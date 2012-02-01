From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:57 +0000
Subject: [lm-sensors] [PATCH 09/24] hwmon: (gl520sm) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gl520sm.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 5ff452b..e45f27e 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -113,7 +113,6 @@ struct gl520_data {
 	unsigned long last_updated;	/* in jiffies */
 
 	u8 vid;
-	u8 vrm;
 	u8 in_input[5];		/* [0] = VVD */
 	u8 in_min[5];		/* [0] = VDD */
 	u8 in_max[5];		/* [0] = VDD */
@@ -139,7 +138,7 @@ static ssize_t get_cpu_vid(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct gl520_data *data = gl520_update_device(dev);
-	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, get_cpu_vid, NULL);
 
@@ -669,8 +668,6 @@ static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 7);
 static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 7);
 
 static struct attribute *gl520_attributes[] = {
-	&dev_attr_cpu0_vid.attr,
-
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
@@ -796,6 +793,12 @@ static int gl520_probe(struct i2c_client *client,
 	if (err)
 		goto exit_free;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove_files;
+	}
+
 	if (data->two_temps)
 		err = sysfs_create_group(&client->dev.kobj, &gl520_group_temp2);
 	else
@@ -813,6 +816,7 @@ static int gl520_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove_files:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
@@ -832,7 +836,6 @@ static void gl520_init_client(struct i2c_client *client)
 	conf = oldconf = gl520_read_value(client, GL520_REG_CONF);
 
 	data->alarm_mask = 0xff;
-	data->vrm = vid_which_vrm();
 
 	if (extra_sensor_type = 1)
 		conf &= ~0x10;
@@ -866,6 +869,7 @@ static int gl520_remove(struct i2c_client *client)
 	struct gl520_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
