From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 Mar 2012 19:20:33 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (pmbus) Add support for TI TPS40400 and TPS40422
Message-Id: <1330975238-16811-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TPS40400 and TPS40422 are supported by the generic PMBus driver.
Add device IDs and data sheet references.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/pmbus   |    6 ++++++
 drivers/hwmon/pmbus/Kconfig |    2 +-
 drivers/hwmon/pmbus/pmbus.c |    2 ++
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index d28b591..c2b157b 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -22,6 +22,12 @@ Supported chips:
 	http://www.lineagepower.com/oem/pdf/PDT006A0X.pdf
 	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
 	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
+  * Texas Instruments TPS40400, TPS40422
+    Prefixes: 'tps40400', 'tps40422'
+    Addresses scanned: -
+    Datasheets:
+	http://www.ti.com/lit/gpn/tps40400
+	http://www.ti.com/lit/gpn/tps40422
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index cfec923..7968c81 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -20,7 +20,7 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
-	  NCP4200, and NCP4208.
+	  NCP4200, NCP4208, TPS40400, and TPS40422.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 3488740..7d5161d 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -191,6 +191,8 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"pdt006", 1},
 	{"pdt012", 1},
 	{"pmbus", 0},
+	{"tps40400", 1},
+	{"tps40422", 2},
 	{"udt020", 1},
 	{}
 };
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
