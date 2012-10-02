From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Oct 2012 16:20:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: Drop needless includes of <linux/delay.h>
Message-Id: <20121002182056.6adb0fa4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These drivers use no sleep or delay functions so they don't need to
include <linux/delay.h>.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/hwmon/adt7411.c          |    1 -
 drivers/hwmon/adt7462.c          |    1 -
 drivers/hwmon/da9052-hwmon.c     |    1 -
 drivers/hwmon/emc6w201.c         |    1 -
 drivers/hwmon/i5k_amb.c          |    1 -
 drivers/hwmon/k8temp.c           |    1 -
 drivers/hwmon/max16065.c         |    1 -
 drivers/hwmon/pmbus/pmbus_core.c |    1 -
 drivers/hwmon/s3c-hwmon.c        |    1 -
 drivers/hwmon/w83795.c           |    1 -
 10 files changed, 10 deletions(-)

--- linux-3.7-rc0.orig/drivers/hwmon/adt7411.c	2012-10-02 08:54:00.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/adt7411.c	2012-10-02 18:13:50.152275197 +0200
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
--- linux-3.7-rc0.orig/drivers/hwmon/adt7462.c	2012-10-02 08:54:00.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/adt7462.c	2012-10-02 18:13:34.791270368 +0200
@@ -26,7 +26,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 
--- linux-3.7-rc0.orig/drivers/hwmon/da9052-hwmon.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/da9052-hwmon.c	2012-10-02 18:14:12.009281303 +0200
@@ -12,7 +12,6 @@
  *
  */
 
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
--- linux-3.7-rc0.orig/drivers/hwmon/emc6w201.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/emc6w201.c	2012-10-02 18:13:45.704273808 +0200
@@ -18,7 +18,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
--- linux-3.7-rc0.orig/drivers/hwmon/i5k_amb.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/i5k_amb.c	2012-10-02 18:13:28.499268624 +0200
@@ -26,7 +26,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
--- linux-3.7-rc0.orig/drivers/hwmon/k8temp.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/k8temp.c	2012-10-02 18:13:41.961272565 +0200
@@ -22,7 +22,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
--- linux-3.7-rc0.orig/drivers/hwmon/max16065.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/max16065.c	2012-10-02 18:14:16.607282770 +0200
@@ -22,7 +22,6 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include <linux/delay.h>
 #include <linux/jiffies.h>
 
 enum chips { max16065, max16066, max16067, max16068, max16070, max16071 };
--- linux-3.7-rc0.orig/drivers/hwmon/pmbus/pmbus_core.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/pmbus/pmbus_core.c	2012-10-02 18:13:54.414276552 +0200
@@ -26,7 +26,6 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include <linux/delay.h>
 #include <linux/i2c/pmbus.h>
 #include "pmbus.h"
 
--- linux-3.7-rc0.orig/drivers/hwmon/s3c-hwmon.c	2012-10-02 08:54:00.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/s3c-hwmon.c	2012-10-02 18:13:58.213277857 +0200
@@ -22,7 +22,6 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/err.h>
--- linux-3.7-rc0.orig/drivers/hwmon/w83795.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/w83795.c	2012-10-02 18:14:04.073279344 +0200
@@ -34,7 +34,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
