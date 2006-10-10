From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 10 Oct 2006 20:54:09 +0000
Subject: [lm-sensors] patch hwmon-k8temp-documentation-update.patch added to
Message-Id: <20061010205401.DD2FF936C33@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 5/6] k8temp: Documentation update

to my gregkh-2.6 tree.  Its filename is

     hwmon-k8temp-documentation-update.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Oct  8 13:01:38 2006
Date: Sun, 8 Oct 2006 22:01:26 +0200
From: Rudolf Marek <r.marek at assembler.cz>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Rudolf Marek <r.marek at assembler.cz>
Subject: [PATCH 5/6] k8temp: Documentation update
Message-Id: <20061008220126.3bfe9476.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-k8temp-documentation-update.patch

From: Rudolf Marek <r.marek at assembler.cz>

Update the documentation for the k8temp driver.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/k8temp |   13 ++++++++-----
 MAINTAINERS                |    6 ++++++
 drivers/hwmon/Kconfig      |    6 ++++--
 3 files changed, 18 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/k8temp
+++ gregkh-2.6/Documentation/hwmon/k8temp
@@ -2,7 +2,7 @@ Kernel driver k8temp
 ==========
 
 Supported chips:
-  * AMD K8 CPU
+  * AMD Athlon64/FX or Opteron CPUs
     Prefix: 'k8temp'
     Addresses scanned: PCI space
     Datasheet: http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
@@ -13,10 +13,13 @@ Contact: Rudolf Marek <r.marek at sh.cvut.c
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
--- gregkh-2.6.orig/MAINTAINERS
+++ gregkh-2.6/MAINTAINERS
@@ -1666,6 +1666,12 @@ M:	sct at redhat.com, akpm at osdl.org
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
--- gregkh-2.6.orig/drivers/hwmon/Kconfig
+++ gregkh-2.6/drivers/hwmon/Kconfig
@@ -95,11 +95,13 @@ config SENSORS_ADM9240
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


Patches currently in gregkh-2.6 which might be from r.marek at assembler.cz are

i2c/hwmon-k8temp-documentation-update.patch
i2c/hwmon-w83627ehf-fix-fan5-detection.patch

