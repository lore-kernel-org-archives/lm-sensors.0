From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 Apr 2014 22:28:11 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (max1619) Rearrange code to avoid forward declarations
Message-Id: <1397946493-4455-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forward declarations are unnecessary and easy to avoid, so rearrange
code and drop them.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1619.c |  158 +++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 89 deletions(-)

diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 9a8d7ca..c8a7297 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -72,40 +72,6 @@ static int temp_to_reg(int val)
 }
 
 /*
- * Functions declaration
- */
-
-static int max1619_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int max1619_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static void max1619_init_client(struct i2c_client *client);
-static int max1619_remove(struct i2c_client *client);
-static struct max1619_data *max1619_update_device(struct device *dev);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id max1619_id[] = {
-	{ "max1619", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, max1619_id);
-
-static struct i2c_driver max1619_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "max1619",
-	},
-	.probe		= max1619_probe,
-	.remove		= max1619_remove,
-	.id_table	= max1619_id,
-	.detect		= max1619_detect,
-	.address_list	= normal_i2c,
-};
-
-/*
  * Client data (each client gets its own)
  */
 
@@ -123,6 +89,44 @@ struct max1619_data {
 	u8 alarms;
 };
 
+static struct max1619_data *max1619_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max1619_data *data = i2c_get_clientdata(client);
+	int config;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
+		dev_dbg(&client->dev, "Updating max1619 data.\n");
+		data->temp_input1 = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_LOCAL_TEMP);
+		data->temp_input2 = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_REMOTE_TEMP);
+		data->temp_high2 = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_REMOTE_HIGH);
+		data->temp_low2 = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_REMOTE_LOW);
+		data->temp_crit2 = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_REMOTE_CRIT);
+		data->temp_hyst2 = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_TCRIT_HYST);
+		data->alarms = i2c_smbus_read_byte_data(client,
+					MAX1619_REG_R_STATUS);
+		/* If OVERT polarity is low, reverse alarm bit */
+		config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
+		if (!(config & 0x20))
+			data->alarms ^= 0x02;
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
 /*
  * Sysfs stuff
  */
@@ -216,10 +220,6 @@ static const struct attribute_group max1619_group = {
 	.attrs = max1619_attributes,
 };
 
-/*
- * Real code
- */
-
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int max1619_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -256,6 +256,21 @@ static int max1619_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void max1619_init_client(struct i2c_client *client)
+{
+	u8 config;
+
+	/*
+	 * Start the conversions.
+	 */
+	i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONVRATE,
+				  5); /* 2 Hz */
+	config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
+	if (config & 0x40)
+		i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONFIG,
+					  config & 0xBF); /* run */
+}
+
 static int max1619_probe(struct i2c_client *new_client,
 			 const struct i2c_device_id *id)
 {
@@ -291,21 +306,6 @@ exit_remove_files:
 	return err;
 }
 
-static void max1619_init_client(struct i2c_client *client)
-{
-	u8 config;
-
-	/*
-	 * Start the conversions.
-	 */
-	i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONVRATE,
-				  5); /* 2 Hz */
-	config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
-	if (config & 0x40)
-		i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONFIG,
-					  config & 0xBF); /* run */
-}
-
 static int max1619_remove(struct i2c_client *client)
 {
 	struct max1619_data *data = i2c_get_clientdata(client);
@@ -316,43 +316,23 @@ static int max1619_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct max1619_data *max1619_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max1619_data *data = i2c_get_clientdata(client);
-	int config;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
-		dev_dbg(&client->dev, "Updating max1619 data.\n");
-		data->temp_input1 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_LOCAL_TEMP);
-		data->temp_input2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_TEMP);
-		data->temp_high2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_HIGH);
-		data->temp_low2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_LOW);
-		data->temp_crit2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_CRIT);
-		data->temp_hyst2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_TCRIT_HYST);
-		data->alarms = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_STATUS);
-		/* If OVERT polarity is low, reverse alarm bit */
-		config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
-		if (!(config & 0x20))
-			data->alarms ^= 0x02;
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id max1619_id[] = {
+	{ "max1619", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max1619_id);
 
-	return data;
-}
+static struct i2c_driver max1619_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "max1619",
+	},
+	.probe		= max1619_probe,
+	.remove		= max1619_remove,
+	.id_table	= max1619_id,
+	.detect		= max1619_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(max1619_driver);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
