From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:07 +0000
Subject: [lm-sensors] [PATCH 19/24] hwmon: (w83781d) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-20-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83781d.c |   39 ++++++++-------------------------------
 1 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index b03d54a..7df88ee 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -245,7 +245,6 @@ struct w83781d_data {
 				 * 1 = pentium diode; 2 = 3904 diode;
 				 * 4 = thermistor
 				 */
-	u8 vrm;
 };
 
 static struct w83781d_data *w83781d_data_if_isa(void);
@@ -420,37 +419,12 @@ static ssize_t
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid));
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t
-show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w83781d_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-
-static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr,
-	      const char *buf, size_t count)
-{
-	struct w83781d_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	data->vrm = SENSORS_LIMIT(val, 0, 255);
-
-	return count;
-}
-
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-
-static ssize_t
 show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -964,8 +938,6 @@ static struct attribute *w83781d_attributes[] = {
 	FAN_UNIT_ATTRS(3),
 	TEMP_UNIT_ATTRS(1),
 	TEMP_UNIT_ATTRS(2),
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_beep_mask.attr,
 	&sensor_dev_attr_beep_enable.dev_attr.attr,
@@ -1039,6 +1011,12 @@ w83781d_create_files(struct device *dev, int kind, int is_isa)
 	if (err)
 		return err;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(dev, &dev_attr_cpu0_vid);
+		if (err)
+			return err;
+	}
+
 	if (kind != w83783s) {
 		err = sysfs_create_group(&dev->kobj, &w83781d_group_in1);
 		if (err)
@@ -1197,6 +1175,7 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 
 static void w83781d_remove_files(struct device *dev)
 {
+	device_remove_file(dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&dev->kobj, &w83781d_group);
 	sysfs_remove_group(&dev->kobj, &w83781d_group_in1);
 	sysfs_remove_group(&dev->kobj, &w83781d_group_in78);
@@ -1409,8 +1388,6 @@ w83781d_init_device(struct device *dev)
 		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
 	}
 
-	data->vrm = vid_which_vrm();
-
 	if ((type != w83781d) && (type != as99127f)) {
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		for (i = 1; i <= 3; i++) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
