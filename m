From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Sat, 23 Jul 2005 16:01:36 +0000
Subject: [lm-sensors] [CALL FOR TESTERS] i2c-nforce2 support for MCP04 and
Message-Id: <42E24D97.3080104@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

*Hi list,

is there anybody on the list who has an nForce4 SLI intel edition or a prototype of the
mainboard with the upcoming nVidia CK8-04u/MCP51 chipset? *
*Unfortunately I haven't got a motherboard with such chipsets available, but I would like
to support these chipsets early on.
**Can you please apply the attached patch and check whether i2c-nforce2 finds the 2 SMBusses.
The output of i2cdetect would be appreciated as an indication that the module not only
finds the busses, but also has the minimum functionality.
The patch is against 2.6.13-rc3-mm1 with the cleanup patch included that I have sent to
the list today. It also applies to vanilla 2.6.13-rc3-mm1, but with some offset.

Thanks for your testing!

--- linux-2.6.13-rc3-mm1.orig/drivers/i2c/busses/i2c-nforce2.c	2005-07-23 14:37:35.160679000 +0200*
*+++ linux-2.6.13-rc3-mm1/drivers/i2c/busses/i2c-nforce2.c	2005-07-23 15:38:57.275289043 +0200*
@@ -30,6 +30,8 @@
     nForce3 Pro150 MCP		00D4
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
+    nForce4 I.E. MCP		0034
+    MCP51			0264
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -52,6 +54,13 @@
 MODULE_AUTHOR ("Hans-Frieder Vogt <hfvogt@arcor.de>");
 MODULE_DESCRIPTION("nForce2 SMBus driver");
 
+/* temporarily needed! */
+#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS 0x0034
+#endif
+#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS 0x0264
+#endif
 
 struct nforce2_smbus {
 	struct pci_dev *dev;
@@ -271,6 +280,8 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS) },
 	{ 0 }
 };
 

-- 
--
Hans-Frieder Vogt		e-mail:	hfvogt <at> arcor .dot. de
					hfvogt <at> gmx .dot. net

