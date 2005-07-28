From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 28 Jul 2005 23:14:46 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: move SENSORS_LIMIT to hwmon.h
Message-Id: <20050728231459.3c3585e4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Mark, all,

Move SENSORS_LIMIT from i2c-sensor.h to hwmon.h, as it is in no way
related to i2c.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/lm75.h       |    2 +-
 include/linux/hwmon.h      |   11 +++++++++++
 include/linux/i2c-sensor.h |   12 ------------
 3 files changed, 12 insertions(+), 13 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/lm75.h	2005-07-13 23:34:12.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm75.h	2005-07-28 20:37:34.000000000 +0200
@@ -25,7 +25,7 @@
     which contains this code, we don't worry about the wasted space.
 */
 
-#include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
 
 /* straight from the datasheet */
 #define LM75_TEMP_MIN (-55000)
--- linux-2.6.13-rc3.orig/include/linux/hwmon.h	2005-07-17 21:44:37.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/hwmon.h	2005-07-28 20:37:34.000000000 +0200
@@ -20,5 +20,16 @@
 
 void hwmon_device_unregister(struct class_device *cdev);
 
+/* Scale user input to sensible values */
+static inline int SENSORS_LIMIT(long value, long low, long high)
+{
+	if (value < low)
+		return low;
+	else if (value > high)
+		return high;
+	else
+		return value;
+}
+
 #endif
 
--- linux-2.6.13-rc3.orig/include/linux/i2c-sensor.h	2005-07-28 18:55:02.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/i2c-sensor.h	2005-07-28 20:37:34.000000000 +0200
@@ -242,16 +242,4 @@
 		      struct i2c_address_data *address_data,
 		      int (*found_proc) (struct i2c_adapter *, int, int));
 
-
-/* This macro is used to scale user-input to sensible values in almost all
-   chip drivers. */
-static inline int SENSORS_LIMIT(long value, long low, long high)
-{
-	if (value < low)
-		return low;
-	else if (value > high)
-		return high;
-	else
-		return value;
-}
 #endif				/* def _LINUX_I2C_SENSOR_H */


-- 
Jean Delvare
