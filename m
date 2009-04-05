From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 05 Apr 2009 20:01:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95241) Convert to new-style i2c
Message-Id: <20090405220148.57c2855e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The legacy i2c binding model is going away really soon now, so convert
the lm95241 driver to the new binding model or it will break.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Davide Rizzo <elpa-rizzo@gmail.com>
---
Davide, please test this patch and report, or send me a dump of your
chip so that I can test the patch myself (or both.)

 drivers/hwmon/lm95241.c |  121 +++++++++++++++++------------------------------
 1 file changed, 46 insertions(+), 75 deletions(-)

--- linux-2.6.30-rc0.orig/drivers/hwmon/lm95241.c	2009-04-04 15:07:39.000000000 +0200
+++ linux-2.6.30-rc0/drivers/hwmon/lm95241.c	2009-04-05 20:55:19.000000000 +0200
@@ -87,25 +87,11 @@ I2C_CLIENT_INSMOD_1(lm95241);
     (val_h)) * 1000 + (val_l) * 1000 / 256)
 
 /* Functions declaration */
-static int lm95241_attach_adapter(struct i2c_adapter *adapter);
-static int lm95241_detect(struct i2c_adapter *adapter, int address,
-			  int kind);
 static void lm95241_init_client(struct i2c_client *client);
-static int lm95241_detach_client(struct i2c_client *client);
 static struct lm95241_data *lm95241_update_device(struct device *dev);
 
-/* Driver data (common to all clients) */
-static struct i2c_driver lm95241_driver = {
-	.driver = {
-		.name   = "lm95241",
-	},
-	.attach_adapter = lm95241_attach_adapter,
-	.detach_client  = lm95241_detach_client,
-};
-
 /* Client data (each client gets its own) */
 struct lm95241_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	unsigned long last_updated, rate; /* in jiffies */
@@ -323,42 +309,16 @@ static const struct attribute_group lm95
 	.attrs = lm95241_attributes,
 };
 
-/* Init/exit code */
-static int lm95241_attach_adapter(struct i2c_adapter *adapter)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int lm95241_detect(struct i2c_client *new_client, int kind,
+			  struct i2c_board_info *info)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm95241_detect);
-}
-
-/*
- * The following function does more than just detection. If detection
- * succeeds, it also registers the new chip.
- */
-static int lm95241_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *new_client;
-	struct lm95241_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = new_client->adapter;
+	int address = new_client->addr;
 	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	data = kzalloc(sizeof(struct lm95241_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	/* The common I2C client data is placed right before the
-	   LM95241-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm95241_driver;
-	new_client->flags = 0;
+		return -ENODEV;
 
 	/*
 	 * Now we do the remaining detection. A negative kind means that
@@ -370,17 +330,6 @@ static int lm95241_detect(struct i2c_ada
 	 * requested, so both the detection and the identification steps
 	 * are skipped.
 	 */
-	if (kind < 0) {	/* detection */
-		if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
-		     != MANUFACTURER_ID)
-		|| (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
-		    < DEFAULT_REVISION)) {
-			dev_dbg(&adapter->dev,
-				"LM95241 detection failed at 0x%02x.\n",
-				address);
-			goto exit_free;
-		}
-	}
 
 	if (kind <= 0) { /* identification */
 		if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
@@ -392,23 +341,32 @@ static int lm95241_detect(struct i2c_ada
 
 			if (kind <= 0) { /* identification failed */
 				dev_info(&adapter->dev, "Unsupported chip\n");
-				goto exit_free;
+				return -ENODEV;
 			}
 		}
 	}
 
+	/* Fill the i2c board info */
 	if (kind = lm95241)
 		name = "lm95241";
+	strlcpy(info->type, name, I2C_NAME_SIZE);
+	return 0;
+}
 
-	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
-	mutex_init(&data->update_lock);
+static int lm95241_probe(struct i2c_client *new_client,
+			 const struct i2c_device_id *id)
+{
+	struct lm95241_data *data;
+	int err;
 
-	/* Tell the I2C layer a new client has arrived */
-	err = i2c_attach_client(new_client);
-	if (err)
-		goto exit_free;
+	data = kzalloc(sizeof(struct lm95241_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(new_client, data);
+	mutex_init(&data->update_lock);
 
 	/* Initialize the LM95241 chip */
 	lm95241_init_client(new_client);
@@ -416,7 +374,7 @@ static int lm95241_detect(struct i2c_ada
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&new_client->dev.kobj, &lm95241_group);
 	if (err)
-		goto exit_detach;
+		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -428,8 +386,6 @@ static int lm95241_detect(struct i2c_ada
 
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &lm95241_group);
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -456,18 +412,14 @@ static void lm95241_init_client(struct i
 				  data->model);
 }
 
-static int lm95241_detach_client(struct i2c_client *client)
+static int lm95241_remove(struct i2c_client *client)
 {
 	struct lm95241_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm95241_group);
 
-	err = i2c_detach_client(client);
-	if (err)
-		return err;
-
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
@@ -509,6 +461,25 @@ static struct lm95241_data *lm95241_upda
 	return data;
 }
 
+/* Driver data (common to all clients) */
+static const struct i2c_device_id lm95241_id[] = {
+	{ "lm95241", lm95241 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm95241_id);
+
+static struct i2c_driver lm95241_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name   = "lm95241",
+	},
+	.probe		= lm95241_probe,
+	.remove		= lm95241_remove,
+	.id_table	= lm95241_id,
+	.detect		= lm95241_detect,
+	.address_data	= &addr_data,
+};
+
 static int __init sensors_lm95241_init(void)
 {
 	return i2c_add_driver(&lm95241_driver);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
