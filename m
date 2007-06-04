From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Jun 2007 13:49:37 +0000
Subject: [lm-sensors] [PATCH] hwmon/sis5595: Use PCI_REVISION_ID
Message-Id: <20070604154937.77e69eb7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use PCI_REVISION_ID instead of our own define.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/sis5595.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.22-rc3.orig/drivers/hwmon/sis5595.c	2007-06-04 14:28:29.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/sis5595.c	2007-06-04 15:42:13.000000000 +0200
@@ -79,7 +79,6 @@ static struct platform_device *pdev;
 /* Length of ISA address segment */
 #define SIS5595_EXTENT 8
 /* PCI Config Registers */
-#define SIS5595_REVISION_REG 0x08
 #define SIS5595_BASE_REG 0x68
 #define SIS5595_PIN_REG 0x7A
 #define SIS5595_ENABLE_REG 0x7B
@@ -518,7 +517,7 @@ static int __devinit sis5595_probe(struc
 	platform_set_drvdata(pdev, data);
 
 	/* Check revision and pin registers to determine whether 4 or 5 voltages */
-	pci_read_config_byte(s_bridge, SIS5595_REVISION_REG, &(data->revision));
+	pci_read_config_byte(s_bridge, PCI_REVISION_ID, &data->revision);
 	/* 4 voltages, 1 temp */
 	data->maxins = 3;
 	if (data->revision >= REV2MIN) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
