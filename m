From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Mar 2013 11:16:51 +0000
Subject: [lm-sensors] [PATCH 5/5 v2] Add support for the Dallas/Maxim DS7505
Message-Id: <20130313121651.4438345e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Basically it's the same as the original DS75 but much faster.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v2:
 * Fix chip names.

 Documentation/hwmon/lm75 |    8 ++++----
 drivers/hwmon/Kconfig    |    2 +-
 drivers/hwmon/lm75.c     |    7 +++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

--- linux-3.9-rc2.orig/Documentation/hwmon/lm75	2013-03-12 15:49:08.893730398 +0100
+++ linux-3.9-rc2/Documentation/hwmon/lm75	2013-03-12 15:51:32.842053514 +0100
@@ -12,11 +12,11 @@ Supported chips:
     Addresses scanned: I2C 0x48 - 0x4f
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/
-  * Dallas Semiconductor DS75, DS1775
-    Prefixes: 'ds75', 'ds1775'
+  * Dallas Semiconductor (now Maxim) DS75, DS1775, DS7505
+    Prefixes: 'ds75', 'ds1775', 'ds7505'
     Addresses scanned: none
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.maxim-ic.com/
+    Datasheet: Publicly available at the Maxim website
+               http://www.maximintegrated.com/
   * Maxim MAX6625, MAX6626
     Prefixes: 'max6625', 'max6626'
     Addresses scanned: none
--- linux-3.9-rc2.orig/drivers/hwmon/Kconfig	2013-03-12 15:07:16.999781820 +0100
+++ linux-3.9-rc2/drivers/hwmon/Kconfig	2013-03-12 15:51:32.845053584 +0100
@@ -588,7 +588,7 @@ config SENSORS_LM75
 	  temperature sensor chip, with models including:
 
 		- Analog Devices ADT75
-		- Dallas Semiconductor DS75 and DS1775
+		- Dallas Semiconductor DS75, DS1775 and DS7505
 		- Maxim MAX6625 and MAX6626
 		- Microchip MCP980x
 		- National Semiconductor LM75, LM75A
--- linux-3.9-rc2.orig/drivers/hwmon/lm75.c	2013-03-12 15:46:06.388517515 +0100
+++ linux-3.9-rc2/drivers/hwmon/lm75.c	2013-03-12 15:51:32.845053584 +0100
@@ -38,6 +38,7 @@ enum lm75_type {		/* keep sorted in alph
 	adt75,
 	ds1775,
 	ds75,
+	ds7505,
 	lm75,
 	lm75a,
 	max6625,
@@ -202,6 +203,11 @@ lm75_probe(struct i2c_client *client, co
 		data->resolution = 11;
 		data->sample_time = HZ;
 		break;
+	case ds7505:
+		set_mask |= 3 << 5;		/* 12-bit mode */
+		data->resolution = 12;
+		data->sample_time = HZ / 4;
+		break;
 	case lm75:
 	case lm75a:
 		data->resolution = 9;
@@ -289,6 +295,7 @@ static const struct i2c_device_id lm75_i
 	{ "adt75", adt75, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
+	{ "ds7505", ds7505, },
 	{ "lm75", lm75, },
 	{ "lm75a", lm75a, },
 	{ "max6625", max6625, },

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
