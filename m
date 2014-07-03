From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 01:48:04 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (gl518sm) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404352084.29709.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/gl518sm.c | 76 ++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 0307d82..0212c83 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -114,7 +114,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 /* Each client has this additional data */
 struct gl518_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	enum chips type;
 
 	struct mutex update_lock;
@@ -160,8 +161,8 @@ static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
 
 static struct gl518_data *gl518_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl518_data *data = i2c_get_clientdata(client);
+	struct gl518_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int val;
 
 	mutex_lock(&data->update_lock);
@@ -293,8 +294,8 @@ static ssize_t set_##suffix(struct device *dev,				\
 			    struct device_attribute *attr,		\
 			    const char *buf, size_t count)		\
 {									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct gl518_data *data = i2c_get_clientdata(client);		\
+	struct gl518_data *data = dev_get_drvdata(dev);			\
+	struct i2c_client *client = data->client;			\
 	long val;							\
 	int err = kstrtol(buf, 10, &val);				\
 	if (err)							\
@@ -312,8 +313,8 @@ static ssize_t set_##suffix(struct device *dev,				\
 			    struct device_attribute *attr,		\
 			    const char *buf, size_t count)		\
 {									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct gl518_data *data = i2c_get_clientdata(client);		\
+	struct gl518_data *data = dev_get_drvdata(dev);			\
+	struct i2c_client *client = data->client;			\
 	int regvalue;							\
 	unsigned long val;						\
 	int err = kstrtoul(buf, 10, &val);				\
@@ -351,8 +352,8 @@ set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl518_data *data = i2c_get_clientdata(client);
+	struct gl518_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	int regvalue;
 	unsigned long val;
@@ -384,8 +385,8 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl518_data *data = i2c_get_clientdata(client);
+	struct gl518_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	int regvalue;
 	unsigned long val;
@@ -485,8 +486,8 @@ static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
 static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl518_data *data = i2c_get_clientdata(client);
+	struct gl518_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	unsigned long bit;
 	int err;
@@ -627,15 +628,16 @@ static void gl518_init_client(struct i2c_client *client)
 static int gl518_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct gl518_data *data;
-	int err, revision;
+	int revision;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct gl518_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct gl518_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	revision = gl518_read_value(client, GL518_REG_REVISION);
 	data->type = revision = 0x80 ? gl518sm_r80 : gl518sm_r00;
 	mutex_init(&data->update_lock);
@@ -644,41 +646,14 @@ static int gl518_probe(struct i2c_client *client,
 	data->alarm_mask = 0xff;
 	gl518_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &gl518_group);
-	if (err)
-		return err;
-	if (data->type = gl518sm_r80) {
-		err = sysfs_create_group(&client->dev.kobj, &gl518_group_r80);
-		if (err)
-			goto exit_remove_files;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &gl518_group);
-	if (data->type = gl518sm_r80)
-		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
-	return err;
-}
-
-static int gl518_remove(struct i2c_client *client)
-{
-	struct gl518_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &gl518_group);
+	/* sysfs hooks */
+	data->groups[0] = &gl518_group;
 	if (data->type = gl518sm_r80)
-		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
+		data->groups[1] = &gl518_group_r80;
 
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id gl518_id[] = {
@@ -693,7 +668,6 @@ static struct i2c_driver gl518_driver = {
 		.name	= "gl518sm",
 	},
 	.probe		= gl518_probe,
-	.remove		= gl518_remove,
 	.id_table	= gl518_id,
 	.detect		= gl518_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
