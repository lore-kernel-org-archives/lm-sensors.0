From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 11:14:17 +0000
Subject: [lm-sensors] PATCH: f71882fg: add missing pwm3 attr for f71862fg
Message-Id: <49463C09.60509@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020807010306030908090907"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807010306030908090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

For some reason the fan_attr array for the f71862fg was missing the attr for
the 3th pwm output. This patch fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

--------------020807010306030908090907
Content-Type: text/plain;
 name="hwmon-f71882fg-14-add-f71862fg-pwm3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-14-add-f71862fg-pwm3.patch"

For some reason the fan_attr array for the f71862fg was missing the attr for
the 3th pwm output. This patch fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.13-applied	2008-12-15 12:06:33.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-15 12:09:22.000000000 +0100
@@ -443,6 +443,28 @@
 		      0, 1),
 	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
+
+	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
 };
 
 /* Fan / PWM attr for the f71882fg */

--------------020807010306030908090907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020807010306030908090907--
