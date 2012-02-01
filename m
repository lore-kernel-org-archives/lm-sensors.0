From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:59 +0000
Subject: [lm-sensors] [PATCH 11/24] hwmon: (lm85) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm85.c |   43 ++++++++++---------------------------------
 1 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 864c7d9..6fb0889 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -330,7 +330,6 @@ struct lm85_data {
 	u8 temp_ext[3];		/* Decoded values */
 	u8 in_ext[8];		/* Decoded values */
 	u8 vid;			/* Register value */
-	u8 vrm;			/* VRM version */
 	u32 alarms;		/* Register encoding, combined */
 	u8 cfg5;		/* Config Register 5 on ADT7468 */
 	struct lm85_autofan autofan[3];
@@ -424,7 +423,7 @@ show_fan_offset(2);
 show_fan_offset(3);
 show_fan_offset(4);
 
-/* vid, vrm, alarms */
+/* vid, alarms */
 
 static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -434,10 +433,10 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 
 	if (data->has_vid5) {
 		/* 6-pin VID (VRM 10) */
-		vid = vid_from_reg(data->vid & 0x3f, data->vrm);
+		vid = vid_from_reg(data->vid & 0x3f);
 	} else {
 		/* 5-pin VID (VRM 9) */
-		vid = vid_from_reg(data->vid & 0x1f, data->vrm);
+		vid = vid_from_reg(data->vid & 0x1f);
 	}
 
 	return sprintf(buf, "%d\n", vid);
@@ -445,30 +444,6 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct lm85_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-
-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct lm85_data *data = dev_get_drvdata(dev);
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
-
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-
 static ssize_t show_alarms_reg(struct device *dev, struct device_attribute
 		*attr, char *buf)
 {
@@ -1174,8 +1149,6 @@ static struct attribute *lm85_attributes[] = {
 	&sensor_dev_attr_temp2_auto_temp_crit.dev_attr.attr,
 	&sensor_dev_attr_temp3_auto_temp_crit.dev_attr.attr,
 
-	&dev_attr_vrm.attr,
-	&dev_attr_cpu0_vid.attr,
 	&dev_attr_alarms.attr,
 	NULL
 };
@@ -1370,6 +1343,7 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 
 static void lm85_remove_files(struct i2c_client *client, struct lm85_data *data)
 {
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &lm85_group);
 	if (data->type != emc6d103s) {
 		sysfs_remove_group(&client->dev.kobj, &lm85_group_minctl);
@@ -1410,9 +1384,6 @@ static int lm85_probe(struct i2c_client *client,
 		data->freq_map = lm85_freq_map;
 	}
 
-	/* Set the VRM version */
-	data->vrm = vid_which_vrm();
-
 	/* Initialize the LM85 chip */
 	lm85_init_client(client);
 
@@ -1421,6 +1392,12 @@ static int lm85_probe(struct i2c_client *client,
 	if (err)
 		goto err_kfree;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto err_remove_files;
+	}
+
 	/* minctl and temp_off exist on all chips except emc6d103s */
 	if (data->type != emc6d103s) {
 		err = sysfs_create_group(&client->dev.kobj, &lm85_group_minctl);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
