From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 01:49:21 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (gl520sm) Avoid forward declaration
Message-Id: <1404352161.29709.4.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/gl520sm.c | 317 +++++++++++++++++++++++-------------------------
 1 file changed, 150 insertions(+), 167 deletions(-)

diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index ed56e09..86c08a1 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -73,38 +73,6 @@ static const u8 GL520_REG_TEMP_MAX_HYST[]	= { 0x06, 0x18 };
 #define GL520_REG_BEEP_MASK		0x10
 #define GL520_REG_BEEP_ENABLE		GL520_REG_CONF
 
-/*
- * Function declarations
- */
-
-static int gl520_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id);
-static int gl520_detect(struct i2c_client *client, struct i2c_board_info *info);
-static void gl520_init_client(struct i2c_client *client);
-static int gl520_remove(struct i2c_client *client);
-static int gl520_read_value(struct i2c_client *client, u8 reg);
-static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value);
-static struct gl520_data *gl520_update_device(struct device *dev);
-
-/* Driver data */
-static const struct i2c_device_id gl520_id[] = {
-	{ "gl520sm", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, gl520_id);
-
-static struct i2c_driver gl520_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "gl520sm",
-	},
-	.probe		= gl520_probe,
-	.remove		= gl520_remove,
-	.id_table	= gl520_id,
-	.detect		= gl520_detect,
-	.address_list	= normal_i2c,
-};
-
 /* Client data */
 struct gl520_data {
 	struct device *hwmon_dev;
@@ -132,6 +100,102 @@ struct gl520_data {
 };
 
 /*
+ * Registers 0x07 to 0x0c are word-sized, others are byte-sized
+ * GL520 uses a high-byte first convention
+ */
+static int gl520_read_value(struct i2c_client *client, u8 reg)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return i2c_smbus_read_word_swapped(client, reg);
+	else
+		return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return i2c_smbus_write_word_swapped(client, reg, value);
+	else
+		return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static struct gl520_data *gl520_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int val, i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting gl520sm update\n");
+
+		data->alarms = gl520_read_value(client, GL520_REG_ALARMS);
+		data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
+		data->vid = gl520_read_value(client,
+					     GL520_REG_VID_INPUT) & 0x1f;
+
+		for (i = 0; i < 4; i++) {
+			data->in_input[i] = gl520_read_value(client,
+							GL520_REG_IN_INPUT[i]);
+			val = gl520_read_value(client, GL520_REG_IN_LIMIT[i]);
+			data->in_min[i] = val & 0xff;
+			data->in_max[i] = (val >> 8) & 0xff;
+		}
+
+		val = gl520_read_value(client, GL520_REG_FAN_INPUT);
+		data->fan_input[0] = (val >> 8) & 0xff;
+		data->fan_input[1] = val & 0xff;
+
+		val = gl520_read_value(client, GL520_REG_FAN_MIN);
+		data->fan_min[0] = (val >> 8) & 0xff;
+		data->fan_min[1] = val & 0xff;
+
+		data->temp_input[0] = gl520_read_value(client,
+						GL520_REG_TEMP_INPUT[0]);
+		data->temp_max[0] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX[0]);
+		data->temp_max_hyst[0] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX_HYST[0]);
+
+		val = gl520_read_value(client, GL520_REG_FAN_DIV);
+		data->fan_div[0] = (val >> 6) & 0x03;
+		data->fan_div[1] = (val >> 4) & 0x03;
+		data->fan_off = (val >> 2) & 0x01;
+
+		data->alarms &= data->alarm_mask;
+
+		val = gl520_read_value(client, GL520_REG_CONF);
+		data->beep_enable = !((val >> 2) & 1);
+
+		/* Temp1 and Vin4 are the same input */
+		if (data->two_temps) {
+			data->temp_input[1] = gl520_read_value(client,
+						GL520_REG_TEMP_INPUT[1]);
+			data->temp_max[1] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX[1]);
+			data->temp_max_hyst[1] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX_HYST[1]);
+		} else {
+			data->in_input[4] = gl520_read_value(client,
+						GL520_REG_IN_INPUT[4]);
+			data->in_min[4] = gl520_read_value(client,
+						GL520_REG_IN_MIN[4]);
+			data->in_max[4] = gl520_read_value(client,
+						GL520_REG_IN_MAX[4]);
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
  * Sysfs stuff
  */
 
@@ -772,6 +836,44 @@ static int gl520_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
+/* Called when we have found a new GL520SM. */
+static void gl520_init_client(struct i2c_client *client)
+{
+	struct gl520_data *data = i2c_get_clientdata(client);
+	u8 oldconf, conf;
+
+	conf = oldconf = gl520_read_value(client, GL520_REG_CONF);
+
+	data->alarm_mask = 0xff;
+	data->vrm = vid_which_vrm();
+
+	if (extra_sensor_type = 1)
+		conf &= ~0x10;
+	else if (extra_sensor_type = 2)
+		conf |= 0x10;
+	data->two_temps = !(conf & 0x10);
+
+	/* If IRQ# is disabled, we can safely force comparator mode */
+	if (!(conf & 0x20))
+		conf &= 0xf7;
+
+	/* Enable monitoring if needed */
+	conf |= 0x40;
+
+	if (conf != oldconf)
+		gl520_write_value(client, GL520_REG_CONF, conf);
+
+	gl520_update_device(&(client->dev));
+
+	if (data->fan_min[0] = 0)
+		data->alarm_mask &= ~0x20;
+	if (data->fan_min[1] = 0)
+		data->alarm_mask &= ~0x40;
+
+	data->beep_mask &= data->alarm_mask;
+	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
+}
+
 static int gl520_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
@@ -817,45 +919,6 @@ exit_remove_files:
 	return err;
 }
 
-
-/* Called when we have found a new GL520SM. */
-static void gl520_init_client(struct i2c_client *client)
-{
-	struct gl520_data *data = i2c_get_clientdata(client);
-	u8 oldconf, conf;
-
-	conf = oldconf = gl520_read_value(client, GL520_REG_CONF);
-
-	data->alarm_mask = 0xff;
-	data->vrm = vid_which_vrm();
-
-	if (extra_sensor_type = 1)
-		conf &= ~0x10;
-	else if (extra_sensor_type = 2)
-		conf |= 0x10;
-	data->two_temps = !(conf & 0x10);
-
-	/* If IRQ# is disabled, we can safely force comparator mode */
-	if (!(conf & 0x20))
-		conf &= 0xf7;
-
-	/* Enable monitoring if needed */
-	conf |= 0x40;
-
-	if (conf != oldconf)
-		gl520_write_value(client, GL520_REG_CONF, conf);
-
-	gl520_update_device(&(client->dev));
-
-	if (data->fan_min[0] = 0)
-		data->alarm_mask &= ~0x20;
-	if (data->fan_min[1] = 0)
-		data->alarm_mask &= ~0x40;
-
-	data->beep_mask &= data->alarm_mask;
-	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
-}
-
 static int gl520_remove(struct i2c_client *client)
 {
 	struct gl520_data *data = i2c_get_clientdata(client);
@@ -868,103 +931,23 @@ static int gl520_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id gl520_id[] = {
+	{ "gl520sm", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, gl520_id);
 
-/*
- * Registers 0x07 to 0x0c are word-sized, others are byte-sized
- * GL520 uses a high-byte first convention
- */
-static int gl520_read_value(struct i2c_client *client, u8 reg)
-{
-	if ((reg >= 0x07) && (reg <= 0x0c))
-		return i2c_smbus_read_word_swapped(client, reg);
-	else
-		return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value)
-{
-	if ((reg >= 0x07) && (reg <= 0x0c))
-		return i2c_smbus_write_word_swapped(client, reg, value);
-	else
-		return i2c_smbus_write_byte_data(client, reg, value);
-}
-
-
-static struct gl520_data *gl520_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct gl520_data *data = i2c_get_clientdata(client);
-	int val, i;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
-
-		dev_dbg(&client->dev, "Starting gl520sm update\n");
-
-		data->alarms = gl520_read_value(client, GL520_REG_ALARMS);
-		data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
-		data->vid = gl520_read_value(client,
-					     GL520_REG_VID_INPUT) & 0x1f;
-
-		for (i = 0; i < 4; i++) {
-			data->in_input[i] = gl520_read_value(client,
-							GL520_REG_IN_INPUT[i]);
-			val = gl520_read_value(client, GL520_REG_IN_LIMIT[i]);
-			data->in_min[i] = val & 0xff;
-			data->in_max[i] = (val >> 8) & 0xff;
-		}
-
-		val = gl520_read_value(client, GL520_REG_FAN_INPUT);
-		data->fan_input[0] = (val >> 8) & 0xff;
-		data->fan_input[1] = val & 0xff;
-
-		val = gl520_read_value(client, GL520_REG_FAN_MIN);
-		data->fan_min[0] = (val >> 8) & 0xff;
-		data->fan_min[1] = val & 0xff;
-
-		data->temp_input[0] = gl520_read_value(client,
-						GL520_REG_TEMP_INPUT[0]);
-		data->temp_max[0] = gl520_read_value(client,
-						GL520_REG_TEMP_MAX[0]);
-		data->temp_max_hyst[0] = gl520_read_value(client,
-						GL520_REG_TEMP_MAX_HYST[0]);
-
-		val = gl520_read_value(client, GL520_REG_FAN_DIV);
-		data->fan_div[0] = (val >> 6) & 0x03;
-		data->fan_div[1] = (val >> 4) & 0x03;
-		data->fan_off = (val >> 2) & 0x01;
-
-		data->alarms &= data->alarm_mask;
-
-		val = gl520_read_value(client, GL520_REG_CONF);
-		data->beep_enable = !((val >> 2) & 1);
-
-		/* Temp1 and Vin4 are the same input */
-		if (data->two_temps) {
-			data->temp_input[1] = gl520_read_value(client,
-						GL520_REG_TEMP_INPUT[1]);
-			data->temp_max[1] = gl520_read_value(client,
-						GL520_REG_TEMP_MAX[1]);
-			data->temp_max_hyst[1] = gl520_read_value(client,
-						GL520_REG_TEMP_MAX_HYST[1]);
-		} else {
-			data->in_input[4] = gl520_read_value(client,
-						GL520_REG_IN_INPUT[4]);
-			data->in_min[4] = gl520_read_value(client,
-						GL520_REG_IN_MIN[4]);
-			data->in_max[4] = gl520_read_value(client,
-						GL520_REG_IN_MAX[4]);
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
+static struct i2c_driver gl520_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "gl520sm",
+	},
+	.probe		= gl520_probe,
+	.remove		= gl520_remove,
+	.id_table	= gl520_id,
+	.detect		= gl520_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(gl520_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
