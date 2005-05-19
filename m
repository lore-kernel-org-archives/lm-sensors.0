From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Use PCI_DEVICE in bus drivers
Message-Id: <20041218191234.4fc7fd76.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> Hint, the PCI_DEVICE() macro makes this a lot simpler :)

What about this cleanup patch then? It generalizes the use of
PCI_DEVICE() among i2c/busses drivers (with some pci ids cleanups for
free).

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/include/linux/pci_ids.h.orig	2004-12-17 19:45:43.000000000 +0100
+++ linux-2.6.10-rc3/include/linux/pci_ids.h	2004-12-18 17:38:47.000000000 +0100
@@ -495,6 +495,8 @@
 #	define PCI_DEVICE_ID_AMD_VIPER_7449	PCI_DEVICE_ID_AMD_OPUS_7449
 #define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
 #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
+#define PCI_DEVICE_ID_AMD_8111_SMBUS2	0x746a
+#define PCI_DEVICE_ID_AMD_8111_SMBUS	0x746b
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
 #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
@@ -584,6 +586,7 @@
 #define PCI_DEVICE_ID_SI_6202		0x0002
 #define PCI_DEVICE_ID_SI_503		0x0008
 #define PCI_DEVICE_ID_SI_ACPI		0x0009
+#define PCI_DEVICE_ID_SI_SMBUS		0x0016
 #define PCI_DEVICE_ID_SI_LPC		0x0018
 #define PCI_DEVICE_ID_SI_5597_VGA	0x0200
 #define PCI_DEVICE_ID_SI_6205		0x0205
@@ -1131,6 +1134,7 @@
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
 #define PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO		0x01b1
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS	0x01b4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_NVENET_1		0x01c3
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
@@ -2046,9 +2050,11 @@
 #define PCI_DEVICE_ID_S3_PLATO_PXG	0x8902
 #define PCI_DEVICE_ID_S3_ViRGE_DXGX	0x8a01
 #define PCI_DEVICE_ID_S3_ViRGE_GX2	0x8a10
+#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
 #define PCI_DEVICE_ID_S3_ViRGE_MX	0x8c01
 #define PCI_DEVICE_ID_S3_ViRGE_MXP	0x8c02
 #define PCI_DEVICE_ID_S3_ViRGE_MXPMV	0x8c03
+#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
 #define PCI_DEVICE_ID_S3_SONICVIBES	0xca00
 
 #define PCI_VENDOR_ID_DUNORD		0x5544
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-ali1535.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-ali1535.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-ali1535.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-ali1535.c	2004-12-18 17:55:31.000000000 +0100
@@ -487,12 +487,7 @@
 };
 
 static struct pci_device_id ali1535_ids[] = {
-	{
-		.vendor =	PCI_VENDOR_ID_AL,
-		.device =	PCI_DEVICE_ID_AL_M7101,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
 	{ },
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-ali1563.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-ali1563.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-ali1563.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-ali1563.c	2004-12-18 17:55:31.000000000 +0100
@@ -385,12 +385,7 @@
 }
 
 static struct pci_device_id __devinitdata ali1563_id_table[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_AL,
-		.device		= PCI_DEVICE_ID_AL_M1563,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1563) },
 	{},
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-ali15x3.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-ali15x3.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-ali15x3.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-ali15x3.c	2004-12-18 17:55:31.000000000 +0100
@@ -477,12 +477,7 @@
 };
 
 static struct pci_device_id ali15x3_ids[] = {
-	{
-	.vendor =	PCI_VENDOR_ID_AL,
-	.device =	PCI_DEVICE_ID_AL_M7101,
-	.subvendor =	PCI_ANY_ID,
-	.subdevice =	PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-amd756.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-amd756.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-amd756.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-amd756.c	2004-12-18 17:55:31.000000000 +0100
@@ -316,11 +316,16 @@
 };
 
 static struct pci_device_id amd756_ids[] = {
-	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
-	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
-	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
-	{PCI_VENDOR_ID_AMD, 0x746B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
-	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B),
+	  .driver_data = AMD756 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413),
+	  .driver_data = AMD766 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443),
+	  .driver_data = AMD768 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS),
+	  .driver_data = AMD8111 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS),
+	  .driver_data = NFORCE },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-amd8111.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-amd8111.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-amd8111.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-amd8111.c	2004-12-18 17:55:31.000000000 +0100
@@ -332,7 +332,7 @@
 
 
 static struct pci_device_id amd8111_ids[] = {
-	{ 0x1022, 0x746a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS2) },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-hydra.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-hydra.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-hydra.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-hydra.c	2004-12-18 17:55:31.000000000 +0100
@@ -111,12 +111,7 @@
 };
 
 static struct pci_device_id hydra_ids[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_APPLE,
-		.device		= PCI_DEVICE_ID_APPLE_HYDRA,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_HYDRA) },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-i801.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-i801.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-i801.c	2004-12-06 20:35:22.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-i801.c	2004-12-18 17:55:31.000000000 +0100
@@ -548,54 +548,14 @@
 };
 
 static struct pci_device_id i801_ids[] = {
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801AB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801BA_2,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801CA_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801DB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801EB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_ESB_4,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice = 	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_ICH6_16,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-nforce2.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-nforce2.c	2004-12-17 19:46:33.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-nforce2.c	2004-12-18 17:55:31.000000000 +0100
@@ -291,14 +291,10 @@
 
 
 static struct pci_device_id nforce2_ids[] = {
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ 0 }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-piix4.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-piix4.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-piix4.c	2004-12-18 18:30:22.000000000 +0100
@@ -414,48 +414,18 @@
 };
 
 static struct pci_device_id piix4_ids[] = {
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82371AB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	3
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
-		.device =	PCI_DEVICE_ID_SERVERWORKS_OSB4,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
-		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
-		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB6,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82443MX_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	3,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_EFAR,
-		.device =	PCI_DEVICE_ID_EFAR_SLC90E66_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3),
+	  .driver_data = 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3),
+	  .driver_data = 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
+	  .driver_data = 0 },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-prosavage.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-prosavage.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-prosavage.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-prosavage.c	2004-12-18 17:55:31.000000000 +0100
@@ -96,13 +96,6 @@
 /* 
  * S3/VIA 8365/8375 registers
  */
-#ifndef PCI_DEVICE_ID_S3_SAVAGE4
-#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
-#endif
-#ifndef PCI_DEVICE_ID_S3_PROSAVAGE8
-#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
-#endif
-
 #define VGA_CR_IX	0x3d4
 #define VGA_CR_DATA	0x3d5
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-sis96x.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-sis96x.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-sis96x.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-sis96x.c	2004-12-18 17:55:31.000000000 +0100
@@ -51,9 +51,6 @@
 */
 #define SIS96x_VERSION "1.0.0"
 
-/* SiS96x SMBus PCI device ID */
-#define PCI_DEVICE_ID_SI_SMBUS 0x16
-
 /* base address register in PCI config space */
 #define SIS96x_BAR 0x04
 
@@ -267,14 +264,7 @@
 };
 
 static struct pci_device_id sis96x_ids[] = {
-
-	{
-		.vendor	=	PCI_VENDOR_ID_SI,
-		.device =	PCI_DEVICE_ID_SI_SMBUS,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_SMBUS) },
 	{ 0, }
 };
 
diff -ruN linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-viapro.c linux-2.6.10-rc3/drivers/i2c/busses/i2c-viapro.c
--- linux-2.6.10-rc3/drivers/i2c/busses.orig/i2c-viapro.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-viapro.c	2004-12-18 18:34:28.000000000 +0100
@@ -395,62 +395,22 @@
 }
 
 static struct pci_device_id vt596_ids[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_82C596_3,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_82C596B_3,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_82C686_4,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8233_0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8233A,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8235,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8237,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8231_4,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596_3),
+	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596B_3),
+	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4),
+	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_0),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233A),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4),
+	  .driver_data = SMBBA1 },
 	{ 0, }
 };
 


-- 
Jean Delvare
http://khali.linux-fr.org/
