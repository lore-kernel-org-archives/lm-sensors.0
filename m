From: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [patch] i2c-piix: Don't treat ServerWorks servers as Laptops
Message-Id: <20040529142325.GA14964@ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I'm sending you this little obvious patch which should enable i2c-piix
to work on IBM servers with ServerWorks chipsets. It still will treat
any IBM/Intel machine as a laptop and refuse to work, but it's better
than before.


ChangeSet@1.1815, 2004-03-19 16:01:20+01:00, vojtech@suse.cz
  i2c: Treat only IBM machines with Intel chipsets as IBM laptops.


 i2c-piix4.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri Mar 19 16:01:34 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri Mar 19 16:01:34 2004
@@ -138,7 +138,7 @@
 
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
-	if(ibm_dmi_probe()) {
+	if(ibm_dmi_probe() && PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL) {
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");
-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
