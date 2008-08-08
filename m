From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Aug 2008 12:34:47 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (dme1737) Convert to a new-style
Message-Id: <20080808143447.5feb9ce6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Michal =?ISO-8859-1?B?TWVkdmVja/0=?= <michal-2MYblgRXpuPk1uMJSBkQmQ@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

The new-style dme1737 driver implements the optional detect() callback
to cover the use cases of the legacy driver. I don't actually expect
any new-style device for that driver, but as the old i2c API is going
away soon, we have to switch to the new one.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Juerg Haefliger <juergh@gmail.com>
---
Juerg, Michal, any chance you could test these 2 patches on top of
2.6.27-rc2-git2?

 drivers/hwmon/dme1737.c |  106 +++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 58 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/dme1737.c	2008-07-06 20:11:04.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/dme1737.c	2008-07-06 20:31:35.000000000 +0200
@@ -176,7 +176,6 @@ static const u8 DME1737_BIT_ALARM_FAN[] 
  * --------------------------------------------------------------------- */
 
 struct dme1737_data {
-	struct i2c_client _client;	/* will go away soon */
 	struct i2c_client *client;	/* for I2C devices only */
 	struct device *hwmon_dev;
 	const char *name;
@@ -2188,38 +2187,24 @@ exit:
 	return err;
 }
 
-static int dme1737_i2c_detect(struct i2c_adapter *adapter, int address,
-			      int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int dme1737_i2c_detect(struct i2c_client *client, int kind,
+			      struct i2c_board_info *info)
 {
+	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &adapter->dev;
 	u8 company, verstep = 0;
-	struct i2c_client *client;
-	struct dme1737_data *data;
-	struct device *dev;
-	int err = 0;
 	const char *name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		goto exit;
-	}
-
-	if (!(data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
+		return -ENODEV;
 	}
 
-	client = &data->_client;
-	data->client = client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &dme1737_i2c_driver;
-	dev = &client->dev;
-
 	/* A negative kind means that the driver was loaded with no force
 	 * parameter (default), so we must identify the chip. */
 	if (kind < 0) {
-		company = dme1737_read(data, DME1737_REG_COMPANY);
-		verstep = dme1737_read(data, DME1737_REG_VERSTEP);
+		company = i2c_smbus_read_byte_data(client, DME1737_REG_COMPANY);
+		verstep = i2c_smbus_read_byte_data(client, DME1737_REG_VERSTEP);
 
 		if (company = DME1737_COMPANY_SMSC &&
 		    (verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP) {
@@ -2228,8 +2213,7 @@ static int dme1737_i2c_detect(struct i2c
 			   verstep = SCH5027_VERSTEP) {
 			kind = sch5027;
 		} else {
-			err = -ENODEV;
-			goto exit_kfree;
+			return -ENODEV;
 		}
 	}
 
@@ -2239,33 +2223,44 @@ static int dme1737_i2c_detect(struct i2c
 		kind = dme1737;
 		name = "dme1737";
 	}
-	data->type = kind;
-
-	/* Fill in the remaining client fields and put it into the global
-	 * list */
-	strlcpy(client->name, name, I2C_NAME_SIZE);
-	data->name = client->name;
-	mutex_init(&data->update_lock);
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client))) {
-		goto exit_kfree;
-	}
 
 	dev_info(dev, "Found a %s chip at 0x%02x (rev 0x%02x).\n",
 		 kind = sch5027 ? "SCH5027" : "DME1737", client->addr,
 		 verstep);
+	strlcpy(info->type, name, I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int dme1737_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct dme1737_data *data;
+	struct device *dev = &client->dev;
+	int err;
+
+	data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	data->type = id->driver_data;
+	data->client = client;
+	data->name = client->name;
+	mutex_init(&data->update_lock);
 
 	/* Initialize the DME1737 chip */
 	if ((err = dme1737_init_device(dev))) {
 		dev_err(dev, "Failed to initialize device.\n");
-		goto exit_detach;
+		goto exit_kfree;
 	}
 
 	/* Create sysfs files */
 	if ((err = dme1737_create_files(dev))) {
 		dev_err(dev, "Failed to create sysfs files.\n");
-		goto exit_detach;
+		goto exit_kfree;
 	}
 
 	/* Register device */
@@ -2280,45 +2275,40 @@ static int dme1737_i2c_detect(struct i2c
 
 exit_remove:
 	dme1737_remove_files(dev);
-exit_detach:
-	i2c_detach_client(client);
 exit_kfree:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int dme1737_i2c_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON)) {
-		return 0;
-	}
-
-	return i2c_probe(adapter, &addr_data, dme1737_i2c_detect);
-}
-
-static int dme1737_i2c_detach_client(struct i2c_client *client)
+static int dme1737_i2c_remove(struct i2c_client *client)
 {
 	struct dme1737_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	dme1737_remove_files(&client->dev);
 
-	if ((err = i2c_detach_client(client))) {
-		return err;
-	}
-
 	kfree(data);
 	return 0;
 }
 
+static const struct i2c_device_id dme1737_id[] = {
+	{ "dme1737", dme1737 },
+	{ "sch5027", sch5027 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, dme1737_id);
+
 static struct i2c_driver dme1737_i2c_driver = {
+	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = "dme1737",
 	},
-	.attach_adapter	= dme1737_i2c_attach_adapter,
-	.detach_client = dme1737_i2c_detach_client,
+	.probe = dme1737_i2c_probe,
+	.remove = dme1737_i2c_remove,
+	.id_table = dme1737_id,
+	.detect = dme1737_i2c_detect,
+	.address_data = &addr_data,
 };
 
 /* ---------------------------------------------------------------------


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
