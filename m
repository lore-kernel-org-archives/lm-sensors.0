From: Ben Hutchings <bhutchings@solarflare.com>
Date: Thu, 10 Jul 2008 15:00:02 +0000
Subject: [lm-sensors] [PATCH 3/3] lm90: Converted into a new-style driver
Message-Id: <20080710150001.GC19302@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Renamed the legacy driver to lm90_legacy, implemented using the new-style
driver (untested).

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm90.c |  175 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 112 insertions(+), 63 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index dbf0dfe..5849ac1 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -90,13 +90,6 @@ static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680,
-		    max6646);
-
-/*
  * The LM90 registers
  */
 
@@ -148,6 +141,8 @@ I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680,
  * Functions declaration
  */
 
+static int lm90_probe(struct i2c_client *client, const struct i2c_device_id *);
+static int lm90_remove(struct i2c_client *client);
 static int lm90_attach_adapter(struct i2c_adapter *adapter);
 static int lm90_detect(struct i2c_adapter *adapter, int address,
 	int kind);
@@ -159,10 +154,46 @@ static struct lm90_data *lm90_update_device(struct device *dev);
  * Driver data (common to all clients)
  */
 
+/*
+ * Device types, selectable by module parameter.
+ * The order of names here must match the id table below.
+ */
+I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680,
+		    max6646);
+
+static const struct i2c_device_id lm90_id[] = {
+	{ "lm90",	lm90 },
+	{ "adm1032",	adm1032 },
+	{ "lm99",	lm99 },
+	{ "lm86",	lm86 },
+	{ "max6657",	max6657 },
+	{ "adt7461",	adt7461 },
+	{ "max6680",	max6680 },
+	{ "max6646",	max6646 },
+	/* Aliases can appear in any order */
+	{ "lm89",	lm99 },
+	{ "max6647",	max6646 },
+	{ "max6649",	max6646 },
+	{ "max6658",	max6657 },
+	{ "max6659",	max6657 },
+	{ "max6681",	max6680 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm90_id);
+
 static struct i2c_driver lm90_driver = {
 	.driver = {
 		.name	= "lm90",
 	},
+	.probe		= lm90_probe,
+	.remove		= lm90_remove,
+	.id_table	= lm90_id,
+};
+
+static struct i2c_driver lm90_legacy_driver = {
+	.driver = {
+		.name	= "lm90_legacy",
+	},
 	.attach_adapter	= lm90_attach_adapter,
 	.detach_client	= lm90_detach_client,
 };
@@ -172,7 +203,6 @@ static struct i2c_driver lm90_driver = {
  */
 
 struct lm90_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
@@ -614,25 +644,17 @@ static int lm90_attach_adapter(struct i2c_adapter *adapter)
 static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
-	struct lm90_data *data;
 	int err = 0;
-	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
+		return 0;
 
-	/* The common I2C client data is placed right before the
-	   LM90-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
+	if (!new_client)
+		return -ENOMEM;
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm90_driver;
+	new_client->driver = &lm90_legacy_driver;
 	new_client->flags = 0;
 
 	/*
@@ -698,9 +720,6 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 			 && (reg_config1 & 0x1B) = 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adt7461;
-				/* Check Temperature Range Select */
-				if (reg_config1 & 0x04)
-					data->flags |= LM90_FLAG_ADT7461_EXT;
 			}
 		} else
 		if (man_id = 0x4D) { /* Maxim */
@@ -742,44 +761,57 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 		}
 	}
 
-	if (kind = lm90) {
-		name = "lm90";
-	} else if (kind = adm1032) {
-		name = "adm1032";
-		/* The ADM1032 supports PEC, but only if combined
-		   transactions are not used. */
-		if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-			new_client->flags |= I2C_CLIENT_PEC;
-	} else if (kind = lm99) {
-		name = "lm99";
-	} else if (kind = lm86) {
-		name = "lm86";
-	} else if (kind = max6657) {
-		name = "max6657";
-	} else if (kind = max6680) {
-		name = "max6680";
-	} else if (kind = adt7461) {
-		name = "adt7461";
-	} else if (kind = max6646) {
-		name = "max6646";
-	}
+	/* The ADM1032 supports PEC, but only if combined
+	   transactions are not used. */
+	if (kind = adm1032
+	    && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		new_client->flags |= I2C_CLIENT_PEC;
 
-	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
-	data->kind = kind;
-	mutex_init(&data->update_lock);
+	strlcpy(new_client->name, lm90_id[kind - 1].name, I2C_NAME_SIZE);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	err = lm90_probe(new_client, lm90_id + kind - 1);
+	if (err)
 		goto exit_free;
 
+	/* Tell the I2C layer a new client has arrived */
+	err = i2c_attach_client(new_client);
+	if (err)
+		goto exit_remove;
+
+	return 0;
+
+exit_remove:
+	lm90_remove(new_client);
+exit_free:
+	kfree(new_client);
+	return err;
+}
+
+static int
+lm90_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
+{
+	struct lm90_data *data;
+	int err;
+
+	if (!i2c_check_functionality(new_client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->valid = 0;
+	data->kind = id ? id->driver_data : lm90;
+	mutex_init(&data->update_lock);
+	i2c_set_clientdata(new_client, data);
+
 	/* Initialize the LM90 chip */
 	lm90_init_client(new_client);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm90_group)))
-		goto exit_detach;
+		goto exit_free;
 	if (new_client->flags & I2C_CLIENT_PEC) {
 		if ((err = device_create_file(&new_client->dev,
 					      &dev_attr_pec)))
@@ -802,11 +834,9 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &lm90_group);
 	device_remove_file(&new_client->dev, &dev_attr_pec);
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
-exit:
+	i2c_set_clientdata(new_client, NULL);
 	return err;
 }
 
@@ -826,6 +856,10 @@ static void lm90_init_client(struct i2c_client *client)
 	}
 	config_orig = config;
 
+	/* Check Temperature Range Select on ADT7461 */
+	if (data->kind = adt7461 && config & 0x04)
+		data->flags |= LM90_FLAG_ADT7461_EXT;
+
 	/*
 	 * Put MAX6680/MAX8881 into extended resolution (bit 0x10,
 	 * 0.125 degree resolution) and range (0x08, extend range
@@ -840,10 +874,9 @@ static void lm90_init_client(struct i2c_client *client)
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
 }
 
-static int lm90_detach_client(struct i2c_client *client)
+static int lm90_remove(struct i2c_client *client)
 {
 	struct lm90_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm90_group);
@@ -852,13 +885,21 @@ static int lm90_detach_client(struct i2c_client *client)
 		device_remove_file(&client->dev,
 				   &sensor_dev_attr_temp2_offset.dev_attr);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	kfree(data);
+	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
+static int lm90_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	lm90_remove(client);
+	err = i2c_detach_client(client);
+	if (!err)
+		kfree(client);
+	return err;
+}
+
 static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
 {
 	int err;
@@ -957,11 +998,19 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 
 static int __init sensors_lm90_init(void)
 {
-	return i2c_add_driver(&lm90_driver);
+	int err;
+	err = i2c_add_driver(&lm90_driver);
+	if (err)
+		return err;
+	err = i2c_add_driver(&lm90_legacy_driver);
+	if (err)
+		i2c_del_driver(&lm90_driver);
+	return err;
 }
 
 static void __exit sensors_lm90_exit(void)
 {
+	i2c_del_driver(&lm90_legacy_driver);
 	i2c_del_driver(&lm90_driver);
 }
 
-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
