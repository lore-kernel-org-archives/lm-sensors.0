From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: move SENSORS_LIMIT to hwmon.h
Message-Id: <11259567682388@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: move SENSORS_LIMIT to hwmon.h

Move SENSORS_LIMIT from i2c-sensor.h to hwmon.h, as it is in no way
related to i2c.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 53ae11b08353268c4012ef107bf205a0724d71aa
tree 10820fdc417eb80a329a3326315fe74d5f545ae3
parent b6d7b3d1b5a388b7e9af2629a9ecccedee064078
author Jean Delvare <khali@linux-fr.org> Thu, 28 Jul 2005 23:14:59 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:17 -0700

 drivers/hwmon/lm75.h       |    2 +-
 include/linux/hwmon.h      |   11 +++++++++++
 include/linux/i2c-sensor.h |   12 ------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -25,7 +25,7 @@
     which contains this code, we don't worry about the wasted space.
 */
 
-#include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
 
 /* straight from the datasheet */
 #define LM75_TEMP_MIN (-55000)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -20,5 +20,16 @@ struct class_device *hwmon_device_regist
 
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
 
diff --git a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h
+++ b/include/linux/i2c-sensor.h
@@ -242,16 +242,4 @@ extern int i2c_detect(struct i2c_adapter
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

