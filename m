From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 17 Jul 2014 11:05:23 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (thmc50) Avoid forward declaration
Message-Id: <1405595123.13586.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/thmc50.c | 160 +++++++++++++++++++++++--------------------------
 1 file changed, 76 insertions(+), 84 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index db288db..bb538da 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -85,32 +85,47 @@ struct thmc50_data {
 	u8 alarms;
 };
 
-static int thmc50_detect(struct i2c_client *client,
-			 struct i2c_board_info *info);
-static int thmc50_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
-static int thmc50_remove(struct i2c_client *client);
-static void thmc50_init_client(struct i2c_client *client);
-static struct thmc50_data *thmc50_update_device(struct device *dev);
+static struct thmc50_data *thmc50_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int timeout = HZ / 5 + (data->type = thmc50 ? HZ : 0);
 
-static const struct i2c_device_id thmc50_id[] = {
-	{ "adm1022", adm1022 },
-	{ "thmc50", thmc50 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, thmc50_id);
+	mutex_lock(&data->update_lock);
 
-static struct i2c_driver thmc50_driver = {
-	.class = I2C_CLASS_HWMON,
-	.driver = {
-		.name = "thmc50",
-	},
-	.probe = thmc50_probe,
-	.remove = thmc50_remove,
-	.id_table = thmc50_id,
-	.detect = thmc50_detect,
-	.address_list = normal_i2c,
-};
+	if (time_after(jiffies, data->last_updated + timeout)
+	    || !data->valid) {
+
+		int temps = data->has_temp3 ? 3 : 2;
+		int i;
+		int prog = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
+
+		prog &= THMC50_REG_CONF_PROGRAMMED;
+
+		for (i = 0; i < temps; i++) {
+			data->temp_input[i] = i2c_smbus_read_byte_data(client,
+						THMC50_REG_TEMP[i]);
+			data->temp_max[i] = i2c_smbus_read_byte_data(client,
+						THMC50_REG_TEMP_MAX[i]);
+			data->temp_min[i] = i2c_smbus_read_byte_data(client,
+						THMC50_REG_TEMP_MIN[i]);
+			data->temp_critical[i] +				i2c_smbus_read_byte_data(client,
+					prog ? THMC50_REG_TEMP_CRITICAL[i]
+					     : THMC50_REG_TEMP_DEFAULT[i]);
+		}
+		data->analog_out +		    i2c_smbus_read_byte_data(client, THMC50_REG_ANALOG_OUT);
+		data->alarms +		    i2c_smbus_read_byte_data(client, THMC50_REG_INTR);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 static ssize_t show_analog_out(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -355,6 +370,26 @@ static int thmc50_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void thmc50_init_client(struct i2c_client *client)
+{
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int config;
+
+	data->analog_out = i2c_smbus_read_byte_data(client,
+						    THMC50_REG_ANALOG_OUT);
+	/* set up to at least 1 */
+	if (data->analog_out = 0) {
+		data->analog_out = 1;
+		i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
+					  data->analog_out);
+	}
+	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
+	config |= 0x1;	/* start the chip if it is in standby mode */
+	if (data->type = adm1022 && (config & (1 << 7)))
+		data->has_temp3 = 1;
+	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
+}
+
 static int thmc50_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -413,67 +448,24 @@ static int thmc50_remove(struct i2c_client *client)
 	return 0;
 }
 
-static void thmc50_init_client(struct i2c_client *client)
-{
-	struct thmc50_data *data = i2c_get_clientdata(client);
-	int config;
-
-	data->analog_out = i2c_smbus_read_byte_data(client,
-						    THMC50_REG_ANALOG_OUT);
-	/* set up to at least 1 */
-	if (data->analog_out = 0) {
-		data->analog_out = 1;
-		i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
-					  data->analog_out);
-	}
-	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
-	config |= 0x1;	/* start the chip if it is in standby mode */
-	if (data->type = adm1022 && (config & (1 << 7)))
-		data->has_temp3 = 1;
-	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
-}
-
-static struct thmc50_data *thmc50_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thmc50_data *data = i2c_get_clientdata(client);
-	int timeout = HZ / 5 + (data->type = thmc50 ? HZ : 0);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + timeout)
-	    || !data->valid) {
-
-		int temps = data->has_temp3 ? 3 : 2;
-		int i;
-		int prog = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
-
-		prog &= THMC50_REG_CONF_PROGRAMMED;
-
-		for (i = 0; i < temps; i++) {
-			data->temp_input[i] = i2c_smbus_read_byte_data(client,
-						THMC50_REG_TEMP[i]);
-			data->temp_max[i] = i2c_smbus_read_byte_data(client,
-						THMC50_REG_TEMP_MAX[i]);
-			data->temp_min[i] = i2c_smbus_read_byte_data(client,
-						THMC50_REG_TEMP_MIN[i]);
-			data->temp_critical[i] -				i2c_smbus_read_byte_data(client,
-					prog ? THMC50_REG_TEMP_CRITICAL[i]
-					     : THMC50_REG_TEMP_DEFAULT[i]);
-		}
-		data->analog_out -		    i2c_smbus_read_byte_data(client, THMC50_REG_ANALOG_OUT);
-		data->alarms -		    i2c_smbus_read_byte_data(client, THMC50_REG_INTR);
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id thmc50_id[] = {
+	{ "adm1022", adm1022 },
+	{ "thmc50", thmc50 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, thmc50_id);
 
-	return data;
-}
+static struct i2c_driver thmc50_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "thmc50",
+	},
+	.probe = thmc50_probe,
+	.remove = thmc50_remove,
+	.id_table = thmc50_id,
+	.detect = thmc50_detect,
+	.address_list = normal_i2c,
+};
 
 module_i2c_driver(thmc50_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
