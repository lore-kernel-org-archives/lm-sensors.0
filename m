From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 12:50:34 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1029) Convert to a new-style i2c
Message-Id: <20080716145034.49a730b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Corentin Labbe <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>

The new-style adm1029 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
---
 drivers/hwmon/adm1029.c |   97 +++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 53 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/adm1029.c	2008-07-12 09:20:31.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/adm1029.c	2008-07-12 10:27:32.000000000 +0200
@@ -115,9 +115,11 @@ static const u8 ADM1029_REG_FAN_DIV[] = 
  * Functions declaration
  */
 
-static int adm1029_attach_adapter(struct i2c_adapter *adapter);
-static int adm1029_detect(struct i2c_adapter *adapter, int address, int kind);
-static int adm1029_detach_client(struct i2c_client *client);
+static int adm1029_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id);
+static int adm1029_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info);
+static int adm1029_remove(struct i2c_client *client);
 static struct adm1029_data *adm1029_update_device(struct device *dev);
 static int adm1029_init_client(struct i2c_client *client);
 
@@ -125,12 +127,22 @@ static int adm1029_init_client(struct i2
  * Driver data (common to all clients)
  */
 
+static const struct i2c_device_id adm1029_id[] = {
+	{ "adm1029", adm1029 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1029_id);
+
 static struct i2c_driver adm1029_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name = "adm1029",
 	},
-	.attach_adapter = adm1029_attach_adapter,
-	.detach_client = adm1029_detach_client,
+	.probe		= adm1029_probe,
+	.remove		= adm1029_remove,
+	.id_table	= adm1029_id,
+	.detect		= adm1029_detect,
+	.address_data	= &addr_data,
 };
 
 /*
@@ -138,7 +150,6 @@ static struct i2c_driver adm1029_driver 
  */
 
 struct adm1029_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until following fields are valid */
@@ -284,37 +295,14 @@ static const struct attribute_group adm1
  * Real code
  */
 
-static int adm1029_attach_adapter(struct i2c_adapter *adapter)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int adm1029_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm1029_detect);
-}
+	struct i2c_adapter *adapter = client->adapter;
 
-/*
- * The following function does more than just detection. If detection
- * succeeds, it also registers the new chip.
- */
-
-static int adm1029_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *client;
-	struct adm1029_data *data;
-	int err = 0;
-	const char *name = "";
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct adm1029_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &adm1029_driver;
+		return -ENODEV;
 
 	/* Now we do the detection and identification. A negative kind
 	 * means that the driver was loaded with no force parameter
@@ -362,32 +350,41 @@ static int adm1029_detect(struct i2c_ada
 		if (kind <= 0) {	/* identification failed */
 			pr_debug("adm1029: Unsupported chip (man_id=0x%02X, "
 				 "chip_id=0x%02X)\n", man_id, chip_id);
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
+	strlcpy(info->type, "adm1029", I2C_NAME_SIZE);
 
-	if (kind = adm1029) {
-		name = "adm1029";
+	return 0;
+}
+
+static int adm1029_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct adm1029_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct adm1029_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
 	}
 
-	/* We can fill in the remaining client fields */
-	strlcpy(client->name, name, I2C_NAME_SIZE);
+	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
-
 	/*
 	 * Initialize the ADM1029 chip
 	 * Check config register
 	 */
-	if (adm1029_init_client(client) = 0)
-		goto exit_detach;
+	if (adm1029_init_client(client) = 0) {
+		err = -ENODEV;
+		goto exit_free;
+	}
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &adm1029_group)))
-		goto exit_detach;
+		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -399,8 +396,6 @@ static int adm1029_detect(struct i2c_ada
 
  exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
- exit_detach:
-	i2c_detach_client(client);
  exit_free:
 	kfree(data);
  exit:
@@ -424,17 +419,13 @@ static int adm1029_init_client(struct i2
 	return 1;
 }
 
-static int adm1029_detach_client(struct i2c_client *client)
+static int adm1029_remove(struct i2c_client *client)
 {
 	struct adm1029_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
 
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
