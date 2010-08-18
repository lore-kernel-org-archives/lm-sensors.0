From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Wed, 18 Aug 2010 12:13:00 +0000
Subject: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100818121259.GA4611@loge.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Andreas Herrmann <andreas.herrmann3@amd.com>

Commit 8bf0223ed515be24de0c671eedaff49e78bebc9c (hwmon, k8temp: Fix
temperature reporting for ASB1 processor revisions) fixed temperature
reporting for ASB1 CPUs. But those CPU models (model 0x6b, 0x6f, 0x7f)
were packaged both as AM2 (desktop) and ASB1 (mobile). Thus the commit
leads to wrong temperature reporting for AM2 CPU parts.

The solution is to determine the package type for models 0x6b, 0x6f,
0x7f.

This is done using BrandId from CPUID Fn8000_0001_EBX[15:0]. See
"Constructing the processor Name String" in "Revision Guide for AMD
NPT Family 0Fh Processors" (Rev. 3.46).

Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: stable@kernel.org [.32.x .34.x, .35.x]
Reported-by: Vladislav Guberinic <neosisani@gmail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   44 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 34 insertions(+), 10 deletions(-)

Here is the updated patch considering single core and dual core ASB1
CPUs. Tested with model 0x6b ASB1 CPU. I don't have instant access to
model 0x6f and 0x7f CPU models.


Andreas


diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index b9bb3e0..bbfc0ad 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -143,6 +143,34 @@ static const struct pci_device_id k8temp_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, k8temp_ids);
 
+static int is_rev_g_desktop(u8 model)
+{
+	u32 brandidx;
+
+	if (model < 0x69)
+		return 0;
+
+	if (model = 0xc1 || model = 0x6c || model = 0x7c)
+		return 0;
+
+	/*
+	 * differentiate between AM2 and ASB1
+	 */
+
+	brandidx = cpuid_ebx(0x80000001);
+	brandidx = (brandidx >> 9) & 0x1f;
+	if (model = 0x6b &&
+	    (brandidx = 0xb || brandidx = 0xc))
+		return 0;
+
+	if ((model = 0x6f || model = 0x7f) &&
+	    (brandidx = 7 || brandidx = 9 ||
+	     brandidx = 0xc))
+		return 0;
+
+	return 1;
+}
+
 static int __devinit k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
@@ -179,17 +207,13 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 				 "wrong - check erratum #141\n");
 		}
 
-		if ((model >= 0x69) &&
-		    !(model = 0xc1 || model = 0x6c || model = 0x7c ||
-		      model = 0x6b || model = 0x6f || model = 0x7f)) {
-			/*
-			 * RevG desktop CPUs (i.e. no socket S1G1 or
-			 * ASB1 parts) need additional offset,
-			 * otherwise reported temperature is below
-			 * ambient temperature
-			 */
+		/*
+		 * RevG desktop CPUs (i.e. no socket S1G1 or ASB1
+		 * parts) need additional offset, otherwise reported
+		 * temperature is below ambient temperature
+		 */
+		if (is_rev_g_desktop(model))
 			data->temp_offset = 21000;
-		}
 
 		break;
 	}
-- 
1.7.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
