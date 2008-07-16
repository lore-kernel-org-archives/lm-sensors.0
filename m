From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 15:33:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: (thmc50) Convert to a new-style i2c
Message-Id: <20080716173316.1e8c5c42@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

The new-style thmc50 driver implements the optional detect()
callback to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/hwmon/thmc50.c |  107 +++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/thmc50.c	2008-07-12 09:20:29.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/thmc50.c	2008-07-12 10:27:12.000000000 +0200
@@ -60,7 +60,6 @@ static const u8 THMC50_REG_TEMP_MAX[] = 
 
 /* Each client has this additional data */
 struct thmc50_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 
 	struct mutex update_lock;
@@ -77,17 +76,31 @@ struct thmc50_data {
 	u8 alarms;
 };
 
-static int thmc50_attach_adapter(struct i2c_adapter *adapter);
-static int thmc50_detach_client(struct i2c_client *client);
+static int thmc50_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info);
+static int thmc50_probe(struct i2c_client *client,
+			const struct i2c_device_id *id);
+static int thmc50_remove(struct i2c_client *client);
 static void thmc50_init_client(struct i2c_client *client);
 static struct thmc50_data *thmc50_update_device(struct device *dev);
 
+static const struct i2c_device_id thmc50_id[] = {
+	{ "adm1022", adm1022 },
+	{ "thmc50", thmc50 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, thmc50_id);
+
 static struct i2c_driver thmc50_driver = {
+	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = "thmc50",
 	},
-	.attach_adapter = thmc50_attach_adapter,
-	.detach_client = thmc50_detach_client,
+	.probe = thmc50_probe,
+	.remove = thmc50_remove,
+	.id_table = thmc50_id,
+	.detect = thmc50_detect,
+	.address_data = &addr_data,
 };
 
 static ssize_t show_analog_out(struct device *dev,
@@ -250,39 +263,23 @@ static const struct attribute_group temp
 	.attrs = temp3_attributes,
 };
 
-static int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int thmc50_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info)
 {
 	unsigned company;
 	unsigned revision;
 	unsigned config;
-	struct i2c_client *client;
-	struct thmc50_data *data;
-	struct device *dev;
+	struct i2c_adapter *adapter = client->adapter;
 	int err = 0;
 	const char *type_name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		pr_debug("thmc50: detect failed, "
 			 "smbus byte data not supported!\n");
-		goto exit;
-	}
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access thmc50 registers. */
-	if (!(data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL))) {
-		pr_debug("thmc50: detect failed, kzalloc failed!\n");
-		err = -ENOMEM;
-		goto exit;
+		return -ENODEV;
 	}
 
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &thmc50_driver;
-	dev = &client->dev;
-
 	pr_debug("thmc50: Probing for THMC50 at 0x%2X on bus %d\n",
 		 client->addr, i2c_adapter_id(client->adapter));
 
@@ -307,21 +304,22 @@ static int thmc50_detect(struct i2c_adap
 	}
 	if (err = -ENODEV) {
 		pr_debug("thmc50: Detection of THMC50/ADM1022 failed\n");
-		goto exit_free;
+		return err;
 	}
-	data->type = kind;
 
 	if (kind = adm1022) {
 		int id = i2c_adapter_id(client->adapter);
 		int i;
 
 		type_name = "adm1022";
-		data->has_temp3 = (config >> 7) & 1;	/* config MSB */
 		for (i = 0; i + 1 < adm1022_temp3_num; i += 2)
 			if (adm1022_temp3[i] = id &&
-			    adm1022_temp3[i + 1] = address) {
+			    adm1022_temp3[i + 1] = client->addr) {
 				/* enable 2nd remote temp */
-				data->has_temp3 = 1;
+				config |= (1 << 7);
+				i2c_smbus_write_byte_data(client,
+							  THMC50_REG_CONF,
+							  config);
 				break;
 			}
 	} else {
@@ -330,19 +328,33 @@ static int thmc50_detect(struct i2c_adap
 	pr_debug("thmc50: Detected %s (version %x, revision %x)\n",
 		 type_name, (revision >> 4) - 0xc, revision & 0xf);
 
-	/* Fill in the remaining client fields & put it into the global list */
-	strlcpy(client->name, type_name, I2C_NAME_SIZE);
-	mutex_init(&data->update_lock);
+	strlcpy(info->type, type_name, I2C_NAME_SIZE);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
+	return 0;
+}
+
+static int thmc50_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct thmc50_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL);
+	if (!data) {
+		pr_debug("thmc50: detect failed, kzalloc failed!\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	data->type = id->driver_data;
+	mutex_init(&data->update_lock);
 
 	thmc50_init_client(client);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &thmc50_group)))
-		goto exit_detach;
+		goto exit_free;
 
 	/* Register ADM1022 sysfs hooks */
 	if (data->has_temp3)
@@ -364,34 +376,21 @@ exit_remove_sysfs:
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 exit_remove_sysfs_thmc50:
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int thmc50_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, thmc50_detect);
-}
-
-static int thmc50_detach_client(struct i2c_client *client)
+static int thmc50_remove(struct i2c_client *client)
 {
 	struct thmc50_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
 	if (data->has_temp3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
 
 	return 0;
@@ -412,8 +411,8 @@ static void thmc50_init_client(struct i2
 	}
 	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
 	config |= 0x1;	/* start the chip if it is in standby mode */
-	if (data->has_temp3)
-		config |= 0x80;		/* enable 2nd remote temp */
+	if (data->type = adm1022 && (config & (1 << 7)))
+		data->has_temp3 = 1;
 	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
