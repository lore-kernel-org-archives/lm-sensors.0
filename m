From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jan 2008 14:35:09 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm80) Various cleanups
Message-Id: <20080105153509.5864840d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Drop trailing whitespace
* Fold a long line
* Rename new_client to client
* Drop redundant initializations to 0
* Drop bogus comment

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Tested using i2c-stub.

 drivers/hwmon/lm80.c |   49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/lm80.c	2008-01-05 15:02:21.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm80.c	2008-01-05 15:16:33.000000000 +0100
@@ -127,7 +127,7 @@ struct lm80_data {
 	u16 alarms;		/* Register encoding, combined */
 };
 
-/* 
+/*
  * Functions declaration
  */
 
@@ -336,7 +336,8 @@ set_temp(hot_hyst, temp_hot_hyst, LM80_R
 set_temp(os_max, temp_os_max, LM80_REG_TEMP_OS_MAX);
 set_temp(os_hyst, temp_os_hyst, LM80_REG_TEMP_OS_HYST);
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -438,7 +439,7 @@ static const struct attribute_group lm80
 static int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur;
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct lm80_data *data;
 	int err = 0;
 	const char *name;
@@ -454,21 +455,20 @@ static int lm80_detect(struct i2c_adapte
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm80_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &lm80_driver;
 
 	/* Now, we do the remaining detection. It is lousy. */
-	if (lm80_read_value(new_client, LM80_REG_ALARM2) & 0xc0)
+	if (lm80_read_value(client, LM80_REG_ALARM2) & 0xc0)
 		goto error_free;
 	for (i = 0x2a; i <= 0x3d; i++) {
-		cur = i2c_smbus_read_byte_data(new_client, i);
-		if ((i2c_smbus_read_byte_data(new_client, i + 0x40) != cur)
-		 || (i2c_smbus_read_byte_data(new_client, i + 0x80) != cur)
-		 || (i2c_smbus_read_byte_data(new_client, i + 0xc0) != cur))
+		cur = i2c_smbus_read_byte_data(client, i);
+		if ((i2c_smbus_read_byte_data(client, i + 0x40) != cur)
+		 || (i2c_smbus_read_byte_data(client, i + 0x80) != cur)
+		 || (i2c_smbus_read_byte_data(client, i + 0xc0) != cur))
 		    goto error_free;
 	}
 
@@ -476,27 +476,26 @@ static int lm80_detect(struct i2c_adapte
 	kind = lm80;
 	name = "lm80";
 
-	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
+	/* Fill in the remaining client fields */
+	strlcpy(client->name, name, I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto error_free;
 
 	/* Initialize the LM80 chip */
-	lm80_init_client(new_client);
+	lm80_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	data->fan_min[0] = lm80_read_value(new_client, LM80_REG_FAN_MIN(1));
-	data->fan_min[1] = lm80_read_value(new_client, LM80_REG_FAN_MIN(2));
+	data->fan_min[0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+	data->fan_min[1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm80_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &lm80_group)))
 		goto error_detach;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto error_remove;
@@ -505,9 +504,9 @@ static int lm80_detect(struct i2c_adapte
 	return 0;
 
 error_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm80_group);
+	sysfs_remove_group(&client->dev.kobj, &lm80_group);
 error_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 error_free:
 	kfree(data);
 exit:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
