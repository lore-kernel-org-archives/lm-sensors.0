From: gardner.ben@gmail.com (Ben Gardner)
Date: Fri, 16 Dec 2005 16:10:13 +0000
Subject: [lm-sensors] [PATCH] i2c-busses-scx200_acb : add support for Geode
Message-Id: <808c8e9d0512160810t664d3939t846efce05a50ebf0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Modify scx200_acb.c to support the AMD Geode CS5535 and CS5536 SMBus,
since they are all register-compatible.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   82 ++++++++++++++++++++++++++--------------
 1 files changed, 55 insertions(+), 27 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm1/drivers/i2c/busses/scx200_acb.c
@@ -1,27 +1,26 @@
-/*  linux/drivers/i2c/scx200_acb.c 
-
+/*
     Copyright (c) 2001,2002 Christer Weinigel <wingel at nano-system.com>
 
     National Semiconductor SCx200 ACCESS.bus support
-    
+    Also supports AMD CS5535 and AMD CS5536
+
     Based on i2c-keywest.c which is:
         Copyright (c) 2001 Benjamin Herrenschmidt <benh at kernel.crashing.org>
         Copyright (c) 2000 Philip Edelbrock <phil at stimpy.netroedge.com>
-    
+
     This program is free software; you can redistribute it and/or
     modify it under the terms of the GNU General Public License as
     published by the Free Software Foundation; either version 2 of the
     License, or (at your option) any later version.
-   
+
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     General Public License for more details.
-   
+
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
 */
 
 #include <linux/module.h>
@@ -33,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <asm/io.h>
+#include <asm/msr.h>
 
 #include <linux/scx200.h>
 
@@ -100,7 +100,7 @@ struct scx200_acb_iface
 #define ACBSDA		(iface->base + 0)
 #define ACBST		(iface->base + 1)
 #define    ACBST_SDAST		0x40 /* SDA Status */
-#define    ACBST_BER		0x20 
+#define    ACBST_BER		0x20
 #define    ACBST_NEGACK		0x10 /* Negative Acknowledge */
 #define    ACBST_STASTR		0x08 /* Stall After Start */
 #define    ACBST_MASTER		0x02
@@ -122,7 +122,7 @@ static void scx200_acb_machine(struct sc
 {
 	const char *errmsg;
 
-	DBG("state %s, status = 0x%02x\n", 
+	DBG("state %s, status = 0x%02x\n",
 	    scx200_acb_state_name[iface->state], status);
 
 	if (status & ACBST_BER) {
@@ -163,7 +163,7 @@ static void scx200_acb_machine(struct sc
 		
 	case state_quick:
 		if (iface->address_byte & 1) {
-			if (iface->len = 1) 
+			if (iface->len = 1)
 				outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
 			else
 				outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
@@ -212,7 +212,7 @@ static void scx200_acb_machine(struct sc
 	return;
 
  negack:
-	DBG("negative acknowledge in state %s\n", 
+	DBG("negative acknowledge in state %s\n",
 	    scx200_acb_state_name[iface->state]);
 
 	iface->state = state_idle;
@@ -231,7 +231,7 @@ static void scx200_acb_machine(struct sc
 	iface->needs_reset = 1;
 }
 
-static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
+static void scx200_acb_timeout(struct scx200_acb_iface *iface)
 {
 	dev_err(&iface->adapter.dev, "timeout in state %s\n",
 		scx200_acb_state_name[iface->state]);
@@ -264,7 +264,7 @@ static void scx200_acb_poll(struct scx20
 static void scx200_acb_reset(struct scx200_acb_iface *iface)
 {
 	/* Disable the ACCESS.bus device and Configure the SCL
-           frequency: 16 clock cycles */
+	   frequency: 16 clock cycles */
 	outb(0x70, ACBCTL2);
 	/* Polling mode */
 	outb(0, ACBCTL1);
@@ -284,7 +284,7 @@ static void scx200_acb_reset(struct scx2
 
 static s32 scx200_acb_smbus_xfer(struct i2c_adapter *adapter,
 				u16 address, unsigned short flags,	
-				char rw, u8 command, int size, 
+				char rw, u8 command, int size,
 				union i2c_smbus_data *data)
 {
 	struct scx200_acb_iface *iface = i2c_get_adapdata(adapter);
@@ -435,7 +435,7 @@ static int scx200_acb_probe(struct scx20
 	return 0;
 }
 
-static int  __init scx200_acb_create(int base, int index)
+static int  __init scx200_acb_create(const char *text, int base, int index)
 {
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
@@ -451,7 +451,7 @@ static int  __init scx200_acb_create(int
 
 	adapter = &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
-	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
+	snprintf(adapter->name, I2C_NAME_SIZE, "%s ACB%d", text, index);
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_HW_SMBUS_SCX200;
 	adapter->algo = &scx200_acb_algorithm;
@@ -459,7 +459,9 @@ static int  __init scx200_acb_create(int
 
 	init_MUTEX(&iface->sem);
 
-	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
+		 text, adapter->name);
+
 	if (request_region(base, 8, description) = 0) {
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
@@ -504,24 +506,50 @@ static struct pci_device_id scx200[] = {
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
+	return scx200_acb_create("cs5535", smb_base, 0);
+}
+
 static int __init scx200_acb_init(void)
 {
 	int i;
-	int rc;
+	int rc = -ENODEV;
 
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
 


