From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Jun 2010 16:47:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (k10temp) Do not blacklist known
Message-Id: <20100601184732.7a498112@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When detecting AM2+ or AM3 socket with DDR2, only blacklist cores
which are known to exist in AM2+ format.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k10temp.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- linux-2.6.35-rc1.orig/drivers/hwmon/k10temp.c	2010-05-17 18:42:27.000000000 +0200
+++ linux-2.6.35-rc1/drivers/hwmon/k10temp.c	2010-06-01 18:08:01.000000000 +0200
@@ -112,11 +112,22 @@ static bool __devinit has_erratum_319(st
 	if (pkg_type != CPUID_PKGTYPE_AM2R2_AM3)
 		return false;
 
-	/* Differentiate between AM2+ (bad) and AM3 (good) */
+	/* DDR3 memory implies socket AM3, which is good */
 	pci_bus_read_config_dword(pdev->bus,
 				  PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
 				  REG_DCT0_CONFIG_HIGH, &reg_dram_cfg);
-	return !(reg_dram_cfg & DDR3_MODE);
+	if (reg_dram_cfg & DDR3_MODE)
+		return false;
+
+	/*
+	 * Unfortunately it is possible to run a socket AM3 CPU with DDR2
+	 * memory. We blacklist all the cores which do exist in socket AM2+
+	 * format. It still isn't perfect, as RB-C2 cores exist in both AM2+
+	 * and AM3 formats, but that's the best we can do.
+	 */
+	return boot_cpu_data.x86_model < 4 ||
+	       (boot_cpu_data.x86_model = 4 && boot_cpu_data.x86_mask <= 2);
+
 }
 
 static int __devinit k10temp_probe(struct pci_dev *pdev,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
