From: Keerthy <j-keerthy@ti.com>
Date: Thu, 16 Sep 2010 10:35:32 +0000
Subject: [lm-sensors] [PATCH 2/2] Makefile and Kconfig changes for
Message-Id: <1284632612-25339-1-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: j-keerthy@ti.com, balajitk@ti.com

Makefile amd Kconfig Changes for twl4030-madc driver inclusion.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ++++
 drivers/hwmon/Kconfig       |    4 ++++
 drivers/hwmon/Makefile      |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..139137b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -170,6 +170,8 @@ config MACH_OMAP_3430SDP
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select HWMON
+	select TWL4030_MADC
 
 config MACH_NOKIA_N800
        bool
@@ -206,6 +208,8 @@ config MACH_OMAP_ZOOM3
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBP
+	select HWMON
+	select TWL4030_MADC
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4d4d09b..47d66b9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -39,6 +39,10 @@ config HWMON_DEBUG_CHIP
 
 comment "Native drivers"
 
+config TWL4030_MADC
+	tristate
+	depends on HWMON && TWL4030_CORE
+
 config SENSORS_ABITUGURU
 	tristate "Abit uGuru (rev 1 & 2)"
 	depends on X86 && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e3c2484..24b3b17 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SENSORS_W83792D)	+= w83792d.o
 obj-$(CONFIG_SENSORS_W83793)	+= w83793.o
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
 obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
+obj-$(CONFIG_TWL4030_MADC)      += twl4030-madc.o
 
 obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
 obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
