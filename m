From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <10476033213315@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10476033191486@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1108, 2003/03/13 11:38:03-08:00, greg@kroah.com

i2c: get i2c-i801 driver to actually bind to a PCI device.


 drivers/i2c/busses/i2c-i801.c |   74 +++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 36 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 13 16:57:41 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 13 16:57:41 2003
@@ -128,49 +128,21 @@
 static int i801_block_transaction(union i2c_smbus_data *data,
 				  char read_write, int command);
 
+static unsigned short i801_smba;
+static struct pci_dev *I801_dev;
+static int isich4;
 
-
-
-static unsigned short i801_smba = 0;
-static struct pci_dev *I801_dev = NULL;
-static int isich4 = 0;
-
-/* Detect whether a I801 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int i801_setup(void)
+static int i801_setup(struct pci_dev *dev)
 {
 	int error_return = 0;
 	int *num = supported;
 	unsigned char temp;
 
-	/* First check whether we can access PCI at all */
-	if (pci_present() = 0) {
-		printk(KERN_WARNING "i2c-i801.o: Error: No PCI-bus found!\n");
-		error_return = -ENODEV;
-		goto END;
-	}
-
-	/* Look for each chip */
 	/* Note: we keep on searching until we have found 'function 3' */
-	I801_dev = NULL;
-	do {
-		if((I801_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					      *num, I801_dev))) {
-			if(PCI_FUNC(I801_dev->devfn) != 3)
-				continue;
-			break;
-		}
-		num++;
-	} while (*num != 0);
+	if(PCI_FUNC(dev->devfn) != 3)
+		return -ENODEV;
 
-	if (I801_dev = NULL) {
-		printk
-		    (KERN_WARNING "i2c-i801.o: Error: Can't detect I801, function 3!\n");
-		error_return = -ENODEV;
-		goto END;
-	}
+	I801_dev = dev;
 	isich4 = *num = PCI_DEVICE_ID_INTEL_82801DB_SMBUS;
 
 /* Determine the address of the SMBus areas */
@@ -658,13 +630,43 @@
 
 
 static struct pci_device_id i801_ids[] __devinitdata = {
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801AB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801BA_2,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
 	{ 0, }
 };
 
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 
-	if (i801_setup()) {
+	if (i801_setup(dev)) {
 		printk
 		    (KERN_WARNING "i2c-i801.o: I801 not detected, module not inserted.\n");
 		return -ENODEV;
