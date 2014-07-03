From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 01:46:51 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (gl518sm) Avoid forward declaration
Message-Id: <1404352011.29709.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/gl518sm.c | 263 +++++++++++++++++++++++-------------------------
 1 file changed, 126 insertions(+), 137 deletions(-)

diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 1e98305..0307d82 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -137,33 +137,98 @@ struct gl518_data {
 	u8 beep_enable;		/* Boolean */
 };
 
-static int gl518_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id);
-static int gl518_detect(struct i2c_client *client, struct i2c_board_info *info);
-static void gl518_init_client(struct i2c_client *client);
-static int gl518_remove(struct i2c_client *client);
-static int gl518_read_value(struct i2c_client *client, u8 reg);
-static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value);
-static struct gl518_data *gl518_update_device(struct device *dev);
+/*
+ * Registers 0x07 to 0x0c are word-sized, others are byte-sized
+ * GL518 uses a high-byte first convention, which is exactly opposite to
+ * the SMBus standard.
+ */
+static int gl518_read_value(struct i2c_client *client, u8 reg)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return i2c_smbus_read_word_swapped(client, reg);
+	else
+		return i2c_smbus_read_byte_data(client, reg);
+}
 
-static const struct i2c_device_id gl518_id[] = {
-	{ "gl518sm", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, gl518_id);
+static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return i2c_smbus_write_word_swapped(client, reg, value);
+	else
+		return i2c_smbus_write_byte_data(client, reg, value);
+}
 
-/* This is the driver that will be inserted */
-static struct i2c_driver gl518_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "gl518sm",
-	},
-	.probe		= gl518_probe,
-	.remove		= gl518_remove,
-	.id_table	= gl518_id,
-	.detect		= gl518_detect,
-	.address_list	= normal_i2c,
-};
+static struct gl518_data *gl518_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl518_data *data = i2c_get_clientdata(client);
+	int val;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		dev_dbg(&client->dev, "Starting gl518 update\n");
+
+		data->alarms = gl518_read_value(client, GL518_REG_INT);
+		data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
+
+		val = gl518_read_value(client, GL518_REG_VDD_LIMIT);
+		data->voltage_min[0] = val & 0xff;
+		data->voltage_max[0] = (val >> 8) & 0xff;
+		val = gl518_read_value(client, GL518_REG_VIN1_LIMIT);
+		data->voltage_min[1] = val & 0xff;
+		data->voltage_max[1] = (val >> 8) & 0xff;
+		val = gl518_read_value(client, GL518_REG_VIN2_LIMIT);
+		data->voltage_min[2] = val & 0xff;
+		data->voltage_max[2] = (val >> 8) & 0xff;
+		val = gl518_read_value(client, GL518_REG_VIN3_LIMIT);
+		data->voltage_min[3] = val & 0xff;
+		data->voltage_max[3] = (val >> 8) & 0xff;
+
+		val = gl518_read_value(client, GL518_REG_FAN_COUNT);
+		data->fan_in[0] = (val >> 8) & 0xff;
+		data->fan_in[1] = val & 0xff;
+
+		val = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+		data->fan_min[0] = (val >> 8) & 0xff;
+		data->fan_min[1] = val & 0xff;
+
+		data->temp_in = gl518_read_value(client, GL518_REG_TEMP_IN);
+		data->temp_max +		    gl518_read_value(client, GL518_REG_TEMP_MAX);
+		data->temp_hyst +		    gl518_read_value(client, GL518_REG_TEMP_HYST);
+
+		val = gl518_read_value(client, GL518_REG_MISC);
+		data->fan_div[0] = (val >> 6) & 0x03;
+		data->fan_div[1] = (val >> 4) & 0x03;
+		data->fan_auto1  = (val >> 3) & 0x01;
+
+		data->alarms &= data->alarm_mask;
+
+		val = gl518_read_value(client, GL518_REG_CONF);
+		data->beep_enable = (val >> 2) & 1;
+
+		if (data->type != gl518sm_r00) {
+			data->voltage_in[0] +			    gl518_read_value(client, GL518_REG_VDD);
+			data->voltage_in[1] +			    gl518_read_value(client, GL518_REG_VIN1);
+			data->voltage_in[2] +			    gl518_read_value(client, GL518_REG_VIN2);
+		}
+		data->voltage_in[3] +		    gl518_read_value(client, GL518_REG_VIN3);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 /*
  * Sysfs stuff
@@ -539,6 +604,26 @@ static int gl518_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
+/*
+ * Called when we have found a new GL518SM.
+ * Note that we preserve D4:NoFan2 and D2:beep_enable.
+ */
+static void gl518_init_client(struct i2c_client *client)
+{
+	/* Make sure we leave D7:Reset untouched */
+	u8 regvalue = gl518_read_value(client, GL518_REG_CONF) & 0x7f;
+
+	/* Comparator mode (D3=0), standby mode (D6=0) */
+	gl518_write_value(client, GL518_REG_CONF, (regvalue &= 0x37));
+
+	/* Never interrupts */
+	gl518_write_value(client, GL518_REG_MASK, 0x00);
+
+	/* Clear status register (D5=1), start (D6=1) */
+	gl518_write_value(client, GL518_REG_CONF, 0x20 | regvalue);
+	gl518_write_value(client, GL518_REG_CONF, 0x40 | regvalue);
+}
+
 static int gl518_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
@@ -584,27 +669,6 @@ exit_remove_files:
 	return err;
 }
 
-
-/*
- * Called when we have found a new GL518SM.
- * Note that we preserve D4:NoFan2 and D2:beep_enable.
- */
-static void gl518_init_client(struct i2c_client *client)
-{
-	/* Make sure we leave D7:Reset untouched */
-	u8 regvalue = gl518_read_value(client, GL518_REG_CONF) & 0x7f;
-
-	/* Comparator mode (D3=0), standby mode (D6=0) */
-	gl518_write_value(client, GL518_REG_CONF, (regvalue &= 0x37));
-
-	/* Never interrupts */
-	gl518_write_value(client, GL518_REG_MASK, 0x00);
-
-	/* Clear status register (D5=1), start (D6=1) */
-	gl518_write_value(client, GL518_REG_CONF, 0x20 | regvalue);
-	gl518_write_value(client, GL518_REG_CONF, 0x40 | regvalue);
-}
-
 static int gl518_remove(struct i2c_client *client)
 {
 	struct gl518_data *data = i2c_get_clientdata(client);
@@ -617,98 +681,23 @@ static int gl518_remove(struct i2c_client *client)
 	return 0;
 }
 
-/*
- * Registers 0x07 to 0x0c are word-sized, others are byte-sized
- * GL518 uses a high-byte first convention, which is exactly opposite to
- * the SMBus standard.
- */
-static int gl518_read_value(struct i2c_client *client, u8 reg)
-{
-	if ((reg >= 0x07) && (reg <= 0x0c))
-		return i2c_smbus_read_word_swapped(client, reg);
-	else
-		return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
-{
-	if ((reg >= 0x07) && (reg <= 0x0c))
-		return i2c_smbus_write_word_swapped(client, reg, value);
-	else
-		return i2c_smbus_write_byte_data(client, reg, value);
-}
-
-static struct gl518_data *gl518_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl518_data *data = i2c_get_clientdata(client);
-	int val;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		dev_dbg(&client->dev, "Starting gl518 update\n");
-
-		data->alarms = gl518_read_value(client, GL518_REG_INT);
-		data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
-
-		val = gl518_read_value(client, GL518_REG_VDD_LIMIT);
-		data->voltage_min[0] = val & 0xff;
-		data->voltage_max[0] = (val >> 8) & 0xff;
-		val = gl518_read_value(client, GL518_REG_VIN1_LIMIT);
-		data->voltage_min[1] = val & 0xff;
-		data->voltage_max[1] = (val >> 8) & 0xff;
-		val = gl518_read_value(client, GL518_REG_VIN2_LIMIT);
-		data->voltage_min[2] = val & 0xff;
-		data->voltage_max[2] = (val >> 8) & 0xff;
-		val = gl518_read_value(client, GL518_REG_VIN3_LIMIT);
-		data->voltage_min[3] = val & 0xff;
-		data->voltage_max[3] = (val >> 8) & 0xff;
-
-		val = gl518_read_value(client, GL518_REG_FAN_COUNT);
-		data->fan_in[0] = (val >> 8) & 0xff;
-		data->fan_in[1] = val & 0xff;
-
-		val = gl518_read_value(client, GL518_REG_FAN_LIMIT);
-		data->fan_min[0] = (val >> 8) & 0xff;
-		data->fan_min[1] = val & 0xff;
-
-		data->temp_in = gl518_read_value(client, GL518_REG_TEMP_IN);
-		data->temp_max -		    gl518_read_value(client, GL518_REG_TEMP_MAX);
-		data->temp_hyst -		    gl518_read_value(client, GL518_REG_TEMP_HYST);
-
-		val = gl518_read_value(client, GL518_REG_MISC);
-		data->fan_div[0] = (val >> 6) & 0x03;
-		data->fan_div[1] = (val >> 4) & 0x03;
-		data->fan_auto1  = (val >> 3) & 0x01;
-
-		data->alarms &= data->alarm_mask;
-
-		val = gl518_read_value(client, GL518_REG_CONF);
-		data->beep_enable = (val >> 2) & 1;
-
-		if (data->type != gl518sm_r00) {
-			data->voltage_in[0] -			    gl518_read_value(client, GL518_REG_VDD);
-			data->voltage_in[1] -			    gl518_read_value(client, GL518_REG_VIN1);
-			data->voltage_in[2] -			    gl518_read_value(client, GL518_REG_VIN2);
-		}
-		data->voltage_in[3] -		    gl518_read_value(client, GL518_REG_VIN3);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id gl518_id[] = {
+	{ "gl518sm", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, gl518_id);
 
-	return data;
-}
+static struct i2c_driver gl518_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "gl518sm",
+	},
+	.probe		= gl518_probe,
+	.remove		= gl518_remove,
+	.id_table	= gl518_id,
+	.detect		= gl518_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(gl518_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
