From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:51 +0000
Subject: [lm-sensors] [PATCH 03/24] hwmon: (adm1026) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1026.c |   41 ++++++++++-------------------------------
 1 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 1003219..7f42125 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -286,7 +286,6 @@ struct adm1026_data {
 	u8 fan_min[8];		/* Register value */
 	u8 fan_div[8];		/* Decoded value */
 	struct pwm_data pwm1;	/* Pwm control values */
-	u8 vrm;			/* VRM version */
 	u8 analog_out;		/* Register value (DAC) */
 	long alarms;		/* Register encoding, combined */
 	long alarm_mask;	/* Register encoding, combined */
@@ -1294,35 +1293,11 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 	int vid = (data->gpio >> 11) & 0x1f;
 
 	dev_dbg(dev, "Setting VID from GPIO11-15.\n");
-	return sprintf(buf, "%d\n", vid_from_reg(vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(vid));
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct adm1026_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
-{
-	struct adm1026_data *data = dev_get_drvdata(dev);
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
 static ssize_t show_alarms_reg(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -1720,8 +1695,6 @@ static struct attribute *adm1026_attributes[] = {
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&dev_attr_temp1_crit_enable.attr,
 	&dev_attr_temp2_crit_enable.attr,
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_alarm_mask.attr,
 	&dev_attr_gpio.attr,
@@ -1843,9 +1816,6 @@ static int adm1026_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	/* Set the VRM version */
-	data->vrm = vid_which_vrm();
-
 	/* Initialize the ADM1026 chip */
 	adm1026_init_client(client);
 
@@ -1853,6 +1823,13 @@ static int adm1026_probe(struct i2c_client *client,
 	err = sysfs_create_group(&client->dev.kobj, &adm1026_group);
 	if (err)
 		goto exitfree;
+
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exitremove;
+	}
+
 	if (data->config1 & CFG1_AIN8_9)
 		err = sysfs_create_group(&client->dev.kobj,
 					 &adm1026_group_in8_9);
@@ -1872,6 +1849,7 @@ static int adm1026_probe(struct i2c_client *client,
 
 	/* Error out and cleanup code */
 exitremove:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
 	if (data->config1 & CFG1_AIN8_9)
 		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
@@ -1887,6 +1865,7 @@ static int adm1026_remove(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
 	if (data->config1 & CFG1_AIN8_9)
 		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
