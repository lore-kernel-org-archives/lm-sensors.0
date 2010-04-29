From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 29 Apr 2010 19:17:02 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (tmp401) Reorganize code to get rid
Message-Id: <1272568622-3385-2-git-send-email-andre.prendel@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---
 drivers/hwmon/tmp401.c |  249 +++++++++++++++++++++++-------------------------
 1 files changed, 119 insertions(+), 130 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index d58b40a..bd664ac 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -92,17 +92,6 @@ static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
 #define TMP411_DEVICE_ID			0x12
 
 /*
- * Functions declarations
- */
-
-static int tmp401_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
-static int tmp401_detect(struct i2c_client *client,
-			 struct i2c_board_info *info);
-static int tmp401_remove(struct i2c_client *client);
-static struct tmp401_data *tmp401_update_device(struct device *dev);
-
-/*
  * Driver data (common to all clients)
  */
 
@@ -113,18 +102,6 @@ static const struct i2c_device_id tmp401_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tmp401_id);
 
-static struct i2c_driver tmp401_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "tmp401",
-	},
-	.probe		= tmp401_probe,
-	.remove		= tmp401_remove,
-	.id_table	= tmp401_id,
-	.detect		= tmp401_detect,
-	.address_list	= normal_i2c,
-};
-
 /*
  * Client data (each client gets its own)
  */
@@ -194,6 +171,71 @@ static u8 tmp401_crit_temp_to_register(long temp, u8 config)
 	return (temp + 500) / 1000;
 }
 
+static struct tmp401_data *tmp401_update_device_reg16(
+	struct i2c_client *client, struct tmp401_data *data)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		/*
+		 * High byte must be read first immediately followed
+		 * by the low byte
+		 */
+		data->temp[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_MSB[i]) << 8;
+		data->temp[i] |= i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_LSB[i]);
+		data->temp_low[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_LOW_LIMIT_MSB_READ[i]) << 8;
+		data->temp_low[i] |= i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_LOW_LIMIT_LSB[i]);
+		data->temp_high[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_HIGH_LIMIT_MSB_READ[i]) << 8;
+		data->temp_high[i] |= i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_HIGH_LIMIT_LSB[i]);
+		data->temp_crit[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_CRIT_LIMIT[i]);
+
+		if (data->kind = tmp411) {
+			data->temp_lowest[i] = i2c_smbus_read_byte_data(client,
+				TMP411_TEMP_LOWEST_MSB[i]) << 8;
+			data->temp_lowest[i] |= i2c_smbus_read_byte_data(
+				client, TMP411_TEMP_LOWEST_LSB[i]);
+
+			data->temp_highest[i] = i2c_smbus_read_byte_data(
+				client, TMP411_TEMP_HIGHEST_MSB[i]) << 8;
+			data->temp_highest[i] |= i2c_smbus_read_byte_data(
+				client, TMP411_TEMP_HIGHEST_LSB[i]);
+		}
+	}
+	return data;
+}
+
+static struct tmp401_data *tmp401_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tmp401_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		data->status = i2c_smbus_read_byte_data(client, TMP401_STATUS);
+		data->config = i2c_smbus_read_byte_data(client,
+						TMP401_CONFIG_READ);
+		tmp401_update_device_reg16(client, data);
+
+		data->temp_crit_hyst = i2c_smbus_read_byte_data(client,
+						TMP401_TEMP_CRIT_HYST);
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
 static ssize_t show_temp_value(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
@@ -493,45 +535,24 @@ static void tmp401_init_client(struct i2c_client *client)
 		i2c_smbus_write_byte_data(client, TMP401_CONFIG_WRITE, config);
 }
 
-static int tmp401_detect(struct i2c_client *client,
-			 struct i2c_board_info *info)
+static int tmp401_remove(struct i2c_client *client)
 {
-	enum chips kind;
-	struct i2c_adapter *adapter = client->adapter;
-	u8 reg;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
+	struct tmp401_data *data = i2c_get_clientdata(client);
+	int i;
 
-	/* Detect and identify the chip */
-	reg = i2c_smbus_read_byte_data(client, TMP401_MANUFACTURER_ID_REG);
-	if (reg != TMP401_MANUFACTURER_ID)
-		return -ENODEV;
+	if (data->hwmon_dev)
+		hwmon_device_unregister(data->hwmon_dev);
 
-	reg = i2c_smbus_read_byte_data(client, TMP401_DEVICE_ID_REG);
+	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++)
+		device_remove_file(&client->dev, &tmp401_attr[i].dev_attr);
 
-	switch (reg) {
-	case TMP401_DEVICE_ID:
-		kind = tmp401;
-		break;
-	case TMP411_DEVICE_ID:
-		kind = tmp411;
-		break;
-	default:
-		return -ENODEV;
+	if (data->kind = tmp411) {
+		for (i = 0; i < ARRAY_SIZE(tmp411_attr); i++)
+			device_remove_file(&client->dev,
+					   &tmp411_attr[i].dev_attr);
 	}
 
-	reg = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
-	if (reg & 0x1b)
-		return -ENODEV;
-
-	reg = i2c_smbus_read_byte_data(client, TMP401_CONVERSION_RATE_READ);
-	/* Datasheet says: 0x1-0x6 */
-	if (reg > 15)
-		return -ENODEV;
-
-	strlcpy(info->type, tmp401_id[kind].name, I2C_NAME_SIZE);
-
+	kfree(data);
 	return 0;
 }
 
@@ -587,92 +608,60 @@ exit_remove:
 	return err;
 }
 
-static int tmp401_remove(struct i2c_client *client)
+static int tmp401_detect(struct i2c_client *client,
+			 struct i2c_board_info *info)
 {
-	struct tmp401_data *data = i2c_get_clientdata(client);
-	int i;
-
-	if (data->hwmon_dev)
-		hwmon_device_unregister(data->hwmon_dev);
-
-	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++)
-		device_remove_file(&client->dev, &tmp401_attr[i].dev_attr);
-
-	if (data->kind = tmp411) {
-		for (i = 0; i < ARRAY_SIZE(tmp411_attr); i++)
-			device_remove_file(&client->dev,
-					   &tmp411_attr[i].dev_attr);
-	}
-
-	kfree(data);
-	return 0;
-}
+	enum chips kind;
+	struct i2c_adapter *adapter = client->adapter;
+	u8 reg;
 
-static struct tmp401_data *tmp401_update_device_reg16(
-	struct i2c_client *client, struct tmp401_data *data)
-{
-	int i;
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
 
-	for (i = 0; i < 2; i++) {
-		/*
-		 * High byte must be read first immediately followed
-		 * by the low byte
-		 */
-		data->temp[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_MSB[i]) << 8;
-		data->temp[i] |= i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_LSB[i]);
-		data->temp_low[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_LOW_LIMIT_MSB_READ[i]) << 8;
-		data->temp_low[i] |= i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_LOW_LIMIT_LSB[i]);
-		data->temp_high[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_HIGH_LIMIT_MSB_READ[i]) << 8;
-		data->temp_high[i] |= i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_HIGH_LIMIT_LSB[i]);
-		data->temp_crit[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_CRIT_LIMIT[i]);
+	/* Detect and identify the chip */
+	reg = i2c_smbus_read_byte_data(client, TMP401_MANUFACTURER_ID_REG);
+	if (reg != TMP401_MANUFACTURER_ID)
+		return -ENODEV;
 
-		if (data->kind = tmp411) {
-			data->temp_lowest[i] = i2c_smbus_read_byte_data(client,
-				TMP411_TEMP_LOWEST_MSB[i]) << 8;
-			data->temp_lowest[i] |= i2c_smbus_read_byte_data(
-				client, TMP411_TEMP_LOWEST_LSB[i]);
+	reg = i2c_smbus_read_byte_data(client, TMP401_DEVICE_ID_REG);
 
-			data->temp_highest[i] = i2c_smbus_read_byte_data(
-				client, TMP411_TEMP_HIGHEST_MSB[i]) << 8;
-			data->temp_highest[i] |= i2c_smbus_read_byte_data(
-				client, TMP411_TEMP_HIGHEST_LSB[i]);
-		}
+	switch (reg) {
+	case TMP401_DEVICE_ID:
+		kind = tmp401;
+		break;
+	case TMP411_DEVICE_ID:
+		kind = tmp411;
+		break;
+	default:
+		return -ENODEV;
 	}
-	return data;
-}
 
-static struct tmp401_data *tmp401_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct tmp401_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		data->status = i2c_smbus_read_byte_data(client, TMP401_STATUS);
-		data->config = i2c_smbus_read_byte_data(client,
-						TMP401_CONFIG_READ);
-		tmp401_update_device_reg16(client, data);
-
-		data->temp_crit_hyst = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_CRIT_HYST);
+	reg = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
+	if (reg & 0x1b)
+		return -ENODEV;
 
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
+	reg = i2c_smbus_read_byte_data(client, TMP401_CONVERSION_RATE_READ);
+	/* Datasheet says: 0x1-0x6 */
+	if (reg > 15)
+		return -ENODEV;
 
-	mutex_unlock(&data->update_lock);
+	strlcpy(info->type, tmp401_id[kind].name, I2C_NAME_SIZE);
 
-	return data;
+	return 0;
 }
 
+static struct i2c_driver tmp401_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "tmp401",
+	},
+	.probe		= tmp401_probe,
+	.remove		= tmp401_remove,
+	.id_table	= tmp401_id,
+	.detect		= tmp401_detect,
+	.address_list	= normal_i2c,
+};
+
 static int __init tmp401_init(void)
 {
 	return i2c_add_driver(&tmp401_driver);
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
