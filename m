From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Mar 2013 12:33:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm75.h) Update header inclusion
Message-Id: <20130307133301.4cfd2414@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

File lm75.h used to include <linux/hwmon.h> for SENSORS_LIMIT() but
this function is gone by now. Instead we call clamp_val() so we should
include <linux/kernel.h>, where this function is declared.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm75.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.9-rc1.orig/drivers/hwmon/lm75.h	2013-03-05 10:33:28.169897107 +0100
+++ linux-3.9-rc1/drivers/hwmon/lm75.h	2013-03-07 13:28:24.877903474 +0100
@@ -25,7 +25,7 @@
     which contains this code, we don't worry about the wasted space.
 */
 
-#include <linux/hwmon.h>
+#include <linux/kernel.h>
 
 /* straight from the datasheet */
 #define LM75_TEMP_MIN (-55000)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
