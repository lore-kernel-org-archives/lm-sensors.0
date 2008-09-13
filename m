From: Wolfgang Grandegger <wg@grandegger.com>
Date: Sat, 13 Sep 2008 08:55:22 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: w83781d: use new style driver
Message-Id: <48CB7FFA.10202@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch modifies the w83781d driver to use new style driver binding.
Substantial code modifications are required to deal with the new
interface, especially legacy device detection.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/hwmon/w83781d.c |  615 +++++++++++++++++++++---------------------------
 1 file changed, 278 insertions(+), 337 deletions(-)

Index: linux-2.6-denx/drivers/hwmon/w83781d.c
=================================--- linux-2.6-denx.orig/drivers/hwmon/w83781d.c
+++ linux-2.6-denx/drivers/hwmon/w83781d.c
@@ -205,7 +205,7 @@ DIV_TO_REG(long val, enum chips type)
 /* For ISA chips, we abuse the i2c_client addr and name fields. We also use
    the driver field to differentiate between I2C and ISA chips. */
 struct w83781d_data {
-	struct i2c_client client;
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
@@ -240,25 +240,11 @@ struct w83781d_data {
 	u8 vrm;
 };
 
-static struct w83781d_data *w83781d_data_if_isa(void);
-static int w83781d_alias_detect(struct i2c_client *client, u8 chipid);
-
-static int w83781d_attach_adapter(struct i2c_adapter *adapter);
-static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
-static int w83781d_detach_client(struct i2c_client *client);
+static int w83781d_alias_detect(struct i2c_client *client);
 
 static int w83781d_read_value(struct w83781d_data *data, u16 reg);
 static int w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
-static void w83781d_init_device(struct device *dev);
-
-static struct i2c_driver w83781d_driver = {
-	.driver = {
-		.name = "w83781d",
-	},
-	.attach_adapter = w83781d_attach_adapter,
-	.detach_client = w83781d_detach_client,
-};
 
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
@@ -821,46 +807,16 @@ static SENSOR_DEVICE_ATTR(temp2_type, S_
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
-	int i, val1 = 0, id;
-	int err;
-	const char *client_name = "";
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
-
-	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!(data->lm75[0])) {
-		err = -ENOMEM;
-		goto ERROR_SC_0;
-	}
+	struct i2c_adapter *adapter = new_client->adapter;
+	int i, val1 = 0, id, err;
+	int address = new_client->addr;
 
 	id = i2c_adapter_id(adapter);
 
@@ -872,31 +828,39 @@ w83781d_detect_subclients(struct i2c_ada
 					"address %d; must be 0x48-0x4f\n",
 					force_subclients[i]);
 				err = -EINVAL;
-				goto ERROR_SC_1;
+				goto ERROR_SC_0;
 			}
 		}
 		w83781d_write_value(data, W83781D_REG_I2C_SUBADDR,
 				(force_subclients[2] & 0x07) |
 				((force_subclients[3] & 0x07) << 4));
-		data->lm75[0]->addr = force_subclients[2];
+		data->lm75[0] = i2c_new_dummy(adapter, force_subclients[2]);
 	} else {
 		val1 = w83781d_read_value(data, W83781D_REG_I2C_SUBADDR);
-		data->lm75[0]->addr = 0x48 + (val1 & 0x07);
+		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val1 & 0x07));
+	}
+	if (!data->lm75[0]) {
+		dev_err(&new_client->dev,
+			"subclient 0 registration failed\n");
+		err = -ENOMEM;
+		goto ERROR_SC_0;
 	}
 
-	if (kind != w83783s) {
-		data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-		if (!(data->lm75[1])) {
+	if (data->type != w83783s) {
+		if (force_subclients[0] = id &&
+		    force_subclients[1] = address)
+			data->lm75[1] +				i2c_new_dummy(adapter, force_subclients[3]);
+		else
+			data->lm75[1] +				i2c_new_dummy(adapter,
+					      0x48 + ((val1 >> 4) & 0x07));
+		if (!data->lm75[1]) {
+			dev_err(&new_client->dev,
+				"subclient 1 registration failed\n");
 			err = -ENOMEM;
 			goto ERROR_SC_1;
 		}
-
-		if (force_subclients[0] = id &&
-		    force_subclients[1] = address) {
-			data->lm75[1]->addr = force_subclients[3];
-		} else {
-			data->lm75[1]->addr = 0x48 + ((val1 >> 4) & 0x07);
-		}
 		if (data->lm75[0]->addr = data->lm75[1]->addr) {
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
@@ -905,45 +869,13 @@ w83781d_detect_subclients(struct i2c_ada
 			goto ERROR_SC_2;
 		}
 	}
-
-	if (kind = w83781d)
-		client_name = "w83781d subclient";
-	else if (kind = w83782d)
-		client_name = "w83782d subclient";
-	else if (kind = w83783s)
-		client_name = "w83783s subclient";
-	else if (kind = as99127f)
-		client_name = "as99127f subclient";
-
-	for (i = 0; i <= 1; i++) {
-		/* store all data in w83781d */
-		i2c_set_clientdata(data->lm75[i], NULL);
-		data->lm75[i]->adapter = adapter;
-		data->lm75[i]->driver = &w83781d_driver;
-		data->lm75[i]->flags = 0;
-		strlcpy(data->lm75[i]->name, client_name,
-			I2C_NAME_SIZE);
-		if ((err = i2c_attach_client(data->lm75[i]))) {
-			dev_err(&new_client->dev, "Subclient %d "
-				"registration at address 0x%x "
-				"failed.\n", i, data->lm75[i]->addr);
-			if (i = 1)
-				goto ERROR_SC_3;
-			goto ERROR_SC_2;
-		}
-		if (kind = w83783s)
-			break;
-	}
-
 	return 0;
 
-/* Undo inits in case of errors */
-ERROR_SC_3:
-	i2c_detach_client(data->lm75[0]);
+	/* Undo inits in case of errors */
 ERROR_SC_2:
-	kfree(data->lm75[1]);
+	i2c_unregister_device(data->lm75[1]);
 ERROR_SC_1:
-	kfree(data->lm75[0]);
+	i2c_unregister_device(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
@@ -1111,216 +1043,11 @@ w83781d_create_files(struct device *dev,
 }
 
 static int
-w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	int val1 = 0, val2;
-	struct i2c_client *client;
-	struct device *dev;
-	struct w83781d_data *data;
-	int err;
-	const char *client_name = "";
-	enum vendor { winbond, asus } vendid;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		err = -EINVAL;
-		goto ERROR1;
-	}
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access w83781d_{read,write}_value. */
-
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
-
-	/* The w8378?d may be stuck in some other bank than bank 0. This may
-	   make reading other information impossible. Specify a force=... or
-	   force_*=... parameter, and the Winbond will be reset to the right
-	   bank. */
-	if (kind < 0) {
-		if (w83781d_read_value(data, W83781D_REG_CONFIG) & 0x80) {
-			dev_dbg(&adapter->dev, "Detection of w83781d chip "
-				"failed at step 3\n");
-			err = -ENODEV;
-			goto ERROR2;
-		}
-		val1 = w83781d_read_value(data, W83781D_REG_BANK);
-		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
-		/* Check for Winbond or Asus ID if in bank 0 */
-		if ((!(val1 & 0x07)) &&
-		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
-		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
-			dev_dbg(&adapter->dev, "Detection of w83781d chip "
-				"failed at step 4\n");
-			err = -ENODEV;
-			goto ERROR2;
-		}
-		/* If Winbond SMBus, check address at 0x48.
-		   Asus doesn't support, except for as99127f rev.2 */
-		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
-		    ((val1 & 0x80) && (val2 = 0x5c))) {
-			if (w83781d_read_value
-			    (data, W83781D_REG_I2C_ADDR) != address) {
-				dev_dbg(&adapter->dev, "Detection of w83781d "
-					"chip failed at step 5\n");
-				err = -ENODEV;
-				goto ERROR2;
-			}
-		}
-	}
-
-	/* We have either had a force parameter, or we have already detected the
-	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
-	w83781d_write_value(data, W83781D_REG_BANK,
-			    (w83781d_read_value(data, W83781D_REG_BANK)
-			     & 0x78) | 0x80);
-
-	/* Determine the chip type. */
-	if (kind <= 0) {
-		/* get vendor ID */
-		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
-		if (val2 = 0x5c)
-			vendid = winbond;
-		else if (val2 = 0x12)
-			vendid = asus;
-		else {
-			dev_dbg(&adapter->dev, "w83781d chip vendor is "
-				"neither Winbond nor Asus\n");
-			err = -ENODEV;
-			goto ERROR2;
-		}
-
-		val1 = w83781d_read_value(data, W83781D_REG_WCHIPID);
-		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
-			kind = w83781d;
-		else if (val1 = 0x30 && vendid = winbond)
-			kind = w83782d;
-		else if (val1 = 0x40 && vendid = winbond && address = 0x2d)
-			kind = w83783s;
-		else if (val1 = 0x31)
-			kind = as99127f;
-		else {
-			if (kind = 0)
-				dev_warn(&adapter->dev, "Ignoring 'force' "
-					 "parameter for unknown chip at "
-					 "address 0x%02x\n", address);
-			err = -EINVAL;
-			goto ERROR2;
-		}
-
-		if ((kind = w83781d || kind = w83782d)
-		 && w83781d_alias_detect(client, val1)) {
-			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
-				"be the same as ISA device\n", address);
-			err = -ENODEV;
-			goto ERROR2;
-		}
-	}
-
-	if (kind = w83781d) {
-		client_name = "w83781d";
-	} else if (kind = w83782d) {
-		client_name = "w83782d";
-	} else if (kind = w83783s) {
-		client_name = "w83783s";
-	} else if (kind = as99127f) {
-		client_name = "as99127f";
-	}
-
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(client->name, client_name, I2C_NAME_SIZE);
-	data->type = kind;
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto ERROR2;
-
-	/* attach secondary i2c lm75-like clients */
-	if ((err = w83781d_detect_subclients(adapter, address,
-			kind, client)))
-		goto ERROR3;
-
-	/* Initialize the chip */
-	w83781d_init_device(dev);
-
-	/* Register sysfs hooks */
-	err = w83781d_create_files(dev, kind, 0);
-	if (err)
-		goto ERROR4;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto ERROR4;
-	}
-
-	return 0;
-
-ERROR4:
-	sysfs_remove_group(&dev->kobj, &w83781d_group);
-	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
-
-	if (data->lm75[1]) {
-		i2c_detach_client(data->lm75[1]);
-		kfree(data->lm75[1]);
-	}
-	if (data->lm75[0]) {
-		i2c_detach_client(data->lm75[0]);
-		kfree(data->lm75[0]);
-	}
-ERROR3:
-	i2c_detach_client(client);
-ERROR2:
-	kfree(data);
-ERROR1:
-	return err;
-}
-
-static int
-w83781d_detach_client(struct i2c_client *client)
+w83781d_read_value_i2c(struct i2c_client *client, u16 reg)
 {
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	int err;
-
-	/* main client */
-	if (data) {
-		hwmon_device_unregister(data->hwmon_dev);
-		sysfs_remove_group(&client->dev.kobj, &w83781d_group);
-		sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
-	}
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	/* main client */
-	if (data)
-		kfree(data);
-
-	/* subclient */
-	else
-		kfree(client);
-
-	return 0;
-}
-
-static int
-w83781d_read_value_i2c(struct w83781d_data *data, u16 reg)
-{
-	struct i2c_client *client = &data->client;
-	int res, bank;
 	struct i2c_client *cl;
+	int res = 0, bank;
 
 	bank = (reg >> 8) & 0x0f;
 	if (bank > 2)
@@ -1329,7 +1056,7 @@ w83781d_read_value_i2c(struct w83781d_da
 					  bank);
 	if (bank = 0 || bank > 2) {
 		res = i2c_smbus_read_byte_data(client, reg & 0xff);
-	} else {
+	} else if (data) {
 		/* switch to subclient */
 		cl = data->lm75[bank - 1];
 		/* convert from ISA to LM75 I2C addresses */
@@ -1356,9 +1083,9 @@ w83781d_read_value_i2c(struct w83781d_da
 }
 
 static int
-w83781d_write_value_i2c(struct w83781d_data *data, u16 reg, u16 value)
+w83781d_write_value_i2c(struct i2c_client *client, u16 reg, u16 value)
 {
-	struct i2c_client *client = &data->client;
+	struct w83781d_data *data = i2c_get_clientdata(client);
 	struct i2c_client *cl;
 	int bank;
 
@@ -1370,7 +1097,7 @@ w83781d_write_value_i2c(struct w83781d_d
 	if (bank = 0 || bank > 2) {
 		i2c_smbus_write_byte_data(client, reg & 0xff,
 					  value & 0xff);
-	} else {
+	} else if (data) {
 		/* switch to subclient */
 		cl = data->lm75[bank - 1];
 		/* convert from ISA to LM75 I2C addresses */
@@ -1495,7 +1222,7 @@ w83781d_init_device(struct device *dev)
 static struct w83781d_data *w83781d_update_device(struct device *dev)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -1608,6 +1335,225 @@ static struct w83781d_data *w83781d_upda
 	return data;
 }
 
+static int
+w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
+	struct w83781d_data *data;
+	int err;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		err = -EINVAL;
+		goto ERROR1;
+	}
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
+
+	if ((data->type = w83781d || data->type = w83782d) &&
+	    w83781d_alias_detect(client)) {
+		dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
+			"be the same as ISA device\n", client->addr);
+		err = -ENODEV;
+		goto ERROR1;
+	}
+
+	/* attach secondary i2c lm75-like clients */
+	err = w83781d_detect_subclients(client);
+	if (err)
+		goto ERROR2;
+
+	/* Initialize the chip */
+	w83781d_init_device(dev);
+
+	/* Register sysfs hooks */
+	err = w83781d_create_files(dev, data->type, 0);
+	if (err)
+		goto ERROR3;
+
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto ERROR3;
+	}
+
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		 data->hwmon_dev->bus_id, client->name);
+
+	return 0;
+
+ERROR3:
+	sysfs_remove_group(&dev->kobj, &w83781d_group);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
+
+	if (data->lm75[1])
+		i2c_unregister_device(data->lm75[0]);
+	if (data->lm75[1])
+		i2c_unregister_device(data->lm75[1]);
+ERROR2:
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
+ERROR1:
+	return err;
+}
+
+static int w83781d_remove(struct i2c_client *client)
+{
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
+
+	hwmon_device_unregister(data->hwmon_dev);
+
+	sysfs_remove_group(&dev->kobj, &w83781d_group);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
+
+	if (data->lm75[1])
+		i2c_unregister_device(data->lm75[0]);
+	if (data->lm75[1])
+		i2c_unregister_device(data->lm75[1]);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
+
+	return 0;
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int  w83781d_detect(struct i2c_client *client, int kind,
+			   struct i2c_board_info *info)
+{
+	int val1 = 0, val2;
+	struct i2c_adapter *adapter = client->adapter;
+	int address = client->addr;
+	const char *client_name = "";
+	enum vendor { winbond, asus } vendid;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/* The w8378?d may be stuck in some other bank than bank 0. This may
+	   make reading other information impossible. Specify a force=... or
+	   force_*=... parameter, and the Winbond will be reset to the right
+	   bank. */
+	if (kind < 0) {
+		if (w83781d_read_value_i2c(client, W83781D_REG_CONFIG) & 0x80) {
+			dev_dbg(&adapter->dev, "Detection of w83781d chip "
+				"failed at step 3\n");
+			return -ENODEV;
+		}
+		val1 = w83781d_read_value_i2c(client, W83781D_REG_BANK);
+		val2 = w83781d_read_value_i2c(client, W83781D_REG_CHIPMAN);
+		/* Check for Winbond or Asus ID if in bank 0 */
+		if ((!(val1 & 0x07)) &&
+		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
+		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
+			dev_dbg(&adapter->dev, "Detection of w83781d chip "
+				"failed at step 4\n");
+			return -ENODEV;
+		}
+		/* If Winbond SMBus, check address at 0x48.
+		   Asus doesn't support, except for as99127f rev.2 */
+		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
+		    ((val1 & 0x80) && (val2 = 0x5c))) {
+			if (w83781d_read_value_i2c
+			    (client, W83781D_REG_I2C_ADDR) != address) {
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 5\n");
+				return -ENODEV;
+			}
+		}
+	}
+
+	/* We have either had a force parameter, or we have already detected the
+	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
+	w83781d_write_value_i2c(client, W83781D_REG_BANK,
+		(w83781d_read_value_i2c(client, W83781D_REG_BANK)
+		 & 0x78) | 0x80);
+
+	/* Determine the chip type. */
+	if (kind <= 0) {
+		/* get vendor ID */
+		val2 = w83781d_read_value_i2c(client, W83781D_REG_CHIPMAN);
+		if (val2 = 0x5c)
+			vendid = winbond;
+		else if (val2 = 0x12)
+			vendid = asus;
+		else {
+			dev_dbg(&adapter->dev, "w83781d chip vendor is "
+				"neither Winbond nor Asus\n");
+			return -ENODEV;
+		}
+
+		val1 = w83781d_read_value_i2c(client, W83781D_REG_WCHIPID);
+		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
+			kind = w83781d;
+		else if (val1 = 0x30 && vendid = winbond)
+			kind = w83782d;
+		else if (val1 = 0x40 && vendid = winbond && address = 0x2d)
+			kind = w83783s;
+		else if (val1 = 0x31)
+			kind = as99127f;
+		else {
+			if (kind = 0)
+				dev_warn(&adapter->dev, "Ignoring 'force' "
+					 "parameter for unknown chip at "
+					 "address 0x%02x\n", address);
+			return -ENODEV;
+		}
+	}
+
+	if (kind = w83781d)
+		client_name = "w83781d";
+	else if (kind = w83782d)
+		client_name = "w83782d";
+	else if (kind = w83783s)
+		client_name = "w83783s";
+	else if (kind = as99127f)
+		client_name = "as99127f";
+	else
+		return -ENODEV;
+
+	/* Fill in the remaining client fields and put into the global list */
+	strlcpy(info->type, client_name, I2C_NAME_SIZE);
+
+	return 0;
+}
+
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
@@ -1621,19 +1567,15 @@ static ssize_t
 show_name(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", data->client.name);
+	return sprintf(buf, "%s\n", data->client->name);
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static struct w83781d_data *w83781d_data_if_isa(void)
-{
-	return pdev ? platform_get_drvdata(pdev) : NULL;
-}
-
 /* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
-static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
+static int w83781d_alias_detect(struct i2c_client *client)
 {
 	struct w83781d_data *i2c, *isa;
+	u8 chipid;
 	int i;
 
 	if (!pdev)	/* No ISA chip */
@@ -1644,6 +1586,7 @@ static int w83781d_alias_detect(struct i
 
 	if (w83781d_read_value(isa, W83781D_REG_I2C_ADDR) != client->addr)
 		return 0;	/* Address doesn't match */
+	chipid = w83781d_read_value(i2c, W83781D_REG_WCHIPID);
 	if (w83781d_read_value(isa, W83781D_REG_WCHIPID) != chipid)
 		return 0;	/* Chip type doesn't match */
 
@@ -1667,7 +1610,7 @@ static int w83781d_alias_detect(struct i
 static int
 w83781d_read_value_isa(struct w83781d_data *data, u16 reg)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int word_sized, res;
 
 	word_sized = (((reg & 0xff00) = 0x100)
@@ -1701,7 +1644,7 @@ w83781d_read_value_isa(struct w83781d_da
 static void
 w83781d_write_value_isa(struct w83781d_data *data, u16 reg, u16 value)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int word_sized;
 
 	word_sized = (((reg & 0xff00) = 0x100)
@@ -1738,12 +1681,12 @@ w83781d_write_value_isa(struct w83781d_d
 static int
 w83781d_read_value(struct w83781d_data *data, u16 reg)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int res;
 
 	mutex_lock(&data->lock);
 	if (client->driver)
-		res = w83781d_read_value_i2c(data, reg);
+		res = w83781d_read_value_i2c(client, reg);
 	else
 		res = w83781d_read_value_isa(data, reg);
 	mutex_unlock(&data->lock);
@@ -1753,11 +1696,11 @@ w83781d_read_value(struct w83781d_data *
 static int
 w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
 {
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->lock);
 	if (client->driver)
-		w83781d_write_value_i2c(data, reg, value);
+		w83781d_write_value_i2c(client, reg, value);
 	else
 		w83781d_write_value_isa(data, reg, value);
 	mutex_unlock(&data->lock);
@@ -1786,8 +1729,8 @@ w83781d_isa_probe(struct platform_device
 		goto exit_release_region;
 	}
 	mutex_init(&data->lock);
-	data->client.addr = res->start;
-	i2c_set_clientdata(&data->client, data);
+	data->client->addr = res->start;
+	i2c_set_clientdata(data->client, data);
 	platform_set_drvdata(pdev, data);
 
 	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
@@ -1800,7 +1743,7 @@ w83781d_isa_probe(struct platform_device
 		data->type = w83781d;
 		name = "w83781d";
 	}
-	strlcpy(data->client.name, name, I2C_NAME_SIZE);
+	strlcpy(data->client->name, name, I2C_NAME_SIZE);
 
 	/* Initialize the W83781D chip */
 	w83781d_init_device(&pdev->dev);
@@ -1842,7 +1785,7 @@ w83781d_isa_remove(struct platform_devic
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
+	release_region(data->client->addr + W83781D_ADDR_REG_OFFSET, 2);
 	kfree(data);
 
 	return 0;
@@ -2027,13 +1970,8 @@ w83781d_isa_unregister(void)
 }
 #else /* !CONFIG_ISA */
 
-static struct w83781d_data *w83781d_data_if_isa(void)
-{
-	return NULL;
-}
-
 static int
-w83781d_alias_detect(struct i2c_client *client, u8 chipid)
+w83781d_alias_detect(struct i2c_client *client)
 {
 	return 0;
 }
@@ -2041,10 +1979,11 @@ w83781d_alias_detect(struct i2c_client *
 static int
 w83781d_read_value(struct w83781d_data *data, u16 reg)
 {
+	struct i2c_client *client = data->client;
 	int res;
 
 	mutex_lock(&data->lock);
-	res = w83781d_read_value_i2c(data, reg);
+	res = w83781d_read_value_i2c(client, reg);
 	mutex_unlock(&data->lock);
 
 	return res;
@@ -2053,8 +1992,10 @@ w83781d_read_value(struct w83781d_data *
 static int
 w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
 {
+	struct i2c_client *client = data->client;
+
 	mutex_lock(&data->lock);
-	w83781d_write_value_i2c(data, reg, value);
+	w83781d_write_value_i2c(client, reg, value);
 	mutex_unlock(&data->lock);
 
 	return 0;
@@ -2089,9 +2030,9 @@ sensors_w83781d_init(void)
 
 	return 0;
 
- exit_unreg_isa:
+exit_unreg_isa:
 	w83781d_isa_unregister();
- exit:
+exit:
 	return res;
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
