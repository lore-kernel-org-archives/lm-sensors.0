From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 20 Nov 2011 22:42:16 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm63) Add support for LM96163
Message-Id: <1321828936-15123-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM96163 is an enhanced version of LM63 with improved PWM resolution. Add chip
detection code as well as support for improved PWM resolution if the chip is
configured to use it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Tested with both LM63 and LM96163.

 drivers/hwmon/lm63.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index e02d7f0..3e20da9 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -91,6 +91,8 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define LM63_REG_MAN_ID			0xFE
 #define LM63_REG_CHIP_ID		0xFF
 
+#define LM96163_REG_CONFIG_ENHANCED	0x45
+
 /*
  * Conversions and various macros
  * For tachometer counts, the LM63 uses 16-bit values.
@@ -134,7 +136,7 @@ static struct lm63_data *lm63_update_device(struct device *dev);
 static int lm63_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void lm63_init_client(struct i2c_client *client);
 
-enum chips { lm63, lm64 };
+enum chips { lm63, lm64, lm96163 };
 
 /*
  * Driver data (common to all clients)
@@ -143,6 +145,7 @@ enum chips { lm63, lm64 };
 static const struct i2c_device_id lm63_id[] = {
 	{ "lm63", lm63 },
 	{ "lm64", lm64 },
+	{ "lm96163", lm96163 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm63_id);
@@ -185,6 +188,7 @@ struct lm63_data {
 			   2: remote high limit */
 	u8 temp2_crit_hyst;
 	u8 alarms;
+	bool pwm_highres;
 };
 
 /*
@@ -225,9 +229,16 @@ static ssize_t show_pwm1(struct device *dev, struct device_attribute *dummy,
 			 char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * data->pwm1_freq ?
+	int pwm;
+
+	if (data->pwm_highres)
+		pwm = data->pwm1_value;
+	else
+		pwm = data->pwm1_value >= 2 * data->pwm1_freq ?
 		       255 : (data->pwm1_value * 255 + data->pwm1_freq) /
-		       (2 * data->pwm1_freq));
+		       (2 * data->pwm1_freq);
+
+	return sprintf(buf, "%d\n", pwm);
 }
 
 static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
@@ -245,9 +256,9 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
 	if (err)
 		return err;
 
+	val = SENSORS_LIMIT(val, 0, 255);
 	mutex_lock(&data->update_lock);
-	data->pwm1_value = val <= 0 ? 0 :
-			   val >= 255 ? 2 * data->pwm1_freq :
+	data->pwm1_value = data->pwm_highres ? val :
 			   (val * data->pwm1_freq * 2 + 127) / 255;
 	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
 	mutex_unlock(&data->update_lock);
@@ -516,6 +527,8 @@ static int lm63_detect(struct i2c_client *new_client,
 		strlcpy(info->type, "lm63", I2C_NAME_SIZE);
 	else if (chip_id = 0x51 && (address = 0x18 || address = 0x4e))
 		strlcpy(info->type, "lm64", I2C_NAME_SIZE);
+	else if (chip_id = 0x49 && address = 0x4c)
+		strlcpy(info->type, "lm96163", I2C_NAME_SIZE);
 	else
 		return -ENODEV;
 
@@ -599,6 +612,16 @@ static void lm63_init_client(struct i2c_client *client)
 	if (data->pwm1_freq = 0)
 		data->pwm1_freq = 1;
 
+	/* For LM96163, check if high resolution PWM is enabled */
+	if (data->kind = lm96163
+	    && !(data->config_fan & 0x08) && data->pwm1_freq = 8) {
+		u8 config_enhanced
+		  = i2c_smbus_read_byte_data(client,
+					     LM96163_REG_CONFIG_ENHANCED);
+		if (config_enhanced & 0x10)
+			data->pwm_highres = true;
+	}
+
 	/* Show some debug info about the LM63 configuration */
 	dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
 		(data->config & 0x04) ? "tachometer input" :
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
