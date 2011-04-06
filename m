From: Andre Przywara <andre.przywara@amd.com>
Date: Wed, 06 Apr 2011 10:56:23 +0000
Subject: [lm-sensors] [PATCH] hwmon/k10temp: add support for Fam15h
Message-Id: <1302087626-30007-1-git-send-email-andre.przywara@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302079081-22572-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1302079081-22572-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

AMDs upcoming CPUs use the same mechanism for the internal
temperature reporting as the Fam10h CPUs, so we just needed to add
the appropriate PCI-ID to the list.
This allows to use the k10temp driver on those CPUs.
While at it change the Kconfig entry to be more generic.

Signed-off-by: Andre Przywara <andre.przywara@amd.com>
---
 Documentation/hwmon/k10temp |    3 ++-
 drivers/hwmon/Kconfig       |    4 ++--
 drivers/hwmon/k10temp.c     |    5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/k10temp b/Documentation/hwmon/k10temp
index d2b56a4..0393c89 100644
--- a/Documentation/hwmon/k10temp
+++ b/Documentation/hwmon/k10temp
@@ -11,6 +11,7 @@ Supported chips:
   Socket S1G2: Athlon (X2), Sempron (X2), Turion X2 (Ultra)
 * AMD Family 12h processors: "Llano"
 * AMD Family 14h processors: "Brazos" (C/E/G-Series)
+* AMD Family 15h processors: "Bulldozer"
 
   Prefix: 'k10temp'
   Addresses scanned: PCI space
@@ -40,7 +41,7 @@ Description
 -----------
 
 This driver permits reading of the internal temperature sensor of AMD
-Family 10h/11h/12h/14h processors.
+Family 10h/11h/12h/14h/15h processors.
 
 All these processors have a sensor, but on those for Socket F or AM2+,
 the sensor may return inconsistent values (erratum 319).  The driver
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 060ef63..95b5516 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -238,13 +238,13 @@ config SENSORS_K8TEMP
 	  will be called k8temp.
 
 config SENSORS_K10TEMP
-	tristate "AMD Family 10h/11h/12h/14h temperature sensor"
+	tristate "AMD Family 10h+ temperature sensor"
 	depends on X86 && PCI
 	help
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported are later revisions of
 	  the AMD Family 10h and all revisions of the AMD Family 11h,
-	  12h (Llano), and 14h (Brazos) microarchitectures.
+	  12h (Llano), 14h (Brazos) and 15h (Bulldozer) microarchitectures.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called k10temp.
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 82bf65a..306bea8 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -1,5 +1,5 @@
 /*
- * k10temp.c - AMD Family 10h/11h/12h/14h processor hardware monitoring
+ * k10temp.c - AMD Family 10h/11h/12h/14h/15h processor hardware monitoring
  *
  * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
  *
@@ -25,7 +25,7 @@
 #include <linux/pci.h>
 #include <asm/processor.h>
 
-MODULE_DESCRIPTION("AMD Family 10h/11h/12h/14h CPU core temperature monitor");
+MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL");
 
@@ -209,6 +209,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
-- 
1.6.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
