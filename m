From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 14:41:49 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm87) Reorganize the code
Message-Id: <20120126154149.46793cc7@endymion.delvare>
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
This goes on top of Guenter's two lm87 patches:
hwmon: (lm87) Fix checkpatch issues
hwmon: (lm87) Fix: do not use assignment in if condition

 drivers/hwmon/lm87.c |  351 +++++++++++++++++++++++---------------------------
 1 file changed, 165 insertions(+), 186 deletions(-)

--- linux-3.3-rc1.orig/drivers/hwmon/lm87.c	2012-01-26 15:29:11.089274696 +0100
+++ linux-3.3-rc1/drivers/hwmon/lm87.c	2012-01-26 15:29:21.070274843 +0100
@@ -150,41 +150,6 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A,
 #define CHAN_NO_VID		(1 << 7)
 
 /*
- * Functions declaration
- */
-
-static int lm87_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int lm87_detect(struct i2c_client *new_client,
-		       struct i2c_board_info *info);
-static void lm87_init_client(struct i2c_client *client);
-static int lm87_remove(struct i2c_client *client);
-static struct lm87_data *lm87_update_device(struct device *dev);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id lm87_id[] = {
-	{ "lm87", lm87 },
-	{ "adm1024", adm1024 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm87_id);
-
-static struct i2c_driver lm87_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm87",
-	},
-	.probe		= lm87_probe,
-	.remove		= lm87_remove,
-	.id_table	= lm87_id,
-	.detect		= lm87_detect,
-	.address_list	= normal_i2c,
-};
-
-/*
  * Client data (each client gets its own)
  */
 
@@ -218,10 +183,6 @@ struct lm87_data {
 	u8 vrm;
 };
 
-/*
- * Sysfs stuff
- */
-
 static inline int lm87_read_value(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -232,6 +193,89 @@ static inline int lm87_write_value(struc
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
+static struct lm87_data *lm87_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm87_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		int i, j;
+
+		dev_dbg(&client->dev, "Updating data.\n");
+
+		i = (data->channel & CHAN_TEMP3) ? 1 : 0;
+		j = (data->channel & CHAN_TEMP3) ? 5 : 6;
+		for (; i < j; i++) {
+			data->in[i] = lm87_read_value(client,
+				      LM87_REG_IN(i));
+			data->in_min[i] = lm87_read_value(client,
+					  LM87_REG_IN_MIN(i));
+			data->in_max[i] = lm87_read_value(client,
+					  LM87_REG_IN_MAX(i));
+		}
+
+		for (i = 0; i < 2; i++) {
+			if (data->channel & CHAN_NO_FAN(i)) {
+				data->in[6+i] = lm87_read_value(client,
+						LM87_REG_AIN(i));
+				data->in_max[6+i] = lm87_read_value(client,
+						    LM87_REG_AIN_MAX(i));
+				data->in_min[6+i] = lm87_read_value(client,
+						    LM87_REG_AIN_MIN(i));
+
+			} else {
+				data->fan[i] = lm87_read_value(client,
+					       LM87_REG_FAN(i));
+				data->fan_min[i] = lm87_read_value(client,
+						   LM87_REG_FAN_MIN(i));
+			}
+		}
+
+		j = (data->channel & CHAN_TEMP3) ? 3 : 2;
+		for (i = 0 ; i < j; i++) {
+			data->temp[i] = lm87_read_value(client,
+					LM87_REG_TEMP[i]);
+			data->temp_high[i] = lm87_read_value(client,
+					     LM87_REG_TEMP_HIGH[i]);
+			data->temp_low[i] = lm87_read_value(client,
+					    LM87_REG_TEMP_LOW[i]);
+		}
+
+		i = lm87_read_value(client, LM87_REG_TEMP_HW_INT_LOCK);
+		j = lm87_read_value(client, LM87_REG_TEMP_HW_INT);
+		data->temp_crit_int = min(i, j);
+
+		i = lm87_read_value(client, LM87_REG_TEMP_HW_EXT_LOCK);
+		j = lm87_read_value(client, LM87_REG_TEMP_HW_EXT);
+		data->temp_crit_ext = min(i, j);
+
+		i = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
+		data->fan_div[0] = (i >> 4) & 0x03;
+		data->fan_div[1] = (i >> 6) & 0x03;
+		data->vid = (i & 0x0F)
+			  | (lm87_read_value(client, LM87_REG_VID4) & 0x01)
+			     << 4;
+
+		data->alarms = lm87_read_value(client, LM87_REG_ALARMS1)
+			     | (lm87_read_value(client, LM87_REG_ALARMS2)
+				<< 8);
+		data->aout = lm87_read_value(client, LM87_REG_AOUT);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+/*
+ * Sysfs stuff
+ */
+
 #define show_in(offset) \
 static ssize_t show_in##offset##_input(struct device *dev, \
 				       struct device_attribute *attr, \
@@ -789,22 +833,21 @@ static const struct attribute_group lm87
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm87_detect(struct i2c_client *new_client,
-		       struct i2c_board_info *info)
+static int lm87_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
 	const char *name;
 	u8 cid, rev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	if (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)
+	if (lm87_read_value(client, LM87_REG_CONFIG) & 0x80)
 		return -ENODEV;
 
 	/* Now, we do the remaining detection. */
-	cid = lm87_read_value(new_client, LM87_REG_COMPANY_ID);
-	rev = lm87_read_value(new_client, LM87_REG_REVISION);
+	cid = lm87_read_value(client, LM87_REG_COMPANY_ID);
+	rev = lm87_read_value(client, LM87_REG_REVISION);
 
 	if (cid = 0x02			/* National Semiconductor */
 	 && (rev >= 0x01 && rev <= 0x08))
@@ -814,7 +857,7 @@ static int lm87_detect(struct i2c_client
 		name = "adm1024";
 	else {
 		dev_dbg(&adapter->dev, "LM87 detection failed at 0x%02x\n",
-			new_client->addr);
+			client->addr);
 		return -ENODEV;
 	}
 
@@ -835,8 +878,49 @@ static void lm87_remove_files(struct i2c
 	sysfs_remove_group(&client->dev.kobj, &lm87_group_vid);
 }
 
-static int lm87_probe(struct i2c_client *new_client,
-		      const struct i2c_device_id *id)
+static void lm87_init_client(struct i2c_client *client)
+{
+	struct lm87_data *data = i2c_get_clientdata(client);
+
+	if (client->dev.platform_data) {
+		data->channel = *(u8 *)client->dev.platform_data;
+		lm87_write_value(client,
+				 LM87_REG_CHANNEL_MODE, data->channel);
+	} else {
+		data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
+	}
+	data->config = lm87_read_value(client, LM87_REG_CONFIG) & 0x6F;
+
+	if (!(data->config & 0x01)) {
+		int i;
+
+		/* Limits are left uninitialized after power-up */
+		for (i = 1; i < 6; i++) {
+			lm87_write_value(client, LM87_REG_IN_MIN(i), 0x00);
+			lm87_write_value(client, LM87_REG_IN_MAX(i), 0xFF);
+		}
+		for (i = 0; i < 2; i++) {
+			lm87_write_value(client, LM87_REG_TEMP_HIGH[i], 0x7F);
+			lm87_write_value(client, LM87_REG_TEMP_LOW[i], 0x00);
+			lm87_write_value(client, LM87_REG_AIN_MIN(i), 0x00);
+			lm87_write_value(client, LM87_REG_AIN_MAX(i), 0xFF);
+		}
+		if (data->channel & CHAN_TEMP3) {
+			lm87_write_value(client, LM87_REG_TEMP_HIGH[2], 0x7F);
+			lm87_write_value(client, LM87_REG_TEMP_LOW[2], 0x00);
+		} else {
+			lm87_write_value(client, LM87_REG_IN_MIN(0), 0x00);
+			lm87_write_value(client, LM87_REG_IN_MAX(0), 0xFF);
+		}
+	}
+
+	/* Make sure Start is set and INT#_Clear is clear */
+	if ((data->config & 0x09) != 0x01)
+		lm87_write_value(client, LM87_REG_CONFIG,
+				 (data->config & 0x77) | 0x01);
+}
+
+static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct lm87_data *data;
 	int err;
@@ -847,12 +931,12 @@ static int lm87_probe(struct i2c_client
 		goto exit;
 	}
 
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM87 chip */
-	lm87_init_client(new_client);
+	lm87_init_client(client);
 
 	data->in_scale[0] = 2500;
 	data->in_scale[1] = 2700;
@@ -864,55 +948,48 @@ static int lm87_probe(struct i2c_client
 	data->in_scale[7] = 1875;
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm87_group);
+	err = sysfs_create_group(&client->dev.kobj, &lm87_group);
 	if (err)
 		goto exit_free;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_in6);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_in6);
 		if (err)
 			goto exit_remove;
 	} else {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_fan1);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_fan1);
 		if (err)
 			goto exit_remove;
 	}
 
 	if (data->channel & CHAN_NO_FAN(1)) {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_in7);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_in7);
 		if (err)
 			goto exit_remove;
 	} else {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_fan2);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_fan2);
 		if (err)
 			goto exit_remove;
 	}
 
 	if (data->channel & CHAN_TEMP3) {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_temp3);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_temp3);
 		if (err)
 			goto exit_remove;
 	} else {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_in0_5);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_in0_5);
 		if (err)
 			goto exit_remove;
 	}
 
 	if (!(data->channel & CHAN_NO_VID)) {
 		data->vrm = vid_which_vrm();
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm87_group_vid);
+		err = sysfs_create_group(&client->dev.kobj, &lm87_group_vid);
 		if (err)
 			goto exit_remove;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -921,56 +998,14 @@ static int lm87_probe(struct i2c_client
 	return 0;
 
 exit_remove:
-	lm87_remove_files(new_client);
+	lm87_remove_files(client);
 exit_free:
-	lm87_write_value(new_client, LM87_REG_CONFIG, data->config);
+	lm87_write_value(client, LM87_REG_CONFIG, data->config);
 	kfree(data);
 exit:
 	return err;
 }
 
-static void lm87_init_client(struct i2c_client *client)
-{
-	struct lm87_data *data = i2c_get_clientdata(client);
-
-	if (client->dev.platform_data) {
-		data->channel = *(u8 *)client->dev.platform_data;
-		lm87_write_value(client,
-				 LM87_REG_CHANNEL_MODE, data->channel);
-	} else {
-		data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
-	}
-	data->config = lm87_read_value(client, LM87_REG_CONFIG) & 0x6F;
-
-	if (!(data->config & 0x01)) {
-		int i;
-
-		/* Limits are left uninitialized after power-up */
-		for (i = 1; i < 6; i++) {
-			lm87_write_value(client, LM87_REG_IN_MIN(i), 0x00);
-			lm87_write_value(client, LM87_REG_IN_MAX(i), 0xFF);
-		}
-		for (i = 0; i < 2; i++) {
-			lm87_write_value(client, LM87_REG_TEMP_HIGH[i], 0x7F);
-			lm87_write_value(client, LM87_REG_TEMP_LOW[i], 0x00);
-			lm87_write_value(client, LM87_REG_AIN_MIN(i), 0x00);
-			lm87_write_value(client, LM87_REG_AIN_MAX(i), 0xFF);
-		}
-		if (data->channel & CHAN_TEMP3) {
-			lm87_write_value(client, LM87_REG_TEMP_HIGH[2], 0x7F);
-			lm87_write_value(client, LM87_REG_TEMP_LOW[2], 0x00);
-		} else {
-			lm87_write_value(client, LM87_REG_IN_MIN(0), 0x00);
-			lm87_write_value(client, LM87_REG_IN_MAX(0), 0xFF);
-		}
-	}
-
-	/* Make sure Start is set and INT#_Clear is clear */
-	if ((data->config & 0x09) != 0x01)
-		lm87_write_value(client, LM87_REG_CONFIG,
-				 (data->config & 0x77) | 0x01);
-}
-
 static int lm87_remove(struct i2c_client *client)
 {
 	struct lm87_data *data = i2c_get_clientdata(client);
@@ -983,84 +1018,28 @@ static int lm87_remove(struct i2c_client
 	return 0;
 }
 
-static struct lm87_data *lm87_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm87_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		int i, j;
-
-		dev_dbg(&client->dev, "Updating data.\n");
-
-		i = (data->channel & CHAN_TEMP3) ? 1 : 0;
-		j = (data->channel & CHAN_TEMP3) ? 5 : 6;
-		for (; i < j; i++) {
-			data->in[i] = lm87_read_value(client,
-				      LM87_REG_IN(i));
-			data->in_min[i] = lm87_read_value(client,
-					  LM87_REG_IN_MIN(i));
-			data->in_max[i] = lm87_read_value(client,
-					  LM87_REG_IN_MAX(i));
-		}
-
-		for (i = 0; i < 2; i++) {
-			if (data->channel & CHAN_NO_FAN(i)) {
-				data->in[6+i] = lm87_read_value(client,
-						LM87_REG_AIN(i));
-				data->in_max[6+i] = lm87_read_value(client,
-						    LM87_REG_AIN_MAX(i));
-				data->in_min[6+i] = lm87_read_value(client,
-						    LM87_REG_AIN_MIN(i));
-
-			} else {
-				data->fan[i] = lm87_read_value(client,
-					       LM87_REG_FAN(i));
-				data->fan_min[i] = lm87_read_value(client,
-						   LM87_REG_FAN_MIN(i));
-			}
-		}
-
-		j = (data->channel & CHAN_TEMP3) ? 3 : 2;
-		for (i = 0 ; i < j; i++) {
-			data->temp[i] = lm87_read_value(client,
-					LM87_REG_TEMP[i]);
-			data->temp_high[i] = lm87_read_value(client,
-					     LM87_REG_TEMP_HIGH[i]);
-			data->temp_low[i] = lm87_read_value(client,
-					    LM87_REG_TEMP_LOW[i]);
-		}
-
-		i = lm87_read_value(client, LM87_REG_TEMP_HW_INT_LOCK);
-		j = lm87_read_value(client, LM87_REG_TEMP_HW_INT);
-		data->temp_crit_int = min(i, j);
-
-		i = lm87_read_value(client, LM87_REG_TEMP_HW_EXT_LOCK);
-		j = lm87_read_value(client, LM87_REG_TEMP_HW_EXT);
-		data->temp_crit_ext = min(i, j);
-
-		i = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = (i >> 6) & 0x03;
-		data->vid = (i & 0x0F)
-			  | (lm87_read_value(client, LM87_REG_VID4) & 0x01)
-			     << 4;
-
-		data->alarms = lm87_read_value(client, LM87_REG_ALARMS1)
-			     | (lm87_read_value(client, LM87_REG_ALARMS2)
-				<< 8);
-		data->aout = lm87_read_value(client, LM87_REG_AOUT);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
+/*
+ * Driver data (common to all clients)
+ */
 
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id lm87_id[] = {
+	{ "lm87", lm87 },
+	{ "adm1024", adm1024 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm87_id);
 
-	return data;
-}
+static struct i2c_driver lm87_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm87",
+	},
+	.probe		= lm87_probe,
+	.remove		= lm87_remove,
+	.id_table	= lm87_id,
+	.detect		= lm87_detect,
+	.address_list	= normal_i2c,
+};
 
 static int __init sensors_lm87_init(void)
 {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
