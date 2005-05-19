From: henk@god.dyndns.org (henk)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH 2.5.xx] - i2c-prosavage driver
Message-Id: <Pine.LNX.4.21.0306180108540.31336-200000@axp.arion.loc>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0306180041260.31258-200000@axp.arion.loc>
In-Reply-To: <Pine.LNX.4.21.0306180041260.31258-200000@axp.arion.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Had too much fun -> adapted codingstyle

Best regards, 

Henk


On Tue, 17 Jun 2003, Greg KH wrote:

> On Wed, Jun 18, 2003 at 12:44:47AM +0200, henk wrote:
> > 
> > OK ;)
> 
> Can you follow the proper Documentation/CodingStyle too and use tabs
> instead of spaces, and make your if statements readable?
> 
> thanks,
> 
> greg k-h
> 

-- 
-------------- next part --------------
diff -ruN --exclude='\.*' linux-2.5.71/drivers/i2c/Kconfig linux-2.5.71-p1/drivers/i2c/Kconfig
--- linux-2.5.71/drivers/i2c/Kconfig	2003-06-14 21:18:01.000000000 +0200
+++ linux-2.5.71-p1/drivers/i2c/Kconfig	2003-06-16 02:01:49.000000000 +0200
@@ -42,6 +42,26 @@
 	  <file:Documentation/modules.txt>.
 	  The module will be called i2c-algo-bit.
 
+config I2C_PROSAVAGE
+	tristate "S3/VIA (Pro)Savage"
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the
+	  I2C bus and DDC bus of the S3VIA embedded Savage4 and ProSavage8
+	  graphics processors.
+	  chipsets supported:
+	    S3/VIA KM266/VT8375 aka ProSavage8
+	    S3/VIA KM133/VT8365 aka Savage4
+
+	  This can also be built as a module which can be inserted and removed
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+	  The module will be called i2c-prosavage.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at
+	  http://www.lm-sensors.nu
+
 config I2C_PHILIPSPAR
 	tristate "Philips style parallel port adapter"
 	depends on I2C_ALGOBIT && PARPORT
diff -ruN --exclude='\.*' linux-2.5.71/drivers/i2c/Makefile linux-2.5.71-p1/drivers/i2c/Makefile
--- linux-2.5.71/drivers/i2c/Makefile	2003-06-14 21:17:56.000000000 +0200
+++ linux-2.5.71-p1/drivers/i2c/Makefile	2003-06-16 01:57:44.000000000 +0200
@@ -5,6 +5,7 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
+obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
diff -ruN --exclude='\.*' linux-2.5.71/drivers/i2c/i2c-prosavage.c linux-2.5.71-p1/drivers/i2c/i2c-prosavage.c
--- linux-2.5.71/drivers/i2c/i2c-prosavage.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.71-p1/drivers/i2c/i2c-prosavage.c	2003-06-18 01:19:37.000000000 +0200
@@ -0,0 +1,343 @@
+/*
+ *    kernel/busses/i2c-prosavage.c
+ *
+ *    i2c bus driver for S3/VIA 8365/8375 graphics processor.
+ *    Copyright (c) 2003 Henk Vergonet <henk@god.dyndns.org>
+ *    Based on code written by:
+ *	Frodo Looijaard <frodol@dds.nl>,
+ *	Philip Edelbrock <phil@netroedge.com>,
+ *	Ralph Metzler <rjkm@thp.uni-koeln.de>, and
+ *	Mark D. Studebaker <mdsxyz123@yahoo.com>
+ *	Simon Vogl
+ *	and others
+ *
+ *    Please read the lm_sensors documentation for details on use.
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+/*  18-05-2003 HVE - created
+ *  14-06-2003 HVE - adapted for lm_sensors2
+ *  17-06-2003 HVE - linux 2.5.xx compatible
+ *  18-06-2003 HVE - codingstyle
+ *
+ *  This driver interfaces to the I2C bus of the VIA north bridge embedded
+ *  ProSavage4/8 devices. Usefull for gaining access to the TV Encoder chips.
+ *
+ *  Graphics cores:
+ *   S3/VIA KM266/VT8375 aka ProSavage8
+ *   S3/VIA KM133/VT8365 aka Savage4
+ *
+ *  Two serial busses are implemented:
+ *   SERIAL1 - I2C serial communications interface
+ *   SERIAL2 - DDC2 monitor communications interface
+ *
+ *  Tested on a FX41 mainboard, see http://www.shuttle.com
+ * 
+ *
+ *  TODO:
+ *  - Robust initialisation code of video registers.
+ *    Get rid of the hardcoded video IO base addresses.
+ *    (Additional documentation needed :(
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+
+/*
+ * driver configuration
+ */
+#define	DRIVER_ID	"i2c-prosavage"
+#define	DRIVER_VERSION	"20030618"
+
+
+/*
+ * i2c configuration
+ */
+#ifndef I2C_HW_B_S3VIA
+#define I2C_HW_B_S3VIA	0x18	/* S3VIA ProSavage adapter		*/
+#endif
+
+/* delays */
+#define CYCLE_DELAY	10
+#define TIMEOUT		(HZ / 2)
+
+
+/* 
+ * S3/VIA 8365/8375 registers
+ */
+#ifndef PCI_VENDOR_ID_S3
+#define PCI_VENDOR_ID_S3		0x5333
+#endif
+#ifndef PCI_DEVICE_ID_S3_SAVAGE4
+#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
+#endif
+#ifndef PCI_DEVICE_ID_S3_PROSAVAGE8
+#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
+#endif
+
+/* FIXME determine from chip config or use mmio */
+#define VGA_IOBASE0	0x3c0
+#define VGA_IOBASE1	0x3d0
+
+#define PCIREG_SUBSYS	0x2c
+#define IOREG_SUBSYS	0x81
+
+#define IOREG_SERIAL1	0xa0	/* I2C serial communications interface */
+#define MMREG_SERIAL1	0xff20
+#define IOREG_SERIAL2	0xb1	/* DDC2 monitor communications interface */
+
+/* based on vt8365 documentation */
+#define I2C_ENAB	0x00000010
+#define I2C_SCL_OUT	0x00000001
+#define I2C_SDA_OUT	0x00000002
+#define I2C_SCL_IN	0x00000004
+#define I2C_SDA_IN	0x00000008
+
+
+/*
+ * Manipulate the extended video registers
+ *
+ * TODO: spinlocks with other code sections accessing video registers?
+ */
+static inline unsigned int getCR0(unsigned int cr)
+{
+	outb_p((unsigned char)cr, VGA_IOBASE0 + 4);
+	return inb_p(VGA_IOBASE0 + 5);
+}
+
+static inline void setCR0(unsigned int cr, unsigned int val)
+{
+	outb_p((unsigned char)cr, VGA_IOBASE0 + 4);
+	outb_p((unsigned char)val, VGA_IOBASE0 + 5);
+}
+
+static inline unsigned int getCR1(unsigned int cr)
+{
+	outb_p((unsigned char)cr, VGA_IOBASE1 + 4);
+	return inb_p(VGA_IOBASE1 + 5);
+}
+
+static inline void setCR1(unsigned int cr, unsigned int val)
+{
+	outb_p((unsigned char)cr, VGA_IOBASE1 + 4);
+	outb_p((unsigned char)val, VGA_IOBASE1 + 5);
+}
+
+
+/*
+ * Serial bus line handling
+ *
+ * serial communications register as parameter in private data
+ */
+static void bit_s3via_setscl(void *cr, int val)
+{
+	unsigned int r;
+	r = getCR1((unsigned int)cr);
+	r |= I2C_ENAB;
+	if(val)	{
+		r |= I2C_SCL_OUT;
+	} else {
+		r &= ~I2C_SCL_OUT;
+	}
+	setCR1((unsigned int)cr, r);
+}
+
+static void bit_s3via_setsda(void *cr, int val)
+{
+	unsigned int r;
+	r = getCR1((unsigned int)cr);
+	r |= I2C_ENAB;
+	if(val) {
+		r |= I2C_SDA_OUT;
+	} else {
+		r &= ~I2C_SDA_OUT;
+	}
+	setCR1((unsigned int)cr, r);
+}
+
+static int bit_s3via_getscl(void *cr)
+{
+	return (0 != (getCR1((unsigned int)cr) & I2C_SCL_IN));
+}
+
+static int bit_s3via_getsda(void *cr)
+{
+	return (0 != (getCR1((unsigned int)cr) & I2C_SDA_IN));
+}
+
+
+#define MAX_BUSSES	2
+
+static int i2c_bus_cnt = 0;
+static struct s_i2c_bus {
+	struct i2c_adapter		adap;
+	struct i2c_algo_bit_data	algo;
+} i2c_bus[MAX_BUSSES];
+
+/*
+ * adapter initialisation
+ */
+static int i2c_register_bus(struct pci_dev *dev, unsigned reg)
+{
+	struct s_i2c_bus *p;
+	int ret;
+
+	if(i2c_bus_cnt > MAX_BUSSES) {
+		return -ENOSPC;
+	}
+
+	p = &i2c_bus[i2c_bus_cnt];
+	p->adap.owner	= THIS_MODULE;
+	p->adap.id		= I2C_HW_B_S3VIA;
+	p->adap.algo_data	= &p->algo;
+	p->algo.setsda	= bit_s3via_setsda;
+	p->algo.setscl	= bit_s3via_setscl;
+	p->algo.getsda	= bit_s3via_getsda;
+	p->algo.getscl	= bit_s3via_getscl;
+	p->algo.udelay	= CYCLE_DELAY;
+	p->algo.mdelay	= CYCLE_DELAY;
+	p->algo.timeout	= TIMEOUT;
+	p->algo.data	= (void *)reg;
+    
+	/* add a xref to the bus number */
+	switch(reg) {
+	case IOREG_SERIAL1:
+	    snprintf(p->adap.dev.name, sizeof(p->adap.dev.name),
+		"ProSavage I2C bus at %02x:%02x.%x", dev->bus->number,
+		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	    break;
+	case IOREG_SERIAL2:
+	    snprintf(p->adap.dev.name, sizeof(p->adap.dev.name),
+		"ProSavage DDC bus at %02x:%02x.%x", dev->bus->number,
+		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	    break;
+	default:
+	    return -ENODEV;
+	}
+
+	ret = i2c_bit_add_bus(&p->adap);
+	if(ret) {
+		return ret;
+	}
+
+	i2c_bus_cnt++;
+	return 0;
+}
+
+
+/*
+ * Detect chip and initialize it
+ */
+static int __devinit prosavage_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int i, ret;
+	u8 tmp;
+
+	/*
+	 * Compare subsystem ID's of pci space and video register space.
+	 * This could be usefull if more than 1 video device is installed. If
+	 * the video io registers are redirected to an other video card we
+	 * assume the subsystem ID's do not match and we should abort the
+	 * installation.
+	 */
+	for(i=0; i<4; i++) {
+		pci_read_config_byte(dev, PCIREG_SUBSYS + i, &tmp);
+		if(tmp != (u8)getCR1(IOREG_SUBSYS + i)) {
+		    printk(DRIVER_ID ": Video IO registers redirected?\n");   
+		    return -ENODEV;
+		}
+	}
+
+	/*
+	 * Chip initialisation
+	 */
+	/* Unlock Extended IO Space ??? */
+
+	ret = i2c_register_bus(dev, IOREG_SERIAL1);
+	if(ret) {
+		return ret;
+	}
+
+	ret = i2c_register_bus(dev, IOREG_SERIAL2);
+	return ret;
+}
+
+static void __devexit prosavage_remove(struct pci_dev *dev)
+{
+	int ret;
+	while(i2c_bus_cnt > 0) {
+		i2c_bus_cnt--;
+	        ret = i2c_bit_del_bus(&i2c_bus[i2c_bus_cnt].adap);
+	        if(ret) {
+        	    printk(DRIVER_ID ": %s not removed\n",
+			i2c_bus[i2c_bus_cnt].adap.dev.name);
+		}
+	}
+}
+
+
+/*
+ * Data for PCI driver interface
+ */
+static struct pci_device_id prosavage_pci_tbl[] __devinitdata = {
+   {
+	.vendor		=	PCI_VENDOR_ID_S3,
+	.device		=	PCI_DEVICE_ID_S3_SAVAGE4,
+	.subvendor	=	PCI_ANY_ID,
+	.subdevice	=	PCI_ANY_ID,
+   },{
+	.vendor		=	PCI_VENDOR_ID_S3,
+	.device		=	PCI_DEVICE_ID_S3_PROSAVAGE8,
+	.subvendor	=	PCI_ANY_ID,
+	.subdevice	=	PCI_ANY_ID,
+   },{ 0, }
+};
+
+static struct pci_driver prosavage_driver = {
+        .name           =	"s3via-smbus",
+        .id_table       =	prosavage_pci_tbl,
+        .probe          =	prosavage_probe,
+        .remove         =	__devexit_p(prosavage_remove),
+};
+
+static int __init i2c_prosavage_init(void)
+{
+	i2c_bus_cnt = 0;
+	memset(&i2c_bus, 0, sizeof(i2c_bus));
+
+	printk(DRIVER_ID " version %s (%s)\n", I2C_VERSION, DRIVER_VERSION);
+	return pci_module_init(&prosavage_driver);
+}
+
+static void __exit i2c_prosavage_exit(void)
+{
+	pci_unregister_driver(&prosavage_driver);
+}
+
+MODULE_DEVICE_TABLE(pci, prosavage_pci_tbl);
+MODULE_AUTHOR("Henk Vergonet");
+MODULE_DESCRIPTION("ProSavage VIA 8365/8375 smbus driver");
+MODULE_LICENSE("GPL");
+
+module_init (i2c_prosavage_init);
+module_exit (i2c_prosavage_exit);
