From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 19:04:31 +0000
Subject: [lm-sensors] [PATCH 6/6] hwmon: (w83781d) Use new style driver
Message-Id: <20081007210431.4fd37ad1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Wolfgang Grandegger <wg@grandegger.com>

This patch modifies the w83781d driver to use new style driver binding.
Substantial code modifications are required to deal with the new
interface, especially legacy device detection.

[JD: largely edited to make the patch smaller and to get the driver
to work again on ISA devices.]

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |  311 ++++++++++++++++++++---------------------------
 1 file changed, 135 insertions(+), 176 deletions(-)

--- linux-2.6.27-rc9.orig/drivers/hwmon/w83781d.c	2008-10-07 19:00:22.000000000 +0200
+++ linux-2.6.27-rc9/drivers/hwmon/w83781d.c	2008-10-07 19:01:55.000000000 +0200
@@ -199,7 +199,7 @@ DIV_TO_REG(long val, enum chips type)
 }
 
 struct w83781d_data {
-	struct i2c_client client;
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
@@ -241,23 +241,11 @@ struct w83781d_data {
 static struct w83781d_data *w83781d_data_if_isa(void);
 static int w83781d_alias_detect(struct i2c_client *client, u8 chipid);
 
-static int w83781d_attach_adapter(struct i2c_adapter *adapter);
-static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
-static int w83781d_detach_client(struct i2c_client *client);
-
 static int w83781d_read_value(struct w83781d_data *data, u16 reg);
 static int w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_device(struct device *dev);
 
-static struct i2c_driver w83781d_driver = {
-	.driver = {
-		.name = "w83781d",
-	},
-	.attach_adapter = w83781d_attach_adapter,
-	.detach_client = w83781d_detach_client,
-};
-
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
@@ -819,46 +807,19 @@ static SENSOR_DEVICE_ATTR(temp2_type, S_
 static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
 	show_sensor, store_sensor, 2);
 
-/* This function is called when:
-     * w83781d_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and w83781d_driver is still present)
-   We block updates of the ISA device to minimize the risk of concurrent
-   access to the same W83781D chip through different interfaces. */
-static int
-w83781d_attach_adapter(struct i2c_adapter *adapter)
-{
-	struct w83781d_data *data = w83781d_data_if_isa();
-	int err;
-
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-
-	if (data)
-		mutex_lock(&data->update_lock);
-	err = i2c_probe(adapter, &addr_data, w83781d_detect);
-	if (data)
-		mutex_unlock(&data->update_lock);
-	return err;
-}
-
 /* Assumes that adapter is of I2C, not ISA variety.
  * OTHERWISE DON'T CALL THIS
  */
 static int
-w83781d_detect_subclients(struct i2c_adapter *adapter, int address, int kind,
-		struct i2c_client *new_client)
+w83781d_detect_subclients(struct i2c_client *new_client)
 {
 	int i, val1 = 0, id;
 	int err;
-	const char *client_name = "";
+	int address = new_client->addr;
+	unsigned short sc_addr[2];
+	struct i2c_adapter *adapter = new_client->adapter;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
-
-	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!(data->lm75[0])) {
-		err = -ENOMEM;
-		goto ERROR_SC_0;
-	}
+	enum chips kind = data->type;
 
 	id = i2c_adapter_id(adapter);
 
@@ -876,55 +837,35 @@ w83781d_detect_subclients(struct i2c_ada
 		w83781d_write_value(data, W83781D_REG_I2C_SUBADDR,
 				(force_subclients[2] & 0x07) |
 				((force_subclients[3] & 0x07) << 4));
-		data->lm75[0]->addr = force_subclients[2];
+		sc_addr[0] = force_subclients[2];
 	} else {
 		val1 = w83781d_read_value(data, W83781D_REG_I2C_SUBADDR);
-		data->lm75[0]->addr = 0x48 + (val1 & 0x07);
+		sc_addr[0] = 0x48 + (val1 & 0x07);
 	}
 
 	if (kind != w83783s) {
-		data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-		if (!(data->lm75[1])) {
-			err = -ENOMEM;
-			goto ERROR_SC_1;
-		}
-
 		if (force_subclients[0] = id &&
 		    force_subclients[1] = address) {
-			data->lm75[1]->addr = force_subclients[3];
+			sc_addr[1] = force_subclients[3];
 		} else {
-			data->lm75[1]->addr = 0x48 + ((val1 >> 4) & 0x07);
+			sc_addr[1] = 0x48 + ((val1 >> 4) & 0x07);
 		}
-		if (data->lm75[0]->addr = data->lm75[1]->addr) {
+		if (sc_addr[0] = sc_addr[1]) {
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
-			       data->lm75[0]->addr);
+			       sc_addr[0]);
 			err = -EBUSY;
 			goto ERROR_SC_2;
 		}
 	}
 
-	if (kind = w83781d)
-		client_name = "w83781d subclient";
-	else if (kind = w83782d)
-		client_name = "w83782d subclient";
-	else if (kind = w83783s)
-		client_name = "w83783s subclient";
-	else if (kind = as99127f)
-		client_name = "as99127f subclient";
-
 	for (i = 0; i <= 1; i++) {
-		/* store all data in w83781d */
-		i2c_set_clientdata(data->lm75[i], NULL);
-		data->lm75[i]->adapter = adapter;
-		data->lm75[i]->driver = &w83781d_driver;
-		data->lm75[i]->flags = 0;
-		strlcpy(data->lm75[i]->name, client_name,
-			I2C_NAME_SIZE);
-		if ((err = i2c_attach_client(data->lm75[i]))) {
+		data->lm75[i] = i2c_new_dummy(adapter, sc_addr[i]);
+		if (!data->lm75[i]) {
 			dev_err(&new_client->dev, "Subclient %d "
 				"registration at address 0x%x "
-				"failed.\n", i, data->lm75[i]->addr);
+				"failed.\n", i, sc_addr[i]);
+			err = -ENOMEM;
 			if (i = 1)
 				goto ERROR_SC_3;
 			goto ERROR_SC_2;
@@ -937,12 +878,9 @@ w83781d_detect_subclients(struct i2c_ada
 
 /* Undo inits in case of errors */
 ERROR_SC_3:
-	i2c_detach_client(data->lm75[0]);
+	i2c_unregister_device(data->lm75[0]);
 ERROR_SC_2:
-	kfree(data->lm75[1]);
 ERROR_SC_1:
-	kfree(data->lm75[0]);
-ERROR_SC_0:
 	return err;
 }
 
@@ -1108,87 +1046,71 @@ w83781d_create_files(struct device *dev,
 	return 0;
 }
 
+/* Return 0 if detection is successful, -ENODEV otherwise */
 static int
-w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
+w83781d_detect(struct i2c_client *client, int kind,
+	       struct i2c_board_info *info)
 {
 	int val1 = 0, val2;
-	struct i2c_client *client;
-	struct device *dev;
-	struct w83781d_data *data;
-	int err;
+	struct w83781d_data *isa = w83781d_data_if_isa();
+	struct i2c_adapter *adapter = client->adapter;
+	int address = client->addr;
 	const char *client_name = "";
 	enum vendor { winbond, asus } vendid;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		err = -EINVAL;
-		goto ERROR1;
-	}
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access w83781d_{read,write}_value. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
 
-	if (!(data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto ERROR1;
-	}
-
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	mutex_init(&data->lock);
-	client->adapter = adapter;
-	client->driver = &w83781d_driver;
-	dev = &client->dev;
-
-	/* Now, we do the remaining detection. */
+	/* We block updates of the ISA device to minimize the risk of
+	   concurrent access to the same W83781D chip through different
+	   interfaces. */
+	if (isa)
+		mutex_lock(&isa->update_lock);
 
 	/* The w8378?d may be stuck in some other bank than bank 0. This may
 	   make reading other information impossible. Specify a force=... or
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(data, W83781D_REG_CONFIG) & 0x80) {
+		if (i2c_smbus_read_byte_data
+		    (client, W83781D_REG_CONFIG) & 0x80) {
 			dev_dbg(&adapter->dev, "Detection of w83781d chip "
 				"failed at step 3\n");
-			err = -ENODEV;
-			goto ERROR2;
+			goto err_nodev;
 		}
-		val1 = w83781d_read_value(data, W83781D_REG_BANK);
-		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
+		val1 = i2c_smbus_read_byte_data(client, W83781D_REG_BANK);
+		val2 = i2c_smbus_read_byte_data(client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
 		if ((!(val1 & 0x07)) &&
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
 			dev_dbg(&adapter->dev, "Detection of w83781d chip "
 				"failed at step 4\n");
-			err = -ENODEV;
-			goto ERROR2;
+			goto err_nodev;
 		}
 		/* If Winbond SMBus, check address at 0x48.
 		   Asus doesn't support, except for as99127f rev.2 */
 		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
 		    ((val1 & 0x80) && (val2 = 0x5c))) {
-			if (w83781d_read_value
-			    (data, W83781D_REG_I2C_ADDR) != address) {
+			if (i2c_smbus_read_byte_data
+			    (client, W83781D_REG_I2C_ADDR) != address) {
 				dev_dbg(&adapter->dev, "Detection of w83781d "
 					"chip failed at step 5\n");
-				err = -ENODEV;
-				goto ERROR2;
+				goto err_nodev;
 			}
 		}
 	}
 
 	/* We have either had a force parameter, or we have already detected the
 	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
-	w83781d_write_value(data, W83781D_REG_BANK,
-			    (w83781d_read_value(data, W83781D_REG_BANK)
-			     & 0x78) | 0x80);
+	i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
+		(i2c_smbus_read_byte_data(client, W83781D_REG_BANK)
+		 & 0x78) | 0x80);
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
 		/* get vendor ID */
-		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
+		val2 = i2c_smbus_read_byte_data(client, W83781D_REG_CHIPMAN);
 		if (val2 = 0x5c)
 			vendid = winbond;
 		else if (val2 = 0x12)
@@ -1196,11 +1118,10 @@ w83781d_detect(struct i2c_adapter *adapt
 		else {
 			dev_dbg(&adapter->dev, "w83781d chip vendor is "
 				"neither Winbond nor Asus\n");
-			err = -ENODEV;
-			goto ERROR2;
+			goto err_nodev;
 		}
 
-		val1 = w83781d_read_value(data, W83781D_REG_WCHIPID);
+		val1 = i2c_smbus_read_byte_data(client, W83781D_REG_WCHIPID);
 		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
 			kind = w83781d;
 		else if (val1 = 0x30 && vendid = winbond)
@@ -1214,19 +1135,20 @@ w83781d_detect(struct i2c_adapter *adapt
 				dev_warn(&adapter->dev, "Ignoring 'force' "
 					 "parameter for unknown chip at "
 					 "address 0x%02x\n", address);
-			err = -EINVAL;
-			goto ERROR2;
+			goto err_nodev;
 		}
 
 		if ((kind = w83781d || kind = w83782d)
 		 && w83781d_alias_detect(client, val1)) {
 			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
 				"be the same as ISA device\n", address);
-			err = -ENODEV;
-			goto ERROR2;
+			goto err_nodev;
 		}
 	}
 
+	if (isa)
+		mutex_unlock(&isa->update_lock);
+
 	if (kind = w83781d) {
 		client_name = "w83781d";
 	} else if (kind = w83782d) {
@@ -1237,24 +1159,46 @@ w83781d_detect(struct i2c_adapter *adapt
 		client_name = "as99127f";
 	}
 
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(client->name, client_name, I2C_NAME_SIZE);
-	data->type = kind;
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto ERROR2;
+	strlcpy(info->type, client_name, I2C_NAME_SIZE);
+
+	return 0;
+
+ err_nodev:
+	if (isa)
+		mutex_unlock(&isa->update_lock);
+	return -ENODEV;
+}
+
+static int
+w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct w83781d_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto ERROR1;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
+	mutex_init(&data->update_lock);
+
+	data->type = id->driver_data;
+	data->client = client;
 
 	/* attach secondary i2c lm75-like clients */
-	if ((err = w83781d_detect_subclients(adapter, address,
-			kind, client)))
+	err = w83781d_detect_subclients(client);
+	if (err)
 		goto ERROR3;
 
 	/* Initialize the chip */
 	w83781d_init_device(dev);
 
 	/* Register sysfs hooks */
-	err = w83781d_create_files(dev, kind, 0);
+	err = w83781d_create_files(dev, data->type, 0);
 	if (err)
 		goto ERROR4;
 
@@ -1270,45 +1214,35 @@ ERROR4:
 	sysfs_remove_group(&dev->kobj, &w83781d_group);
 	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
 
-	if (data->lm75[1]) {
-		i2c_detach_client(data->lm75[1]);
-		kfree(data->lm75[1]);
-	}
-	if (data->lm75[0]) {
-		i2c_detach_client(data->lm75[0]);
-		kfree(data->lm75[0]);
-	}
+	if (data->lm75[0])
+		i2c_unregister_device(data->lm75[0]);
+	if (data->lm75[1])
+		i2c_unregister_device(data->lm75[1]);
 ERROR3:
-	i2c_detach_client(client);
-ERROR2:
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 ERROR1:
 	return err;
 }
 
 static int
-w83781d_detach_client(struct i2c_client *client)
+w83781d_remove(struct i2c_client *client)
 {
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	int err;
+	struct device *dev = &client->dev;
 
-	/* main client */
-	if (data) {
-		hwmon_device_unregister(data->hwmon_dev);
-		sysfs_remove_group(&client->dev.kobj, &w83781d_group);
-		sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
-	}
+	hwmon_device_unregister(data->hwmon_dev);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
+	sysfs_remove_group(&dev->kobj, &w83781d_group);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
 
-	/* main client */
-	if (data)
-		kfree(data);
+	if (data->lm75[0])
+		i2c_unregister_device(data->lm75[0]);
+	if (data->lm75[1])
+		i2c_unregister_device(data->lm75[1]);
 
-	/* subclient */
-	else
-		kfree(client);
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
 
 	return 0;
 }
@@ -1316,7 +1250,7 @@ w83781d_detach_client(struct i2c_client
 static int
 w83781d_read_value_i2c(struct w83781d_data *data, u16 reg)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int res, bank;
 	struct i2c_client *cl;
 
@@ -1356,7 +1290,7 @@ w83781d_read_value_i2c(struct w83781d_da
 static int
 w83781d_write_value_i2c(struct w83781d_data *data, u16 reg, u16 value)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int bank;
 	struct i2c_client *cl;
 
@@ -1493,7 +1427,7 @@ w83781d_init_device(struct device *dev)
 static struct w83781d_data *w83781d_update_device(struct device *dev)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -1606,6 +1540,30 @@ static struct w83781d_data *w83781d_upda
 	return data;
 }
 
+static const struct i2c_device_id w83781d_ids[] = {
+	{ "w83781d", w83781d, },
+	{ "w83782d", w83782d, },
+	{ "w83783s", w83783s, },
+	{ "as99127f", as99127f },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, w83781d_ids);
+
+static struct i2c_driver w83781d_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name = "w83781d",
+	},
+	.probe		= w83781d_probe,
+	.remove		= w83781d_remove,
+	.id_table	= w83781d_ids,
+	.detect		= w83781d_detect,
+	.address_data	= &addr_data,
+};
+
+/*
+ * ISA related code
+ */
 #ifdef CONFIG_ISA
 
 /* ISA device, if found */
@@ -1631,13 +1589,12 @@ static struct w83781d_data *w83781d_data
 /* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
 static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
 {
-	struct w83781d_data *i2c, *isa;
+	struct w83781d_data *isa;
 	int i;
 
 	if (!pdev)	/* No ISA chip */
 		return 0;
 
-	i2c = i2c_get_clientdata(client);
 	isa = platform_get_drvdata(pdev);
 
 	if (w83781d_read_value(isa, W83781D_REG_I2C_ADDR) != client->addr)
@@ -1648,14 +1605,16 @@ static int w83781d_alias_detect(struct i
 	/* We compare all the limit registers, the config register and the
 	 * interrupt mask registers */
 	for (i = 0x2b; i <= 0x3d; i++) {
-		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
+		if (w83781d_read_value(isa, i) !+		    i2c_smbus_read_byte_data(client, i))
 			return 0;
 	}
 	if (w83781d_read_value(isa, W83781D_REG_CONFIG) !-	    w83781d_read_value(i2c, W83781D_REG_CONFIG))
+	    i2c_smbus_read_byte_data(client, W83781D_REG_CONFIG))
 		return 0;
 	for (i = 0x43; i <= 0x46; i++) {
-		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
+		if (w83781d_read_value(isa, i) !+		    i2c_smbus_read_byte_data(client, i))
 			return 0;
 	}
 
@@ -1734,11 +1693,11 @@ w83781d_write_value_isa(struct w83781d_d
 static int
 w83781d_read_value(struct w83781d_data *data, u16 reg)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int res;
 
 	mutex_lock(&data->lock);
-	if (client->driver)
+	if (client)
 		res = w83781d_read_value_i2c(data, reg);
 	else
 		res = w83781d_read_value_isa(data, reg);
@@ -1749,10 +1708,10 @@ w83781d_read_value(struct w83781d_data *
 static int
 w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->lock);
-	if (client->driver)
+	if (client)
 		w83781d_write_value_i2c(data, reg, value);
 	else
 		w83781d_write_value_isa(data, reg, value);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
