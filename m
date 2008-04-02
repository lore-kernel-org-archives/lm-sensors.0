From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Wed, 02 Apr 2008 08:07:25 +0000
Subject: [lm-sensors] [PATCH 1/3] thermal: build generic thermal driver as a
Message-Id: <1207123645.27304.3.camel@acpi-hp-zz.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

The generic thermal driver can be built as module "thermal_sys",
which give us more flexibility both at build time and
when bugs are reported.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig   |    4 ++--
 drivers/thermal/Makefile  |    3 ++-
 drivers/thermal/thermal.c |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/thermal/Kconfig
=================================--- linux-2.6.orig/drivers/thermal/Kconfig
+++ linux-2.6/drivers/thermal/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig THERMAL
-	bool "Generic Thermal sysfs driver"
+	tristate "Generic Thermal sysfs driver"
 	help
 	  Generic Thermal Sysfs driver offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
@@ -11,4 +11,4 @@ menuconfig THERMAL
 	  Each thermal zone contains its own temperature, trip points,
 	  cooling devices.
 	  All platforms with ACPI thermal support can use this driver.
-	  If you want this support, you should say Y here.
+	  If you want this support, you should say Y or M here.
Index: linux-2.6/drivers/thermal/thermal.c
=================================--- linux-2.6.orig/drivers/thermal/thermal.c
+++ linux-2.6/drivers/thermal/thermal.c
@@ -31,7 +31,7 @@
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
 
-MODULE_AUTHOR("Zhang Rui")
+MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
Index: linux-2.6/drivers/thermal/Makefile
=================================--- linux-2.6.orig/drivers/thermal/Makefile
+++ linux-2.6/drivers/thermal/Makefile
@@ -2,4 +2,5 @@
 # Makefile for sensor chip drivers.
 #
 
-obj-$(CONFIG_THERMAL)		+= thermal.o
+thermal_sys-objs	+= thermal.o
+obj-$(CONFIG_THERMAL)		+= thermal_sys.o



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
