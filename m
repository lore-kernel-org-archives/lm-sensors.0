From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 01:50:13 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (gl520sm) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404352213.29709.5.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/gl520sm.c | 96 ++++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 61 deletions(-)

diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 86c08a1..dee93ec 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -75,7 +75,8 @@ static const u8 GL520_REG_TEMP_MAX_HYST[]	= { 0x06, 0x18 };
 
 /* Client data */
 struct gl520_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
@@ -121,8 +122,8 @@ static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value)
 
 static struct gl520_data *gl520_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int val, i;
 
 	mutex_lock(&data->update_lock);
@@ -255,8 +256,8 @@ static ssize_t get_in_max(struct device *dev, struct device_attribute *attr,
 static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int n = to_sensor_dev_attr(attr)->index;
 	u8 r;
 	long v;
@@ -289,8 +290,8 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int n = to_sensor_dev_attr(attr)->index;
 	u8 r;
 	long v;
@@ -390,8 +391,8 @@ static ssize_t get_fan_off(struct device *dev, struct device_attribute *attr,
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int n = to_sensor_dev_attr(attr)->index;
 	u8 r;
 	unsigned long v;
@@ -429,8 +430,8 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int n = to_sensor_dev_attr(attr)->index;
 	u8 r;
 	unsigned long v;
@@ -478,8 +479,8 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 static ssize_t set_fan_off(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 r;
 	unsigned long v;
 	int err;
@@ -546,8 +547,8 @@ static ssize_t get_temp_max_hyst(struct device *dev,
 static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int n = to_sensor_dev_attr(attr)->index;
 	long v;
 	int err;
@@ -566,8 +567,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 static ssize_t set_temp_max_hyst(struct device *dev, struct device_attribute
 				 *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int n = to_sensor_dev_attr(attr)->index;
 	long v;
 	int err;
@@ -619,8 +620,8 @@ static ssize_t get_beep_mask(struct device *dev, struct device_attribute *attr,
 static ssize_t set_beep_enable(struct device *dev, struct device_attribute
 			       *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 r;
 	unsigned long v;
 	int err;
@@ -643,8 +644,8 @@ static ssize_t set_beep_enable(struct device *dev, struct device_attribute
 static ssize_t set_beep_mask(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long r;
 	int err;
 
@@ -697,8 +698,8 @@ static ssize_t get_beep(struct device *dev, struct device_attribute *attr,
 static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
+	struct gl520_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	unsigned long bit;
 
@@ -877,58 +878,32 @@ static void gl520_init_client(struct i2c_client *client)
 static int gl520_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct gl520_data *data;
-	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct gl520_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct gl520_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	data->client = client;
 
 	/* Initialize the GL520SM chip */
 	gl520_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &gl520_group);
-	if (err)
-		return err;
+	/* sysfs hooks */
+	data->groups[0] = &gl520_group;
 
 	if (data->two_temps)
-		err = sysfs_create_group(&client->dev.kobj, &gl520_group_temp2);
+		data->groups[1] = &gl520_group_temp2;
 	else
-		err = sysfs_create_group(&client->dev.kobj, &gl520_group_in4);
-
-	if (err)
-		goto exit_remove_files;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
+		data->groups[1] = &gl520_group_in4;
 
-exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &gl520_group);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
-	return err;
-}
-
-static int gl520_remove(struct i2c_client *client)
-{
-	struct gl520_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id gl520_id[] = {
@@ -943,7 +918,6 @@ static struct i2c_driver gl520_driver = {
 		.name	= "gl520sm",
 	},
 	.probe		= gl520_probe,
-	.remove		= gl520_remove,
 	.id_table	= gl520_id,
 	.detect		= gl520_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
