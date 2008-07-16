From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 15:35:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83l786ng) Convert to a new-style i2c
Message-Id: <20080716173503.31f72571@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Kevin Lo <kevlo-M03WffYOTozYtjvyW6yDsg@public.gmane.org>

The new-style w83l786ng driver implements the optional detect()
callback to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Kevin Lo <kevlo@kevlo.org>
---
 drivers/hwmon/w83l786ng.c |   98 ++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 53 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/w83l786ng.c	2008-07-12 09:20:28.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/w83l786ng.c	2008-07-12 10:27:08.000000000 +0200
@@ -121,7 +121,6 @@ DIV_TO_REG(long val)
 }
 
 struct w83l786ng_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
@@ -146,18 +145,30 @@ struct w83l786ng_data {
 	u8 tolerance[2];
 };
 
-static int w83l786ng_attach_adapter(struct i2c_adapter *adapter);
-static int w83l786ng_detect(struct i2c_adapter *adapter, int address, int kind);
-static int w83l786ng_detach_client(struct i2c_client *client);
+static int w83l786ng_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id);
+static int w83l786ng_detect(struct i2c_client *client, int kind,
+			    struct i2c_board_info *info);
+static int w83l786ng_remove(struct i2c_client *client);
 static void w83l786ng_init_client(struct i2c_client *client);
 static struct w83l786ng_data *w83l786ng_update_device(struct device *dev);
 
+static const struct i2c_device_id w83l786ng_id[] = {
+	{ "w83l786ng", w83l786ng },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, w83l786ng_id);
+
 static struct i2c_driver w83l786ng_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		   .name = "w83l786ng",
 	},
-	.attach_adapter = w83l786ng_attach_adapter,
-	.detach_client = w83l786ng_detach_client,
+	.probe		= w83l786ng_probe,
+	.remove		= w83l786ng_remove,
+	.id_table	= w83l786ng_id,
+	.detect		= w83l786ng_detect,
+	.address_data	= &addr_data,
 };
 
 static u8
@@ -575,42 +586,15 @@ static const struct attribute_group w83l
 };
 
 static int
-w83l786ng_attach_adapter(struct i2c_adapter *adapter)
+w83l786ng_detect(struct i2c_client *client, int kind,
+		 struct i2c_board_info *info)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, w83l786ng_detect);
-}
-
-static int
-w83l786ng_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *client;
-	struct device *dev;
-	struct w83l786ng_data *data;
-	int i, err = 0;
-	u8 reg_tmp;
+	struct i2c_adapter *adapter = client->adapter;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		goto exit;
-	}
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access w83l786ng_{read,write}_value. */
-
-	if (!(data = kzalloc(sizeof(struct w83l786ng_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
+		return -ENODEV;
 	}
 
-	client = &data->client;
-	dev = &client->dev;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &w83l786ng_driver;
-
 	/*
 	 * Now we do the remaining detection. A negative kind means that
 	 * the driver was loaded with no force parameter (default), so we
@@ -627,8 +611,8 @@ w83l786ng_detect(struct i2c_adapter *ada
 		    W83L786NG_REG_CONFIG) & 0x80) != 0x00)) {
 			dev_dbg(&adapter->dev,
 				"W83L786NG detection failed at 0x%02x.\n",
-				address);
-			goto exit_free;
+				client->addr);
+			return -ENODEV;
 		}
 	}
 
@@ -651,17 +635,31 @@ w83l786ng_detect(struct i2c_adapter *ada
 			dev_info(&adapter->dev,
 			    "Unsupported chip (man_id=0x%04X, "
 			    "chip_id=0x%02X).\n", man_id, chip_id);
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
 
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(client->name, "w83l786ng", I2C_NAME_SIZE);
-	mutex_init(&data->update_lock);
+	strlcpy(info->type, "w83l786ng", I2C_NAME_SIZE);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
+	return 0;
+}
+
+static int
+w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct w83l786ng_data *data;
+	int i, err = 0;
+	u8 reg_tmp;
+
+	data = kzalloc(sizeof(struct w83l786ng_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
 
 	/* Initialize the chip */
 	w83l786ng_init_client(client);
@@ -693,25 +691,19 @@ w83l786ng_detect(struct i2c_adapter *ada
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &w83l786ng_group);
-	i2c_detach_client(client);
-exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
 static int
-w83l786ng_detach_client(struct i2c_client *client)
+w83l786ng_remove(struct i2c_client *client)
 {
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &w83l786ng_group);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
