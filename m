From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 01:41:08 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm1029) Avoid forward declaration
Message-Id: <1404006068.19191.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1029.c | 171 ++++++++++++++++++++++--------------------------
 1 file changed, 78 insertions(+), 93 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 78339e8..7782de9 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -106,40 +106,6 @@ static const u8 ADM1029_REG_FAN_DIV[] = {
 };
 
 /*
- * Functions declaration
- */
-
-static int adm1029_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adm1029_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static int adm1029_remove(struct i2c_client *client);
-static struct adm1029_data *adm1029_update_device(struct device *dev);
-static int adm1029_init_client(struct i2c_client *client);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id adm1029_id[] = {
-	{ "adm1029", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1029_id);
-
-static struct i2c_driver adm1029_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name = "adm1029",
-	},
-	.probe		= adm1029_probe,
-	.remove		= adm1029_remove,
-	.id_table	= adm1029_id,
-	.detect		= adm1029_detect,
-	.address_list	= normal_i2c,
-};
-
-/*
  * Client data (each client gets its own)
  */
 
@@ -156,6 +122,50 @@ struct adm1029_data {
 };
 
 /*
+ * function that update the status of the chips (temperature for example)
+ */
+static struct adm1029_data *adm1029_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1029_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	/*
+	 * Use the "cache" Luke, don't recheck values
+	 * if there are already checked not a long time later
+	 */
+	if (time_after(jiffies, data->last_updated + HZ * 2)
+	 || !data->valid) {
+		int nr;
+
+		dev_dbg(&client->dev, "Updating adm1029 data\n");
+
+		for (nr = 0; nr < ARRAY_SIZE(ADM1029_REG_TEMP); nr++) {
+			data->temp[nr] +			    i2c_smbus_read_byte_data(client,
+						     ADM1029_REG_TEMP[nr]);
+		}
+		for (nr = 0; nr < ARRAY_SIZE(ADM1029_REG_FAN); nr++) {
+			data->fan[nr] +			    i2c_smbus_read_byte_data(client,
+						     ADM1029_REG_FAN[nr]);
+		}
+		for (nr = 0; nr < ARRAY_SIZE(ADM1029_REG_FAN_DIV); nr++) {
+			data->fan_div[nr] +			    i2c_smbus_read_byte_data(client,
+						     ADM1029_REG_FAN_DIV[nr]);
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
 
@@ -337,6 +347,24 @@ static int adm1029_detect(struct i2c_client *client,
 	return 0;
 }
 
+static int adm1029_init_client(struct i2c_client *client)
+{
+	u8 config;
+
+	config = i2c_smbus_read_byte_data(client, ADM1029_REG_CONFIG);
+	if ((config & 0x10) = 0) {
+		i2c_smbus_write_byte_data(client, ADM1029_REG_CONFIG,
+					  config | 0x10);
+	}
+	/* recheck config */
+	config = i2c_smbus_read_byte_data(client, ADM1029_REG_CONFIG);
+	if ((config & 0x10) = 0) {
+		dev_err(&client->dev, "Initialization failed!\n");
+		return 0;
+	}
+	return 1;
+}
+
 static int adm1029_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -376,23 +404,6 @@ static int adm1029_probe(struct i2c_client *client,
 	return err;
 }
 
-static int adm1029_init_client(struct i2c_client *client)
-{
-	u8 config;
-	config = i2c_smbus_read_byte_data(client, ADM1029_REG_CONFIG);
-	if ((config & 0x10) = 0) {
-		i2c_smbus_write_byte_data(client, ADM1029_REG_CONFIG,
-					  config | 0x10);
-	}
-	/* recheck config */
-	config = i2c_smbus_read_byte_data(client, ADM1029_REG_CONFIG);
-	if ((config & 0x10) = 0) {
-		dev_err(&client->dev, "Initialization failed!\n");
-		return 0;
-	}
-	return 1;
-}
-
 static int adm1029_remove(struct i2c_client *client)
 {
 	struct adm1029_data *data = i2c_get_clientdata(client);
@@ -403,49 +414,23 @@ static int adm1029_remove(struct i2c_client *client)
 	return 0;
 }
 
-/*
- * function that update the status of the chips (temperature for example)
- */
-static struct adm1029_data *adm1029_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1029_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-	/*
-	 * Use the "cache" Luke, don't recheck values
-	 * if there are already checked not a long time later
-	 */
-	if (time_after(jiffies, data->last_updated + HZ * 2)
-	 || !data->valid) {
-		int nr;
-
-		dev_dbg(&client->dev, "Updating adm1029 data\n");
-
-		for (nr = 0; nr < ARRAY_SIZE(ADM1029_REG_TEMP); nr++) {
-			data->temp[nr] -			    i2c_smbus_read_byte_data(client,
-						     ADM1029_REG_TEMP[nr]);
-		}
-		for (nr = 0; nr < ARRAY_SIZE(ADM1029_REG_FAN); nr++) {
-			data->fan[nr] -			    i2c_smbus_read_byte_data(client,
-						     ADM1029_REG_FAN[nr]);
-		}
-		for (nr = 0; nr < ARRAY_SIZE(ADM1029_REG_FAN_DIV); nr++) {
-			data->fan_div[nr] -			    i2c_smbus_read_byte_data(client,
-						     ADM1029_REG_FAN_DIV[nr]);
-		}
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id adm1029_id[] = {
+	{ "adm1029", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1029_id);
 
-	return data;
-}
+static struct i2c_driver adm1029_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name = "adm1029",
+	},
+	.probe		= adm1029_probe,
+	.remove		= adm1029_remove,
+	.id_table	= adm1029_id,
+	.detect		= adm1029_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(adm1029_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
