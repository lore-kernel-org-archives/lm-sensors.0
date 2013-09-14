From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 17:13:51 +0000
Subject: [lm-sensors] [PATCH 10/11] hwmon: (ltc4261) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1379178832-1489-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379178832-1489-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1379178832-1489-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Also use new macro ATTRIBUTE_GROUPS to declare attribute groups.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4261.c |   55 ++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index 487da58..6c50db9 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -55,7 +55,7 @@
 #define FAULT_OC	(1<<2)
 
 struct ltc4261_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 
 	struct mutex update_lock;
 	bool valid;
@@ -67,8 +67,8 @@ struct ltc4261_data {
 
 static struct ltc4261_data *ltc4261_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ltc4261_data *data = i2c_get_clientdata(client);
+	struct ltc4261_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct ltc4261_data *ret = data;
 
 	mutex_lock(&data->update_lock);
@@ -150,7 +150,6 @@ static ssize_t ltc4261_show_bool(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct i2c_client *client = to_i2c_client(dev);
 	struct ltc4261_data *data = ltc4261_update_device(dev);
 	u8 fault;
 
@@ -159,7 +158,7 @@ static ssize_t ltc4261_show_bool(struct device *dev,
 
 	fault = data->regs[LTC4261_FAULT] & attr->index;
 	if (fault)		/* Clear reported faults in chip register */
-		i2c_smbus_write_byte_data(client, LTC4261_FAULT, ~fault);
+		i2c_smbus_write_byte_data(data->client, LTC4261_FAULT, ~fault);
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", fault ? 1 : 0);
 }
@@ -197,7 +196,7 @@ static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4261_show_value, NULL,
 static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
 			  FAULT_OC);
 
-static struct attribute *ltc4261_attributes[] = {
+static struct attribute *ltc4261_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
@@ -210,60 +209,39 @@ static struct attribute *ltc4261_attributes[] = {
 
 	NULL,
 };
-
-static const struct attribute_group ltc4261_group = {
-	.attrs = ltc4261_attributes,
-};
+ATTRIBUTE_GROUPS(ltc4261);
 
 static int ltc4261_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
 	struct ltc4261_data *data;
-	int ret;
+	struct device *hwmon_dev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
 	if (i2c_smbus_read_byte_data(client, LTC4261_STATUS) < 0) {
-		dev_err(&client->dev, "Failed to read status register\n");
+		dev_err(dev, "Failed to read status register\n");
 		return -ENODEV;
 	}
 
-	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Clear faults */
 	i2c_smbus_write_byte_data(client, LTC4261_FAULT, 0x00);
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &ltc4261_group);
-	if (ret)
-		return ret;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto out_hwmon_device_register;
-	}
-
-	return 0;
-
-out_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
-	return ret;
-}
-
-static int ltc4261_remove(struct i2c_client *client)
-{
-	struct ltc4261_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   ltc4261_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 	return 0;
 }
@@ -281,7 +259,6 @@ static struct i2c_driver ltc4261_driver = {
 		   .name = "ltc4261",
 		   },
 	.probe = ltc4261_probe,
-	.remove = ltc4261_remove,
 	.id_table = ltc4261_id,
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
