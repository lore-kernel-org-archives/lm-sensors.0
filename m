From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Mon, 16 Aug 2010 09:21:38 +0000
Subject: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100816092138.GB21437@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Andreas Herrmann <andreas.herrmann3@amd.com>

The family check in k8temp is not required because the driver is
already bound to a northbridge device only used with K8 CPUs.

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   49 +++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index bcb1a35..2210b21 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -182,36 +182,31 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 	model = boot_cpu_data.x86_model;
 	stepping = boot_cpu_data.x86_mask;
 
-	switch (boot_cpu_data.x86) {
-	case 0xf:
-		/* feature available since SH-C0, exclude older revisions */
-		if (((model = 4) && (stepping = 0)) ||
-		    ((model = 5) && (stepping <= 1))) {
-			err = -ENODEV;
-			goto exit_free;
-		}
+	/* feature available since SH-C0, exclude older revisions */
+	if (((model = 4) && (stepping = 0)) ||
+	    ((model = 5) && (stepping <= 1))) {
+		err = -ENODEV;
+		goto exit_free;
+	}
+
+	/*
+	 * AMD NPT family 0fh, i.e. RevF and RevG:
+	 * meaning of SEL_CORE bit is inverted
+	 */
+	if (model >= 0x40) {
+		data->swap_core_select = 1;
+		dev_warn(&pdev->dev, "Temperature readouts might be "
+			 "wrong - check erratum #141\n");
+	}
 
+	if (is_rev_g_desktop(model))
 		/*
-		 * AMD NPT family 0fh, i.e. RevF and RevG:
-		 * meaning of SEL_CORE bit is inverted
+		 * RevG desktop CPUs (i.e. no socket S1G1 or
+		 * ASB1 parts) need additional offset,
+		 * otherwise reported temperature is below
+		 * ambient temperature
 		 */
-		if (model >= 0x40) {
-			data->swap_core_select = 1;
-			dev_warn(&pdev->dev, "Temperature readouts might be "
-				 "wrong - check erratum #141\n");
-		}
-
-		if (is_rev_g_desktop(model))
-			/*
-			 * RevG desktop CPUs (i.e. no socket S1G1 or
-			 * ASB1 parts) need additional offset,
-			 * otherwise reported temperature is below
-			 * ambient temperature
-			 */
-			data->temp_offset = 21000;
-
-		break;
-	}
+		data->temp_offset = 21000;
 
 	pci_read_config_byte(pdev, REG_TEMP, &scfg);
 	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
-- 
1.7.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
