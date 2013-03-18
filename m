From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Mar 2013 01:45:53 +0000
Subject: [lm-sensors] [RFC PATCH 4/8] hwmon: (ltc4261) convert to devm_hwmon_device_register API
Message-Id: <1363571157-16273-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363571157-16273-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1363571157-16273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4261.c |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index 84a2d28..a6da54c 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -67,7 +67,7 @@ struct ltc4261_data {
 
 static struct ltc4261_data *ltc4261_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct ltc4261_data *data = i2c_get_clientdata(client);
 	struct ltc4261_data *ret = data;
 
@@ -150,7 +150,7 @@ static ssize_t ltc4261_show_bool(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct ltc4261_data *data = ltc4261_update_device(dev);
 	u8 fault;
 
@@ -221,12 +221,16 @@ static const struct attribute_group ltc4261_group = {
 	.attrs = ltc4261_attributes,
 };
 
+static const struct attribute_group *ltc4261_groups[] = {
+	&ltc4261_group,
+	NULL
+};
+
 static int ltc4261_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct ltc4261_data *data;
-	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -246,31 +250,16 @@ static int ltc4261_probe(struct i2c_client *client,
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
+	data->hwmon_dev = devm_hwmon_device_register(&client->dev,
+						     ltc4261_groups, id->name);
+	if (IS_ERR(data->hwmon_dev))
+		return PTR_ERR(data->hwmon_dev);
 
 	return 0;
-
-out_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
-	return ret;
 }
 
 static int ltc4261_remove(struct i2c_client *client)
 {
-	struct ltc4261_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
