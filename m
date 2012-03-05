From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 Mar 2012 19:20:38 +0000
Subject: [lm-sensors] [PATCH 6/6] hwmon: (zl6100) Add support for ZL9101M and ZL9117M
Message-Id: <1330975238-16811-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ZL9101M and ZL9117M are compatible to ZL6100. Add support to the zl6100 driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch is untested, so I may drop it if I don't get the eval boards in time
for 3.4.

 Documentation/hwmon/zl6100   |    8 ++++++++
 drivers/hwmon/pmbus/Kconfig  |    6 +++---
 drivers/hwmon/pmbus/zl6100.c |    5 ++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index 51f76a1..52084b3 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -34,6 +34,14 @@ Supported chips:
     Prefix: 'zl6105'
     Addresses scanned: -
     Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
+  * Intersil / Zilker Labs ZL9101M
+    Prefix: 'zl9101m'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn7669.pdf
+  * Intersil / Zilker Labs ZL9117M
+    Prefix: 'zl9117m'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn7914.pdf
   * Ericsson BMR450, BMR451
     Prefix: 'bmr450', 'bmr451'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 9246d01..2ca6a5a 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -114,9 +114,9 @@ config SENSORS_ZL6100
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Intersil
-	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, and ZL6105
-	  Digital DC/DC Controllers, as well as for Ericsson BMR450, BMR451,
-	  BMR462, BMR463, and BMR464.
+	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, ZL6105,
+	  ZL9101M, and ZL9117M Digital DC/DC Controllers, as well as for
+	  Ericsson BMR450, BMR451, BMR462, BMR463, and BMR464.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called zl6100.
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 4a8fc63..92620d7 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -28,7 +28,8 @@
 #include <linux/delay.h>
 #include "pmbus.h"
 
-enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
+enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105,
+	     zl9101m, zl9117m };
 
 struct zl6100_data {
 	int id;
@@ -151,6 +152,8 @@ static const struct i2c_device_id zl6100_id[] = {
 	{"zl2106", zl2106},
 	{"zl6100", zl6100},
 	{"zl6105", zl6105},
+	{"zl9101m", zl9101m},
+	{"zl9117m", zl9117m},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zl6100_id);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
