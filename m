From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 09 May 2013 05:45:53 +0000
Subject: [lm-sensors] [lm-sensors 1/2] hwmon: (ds1621) Add ds1721 chip support
Message-Id: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Update the ds1621 documentation, driver, & Kconfig with ds1721 chip support.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 Documentation/hwmon/ds1621 |   26 +++++++---
 drivers/hwmon/Kconfig      |    9 ++--
 drivers/hwmon/ds1621.c     |  120 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 132 insertions(+), 23 deletions(-)

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index 5e97f33..ee7bc01 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -2,16 +2,22 @@ Kernel driver ds1621
 ==========
 
 Supported chips:
-  * Dallas Semiconductor DS1621
+  * Dallas Semiconductor & Maxim Integrated DS1621
     Prefix: 'ds1621'
     Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.dalsemi.com/
+    Datasheet: Publicly available from www.maximintegrated.com
+
   * Dallas Semiconductor DS1625
-    Prefix: 'ds1621'
+    Prefix:
+     'ds1621' - if binding via _detect function
+     'ds1625' - explicit instantiation
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available from www.datasheetarchive.com
+
+  * Maxim Integrated DS1721
+    Prefix: 'ds1721'
     Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.dalsemi.com/
+    Datasheet: Publicly available from www.maximintegrated.com
 
 Authors:
         Christian W. Zuckschwerdt <zany@triq.net>
@@ -61,3 +67,11 @@ with neither of the alarms set.
 
 Temperature conversion of the DS1621 takes up to 1000ms; internal access to
 non-volatile registers may last for 10ms or below.
+
+The DS1625 is pin compatible and functionally equivalent with the DS1621,
+but the DS1621 is meant to replace it.
+
+The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
+degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
+default setting of 75 and 80 degrees respectifully, and a maximum conversion
+time of 750ms.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 89ac1cb..92e784e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -315,11 +315,14 @@ config SENSORS_DS620
 	  will be called ds620.
 
 config SENSORS_DS1621
-	tristate "Dallas Semiconductor DS1621 and DS1625"
+	tristate "Dallas Semiconductor DS1621 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for Dallas Semiconductor
-	  DS1621 and DS1625 sensor chips.
+	  If you say yes here you get support for Dallas Semiconductor/Maxim
+	  Integrated DS1621 sensor chips and compatible models including:
+
+	  - Dallas Semiconductor DS1625
+	  - Maxim Integrated DS1721
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1621.
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 1c56873..04a3b12 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -6,6 +6,19 @@
  * Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
  * the help of Jean Delvare <khali@linux-fr.org>
  *
+ * The DS1621 device is a digital temperature/thermometer with 9-bit
+ * resolution, a thermal alarm output (Tout), and user-defined minimum
+ * and maximum temperature thresholds (TH & TL).
+ *
+ * The DS1625 & DS1721 are pin compatible with the DS1621 and similar
+ * in operation, with slight variations as noted in the device
+ * datasheets (please refer to www.maximintegrated.com for specific
+ * device information).
+ *
+ * Since the DS1621 was the first chipset supported by this driver,
+ * most comments will refer to this chipset, but are actually general
+ * and concern all supported chipsets, unless mentioned otherwise.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -31,27 +44,62 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
-#include "lm75.h"
+#include <linux/kernel.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
+/* Supported devices */
+enum chips { ds1621, ds1625, ds1721 };
+
 /* Insmod parameters */
 static int polarity = -1;
 module_param(polarity, int, 0);
 MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low");
 
-/* Many DS1621 constants specified below */
-/* Config register used for detection         */
-/*  7    6    5    4    3    2    1    0      */
-/* |Done|THF |TLF |NVB | X  | X  |POL |1SHOT| */
+/*
+ * The Configuration/Status register
+ *
+ * - DS1621:
+ *   7    6    5    4    3    2    1    0
+ * |Done|THF |TLF |NVB | X  | X  |POL |1SHOT|
+ *
+ * - DS1625:
+ *   7    6    5    4    3    2    1    0
+ * |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT|
+ *
+ * - DS1721:
+ *   7    6    5    4    3    2    1    0
+ * |Done| X  | X  | U  | R1 | R0 |POL |1SHOT|
+ *
+ * Where:
+ * - 'X' is Reserved
+ * - 'U' is Undefined
+ */
 #define DS1621_REG_CONFIG_NVB		0x10
+#define DS1621_REG_CONFIG_RESOL		0x0C
 #define DS1621_REG_CONFIG_POLARITY	0x02
 #define DS1621_REG_CONFIG_1SHOT		0x01
 #define DS1621_REG_CONFIG_DONE		0x80
 
-/* The DS1621 registers */
+#define DS1621_REG_CONFIG_RESOL_SHIFT	2
+
+/* ds1721 conversion rates: {C/LSB, time(ms), resolution bit setting} */
+static const unsigned short ds1721_convrates[] = {
+	94,	/*  9-bits (0.5,  93.75, RES[0..1] = 0 */
+	188,	/* 10-bits (0.25, 187.5, RES[0..1] = 1 */
+	375,	/* 11-bits (0.125,  375, RES[0..1] = 2 */
+	750,	/* 12-bits (0.0625, 750, RES[0..1] = 3 */
+};
+
+#define DS1621_CONVERSION_MAX	750
+#define DS1625_CONVERSION_MAX	500
+
+#define DS1621_TEMP_MAX	125000
+#define DS1621_TEMP_MIN	(-55000)
+
+/* The DS1621 temperature registers */
 static const u8 DS1621_REG_TEMP[3] = {
 	0xAA,		/* input, word, RO */
 	0xA2,		/* min, word, RW */
@@ -59,6 +107,7 @@ static const u8 DS1621_REG_TEMP[3] = {
 };
 #define DS1621_REG_CONF			0xAC /* byte, RW */
 #define DS1621_COM_START		0xEE /* no data */
+#define DS1721_COM_START		0x51 /* no data */
 #define DS1621_COM_STOP			0x22 /* no data */
 
 /* The DS1621 configuration register */
@@ -75,14 +124,37 @@ struct ds1621_data {
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
+	enum chips kind;		/* device type */
 
 	u16 temp[3];			/* Register values, word */
 	u8 conf;			/* Register encoding, combined */
+	u16 update_interval;		/* Conversion rate in milliseconds */
 };
 
+static inline int DS1621_TEMP_FROM_REG(u16 reg)
+{
+	return DIV_ROUND_CLOSEST(((s16)reg / 16) * 625, 10);
+}
+
+/*
+ * TEMP: 0.001C/bit (-55C to +125C)
+ * REG:
+ *  - 1621, 1625: x = 0.5C
+ *  - 1721:       x = 0.0625C
+ * Assume highest resolution and let the bits fall where they may..
+ */
+static inline u16 DS1621_TEMP_TO_REG(long temp)
+{
+	int ntemp = clamp_val(temp, DS1621_TEMP_MIN, DS1621_TEMP_MAX);
+	ntemp += (ntemp < 0 ? -31 : 31);
+	ntemp = DIV_ROUND_CLOSEST(ntemp * 10, 625) << 4;
+	return (u16)ntemp;
+}
+
 static void ds1621_init_client(struct i2c_client *client)
 {
-	u8 conf, new_conf;
+	u8 conf, new_conf, sreg, resol;
+	struct ds1621_data *data = i2c_get_clientdata(client);
 
 	new_conf = conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
 	/* switch to continuous conversion mode */
@@ -97,8 +169,25 @@ static void ds1621_init_client(struct i2c_client *client)
 	if (conf != new_conf)
 		i2c_smbus_write_byte_data(client, DS1621_REG_CONF, new_conf);
 
+	switch (data->kind) {
+	case ds1625:
+		data->update_interval = DS1625_CONVERSION_MAX;
+		sreg = DS1621_COM_START;
+		break;
+	case ds1721:
+		resol = (new_conf & DS1621_REG_CONFIG_RESOL) >>
+			 DS1621_REG_CONFIG_RESOL_SHIFT;
+		data->update_interval = ds1721_convrates[resol];
+		sreg = DS1721_COM_START;
+		break;
+	default:
+		data->update_interval = DS1621_CONVERSION_MAX;
+		sreg = DS1621_COM_START;
+		break;
+	}
+
 	/* start conversion */
-	i2c_smbus_write_byte(client, DS1621_COM_START);
+	i2c_smbus_write_byte(client, sreg);
 }
 
 static struct ds1621_data *ds1621_update_client(struct device *dev)
@@ -109,8 +198,8 @@ static struct ds1621_data *ds1621_update_client(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
+	if (time_after(jiffies, data->last_updated + data->update_interval) ||
+	    !data->valid) {
 		int i;
 
 		dev_dbg(&client->dev, "Starting ds1621 update\n");
@@ -146,7 +235,7 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ds1621_data *data = ds1621_update_client(dev);
 	return sprintf(buf, "%d\n",
-		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
+		       DS1621_TEMP_FROM_REG(data->temp[attr->index]));
 }
 
 static ssize_t set_temp(struct device *dev, struct device_attribute *da,
@@ -163,7 +252,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp[attr->index] = LM75_TEMP_TO_REG(val);
+	data->temp[attr->index] = DS1621_TEMP_TO_REG(val);
 	i2c_smbus_write_word_swapped(client, DS1621_REG_TEMP[attr->index],
 				     data->temp[attr->index]);
 	mutex_unlock(&data->update_lock);
@@ -257,6 +346,8 @@ static int ds1621_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
+	data->kind = id->driver_data;
+
 	/* Initialize the DS1621 chip */
 	ds1621_init_client(client);
 
@@ -289,8 +380,9 @@ static int ds1621_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds1621_id[] = {
-	{ "ds1621", 0 },
-	{ "ds1625", 0 },
+	{ "ds1621", ds1621 },
+	{ "ds1625", ds1625 },
+	{ "ds1721", ds1721 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1621_id);
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
