From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Oct 2012 11:37:15 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add missing inclusions of <linux/err.h>
Message-Id: <20121003133715.04690c8e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121003131908.3a36fe3a@endymion.delvare>
In-Reply-To: <20121003131908.3a36fe3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These drivers use IS_ERR so they should include <linux/err.h>.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Henrik Rydberg <rydberg@euromail.se>
Cc: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/hwmon/acpi_power_meter.c |    1 +
 drivers/hwmon/applesmc.c         |    1 +
 drivers/hwmon/asus_atk0110.c     |    1 +
 drivers/hwmon/ibmaem.c           |    1 +
 drivers/hwmon/ibmpex.c           |    1 +
 drivers/hwmon/ultra45_env.c      |    1 +
 6 files changed, 6 insertions(+)

--- linux-3.7-rc0.orig/drivers/hwmon/acpi_power_meter.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/acpi_power_meter.c	2012-10-03 13:25:07.459293926 +0200
@@ -29,6 +29,7 @@
 #include <linux/kdev_t.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 
--- linux-3.7-rc0.orig/drivers/hwmon/applesmc.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/applesmc.c	2012-10-03 13:25:26.512299120 +0200
@@ -43,6 +43,7 @@
 #include <linux/leds.h>
 #include <linux/hwmon.h>
 #include <linux/workqueue.h>
+#include <linux/err.h>
 
 /* data port used by Apple SMC */
 #define APPLESMC_DATA_PORT	0x300
--- linux-3.7-rc0.orig/drivers/hwmon/asus_atk0110.c	2012-10-03 12:58:58.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/asus_atk0110.c	2012-10-03 13:25:14.939296141 +0200
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
+#include <linux/err.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acpixf.h>
--- linux-3.7-rc0.orig/drivers/hwmon/ibmaem.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ibmaem.c	2012-10-03 13:25:35.066301575 +0200
@@ -36,6 +36,7 @@
 #include <linux/platform_device.h>
 #include <linux/math64.h>
 #include <linux/time.h>
+#include <linux/err.h>
 
 #define REFRESH_INTERVAL	(HZ)
 #define IPMI_TIMEOUT		(30 * HZ)
--- linux-3.7-rc0.orig/drivers/hwmon/ibmpex.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ibmpex.c	2012-10-03 13:24:02.453126836 +0200
@@ -26,6 +26,7 @@
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/err.h>
 
 #define REFRESH_INTERVAL	(2 * HZ)
 #define DRVNAME			"ibmpex"
--- linux-3.7-rc0.orig/drivers/hwmon/ultra45_env.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ultra45_env.c	2012-10-03 13:23:55.985124621 +0200
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
 
 #define DRV_MODULE_VERSION	"0.1"
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
