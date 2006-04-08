From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Apr 2006 18:42:21 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <20060408204221.6de018b8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
In-Reply-To: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> > Hey, good work. lease provide the output of (as root):
> >   lspci -s 00:0a.1 -xxx
> 
> Here it is:
>  lspci -s 00:0a.1 -xxx
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
> 00: de 10 64 02 01 00 b0 00 a2 00 05 0c 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 06 00 00 01 07 00 00 00 00 00 00 de 10 84 cb
> 30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 00 00
> 40: de 10 84 cb 01 00 02 c0 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 01 05 00 00 01 08 00 00 01 09 00 00 00 00 00 00
> 70: 01 00 00 00 00 00 b8 fe 00 00 fe fe 01 20 00 00

OK, that explains it. The driver was looking for the base I/O addresses
at (non-standard registers) 0x50 and 0x54. You have them at (standard
registers) 0x20 and 0x24.

I did some search and it seems that previous nforce4 devices had each
address listed twice (once in the non-standard register and once in the
standard register). Original nforce2 devices had only the non-standard
ones though, which explains why the driver was using them.

So my guess is that Nvidia tried to move to the standard register,
which isn't a bad thing, and kept the old ones around for some times
for compatibility purposes (not a bad idea either.) And your device is
the first one without that compatibility measure, so the driver broke.

I modified the driver so that it'll check the standard register first,
and fallback to the non-standard one when needed (older devices.) Patch
follows:

Add support for the new nForce4 MCP51 (also known as nForce 410 or
430) to the i2c-nforce2 driver. Some code changes were required because
the base I/O address registers have changed in this version. Standard
BARs are now being used, while the original nForce2 chips used
non-standard ones.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-nforce2.c |   18 +++++++++++++-----
 include/linux/pci_ids.h          |    1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

--- linux-2.6.17-rc1.orig/drivers/i2c/busses/i2c-nforce2.c	2006-03-27 18:18:57.000000000 +0200
+++ linux-2.6.17-rc1/drivers/i2c/busses/i2c-nforce2.c	2006-04-08 20:29:13.000000000 +0200
@@ -31,6 +31,7 @@
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
     nForce4 MCP-04		0034
+    nForce4 MCP51		0264
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -259,6 +260,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS) },
 	{ 0 }
 };
 
@@ -267,17 +269,20 @@
 
 
 static int __devinit nforce2_probe_smb (struct pci_dev *dev, int reg,
-	struct nforce2_smbus *smbus, char *name)
+	int alt_reg, struct nforce2_smbus *smbus, char *name)
 {
 	u16 iobase;
 	int error;
 
-	if (pci_read_config_word(dev, reg, &iobase) != PCIBIOS_SUCCESSFUL) {
+	/* Older incarnations of the device used non-standard BARs */
+	if (pci_read_config_word(dev, reg, &iobase) != PCIBIOS_SUCCESSFUL
+	 || (!iobase && pci_read_config_word(dev, alt_reg, &iobase)
+			!= PCIBIOS_SUCCESSFUL)) {
 		dev_err(&smbus->adapter.dev, "Error reading PCI config for %s\n", name);
 		return -1;
 	}
 	smbus->dev  = dev;
-	smbus->base = iobase & 0xfffc;
+	smbus->base = iobase & PCI_BASE_ADDRESS_IO_MASK;
 	smbus->size = 8;
 
 	if (!request_region(smbus->base, smbus->size, nforce2_driver.name)) {
@@ -313,12 +318,15 @@
 	pci_set_drvdata(dev, smbuses);
 
 	/* SMBus adapter 1 */
-	res1 = nforce2_probe_smb (dev, NFORCE_PCI_SMB1, &smbuses[0], "SMB1");
+	res1 = nforce2_probe_smb(dev, PCI_BASE_ADDRESS_4, NFORCE_PCI_SMB1,
+				 &smbuses[0], "SMB1");
 	if (res1 < 0) {
 		dev_err(&dev->dev, "Error probing SMB1.\n");
 		smbuses[0].base = 0;	/* to have a check value */
 	}
-	res2 = nforce2_probe_smb (dev, NFORCE_PCI_SMB2, &smbuses[1], "SMB2");
+	/* SMBus adapter 2 */
+	res2 = nforce2_probe_smb(dev, PCI_BASE_ADDRESS_5, NFORCE_PCI_SMB2,
+				 &smbuses[1], "SMB2");
 	if (res2 < 0) {
 		dev_err(&dev->dev, "Error probing SMB2.\n");
 		smbuses[1].base = 0;	/* to have a check value */
--- linux-2.6.17-rc1.orig/include/linux/pci_ids.h	2006-04-03 20:50:44.000000000 +0200
+++ linux-2.6.17-rc1/include/linux/pci_ids.h	2006-04-08 18:46:22.000000000 +0200
@@ -1124,6 +1124,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS	0x0264
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267


Mark (McKnight), can you please try it too? It should work for you too.

Other users of i2c-nforce2 are invited to test that patch too, just to
make sure I did not accidentally break the older chips.

Thanks,
-- 
Jean Delvare

