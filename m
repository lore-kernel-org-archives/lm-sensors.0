From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Oct 2005 22:37:43 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <20051006223651.45c25361.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Stig,

> I have incorporated all your suggestions into this patch, except for=20
> these two:
>=20
> * Jean: use of val & 255 in printk statement in pcf_isa_setbyte() - I=20
> think this is actually required because parameter val is an integer=20
> quantity and could have been sign-extended?  I would prefer to change=20
> the function parameter to u8, but this violates the types of struct=20
> i2c_algo_pcf_data.

The "& 255" is done in the debug printk only, iowrite8 is still called
with val unmasked, so if the masking actually did something, something
bas is happening, and the debug trace won't ever show it.

Looking at i2c-algo-pcf, it's quite clear that val will always fit in
an u8, so the masking is actually needless.

> * Greg: I haven't changed the printk and pr_debug calls yet, because=20
> there are some printk calls before a struct device is initialised (this=20
> is done when the device is registered to i2c_algo_pcf at the end of=20
> driver init).  What is the policy relating to driver output before=20
> there is an associated struct device initialised?

pr_debug and pr_info are fine to use in these cases (or even explicit
printk for other cases).

> I took a look at the code with sparse, there were no reported problems.=20
>   However, am I right in thinking that sparse is x86-centric?  I was=20
> running the compilation on an Alpha system.  With more than a little=20
> irony considering the political harangue against gcc in the sparse=20
> documentation, it didn't compile on my RH8 x86 system: gcc gave an=20
> internal compiler error...

I had the exact same problem :(

> The attached patch is for code cleanup and is a direct replacement for=20
> patch 2.

Comments:

> * all printed messages are prefixed by "i2c-elektor: ", via new preproces=
sor
>   definitions DRVNAME and DRVPFX

This is pretty pointless considering that we want to convert all of
these to dev_{dbg,err,warn,info} anyway, and these do not need a prefix.

> * #if __alpha__ converted to #ifdef __alpha__

This is a bug you introduced in patch #1! Don't fix it in patch #2, fix
patch #1 not to introduce it in the first place.

So, here comes a respin of both patches. I'd like to enqueue them and
push them to Greg soon. Can you test them and confirm them work OK for
you?

Thanks,
--=20
Jean Delvare
-------------- next part --------------
This patch updates the i2c-elektor driver, enabling it to compile
cleanly, load and run.  The key change is that it uses the new
__iomem/iowrite8/ioread8 functions to abstract the direct or
memory-mapped variants of register access.  Also, the original driver
would crash on module load on the Alpha because the PCI memory region
was not remapped into kernel memory.

I have managed the following testing:=20

* compiled and tested it on my Alpha UP2000+ system.
* compiles cleanly for x86 but I don't have the hardware to test.

Signed-off-by: Stig Telfer <stig@lizardlogic.co.uk>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-elektor.c |   74 +++++++++++++++++++++++++---------=
----
 1 file changed, 49 insertions(+), 25 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-elektor.c	2005-10-05 21:55=
:34.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-elektor.c	2005-10-06 22:18:20.0=
00000000 +0200
@@ -46,6 +46,8 @@
 #define DEFAULT_BASE 0x330
=20
 static int base;
+static u8 __iomem *base_iomem;
+
 static int irq;
 static int clock  =3D 0x1c;
 static int own    =3D 0x55;
@@ -64,36 +66,27 @@
=20
 static void pcf_isa_setbyte(void *data, int ctl, int val)
 {
-	int address =3D ctl ? (base + 1) : base;
+	u8 __iomem *address =3D ctl ? (base_iomem + 1) : base_iomem;
=20
 	/* enable irq if any specified for serial operation */
 	if (ctl && irq && (val & I2C_PCF_ESO)) {
 		val |=3D I2C_PCF_ENI;
 	}
=20
-	pr_debug("i2c-elektor: Write 0x%X 0x%02X\n", address, val & 255);
-
-	switch (mmapped) {
-	case 0: /* regular I/O */
-		outb(val, address);
-		break;
-	case 2: /* double mapped I/O needed for UP2000 board,
-                   I don't know why this... */
-		writeb(val, (void *)address);
-		/* fall */
-	case 1: /* memory mapped I/O */
-		writeb(val, (void *)address);
-		break;
-	}
+	pr_debug("i2c-elektor: Write %p 0x%02X\n", address, val);
+	iowrite8(val, address);
+#ifdef __alpha__
+	/* API UP2000 needs some hardware fudging to make the write stick */
+	iowrite8(val, address);
+#endif
 }
=20
 static int pcf_isa_getbyte(void *data, int ctl)
 {
-	int address =3D ctl ? (base + 1) : base;
-	int val =3D mmapped ? readb((void *)address) : inb(address);
-
-	pr_debug("i2c-elektor: Read 0x%X 0x%02X\n", address, val);
+	u8 __iomem *address =3D ctl ? (base_iomem + 1) : base_iomem;
+	int val =3D ioread8(address);
=20
+	pr_debug("i2c-elektor: Read %p 0x%02X\n", address, val);
 	return (val);
 }
=20
@@ -155,7 +148,30 @@
 			       "is in use.\n", base);
 			return -ENODEV;
 		}
+		base_iomem =3D ioport_map(base, 2);
+		if (!base_iomem) {
+			printk(KERN_ERR "i2c-elektor: remap of I/O region "
+			       "%#x failed\n", base);
+			release_region(base, 2);
+			return -ENODEV;
+		}
+	} else {
+		if (!request_mem_region(base, 2, "i2c-elektor")) {
+			printk(KERN_ERR "i2c-elektor: requested memory region "
+			       "(%#x:2) is in use\n", base);
+			return -ENODEV;
+		}
+		base_iomem =3D ioremap(base, 2);
+		if (base_iomem =3D NULL) {
+			printk(KERN_ERR "i2c-elektor: remap of memory region "
+			       "%#x failed\n", base);
+			release_mem_region(base, 2);
+			return -ENODEV;
+		}
 	}
+	pr_debug("i2c-elektor: registers %#x remapped to %p\n", base,
+		 base_iomem);
+
 	if (irq > 0) {
 		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", NULL) < 0) {
 			printk(KERN_ERR "i2c-elektor: Request irq%d failed\n", irq);
@@ -200,7 +216,7 @@
 		cy693_dev =3D pci_get_device(PCI_VENDOR_ID_CONTAQ,=20
 					   PCI_DEVICE_ID_CONTAQ_82C693, NULL);
 		if (cy693_dev) {
-			char config;
+			unsigned char config;
 			/* yeap, we've found cypress, let's check config */
 			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
 			=09
@@ -219,9 +235,7 @@
 				if ((config & 0x7f) =3D 0x61) {
 					/* seems to be UP2000 like board */
 					base =3D 0xe0000;
-                                        /* I don't know why we need to
-                                           write twice */
-					mmapped =3D 2;
+					mmapped =3D 1;
                                         /* UP2000 drives ISA with
 					   8.25 MHz (PCI/4) clock
 					   (this can be read from cypress) */
@@ -262,8 +276,13 @@
 		free_irq(irq, NULL);
 	}
=20
-	if (!mmapped)
+	if (!mmapped) {
+		ioport_unmap(base_iomem);
 		release_region(base , 2);
+	} else {
+		iounmap(base_iomem);
+		release_mem_region(base, 2);
+	}
 	return -ENODEV;
 }
=20
@@ -276,8 +295,13 @@
 		free_irq(irq, NULL);
 	}
=20
-	if (!mmapped)
+	if (!mmapped) {
+		ioport_unmap(base_iomem);
 		release_region(base , 2);
+	} else {
+		iounmap(base_iomem);
+		release_mem_region(base, 2);
+	}
 }
=20
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
-------------- next part --------------
Cleanups to the i2c-elektor driver:

* Set the i2c_adapter name field to "i2c-elektor" and use this string
  in all resource requests and printks.
* Change space-padding for tab indentation, kill trailing white space.
* Use dev_dbg and dev_info instead of printk where possible, and
  pr_debug and pr_info where not.
* Lines chopped to 80 columns.

Signed-off-by: Stig Telfer <stig@lizardlogic.co.uk>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-elektor.c |   80 ++++++++++++++++++++--------------=
----
 1 file changed, 43 insertions(+), 37 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-elektor.c	2005-10-06 22:18=
:20.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-elektor.c	2005-10-06 22:19:39.0=
00000000 +0200
@@ -22,7 +22,7 @@
 /* With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
=20
-/* Partialy rewriten by Oleg I. Vdovikin for mmapped support of=20
+/* Partialy rewriten by Oleg I. Vdovikin for mmapped support of
    for Alpha Processor Inc. UP-2000(+) boards */
=20
 #include <linux/kernel.h>
@@ -53,7 +53,7 @@
 static int own    =3D 0x55;
 static int mmapped;
=20
-/* vdovikin: removed static struct i2c_pcf_isa gpi; code -=20
+/* vdovikin: removed static struct i2c_pcf_isa gpi; code -
   this module in real supports only one device, due to missing arguments
   in some functions, called from the algo-pcf module. Sometimes it's
   need to be rewriten - but for now just remove this for simpler reading */
@@ -62,6 +62,8 @@
 static int pcf_pending;
 static spinlock_t lock;
=20
+static struct i2c_adapter pcf_isa_ops;
+
 /* ----- local functions ----------------------------------------------	*/
=20
 static void pcf_isa_setbyte(void *data, int ctl, int val)
@@ -73,7 +75,7 @@
 		val |=3D I2C_PCF_ENI;
 	}
=20
-	pr_debug("i2c-elektor: Write %p 0x%02X\n", address, val);
+	dev_dbg(&pcf_isa_ops.dev, "Write %p 0x%02X\n", address, val);
 	iowrite8(val, address);
 #ifdef __alpha__
 	/* API UP2000 needs some hardware fudging to make the write stick */
@@ -86,7 +88,7 @@
 	u8 __iomem *address =3D ctl ? (base_iomem + 1) : base_iomem;
 	int val =3D ioread8(address);
=20
-	pr_debug("i2c-elektor: Read %p 0x%02X\n", address, val);
+	dev_dbg(&pcf_isa_ops.dev, "Read %p 0x%02X\n", address, val);
 	return (val);
 }
=20
@@ -142,39 +144,40 @@
 {
 	spin_lock_init(&lock);
 	if (!mmapped) {
-		if (!request_region(base, 2, "i2c (isa bus adapter)")) {
-			printk(KERN_ERR
-			       "i2c-elektor: requested I/O region (0x%X:2) "
-			       "is in use.\n", base);
+		if (!request_region(base, 2, pcf_isa_ops.name)) {
+			printk(KERN_ERR "%s: requested I/O region (%#x:2) is "
+			       "in use\n", pcf_isa_ops.name, base);
 			return -ENODEV;
 		}
 		base_iomem =3D ioport_map(base, 2);
 		if (!base_iomem) {
-			printk(KERN_ERR "i2c-elektor: remap of I/O region "
-			       "%#x failed\n", base);
+			printk(KERN_ERR "%s: remap of I/O region %#x failed\n",
+			       pcf_isa_ops.name, base);
 			release_region(base, 2);
 			return -ENODEV;
 		}
 	} else {
-		if (!request_mem_region(base, 2, "i2c-elektor")) {
-			printk(KERN_ERR "i2c-elektor: requested memory region "
-			       "(%#x:2) is in use\n", base);
+		if (!request_mem_region(base, 2, pcf_isa_ops.name)) {
+			printk(KERN_ERR "%s: requested memory region (%#x:2) "
+			       "is in use\n", pcf_isa_ops.name, base);
 			return -ENODEV;
 		}
 		base_iomem =3D ioremap(base, 2);
 		if (base_iomem =3D NULL) {
-			printk(KERN_ERR "i2c-elektor: remap of memory region "
-			       "%#x failed\n", base);
+			printk(KERN_ERR "%s: remap of memory region %#x "
+			       "failed\n", pcf_isa_ops.name, base);
 			release_mem_region(base, 2);
 			return -ENODEV;
 		}
 	}
-	pr_debug("i2c-elektor: registers %#x remapped to %p\n", base,
+	pr_debug("%s: registers %#x remapped to %p\n", pcf_isa_ops.name, base,
 		 base_iomem);
=20
 	if (irq > 0) {
-		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", NULL) < 0) {
-			printk(KERN_ERR "i2c-elektor: Request irq%d failed\n", irq);
+		if (request_irq(irq, pcf_isa_handler, 0, pcf_isa_ops.name,
+				NULL) < 0) {
+			printk(KERN_ERR "%s: Request irq%d failed\n",
+			       pcf_isa_ops.name, irq);
 			irq =3D 0;
 		} else
 			enable_irq(irq);
@@ -202,45 +205,49 @@
 	.class		=3D I2C_CLASS_HWMON,
 	.id		=3D I2C_HW_P_ELEK,
 	.algo_data	=3D &pcf_isa_data,
-	.name		=3D "PCF8584 ISA adapter",
+	.name		=3D "i2c-elektor",
 };
=20
-static int __init i2c_pcfisa_init(void)=20
+static int __init i2c_pcfisa_init(void)
 {
 #ifdef __alpha__
-	/* check to see we have memory mapped PCF8584 connected to the=20
+	/* check to see we have memory mapped PCF8584 connected to the
 	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
 	if (base =3D 0) {
 		struct pci_dev *cy693_dev;
-	=09
-		cy693_dev =3D pci_get_device(PCI_VENDOR_ID_CONTAQ,=20
+
+		cy693_dev =3D pci_get_device(PCI_VENDOR_ID_CONTAQ,
 					   PCI_DEVICE_ID_CONTAQ_82C693, NULL);
 		if (cy693_dev) {
 			unsigned char config;
 			/* yeap, we've found cypress, let's check config */
 			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
-			=09
-				pr_debug("i2c-elektor: found cy82c693, config register 0x47 =3D 0x%02x=
.\n", config);
+
+				pr_debug("%s: found cy82c693, config "
+					 "register 0x47 =3D 0x%02x\n",
+					 pcf_isa_ops.name, config);
=20
 				/* UP2000 board has this register set to 0xe1,
-                                   but the most significant bit as seems c=
an be=20
+				   but the most significant bit as seems can be
 				   reset during the proper initialisation
-                                   sequence if guys from API decides to do=
 that
-                                   (so, we can even enable Tsunami Pchip
-                                   window for the upper 1 Gb) */
+				   sequence if guys from API decides to do that
+				   (so, we can even enable Tsunami Pchip
+				   window for the upper 1 Gb) */
=20
 				/* so just check for ROMCS at 0xe0000,
-                                   ROMCS enabled for writes
+				   ROMCS enabled for writes
 				   and external XD Bus buffer in use. */
 				if ((config & 0x7f) =3D 0x61) {
 					/* seems to be UP2000 like board */
 					base =3D 0xe0000;
 					mmapped =3D 1;
-                                        /* UP2000 drives ISA with
+					/* UP2000 drives ISA with
 					   8.25 MHz (PCI/4) clock
 					   (this can be read from cypress) */
 					clock =3D I2C_PCF_CLK | I2C_PCF_TRNS90;
-					printk(KERN_INFO "i2c-elektor: found API UP2000 like board, will prob=
e PCF8584 later.\n");
+					pr_info("%s: found API UP2000 like "
+						"board, will probe PCF8584 "
+						"later\n", pcf_isa_ops.name);
 				}
 			}
 			pci_dev_put(cy693_dev);
@@ -250,12 +257,11 @@
=20
 	/* sanity checks for mmapped I/O */
 	if (mmapped && base < 0xc8000) {
-		printk(KERN_ERR "i2c-elektor: incorrect base address (0x%0X) specified f=
or mmapped I/O.\n", base);
+		printk(KERN_ERR "%s: incorrect base address (%#x) specified "
+		       "for mmapped I/O\n", pcf_isa_ops.name, base);
 		return -ENODEV;
 	}
=20
-	printk(KERN_INFO "i2c-elektor: i2c pcf8584-isa adapter driver\n");
-
 	if (base =3D 0) {
 		base =3D DEFAULT_BASE;
 	}
@@ -265,8 +271,8 @@
 		return -ENODEV;
 	if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
 		goto fail;
-=09
-	printk(KERN_ERR "i2c-elektor: found device at %#x.\n", base);
+
+	dev_info(&pcf_isa_ops.dev, "found device at %#x\n", base);
=20
 	return 0;
=20
