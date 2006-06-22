From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:36 +0000
Subject: [lm-sensors] [PATCH 10/44] [PATCH] I2C: i2c-piix4: Remove the
Message-Id: <11510009231235-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>

This patch removes the fix_hstcfg option from the driver and related
SMBus Interrupt Select register magic because now we know what are
valid values for this register. This patch updates the documentation
and adds new IRQ mode check so we are sure not to miss any new
"unusual" value.

The PCI quirk for users of fix_hstcfg was not developed because the
chipset lacks of subsystem ID registers and DMI is stated "To be
filled". Impact to existing systems is minimal because the problem
showed up on motherboards like 10 years back. On the other hand users
of newer Serverworks and HT1000 systems won't be misleaded by the
message suggesting to try the fix_hstcfg any more.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-piix4 |   22 ++++++++++++++++------
 drivers/i2c/busses/i2c-piix4.c     |   25 +------------------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index 6e6c905..10957be 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -23,8 +23,6 @@ Module Parameters
   Forcibly enable the PIIX4. DANGEROUS!
 * force_addr: int
   Forcibly enable the PIIX4 at the given address. EXTREMELY DANGEROUS!
-* fix_hstcfg: int
-  Fix config register. Needed on some boards (Force CPCI735).
 
 
 Description
@@ -68,7 +66,19 @@ this driver on those mainboards.
 The ServerWorks Southbridges, the Intel 440MX, and the Victory766 are
 identical to the PIIX4 in I2C/SMBus support.
 
-A few OSB4 southbridges are known to be misconfigured by the BIOS. In this
-case, you have you use the fix_hstcfg module parameter. Do not use it
-unless you know you have to, because in some cases it also breaks
-configuration on southbridges that don't need it.
+If you own Force CPCI735 motherboard or other OSB4 based systems you may need
+to change the SMBus Interrupt Select register so the SMBus controller uses
+the SMI mode.
+
+1) Use lspci command and locate the PCI device with the SMBus controller:
+   00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
+   The line may vary for different chipsets. Please consult the driver source
+   for all possible PCI ids (and lspci -n to match them). Lets assume the
+   device is located at 00:0f.0.
+2) Now you just need to change the value in 0xD2 register. Get it first with
+   command: lspci -xxx -s 00:0f.0
+   If the value is 0x3 then you need to change it to 0x1
+   setpci  -s 00:0f.0 d2.b=1
+
+Please note that you don't need to do that in all cases, just when the SMBus is
+not working properly.
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 5f06e81..05af7b0 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -102,13 +102,6 @@ MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-/* If fix_hstcfg is set to anything different from 0, we reset one of the
-   registers to be a valid value. */
-static int fix_hstcfg;
-module_param (fix_hstcfg, int, 0);
-MODULE_PARM_DESC(fix_hstcfg,
-		"Fix config register. Needed on some boards (Force CPCI735).");
-
 static int piix4_transaction(void);
 
 static unsigned short piix4_smba;
@@ -166,22 +159,6 @@ static int __devinit piix4_setup(struct 
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
 
-	/* Some BIOS will set up the chipset incorrectly and leave a register
-	   in an undefined state (causing I2C to act very strangely). */
-	if (temp & 0x02) {
-		if (fix_hstcfg) {
-			dev_info(&PIIX4_dev->dev, "Working around buggy BIOS "
-					"(I2C)\n");
-			temp &= 0xfd;
-			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
-		} else {
-			dev_info(&PIIX4_dev->dev, "Unusual config register "
-					"value\n");
-			dev_info(&PIIX4_dev->dev, "Try using fix_hstcfg=1 if "
-					"you experience problems\n");
-		}
-	}
- 
 	/* If force_addr is set, we program the new address here. Just to make
 	   sure, we disable the PIIX4 first. */
 	if (force_addr) {
@@ -214,7 +191,7 @@ static int __devinit piix4_setup(struct 
 		}
 	}
 
-	if ((temp & 0x0E) = 8)
+	if (((temp & 0x0E) = 8) || ((temp & 0x0E) = 2))
 		dev_dbg(&PIIX4_dev->dev, "Using Interrupt 9 for SMBus.\n");
 	else if ((temp & 0x0E) = 0)
 		dev_dbg(&PIIX4_dev->dev, "Using Interrupt SMI# for SMBus.\n");
-- 
1.4.0


