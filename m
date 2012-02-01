From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:58 +0000
Subject: [lm-sensors] [PATCH 10/24] hwmon: (it87) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-11-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/it87.c |   28 +++-------------------------
 1 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 0b204e4..e8a9ba4 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -259,7 +259,6 @@ struct it87_data {
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
-	u8 vrm;
 	u32 alarms;		/* Register encoding, combined */
 	u8 beeps;		/* Register encoding */
 	u8 fan_main_ctrl;	/* Register value */
@@ -1309,32 +1308,11 @@ static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO, show_beep, NULL, 2);
 
-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct it87_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct it87_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-
-	if (kstrtoul(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	data->vrm = val;
-
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-
 static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
@@ -1593,7 +1571,6 @@ static struct attribute *it87_attributes_fan_beep[] = {
 };
 
 static struct attribute *it87_attributes_vid[] = {
-	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
 	NULL
 };
@@ -1768,6 +1745,8 @@ static int __init it87_find(unsigned short *address,
 			sio_data->skip_pwm = (1 << 1);
 		}
 	}
+	if (!sio_data->skip_vid)
+		sio_data->skip_vid = vid_which_vrm() = 0;
 
 exit:
 	superio_exit();
@@ -1934,7 +1913,6 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	}
 
 	if (!sio_data->skip_vid) {
-		data->vrm = vid_which_vrm();
 		/* VID reading from Super-I/O config space if available */
 		data->vid = sio_data->vid_value;
 		err = sysfs_create_group(&dev->kobj, &it87_group_vid);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
