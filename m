From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 13 Apr 2006 10:49:15 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <20060413124915.d627a9d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
In-Reply-To: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark and Mark,

> > Mark (McKnight), can you please try it too? It should work for you too.
> 
> I tried it on Ubuntu 2.6.15 and it works as expected. I'm now
> displaying cpu temp and fan speed in the gnome panel.

OK, great! Thanks for testing.

Since then, I've come up with a slightly different patch which seems to
be technically more correct. Testers would be welcome. As before,
testers for older devices are just as welcome as testers for the new
one, so as to make sure I didn't break anything.


Add support for the new nForce4 MCP51 (also known as nForce 410 or
430) to the i2c-nforce2 driver. Some code changes were required because
the base I/O address registers have changed in this version. Standard
BARs are now being used, while the original nForce2 chips used
non-standard ones.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/i2c-nforce2 |    1 +
 drivers/i2c/busses/i2c-nforce2.c     |   36 ++++++++++++++++++++++++----------
 include/linux/pci_ids.h              |    1 +
 3 files changed, 27 insertions(+), 11 deletions(-)

--- linux-2.6.17-rc1.orig/drivers/i2c/busses/i2c-nforce2.c	2006-04-13 12:32:15.000000000 +0200
+++ linux-2.6.17-rc1/drivers/i2c/busses/i2c-nforce2.c	2006-04-13 12:46:44.000000000 +0200
@@ -31,6 +31,7 @@
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
     nForce4 MCP-04		0034
+    nForce4 MCP51		0264
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -64,6 +65,7 @@
 
 /*
  * nVidia nForce2 SMBus control register definitions
+ * (Newer incarnations use standard BAR 4 and 5 instead)
  */
 #define NFORCE_PCI_SMB1	0x50
 #define NFORCE_PCI_SMB2	0x54
@@ -259,6 +261,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS) },
 	{ 0 }
 };
 
@@ -266,19 +269,29 @@
 MODULE_DEVICE_TABLE (pci, nforce2_ids);
 
 
-static int __devinit nforce2_probe_smb (struct pci_dev *dev, int reg,
-	struct nforce2_smbus *smbus, char *name)
+static int __devinit nforce2_probe_smb (struct pci_dev *dev, int bar,
+	int alt_reg, struct nforce2_smbus *smbus, const char *name)
 {
-	u16 iobase;
 	int error;
 
-	if (pci_read_config_word(dev, reg, &iobase) != PCIBIOS_SUCCESSFUL) {
-		dev_err(&smbus->adapter.dev, "Error reading PCI config for %s\n", name);
-		return -1;
+	smbus->base = pci_resource_start(dev, bar);
+	if (smbus->base) {
+		smbus->size = pci_resource_len(dev, bar);
+	} else {
+		/* Older incarnations of the device used non-standard BARs */
+		u16 iobase;
+
+		if (pci_read_config_word(dev, alt_reg, &iobase)
+		    != PCIBIOS_SUCCESSFUL) {
+			dev_err(&dev->dev, "Error reading PCI config for %s\n",
+				name);
+			return -1;
+		}
+
+		smbus->base = iobase & PCI_BASE_ADDRESS_IO_MASK;
+		smbus->size = 8;
 	}
-	smbus->dev  = dev;
-	smbus->base = iobase & 0xfffc;
-	smbus->size = 8;
+	smbus->dev = dev;
 
 	if (!request_region(smbus->base, smbus->size, nforce2_driver.name)) {
 		dev_err(&smbus->adapter.dev, "Error requesting region %02x .. %02X for %s\n",
@@ -313,12 +326,13 @@
 	pci_set_drvdata(dev, smbuses);
 
 	/* SMBus adapter 1 */
-	res1 = nforce2_probe_smb (dev, NFORCE_PCI_SMB1, &smbuses[0], "SMB1");
+	res1 = nforce2_probe_smb(dev, 4, NFORCE_PCI_SMB1, &smbuses[0], "SMB1");
 	if (res1 < 0) {
 		dev_err(&dev->dev, "Error probing SMB1.\n");
 		smbuses[0].base = 0;	/* to have a check value */
 	}
-	res2 = nforce2_probe_smb (dev, NFORCE_PCI_SMB2, &smbuses[1], "SMB2");
+	/* SMBus adapter 2 */
+	res2 = nforce2_probe_smb(dev, 5, NFORCE_PCI_SMB2, &smbuses[1], "SMB2");
 	if (res2 < 0) {
 		dev_err(&dev->dev, "Error probing SMB2.\n");
 		smbuses[1].base = 0;	/* to have a check value */
--- linux-2.6.17-rc1.orig/include/linux/pci_ids.h	2006-04-13 12:32:15.000000000 +0200
+++ linux-2.6.17-rc1/include/linux/pci_ids.h	2006-04-13 12:39:47.000000000 +0200
@@ -1124,6 +1124,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS	0x0264
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
--- linux-2.6.17-rc1.orig/Documentation/i2c/busses/i2c-nforce2	2006-04-13 12:32:15.000000000 +0200
+++ linux-2.6.17-rc1/Documentation/i2c/busses/i2c-nforce2	2006-04-13 12:39:47.000000000 +0200
@@ -7,6 +7,7 @@
   * nForce3 250Gb MCP          10de:00E4 
   * nForce4 MCP                10de:0052
   * nForce4 MCP-04             10de:0034
+  * nForce4 MCP51              10de:0264
 
 Datasheet: not publically available, but seems to be similar to the
            AMD-8111 SMBus 2.0 adapter.

> I'd also like to thank lm-sensor developers past and present for
> sensors-detect. I found it a very useful utility.

Thanks :')

-- 
Jean Delvare

