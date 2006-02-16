From: devik@cdi.cz (Martin Devera)
Date: Thu, 16 Feb 2006 00:04:46 +0000
Subject: [lm-sensors] [PATCH 1/1 RESEND 2] i2c: add BroadCom HT-1000 to
Message-Id: <E1F9Wda-0008Gs-00@devix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Martin Devera <devik at cdi.cz>

Add BroadCom HT-1000 south bridge's PCI ID to i2c-piix driver. Note
that at least on Supermicro H8SSL it uses non-standard SMBHSTCFG = 3
and standard values like 0 or 9 causes hangup.

Signed-off-by: Martin Devera <devik at cdi.cz>
---
Kudos to Rudolf Marek for its helpful comments.

diff -upr a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
--- a/Documentation/i2c/busses/i2c-piix4	Thu Feb 16 00:52:01 2006
+++ b/Documentation/i2c/busses/i2c-piix4	Thu Feb 16 00:55:37 2006
@@ -4,7 +4,7 @@ Supported adapters:
   * Intel 82371AB PIIX4 and PIIX4E
   * Intel 82443MX (440MX)
     Datasheet: Publicly available at the Intel website
-  * ServerWorks OSB4, CSB5 and CSB6 southbridges
+  * ServerWorks OSB4, CSB5, CSB6 and HT-1000 southbridges
     Datasheet: Only available via NDA from ServerWorks
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
@@ -66,7 +66,8 @@ this driver on those mainboards.
 The ServerWorks Southbridges, the Intel 440MX, and the Victory766 are
 identical to the PIIX4 in I2C/SMBus support.
 
-A few OSB4 southbridges are known to be misconfigured by the BIOS. In this
-case, you have you use the fix_hstcfg module parameter. Do not use it
-unless you know you have to, because in some cases it also breaks
-configuration on southbridges that don't need it.
+A few OSB4 (and probably HT-1000 too) southbridges are known to be 
+misconfigured by the BIOS. In this case, you have you use the 
+fix_hstcfg module parameter. Do not use it unless you know you have to, 
+because in some cases it also breaks configuration on southbridges 
+that don't need it.
diff -upr a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Thu Feb 16 00:56:32 2006
+++ b/drivers/i2c/busses/Kconfig	Thu Feb 16 00:58:24 2006
@@ -167,12 +167,14 @@ config I2C_PIIX4
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset are supported:
+	  versions of the chipset are supported (note that Serverworks is part
+	  of BroadCom):
 	    Intel PIIX4
 	    Intel 440MX
 	    Serverworks OSB4
 	    Serverworks CSB5
 	    Serverworks CSB6
+	    Serverworks HT-1000
 	    SMSC Victory66
 
 	  This driver can also be built as a module.  If so, the module
diff -upr a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Tue Feb 14 17:03:23 2006
+++ b/drivers/i2c/busses/i2c-piix4.c	Tue Feb 14 16:57:29 2006
@@ -419,6 +419,8 @@ static struct pci_device_id piix4_ids[] 
 	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6),
 	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000SB),
+	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3),
 	  .driver_data = 3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
diff -upr a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Feb 14 17:03:36 2006
+++ b/include/linux/pci_ids.h	Tue Feb 14 16:55:16 2006
@@ -1343,6 +1343,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
+#define PCI_DEVICE_ID_SERVERWORKS_HT1000SB 0x0205
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE 0x0213

