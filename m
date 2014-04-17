From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 17 Apr 2014 05:05:32 +0000
Subject: [lm-sensors] [PATCH v2 1/3] hwmon: (lm77) Rearrange code to no longer require forward declarations
Message-Id: <1397711134-10501-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forward declarations are easy to avoid and unnecessary.
Rearrange code to avoid it.

No functional change.

Acked-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Moved lm77_init_client after detect function
    and before probe function.

 drivers/hwmon/lm77.c |  173 +++++++++++++++++++++++---------------------------
 1 file changed, 81 insertions(+), 92 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 6422162..4cd8a513 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -57,36 +57,6 @@ struct lm77_data {
 	u8			alarms;
 };
 
-static int lm77_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info);
-static void lm77_init_client(struct i2c_client *client);
-static int lm77_remove(struct i2c_client *client);
-static u16 lm77_read_value(struct i2c_client *client, u8 reg);
-static int lm77_write_value(struct i2c_client *client, u8 reg, u16 value);
-
-static struct lm77_data *lm77_update_device(struct device *dev);
-
-
-static const struct i2c_device_id lm77_id[] = {
-	{ "lm77", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm77_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver lm77_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm77",
-	},
-	.probe		= lm77_probe,
-	.remove		= lm77_remove,
-	.id_table	= lm77_id,
-	.detect		= lm77_detect,
-	.address_list	= normal_i2c,
-};
-
 /* straight from the datasheet */
 #define LM77_TEMP_MIN (-55000)
 #define LM77_TEMP_MAX 125000
@@ -106,6 +76,62 @@ static inline int LM77_TEMP_FROM_REG(s16 reg)
 	return (reg / 8) * 500;
 }
 
+/*
+ * All registers are word-sized, except for the configuration register.
+ * The LM77 uses the high-byte first convention.
+ */
+static u16 lm77_read_value(struct i2c_client *client, u8 reg)
+{
+	if (reg = LM77_REG_CONF)
+		return i2c_smbus_read_byte_data(client, reg);
+	else
+		return i2c_smbus_read_word_swapped(client, reg);
+}
+
+static int lm77_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if (reg = LM77_REG_CONF)
+		return i2c_smbus_write_byte_data(client, reg, value);
+	else
+		return i2c_smbus_write_word_swapped(client, reg, value);
+}
+
+static struct lm77_data *lm77_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm77_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		dev_dbg(&client->dev, "Starting lm77 update\n");
+		data->temp_input +			LM77_TEMP_FROM_REG(lm77_read_value(client,
+							   LM77_REG_TEMP));
+		data->temp_hyst +			LM77_TEMP_FROM_REG(lm77_read_value(client,
+							   LM77_REG_TEMP_HYST));
+		data->temp_crit +			LM77_TEMP_FROM_REG(lm77_read_value(client,
+							   LM77_REG_TEMP_CRIT));
+		data->temp_min +			LM77_TEMP_FROM_REG(lm77_read_value(client,
+							   LM77_REG_TEMP_MIN));
+		data->temp_max +			LM77_TEMP_FROM_REG(lm77_read_value(client,
+							   LM77_REG_TEMP_MAX));
+		data->alarms +			lm77_read_value(client, LM77_REG_TEMP) & 0x0007;
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
 /* sysfs stuff */
 
 /* read routines for temperature limits */
@@ -333,6 +359,14 @@ static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
+static void lm77_init_client(struct i2c_client *client)
+{
+	/* Initialize the LM77 chip - turn off shutdown mode */
+	int conf = lm77_read_value(client, LM77_REG_CONF);
+	if (conf & 1)
+		lm77_write_value(client, LM77_REG_CONF, conf & 0xfe);
+}
+
 static int lm77_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
@@ -375,69 +409,24 @@ static int lm77_remove(struct i2c_client *client)
 	return 0;
 }
 
-/*
- * All registers are word-sized, except for the configuration register.
- * The LM77 uses the high-byte first convention.
- */
-static u16 lm77_read_value(struct i2c_client *client, u8 reg)
-{
-	if (reg = LM77_REG_CONF)
-		return i2c_smbus_read_byte_data(client, reg);
-	else
-		return i2c_smbus_read_word_swapped(client, reg);
-}
-
-static int lm77_write_value(struct i2c_client *client, u8 reg, u16 value)
-{
-	if (reg = LM77_REG_CONF)
-		return i2c_smbus_write_byte_data(client, reg, value);
-	else
-		return i2c_smbus_write_word_swapped(client, reg, value);
-}
-
-static void lm77_init_client(struct i2c_client *client)
-{
-	/* Initialize the LM77 chip - turn off shutdown mode */
-	int conf = lm77_read_value(client, LM77_REG_CONF);
-	if (conf & 1)
-		lm77_write_value(client, LM77_REG_CONF, conf & 0xfe);
-}
-
-static struct lm77_data *lm77_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm77_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		dev_dbg(&client->dev, "Starting lm77 update\n");
-		data->temp_input -			LM77_TEMP_FROM_REG(lm77_read_value(client,
-							   LM77_REG_TEMP));
-		data->temp_hyst -			LM77_TEMP_FROM_REG(lm77_read_value(client,
-							   LM77_REG_TEMP_HYST));
-		data->temp_crit -			LM77_TEMP_FROM_REG(lm77_read_value(client,
-							   LM77_REG_TEMP_CRIT));
-		data->temp_min -			LM77_TEMP_FROM_REG(lm77_read_value(client,
-							   LM77_REG_TEMP_MIN));
-		data->temp_max -			LM77_TEMP_FROM_REG(lm77_read_value(client,
-							   LM77_REG_TEMP_MAX));
-		data->alarms -			lm77_read_value(client, LM77_REG_TEMP) & 0x0007;
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id lm77_id[] = {
+	{ "lm77", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm77_id);
 
-	return data;
-}
+/* This is the driver that will be inserted */
+static struct i2c_driver lm77_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm77",
+	},
+	.probe		= lm77_probe,
+	.remove		= lm77_remove,
+	.id_table	= lm77_id,
+	.detect		= lm77_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(lm77_driver);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
