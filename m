From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-viapro and via686a don't mix with linux-2.6.0-test1
Message-Id: <20030715181434.380d4ff9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030715142051.GA14443@h111.hadiko.de>
In-Reply-To: <20030715142051.GA14443@h111.hadiko.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> With kernel 2.6.0-test1 (likely with lm-sensors 2.8.0 too), it is
> possible to load both via686a and i2c-viapro, but only one of them
> will work, depending on which was loaded first. 
> 
> The reason for this is, that both drivers feel responsible for
> the VIA_82C686_4 and once the probe was successful, it is registered
> only to the driver which was loaded first. (So, you can load another
> driver for the device but the probe function will never get called). 
> 
> Sorry for not providing a patch, I have on clue how to fix this
> properly.

I tested this case on my own system and I could load both modules, and
both seemed to work (lm_sensors-2.8.0). I think I remember seeing
something about that on the mailing list recently:

Modified Files:
	i2c-voodoo3.c i2c-via.c i2c-viapro.c i2c-i810.c i2c-savage4.c 
Log Message:
(mds) don't use pci_module_init() for video i2c drivers so we don't
      conflict with video drivers

It was for a different conflict (it seems). However, the changes made to
i2c-viapro.c may also prevent the conflict you observed. This is a very
recent change (occured on July 2nd.). I attached the patch, could you
please check wether it is already applied to the 2.6.0 kernel tree? If
not, could you try to apply it and tell us if it solves your problem?

I admit I'm a bit confused, because i2c-viapro is a bus driver while
via686a is a chip driver. Thus I wonder how they can conflict...
However, the driver registering mechanisms of the Linux kernel is beyond
me, so it may just be me ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: i2c-viapro.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-viapro.c,v
retrieving revision 1.31
retrieving revision 1.32
diff -u -r1.31 -r1.32
--- i2c-viapro.c	10 Jun 2003 01:07:54 -0000	1.31
+++ i2c-viapro.c	3 Jul 2003 01:30:13 -0000	1.32
@@ -459,23 +459,41 @@
 	{ 0, }
 };
 
+/* Don't register driver to avoid driver conflicts */
+/*
 static struct pci_driver vt596_driver = {
 	.name		= "vt596 smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
 	.remove		= __devexit_p(vt596_remove),
 };
+*/
 
 static int __init i2c_vt596_init(void)
 {
+	struct pci_dev *dev;
+	const struct pci_device_id *id;
+
 	printk("i2c-viapro.o version %s (%s)\n", LM_VERSION, LM_DATE);
+/*
 	return pci_module_init(&vt596_driver);
+*/
+	pci_for_each_dev(dev) {
+		id = pci_match_device(vt596_ids, dev);
+		if(id)
+			if(vt596_probe(dev, id) >= 0)
+				return 0;
+	}
+	return -ENODEV;
 }
 
 
 static void __exit i2c_vt596_exit(void)
 {
+/*
 	pci_unregister_driver(&vt596_driver);
+*/
+	vt596_remove(NULL);
 }
 
 MODULE_AUTHOR(
