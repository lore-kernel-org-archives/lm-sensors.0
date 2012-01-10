From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 10 Jan 2012 03:42:00 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (lm63) Add support for LM96163
Message-Id: <1326166923-11187-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <guenter.roeck@ericsson.com>

LM96163 is an enhanced version of LM63 with improved PWM resolution. Add chip
detection code as well as support for improved PWM resolution if the chip is
configured to use it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm63 |    8 ++++++++
 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/lm63.c     |   41 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63
index b9843ea..337f7f4 100644
--- a/Documentation/hwmon/lm63
+++ b/Documentation/hwmon/lm63
@@ -12,6 +12,11 @@ Supported chips:
     Addresses scanned: I2C 0x18 and 0x4e
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/pf/LM/LM64.html
+  * National Semiconductor LM96163
+    Prefix: 'lm96163'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+	       http://www.national.com/pf/LM/LM96163.html
 
 Author: Jean Delvare <khali@linux-fr.org>
 
@@ -62,3 +67,6 @@ values.
 
 The LM64 is effectively an LM63 with GPIO lines. The driver does not
 support these GPIO lines at present.
+
+The LM96163 is an enhanced version of LM63 with improved temperature accuracy
+and better PWM resolution.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 91be41f..50954a4 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -515,11 +515,11 @@ config SENSORS_LINEAGE
 	  will be called lineage-pem.
 
 config SENSORS_LM63
-	tristate "National Semiconductor LM63 and LM64"
+	tristate "National Semiconductor LM63 and compatibles"
 	depends on I2C
 	help
 	  If you say yes here you get support for the National
-	  Semiconductor LM63 and LM64 remote diode digital temperature
+	  Semiconductor LM63, LM64, and LM96163 remote diode digital temperature
 	  sensors with integrated fan control.  Such chips are found
 	  on the Tyan S4882 (Thunder K8QS Pro) motherboard, among
 	  others.
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 313aee1..de6cf7f 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -47,6 +47,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 /*
  * Addresses to scan
@@ -91,6 +92,8 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define LM63_REG_MAN_ID			0xFE
 #define LM63_REG_CHIP_ID		0xFF
 
+#define LM96163_REG_CONFIG_ENHANCED	0x45
+
 /*
  * Conversions and various macros
  * For tachometer counts, the LM63 uses 16-bit values.
@@ -134,7 +137,7 @@ static struct lm63_data *lm63_update_device(struct device *dev);
 static int lm63_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void lm63_init_client(struct i2c_client *client);
 
-enum chips { lm63, lm64 };
+enum chips { lm63, lm64, lm96163 };
 
 /*
  * Driver data (common to all clients)
@@ -143,6 +146,7 @@ enum chips { lm63, lm64 };
 static const struct i2c_device_id lm63_id[] = {
 	{ "lm63", lm63 },
 	{ "lm64", lm64 },
+	{ "lm96163", lm96163 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm63_id);
@@ -186,6 +190,7 @@ struct lm63_data {
 			   3: remote offset */
 	u8 temp2_crit_hyst;
 	u8 alarms;
+	bool pwm_highres;
 };
 
 /*
@@ -226,9 +231,16 @@ static ssize_t show_pwm1(struct device *dev, struct device_attribute *dummy,
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
@@ -246,9 +258,9 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
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
@@ -522,6 +534,8 @@ static int lm63_detect(struct i2c_client *new_client,
 		strlcpy(info->type, "lm63", I2C_NAME_SIZE);
 	else if (chip_id = 0x51 && (address = 0x18 || address = 0x4e))
 		strlcpy(info->type, "lm64", I2C_NAME_SIZE);
+	else if (chip_id = 0x49 && address = 0x4c)
+		strlcpy(info->type, "lm96163", I2C_NAME_SIZE);
 	else
 		return -ENODEV;
 
@@ -605,6 +619,23 @@ static void lm63_init_client(struct i2c_client *client)
 	if (data->pwm1_freq = 0)
 		data->pwm1_freq = 1;
 
+	/*
+	 * For LM96163, check if high resolution PWM is enabled.
+	 * Also, check if unsigned temperature format is enabled
+	 * and display a warning message if it is.
+	 */
+	if (data->kind = lm96163) {
+		u8 config_enhanced
+		  = i2c_smbus_read_byte_data(client,
+					     LM96163_REG_CONFIG_ENHANCED);
+		if ((config_enhanced & 0x10)
+		    && !(data->config_fan & 0x08) && data->pwm1_freq = 8)
+			data->pwm_highres = true;
+		if (config_enhanced & 0x08)
+			dev_warn(&client->dev,
+				 "Unsigned format for High and Crit setpoints enabled but not supported by driver");
+	}
+
 	/* Show some debug info about the LM63 configuration */
 	dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
 		(data->config & 0x04) ? "tachometer input" :
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
