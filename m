From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Aug 2011 11:42:06 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Make code more readable
Message-Id: <20110829134206.14886878@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Clean up the code to make it more readable:
* Remove reg_ and new_ prefixes from variable names, they made the
  names longer, causing extra line breaks, while not adding much
  value.
* Introduce struct device dev* = &client->dev in two functions, to
  avoid repeating client->dev everywhere in these functions.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |  143 ++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 74 deletions(-)

--- linux-3.1-rc3.orig/drivers/hwmon/lm90.c	2011-08-29 11:28:42.000000000 +0200
+++ linux-3.1-rc3/drivers/hwmon/lm90.c	2011-08-29 11:52:22.000000000 +0200
@@ -1105,39 +1105,37 @@ static DEVICE_ATTR(pec, S_IWUSR | S_IRUG
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm90_detect(struct i2c_client *new_client,
+static int lm90_detect(struct i2c_client *client,
 		       struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
-	int address = new_client->addr;
+	struct i2c_adapter *adapter = client->adapter;
+	int address = client->addr;
 	const char *name = NULL;
-	int man_id, chip_id, reg_config1, reg_config2, reg_convrate;
+	int man_id, chip_id, config1, config2, convrate;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
 	/* detection and identification */
-	man_id = i2c_smbus_read_byte_data(new_client, LM90_REG_R_MAN_ID);
-	chip_id = i2c_smbus_read_byte_data(new_client, LM90_REG_R_CHIP_ID);
-	reg_config1 = i2c_smbus_read_byte_data(new_client, LM90_REG_R_CONFIG1);
-	reg_convrate = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONVRATE);
-	if (man_id < 0 || chip_id < 0 || reg_config1 < 0 || reg_convrate < 0)
+	man_id = i2c_smbus_read_byte_data(client, LM90_REG_R_MAN_ID);
+	chip_id = i2c_smbus_read_byte_data(client, LM90_REG_R_CHIP_ID);
+	config1 = i2c_smbus_read_byte_data(client, LM90_REG_R_CONFIG1);
+	convrate = i2c_smbus_read_byte_data(client, LM90_REG_R_CONVRATE);
+	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0)
 		return -ENODEV;
 
 	if (man_id = 0x01 || man_id = 0x5C || man_id = 0x41) {
-		reg_config2 = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONFIG2);
-		if (reg_config2 < 0)
+		config2 = i2c_smbus_read_byte_data(client, LM90_REG_R_CONFIG2);
+		if (config2 < 0)
 			return -ENODEV;
 	} else
-		reg_config2 = 0;	/* Make compiler happy */
+		config2 = 0;		/* Make compiler happy */
 
 	if ((address = 0x4C || address = 0x4D)
 	 && man_id = 0x01) { /* National Semiconductor */
-		if ((reg_config1 & 0x2A) = 0x00
-		 && (reg_config2 & 0xF8) = 0x00
-		 && reg_convrate <= 0x09) {
+		if ((config1 & 0x2A) = 0x00
+		 && (config2 & 0xF8) = 0x00
+		 && convrate <= 0x09) {
 			if (address = 0x4C
 			 && (chip_id & 0xF0) = 0x20) { /* LM90 */
 				name = "lm90";
@@ -1161,8 +1159,8 @@ static int lm90_detect(struct i2c_client
 	if ((address = 0x4C || address = 0x4D)
 	 && man_id = 0x41) { /* Analog Devices */
 		if ((chip_id & 0xF0) = 0x40 /* ADM1032 */
-		 && (reg_config1 & 0x3F) = 0x00
-		 && reg_convrate <= 0x0A) {
+		 && (config1 & 0x3F) = 0x00
+		 && convrate <= 0x0A) {
 			name = "adm1032";
 			/* The ADM1032 supports PEC, but only if combined
 			   transactions are not used. */
@@ -1171,18 +1169,18 @@ static int lm90_detect(struct i2c_client
 				info->flags |= I2C_CLIENT_PEC;
 		} else
 		if (chip_id = 0x51 /* ADT7461 */
-		 && (reg_config1 & 0x1B) = 0x00
-		 && reg_convrate <= 0x0A) {
+		 && (config1 & 0x1B) = 0x00
+		 && convrate <= 0x0A) {
 			name = "adt7461";
 		} else
 		if (chip_id = 0x57 /* ADT7461A, NCT1008 */
-		 && (reg_config1 & 0x1B) = 0x00
-		 && reg_convrate <= 0x0A) {
+		 && (config1 & 0x1B) = 0x00
+		 && convrate <= 0x0A) {
 			name = "adt7461a";
 		}
 	} else
 	if (man_id = 0x4D) { /* Maxim */
-		int reg_emerg, reg_emerg2, reg_status2;
+		int emerg, emerg2, status2;
 
 		/*
 		 * We read MAX6659_REG_R_REMOTE_EMERG twice, and re-read
@@ -1190,16 +1188,15 @@ static int lm90_detect(struct i2c_client
 		 * exists, both readings will reflect the same value. Otherwise,
 		 * the readings will be different.
 		 */
-		reg_emerg = i2c_smbus_read_byte_data(new_client,
-						  MAX6659_REG_R_REMOTE_EMERG);
-		man_id = i2c_smbus_read_byte_data(new_client,
+		emerg = i2c_smbus_read_byte_data(client,
+						 MAX6659_REG_R_REMOTE_EMERG);
+		man_id = i2c_smbus_read_byte_data(client,
 						  LM90_REG_R_MAN_ID);
-		reg_emerg2 = i2c_smbus_read_byte_data(new_client,
+		emerg2 = i2c_smbus_read_byte_data(client,
 						  MAX6659_REG_R_REMOTE_EMERG);
-		reg_status2 = i2c_smbus_read_byte_data(new_client,
-						       MAX6696_REG_R_STATUS2);
-		if (reg_emerg < 0 || man_id < 0 || reg_emerg2 < 0
-		 || reg_status2 < 0)
+		status2 = i2c_smbus_read_byte_data(client,
+						   MAX6696_REG_R_STATUS2);
+		if (emerg < 0 || man_id < 0 || emerg2 < 0 || status2 < 0)
 			return -ENODEV;
 
 		/*
@@ -1217,8 +1214,8 @@ static int lm90_detect(struct i2c_client
 		 */
 		if (chip_id = man_id
 		 && (address = 0x4C || address = 0x4D || address = 0x4E)
-		 && (reg_config1 & 0x1F) = (man_id & 0x0F)
-		 && reg_convrate <= 0x09) {
+		 && (config1 & 0x1F) = (man_id & 0x0F)
+		 && convrate <= 0x09) {
 			if (address = 0x4C)
 				name = "max6657";
 			else
@@ -1236,10 +1233,10 @@ static int lm90_detect(struct i2c_client
 		 * one of those registers exists.
 		 */
 		if (chip_id = 0x01
-		 && (reg_config1 & 0x10) = 0x00
-		 && (reg_status2 & 0x01) = 0x00
-		 && reg_emerg = reg_emerg2
-		 && reg_convrate <= 0x07) {
+		 && (config1 & 0x10) = 0x00
+		 && (status2 & 0x01) = 0x00
+		 && emerg = emerg2
+		 && convrate <= 0x07) {
 			name = "max6696";
 		} else
 		/*
@@ -1249,8 +1246,8 @@ static int lm90_detect(struct i2c_client
 		 * second to last bit of config1 (software reset).
 		 */
 		if (chip_id = 0x01
-		 && (reg_config1 & 0x03) = 0x00
-		 && reg_convrate <= 0x07) {
+		 && (config1 & 0x03) = 0x00
+		 && convrate <= 0x07) {
 			name = "max6680";
 		} else
 		/*
@@ -1259,21 +1256,21 @@ static int lm90_detect(struct i2c_client
 		 * register are unused and should return zero when read.
 		 */
 		if (chip_id = 0x59
-		 && (reg_config1 & 0x3f) = 0x00
-		 && reg_convrate <= 0x07) {
+		 && (config1 & 0x3f) = 0x00
+		 && convrate <= 0x07) {
 			name = "max6646";
 		}
 	} else
 	if (address = 0x4C
 	 && man_id = 0x5C) { /* Winbond/Nuvoton */
-		if ((reg_config1 & 0x2A) = 0x00
-		 && (reg_config2 & 0xF8) = 0x00) {
+		if ((config1 & 0x2A) = 0x00
+		 && (config2 & 0xF8) = 0x00) {
 			if (chip_id = 0x01 /* W83L771W/G */
-			 && reg_convrate <= 0x09) {
+			 && convrate <= 0x09) {
 				name = "w83l771";
 			} else
 			if ((chip_id & 0xFE) = 0x10 /* W83L771AWG/ASG */
-			 && reg_convrate <= 0x08) {
+			 && convrate <= 0x08) {
 				name = "w83l771";
 			}
 		}
@@ -1281,9 +1278,9 @@ static int lm90_detect(struct i2c_client
 	if (address >= 0x48 && address <= 0x4F
 	 && man_id = 0xA1) { /*  NXP Semiconductor/Philips */
 		if (chip_id = 0x00
-		 && (reg_config1 & 0x2A) = 0x00
-		 && (reg_config2 & 0xFE) = 0x00
-		 && reg_convrate <= 0x09) {
+		 && (config1 & 0x2A) = 0x00
+		 && (config2 & 0xFE) = 0x00
+		 && convrate <= 0x09) {
 			name = "sa56004";
 		}
 	}
@@ -1302,19 +1299,18 @@ static int lm90_detect(struct i2c_client
 
 static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
 {
+	struct device *dev = &client->dev;
+
 	if (data->flags & LM90_HAVE_TEMP3)
-		sysfs_remove_group(&client->dev.kobj, &lm90_temp3_group);
+		sysfs_remove_group(&dev->kobj, &lm90_temp3_group);
 	if (data->flags & LM90_HAVE_EMERGENCY_ALARM)
-		sysfs_remove_group(&client->dev.kobj,
-				   &lm90_emergency_alarm_group);
+		sysfs_remove_group(&dev->kobj, &lm90_emergency_alarm_group);
 	if (data->flags & LM90_HAVE_EMERGENCY)
-		sysfs_remove_group(&client->dev.kobj,
-				   &lm90_emergency_group);
+		sysfs_remove_group(&dev->kobj, &lm90_emergency_group);
 	if (data->flags & LM90_HAVE_OFFSET)
-		device_remove_file(&client->dev,
-				   &sensor_dev_attr_temp2_offset.dev_attr);
-	device_remove_file(&client->dev, &dev_attr_pec);
-	sysfs_remove_group(&client->dev.kobj, &lm90_group);
+		device_remove_file(dev, &sensor_dev_attr_temp2_offset.dev_attr);
+	device_remove_file(dev, &dev_attr_pec);
+	sysfs_remove_group(&dev->kobj, &lm90_group);
 }
 
 static void lm90_init_client(struct i2c_client *client)
@@ -1363,10 +1359,11 @@ static void lm90_init_client(struct i2c_
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
 }
 
-static int lm90_probe(struct i2c_client *new_client,
+static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(new_client->dev.parent);
+	struct device *dev = &client->dev;
+	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
 	struct lm90_data *data;
 	int err;
 
@@ -1375,14 +1372,14 @@ static int lm90_probe(struct i2c_client
 		err = -ENOMEM;
 		goto exit;
 	}
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
 	/* Set the device type */
 	data->kind = id->driver_data;
 	if (data->kind = adm1032) {
 		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-			new_client->flags &= ~I2C_CLIENT_PEC;
+			client->flags &= ~I2C_CLIENT_PEC;
 	}
 
 	/* Different devices have different alarm bits triggering the
@@ -1397,43 +1394,41 @@ static int lm90_probe(struct i2c_client
 	data->max_convrate = lm90_params[data->kind].max_convrate;
 
 	/* Initialize the LM90 chip */
-	lm90_init_client(new_client);
+	lm90_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm90_group);
+	err = sysfs_create_group(&dev->kobj, &lm90_group);
 	if (err)
 		goto exit_free;
-	if (new_client->flags & I2C_CLIENT_PEC) {
-		err = device_create_file(&new_client->dev, &dev_attr_pec);
+	if (client->flags & I2C_CLIENT_PEC) {
+		err = device_create_file(dev, &dev_attr_pec);
 		if (err)
 			goto exit_remove_files;
 	}
 	if (data->flags & LM90_HAVE_OFFSET) {
-		err = device_create_file(&new_client->dev,
+		err = device_create_file(dev,
 					&sensor_dev_attr_temp2_offset.dev_attr);
 		if (err)
 			goto exit_remove_files;
 	}
 	if (data->flags & LM90_HAVE_EMERGENCY) {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm90_emergency_group);
+		err = sysfs_create_group(&dev->kobj, &lm90_emergency_group);
 		if (err)
 			goto exit_remove_files;
 	}
 	if (data->flags & LM90_HAVE_EMERGENCY_ALARM) {
-		err = sysfs_create_group(&new_client->dev.kobj,
+		err = sysfs_create_group(&dev->kobj,
 					 &lm90_emergency_alarm_group);
 		if (err)
 			goto exit_remove_files;
 	}
 	if (data->flags & LM90_HAVE_TEMP3) {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm90_temp3_group);
+		err = sysfs_create_group(&dev->kobj, &lm90_temp3_group);
 		if (err)
 			goto exit_remove_files;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
@@ -1442,7 +1437,7 @@ static int lm90_probe(struct i2c_client
 	return 0;
 
 exit_remove_files:
-	lm90_remove_files(new_client, data);
+	lm90_remove_files(client, data);
 exit_free:
 	kfree(data);
 exit:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
