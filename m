From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:53 +0000
Subject: [lm-sensors] [PATCH 05/24] hwmon: (adt7475) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adt7475.c |   31 +++----------------------------
 1 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index df29d13..bc27380 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -185,7 +185,6 @@ struct adt7475_data {
 	u8 pwmchan[3];
 
 	u8 vid;
-	u8 vrm;
 };
 
 static struct i2c_driver adt7475_driver;
@@ -887,33 +886,11 @@ static ssize_t set_pwm_at_crit(struct device *dev,
 	return count;
 }
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *devattr,
-			char *buf)
-{
-	struct adt7475_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", (int)data->vrm);
-}
-
-static ssize_t set_vrm(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
-{
-	struct adt7475_data *data = dev_get_drvdata(dev);
-	long val;
-
-	if (kstrtol(buf, 10, &val))
-		return -EINVAL;
-	if (val < 0 || val > 255)
-		return -EINVAL;
-	data->vrm = val;
-
-	return count;
-}
-
 static ssize_t show_vid(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 
 static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
@@ -1059,7 +1036,6 @@ static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
 static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
 		   show_pwm_at_crit, set_pwm_at_crit);
 
-static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, set_vrm);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static struct attribute *adt7475_attrs[] = {
@@ -1176,7 +1152,6 @@ static struct attribute *in5_attrs[] = {
 
 static struct attribute *vid_attrs[] = {
 	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	NULL
 };
 
@@ -1322,7 +1297,8 @@ static int adt7475_probe(struct i2c_client *client,
 		if (!(vid & VID_VIDSEL))
 			data->has_voltage |= (1 << 4);		/* in4 */
 
-		data->has_vid = !(adt7475_read(REG_CONFIG5) & CONFIG5_VIDGPIO);
+		data->has_vid = !(adt7475_read(REG_CONFIG5) & CONFIG5_VIDGPIO)
+				&& vid_which_vrm() > 0;
 	}
 
 	/* Voltage attenuators can be bypassed, globally or individually */
@@ -1378,7 +1354,6 @@ static int adt7475_probe(struct i2c_client *client,
 			goto eremove;
 	}
 	if (data->has_vid) {
-		data->vrm = vid_which_vrm();
 		ret = sysfs_create_group(&client->dev.kobj, &vid_attr_group);
 		if (ret)
 			goto eremove;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
