From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 20:53:45 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm63) Reorganize the code
Message-Id: <20120126215345.3eb84ccd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions and driver declaration to no longer need to
forward-declare functions. Also rename new_client to just client
everywhere for readability.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm63.c |  393 +++++++++++++++++++++++---------------------------
 1 file changed, 187 insertions(+), 206 deletions(-)

--- linux-3.3-rc1.orig/drivers/hwmon/lm63.c	2012-01-20 14:06:38.000000000 +0100
+++ linux-3.3-rc1/drivers/hwmon/lm63.c	2012-01-26 15:48:42.285145256 +0100
@@ -148,46 +148,9 @@ static const unsigned short normal_i2c[]
 #define UPDATE_INTERVAL(max, rate) \
 			((1000 << (LM63_MAX_CONVRATE - (rate))) / (max))
 
-/*
- * Functions declaration
- */
-
-static int lm63_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int lm63_remove(struct i2c_client *client);
-
-static struct lm63_data *lm63_update_device(struct device *dev);
-
-static int lm63_detect(struct i2c_client *client, struct i2c_board_info *info);
-static void lm63_init_client(struct i2c_client *client);
-
 enum chips { lm63, lm64, lm96163 };
 
 /*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id lm63_id[] = {
-	{ "lm63", lm63 },
-	{ "lm64", lm64 },
-	{ "lm96163", lm96163 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm63_id);
-
-static struct i2c_driver lm63_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm63",
-	},
-	.probe		= lm63_probe,
-	.remove		= lm63_remove,
-	.id_table	= lm63_id,
-	.detect		= lm63_detect,
-	.address_list	= normal_i2c,
-};
-
-/*
  * Client data (each client gets its own)
  */
 
@@ -242,6 +205,99 @@ static inline int lut_temp_from_reg(stru
 	return data->temp8[nr] * (data->lut_temp_highres ? 500 : 1000);
 }
 
+static struct lm63_data *lm63_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	unsigned long next_update;
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	next_update = data->last_updated
+	  + msecs_to_jiffies(data->update_interval) + 1;
+
+	if (time_after(jiffies, next_update) || !data->valid) {
+		if (data->config & 0x04) { /* tachometer enabled  */
+			/* order matters for fan1_input */
+			data->fan[0] = i2c_smbus_read_byte_data(client,
+				       LM63_REG_TACH_COUNT_LSB) & 0xFC;
+			data->fan[0] |= i2c_smbus_read_byte_data(client,
+					LM63_REG_TACH_COUNT_MSB) << 8;
+			data->fan[1] = (i2c_smbus_read_byte_data(client,
+					LM63_REG_TACH_LIMIT_LSB) & 0xFC)
+				     | (i2c_smbus_read_byte_data(client,
+					LM63_REG_TACH_LIMIT_MSB) << 8);
+		}
+
+		data->pwm1_freq = i2c_smbus_read_byte_data(client,
+				  LM63_REG_PWM_FREQ);
+		if (data->pwm1_freq = 0)
+			data->pwm1_freq = 1;
+		data->pwm1[0] = i2c_smbus_read_byte_data(client,
+				LM63_REG_PWM_VALUE);
+
+		data->temp8[0] = i2c_smbus_read_byte_data(client,
+				 LM63_REG_LOCAL_TEMP);
+		data->temp8[1] = i2c_smbus_read_byte_data(client,
+				 LM63_REG_LOCAL_HIGH);
+
+		/* order matters for temp2_input */
+		data->temp11[0] = i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_TEMP_MSB) << 8;
+		data->temp11[0] |= i2c_smbus_read_byte_data(client,
+				   LM63_REG_REMOTE_TEMP_LSB);
+		data->temp11[1] = (i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_LOW_MSB) << 8)
+				| i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_LOW_LSB);
+		data->temp11[2] = (i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_HIGH_MSB) << 8)
+				| i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_HIGH_LSB);
+		data->temp11[3] = (i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_OFFSET_MSB) << 8)
+				| i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_OFFSET_LSB);
+
+		if (data->kind = lm96163)
+			data->temp11u = (i2c_smbus_read_byte_data(client,
+					LM96163_REG_REMOTE_TEMP_U_MSB) << 8)
+				      | i2c_smbus_read_byte_data(client,
+					LM96163_REG_REMOTE_TEMP_U_LSB);
+
+		data->temp8[2] = i2c_smbus_read_byte_data(client,
+				 LM63_REG_REMOTE_TCRIT);
+		data->temp2_crit_hyst = i2c_smbus_read_byte_data(client,
+					LM63_REG_REMOTE_TCRIT_HYST);
+
+		data->alarms = i2c_smbus_read_byte_data(client,
+			       LM63_REG_ALERT_STATUS) & 0x7F;
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
+	    !data->lut_valid) {
+		for (i = 0; i < data->lut_size; i++) {
+			data->pwm1[1 + i] = i2c_smbus_read_byte_data(client,
+					    LM63_REG_LUT_PWM(i));
+			data->temp8[3 + i] = i2c_smbus_read_byte_data(client,
+					     LM63_REG_LUT_TEMP(i));
+		}
+		data->lut_temp_hyst = i2c_smbus_read_byte_data(client,
+				      LM63_REG_LUT_TEMP_HYST);
+
+		data->lut_last_updated = jiffies;
+		data->lut_valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
 /*
  * Sysfs callback functions and files
  */
@@ -817,28 +873,25 @@ static const struct attribute_group lm63
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm63_detect(struct i2c_client *new_client,
+static int lm63_detect(struct i2c_client *client,
 		       struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
 	u8 man_id, chip_id, reg_config1, reg_config2;
 	u8 reg_alert_status, reg_alert_mask;
-	int address = new_client->addr;
+	int address = client->addr;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	man_id = i2c_smbus_read_byte_data(new_client, LM63_REG_MAN_ID);
-	chip_id = i2c_smbus_read_byte_data(new_client, LM63_REG_CHIP_ID);
+	man_id = i2c_smbus_read_byte_data(client, LM63_REG_MAN_ID);
+	chip_id = i2c_smbus_read_byte_data(client, LM63_REG_CHIP_ID);
 
-	reg_config1 = i2c_smbus_read_byte_data(new_client,
-		      LM63_REG_CONFIG1);
-	reg_config2 = i2c_smbus_read_byte_data(new_client,
-		      LM63_REG_CONFIG2);
-	reg_alert_status = i2c_smbus_read_byte_data(new_client,
+	reg_config1 = i2c_smbus_read_byte_data(client, LM63_REG_CONFIG1);
+	reg_config2 = i2c_smbus_read_byte_data(client, LM63_REG_CONFIG2);
+	reg_alert_status = i2c_smbus_read_byte_data(client,
 			   LM63_REG_ALERT_STATUS);
-	reg_alert_mask = i2c_smbus_read_byte_data(new_client,
-			 LM63_REG_ALERT_MASK);
+	reg_alert_mask = i2c_smbus_read_byte_data(client, LM63_REG_ALERT_MASK);
 
 	if (man_id != 0x01 /* National Semiconductor */
 	 || (reg_config1 & 0x18) != 0x00
@@ -863,74 +916,6 @@ static int lm63_detect(struct i2c_client
 	return 0;
 }
 
-static int lm63_probe(struct i2c_client *new_client,
-		      const struct i2c_device_id *id)
-{
-	struct lm63_data *data;
-	int err;
-
-	data = kzalloc(sizeof(struct lm63_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	i2c_set_clientdata(new_client, data);
-	data->valid = 0;
-	mutex_init(&data->update_lock);
-
-	/* Set the device type */
-	data->kind = id->driver_data;
-	if (data->kind = lm64)
-		data->temp2_offset = 16000;
-
-	/* Initialize chip */
-	lm63_init_client(new_client);
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm63_group);
-	if (err)
-		goto exit_free;
-	if (data->config & 0x04) { /* tachometer enabled */
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm63_group_fan1);
-		if (err)
-			goto exit_remove_files;
-	}
-	if (data->kind = lm96163) {
-		err = device_create_file(&new_client->dev,
-					 &dev_attr_temp2_type);
-		if (err)
-			goto exit_remove_files;
-
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm63_group_extra_lut);
-		if (err)
-			goto exit_remove_files;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &lm63_group);
-	sysfs_remove_group(&new_client->dev.kobj, &lm63_group_fan1);
-	if (data->kind = lm96163) {
-		device_remove_file(&new_client->dev, &dev_attr_temp2_type);
-		sysfs_remove_group(&new_client->dev.kobj,
-				   &lm63_group_extra_lut);
-	}
-exit_free:
-	kfree(data);
-exit:
-	return err;
-}
-
 /*
  * Ideally we shouldn't have to initialize anything, since the BIOS
  * should have taken care of everything
@@ -1010,114 +995,110 @@ static void lm63_init_client(struct i2c_
 		(data->config_fan & 0x20) ? "manual" : "auto");
 }
 
-static int lm63_remove(struct i2c_client *client)
+static int lm63_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id)
 {
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data;
+	int err;
 
-	hwmon_device_unregister(data->hwmon_dev);
+	data = kzalloc(sizeof(struct lm63_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+
+	/* Set the device type */
+	data->kind = id->driver_data;
+	if (data->kind = lm64)
+		data->temp2_offset = 16000;
+
+	/* Initialize chip */
+	lm63_init_client(client);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &lm63_group);
+	if (err)
+		goto exit_free;
+	if (data->config & 0x04) { /* tachometer enabled */
+		err = sysfs_create_group(&client->dev.kobj, &lm63_group_fan1);
+		if (err)
+			goto exit_remove_files;
+	}
+	if (data->kind = lm96163) {
+		err = device_create_file(&client->dev, &dev_attr_temp2_type);
+		if (err)
+			goto exit_remove_files;
+
+		err = sysfs_create_group(&client->dev.kobj,
+					 &lm63_group_extra_lut);
+		if (err)
+			goto exit_remove_files;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_files;
+	}
+
+	return 0;
+
+exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
 	if (data->kind = lm96163) {
 		device_remove_file(&client->dev, &dev_attr_temp2_type);
 		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
 	}
-
+exit_free:
 	kfree(data);
-	return 0;
+exit:
+	return err;
 }
 
-static struct lm63_data *lm63_update_device(struct device *dev)
+static int lm63_remove(struct i2c_client *client)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
-	unsigned long next_update;
-	int i;
-
-	mutex_lock(&data->update_lock);
-
-	next_update = data->last_updated
-	  + msecs_to_jiffies(data->update_interval) + 1;
-
-	if (time_after(jiffies, next_update) || !data->valid) {
-		if (data->config & 0x04) { /* tachometer enabled  */
-			/* order matters for fan1_input */
-			data->fan[0] = i2c_smbus_read_byte_data(client,
-				       LM63_REG_TACH_COUNT_LSB) & 0xFC;
-			data->fan[0] |= i2c_smbus_read_byte_data(client,
-					LM63_REG_TACH_COUNT_MSB) << 8;
-			data->fan[1] = (i2c_smbus_read_byte_data(client,
-					LM63_REG_TACH_LIMIT_LSB) & 0xFC)
-				     | (i2c_smbus_read_byte_data(client,
-					LM63_REG_TACH_LIMIT_MSB) << 8);
-		}
-
-		data->pwm1_freq = i2c_smbus_read_byte_data(client,
-				  LM63_REG_PWM_FREQ);
-		if (data->pwm1_freq = 0)
-			data->pwm1_freq = 1;
-		data->pwm1[0] = i2c_smbus_read_byte_data(client,
-				LM63_REG_PWM_VALUE);
-
-		data->temp8[0] = i2c_smbus_read_byte_data(client,
-				 LM63_REG_LOCAL_TEMP);
-		data->temp8[1] = i2c_smbus_read_byte_data(client,
-				 LM63_REG_LOCAL_HIGH);
-
-		/* order matters for temp2_input */
-		data->temp11[0] = i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_TEMP_MSB) << 8;
-		data->temp11[0] |= i2c_smbus_read_byte_data(client,
-				   LM63_REG_REMOTE_TEMP_LSB);
-		data->temp11[1] = (i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_LOW_MSB) << 8)
-				| i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_LOW_LSB);
-		data->temp11[2] = (i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_HIGH_MSB) << 8)
-				| i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_HIGH_LSB);
-		data->temp11[3] = (i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_OFFSET_MSB) << 8)
-				| i2c_smbus_read_byte_data(client,
-				  LM63_REG_REMOTE_OFFSET_LSB);
-
-		if (data->kind = lm96163)
-			data->temp11u = (i2c_smbus_read_byte_data(client,
-					LM96163_REG_REMOTE_TEMP_U_MSB) << 8)
-				      | i2c_smbus_read_byte_data(client,
-					LM96163_REG_REMOTE_TEMP_U_LSB);
-
-		data->temp8[2] = i2c_smbus_read_byte_data(client,
-				 LM63_REG_REMOTE_TCRIT);
-		data->temp2_crit_hyst = i2c_smbus_read_byte_data(client,
-					LM63_REG_REMOTE_TCRIT_HYST);
-
-		data->alarms = i2c_smbus_read_byte_data(client,
-			       LM63_REG_ALERT_STATUS) & 0x7F;
 
-		data->last_updated = jiffies;
-		data->valid = 1;
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm63_group);
+	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
+	if (data->kind = lm96163) {
+		device_remove_file(&client->dev, &dev_attr_temp2_type);
+		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
 	}
 
-	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
-	    !data->lut_valid) {
-		for (i = 0; i < data->lut_size; i++) {
-			data->pwm1[1 + i] = i2c_smbus_read_byte_data(client,
-					    LM63_REG_LUT_PWM(i));
-			data->temp8[3 + i] = i2c_smbus_read_byte_data(client,
-					     LM63_REG_LUT_TEMP(i));
-		}
-		data->lut_temp_hyst = i2c_smbus_read_byte_data(client,
-				      LM63_REG_LUT_TEMP_HYST);
+	kfree(data);
+	return 0;
+}
 
-		data->lut_last_updated = jiffies;
-		data->lut_valid = 1;
-	}
+/*
+ * Driver data (common to all clients)
+ */
 
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id lm63_id[] = {
+	{ "lm63", lm63 },
+	{ "lm64", lm64 },
+	{ "lm96163", lm96163 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm63_id);
 
-	return data;
-}
+static struct i2c_driver lm63_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm63",
+	},
+	.probe		= lm63_probe,
+	.remove		= lm63_remove,
+	.id_table	= lm63_id,
+	.detect		= lm63_detect,
+	.address_list	= normal_i2c,
+};
 
 static int __init sensors_lm63_init(void)
 {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
