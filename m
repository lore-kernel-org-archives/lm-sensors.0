From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Dec 2009 13:16:35 +0000
Subject: [lm-sensors] [PATCH] hwmon: (k10temp) Blacklist more family 10h
Message-Id: <20091220141635.1dedac02@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

The latest version of the Revision Guide for AMD Family 10h Processors
lists two more processor revisions which may be affected by erratum 319.
Change the blacklisting code to correctly detect those processors, by
implementing AMD's recommended algorithm.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
---
Testers wanted! Testing also possible by using the standalone driver at:
http://khali.linux-fr.org/devel/misc/k10temp/

 Documentation/hwmon/k10temp |   12 ++++++------
 drivers/hwmon/k10temp.c     |   38 ++++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 12 deletions(-)

--- linux-2.6.33-rc1.orig/Documentation/hwmon/k10temp	2009-12-20 09:07:00.000000000 +0100
+++ linux-2.6.33-rc1/Documentation/hwmon/k10temp	2009-12-20 09:07:29.000000000 +0100
@@ -3,8 +3,8 @@ Kernel driver k10temp
 
 Supported chips:
 * AMD Family 10h processors:
-  Socket F: Quad-Core/Six-Core/Embedded Opteron
-  Socket AM2+: Opteron, Phenom (II) X3/X4
+  Socket F: Quad-Core/Six-Core/Embedded Opteron (but see below)
+  Socket AM2+: Quad-Core Opteron, Phenom (II) X3/X4, Athlon X2 (but see below)
   Socket AM3: Quad-Core Opteron, Athlon/Phenom II X2/X3/X4, Sempron II
   Socket S1G3: Athlon II, Sempron, Turion II
 * AMD Family 11h processors:
@@ -36,10 +36,10 @@ Description
 This driver permits reading of the internal temperature sensor of AMD
 Family 10h and 11h processors.
 
-All these processors have a sensor, but on older revisions of Family 10h
-processors, the sensor may return inconsistent values (erratum 319). The
-driver will refuse to load on these revisions unless you specify the
-"force=1" module parameter.
+All these processors have a sensor, but on those for Socket F or AM2+,
+the sensor may return inconsistent values (erratum 319).  The driver
+will refuse to load on these revisions unless you specify the "force=1"
+module parameter.
 
 There is one temperature measurement value, available as temp1_input in
 sysfs. It is measured in degrees Celsius with a resolution of 1/8th degree.
--- linux-2.6.33-rc1.orig/drivers/hwmon/k10temp.c	2009-12-20 09:07:00.000000000 +0100
+++ linux-2.6.33-rc1/drivers/hwmon/k10temp.c	2009-12-20 09:07:29.000000000 +0100
@@ -33,6 +33,16 @@ static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
 
+/* CPUID function 0x80000001, ebx */
+#define CPUID_PKGTYPE_MASK	0xf0000000
+#define CPUID_PKGTYPE_F		0x00000000
+#define CPUID_PKGTYPE_AM2R2_AM3	0x10000000
+
+/* DRAM controller (PCI function 2) */
+#define REG_DCT0_CONFIG_HIGH		0x094
+#define  DDR3_MODE			0x00000100
+
+/* miscellaneous (PCI function 3) */
 #define REG_HARDWARE_THERMAL_CONTROL	0x64
 #define  HTC_ENABLE			0x00000001
 
@@ -85,13 +95,28 @@ static SENSOR_DEVICE_ATTR(temp1_crit, S_
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static bool __devinit has_erratum_319(void)
+static bool __devinit has_erratum_319(struct pci_dev *pdev)
 {
+	u32 pkg_type, reg_dram_cfg;
+
+	if (boot_cpu_data.x86 != 0x10)
+		return false;
+
 	/*
-	 * Erratum 319: The thermal sensor of older Family 10h processors
-	 *              (B steppings) may be unreliable.
+	 * Erratum 319: The thermal sensor of Socket F/AM2+ processors
+	 *              may be unreliable.
 	 */
-	return boot_cpu_data.x86 = 0x10 && boot_cpu_data.x86_model <= 2;
+	pkg_type = cpuid_ebx(0x80000001) & CPUID_PKGTYPE_MASK;
+	if (pkg_type = CPUID_PKGTYPE_F)
+		return true;
+	if (pkg_type != CPUID_PKGTYPE_AM2R2_AM3)
+		return false;
+
+	/* Differentiate between AM2+ (bad) and AM3 (good) */
+	pci_bus_read_config_dword(pdev->bus,
+				  PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
+				  REG_DCT0_CONFIG_HIGH, &reg_dram_cfg);
+	return !(reg_dram_cfg & DDR3_MODE);
 }
 
 static int __devinit k10temp_probe(struct pci_dev *pdev,
@@ -99,9 +124,10 @@ static int __devinit k10temp_probe(struc
 {
 	struct device *hwmon_dev;
 	u32 reg_caps, reg_htc;
+	int unreliable = has_erratum_319(pdev);
 	int err;
 
-	if (has_erratum_319() && !force) {
+	if (unreliable && !force) {
 		dev_err(&pdev->dev,
 			"unreliable CPU thermal sensor; monitoring disabled\n");
 		err = -ENODEV;
@@ -139,7 +165,7 @@ static int __devinit k10temp_probe(struc
 	}
 	dev_set_drvdata(&pdev->dev, hwmon_dev);
 
-	if (has_erratum_319() && force)
+	if (unreliable && force)
 		dev_warn(&pdev->dev,
 			 "unreliable CPU thermal sensor; check erratum 319\n");
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
