From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 15:41:29 +0000
Subject: [lm-sensors] [PATCH 04/15] hwmon: (pmbus) Add Intersil power
Message-Id: <1310485300-2168-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add Intersil power management chips to the list of devices supported by the
generic PMBus driver, and add device IDs to enable explicit instantiation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/pmbus   |   10 ++++++++++
 drivers/hwmon/pmbus/Kconfig |    3 ++-
 drivers/hwmon/pmbus/pmbus.c |    6 ++++++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index c36c1c1..3d9ca9b 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -8,6 +8,16 @@ Supported chips:
     Addresses scanned: -
     Datasheet:
  http://archive.ericsson.net/service/internet/picov/get?DocNo(701-EN/LZT146395
+  * Intersil ZL2004, ZL2006, ZL2008, ZL2106, ZL6100, ZL6105
+    Prefixes: 'zl2004', 'zl2006', 'zl2008', 'zl2106', 'zl6100', zl6105'
+    Addresses scanned: -
+    Datasheets:
+	http://www.intersil.com/data/fn/fn6846.pdf
+	http://www.intersil.com/data/fn/fn6850.pdf
+	http://www.intersil.com/data/fn/fn6859.pdf
+	http://www.intersil.com/data/fn/fn6852.pdf
+	http://www.intersil.com/data/fn/fn6876.pdf
+	http://www.intersil.com/data/fn/fn6906.pdf
   * Linear Technology LTC2978
     Octal PMBus Power Supply Monitor and Controller
     Prefix: 'ltc2978'
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index c69ffb5..f3cf83d 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -20,7 +20,8 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR450, BMR451,
-	  BMR453, BMR454, LTC2978, NCP4200, and NCP4208.
+	  BMR453, BMR454, LTC2978, NCP4200, NCP4208, ZL2004, ZL2006, ZL2008,
+	  ZL2106, ZL6100, and ZL6105.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 73de9f1..56bb3b7 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -209,6 +209,12 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"ncp4200", 1},
 	{"ncp4208", 1},
 	{"pmbus", 0},
+	{"zl2004", 1},
+	{"zl2006", 1},
+	{"zl2008", 1},
+	{"zl2106", 1},
+	{"zl6100", 1},
+	{"zl6105", 1},
 	{}
 };
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
