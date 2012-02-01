From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:54 +0000
Subject: [lm-sensors] [PATCH 06/24] hwmon: (asb100) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Also only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/asb100.c |   40 +++++++++-------------------------------
 1 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 4b8814d..ff8df62 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -212,7 +212,6 @@ struct asb100_data {
 	u8 pwm;			/* Register encoding */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
-	u8 vrm;
 };
 
 static int asb100_read_value(struct i2c_client *client, u16 reg);
@@ -487,35 +486,12 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-/* VRM */
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct asb100_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct asb100_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	data->vrm = val;
-	return count;
-}
-
 /* Alarms */
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -662,8 +638,6 @@ static struct attribute *asb100_attributes[] = {
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
@@ -816,6 +790,12 @@ static int asb100_probe(struct i2c_client *client,
 	if (err)
 		goto ERROR3;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto ERROR4;
+	}
+
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
@@ -825,6 +805,7 @@ static int asb100_probe(struct i2c_client *client,
 	return 0;
 
 ERROR4:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &asb100_group);
 ERROR3:
 	i2c_unregister_device(data->lm75[1]);
@@ -840,6 +821,7 @@ static int asb100_remove(struct i2c_client *client)
 	struct asb100_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &asb100_group);
 
 	i2c_unregister_device(data->lm75[1]);
@@ -940,10 +922,6 @@ static void asb100_write_value(struct i2c_client *client, u16 reg, u16 value)
 
 static void asb100_init_client(struct i2c_client *client)
 {
-	struct asb100_data *data = i2c_get_clientdata(client);
-
-	data->vrm = vid_which_vrm();
-
 	/* Start monitoring */
 	asb100_write_value(client, ASB100_REG_CONFIG,
 		(asb100_read_value(client, ASB100_REG_CONFIG) & 0xf7) | 0x01);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
