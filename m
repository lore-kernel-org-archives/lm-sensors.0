From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Nov 2011 19:30:52 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (pmbus/zl6100) Add support for
Message-Id: <1322076654-5652-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add explicit support for ZL2005. Functionality is almost the same as with other
Zilker Labs / Intersil chips, but limit register detection does not work reliably.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/zl6100   |    4 ++++
 drivers/hwmon/pmbus/Kconfig  |    4 ++--
 drivers/hwmon/pmbus/zl6100.c |   19 +++++++++++++++++--
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index 7617798..d3bca06 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'zl2004'
     Addresses scanned: -
     Datasheet: http://www.intersil.com/data/fn/fn6847.pdf
+  * Intersil / Zilker Labs ZL2005
+    Prefix: 'zl2005'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6848.pdf
   * Intersil / Zilker Labs ZL2006
     Prefix: 'zl2006'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 4b26f51..d357ab2 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -113,8 +113,8 @@ config SENSORS_ZL6100
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Intersil
-	  ZL2004, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, and ZL6105 Digital
-	  DC/DC Controllers.
+	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, and ZL6105
+	  Digital DC/DC Controllers.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called zl6100.
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 2bc9800..d78bdcf 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -28,7 +28,7 @@
 #include <linux/delay.h>
 #include "pmbus.h"
 
-enum chips { zl2004, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
+enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
 
 struct zl6100_data {
 	int id;
@@ -65,6 +65,19 @@ static int zl6100_read_word_data(struct i2c_client *client, int page, int reg)
 	if (page || reg >= PMBUS_VIRT_BASE)
 		return -ENXIO;
 
+	if (data->id = zl2005) {
+		/*
+		 * Limit register detection is not reliable on ZL2005.
+		 * Make sure registers are not erroneously detected.
+		 */
+		switch (reg) {
+		case PMBUS_VOUT_OV_WARN_LIMIT:
+		case PMBUS_VOUT_UV_WARN_LIMIT:
+		case PMBUS_IOUT_OC_WARN_LIMIT:
+			return -ENXIO;
+		}
+	}
+
 	zl6100_wait(data);
 	ret = pmbus_read_word_data(client, page, reg);
 	data->access = ktime_get();
@@ -123,6 +136,7 @@ static int zl6100_write_byte(struct i2c_client *client, int page, u8 value)
 
 static const struct i2c_device_id zl6100_id[] = {
 	{"zl2004", zl2004},
+	{"zl2005", zl2005},
 	{"zl2006", zl2006},
 	{"zl2008", zl2008},
 	{"zl2105", zl2105},
@@ -177,8 +191,9 @@ static int zl6100_probe(struct i2c_client *client,
 	data->id = mid->driver_data;
 
 	/*
-	 * ZL2008, ZL2105, and ZL6100 are known to require a wait time
+	 * ZL2005, ZL2008, ZL2105, and ZL6100 are known to require a wait time
 	 * between I2C accesses. ZL2004 and ZL6105 are known to be safe.
+	 * Other chips have not yet been tested.
 	 *
 	 * Only clear the wait time for chips known to be safe. The wait time
 	 * can be cleared later for additional chips if tests show that it
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
