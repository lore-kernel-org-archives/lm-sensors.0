From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Sep 2008 10:13:51 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (lm78) Convert to a new-style i2c
Message-Id: <20080911121351.26ef82e3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new-style lm78 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm78.c |  200 +++++++++++++++++++++++---------------------------
 1 file changed, 92 insertions(+), 108 deletions(-)

--- linux-2.6.27-rc6.orig/drivers/hwmon/lm78.c	2008-09-11 11:02:31.000000000 +0200
+++ linux-2.6.27-rc6/drivers/hwmon/lm78.c	2008-09-11 11:29:27.000000000 +0200
@@ -115,7 +115,7 @@ static inline int TEMP_FROM_REG(s8 val)
 #define DIV_FROM_REG(val) (1 << (val))
 
 struct lm78_data {
-	struct i2c_client client;
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
@@ -142,9 +142,11 @@ struct lm78_data {
 };
 
 
-static int lm78_attach_adapter(struct i2c_adapter *adapter);
-static int lm78_detect(struct i2c_adapter *adapter, int address, int kind);
-static int lm78_detach_client(struct i2c_client *client);
+static int lm78_i2c_detect(struct i2c_client *client, int kind,
+			   struct i2c_board_info *info);
+static int lm78_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id);
+static int lm78_i2c_remove(struct i2c_client *client);
 
 static int __devinit lm78_isa_probe(struct platform_device *pdev);
 static int __devexit lm78_isa_remove(struct platform_device *pdev);
@@ -155,12 +157,23 @@ static struct lm78_data *lm78_update_dev
 static void lm78_init_device(struct lm78_data *data);
 
 
+static const struct i2c_device_id lm78_i2c_id[] = {
+	{ "lm78", lm78 },
+	{ "lm79", lm79 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm78_i2c_id);
+
 static struct i2c_driver lm78_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm78",
 	},
-	.attach_adapter	= lm78_attach_adapter,
-	.detach_client	= lm78_detach_client,
+	.probe		= lm78_i2c_probe,
+	.remove		= lm78_i2c_remove,
+	.id_table	= lm78_i2c_id,
+	.detect		= lm78_i2c_detect,
+	.address_data	= &addr_data,
 };
 
 static struct platform_driver lm78_isa_driver = {
@@ -445,29 +458,6 @@ static SENSOR_DEVICE_ATTR(fan2_alarm, S_
 static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
 
-/* This function is called when:
-     * lm78_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and lm78_driver is still present)
-   We block updates of the ISA device to minimize the risk of concurrent
-   access to the same LM78 chip through different interfaces. */
-static int lm78_attach_adapter(struct i2c_adapter *adapter)
-{
-	struct lm78_data *data;
-	int err;
-
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-
-	data = pdev ? platform_get_drvdata(pdev) : NULL;
-	if (data)
-		mutex_lock(&data->update_lock);
-	err = i2c_probe(adapter, &addr_data, lm78_detect);
-	if (data)
-		mutex_unlock(&data->update_lock);
-	return err;
-}
-
 static struct attribute *lm78_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
@@ -537,13 +527,11 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
 /* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
 static int lm78_alias_detect(struct i2c_client *client, u8 chipid)
 {
-	struct lm78_data *i2c, *isa;
+	struct lm78_data *isa;
 	int i;
 
 	if (!pdev)	/* No ISA chip */
 		return 0;
-
-	i2c = i2c_get_clientdata(client);
 	isa = platform_get_drvdata(pdev);
 
 	if (lm78_read_value(isa, LM78_REG_I2C_ADDR) != client->addr)
@@ -554,70 +542,55 @@ static int lm78_alias_detect(struct i2c_
 	/* We compare all the limit registers, the config register and the
 	 * interrupt mask registers */
 	for (i = 0x2b; i <= 0x3d; i++) {
-		if (lm78_read_value(isa, i) != lm78_read_value(i2c, i))
+		if (lm78_read_value(isa, i) !+		    i2c_smbus_read_byte_data(client, i))
 			return 0;
 	}
 	if (lm78_read_value(isa, LM78_REG_CONFIG) !-	    lm78_read_value(i2c, LM78_REG_CONFIG))
+	    i2c_smbus_read_byte_data(client, LM78_REG_CONFIG))
 		return 0;
 	for (i = 0x43; i <= 0x46; i++) {
-		if (lm78_read_value(isa, i) != lm78_read_value(i2c, i))
+		if (lm78_read_value(isa, i) !+		    i2c_smbus_read_byte_data(client, i))
 			return 0;
 	}
 
 	return 1;
 }
 
-/* This function is called by i2c_probe */
-static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm78_i2c_detect(struct i2c_client *client, int kind,
+			   struct i2c_board_info *info)
 {
-	int i, err;
-	struct i2c_client *new_client;
-	struct lm78_data *data;
-	const char *client_name = "";
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		err = -ENODEV;
-		goto ERROR1;
-	}
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access lm78_{read,write}_value. */
-
-	if (!(data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto ERROR1;
-	}
-
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm78_driver;
+	int i;
+	struct lm78_data *isa = pdev ? platform_get_drvdata(pdev) : NULL;
+	const char *client_name;
+	struct i2c_adapter *adapter = client->adapter;
+	int address = client->addr;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/* We block updates of the ISA device to minimize the risk of
+	   concurrent access to the same LM78 chip through different
+	   interfaces. */
+	if (isa)
+		mutex_lock(&isa->update_lock);
 
-	/* Now, we do the remaining detection. */
 	if (kind < 0) {
-		if (lm78_read_value(data, LM78_REG_CONFIG) & 0x80) {
-			err = -ENODEV;
-			goto ERROR2;
-		}
-		if (lm78_read_value(data, LM78_REG_I2C_ADDR) !-		    address) {
-			err = -ENODEV;
-			goto ERROR2;
-		}
+		if ((i2c_smbus_read_byte_data(client, LM78_REG_CONFIG) & 0x80)
+		 || i2c_smbus_read_byte_data(client, LM78_REG_I2C_ADDR)
+		    != address)
+			goto err_nodev;
+
 		/* Explicitly prevent the misdetection of Winbond chips */
-		i = lm78_read_value(data, 0x4f);
-		if (i = 0xa3 || i = 0x5c) {
-			err = -ENODEV;
-			goto ERROR2;
-		}
+		i = i2c_smbus_read_byte_data(client, 0x4f);
+		if (i = 0xa3 || i = 0x5c)
+			goto err_nodev;
 	}
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
-		i = lm78_read_value(data, LM78_REG_CHIPID);
+		i = i2c_smbus_read_byte_data(client, LM78_REG_CHIPID);
 		if (i = 0x00 || i = 0x20	/* LM78 */
 		 || i = 0x40)			/* LM78-J */
 			kind = lm78;
@@ -629,40 +602,59 @@ static int lm78_detect(struct i2c_adapte
 					"parameter for unknown chip at "
 					"adapter %d, address 0x%02x\n",
 					i2c_adapter_id(adapter), address);
-			err = -ENODEV;
-			goto ERROR2;
+			goto err_nodev;
 		}
 
-		if (lm78_alias_detect(new_client, i)) {
+		if (lm78_alias_detect(client, i)) {
 			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
 				"be the same as ISA device\n", address);
-			err = -ENODEV;
-			goto ERROR2;
+			goto err_nodev;
 		}
 	}
 
-	if (kind = lm78) {
-		client_name = "lm78";
-	} else if (kind = lm79) {
+	if (isa)
+		mutex_unlock(&isa->update_lock);
+
+	switch (kind) {
+	case lm79:
 		client_name = "lm79";
+		break;
+	default:
+		client_name = "lm78";
 	}
+	strlcpy(info->type, client_name, I2C_NAME_SIZE);
+
+	return 0;
+
+ err_nodev:
+	if (isa)
+		mutex_unlock(&isa->update_lock);
+	return -ENODEV;
+}
 
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-	data->type = kind;
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto ERROR2;
+static int lm78_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct lm78_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	data->client = client;
+	data->type = id->driver_data;
 
 	/* Initialize the LM78 chip */
 	lm78_init_device(data);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm78_group)))
+	err = sysfs_create_group(&client->dev.kobj, &lm78_group);
+	if (err)
 		goto ERROR3;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
@@ -671,26 +663,18 @@ static int lm78_detect(struct i2c_adapte
 	return 0;
 
 ERROR4:
-	sysfs_remove_group(&new_client->dev.kobj, &lm78_group);
+	sysfs_remove_group(&client->dev.kobj, &lm78_group);
 ERROR3:
-	i2c_detach_client(new_client);
-ERROR2:
 	kfree(data);
-ERROR1:
 	return err;
 }
 
-static int lm78_detach_client(struct i2c_client *client)
+static int lm78_i2c_remove(struct i2c_client *client)
 {
 	struct lm78_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm78_group);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
 
 	return 0;
@@ -774,9 +758,9 @@ static int __devexit lm78_isa_remove(str
    would slow down the LM78 access and should not be necessary.  */
 static int lm78_read_value(struct lm78_data *data, u8 reg)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 
-	if (!client->driver) { /* ISA device */
+	if (!client) { /* ISA device */
 		int res;
 		mutex_lock(&data->lock);
 		outb_p(reg, data->isa_addr + LM78_ADDR_REG_OFFSET);
@@ -796,9 +780,9 @@ static int lm78_read_value(struct lm78_d
    nowhere else be necessary! */
 static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 
-	if (!client->driver) { /* ISA device */
+	if (!client) { /* ISA device */
 		mutex_lock(&data->lock);
 		outb_p(reg, data->isa_addr + LM78_ADDR_REG_OFFSET);
 		outb_p(value, data->isa_addr + LM78_DATA_REG_OFFSET);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
