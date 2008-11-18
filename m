From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 08:43:44 +0000
Subject: [lm-sensors] [PATCH 1/2] k8temp: adapt cpuid handling,
Message-Id: <20081118084344.GD12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   54 ++++++++++++++++++++++++++---------------------
 1 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 4885272..a949a86 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -31,6 +31,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <asm/processor.h>
 
 #define FAM_F_TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
 #define FAM_10_TEMP_FROM_REG(val)	(((val) >> 21) * 125)
@@ -56,7 +57,8 @@ struct k8temp_data {
 	int temp[2][2];		/* core, place */
 	int tcontrol_max;
 	u8 fam;
-	u32 cpuid;
+	u8 model;
+	u8 stepping;
 };
 
 static void k8temp_update_device_fam_10(struct device *dev)
@@ -253,12 +255,14 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int err = 0;
-
 	struct k8temp_data *data;
-	u32 cpuid = cpuid_eax(1);
-
-	/* this feature should be available since SH-C0 core */
-	if ((cpuid = 0xf40) || (cpuid = 0xf50) || (cpuid = 0xf51)) {
+	u32 cpuid;
+	
+	/* this feature is available since family 0xf Rev C0 */
+	if ((boot_cpu_data.x86 = 0xf) &&
+	    (boot_cpu_data.x86_model >= 0x48) &&
+	    ((boot_cpu_data.x86_model != 0x50) ||
+	     (boot_cpu_data.x86_model != 0x51))) {
 		err = -ENODEV;
 		goto exit;
 	}
@@ -268,38 +272,40 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 		goto exit;
 	}
 
-	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
-	pci_read_config_dword(pdev, REG_CPUID, &data->cpuid);
+	/* PCI based cpuid, works at least for revF and above */
+	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
 
-	data->fam = (data->cpuid & 0x00000f00) >> 8;
-	data->fam += (data->cpuid & 0x00f00000) >> 20;
+	data->stepping = cpuid & 0xf;
+	data->model = (cpuid >> 4) & 0xf;
+	data->fam = (cpuid >> 8) & 0xf;
+	data->model += (cpuid >> 12) & 0xf0;	/* extended model << 4 */
+	data->fam += (cpuid >> 20) & 0xff;	/* extended family */
 
 	switch (data->fam) {
+		case 0x0: /* mark revE fam 0fh as fam 0fh */
+			data->fam = 0xf;
+			/* fall through */
 		case 0xf:
-			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
-						" - check errata #141\n");
+			if (data->model >= 0x40)
+				/* AMD NPT family 0xf, revF and above */
+				dev_warn(&pdev->dev, "Temperature readouts "
+					"might be wrong. Check erratum #141\n");
 			if ((err = setup_fam_f(pdev, data)))
 				goto exit_free;
 			break;
 		case 0x10:
-			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
-						" - check errata #319\n");
-			if ((err = setup_fam_10(pdev, data)))
-				goto exit_free;
-			break;
+			if ((data->model <= 4) && (data->stepping < 2))
+				/* AMD family 0x10 before Rev C2 */
+				dev_warn(&pdev->dev, "Temperature readouts "
+					"might be wrong. Check erratum #319\n");
+			/* fall through */
 		case 0x11:
 			if ((err = setup_fam_10(pdev, data)))
 				goto exit_free;
 			break;
-		case 0x0:
-			/* mark revE fam 0fh as fam 0fh */
-			data->fam = 0xf;
-			if ((err = setup_fam_f(pdev, data)))
-				goto exit_free;
-			break;
 		default:
 			err = -ENODEV;
-			dev_err(&pdev->dev, "Unknown family with known PCI ID\n");
+			dev_err(&pdev->dev, "unknown CPU family\n");
 			goto exit_free;
 	}
 
-- 
1.6.0.3




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
