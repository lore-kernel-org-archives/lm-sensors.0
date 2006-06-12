From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:51:20 +0000
Subject: [lm-sensors] [PATCH 08/14] i2c-i801: Remove PCI function check
Message-Id: <20060612215120.0578fd85.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-i801-03-remove-pci-function-check.patch

i2c-i801: Remove PCI function check

Remove the PCI function number check when probing devices.
This check is redundant, each function has a separate PCI device
ID, so checking for that ID is sufficient.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-i801.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.17-rc2.orig/drivers/i2c/busses/i2c-i801.c	2006-04-23 20:26:30.000000000 +0200
+++ linux-2.6.17-rc2/drivers/i2c/busses/i2c-i801.c	2006-04-23 20:26:34.000000000 +0200
@@ -107,10 +107,6 @@
 	int error_return = 0;
 	unsigned char temp;
 
-	/* Note: we keep on searching until we have found 'function 3' */
-	if(PCI_FUNC(dev->devfn) != 3)
-		return -ENODEV;
-
 	I801_dev = dev;
 	if ((dev->device = PCI_DEVICE_ID_INTEL_82801DB_3) ||
 	    (dev->device = PCI_DEVICE_ID_INTEL_82801EB_3) ||

-- 
Jean Delvare

