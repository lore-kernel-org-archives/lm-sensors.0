From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: i2c-sis630 driver (fixed)
Message-Id: <20030730223519.GA2177@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307302234.43914.amalysh@web.de>
In-Reply-To: <200307302234.43914.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex:

* Alexander Malysh <amalysh@web.de> [2003-07-30 22:34:39 +0200]:
> Hi again,
> 
> the bug is fixed now... I do not know how to close the tikets. 

It still has a bug: the pci system will associate the 630 or 730
device with your driver, such that no other driver (if there was
one) which might claim that device will work.  The thread where
this was first mentioned is here:

http://archives.andrew.net.au/lm-sensors/msg03193.html

So how about this patch? (against CVS, compiles, untested)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

Index: i2c-sis630.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-sis630.c,v
retrieving revision 1.20
diff -u -r1.20 i2c-sis630.c
--- i2c-sis630.c	30 Jul 2003 20:40:27 -0000	1.20
+++ i2c-sis630.c	30 Jul 2003 22:39:44 -0000
@@ -321,19 +321,21 @@
 		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_PROC_CALL;
 }
 
-int sis630_setup(struct pci_dev *dummy) {
+int sis630_setup(struct pci_dev *sis630_dev) {
 	unsigned char b;
-	struct pci_dev *sis630_dev = NULL;
 
-        /*
-	   We need ISA brigde and not pci device passed in.
-        */
-	if (!(sis630_dev = pci_find_device(PCI_VENDOR_ID_SI,
-                                            PCI_DEVICE_ID_SI_503,
-                                            sis630_dev))) {
-            printk(KERN_ERR "i2c-sis630.o: Error: Can't detect 85C503/5513 ISA bridge!\n");
-            return -ENODEV;
-        }
+	/*
+	   Make sure there is a compatible chipset
+	*/
+	if (!(	pci_find_device(PCI_VENDOR_ID_SI,
+			PCI_DEVICE_ID_SI_630, NULL) ||
+		pci_find_device(PCI_VENDOR_ID_SI,
+			PCI_DEVICE_ID_SI_730, NULL) ))
+	{
+		printk(KERN_ERR "i2c-sis630.o: Error - can't find compatible "
+				"chipset!\n");
+		return -ENODEV;
+	}
 
 	/*
 	   Enable ACPI first , so we can accsess reg 74-75
@@ -392,13 +394,7 @@
 static struct pci_device_id sis630_ids[] __devinitdata = {
 	{
 		.vendor =	PCI_VENDOR_ID_SI,
-		.device =	PCI_DEVICE_ID_SI_630,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SI,
-		.device =	PCI_DEVICE_ID_SI_730,
+		.device =	PCI_DEVICE_ID_SI_503,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
 	},
