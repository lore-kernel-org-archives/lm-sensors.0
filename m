From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Date: Tue, 11 Mar 2014 21:25:59 +0000
Subject: [lm-sensors] [PATCH] hwmon, k10temp: Add support for AMD F16 M30h processor
Message-Id: <1394573159-2317-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clemens@ladisch.de, jdelvare@suse.de, linux@roeck-us.net, rob@landley.net, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andre@andrep.de, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>

Adding new PCI ID to support AMD F16 M30h processor (Mullins).
While at it, modify Kconfig and Doc files to reflect the
support for newer processors

Note: PCI ID for this processor will make it into pci_ids.h
as part of this patch:
http://marc.info/?l=linux-kernel&m9291362126057&w=2
which should be pulled into 3.15 when merge window opens
(It currently sits in 'for-next' branch of bp.git-
https://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next)

Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
---
 Documentation/hwmon/k10temp | 6 +++---
 drivers/hwmon/Kconfig       | 4 ++--
 drivers/hwmon/k10temp.c     | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/k10temp b/Documentation/hwmon/k10temp
index 4dfdc8f..ee6d30e 100644
--- a/Documentation/hwmon/k10temp
+++ b/Documentation/hwmon/k10temp
@@ -11,8 +11,8 @@ Supported chips:
   Socket S1G2: Athlon (X2), Sempron (X2), Turion X2 (Ultra)
 * AMD Family 12h processors: "Llano" (E2/A4/A6/A8-Series)
 * AMD Family 14h processors: "Brazos" (C/E/G/Z-Series)
-* AMD Family 15h processors: "Bulldozer" (FX-Series), "Trinity"
-* AMD Family 16h processors: "Kabini"
+* AMD Family 15h processors: "Bulldozer" (FX-Series), "Trinity", "Kaveri"
+* AMD Family 16h processors: "Kabini", "Mullins"
 
   Prefix: 'k10temp'
   Addresses scanned: PCI space
@@ -46,7 +46,7 @@ Description
 -----------
 
 This driver permits reading of the internal temperature sensor of AMD
-Family 10h/11h/12h/14h/15h processors.
+Family 10h/11h/12h/14h/15h/16h processors.
 
 All these processors have a sensor, but on those for Socket F or AM2+,
 the sensor may return inconsistent values (erratum 319).  The driver
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5ce43d8..83db056 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -296,8 +296,8 @@ config SENSORS_K10TEMP
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported are later revisions of
 	  the AMD Family 10h and all revisions of the AMD Family 11h,
-	  12h (Llano), 14h (Brazos), 15h (Bulldozer/Trinity) and
-	  16h (Kabini) microarchitectures.
+	  12h (Llano), 14h (Brazos), 15h (Bulldozer/Trinity/Kaveri) and
+	  16h (Kabini/Mullins) microarchitectures.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called k10temp.
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index baf375b..f7b46f6 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -212,6 +212,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
-- 
1.8.1.2



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
