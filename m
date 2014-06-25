From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 25 Jun 2014 01:38:57 +0000
Subject: [lm-sensors] [PATCH v2 1/2] hwmon: (w83l786ng) Avoid forward declaration
Message-Id: <1403660337.31123.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/w83l786ng.c | 209 ++++++++++++++++++++++------------------------
 1 file changed, 100 insertions(+), 109 deletions(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 32487c1..6caf33a 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -148,32 +148,6 @@ struct w83l786ng_data {
 	u8 tolerance[2];
 };
 
-static int w83l786ng_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id);
-static int w83l786ng_detect(struct i2c_client *client,
-			    struct i2c_board_info *info);
-static int w83l786ng_remove(struct i2c_client *client);
-static void w83l786ng_init_client(struct i2c_client *client);
-static struct w83l786ng_data *w83l786ng_update_device(struct device *dev);
-
-static const struct i2c_device_id w83l786ng_id[] = {
-	{ "w83l786ng", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, w83l786ng_id);
-
-static struct i2c_driver w83l786ng_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		   .name = "w83l786ng",
-	},
-	.probe		= w83l786ng_probe,
-	.remove		= w83l786ng_remove,
-	.id_table	= w83l786ng_id,
-	.detect		= w83l786ng_detect,
-	.address_list	= normal_i2c,
-};
-
 static u8
 w83l786ng_read_value(struct i2c_client *client, u8 reg)
 {
@@ -186,6 +160,77 @@ w83l786ng_write_value(struct i2c_client *client, u8 reg, u8 value)
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
+static struct w83l786ng_data *w83l786ng_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	int i, j;
+	u8 reg_tmp, pwmcfg;
+
+	mutex_lock(&data->update_lock);
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		dev_dbg(&client->dev, "Updating w83l786ng data.\n");
+
+		/* Update the voltages measured value and limits */
+		for (i = 0; i < 3; i++) {
+			data->in[i] = w83l786ng_read_value(client,
+			    W83L786NG_REG_IN(i));
+			data->in_min[i] = w83l786ng_read_value(client,
+			    W83L786NG_REG_IN_MIN(i));
+			data->in_max[i] = w83l786ng_read_value(client,
+			    W83L786NG_REG_IN_MAX(i));
+		}
+
+		/* Update the fan counts and limits */
+		for (i = 0; i < 2; i++) {
+			data->fan[i] = w83l786ng_read_value(client,
+			    W83L786NG_REG_FAN(i));
+			data->fan_min[i] = w83l786ng_read_value(client,
+			    W83L786NG_REG_FAN_MIN(i));
+		}
+
+		/* Update the fan divisor */
+		reg_tmp = w83l786ng_read_value(client, W83L786NG_REG_FAN_DIV);
+		data->fan_div[0] = reg_tmp & 0x07;
+		data->fan_div[1] = (reg_tmp >> 4) & 0x07;
+
+		pwmcfg = w83l786ng_read_value(client, W83L786NG_REG_FAN_CFG);
+		for (i = 0; i < 2; i++) {
+			data->pwm_mode[i] +			    ((pwmcfg >> W83L786NG_PWM_MODE_SHIFT[i]) & 1)
+			    ? 0 : 1;
+			data->pwm_enable[i] +			    ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3) + 1;
+			data->pwm[i] +			    (w83l786ng_read_value(client, W83L786NG_REG_PWM[i])
+			     & 0x0f) * 0x11;
+		}
+
+
+		/* Update the temperature sensors */
+		for (i = 0; i < 2; i++) {
+			for (j = 0; j < 3; j++) {
+				data->temp[i][j] = w83l786ng_read_value(client,
+				    W83L786NG_REG_TEMP[i][j]);
+			}
+		}
+
+		/* Update Smart Fan I/II tolerance */
+		reg_tmp = w83l786ng_read_value(client, W83L786NG_REG_TOLERANCE);
+		data->tolerance[0] = reg_tmp & 0x0f;
+		data->tolerance[1] = (reg_tmp >> 4) & 0x0f;
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
 static ssize_t \
@@ -662,6 +707,19 @@ w83l786ng_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
+static void w83l786ng_init_client(struct i2c_client *client)
+{
+	u8 tmp;
+
+	if (reset)
+		w83l786ng_write_value(client, W83L786NG_REG_CONFIG, 0x80);
+
+	/* Start monitoring */
+	tmp = w83l786ng_read_value(client, W83L786NG_REG_CONFIG);
+	if (!(tmp & 0x01))
+		w83l786ng_write_value(client, W83L786NG_REG_CONFIG, tmp | 0x01);
+}
+
 static int
 w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -723,90 +781,23 @@ w83l786ng_remove(struct i2c_client *client)
 	return 0;
 }
 
-static void
-w83l786ng_init_client(struct i2c_client *client)
-{
-	u8 tmp;
-
-	if (reset)
-		w83l786ng_write_value(client, W83L786NG_REG_CONFIG, 0x80);
-
-	/* Start monitoring */
-	tmp = w83l786ng_read_value(client, W83L786NG_REG_CONFIG);
-	if (!(tmp & 0x01))
-		w83l786ng_write_value(client, W83L786NG_REG_CONFIG, tmp | 0x01);
-}
-
-static struct w83l786ng_data *w83l786ng_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	int i, j;
-	u8 reg_tmp, pwmcfg;
-
-	mutex_lock(&data->update_lock);
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		dev_dbg(&client->dev, "Updating w83l786ng data.\n");
-
-		/* Update the voltages measured value and limits */
-		for (i = 0; i < 3; i++) {
-			data->in[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_IN(i));
-			data->in_min[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_IN_MIN(i));
-			data->in_max[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_IN_MAX(i));
-		}
-
-		/* Update the fan counts and limits */
-		for (i = 0; i < 2; i++) {
-			data->fan[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_FAN(i));
-			data->fan_min[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_FAN_MIN(i));
-		}
-
-		/* Update the fan divisor */
-		reg_tmp = w83l786ng_read_value(client, W83L786NG_REG_FAN_DIV);
-		data->fan_div[0] = reg_tmp & 0x07;
-		data->fan_div[1] = (reg_tmp >> 4) & 0x07;
-
-		pwmcfg = w83l786ng_read_value(client, W83L786NG_REG_FAN_CFG);
-		for (i = 0; i < 2; i++) {
-			data->pwm_mode[i] -			    ((pwmcfg >> W83L786NG_PWM_MODE_SHIFT[i]) & 1)
-			    ? 0 : 1;
-			data->pwm_enable[i] -			    ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3) + 1;
-			data->pwm[i] -			    (w83l786ng_read_value(client, W83L786NG_REG_PWM[i])
-			     & 0x0f) * 0x11;
-		}
-
-
-		/* Update the temperature sensors */
-		for (i = 0; i < 2; i++) {
-			for (j = 0; j < 3; j++) {
-				data->temp[i][j] = w83l786ng_read_value(client,
-				    W83L786NG_REG_TEMP[i][j]);
-			}
-		}
-
-		/* Update Smart Fan I/II tolerance */
-		reg_tmp = w83l786ng_read_value(client, W83L786NG_REG_TOLERANCE);
-		data->tolerance[0] = reg_tmp & 0x0f;
-		data->tolerance[1] = (reg_tmp >> 4) & 0x0f;
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id w83l786ng_id[] = {
+	{ "w83l786ng", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, w83l786ng_id);
 
-	return data;
-}
+static struct i2c_driver w83l786ng_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		   .name = "w83l786ng",
+	},
+	.probe		= w83l786ng_probe,
+	.remove		= w83l786ng_remove,
+	.id_table	= w83l786ng_id,
+	.detect		= w83l786ng_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(w83l786ng_driver);
 
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
