From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 14:41:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm87) Convert to a new-style i2c driver
Message-Id: <20080716164128.46f6766e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>

The new-style lm87 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |   99 +++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 53 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/lm87.c	2008-07-12 09:20:29.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/lm87.c	2008-07-12 10:27:17.000000000 +0200
@@ -5,7 +5,7 @@
  *                          Philip Edelbrock <phil@netroedge.com>
  *                          Stephen Rousset <stephen.rousset@rocketlogix.com>
  *                          Dan Eaton <dan.eaton@rocketlogix.com>
- * Copyright (C) 2004,2007  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2004-2008  Jean Delvare <khali@linux-fr.org>
  *
  * Original port to Linux 2.6 by Jeff Oliver.
  *
@@ -157,22 +157,35 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A,
  * Functions declaration
  */
 
-static int lm87_attach_adapter(struct i2c_adapter *adapter);
-static int lm87_detect(struct i2c_adapter *adapter, int address, int kind);
+static int lm87_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id);
+static int lm87_detect(struct i2c_client *new_client, int kind,
+		       struct i2c_board_info *info);
 static void lm87_init_client(struct i2c_client *client);
-static int lm87_detach_client(struct i2c_client *client);
+static int lm87_remove(struct i2c_client *client);
 static struct lm87_data *lm87_update_device(struct device *dev);
 
 /*
  * Driver data (common to all clients)
  */
 
+static const struct i2c_device_id lm87_id[] = {
+	{ "lm87", lm87 },
+	{ "adm1024", adm1024 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm87_id);
+
 static struct i2c_driver lm87_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm87",
 	},
-	.attach_adapter	= lm87_attach_adapter,
-	.detach_client	= lm87_detach_client,
+	.probe		= lm87_probe,
+	.remove		= lm87_remove,
+	.id_table	= lm87_id,
+	.detect		= lm87_detect,
+	.address_data	= &addr_data,
 };
 
 /*
@@ -180,7 +193,6 @@ static struct i2c_driver lm87_driver = {
  */
 
 struct lm87_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
@@ -562,13 +574,6 @@ static SENSOR_DEVICE_ATTR(temp3_fault, S
  * Real code
  */
 
-static int lm87_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm87_detect);
-}
-
 static struct attribute *lm87_attributes[] = {
 	&dev_attr_in1_input.attr,
 	&dev_attr_in1_min.attr,
@@ -656,33 +661,15 @@ static const struct attribute_group lm87
 	.attrs = lm87_attributes_opt,
 };
 
-/*
- * The following function does more than just detection. If detection
- * succeeds, it also registers the new chip.
- */
-static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int lm87_detect(struct i2c_client *new_client, int kind,
+		       struct i2c_board_info *info)
 {
-	struct i2c_client *new_client;
-	struct lm87_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = new_client->adapter;
 	static const char *names[] = { "lm87", "adm1024" };
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	/* The common I2C client data is placed right before the
-	   LM87-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm87_driver;
-	new_client->flags = 0;
+		return -ENODEV;
 
 	/* Default to an LM87 if forced */
 	if (kind = 0)
@@ -704,20 +691,32 @@ static int lm87_detect(struct i2c_adapte
 		 || (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)) {
 			dev_dbg(&adapter->dev,
 				"LM87 detection failed at 0x%02x.\n",
-				address);
-			goto exit_free;
+				new_client->addr);
+			return -ENODEV;
 		}
 	}
 
-	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, names[kind - 1], I2C_NAME_SIZE);
+	strlcpy(info->type, names[kind - 1], I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int lm87_probe(struct i2c_client *new_client,
+		      const struct i2c_device_id *id)
+{
+	struct lm87_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(new_client, data);
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_free;
-
 	/* Initialize the LM87 chip */
 	lm87_init_client(new_client);
 
@@ -732,7 +731,7 @@ static int lm87_detect(struct i2c_adapte
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm87_group)))
-		goto exit_detach;
+		goto exit_free;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
 		if ((err = device_create_file(&new_client->dev,
@@ -832,8 +831,6 @@ static int lm87_detect(struct i2c_adapte
 exit_remove:
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -877,18 +874,14 @@ static void lm87_init_client(struct i2c_
 	}
 }
 
-static int lm87_detach_client(struct i2c_client *client)
+static int lm87_remove(struct i2c_client *client)
 {
 	struct lm87_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
