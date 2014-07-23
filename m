From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 23 Jul 2014 04:27:39 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (lm85) Avoid forward declaration
Message-Id: <1406089659.15290.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm85.c | 513 +++++++++++++++++++++++++--------------------------
 1 file changed, 250 insertions(+), 263 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index b0129a5..da6ef1e 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -121,7 +121,6 @@ enum chips {
 #define EMC6D102_REG_EXTEND_ADC3	0x87
 #define EMC6D102_REG_EXTEND_ADC4	0x88
 
-
 /*
  * Conversions. Rounding and limit checking is only done on the TO_REG
  * variants. Note that you should be a bit careful with which arguments
@@ -334,44 +333,235 @@ struct lm85_data {
 	struct lm85_zone zone[3];
 };
 
-static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info);
-static int lm85_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int lm85_remove(struct i2c_client *client);
+static int lm85_read_value(struct i2c_client *client, u8 reg)
+{
+	int res;
 
-static int lm85_read_value(struct i2c_client *client, u8 reg);
-static void lm85_write_value(struct i2c_client *client, u8 reg, int value);
-static struct lm85_data *lm85_update_device(struct device *dev);
+	/* What size location is it? */
+	switch (reg) {
+	case LM85_REG_FAN(0):  /* Read WORD data */
+	case LM85_REG_FAN(1):
+	case LM85_REG_FAN(2):
+	case LM85_REG_FAN(3):
+	case LM85_REG_FAN_MIN(0):
+	case LM85_REG_FAN_MIN(1):
+	case LM85_REG_FAN_MIN(2):
+	case LM85_REG_FAN_MIN(3):
+	case LM85_REG_ALARM1:	/* Read both bytes at once */
+		res = i2c_smbus_read_byte_data(client, reg) & 0xff;
+		res |= i2c_smbus_read_byte_data(client, reg + 1) << 8;
+		break;
+	default:	/* Read BYTE data */
+		res = i2c_smbus_read_byte_data(client, reg);
+		break;
+	}
 
+	return res;
+}
 
-static const struct i2c_device_id lm85_id[] = {
-	{ "adm1027", adm1027 },
-	{ "adt7463", adt7463 },
-	{ "adt7468", adt7468 },
-	{ "lm85", lm85 },
-	{ "lm85b", lm85 },
-	{ "lm85c", lm85 },
-	{ "emc6d100", emc6d100 },
-	{ "emc6d101", emc6d100 },
-	{ "emc6d102", emc6d102 },
-	{ "emc6d103", emc6d103 },
-	{ "emc6d103s", emc6d103s },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm85_id);
+static void lm85_write_value(struct i2c_client *client, u8 reg, int value)
+{
+	switch (reg) {
+	case LM85_REG_FAN(0):  /* Write WORD data */
+	case LM85_REG_FAN(1):
+	case LM85_REG_FAN(2):
+	case LM85_REG_FAN(3):
+	case LM85_REG_FAN_MIN(0):
+	case LM85_REG_FAN_MIN(1):
+	case LM85_REG_FAN_MIN(2):
+	case LM85_REG_FAN_MIN(3):
+	/* NOTE: ALARM is read only, so not included here */
+		i2c_smbus_write_byte_data(client, reg, value & 0xff);
+		i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
+		break;
+	default:	/* Write BYTE data */
+		i2c_smbus_write_byte_data(client, reg, value);
+		break;
+	}
+}
 
-static struct i2c_driver lm85_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name   = "lm85",
-	},
-	.probe		= lm85_probe,
-	.remove		= lm85_remove,
-	.id_table	= lm85_id,
-	.detect		= lm85_detect,
-	.address_list	= normal_i2c,
-};
+static struct lm85_data *lm85_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (!data->valid ||
+	     time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL)) {
+		/* Things that change quickly */
+		dev_dbg(&client->dev, "Reading sensor values\n");
+
+		/*
+		 * Have to read extended bits first to "freeze" the
+		 * more significant bits that are read later.
+		 * There are 2 additional resolution bits per channel and we
+		 * have room for 4, so we shift them to the left.
+		 */
+		if (data->type = adm1027 || data->type = adt7463 ||
+		    data->type = adt7468) {
+			int ext1 = lm85_read_value(client,
+						   ADM1027_REG_EXTEND_ADC1);
+			int ext2 =  lm85_read_value(client,
+						    ADM1027_REG_EXTEND_ADC2);
+			int val = (ext1 << 8) + ext2;
+
+			for (i = 0; i <= 4; i++)
+				data->in_ext[i] +					((val >> (i * 2)) & 0x03) << 2;
+
+			for (i = 0; i <= 2; i++)
+				data->temp_ext[i] +					(val >> ((i + 4) * 2)) & 0x0c;
+		}
+
+		data->vid = lm85_read_value(client, LM85_REG_VID);
+
+		for (i = 0; i <= 3; ++i) {
+			data->in[i] +			    lm85_read_value(client, LM85_REG_IN(i));
+			data->fan[i] +			    lm85_read_value(client, LM85_REG_FAN(i));
+		}
+
+		if (!data->has_vid5)
+			data->in[4] = lm85_read_value(client, LM85_REG_IN(4));
+
+		if (data->type = adt7468)
+			data->cfg5 = lm85_read_value(client, ADT7468_REG_CFG5);
+
+		for (i = 0; i <= 2; ++i) {
+			data->temp[i] +			    lm85_read_value(client, LM85_REG_TEMP(i));
+			data->pwm[i] +			    lm85_read_value(client, LM85_REG_PWM(i));
 
+			if (IS_ADT7468_OFF64(data))
+				data->temp[i] -= 64;
+		}
+
+		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
+
+		if (data->type = emc6d100) {
+			/* Three more voltage sensors */
+			for (i = 5; i <= 7; ++i) {
+				data->in[i] = lm85_read_value(client,
+							EMC6D100_REG_IN(i));
+			}
+			/* More alarm bits */
+			data->alarms |= lm85_read_value(client,
+						EMC6D100_REG_ALARM3) << 16;
+		} else if (data->type = emc6d102 || data->type = emc6d103 ||
+			   data->type = emc6d103s) {
+			/*
+			 * Have to read LSB bits after the MSB ones because
+			 * the reading of the MSB bits has frozen the
+			 * LSBs (backward from the ADM1027).
+			 */
+			int ext1 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC1);
+			int ext2 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC2);
+			int ext3 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC3);
+			int ext4 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC4);
+			data->in_ext[0] = ext3 & 0x0f;
+			data->in_ext[1] = ext4 & 0x0f;
+			data->in_ext[2] = ext4 >> 4;
+			data->in_ext[3] = ext3 >> 4;
+			data->in_ext[4] = ext2 >> 4;
+
+			data->temp_ext[0] = ext1 & 0x0f;
+			data->temp_ext[1] = ext2 & 0x0f;
+			data->temp_ext[2] = ext1 >> 4;
+		}
+
+		data->last_reading = jiffies;
+	}  /* last_reading */
+
+	if (!data->valid ||
+	     time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL)) {
+		/* Things that don't change often */
+		dev_dbg(&client->dev, "Reading config values\n");
+
+		for (i = 0; i <= 3; ++i) {
+			data->in_min[i] +			    lm85_read_value(client, LM85_REG_IN_MIN(i));
+			data->in_max[i] +			    lm85_read_value(client, LM85_REG_IN_MAX(i));
+			data->fan_min[i] +			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
+		}
+
+		if (!data->has_vid5)  {
+			data->in_min[4] = lm85_read_value(client,
+					  LM85_REG_IN_MIN(4));
+			data->in_max[4] = lm85_read_value(client,
+					  LM85_REG_IN_MAX(4));
+		}
+
+		if (data->type = emc6d100) {
+			for (i = 5; i <= 7; ++i) {
+				data->in_min[i] = lm85_read_value(client,
+						EMC6D100_REG_IN_MIN(i));
+				data->in_max[i] = lm85_read_value(client,
+						EMC6D100_REG_IN_MAX(i));
+			}
+		}
+
+		for (i = 0; i <= 2; ++i) {
+			int val;
+
+			data->temp_min[i] +			    lm85_read_value(client, LM85_REG_TEMP_MIN(i));
+			data->temp_max[i] +			    lm85_read_value(client, LM85_REG_TEMP_MAX(i));
+
+			data->autofan[i].config +			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
+			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
+			data->pwm_freq[i] = val & 0x07;
+			data->zone[i].range = val >> 4;
+			data->autofan[i].min_pwm +			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
+			data->zone[i].limit +			    lm85_read_value(client, LM85_REG_AFAN_LIMIT(i));
+			data->zone[i].critical +			    lm85_read_value(client, LM85_REG_AFAN_CRITICAL(i));
+
+			if (IS_ADT7468_OFF64(data)) {
+				data->temp_min[i] -= 64;
+				data->temp_max[i] -= 64;
+				data->zone[i].limit -= 64;
+				data->zone[i].critical -= 64;
+			}
+		}
+
+		if (data->type != emc6d103s) {
+			i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
+			data->autofan[0].min_off = (i & 0x20) != 0;
+			data->autofan[1].min_off = (i & 0x40) != 0;
+			data->autofan[2].min_off = (i & 0x80) != 0;
+
+			i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
+			data->zone[0].hyst = i >> 4;
+			data->zone[1].hyst = i & 0x0f;
+
+			i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
+			data->zone[2].hyst = i >> 4;
+		}
+
+		data->last_config = jiffies;
+	}  /* last_config */
+
+	data->valid = 1;
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 /* 4 Fans */
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
@@ -1464,236 +1654,33 @@ static int lm85_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id lm85_id[] = {
+	{ "adm1027", adm1027 },
+	{ "adt7463", adt7463 },
+	{ "adt7468", adt7468 },
+	{ "lm85", lm85 },
+	{ "lm85b", lm85 },
+	{ "lm85c", lm85 },
+	{ "emc6d100", emc6d100 },
+	{ "emc6d101", emc6d100 },
+	{ "emc6d102", emc6d102 },
+	{ "emc6d103", emc6d103 },
+	{ "emc6d103s", emc6d103s },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm85_id);
 
-static int lm85_read_value(struct i2c_client *client, u8 reg)
-{
-	int res;
-
-	/* What size location is it? */
-	switch (reg) {
-	case LM85_REG_FAN(0):  /* Read WORD data */
-	case LM85_REG_FAN(1):
-	case LM85_REG_FAN(2):
-	case LM85_REG_FAN(3):
-	case LM85_REG_FAN_MIN(0):
-	case LM85_REG_FAN_MIN(1):
-	case LM85_REG_FAN_MIN(2):
-	case LM85_REG_FAN_MIN(3):
-	case LM85_REG_ALARM1:	/* Read both bytes at once */
-		res = i2c_smbus_read_byte_data(client, reg) & 0xff;
-		res |= i2c_smbus_read_byte_data(client, reg + 1) << 8;
-		break;
-	default:	/* Read BYTE data */
-		res = i2c_smbus_read_byte_data(client, reg);
-		break;
-	}
-
-	return res;
-}
-
-static void lm85_write_value(struct i2c_client *client, u8 reg, int value)
-{
-	switch (reg) {
-	case LM85_REG_FAN(0):  /* Write WORD data */
-	case LM85_REG_FAN(1):
-	case LM85_REG_FAN(2):
-	case LM85_REG_FAN(3):
-	case LM85_REG_FAN_MIN(0):
-	case LM85_REG_FAN_MIN(1):
-	case LM85_REG_FAN_MIN(2):
-	case LM85_REG_FAN_MIN(3):
-	/* NOTE: ALARM is read only, so not included here */
-		i2c_smbus_write_byte_data(client, reg, value & 0xff);
-		i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
-		break;
-	default:	/* Write BYTE data */
-		i2c_smbus_write_byte_data(client, reg, value);
-		break;
-	}
-}
-
-static struct lm85_data *lm85_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-	int i;
-
-	mutex_lock(&data->update_lock);
-
-	if (!data->valid ||
-	     time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL)) {
-		/* Things that change quickly */
-		dev_dbg(&client->dev, "Reading sensor values\n");
-
-		/*
-		 * Have to read extended bits first to "freeze" the
-		 * more significant bits that are read later.
-		 * There are 2 additional resolution bits per channel and we
-		 * have room for 4, so we shift them to the left.
-		 */
-		if (data->type = adm1027 || data->type = adt7463 ||
-		    data->type = adt7468) {
-			int ext1 = lm85_read_value(client,
-						   ADM1027_REG_EXTEND_ADC1);
-			int ext2 =  lm85_read_value(client,
-						    ADM1027_REG_EXTEND_ADC2);
-			int val = (ext1 << 8) + ext2;
-
-			for (i = 0; i <= 4; i++)
-				data->in_ext[i] -					((val >> (i * 2)) & 0x03) << 2;
-
-			for (i = 0; i <= 2; i++)
-				data->temp_ext[i] -					(val >> ((i + 4) * 2)) & 0x0c;
-		}
-
-		data->vid = lm85_read_value(client, LM85_REG_VID);
-
-		for (i = 0; i <= 3; ++i) {
-			data->in[i] -			    lm85_read_value(client, LM85_REG_IN(i));
-			data->fan[i] -			    lm85_read_value(client, LM85_REG_FAN(i));
-		}
-
-		if (!data->has_vid5)
-			data->in[4] = lm85_read_value(client, LM85_REG_IN(4));
-
-		if (data->type = adt7468)
-			data->cfg5 = lm85_read_value(client, ADT7468_REG_CFG5);
-
-		for (i = 0; i <= 2; ++i) {
-			data->temp[i] -			    lm85_read_value(client, LM85_REG_TEMP(i));
-			data->pwm[i] -			    lm85_read_value(client, LM85_REG_PWM(i));
-
-			if (IS_ADT7468_OFF64(data))
-				data->temp[i] -= 64;
-		}
-
-		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
-
-		if (data->type = emc6d100) {
-			/* Three more voltage sensors */
-			for (i = 5; i <= 7; ++i) {
-				data->in[i] = lm85_read_value(client,
-							EMC6D100_REG_IN(i));
-			}
-			/* More alarm bits */
-			data->alarms |= lm85_read_value(client,
-						EMC6D100_REG_ALARM3) << 16;
-		} else if (data->type = emc6d102 || data->type = emc6d103 ||
-			   data->type = emc6d103s) {
-			/*
-			 * Have to read LSB bits after the MSB ones because
-			 * the reading of the MSB bits has frozen the
-			 * LSBs (backward from the ADM1027).
-			 */
-			int ext1 = lm85_read_value(client,
-						   EMC6D102_REG_EXTEND_ADC1);
-			int ext2 = lm85_read_value(client,
-						   EMC6D102_REG_EXTEND_ADC2);
-			int ext3 = lm85_read_value(client,
-						   EMC6D102_REG_EXTEND_ADC3);
-			int ext4 = lm85_read_value(client,
-						   EMC6D102_REG_EXTEND_ADC4);
-			data->in_ext[0] = ext3 & 0x0f;
-			data->in_ext[1] = ext4 & 0x0f;
-			data->in_ext[2] = ext4 >> 4;
-			data->in_ext[3] = ext3 >> 4;
-			data->in_ext[4] = ext2 >> 4;
-
-			data->temp_ext[0] = ext1 & 0x0f;
-			data->temp_ext[1] = ext2 & 0x0f;
-			data->temp_ext[2] = ext1 >> 4;
-		}
-
-		data->last_reading = jiffies;
-	}  /* last_reading */
-
-	if (!data->valid ||
-	     time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL)) {
-		/* Things that don't change often */
-		dev_dbg(&client->dev, "Reading config values\n");
-
-		for (i = 0; i <= 3; ++i) {
-			data->in_min[i] -			    lm85_read_value(client, LM85_REG_IN_MIN(i));
-			data->in_max[i] -			    lm85_read_value(client, LM85_REG_IN_MAX(i));
-			data->fan_min[i] -			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
-		}
-
-		if (!data->has_vid5)  {
-			data->in_min[4] = lm85_read_value(client,
-					  LM85_REG_IN_MIN(4));
-			data->in_max[4] = lm85_read_value(client,
-					  LM85_REG_IN_MAX(4));
-		}
-
-		if (data->type = emc6d100) {
-			for (i = 5; i <= 7; ++i) {
-				data->in_min[i] = lm85_read_value(client,
-						EMC6D100_REG_IN_MIN(i));
-				data->in_max[i] = lm85_read_value(client,
-						EMC6D100_REG_IN_MAX(i));
-			}
-		}
-
-		for (i = 0; i <= 2; ++i) {
-			int val;
-
-			data->temp_min[i] -			    lm85_read_value(client, LM85_REG_TEMP_MIN(i));
-			data->temp_max[i] -			    lm85_read_value(client, LM85_REG_TEMP_MAX(i));
-
-			data->autofan[i].config -			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
-			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
-			data->pwm_freq[i] = val & 0x07;
-			data->zone[i].range = val >> 4;
-			data->autofan[i].min_pwm -			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
-			data->zone[i].limit -			    lm85_read_value(client, LM85_REG_AFAN_LIMIT(i));
-			data->zone[i].critical -			    lm85_read_value(client, LM85_REG_AFAN_CRITICAL(i));
-
-			if (IS_ADT7468_OFF64(data)) {
-				data->temp_min[i] -= 64;
-				data->temp_max[i] -= 64;
-				data->zone[i].limit -= 64;
-				data->zone[i].critical -= 64;
-			}
-		}
-
-		if (data->type != emc6d103s) {
-			i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
-			data->autofan[0].min_off = (i & 0x20) != 0;
-			data->autofan[1].min_off = (i & 0x40) != 0;
-			data->autofan[2].min_off = (i & 0x80) != 0;
-
-			i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
-			data->zone[0].hyst = i >> 4;
-			data->zone[1].hyst = i & 0x0f;
-
-			i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
-			data->zone[2].hyst = i >> 4;
-		}
-
-		data->last_config = jiffies;
-	}  /* last_config */
-
-	data->valid = 1;
-
-	mutex_unlock(&data->update_lock);
-
-	return data;
-}
+static struct i2c_driver lm85_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name   = "lm85",
+	},
+	.probe		= lm85_probe,
+	.remove		= lm85_remove,
+	.id_table	= lm85_id,
+	.detect		= lm85_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(lm85_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
