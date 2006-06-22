From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:02 +0000
Subject: [lm-sensors] [PATCH 36/44] [PATCH] i2c-i801: Remove force_addr
Message-Id: <11510010362240-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-i801: Remove force_addr parameter

Remove the force_addr module parameter. It doesn't appear to ever
have been needed, and PCI resources shouldn't be arbitrarily
changed anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-i801 |    3 +--
 drivers/i2c/busses/i2c-i801.c     |   35 +++++++----------------------------
 2 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index fd4b271..e46c234 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -21,8 +21,7 @@ Authors: 
 Module Parameters
 -----------------
 
-* force_addr: int
-  Forcibly enable the ICH at the given address. EXTREMELY DANGEROUS!
+None.
 
 
 Description
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 4396dc9..0d5374c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -92,15 +92,6 @@ #define I801_I2C_BLOCK_LAST	0x38	/* unim
 #define I801_START		0x40
 #define I801_PEC_EN		0x80	/* ICH4 only */
 
-/* insmod parameters */
-
-/* If force_addr is set to anything different from 0, we forcibly enable
-   the I801 at the given address. VERY DANGEROUS! */
-static u16 force_addr;
-module_param(force_addr, ushort, 0);
-MODULE_PARM_DESC(force_addr,
-		 "Forcibly enable the I801 at the given address. "
-		 "EXTREMELY DANGEROUS!");
 
 static int i801_transaction(void);
 static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
@@ -129,16 +120,12 @@ static int i801_setup(struct pci_dev *de
 		isich4 = 0;
 
 	/* Determine the address of the SMBus areas */
-	if (force_addr) {
-		i801_smba = force_addr & 0xfff0;
-	} else {
-		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
-		i801_smba &= 0xfff0;
-		if(i801_smba = 0) {
-			dev_err(&dev->dev, "SMB base address uninitialized "
-				"- upgrade BIOS or use force_addr=0xaddr\n");
-			return -ENODEV;
-		}
+	pci_read_config_word(I801_dev, SMBBA, &i801_smba);
+	i801_smba &= 0xfff0;
+	if (!i801_smba) {
+		dev_err(&dev->dev, "SMBus base address uninitialized, "
+			"upgrade BIOS\n");
+		return -ENODEV;
 	}
 
 	if (!request_region(i801_smba, (isich4 ? 16 : 8), i801_driver.name)) {
@@ -152,15 +139,7 @@ static int i801_setup(struct pci_dev *de
 	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
 	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
 
-	/* If force_addr is set, we program the new address here. Just to make
-	   sure, we disable the device first. */
-	if (force_addr) {
-		pci_write_config_byte(I801_dev, SMBHSTCFG, temp & 0xfe);
-		pci_write_config_word(I801_dev, SMBBA, i801_smba);
-		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 0x01);
-		dev_warn(&dev->dev, "WARNING: I801 SMBus interface set to "
-			"new address %04x!\n", i801_smba);
-	} else if ((temp & 1) = 0) {
+	if (!(temp & 1)) {
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
 		dev_warn(&dev->dev, "enabling SMBus device\n");
 	}
-- 
1.4.0


