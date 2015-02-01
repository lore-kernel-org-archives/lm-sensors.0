From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Feb 2015 23:43:00 +0000
Subject: [lm-sensors] [PATCH v2 1/2] ads2828: Convert to use regmap
Message-Id: <1422834181-6569-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce code size by using regmap to access i2c registers.

Cc: Robert Rosengren <robert.rosengren@axis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Drop byte swapping code; it is handled by regmap internally

Note that the SMBUs word access code in regmap has a bug, resulting
in byte swapped accesses if the i2c controller only supports SMBus
accesses. I will submit patch to fix the code in the regmap subsystem
separately.

 drivers/hwmon/Kconfig   |  1 +
 drivers/hwmon/ads7828.c | 70 ++++++++++++++++++-------------------------------
 2 files changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b1aaf93..9ea71ea 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1389,6 +1389,7 @@ config SENSORS_ADS1015
 config SENSORS_ADS7828
 	tristate "Texas Instruments ADS7828 and compatibles"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments ADS7828 and
 	  ADS7830 8-channel A/D converters. ADS7828 resolution is 12-bit, while
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index a622d40..071f779 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -30,14 +30,12 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/platform_data/ads7828.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 /* The ADS7828 registers */
-#define ADS7828_NCH		8	/* 8 channels supported */
 #define ADS7828_CMD_SD_SE	0x80	/* Single ended inputs */
 #define ADS7828_CMD_PD1		0x04	/* Internal vref OFF && A/D ON */
 #define ADS7828_CMD_PD3		0x0C	/* Internal vref ON && A/D ON */
@@ -50,17 +48,12 @@ enum ads7828_chips { ads7828, ads7830 };
 
 /* Client specific data */
 struct ads7828_data {
-	struct i2c_client *client;
-	struct mutex update_lock;	/* Mutex protecting updates */
-	unsigned long last_updated;	/* Last updated time (in jiffies) */
-	u16 adc_input[ADS7828_NCH];	/* ADS7828_NCH samples */
-	bool valid;			/* Validity flag */
+	struct regmap *regmap;
 	bool diff_input;		/* Differential input */
 	bool ext_vref;			/* External voltage reference */
 	unsigned int vref_mv;		/* voltage reference value */
 	u8 cmd_byte;			/* Command byte without channel bits */
 	unsigned int lsb_resol;		/* Resolution of the ADC sample LSB */
-	s32 (*read_channel)(const struct i2c_client *client, u8 command);
 };
 
 /* Command byte C2,C1,C0 - see datasheet */
@@ -69,42 +62,22 @@ static inline u8 ads7828_cmd_byte(u8 cmd, int ch)
 	return cmd | (((ch >> 1) | (ch & 0x01) << 2) << 4);
 }
 
-/* Update data for the device (all 8 channels) */
-static struct ads7828_data *ads7828_update_device(struct device *dev)
-{
-	struct ads7828_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-			|| !data->valid) {
-		unsigned int ch;
-		dev_dbg(&client->dev, "Starting ads7828 update\n");
-
-		for (ch = 0; ch < ADS7828_NCH; ch++) {
-			u8 cmd = ads7828_cmd_byte(data->cmd_byte, ch);
-			data->adc_input[ch] = data->read_channel(client, cmd);
-		}
-		data->last_updated = jiffies;
-		data->valid = true;
-	}
-
-	mutex_unlock(&data->update_lock);
-
-	return data;
-}
-
 /* sysfs callback function */
 static ssize_t ads7828_show_in(struct device *dev, struct device_attribute *da,
 			       char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct ads7828_data *data = ads7828_update_device(dev);
-	unsigned int value = DIV_ROUND_CLOSEST(data->adc_input[attr->index] *
-					       data->lsb_resol, 1000);
+	struct ads7828_data *data = dev_get_drvdata(dev);
+	u8 cmd = ads7828_cmd_byte(data->cmd_byte, attr->index);
+	unsigned int regval;
+	int err;
 
-	return sprintf(buf, "%d\n", value);
+	err = regmap_read(data->regmap, cmd, &regval);
+	if (err < 0)
+		return err;
+
+	return sprintf(buf, "%d\n",
+		       DIV_ROUND_CLOSEST(regval * data->lsb_resol, 1000));
 }
 
 static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ads7828_show_in, NULL, 0);
@@ -130,6 +103,16 @@ static struct attribute *ads7828_attrs[] = {
 
 ATTRIBUTE_GROUPS(ads7828);
 
+static const struct regmap_config ads2828_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+};
+
+static const struct regmap_config ads2830_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static int ads7828_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -160,19 +143,18 @@ static int ads7828_probe(struct i2c_client *client,
 	/* ADS7828 uses 12-bit samples, while ADS7830 is 8-bit */
 	if (id->driver_data = ads7828) {
 		data->lsb_resol = DIV_ROUND_CLOSEST(data->vref_mv * 1000, 4096);
-		data->read_channel = i2c_smbus_read_word_swapped;
+		data->regmap = devm_regmap_init_i2c(client,
+						    &ads2828_regmap_config);
 	} else {
 		data->lsb_resol = DIV_ROUND_CLOSEST(data->vref_mv * 1000, 256);
-		data->read_channel = i2c_smbus_read_byte_data;
+		data->regmap = devm_regmap_init_i2c(client,
+						    &ads2830_regmap_config);
 	}
 
 	data->cmd_byte = data->ext_vref ? ADS7828_CMD_PD1 : ADS7828_CMD_PD3;
 	if (!data->diff_input)
 		data->cmd_byte |= ADS7828_CMD_SD_SE;
 
-	data->client = client;
-	mutex_init(&data->update_lock);
-
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data,
 							   ads7828_groups);
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
