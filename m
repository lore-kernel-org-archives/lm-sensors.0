From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 18 Sep 2010 03:30:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Rearrange code to no longer
Message-Id: <1284780642-7291-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm90.c |  523 ++++++++++++++++++++++++-------------------------
 1 files changed, 256 insertions(+), 267 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 366bb62..302d9eb 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -164,21 +164,6 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
 
 /*
- * Functions declaration
- */
-
-static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info);
-static int lm90_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static void lm90_init_client(struct i2c_client *client);
-static void lm90_alert(struct i2c_client *client, unsigned int flag);
-static int lm90_remove(struct i2c_client *client);
-static struct lm90_data *lm90_update_device(struct device *dev);
-static inline void lm90_select_remote_channel(struct i2c_client *client,
-					      struct lm90_data *data,
-					      int channel);
-
-/*
  * Driver data (common to all clients)
  */
 
@@ -204,19 +189,6 @@ static const struct i2c_device_id lm90_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, lm90_id);
 
-static struct i2c_driver lm90_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm90",
-	},
-	.probe		= lm90_probe,
-	.remove		= lm90_remove,
-	.alert		= lm90_alert,
-	.id_table	= lm90_id,
-	.detect		= lm90_detect,
-	.address_list	= normal_i2c,
-};
-
 /*
  * Client data (each client gets its own)
  */
@@ -256,6 +228,209 @@ struct lm90_data {
 };
 
 /*
+ * Support functions
+ */
+
+/*
+ * The ADM1032 supports PEC but not on write byte transactions, so we need
+ * to explicitly ask for a transaction without PEC.
+ */
+static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
+{
+	return i2c_smbus_xfer(client->adapter, client->addr,
+			      client->flags & ~I2C_CLIENT_PEC,
+			      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
+}
+
+/*
+ * It is assumed that client->update_lock is held (unless we are in
+ * detection or initialization steps). This matters when PEC is enabled,
+ * because we don't want the address pointer to change between the write
+ * byte and the read byte transactions.
+ */
+static int lm90_read_reg(struct i2c_client *client, u8 reg, u8 *value)
+{
+	int err;
+
+	if (client->flags & I2C_CLIENT_PEC) {
+		err = adm1032_write_byte(client, reg);
+		if (err >= 0)
+			err = i2c_smbus_read_byte(client);
+	} else
+		err = i2c_smbus_read_byte_data(client, reg);
+
+	if (err < 0) {
+		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
+			 reg, err);
+		return err;
+	}
+	*value = err;
+
+	return 0;
+}
+
+static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
+{
+	int err;
+	u8 oldh, newh, l;
+
+	/*
+	 * There is a trick here. We have to read two registers to have the
+	 * sensor temperature, but we have to beware a conversion could occur
+	 * inbetween the readings. The datasheet says we should either use
+	 * the one-shot conversion register, which we don't want to do
+	 * (disables hardware monitoring) or monitor the busy bit, which is
+	 * impossible (we can't read the values and monitor that bit at the
+	 * exact same time). So the solution used here is to read the high
+	 * byte once, then the low byte, then the high byte again. If the new
+	 * high byte matches the old one, then we have a valid reading. Else
+	 * we have to read the low byte again, and now we believe we have a
+	 * correct reading.
+	 */
+	if ((err = lm90_read_reg(client, regh, &oldh))
+	 || (err = lm90_read_reg(client, regl, &l))
+	 || (err = lm90_read_reg(client, regh, &newh)))
+		return err;
+	if (oldh != newh) {
+		err = lm90_read_reg(client, regl, &l);
+		if (err)
+			return err;
+	}
+	*value = (newh << 8) | l;
+
+	return 0;
+}
+
+/*
+ * client->update_lock must be held when calling this function (unless we are
+ * in detection or initialization steps), and while a remote channel other
+ * than channel 0 is selected. Also, calling code must make sure to re-select
+ * external channel 0 before releasing the lock. This is necessary because
+ * various registers have different meanings as a result of selecting a
+ * non-default remote channel.
+ */
+static inline void lm90_select_remote_channel(struct i2c_client *client,
+					      struct lm90_data *data,
+					      int channel)
+{
+	u8 config;
+
+	if (data->kind = max6696) {
+		lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
+		config &= ~0x08;
+		if (channel)
+			config |= 0x08;
+		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
+					  config);
+	}
+}
+
+static struct lm90_data *lm90_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ / 2 + HZ / 10)
+	 || !data->valid) {
+		u8 h, l;
+		u8 alarms;
+
+		dev_dbg(&client->dev, "Updating lm90 data.\n");
+		lm90_read_reg(client, LM90_REG_R_LOCAL_LOW, &data->temp8[0]);
+		lm90_read_reg(client, LM90_REG_R_LOCAL_HIGH, &data->temp8[1]);
+		lm90_read_reg(client, LM90_REG_R_LOCAL_CRIT, &data->temp8[2]);
+		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
+		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
+
+		if (data->flags & LM90_HAVE_LOCAL_EXT) {
+			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
+				    MAX6657_REG_R_LOCAL_TEMPL,
+				    &data->temp11[4]);
+		} else {
+			if (lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP,
+					  &h) = 0)
+				data->temp11[4] = h << 8;
+		}
+		lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
+			    LM90_REG_R_REMOTE_TEMPL, &data->temp11[0]);
+
+		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0) {
+			data->temp11[1] = h << 8;
+			if ((data->flags & LM90_HAVE_REM_LIMIT_EXT)
+			 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL,
+					  &l) = 0)
+				data->temp11[1] |= l;
+		}
+		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0) {
+			data->temp11[2] = h << 8;
+			if ((data->flags & LM90_HAVE_REM_LIMIT_EXT)
+			 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL,
+					  &l) = 0)
+				data->temp11[2] |= l;
+		}
+
+		if (data->flags & LM90_HAVE_OFFSET) {
+			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
+					  &h) = 0
+			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,
+					  &l) = 0)
+				data->temp11[3] = (h << 8) | l;
+		}
+		if (data->flags & LM90_HAVE_EMERGENCY) {
+			lm90_read_reg(client, MAX6659_REG_R_LOCAL_EMERG,
+				      &data->temp8[4]);
+			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
+				      &data->temp8[5]);
+		}
+		lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
+		data->alarms = alarms;	/* save as 16 bit value */
+
+		if (data->kind = max6696) {
+			lm90_select_remote_channel(client, data, 1);
+			lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT,
+				      &data->temp8[6]);
+			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
+				      &data->temp8[7]);
+			lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
+				    LM90_REG_R_REMOTE_TEMPL, &data->temp11[5]);
+			if (!lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h))
+				data->temp11[6] = h << 8;
+			if (!lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h))
+				data->temp11[7] = h << 8;
+			lm90_select_remote_channel(client, data, 0);
+
+			if (!lm90_read_reg(client, MAX6696_REG_R_STATUS2,
+					   &alarms))
+				data->alarms |= alarms << 8;
+		}
+
+		/* Re-enable ALERT# output if it was originally enabled and
+		 * relevant alarms are all clear */
+		if ((data->config_orig & 0x80) = 0
+		 && (data->alarms & data->alert_alarms) = 0) {
+			u8 config;
+
+			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
+			if (config & 0x80) {
+				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
+				i2c_smbus_write_byte_data(client,
+							  LM90_REG_W_CONFIG1,
+							  config & ~0x80);
+			}
+		}
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
  * Conversions
  * For local temperatures and limits, critical limits and the hysteresis
  * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
@@ -770,68 +945,6 @@ static DEVICE_ATTR(pec, S_IWUSR | S_IRUGO, show_pec, set_pec);
  * Real code
  */
 
-/*
- * The ADM1032 supports PEC but not on write byte transactions, so we need
- * to explicitly ask for a transaction without PEC.
- */
-static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
-{
-	return i2c_smbus_xfer(client->adapter, client->addr,
-			      client->flags & ~I2C_CLIENT_PEC,
-			      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
-}
-
-/*
- * It is assumed that client->update_lock is held (unless we are in
- * detection or initialization steps). This matters when PEC is enabled,
- * because we don't want the address pointer to change between the write
- * byte and the read byte transactions.
- */
-static int lm90_read_reg(struct i2c_client *client, u8 reg, u8 *value)
-{
-	int err;
-
-	if (client->flags & I2C_CLIENT_PEC) {
-		err = adm1032_write_byte(client, reg);
-		if (err >= 0)
-			err = i2c_smbus_read_byte(client);
-	} else
-		err = i2c_smbus_read_byte_data(client, reg);
-
-	if (err < 0) {
-		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
-			 reg, err);
-		return err;
-	}
-	*value = err;
-
-	return 0;
-}
-
-/*
- * client->update_lock must be held when calling this function (unless we are
- * in detection or initialization steps), and while a remote channel other
- * than channel 0 is selected. Also, calling code must make sure to re-select
- * external channel 0 before releasing the lock. This is necessary because
- * various registers have different meanings as a result of selecting a
- * non-default remote channel.
- */
-static inline void lm90_select_remote_channel(struct i2c_client *client,
-					      struct lm90_data *data,
-					      int channel)
-{
-	u8 config;
-
-	if (data->kind = max6696) {
-		lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
-		config &= ~0x08;
-		if (channel)
-			config |= 0x08;
-		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
-					  config);
-	}
-}
-
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm90_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
@@ -1023,6 +1136,47 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
 	sysfs_remove_group(&client->dev.kobj, &lm90_group);
 }
 
+static void lm90_init_client(struct i2c_client *client)
+{
+	u8 config;
+	struct lm90_data *data = i2c_get_clientdata(client);
+
+	/*
+	 * Start the conversions.
+	 */
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
+				  5); /* 2 Hz */
+	if (lm90_read_reg(client, LM90_REG_R_CONFIG1, &config) < 0) {
+		dev_warn(&client->dev, "Initialization failed!\n");
+		return;
+	}
+	data->config_orig = config;
+
+	/* Check Temperature Range Select */
+	if (data->kind = adt7461) {
+		if (config & 0x04)
+			data->flags |= LM90_FLAG_ADT7461_EXT;
+	}
+
+	/*
+	 * Put MAX6680/MAX8881 into extended resolution (bit 0x10,
+	 * 0.125 degree resolution) and range (0x08, extend range
+	 * to -64 degree) mode for the remote temperature sensor.
+	 */
+	if (data->kind = max6680)
+		config |= 0x18;
+
+	/*
+	 * Select external channel 0 for max6695/96
+	 */
+	if (data->kind = max6696)
+		config &= ~0x08;
+
+	config &= 0xBF;	/* run */
+	if (config != data->config_orig) /* Only write if changed */
+		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
+}
+
 static int lm90_probe(struct i2c_client *new_client,
 		      const struct i2c_device_id *id)
 {
@@ -1134,47 +1288,6 @@ exit:
 	return err;
 }
 
-static void lm90_init_client(struct i2c_client *client)
-{
-	u8 config;
-	struct lm90_data *data = i2c_get_clientdata(client);
-
-	/*
-	 * Start the conversions.
-	 */
-	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
-				  5); /* 2 Hz */
-	if (lm90_read_reg(client, LM90_REG_R_CONFIG1, &config) < 0) {
-		dev_warn(&client->dev, "Initialization failed!\n");
-		return;
-	}
-	data->config_orig = config;
-
-	/* Check Temperature Range Select */
-	if (data->kind = adt7461) {
-		if (config & 0x04)
-			data->flags |= LM90_FLAG_ADT7461_EXT;
-	}
-
-	/*
-	 * Put MAX6680/MAX8881 into extended resolution (bit 0x10,
-	 * 0.125 degree resolution) and range (0x08, extend range
-	 * to -64 degree) mode for the remote temperature sensor.
-	 */
-	if (data->kind = max6680)
-		config |= 0x18;
-
-	/*
-	 * Select external channel 0 for max6695/96
-	 */
-	if (data->kind = max6696)
-		config &= ~0x08;
-
-	config &= 0xBF;	/* run */
-	if (config != data->config_orig) /* Only write if changed */
-		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
-}
-
 static int lm90_remove(struct i2c_client *client)
 {
 	struct lm90_data *data = i2c_get_clientdata(client);
@@ -1230,142 +1343,18 @@ static void lm90_alert(struct i2c_client *client, unsigned int flag)
 	}
 }
 
-static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
-{
-	int err;
-	u8 oldh, newh, l;
-
-	/*
-	 * There is a trick here. We have to read two registers to have the
-	 * sensor temperature, but we have to beware a conversion could occur
-	 * inbetween the readings. The datasheet says we should either use
-	 * the one-shot conversion register, which we don't want to do
-	 * (disables hardware monitoring) or monitor the busy bit, which is
-	 * impossible (we can't read the values and monitor that bit at the
-	 * exact same time). So the solution used here is to read the high
-	 * byte once, then the low byte, then the high byte again. If the new
-	 * high byte matches the old one, then we have a valid reading. Else
-	 * we have to read the low byte again, and now we believe we have a
-	 * correct reading.
-	 */
-	if ((err = lm90_read_reg(client, regh, &oldh))
-	 || (err = lm90_read_reg(client, regl, &l))
-	 || (err = lm90_read_reg(client, regh, &newh)))
-		return err;
-	if (oldh != newh) {
-		err = lm90_read_reg(client, regl, &l);
-		if (err)
-			return err;
-	}
-	*value = (newh << 8) | l;
-
-	return 0;
-}
-
-static struct lm90_data *lm90_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ / 2 + HZ / 10)
-	 || !data->valid) {
-		u8 h, l;
-		u8 alarms;
-
-		dev_dbg(&client->dev, "Updating lm90 data.\n");
-		lm90_read_reg(client, LM90_REG_R_LOCAL_LOW, &data->temp8[0]);
-		lm90_read_reg(client, LM90_REG_R_LOCAL_HIGH, &data->temp8[1]);
-		lm90_read_reg(client, LM90_REG_R_LOCAL_CRIT, &data->temp8[2]);
-		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
-		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
-
-		if (data->flags & LM90_HAVE_LOCAL_EXT) {
-			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
-				    MAX6657_REG_R_LOCAL_TEMPL,
-				    &data->temp11[4]);
-		} else {
-			if (lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP,
-					  &h) = 0)
-				data->temp11[4] = h << 8;
-		}
-		lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
-			    LM90_REG_R_REMOTE_TEMPL, &data->temp11[0]);
-
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0) {
-			data->temp11[1] = h << 8;
-			if ((data->flags & LM90_HAVE_REM_LIMIT_EXT)
-			 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL,
-					  &l) = 0)
-				data->temp11[1] |= l;
-		}
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0) {
-			data->temp11[2] = h << 8;
-			if ((data->flags & LM90_HAVE_REM_LIMIT_EXT)
-			 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL,
-					  &l) = 0)
-				data->temp11[2] |= l;
-		}
-
-		if (data->flags & LM90_HAVE_OFFSET) {
-			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
-					  &h) = 0
-			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,
-					  &l) = 0)
-				data->temp11[3] = (h << 8) | l;
-		}
-		if (data->flags & LM90_HAVE_EMERGENCY) {
-			lm90_read_reg(client, MAX6659_REG_R_LOCAL_EMERG,
-				      &data->temp8[4]);
-			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
-				      &data->temp8[5]);
-		}
-		lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
-		data->alarms = alarms;	/* save as 16 bit value */
-
-		if (data->kind = max6696) {
-			lm90_select_remote_channel(client, data, 1);
-			lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT,
-				      &data->temp8[6]);
-			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
-				      &data->temp8[7]);
-			lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
-				    LM90_REG_R_REMOTE_TEMPL, &data->temp11[5]);
-			if (!lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h))
-				data->temp11[6] = h << 8;
-			if (!lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h))
-				data->temp11[7] = h << 8;
-			lm90_select_remote_channel(client, data, 0);
-
-			if (!lm90_read_reg(client, MAX6696_REG_R_STATUS2,
-					   &alarms))
-				data->alarms |= alarms << 8;
-		}
-
-		/* Re-enable ALERT# output if it was originally enabled and
-		 * relevant alarms are all clear */
-		if ((data->config_orig & 0x80) = 0
-		 && (data->alarms & data->alert_alarms) = 0) {
-			u8 config;
-
-			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
-			if (config & 0x80) {
-				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
-				i2c_smbus_write_byte_data(client,
-							  LM90_REG_W_CONFIG1,
-							  config & ~0x80);
-			}
-		}
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
-
-	return data;
-}
+static struct i2c_driver lm90_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm90",
+	},
+	.probe		= lm90_probe,
+	.remove		= lm90_remove,
+	.alert		= lm90_alert,
+	.id_table	= lm90_id,
+	.detect		= lm90_detect,
+	.address_list	= normal_i2c,
+};
 
 static int __init sensors_lm90_init(void)
 {
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
