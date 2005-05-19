From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Autoselect i2c algos
Message-Id: <20040118230033.07539111.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > BTW, wouldn't it make sense to apply the same idea to i2c
> > algorithms?
> 
> Yes it would.  Care to make a patch?

Ahahah I love it when you do that ;))

Here you go. I replaced all dependancies on algos with dependancies on
I2C + select algo. There are some cases outside of the i2c subdirectory.

Also note that I slightly altered the condition to display the PCILynx
comment. I added PCI to the dependencies, I think it's more logical that
way. Without it, the user could get the message he/she needs I2C, go to
enable it, come back and still not see the option.

diff -ruN linux-2.6.1-k1/drivers/i2c/busses/Kconfig linux-2.6.1-k2/drivers/i2c/busses/Kconfig
--- linux-2.6.1-k1/drivers/i2c/busses/Kconfig	Sun Jan 18 22:19:29 2004
+++ linux-2.6.1-k2/drivers/i2c/busses/Kconfig	Sun Jan 18 22:35:23 2004
@@ -48,7 +48,8 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF && ISA && BROKEN_ON_SMP
+	depends on I2C && ISA && BROKEN_ON_SMP
+	select I2C_ALGOPCF
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
@@ -58,7 +59,8 @@
 
 config I2C_ELV
 	tristate "ELV adapter"
-	depends on I2C_ALGOBIT
+	depends on I2C
+	select I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters called ELV.  Say Y if you
 	  own such an adapter.
@@ -85,7 +87,8 @@
 
 config I2C_I810
 	tristate "Intel 810/815"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  810/815 family of mainboard I2C interfaces.  Specifically, the 
@@ -123,7 +126,8 @@
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"
-	depends on I2C_ALGOITE
+	depends on I2C
+	select I2C_ALGOITE
 	help
 	  This supports the ITE8172 I2C peripheral found on some MIPS
 	  systems. Say Y if you have one of these. You should also say Y for
@@ -154,7 +158,8 @@
 
 config I2C_PHILIPSPAR
 	tristate "Philips style parallel port adapter"
-	depends on I2C_ALGOBIT && PARPORT
+	depends on I2C && PARPORT
+	select I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters made by Philips.
 
@@ -163,7 +168,8 @@
 
 config I2C_PARPORT
 	tristate "Parallel port adapter"
-	depends on I2C_ALGOBIT && PARPORT
+	depends on I2C && PARPORT
+	select I2C_ALGOBIT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
@@ -183,7 +189,8 @@
 
 config I2C_PARPORT_LIGHT
 	tristate "Parallel port adapter (light)"
-	depends on I2C_ALGOBIT 
+	depends on I2C
+	select I2C_ALGOBIT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
@@ -223,7 +230,8 @@
 
 config I2C_PROSAVAGE
 	tristate "S3/VIA (Pro)Savage"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C bus and DDC bus of the S3VIA embedded Savage4 and ProSavage8
@@ -237,11 +245,13 @@
 
 config I2C_RPXLITE
 	tristate "Embedded Planet RPX Lite/Classic support"
-	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
+	depends on (RPXLITE || RPXCLASSIC) && I2C
+	select I2C_ALGO8XX
 
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the 
 	  S3 Savage 4 I2C interface.
@@ -251,7 +261,8 @@
 
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
-	depends on SCx200_GPIO && I2C_ALGOBIT
+	depends on SCx200_GPIO && I2C
+	select I2C_ALGOBIT
 	help
 	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
@@ -326,7 +337,8 @@
 
 config I2C_VELLEMAN
 	tristate "Velleman K8000 adapter"
-	depends on I2C_ALGOBIT
+	depends on I2C
+	select I2C_ALGOBIT
 	help
 	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
@@ -336,7 +348,8 @@
 
 config I2C_VIA
 	tristate "VIA 82C586B"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 
 	  If you say yes to this option, support will be included for the VIA
@@ -366,7 +379,8 @@
 
 config I2C_VOODOO3
 	tristate "Voodoo 3"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 
 	  If you say yes to this option, support will be included for the
diff -ruN linux-2.6.1-k1/drivers/ieee1394/Kconfig linux-2.6.1-k2/drivers/ieee1394/Kconfig
--- linux-2.6.1-k1/drivers/ieee1394/Kconfig	Fri Jan 16 20:10:16 2004
+++ linux-2.6.1-k2/drivers/ieee1394/Kconfig	Sun Jan 18 22:27:32 2004
@@ -51,12 +51,13 @@
 comment "Device Drivers"
 	depends on IEEE1394
 
-comment "Texas Instruments PCILynx requires I2C bit-banging"
-	depends on IEEE1394 && (I2C=n || I2C_ALGOBIT=n)
+comment "Texas Instruments PCILynx requires I2C"
+	depends on PCI && IEEE1394 && I2C=n
 
 config IEEE1394_PCILYNX
 	tristate "Texas Instruments PCILynx support"
-	depends on PCI && IEEE1394 && I2C_ALGOBIT
+	depends on PCI && IEEE1394 && I2C
+	select I2C_ALGOBIT
 	help
 	  Say Y here if you have an IEEE-1394 controller with the Texas
 	  Instruments PCILynx chip.  Note: this driver is written for revision
diff -ruN linux-2.6.1-k1/drivers/media/video/Kconfig linux-2.6.1-k2/drivers/media/video/Kconfig
--- linux-2.6.1-k1/drivers/media/video/Kconfig	Thu Dec 18 03:59:39 2003
+++ linux-2.6.1-k2/drivers/media/video/Kconfig	Sun Jan 18 22:30:59 2004
@@ -9,7 +9,8 @@
 
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C_ALGOBIT && SOUND
+	depends on VIDEO_DEV && PCI && I2C && SOUND
+	select I2C_ALGOBIT
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in
diff -ruN linux-2.6.1-k1/drivers/video/Kconfig linux-2.6.1-k2/drivers/video/Kconfig
--- linux-2.6.1-k1/drivers/video/Kconfig	Thu Dec 18 03:58:04 2003
+++ linux-2.6.1-k2/drivers/video/Kconfig	Sun Jan 18 22:29:21 2004
@@ -579,7 +579,8 @@
 
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
-	depends on FB_MATROX && I2C_ALGOBIT
+	depends on FB_MATROX && I2C
+	select I2C_ALGOBIT
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
 	  DDC (I2C) bus present on all Matroxes, an I2C bus which


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
