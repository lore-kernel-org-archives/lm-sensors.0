From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 15:34:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83791d) Convert to a new-style i2c
Message-Id: <20080716173419.10c135b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Marc Hulsman <m.hulsman-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>

The new-style w83791d driver implements the optional detect()
callback to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>
---
 drivers/hwmon/w83791d.c |  207 ++++++++++++++++-------------------------------
 1 file changed, 72 insertions(+), 135 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/w83791d.c	2008-07-12 09:20:29.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/w83791d.c	2008-07-12 10:27:11.000000000 +0200
@@ -247,7 +247,6 @@ static u8 div_to_reg(int nr, long val)
 }
 
 struct w83791d_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 
@@ -286,9 +285,11 @@ struct w83791d_data {
 	u8 vrm;			/* hwmon-vid */
 };
 
-static int w83791d_attach_adapter(struct i2c_adapter *adapter);
-static int w83791d_detect(struct i2c_adapter *adapter, int address, int kind);
-static int w83791d_detach_client(struct i2c_client *client);
+static int w83791d_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id);
+static int w83791d_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info);
+static int w83791d_remove(struct i2c_client *client);
 
 static int w83791d_read(struct i2c_client *client, u8 register);
 static int w83791d_write(struct i2c_client *client, u8 register, u8 value);
@@ -300,12 +301,22 @@ static void w83791d_print_debug(struct w
 
 static void w83791d_init_client(struct i2c_client *client);
 
+static const struct i2c_device_id w83791d_id[] = {
+	{ "w83791d", w83791d },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, w83791d_id);
+
 static struct i2c_driver w83791d_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name = "w83791d",
 	},
-	.attach_adapter = w83791d_attach_adapter,
-	.detach_client = w83791d_detach_client,
+	.probe		= w83791d_probe,
+	.remove		= w83791d_remove,
+	.id_table	= w83791d_id,
+	.detect		= w83791d_detect,
+	.address_data	= &addr_data,
 };
 
 /* following are the sysfs callback functions */
@@ -905,49 +916,12 @@ static const struct attribute_group w837
 	.attrs = w83791d_attributes,
 };
 
-/* This function is called when:
-     * w83791d_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and w83791d_driver is still present) */
-static int w83791d_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, w83791d_detect);
-}
-
-
-static int w83791d_create_subclient(struct i2c_adapter *adapter,
-				struct i2c_client *client, int addr,
-				struct i2c_client **sub_cli)
-{
-	int err;
-	struct i2c_client *sub_client;
-
-	(*sub_cli) = sub_client -			kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!(sub_client)) {
-		return -ENOMEM;
-	}
-	sub_client->addr = 0x48 + addr;
-	i2c_set_clientdata(sub_client, NULL);
-	sub_client->adapter = adapter;
-	sub_client->driver = &w83791d_driver;
-	strlcpy(sub_client->name, "w83791d subclient", I2C_NAME_SIZE);
-	if ((err = i2c_attach_client(sub_client))) {
-		dev_err(&client->dev, "subclient registration "
-			"at address 0x%x failed\n", sub_client->addr);
-		kfree(sub_client);
-		return err;
-	}
-	return 0;
-}
-
 
-static int w83791d_detect_subclients(struct i2c_adapter *adapter, int address,
-				int kind, struct i2c_client *client)
+static int w83791d_detect_subclients(struct i2c_client *client)
 {
+	struct i2c_adapter *adapter = client->adapter;
 	struct w83791d_data *data = i2c_get_clientdata(client);
+	int address = client->addr;
 	int i, id, err;
 	u8 val;
 
@@ -971,10 +945,7 @@ static int w83791d_detect_subclients(str
 
 	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
 	if (!(val & 0x08)) {
-		err = w83791d_create_subclient(adapter, client,
-						val & 0x7, &data->lm75[0]);
-		if (err < 0)
-			goto error_sc_0;
+		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
 	}
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
@@ -986,10 +957,8 @@ static int w83791d_detect_subclients(str
 			err = -ENODEV;
 			goto error_sc_1;
 		}
-		err = w83791d_create_subclient(adapter, client,
-					(val >> 4) & 0x7, &data->lm75[1]);
-		if (err < 0)
-			goto error_sc_1;
+		data->lm75[1] = i2c_new_dummy(adapter,
+					      0x48 + ((val >> 4) & 0x7));
 	}
 
 	return 0;
@@ -997,53 +966,31 @@ static int w83791d_detect_subclients(str
 /* Undo inits in case of errors */
 
 error_sc_1:
-	if (data->lm75[0] != NULL) {
-		i2c_detach_client(data->lm75[0]);
-		kfree(data->lm75[0]);
-	}
+	if (data->lm75[0] != NULL)
+		i2c_unregister_device(data->lm75[0]);
 error_sc_0:
 	return err;
 }
 
 
-static int w83791d_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *client;
-	struct device *dev;
-	struct w83791d_data *data;
-	int i, val1, val2;
-	int err = 0;
-	const char *client_name = "";
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int w83791d_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int val1, val2;
+	unsigned short address = client->addr;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		goto error0;
+		return -ENODEV;
 	}
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access w83791d_{read,write}_value. */
-	if (!(data = kzalloc(sizeof(struct w83791d_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto error0;
-	}
-
-	client = &data->client;
-	dev = &client->dev;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &w83791d_driver;
-	mutex_init(&data->update_lock);
-
-	/* Now, we do the remaining detection. */
-
 	/* The w83791d may be stuck in some other bank than bank 0. This may
 	   make reading other information impossible. Specify a force=...
 	   parameter, and the Winbond will be reset to the right bank. */
 	if (kind < 0) {
 		if (w83791d_read(client, W83791D_REG_CONFIG) & 0x80) {
-			dev_dbg(dev, "Detection failed at step 1\n");
-			goto error1;
+			return -ENODEV;
 		}
 		val1 = w83791d_read(client, W83791D_REG_BANK);
 		val2 = w83791d_read(client, W83791D_REG_CHIPMAN);
@@ -1052,15 +999,13 @@ static int w83791d_detect(struct i2c_ada
 			/* yes it is Bank0 */
 			if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
 			    ((val1 & 0x80) && (val2 != 0x5c))) {
-				dev_dbg(dev, "Detection failed at step 2\n");
-				goto error1;
+				return -ENODEV;
 			}
 		}
 		/* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
 		   should match */
 		if (w83791d_read(client, W83791D_REG_I2C_ADDR) != address) {
-			dev_dbg(dev, "Detection failed at step 3\n");
-			goto error1;
+			return -ENODEV;
 		}
 	}
 
@@ -1075,30 +1020,33 @@ static int w83791d_detect(struct i2c_ada
 		/* get vendor ID */
 		val2 = w83791d_read(client, W83791D_REG_CHIPMAN);
 		if (val2 != 0x5c) {	/* the vendor is NOT Winbond */
-			dev_dbg(dev, "Detection failed at step 4\n");
-			goto error1;
+			return -ENODEV;
 		}
 		val1 = w83791d_read(client, W83791D_REG_WCHIPID);
 		if (val1 = 0x71) {
 			kind = w83791d;
 		} else {
 			if (kind = 0)
-				dev_warn(dev,
+				dev_warn(&adapter->dev,
 					"w83791d: Ignoring 'force' parameter "
 					"for unknown chip at adapter %d, "
 					"address 0x%02x\n",
 					i2c_adapter_id(adapter), address);
-			goto error1;
+			return -ENODEV;
 		}
 	}
 
-	if (kind = w83791d) {
-		client_name = "w83791d";
-	} else {
-		dev_err(dev, "w83791d: Internal error: unknown kind (%d)?!?\n",
-			kind);
-		goto error1;
-	}
+	strlcpy(info->type, "w83791d", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int w83791d_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct w83791d_data *data;
+	struct device *dev = &client->dev;
+	int i, val1, err;
 
 #ifdef DEBUG
 	val1 = w83791d_read(client, W83791D_REG_DID_VID4);
@@ -1106,15 +1054,18 @@ static int w83791d_detect(struct i2c_ada
 			(val1 >> 5) & 0x07, (val1 >> 1) & 0x0f, val1);
 #endif
 
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(client->name, client_name, I2C_NAME_SIZE);
+	data = kzalloc(sizeof(struct w83791d_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto error0;
+	}
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto error1;
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
 
-	if ((err = w83791d_detect_subclients(adapter, address, kind, client)))
-		goto error2;
+	err = w83791d_detect_subclients(client);
+	if (err)
+		goto error1;
 
 	/* Initialize the chip */
 	w83791d_init_client(client);
@@ -1141,43 +1092,29 @@ static int w83791d_detect(struct i2c_ada
 error4:
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 error3:
-	if (data->lm75[0] != NULL) {
-		i2c_detach_client(data->lm75[0]);
-		kfree(data->lm75[0]);
-	}
-	if (data->lm75[1] != NULL) {
-		i2c_detach_client(data->lm75[1]);
-		kfree(data->lm75[1]);
-	}
-error2:
-	i2c_detach_client(client);
+	if (data->lm75[0] != NULL)
+		i2c_unregister_device(data->lm75[0]);
+	if (data->lm75[1] != NULL)
+		i2c_unregister_device(data->lm75[1]);
 error1:
 	kfree(data);
 error0:
 	return err;
 }
 
-static int w83791d_detach_client(struct i2c_client *client)
+static int w83791d_remove(struct i2c_client *client)
 {
 	struct w83791d_data *data = i2c_get_clientdata(client);
-	int err;
-
-	/* main client */
-	if (data) {
-		hwmon_device_unregister(data->hwmon_dev);
-		sysfs_remove_group(&client->dev.kobj, &w83791d_group);
-	}
 
-	if ((err = i2c_detach_client(client)))
-		return err;
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 
-	/* main client */
-	if (data)
-		kfree(data);
-	/* subclient */
-	else
-		kfree(client);
+	if (data->lm75[0] != NULL)
+		i2c_unregister_device(data->lm75[0]);
+	if (data->lm75[1] != NULL)
+		i2c_unregister_device(data->lm75[1]);
 
+	kfree(data);
 	return 0;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
