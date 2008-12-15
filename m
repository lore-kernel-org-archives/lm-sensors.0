From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 12:38:05 +0000
Subject: [lm-sensors] PATCH: f71882fg: Fix auto_channels_temp temp numbering
Message-Id: <49464FAD.3030606@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060101030402040004080303"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101030402040004080303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

Adjust auto_channels_temp show and store functions for different numbering of
temps between f8000 and other supported models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

--------------060101030402040004080303
Content-Type: text/plain;
	name="hwmon-f71882fg-15-fix-f8000-auto_channels_temp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="hwmon-f71882fg-15-fix-f8000-auto_channels_temp.patch"

Adjust auto_channels_temp show and store functions for different numbering of
temps between f8000 and other supported models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.14-applied	2008-12-15 13:29:42.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-15 13:33:52.000000000 +0100
@@ -1610,8 +1610,9 @@
 	int result;
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int temp_start = (data->type == f8000) ? 0 : 1;
 
-	result = 1 << ((data->pwm_auto_point_mapping[nr] & 3) - 1);
+	result = 1 << ((data->pwm_auto_point_mapping[nr] & 3) - temp_start);
 
 	return sprintf(buf, "%d\n", result);
 }
@@ -1622,20 +1623,23 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int temp_start = (data->type == f8000) ? 0 : 1;
 	long val = simple_strtol(buf, NULL, 10);
+
 	switch (val) {
 	case 1:
-		val = 1;
+		val = 0;
 		break;
 	case 2:
-		val = 2;
+		val = 1;
 		break;
 	case 4:
-		val = 3;
+		val = 2;
 		break;
 	default:
 		return -EINVAL;
 	}
+	val += temp_start;
 	mutex_lock(&data->update_lock);
 	data->pwm_auto_point_mapping[nr] =
 		f71882fg_read8(data, F71882FG_REG_POINT_MAPPING(nr));

--------------060101030402040004080303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060101030402040004080303--
