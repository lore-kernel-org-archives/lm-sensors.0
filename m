From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 Mar 2012 19:20:34 +0000
Subject: [lm-sensors] [PATCH 2/6] hwmon: (pmbus) Add support for Lineage Power MDT040
Message-Id: <1330975238-16811-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MDT040 is supported by the generic PMBus driver. Add device ID and reference to
datasheet. Also mention Lineage Power device support in Kconfig.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/pmbus   |    3 ++-
 drivers/hwmon/pmbus/Kconfig |    3 ++-
 drivers/hwmon/pmbus/pmbus.c |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index c2b157b..f90f999 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -15,13 +15,14 @@ Supported chips:
 	http://www.onsemi.com/pub_link/Collateral/NCP4200-D.PDF
 	http://www.onsemi.com/pub_link/Collateral/JUNE%202009-%20REV.%200.PDF
   * Lineage Power
-    Prefixes: 'pdt003', 'pdt006', 'pdt012', 'udt020'
+    Prefixes: 'mdt040', 'pdt003', 'pdt006', 'pdt012', 'udt020'
     Addresses scanned: -
     Datasheets:
 	http://www.lineagepower.com/oem/pdf/PDT003A0X.pdf
 	http://www.lineagepower.com/oem/pdf/PDT006A0X.pdf
 	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
 	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
+	http://www.lineagepower.com/oem/pdf/MDT040A0X.pdf
   * Texas Instruments TPS40400, TPS40422
     Prefixes: 'tps40400', 'tps40422'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 7968c81..d1aa2db 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -20,7 +20,8 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
-	  NCP4200, NCP4208, TPS40400, and TPS40422.
+	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, TPS40400,
+	  and TPS40422.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 7d5161d..7e91700 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -185,6 +185,7 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"adp4000", 1},
 	{"bmr453", 1},
 	{"bmr454", 1},
+	{"mdt040", 1},
 	{"ncp4200", 1},
 	{"ncp4208", 1},
 	{"pdt003", 1},
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
