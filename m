From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:01 +0000
Subject: [lm-sensors] [PATCH 13/24] hwmon: (pc87360) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-14-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/pc87360.c |   35 ++++++++---------------------------
 1 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 79ba48c..5e78fa6 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -212,7 +212,6 @@ struct pc87360_data {
 	u8 in_status[14];	/* Register value */
 	u16 in_alarms;		/* Register values, combined, masked */
 	u8 vid_conf;		/* Configuration register value */
-	u8 vrm;
 	u8 vid;			/* Register value */
 
 	s8 temp[3];		/* Register value */
@@ -594,32 +593,10 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	struct pc87360_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
-{
-	struct pc87360_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-
-	data->vrm = val;
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
 static ssize_t show_in_alarms(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -640,8 +617,6 @@ static struct attribute *pc8736x_vin_attr_array[] = {
 	VIN_UNIT_ATTRS(8),
 	VIN_UNIT_ATTRS(9),
 	VIN_UNIT_ATTRS(10),
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	&dev_attr_alarms_in.attr,
 	NULL
 };
@@ -1218,6 +1193,7 @@ static void pc87360_remove_files(struct device *dev)
 		device_remove_file(dev, &pwm[i].dev_attr);
 	}
 	sysfs_remove_group(&dev->kobj, &pc8736x_therm_group);
+	device_remove_file(dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&dev->kobj, &pc8736x_vin_group);
 }
 
@@ -1302,7 +1278,6 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 			(i&0x02) ? "external" : "internal");
 
 		data->vid_conf = confreg[3];
-		data->vrm = vid_which_vrm();
 	}
 
 	/* Fan clock dividers may be needed before any data is read */
@@ -1328,6 +1303,12 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 			goto ERROR3;
 	}
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto ERROR3;
+	}
+
 	if (data->innr = 14) {
 		err = sysfs_create_group(&dev->kobj, &pc8736x_therm_group);
 		if (err)
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
