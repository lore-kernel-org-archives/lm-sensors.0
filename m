From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:56:33 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm1031) Avoid forward declaration
Message-Id: <1404395793.4895.10.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1031.c | 286 +++++++++++++++++++++++-------------------------
 1 file changed, 138 insertions(+), 148 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index a8a540c..80c07c9 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -105,34 +105,6 @@ struct adm1031_data {
 	s8 temp_crit[3];
 };
 
-static int adm1031_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adm1031_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static void adm1031_init_client(struct i2c_client *client);
-static int adm1031_remove(struct i2c_client *client);
-static struct adm1031_data *adm1031_update_device(struct device *dev);
-
-static const struct i2c_device_id adm1031_id[] = {
-	{ "adm1030", adm1030 },
-	{ "adm1031", adm1031 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1031_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver adm1031_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name = "adm1031",
-	},
-	.probe		= adm1031_probe,
-	.remove		= adm1031_remove,
-	.id_table	= adm1031_id,
-	.detect		= adm1031_detect,
-	.address_list	= normal_i2c,
-};
-
 static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -144,6 +116,96 @@ adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
+static struct adm1031_data *adm1031_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1031_data *data = i2c_get_clientdata(client);
+	unsigned long next_update;
+	int chan;
+
+	mutex_lock(&data->update_lock);
+
+	next_update = data->last_updated
+	  + msecs_to_jiffies(data->update_interval);
+	if (time_after(jiffies, next_update) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting adm1031 update\n");
+		for (chan = 0;
+		     chan < ((data->chip_type = adm1031) ? 3 : 2); chan++) {
+			u8 oldh, newh;
+
+			oldh +			    adm1031_read_value(client, ADM1031_REG_TEMP(chan));
+			data->ext_temp[chan] +			    adm1031_read_value(client, ADM1031_REG_EXT_TEMP);
+			newh +			    adm1031_read_value(client, ADM1031_REG_TEMP(chan));
+			if (newh != oldh) {
+				data->ext_temp[chan] +				    adm1031_read_value(client,
+						       ADM1031_REG_EXT_TEMP);
+#ifdef DEBUG
+				oldh +				    adm1031_read_value(client,
+						       ADM1031_REG_TEMP(chan));
+
+				/* oldh is actually newer */
+				if (newh != oldh)
+					dev_warn(&client->dev,
+					  "Remote temperature may be wrong.\n");
+#endif
+			}
+			data->temp[chan] = newh;
+
+			data->temp_offset[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_TEMP_OFFSET(chan));
+			data->temp_min[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_TEMP_MIN(chan));
+			data->temp_max[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_TEMP_MAX(chan));
+			data->temp_crit[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_TEMP_CRIT(chan));
+			data->auto_temp[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_AUTO_TEMP(chan));
+
+		}
+
+		data->conf1 = adm1031_read_value(client, ADM1031_REG_CONF1);
+		data->conf2 = adm1031_read_value(client, ADM1031_REG_CONF2);
+
+		data->alarm = adm1031_read_value(client, ADM1031_REG_STATUS(0))
+		    | (adm1031_read_value(client, ADM1031_REG_STATUS(1)) << 8);
+		if (data->chip_type = adm1030)
+			data->alarm &= 0xc0ff;
+
+		for (chan = 0; chan < (data->chip_type = adm1030 ? 1 : 2);
+		     chan++) {
+			data->fan_div[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_DIV(chan));
+			data->fan_min[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_MIN(chan));
+			data->fan[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_SPEED(chan));
+			data->pwm[chan] +			  (adm1031_read_value(client,
+					ADM1031_REG_PWM) >> (4 * chan)) & 0x0f;
+		}
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 #define TEMP_TO_REG(val)		(((val) < 0 ? ((val - 500) / 1000) : \
 					((val + 500) / 1000)))
@@ -948,6 +1010,37 @@ static int adm1031_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void adm1031_init_client(struct i2c_client *client)
+{
+	unsigned int read_val;
+	unsigned int mask;
+	int i;
+	struct adm1031_data *data = i2c_get_clientdata(client);
+
+	mask = (ADM1031_CONF2_PWM1_ENABLE | ADM1031_CONF2_TACH1_ENABLE);
+	if (data->chip_type = adm1031) {
+		mask |= (ADM1031_CONF2_PWM2_ENABLE |
+			ADM1031_CONF2_TACH2_ENABLE);
+	}
+	/* Initialize the ADM1031 chip (enables fan speed reading ) */
+	read_val = adm1031_read_value(client, ADM1031_REG_CONF2);
+	if ((read_val | mask) != read_val)
+		adm1031_write_value(client, ADM1031_REG_CONF2, read_val | mask);
+
+	read_val = adm1031_read_value(client, ADM1031_REG_CONF1);
+	if ((read_val | ADM1031_CONF1_MONITOR_ENABLE) != read_val) {
+		adm1031_write_value(client, ADM1031_REG_CONF1,
+				    read_val | ADM1031_CONF1_MONITOR_ENABLE);
+	}
+
+	/* Read the chip's update rate */
+	mask = ADM1031_UPDATE_RATE_MASK;
+	read_val = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
+	i = (read_val & mask) >> ADM1031_UPDATE_RATE_SHIFT;
+	/* Save it as update interval */
+	data->update_interval = update_intervals[i];
+}
+
 static int adm1031_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1006,127 +1099,24 @@ static int adm1031_remove(struct i2c_client *client)
 	return 0;
 }
 
-static void adm1031_init_client(struct i2c_client *client)
-{
-	unsigned int read_val;
-	unsigned int mask;
-	int i;
-	struct adm1031_data *data = i2c_get_clientdata(client);
-
-	mask = (ADM1031_CONF2_PWM1_ENABLE | ADM1031_CONF2_TACH1_ENABLE);
-	if (data->chip_type = adm1031) {
-		mask |= (ADM1031_CONF2_PWM2_ENABLE |
-			ADM1031_CONF2_TACH2_ENABLE);
-	}
-	/* Initialize the ADM1031 chip (enables fan speed reading ) */
-	read_val = adm1031_read_value(client, ADM1031_REG_CONF2);
-	if ((read_val | mask) != read_val)
-		adm1031_write_value(client, ADM1031_REG_CONF2, read_val | mask);
-
-	read_val = adm1031_read_value(client, ADM1031_REG_CONF1);
-	if ((read_val | ADM1031_CONF1_MONITOR_ENABLE) != read_val) {
-		adm1031_write_value(client, ADM1031_REG_CONF1,
-				    read_val | ADM1031_CONF1_MONITOR_ENABLE);
-	}
-
-	/* Read the chip's update rate */
-	mask = ADM1031_UPDATE_RATE_MASK;
-	read_val = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
-	i = (read_val & mask) >> ADM1031_UPDATE_RATE_SHIFT;
-	/* Save it as update interval */
-	data->update_interval = update_intervals[i];
-}
-
-static struct adm1031_data *adm1031_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
-	unsigned long next_update;
-	int chan;
-
-	mutex_lock(&data->update_lock);
-
-	next_update = data->last_updated
-	  + msecs_to_jiffies(data->update_interval);
-	if (time_after(jiffies, next_update) || !data->valid) {
-
-		dev_dbg(&client->dev, "Starting adm1031 update\n");
-		for (chan = 0;
-		     chan < ((data->chip_type = adm1031) ? 3 : 2); chan++) {
-			u8 oldh, newh;
-
-			oldh -			    adm1031_read_value(client, ADM1031_REG_TEMP(chan));
-			data->ext_temp[chan] -			    adm1031_read_value(client, ADM1031_REG_EXT_TEMP);
-			newh -			    adm1031_read_value(client, ADM1031_REG_TEMP(chan));
-			if (newh != oldh) {
-				data->ext_temp[chan] -				    adm1031_read_value(client,
-						       ADM1031_REG_EXT_TEMP);
-#ifdef DEBUG
-				oldh -				    adm1031_read_value(client,
-						       ADM1031_REG_TEMP(chan));
-
-				/* oldh is actually newer */
-				if (newh != oldh)
-					dev_warn(&client->dev,
-					  "Remote temperature may be wrong.\n");
-#endif
-			}
-			data->temp[chan] = newh;
-
-			data->temp_offset[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_TEMP_OFFSET(chan));
-			data->temp_min[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_TEMP_MIN(chan));
-			data->temp_max[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_TEMP_MAX(chan));
-			data->temp_crit[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_TEMP_CRIT(chan));
-			data->auto_temp[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_AUTO_TEMP(chan));
-
-		}
-
-		data->conf1 = adm1031_read_value(client, ADM1031_REG_CONF1);
-		data->conf2 = adm1031_read_value(client, ADM1031_REG_CONF2);
-
-		data->alarm = adm1031_read_value(client, ADM1031_REG_STATUS(0))
-		    | (adm1031_read_value(client, ADM1031_REG_STATUS(1)) << 8);
-		if (data->chip_type = adm1030)
-			data->alarm &= 0xc0ff;
-
-		for (chan = 0; chan < (data->chip_type = adm1030 ? 1 : 2);
-		     chan++) {
-			data->fan_div[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_FAN_DIV(chan));
-			data->fan_min[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_FAN_MIN(chan));
-			data->fan[chan] -			    adm1031_read_value(client,
-					       ADM1031_REG_FAN_SPEED(chan));
-			data->pwm[chan] -			  (adm1031_read_value(client,
-					ADM1031_REG_PWM) >> (4 * chan)) & 0x0f;
-		}
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id adm1031_id[] = {
+	{ "adm1030", adm1030 },
+	{ "adm1031", adm1031 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1031_id);
 
-	return data;
-}
+static struct i2c_driver adm1031_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name = "adm1031",
+	},
+	.probe		= adm1031_probe,
+	.remove		= adm1031_remove,
+	.id_table	= adm1031_id,
+	.detect		= adm1031_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(adm1031_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
