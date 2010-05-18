From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 May 2010 08:59:12 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (tmp102) Various fixes
Message-Id: <20100518105912.7a3f6a4e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixes from my driver review:
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-March/028051.html

Only the small changes are in there, more important changes will come
later separately as time permits.

* Drop the remnants of the now gone detect function
* The TMP102 has no known compatible chip
* Include the right header files
* Clarify why byte swapping of register values is needed
* Strip resolution info bit from temperature register value
* Set cache lifetime to 1/3 second
* Don't arbitrarily reject limit values; clamp as needed
* Make limit writing unconditional
* Don't check for transaction types the driver doesn't use
* Properly check for error when setting configuration
* Report error on failed probe
* Make the driver load automatically where needed
* Various other minor fixes

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Steven King <sfking@fdwdc.com>
---
 Documentation/hwmon/tmp102 |    9 ++---
 drivers/hwmon/Kconfig      |    2 -
 drivers/hwmon/tmp102.c     |   69 +++++++++++++++++++++-----------------------
 3 files changed, 39 insertions(+), 41 deletions(-)

--- linux-2.6.34-rc7.orig/Documentation/hwmon/tmp102	2010-05-14 14:27:01.000000000 +0200
+++ linux-2.6.34-rc7/Documentation/hwmon/tmp102	2010-05-16 09:15:45.000000000 +0200
@@ -4,7 +4,7 @@ Kernel driver tmp102
 Supported chips:
   * Texas Instruments TMP102
     Prefix: 'tmp102'
-    Addresses scanned: I2C 0x48 0x49 0x4a 0x4b
+    Addresses scanned: none
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp102.html
 
 Author:
@@ -15,13 +15,12 @@ Description
 
 The Texas Instruments TMP102 implements one temperature sensor.  Limits can be
 set through the Overtemperature Shutdown register and Hysteresis register.  The
-sensor is accurate to 0.5 degrees over the range of -25 to +85 C, and to 1.0
-degrees from -40 to +125 C. Resolution of the sensor is 0.0625 degree.  The
+sensor is accurate to 0.5 degree over the range of -25 to +85 C, and to 1.0
+degree from -40 to +125 C. Resolution of the sensor is 0.0625 degree.  The
 operating temperature has a minimum of -55 C and a maximum of +150 C.
 
 The TMP102 has a programmable update rate that can select between 8, 4, 1, and
 0.5 Hz. (Currently the driver only supports the default of 4 Hz).
 
 The driver provides the common sysfs-interface for temperatures (see
-/Documentation/hwmon/sysfs-interface under Temperatures).
-
+Documentation/hwmon/sysfs-interface under Temperatures).
--- linux-2.6.34-rc7.orig/drivers/hwmon/Kconfig	2010-05-14 14:27:01.000000000 +0200
+++ linux-2.6.34-rc7/drivers/hwmon/Kconfig	2010-05-16 09:15:45.000000000 +0200
@@ -834,7 +834,7 @@ config SENSORS_THMC50
 	  will be called thmc50.
 
 config SENSORS_TMP102
-	tristate "Texas Instruments TMP102 and compatibles"
+	tristate "Texas Instruments TMP102"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for Texas Instruments TMP102
--- linux-2.6.34-rc7.orig/drivers/hwmon/tmp102.c	2010-05-14 14:27:01.000000000 +0200
+++ linux-2.6.34-rc7/drivers/hwmon/tmp102.c	2010-05-16 09:47:06.000000000 +0200
@@ -1,6 +1,6 @@
-/* Texas Instruments TMP102 SMBUS temperature sensor driver
+/* Texas Instruments TMP102 SMBus temperature sensor driver
  *
- * Copyright 2010 Steven King <sfking@fdwdc.com>
+ * Copyright (C) 2010 Steven King <sfking@fdwdc.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -17,8 +17,6 @@
  * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -27,7 +25,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
+#include <linux/device.h>
 
 #define	DRIVER_NAME "tmp102"
 
@@ -56,26 +54,27 @@ struct tmp102 {
 	int temp[3];
 };
 
-/* the TMP102 registers are big endian so we have to swab16 the values */
-static int tmp102_read_reg(struct i2c_client *client, u8 reg)
+/* SMBus specifies low byte first, but the TMP102 returns high byte first,
+ * so we have to swab16 the values */
+static inline int tmp102_read_reg(struct i2c_client *client, u8 reg)
 {
 	int result = i2c_smbus_read_word_data(client, reg);
 	return result < 0 ? result : swab16(result);
 }
 
-static int tmp102_write_reg(struct i2c_client *client, u8 reg, u16 val)
+static inline int tmp102_write_reg(struct i2c_client *client, u8 reg, u16 val)
 {
 	return i2c_smbus_write_word_data(client, reg, swab16(val));
 }
 
-/* convert left adjusted 13bit TMP102 register value to miliCelsius */
-static int tmp102_reg_to_mC(s16 val)
+/* convert left adjusted 13-bit TMP102 register value to milliCelsius */
+static inline int tmp102_reg_to_mC(s16 val)
 {
-	return (val * 1000) / 128;
+	return ((val & ~0x01) * 1000) / 128;
 }
 
-/* convert miliCelsius to left adjusted 13bit TMP102 register value */
-static u16 tmp102_mC_to_reg(int val)
+/* convert milliCelsius to left adjusted 13-bit TMP102 register value */
+static inline u16 tmp102_mC_to_reg(int val)
 {
 	return (val * 128) / 1000;
 }
@@ -91,7 +90,7 @@ static struct tmp102 *tmp102_update_devi
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
 	mutex_lock(&tmp102->lock);
-	if (time_after(jiffies, tmp102->last_update + HZ / 4)) {
+	if (time_after(jiffies, tmp102->last_update + HZ / 3)) {
 		int i;
 		for (i = 0; i < ARRAY_SIZE(tmp102->temp); ++i) {
 			int status = tmp102_read_reg(client, tmp102_reg[i]);
@@ -122,16 +121,16 @@ static ssize_t tmp102_set_temp(struct de
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 	long val;
-	int status = 0;
+	int status;
 
-	if ((strict_strtol(buf, 10, &val) < 0) || (abs(val) > 150000))
+	if (strict_strtol(buf, 10, &val) < 0)
 		return -EINVAL;
+	val = SENSORS_LIMIT(val, -256000, 255000);
+
 	mutex_lock(&tmp102->lock);
-	if (tmp102->temp[sda->index] != val) {
-		tmp102->temp[sda->index] = val;
-		status = tmp102_write_reg(client, tmp102_reg[sda->index],
-					  tmp102_mC_to_reg(val));
-	}
+	tmp102->temp[sda->index] = val;
+	status = tmp102_write_reg(client, tmp102_reg[sda->index],
+				  tmp102_mC_to_reg(val));
 	mutex_unlock(&tmp102->lock);
 	return status ? : count;
 }
@@ -164,9 +163,10 @@ static int __devinit tmp102_probe(struct
 	struct tmp102 *tmp102;
 	int status;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_dbg(&client->dev, "adapter doesnt support SMBUS\n");
+		dev_err(&client->dev, "adapter doesnt support SMBus word "
+			"transactions\n");
 		return -ENODEV;
 	}
 
@@ -177,16 +177,20 @@ static int __devinit tmp102_probe(struct
 	}
 	i2c_set_clientdata(client, tmp102);
 
-	tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONFIG);
+	status = tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONFIG);
+	if (status < 0) {
+		dev_err(&client->dev, "error writing config register\n");
+		goto fail0;
+	}
 	status = tmp102_read_reg(client, TMP102_CONF_REG);
 	if (status < 0) {
-		dev_dbg(&client->dev, "error reading config register\n");
+		dev_err(&client->dev, "error reading config register\n");
 		goto fail0;
 	}
 	status &= ~TMP102_CONFIG_RD_ONLY;
 	if (status != TMP102_CONFIG) {
-		dev_dbg(&client->dev, "could not verify config settings\n");
-		status = -EIO;
+		dev_err(&client->dev, "config settings did not stick\n");
+		status = -ENODEV;
 		goto fail0;
 	}
 	tmp102->last_update = jiffies - HZ;
@@ -213,7 +217,7 @@ fail0:
 	i2c_set_clientdata(client, NULL);
 	kfree(tmp102);
 
-	return 0;
+	return status;
 }
 
 static int __devexit tmp102_remove(struct i2c_client *client)
@@ -260,23 +264,18 @@ static const struct dev_pm_ops tmp102_de
 #define	TMP102_DEV_PM_OPS NULL
 #endif /* CONFIG_PM */
 
-static const unsigned short normal_i2c[] = {
-	0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END
-};
-
 static const struct i2c_device_id tmp102_id[] = {
-	{ DRIVER_NAME, 0 },
+	{ "tmp102", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, tmp102_id);
 
 static struct i2c_driver tmp102_driver = {
 	.driver.name	= DRIVER_NAME,
 	.driver.pm	= TMP102_DEV_PM_OPS,
-	.class		= I2C_CLASS_HWMON,
 	.probe		= tmp102_probe,
 	.remove		= __devexit_p(tmp102_remove),
 	.id_table	= tmp102_id,
-	.address_list	= normal_i2c,
 };
 
 static int __init tmp102_init(void)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
