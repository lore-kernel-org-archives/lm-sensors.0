From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:45:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1021) Avoid forward declaration
Message-Id: <1404395133.4895.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1021.c | 175 +++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 92 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 3eb4281..7f7635b 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -98,41 +98,63 @@ struct adm1021_data {
 	u8 remote_temp_offset_prec;
 };
 
-static int adm1021_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adm1021_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static void adm1021_init_client(struct i2c_client *client);
-static struct adm1021_data *adm1021_update_device(struct device *dev);
-
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
 static bool read_only;
 
+static struct adm1021_data *adm1021_update_device(struct device *dev)
+{
+	struct adm1021_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
-static const struct i2c_device_id adm1021_id[] = {
-	{ "adm1021", adm1021 },
-	{ "adm1023", adm1023 },
-	{ "max1617", max1617 },
-	{ "max1617a", max1617a },
-	{ "thmc10", thmc10 },
-	{ "lm84", lm84 },
-	{ "gl523sm", gl523sm },
-	{ "mc1066", mc1066 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1021_id);
+	mutex_lock(&data->update_lock);
 
-/* This is the driver that will be inserted */
-static struct i2c_driver adm1021_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "adm1021",
-	},
-	.probe		= adm1021_probe,
-	.id_table	= adm1021_id,
-	.detect		= adm1021_detect,
-	.address_list	= normal_i2c,
-};
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+
+		dev_dbg(dev, "Starting adm1021 update\n");
+
+		for (i = 0; i < 2; i++) {
+			data->temp[i] = 1000 *
+				(s8) i2c_smbus_read_byte_data(
+					client, ADM1021_REG_TEMP(i));
+			data->temp_max[i] = 1000 *
+				(s8) i2c_smbus_read_byte_data(
+					client, ADM1021_REG_TOS_R(i));
+			if (data->type != lm84) {
+				data->temp_min[i] = 1000 *
+				  (s8) i2c_smbus_read_byte_data(client,
+							ADM1021_REG_THYST_R(i));
+			}
+		}
+		data->alarms = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_STATUS) & 0x7c;
+		if (data->type = adm1023) {
+			/*
+			 * The ADM1023 provides 3 extra bits of precision for
+			 * the remote sensor in extra registers.
+			 */
+			data->temp[1] += 125 * (i2c_smbus_read_byte_data(
+				client, ADM1023_REG_REM_TEMP_PREC) >> 5);
+			data->temp_max[1] += 125 * (i2c_smbus_read_byte_data(
+				client, ADM1023_REG_REM_TOS_PREC) >> 5);
+			data->temp_min[1] += 125 * (i2c_smbus_read_byte_data(
+				client, ADM1023_REG_REM_THYST_PREC) >> 5);
+			data->remote_temp_offset +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_OFFSET);
+			data->remote_temp_offset_prec +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_OFFSET_PREC);
+		}
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 static ssize_t show_temp(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
@@ -409,6 +431,15 @@ static int adm1021_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void adm1021_init_client(struct i2c_client *client)
+{
+	/* Enable ADC and disable suspend mode */
+	i2c_smbus_write_byte_data(client, ADM1021_REG_CONFIG_W,
+		i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R) & 0xBF);
+	/* Set Conversion rate to 1/sec (this can be tinkered with) */
+	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 0x04);
+}
+
 static int adm1021_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -438,69 +469,29 @@ static int adm1021_probe(struct i2c_client *client,
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static void adm1021_init_client(struct i2c_client *client)
-{
-	/* Enable ADC and disable suspend mode */
-	i2c_smbus_write_byte_data(client, ADM1021_REG_CONFIG_W,
-		i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R) & 0xBF);
-	/* Set Conversion rate to 1/sec (this can be tinkered with) */
-	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 0x04);
-}
-
-static struct adm1021_data *adm1021_update_device(struct device *dev)
-{
-	struct adm1021_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		int i;
-
-		dev_dbg(dev, "Starting adm1021 update\n");
-
-		for (i = 0; i < 2; i++) {
-			data->temp[i] = 1000 *
-				(s8) i2c_smbus_read_byte_data(
-					client, ADM1021_REG_TEMP(i));
-			data->temp_max[i] = 1000 *
-				(s8) i2c_smbus_read_byte_data(
-					client, ADM1021_REG_TOS_R(i));
-			if (data->type != lm84) {
-				data->temp_min[i] = 1000 *
-				  (s8) i2c_smbus_read_byte_data(client,
-							ADM1021_REG_THYST_R(i));
-			}
-		}
-		data->alarms = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_STATUS) & 0x7c;
-		if (data->type = adm1023) {
-			/*
-			 * The ADM1023 provides 3 extra bits of precision for
-			 * the remote sensor in extra registers.
-			 */
-			data->temp[1] += 125 * (i2c_smbus_read_byte_data(
-				client, ADM1023_REG_REM_TEMP_PREC) >> 5);
-			data->temp_max[1] += 125 * (i2c_smbus_read_byte_data(
-				client, ADM1023_REG_REM_TOS_PREC) >> 5);
-			data->temp_min[1] += 125 * (i2c_smbus_read_byte_data(
-				client, ADM1023_REG_REM_THYST_PREC) >> 5);
-			data->remote_temp_offset -				i2c_smbus_read_byte_data(client,
-						ADM1023_REG_REM_OFFSET);
-			data->remote_temp_offset_prec -				i2c_smbus_read_byte_data(client,
-						ADM1023_REG_REM_OFFSET_PREC);
-		}
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id adm1021_id[] = {
+	{ "adm1021", adm1021 },
+	{ "adm1023", adm1023 },
+	{ "max1617", max1617 },
+	{ "max1617a", max1617a },
+	{ "thmc10", thmc10 },
+	{ "lm84", lm84 },
+	{ "gl523sm", gl523sm },
+	{ "mc1066", mc1066 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1021_id);
 
-	return data;
-}
+static struct i2c_driver adm1021_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "adm1021",
+	},
+	.probe		= adm1021_probe,
+	.id_table	= adm1021_id,
+	.detect		= adm1021_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(adm1021_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
