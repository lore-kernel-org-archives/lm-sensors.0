From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 20:01:26 +0000
Subject: [lm-sensors] [PATCH 5/6] k8temp: Documentation update
Message-Id: <20061008220126.3bfe9476.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at assembler.cz>
Content-Disposition: inline; filename=hwmon-k8temp-documentation-update.patch

Update the documentation for the k8temp driver.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/k8temp |   13 ++++++++-----
 MAINTAINERS                |    6 ++++++
 drivers/hwmon/Kconfig      |    6 ++++--
 3 files changed, 18 insertions(+), 7 deletions(-)

--- linux-2.6.19-rc1.orig/Documentation/hwmon/k8temp	2006-10-08 09:52:06.000000000 +0200
+++ linux-2.6.19-rc1/Documentation/hwmon/k8temp	2006-10-08 09:55:19.000000000 +0200
@@ -2,7 +2,7 @@
 ==========
 
 Supported chips:
-  * AMD K8 CPU
+  * AMD Athlon64/FX or Opteron CPUs
     Prefix: 'k8temp'
     Addresses scanned: PCI space
     Datasheet: http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
@@ -13,10 +13,13 @@
 Description
 -----------
 
-This driver permits reading temperature sensor(s) embedded inside AMD K8 CPUs.
-Official documentation says that it works from revision F of K8 core, but
-in fact it seems to be implemented for all revisions of K8 except the first
-two revisions (SH-B0 and SH-B3).
+This driver permits reading temperature sensor(s) embedded inside AMD K8
+family CPUs (Athlon64/FX, Opteron). Official documentation says that it works
+from revision F of K8 core, but in fact it seems to be implemented for all
+revisions of K8 except the first two revisions (SH-B0 and SH-B3).
+
+Please note that you will need at least lm-sensors 2.10.1 for proper userspace
+support.
 
 There can be up to four temperature sensors inside single CPU. The driver
 will auto-detect the sensors and will display only temperatures from
--- linux-2.6.19-rc1.orig/drivers/hwmon/Kconfig	2006-10-08 09:52:06.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/Kconfig	2006-10-08 09:54:39.000000000 +0200
@@ -95,11 +95,13 @@
 	  will be called adm9240.
 
 config SENSORS_K8TEMP
-	tristate "AMD K8 processor sensor"
+	tristate "AMD Athlon64/FX or Opteron temperature sensor"
 	depends on HWMON && X86 && PCI && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the temperature
-	  sensor(s) inside your AMD K8 CPU.
+	  sensor(s) inside your CPU. Supported is whole AMD K8
+	  microarchitecture. Please note that you will need at least
+	  lm-sensors 2.10.1 for proper userspace support.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called k8temp.
--- linux-2.6.19-rc1.orig/MAINTAINERS	2006-10-08 09:51:15.000000000 +0200
+++ linux-2.6.19-rc1/MAINTAINERS	2006-10-08 09:53:34.000000000 +0200
@@ -1666,6 +1666,12 @@
 L:	ext2-devel at lists.sourceforge.net
 S:	Maintained
 
+K8TEMP HARDWARE MONITORING DRIVER
+P:	Rudolf Marek
+M:	r.marek at assembler.cz
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 KCONFIG
 P:	Roman Zippel
 M:	zippel at linux-m68k.org

-- 
Jean Delvare

