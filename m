From: sensors-reply@reaktor.hadiko.de (Christoph Heine)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-viapro and via686a don't mix with linux-2.6.0-test1
Message-Id: <20030715184228.GA15889@h111.hadiko.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030715142051.GA14443@h111.hadiko.de>
In-Reply-To: <20030715142051.GA14443@h111.hadiko.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, Jul 15, 2003 at 06:14:34PM +0200, Jean Delvare wrote:
> I think I remember seeing something about that on the mailing list
> recently:
> 
> Modified Files:
> 	i2c-voodoo3.c i2c-via.c i2c-viapro.c i2c-i810.c i2c-savage4.c 
> Log Message:
> (mds) don't use pci_module_init() for video i2c drivers so we don't
>       conflict with video drivers
> 
> It was for a different conflict (it seems). However, the changes made to
> i2c-viapro.c may also prevent the conflict you observed. This is a very
> recent change (occured on July 2nd.). I attached the patch, could you
> please check wether it is already applied to the 2.6.0 kernel tree? 

It is not applied to the 2.6.0 tree.

> If not, could you try to apply it and tell us if it solves your
> problem?

The patch did not apply to i2c-viapro.c in 2.6 at all and pci_for_each_dev()
does not exist in the 2.6 kernel. 

I've converted it to "the 2.6 way" of doing this and it works for me. :-) 
The new patch is in the Attachment. But somehow I feel this is not the
right solution. 

> I admit I'm a bit confused, because i2c-viapro is a bus driver while
> via686a is a chip driver. Thus I wonder how they can conflict...

My guess is:

The sources look like that the via686a sensor is accessed directly via
the isa bus and the module needs the pci configuration registers of the
VT82C686A to get the base adress. And i2c-viapro needs just the the same
device for the i2c bus of the VT82C686A.

Maybe some parts of via686a should be merged into i2c-viapro. (but I
don't know much about the hardware and i2c in general to tell if that
makes any sense.)

Bye,
Christoph

-------------- next part --------------
--- i2c-viapro.c.orig	2003-07-15 19:37:31.000000000 +0200
+++ i2c-viapro.c	2003-07-15 19:39:52.000000000 +0200
@@ -454,22 +454,24 @@
 	{ 0, }
 };
 
-static struct pci_driver vt596_driver = {
-	.name		= "vt596 smbus",
-	.id_table	= vt596_ids,
-	.probe		= vt596_probe,
-	.remove		= __devexit_p(vt596_remove),
-};
-
 static int __init i2c_vt596_init(void)
 {
-	return pci_module_init(&vt596_driver);
+	struct pci_dev *dev = NULL;
+	const struct pci_device_id *id;
+	
+	while ((dev = pci_find_device(PCI_VENDOR_ID_VIA, PCI_ANY_ID, dev)) != NULL) {
+	id = pci_match_device(vt596_ids, dev);
+       		if(id)
+        		if(vt596_probe(dev, id) >= 0)
+            			return 0;
+	}
+	return -ENODEV;
 }
 
 
 static void __exit i2c_vt596_exit(void)
 {
-	pci_unregister_driver(&vt596_driver);
+	 vt596_remove(NULL);
 }
 
 MODULE_AUTHOR(
