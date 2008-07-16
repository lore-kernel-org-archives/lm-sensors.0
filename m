From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 14:32:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm9240) Convert to a new-style i2c
Message-Id: <20080716163257.107e9340@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Grant Coady <gcoady.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The new-style adm9240 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Grant Coady <gcoady.lk@gmail.com>
---
 drivers/hwmon/adm9240.c |   93 +++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 47 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/adm9240.c	2008-07-12 09:20:31.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/adm9240.c	2008-07-12 10:27:31.000000000 +0200
@@ -130,25 +130,37 @@ static inline unsigned int AOUT_FROM_REG
 	return SCALE(reg, 1250, 255);
 }
 
-static int adm9240_attach_adapter(struct i2c_adapter *adapter);
-static int adm9240_detect(struct i2c_adapter *adapter, int address, int kind);
+static int adm9240_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id);
+static int adm9240_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info);
 static void adm9240_init_client(struct i2c_client *client);
-static int adm9240_detach_client(struct i2c_client *client);
+static int adm9240_remove(struct i2c_client *client);
 static struct adm9240_data *adm9240_update_device(struct device *dev);
 
 /* driver data */
+static const struct i2c_device_id adm9240_id[] = {
+	{ "adm9240", adm9240 },
+	{ "ds1780", ds1780 },
+	{ "lm81", lm81 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm9240_id);
+
 static struct i2c_driver adm9240_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "adm9240",
 	},
-	.attach_adapter	= adm9240_attach_adapter,
-	.detach_client	= adm9240_detach_client,
+	.probe		= adm9240_probe,
+	.remove		= adm9240_remove,
+	.id_table	= adm9240_id,
+	.detect		= adm9240_detect,
+	.address_data	= &addr_data,
 };
 
 /* per client data */
 struct adm9240_data {
-	enum chips type;
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;
@@ -532,28 +544,17 @@ static const struct attribute_group adm9
 
 /*** sensor chip detect and driver install ***/
 
-static int adm9240_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int adm9240_detect(struct i2c_client *new_client, int kind,
+			  struct i2c_board_info *info)
 {
-	struct i2c_client *new_client;
-	struct adm9240_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = new_client->adapter;
 	const char *name = "";
+	int address = new_client->addr;
 	u8 man_id, die_rev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &adm9240_driver;
-	new_client->flags = 0;
+		return -ENODEV;
 
 	if (kind = 0) {
 		kind = adm9240;
@@ -566,7 +567,7 @@ static int adm9240_detect(struct i2c_ada
 				!= address) {
 			dev_err(&adapter->dev, "detect fail: address match, "
 					"0x%02x\n", address);
-			goto exit_free;
+			return -ENODEV;
 		}
 
 		/* check known chip manufacturer */
@@ -581,7 +582,7 @@ static int adm9240_detect(struct i2c_ada
 		} else {
 			dev_err(&adapter->dev, "detect fail: unknown manuf, "
 					"0x%02x\n", man_id);
-			goto exit_free;
+			return -ENODEV;
 		}
 
 		/* successful detect, print chip info */
@@ -600,20 +601,31 @@ static int adm9240_detect(struct i2c_ada
 	} else if (kind = lm81) {
 		name = "lm81";
 	}
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 
-	/* fill in the remaining client fields and attach */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->type = kind;
-	mutex_init(&data->update_lock);
+	return 0;
+}
 
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_free;
+static int adm9240_probe(struct i2c_client *new_client,
+			 const struct i2c_device_id *id)
+{
+	struct adm9240_data *data;
+	int err;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(new_client, data);
+	mutex_init(&data->update_lock);
 
 	adm9240_init_client(new_client);
 
 	/* populate sysfs filesystem */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group)))
-		goto exit_detach;
+		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -625,32 +637,19 @@ static int adm9240_detect(struct i2c_ada
 
 exit_remove:
 	sysfs_remove_group(&new_client->dev.kobj, &adm9240_group);
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int adm9240_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm9240_detect);
-}
-
-static int adm9240_detach_client(struct i2c_client *client)
+static int adm9240_remove(struct i2c_client *client)
 {
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
 
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
