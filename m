From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 08 Aug 2015 04:17:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus) Add device IDs for TPS544{B, C}2{0, 5}
Message-Id: <1439007442-5086-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add device IDs and references for Texas Instruments TPS544B20, TPS544B25,
TPS544C20, and TPS544C25 to the generic PMBus driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/pmbus   | 8 ++++++--
 drivers/hwmon/pmbus/Kconfig | 3 ++-
 drivers/hwmon/pmbus/pmbus.c | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index a3557da8f5b4..b397675e876d 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -23,11 +23,15 @@ Supported chips:
 	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
 	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
 	http://www.lineagepower.com/oem/pdf/MDT040A0X.pdf
-  * Texas Instruments TPS40400
-    Prefixes: 'tps40400'
+  * Texas Instruments TPS40400, TPS544B20, TPS544B25, TPS544C20, TPS544C25
+    Prefixes: 'tps40400', 'tps544b20', 'tps544b25', 'tps544c20', 'tps544c25'
     Addresses scanned: -
     Datasheets:
 	http://www.ti.com/lit/gpn/tps40400
+	http://www.ti.com/lit/gpn/tps544b20
+	http://www.ti.com/lit/gpn/tps544b25
+	http://www.ti.com/lit/gpn/tps544c20
+	http://www.ti.com/lit/gpn/tps544c25
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 47be0468e72e..8279727987cb 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -20,7 +20,8 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
-	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, and TPS40400.
+	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, TPS40400, TPS544B20,
+	  TPS544B25, TPS544C20, TPS544C25, and UDT020.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index bbfa35d82e42..0a74991a60f0 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -194,6 +194,10 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"pdt012", 1},
 	{"pmbus", 0},
 	{"tps40400", 1},
+	{"tps544b20", 1},
+	{"tps544b25", 1},
+	{"tps544c20", 1},
+	{"tps544c25", 1},
 	{"udt020", 1},
 	{}
 };
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
