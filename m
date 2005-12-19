From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 18:55:19 +0000
Subject: [lm-sensors] [PATCH 5/7] i2c: scx200_acb - add cs5535 support
Message-Id: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the CS5535 and CS5536 Geode companion devices.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   57 ++++++++++++++++++++++++++++++----------
 1 files changed, 43 insertions(+), 14 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm1/drivers/i2c/busses/scx200_acb.c
@@ -2,6 +2,7 @@
     Copyright (c) 2001,2002 Christer Weinigel <wingel at nano-system.com>
 
     National Semiconductor SCx200 ACCESS.bus support
+    Also supports the AMD CS5535 and AMD CS5536
 
     Based on i2c-keywest.c which is:
         Copyright (c) 2001 Benjamin Herrenschmidt <benh at kernel.crashing.org>
@@ -31,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <asm/io.h>
+#include <asm/msr.h>
 
 #include <linux/scx200.h>
 
@@ -423,7 +425,7 @@ static int scx200_acb_probe(struct scx20
 	return 0;
 }
 
-static int  __init scx200_acb_create(int base, int index)
+static int  __init scx200_acb_create(const char *text, int base, int index)
 {
 	struct scx200_acb_iface	*iface;
 	struct i2c_adapter	*adapter;
@@ -438,7 +440,7 @@ static int  __init scx200_acb_create(int
 
 	adapter = &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
-	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
+	snprintf(adapter->name, I2C_NAME_SIZE, "%s ACB%d", text, index);
 	adapter->owner = THIS_MODULE;
 	adapter->id    = I2C_HW_SMBUS_SCX200;
 	adapter->algo  = &scx200_acb_algorithm;
@@ -446,8 +448,9 @@ static int  __init scx200_acb_create(int
 
 	init_MUTEX(&iface->sem);
 
-	snprintf(description, sizeof(description),
-		 "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
+		 text, adapter->name);
+
 	if (request_region(base, 8, description) = 0) {
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
@@ -490,24 +493,50 @@ static struct pci_device_id scx200[] = {
 	{ },
 };
 
+static struct pci_device_id divil_pci[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) },
+	{ } /* NULL entry */
+};
+
+#define MSR_LBAR_SMB		0x5140000B
+
+static int scx200_add_cs553x(void)
+{
+	u32	low, hi;
+	u32	smb_base;
+
+	/* Grab & reserve the SMB I/O range */
+	rdmsr(MSR_LBAR_SMB, low, hi);
+
+	/* Check the IO mask and whether SMB is enabled */
+	if (hi != 0x0000F001) {
+		printk(KERN_WARNING NAME ": SMBus not enabled\n");
+		return -ENODEV;
+	}
+
+	/* SMBus IO size is 8 bytes */
+	smb_base = low & 0x0000FFF8;
+
+	return scx200_acb_create("CS5535", smb_base, 0);
+}
+
 static int __init scx200_acb_init(void)
 {
 	int	i;
-	int	rc;
+	int	rc = -ENODEV;
 
 	pr_debug(NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
 
 	/* Verify that this really is a SCx200 processor */
-	if (pci_dev_present(scx200) = 0)
-		return -ENODEV;
+	if (pci_dev_present(scx200)) {
+		for (i = 0; i < MAX_DEVICES; ++i) {
+			if (base[i] > 0)
+				rc = scx200_acb_create("SCx200", base[i], i);
+		}
+	} else if (pci_dev_present(divil_pci))
+		rc = scx200_add_cs553x();
 
-	rc = -ENXIO;
-	for (i = 0; i < MAX_DEVICES; ++i) {
-		if (base[i] > 0)
-			rc = scx200_acb_create(base[i], i);
-	}
-	if (scx200_acb_list)
-		return 0;
 	return rc;
 }
 
