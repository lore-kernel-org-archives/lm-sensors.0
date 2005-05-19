From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Patch for AMD8111 support in 2.8.x
Message-Id: <3FC98E59.2050302@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a long promised patch to add the support for the AMD8111 back 
into the i2c-amd756 driver.  This is a patch against CVS.

The AMD8111 chip has two lm_sensors bus interfaces.  A "classic" i2c 
interface that matches the amd756 register model to which most 
motherboards connect the interesting peripherals and a new SMBus 2.x? 
compliant interface supported by the i2c-amd8111 driver which rarely has 
any devices on it.

This compiles and loads on my system at home which is a dual Athlon 
system with a AMD768, but I don't have an Opteron desktop yet to test it 
on...

:v)
-------------- next part --------------
Index: lm_sensors2/kernel/busses/i2c-amd756.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-amd756.c,v
retrieving revision 1.27
diff -u -r1.27 i2c-amd756.c
--- lm_sensors2/kernel/busses/i2c-amd756.c	3 Aug 2003 05:11:58 -0000	1.27
+++ lm_sensors2/kernel/busses/i2c-amd756.c	30 Nov 2003 06:39:09 -0000
@@ -28,10 +28,12 @@
     2002-04-08: Added nForce support. (Csaba Halasz)
     2002-10-03: Fixed nForce PnP I/O port. (Michael Steil)
     2002-12-28: Rewritten into something that resembles a Linux driver (hch)
+    2003-11-29: Added back AMD8111 removed by backport of the previous
+                rewrite. (Philip Pokorny)
 */
 
 /*
-   Supports AMD756, AMD766, AMD768 and nVidia nForce
+   Supports AMD756, AMD766, AMD768, AMD8111 and nVidia nForce
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
@@ -312,12 +314,13 @@
 	.algo		= &smbus_algorithm,
 };
 
-enum chiptype { AMD756, AMD766, AMD768, NFORCE };
+enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111 };
 
 static struct pci_device_id amd756_ids[] __devinitdata = {
 	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
 	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
 	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
+	{PCI_VENDOR_ID_AMD, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
 	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ 0, }
 };
@@ -325,7 +328,8 @@
 static int __devinit amd756_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
-	int nforce = (id->driver_data = NFORCE), error;
+	int nforce = (id->driver_data = NFORCE);
+	int error;
 	u8 temp;
 	
 	if (amd756_ioport) {
