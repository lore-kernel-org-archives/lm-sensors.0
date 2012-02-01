From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:08 +0000
Subject: [lm-sensors] [PATCH 20/24] hwmon: (w83791d) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-21-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Cc: Charles Spirakis <bezaur@gmail.com>
---
 drivers/hwmon/w83791d.c |   48 ++++++++--------------------------------------
 1 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 2f446f9..4165b96 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -328,7 +328,6 @@ struct w83791d_data {
 	u8 beep_enable;		/* Global beep enable */
 	u32 beep_mask;		/* Mask off specific beeps */
 	u8 vid;			/* Register encoding, combined */
-	u8 vrm;			/* hwmon-vid */
 };
 
 static int w83791d_probe(struct i2c_client *client,
@@ -1154,42 +1153,11 @@ static ssize_t show_vid_reg(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct w83791d_data *data = w83791d_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct w83791d_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t store_vrm_reg(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	struct w83791d_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	/*
-	 * No lock needed as vrm is internal to the driver
-	 * (not read from a chip register) and so is not
-	 * updated in w83791d_update_device()
-	 */
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
 #define IN_UNIT_ATTRS(X) \
 	&sda_in_input[X].dev_attr.attr,	\
 	&sda_in_min[X].dev_attr.attr,	\
@@ -1231,8 +1199,6 @@ static struct attribute *w83791d_attributes[] = {
 	&dev_attr_alarms.attr,
 	&sda_beep_ctrl[0].dev_attr.attr,
 	&sda_beep_ctrl[1].dev_attr.attr,
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	&sda_pwm[0].dev_attr.attr,
 	&sda_pwm[1].dev_attr.attr,
 	&sda_pwm[2].dev_attr.attr,
@@ -1412,6 +1378,12 @@ static int w83791d_probe(struct i2c_client *client,
 	if (err)
 		goto error3;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto error4;
+	}
+
 	/* Check if pins of fan/pwm 4-5 are in use as GPIO */
 	has_fanpwm45 = w83791d_read(client, W83791D_REG_GPIO) & 0x10;
 	if (has_fanpwm45) {
@@ -1434,6 +1406,7 @@ error5:
 	if (has_fanpwm45)
 		sysfs_remove_group(&client->dev.kobj, &w83791d_group_fanpwm45);
 error4:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 error3:
 	if (data->lm75[0] != NULL)
@@ -1451,6 +1424,7 @@ static int w83791d_remove(struct i2c_client *client)
 	struct w83791d_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 
 	if (data->lm75[0] != NULL)
@@ -1464,7 +1438,6 @@ static int w83791d_remove(struct i2c_client *client)
 
 static void w83791d_init_client(struct i2c_client *client)
 {
-	struct w83791d_data *data = i2c_get_clientdata(client);
 	u8 tmp;
 	u8 old_beep;
 
@@ -1517,8 +1490,6 @@ static void w83791d_init_client(struct i2c_client *client)
 			w83791d_write(client, W83791D_REG_CONFIG, tmp | 0x01);
 		}
 	}
-
-	data->vrm = vid_which_vrm();
 }
 
 static struct w83791d_data *w83791d_update_device(struct device *dev)
@@ -1693,7 +1664,6 @@ static void w83791d_print_debug(struct w83791d_data *data, struct device *dev)
 	dev_dbg(dev, "beep_mask is: 0x%08x\n", data->beep_mask);
 	dev_dbg(dev, "beep_enable is: %d\n", data->beep_enable);
 	dev_dbg(dev, "vid is: 0x%02x\n", data->vid);
-	dev_dbg(dev, "vrm is: 0x%02x\n", data->vrm);
 	dev_dbg(dev, "====End of w83791d debug values====\n");
 	dev_dbg(dev, "\n");
 }
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
