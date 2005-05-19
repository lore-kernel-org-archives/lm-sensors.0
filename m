From: henk@god.dyndns.org (henk)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH lm_sensors2 CVS code] - i2c-prosavage driver
Message-Id: <Pine.LNX.4.21.0306141542460.16135-200000@axp.arion.loc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Added i2c-prosavage bus driver to todays lm_sensors2 CVS code, an updated 
./mkpatch/mkpatch.pl and ./kernel/busses/Module.mk is included.

..
/*  18-05-2003 - created
 *  16-06-2003 - adapted for lm_sensors2
 *
 *  This driver interfaces to the I2C bus of the VIA north bridge embedded
 *  ProSavage4/8 devices. Usefull for gaining access to the TV Encoder
chips.
..

Please include this in the CVS tree..

Have fun,

Henk Vergonet
-- 

-------------- next part --------------
diff -U 3 -N -r -x sensors.h -x Entries lm_sensors2/kernel/busses/Module.mk lm_sensors2-p1/kernel/busses/Module.mk
--- lm_sensors2/kernel/busses/Module.mk	2003-06-14 15:24:08.000000000 +0200
+++ lm_sensors2-p1/kernel/busses/Module.mk	2003-06-14 13:55:22.000000000 +0200
@@ -90,6 +90,9 @@
 ifneq ($(shell if grep -q '^CONFIG_I2C_VOODOO3=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-voodoo3.o
 endif
+ifneq ($(shell if grep -q '^CONFIG_I2C_PROSAVAGE=y' $(LINUX)/.config; then echo 1; fi),1)
+KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-prosavage.o
+endif
 
 # Include all dependency files
 INCLUDEFILES += $(KERNELBUSSESTARGETS:.o=.d)
diff -U 3 -N -r -x sensors.h -x Entries lm_sensors2/kernel/busses/i2c-prosavage.c lm_sensors2-p1/kernel/busses/i2c-prosavage.c
--- lm_sensors2/kernel/busses/i2c-prosavage.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2-p1/kernel/busses/i2c-prosavage.c	2003-06-14 15:07:23.000000000 +0200
@@ -0,0 +1,333 @@
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
+/*  18-05-2003 - created
+ *  16-06-2003 - adapted for lm_sensors2
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
+ *    Get rid of the hardcoded the video IO base addresses.
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
+#include "version.h"
+
+
+/*
+ * driver configuration
+ */
+#define	DRIVER_ID	"i2c-prosavage"
+#define	DRIVER_VERSION	"20030616"
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
+/* FIXME determine from chip config */
+#define VGA_IOBASE0	0x3c0
+#define VGA_IOBASE1	0x3d0
+
+#define IOREG_SERIAL1	0xa0	/* I2C serial communications interface */
+#define MMREG_SERIAL1	0xff20
+#define IOREG_SERIAL2	0xb1	/* DDC2 monitor communications interface */
+
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
+ */
+static inline unsigned int getCR0(unsigned int cr)
+{
+   outb_p((unsigned char)cr, VGA_IOBASE0 + 4);
+   return inb_p(VGA_IOBASE0 + 5);
+}
+
+static inline void setCR0(unsigned int cr, unsigned int val)
+{
+   outb_p((unsigned char)cr, VGA_IOBASE0 + 4);
+   outb_p((unsigned char)val, VGA_IOBASE0 + 5);
+}
+
+static inline unsigned int getCR1(unsigned int cr)
+{
+   outb_p((unsigned char)cr, VGA_IOBASE1 + 4);
+   return inb_p(VGA_IOBASE1 + 5);
+}
+
+static inline void setCR1(unsigned int cr, unsigned int val)
+{
+   outb_p((unsigned char)cr, VGA_IOBASE1 + 4);
+   outb_p((unsigned char)val, VGA_IOBASE1 + 5);
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
+	if(val)	r |= I2C_SCL_OUT;
+	else	r &= ~I2C_SCL_OUT;
+	setCR1((unsigned int)cr, r);
+}
+
+static void bit_s3via_setsda(void *cr, int val)
+{
+	unsigned int r;
+	r = getCR1((unsigned int)cr);
+	r |= I2C_ENAB;		/* Enable DDC */
+	if(val) r |= I2C_SDA_OUT;
+	else	r &= ~I2C_SDA_OUT;
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
+/*
+ * WARNING these i2c_algo_bit_data struct's are shared between adapters
+ * if more than 1 video card is used. The bit-algo driver must not modify
+ * or manipulate its contents.
+ */
+static struct i2c_algo_bit_data algo_serial1 = {
+	.data		=	(void *)IOREG_SERIAL1,
+	.setsda		=	bit_s3via_setsda,
+	.setscl		=	bit_s3via_setscl,
+	.getsda		=	bit_s3via_getsda,
+	.getscl		=	bit_s3via_getscl,
+	.udelay		=	CYCLE_DELAY,
+	.mdelay		=	CYCLE_DELAY,
+	.timeout	=	TIMEOUT
+};
+
+static struct i2c_algo_bit_data algo_serial2 = {
+	.data		=	(void *)IOREG_SERIAL2,
+	.setsda		=	bit_s3via_setsda,
+	.setscl		=	bit_s3via_setscl,
+	.getsda		=	bit_s3via_getsda,
+	.getscl		=	bit_s3via_getscl,
+	.udelay		=	CYCLE_DELAY,
+	.mdelay		=	CYCLE_DELAY,
+	.timeout	=	TIMEOUT
+};
+
+static const struct i2c_adapter bus_template_i2c = {
+	.owner		=	THIS_MODULE,
+	.name		=	"ProSavage I2C bus",
+	.id		=	I2C_HW_B_S3VIA,
+	.algo_data	=	&algo_serial1,
+};
+
+static const struct i2c_adapter bus_template_ddc2 = {
+	.owner		=	THIS_MODULE,
+	.name		=	"ProSavage DDC2 bus",
+	.id		=	I2C_HW_B_S3VIA,
+	.algo_data	=	&algo_serial2,
+};
+
+#define MAX_BUSSES	2
+static int		  i2c_bus_cnt = 0;
+static struct i2c_adapter i2c_bus[MAX_BUSSES];
+
+
+/*
+ * adapter initialisation
+ */
+static int i2c_register_bus(struct pci_dev *dev, const struct i2c_adapter *conf)
+{
+    int ret;
+
+    if(i2c_bus_cnt > MAX_BUSSES) return -ENOSPC;
+
+    memcpy(&i2c_bus[i2c_bus_cnt], conf, sizeof(i2c_bus[i2c_bus_cnt]));
+
+    /* add a xref to the bus number */
+    snprintf(i2c_bus[i2c_bus_cnt].name, sizeof(i2c_bus[i2c_bus_cnt].name),
+	"%s at %02x:%02x.%x", conf->name,
+	dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+    ret = i2c_bit_add_bus(&i2c_bus[i2c_bus_cnt]);
+    if(ret) return ret;
+
+    i2c_bus_cnt++;
+    return 0;
+}
+
+
+/*
+ * Detect chip and initialize it
+ */
+static int __devinit prosavage_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+    int ret = 0;
+
+    /* general initialisation */
+    /* Unlock Extended IO Space */
+//    setCR0(0x10, 1);	// is this needed ?
+
+    /* Enable MMIO */
+//    val = getCR0(0x1a);
+//    setCR0(0x1a, val | 0x68);
+
+//    setCR1(0x6a, 0);
+//    setCR1(0x6b, 0);
+//    setCR1(0x6c, 0);
+
+    ret = i2c_register_bus(dev, &bus_template_i2c);
+    if(ret) return ret;
+
+    ret = i2c_register_bus(dev, &bus_template_ddc2);
+    return ret;
+}
+
+static void __devexit prosavage_remove(struct pci_dev *dev)
+{
+    int ret;
+    while(i2c_bus_cnt > 0) {
+        i2c_bus_cnt--;
+        ret = i2c_bit_del_bus(&i2c_bus[i2c_bus_cnt]);
+        if(ret)
+            printk(DRIVER_ID ": %s not removed\n", i2c_bus[i2c_bus_cnt].name);
+    }
+}
+
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.
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
+    },{ 0, }
+};
+
+static struct pci_driver prosavage_driver = {
+        .name           =	"s3via smbus",
+        .id_table       =	prosavage_pci_tbl,
+        .probe          =	prosavage_probe,
+        .remove         =	__devexit_p(prosavage_remove),
+};
+
+static int __init prosavage_init(void)
+{
+	i2c_bus_cnt = 0;
+	printk(DRIVER_ID ": version %s LM(%s)\n", DRIVER_VERSION, LM_VERSION);
+	return pci_module_init(&prosavage_driver);
+}
+
+static void __exit prosavage_exit(void)
+{
+    pci_unregister_driver(&prosavage_driver);
+}
+
+MODULE_DEVICE_TABLE(pci, prosavage_pci_tbl);
+MODULE_AUTHOR("Henk Vergonet");
+MODULE_DESCRIPTION("ProSavage VIA 8365/8375 I2C/SMBus driver");
+MODULE_LICENSE("GPL");
+
+module_init (prosavage_init);
+module_exit (prosavage_exit);
+
diff -U 3 -N -r -x sensors.h -x Entries lm_sensors2/mkpatch/mkpatch.pl lm_sensors2-p1/mkpatch/mkpatch.pl
--- lm_sensors2/mkpatch/mkpatch.pl	2003-06-14 15:24:20.000000000 +0200
+++ lm_sensors2-p1/mkpatch/mkpatch.pl	2003-06-14 14:05:21.000000000 +0200
@@ -235,6 +235,15 @@
   built as a module which can be inserted and removed while the kernel
   is running.
 
+S3VIA ProSavage
+CONFIG_I2C_PROSAVAGE
+  If you say yes to this option, support will be included for the
+  S3VIA ProSavage I2C and DDC interfaces. The I2C busses on the these
+  chips are generally used only for video devices.
+  This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
 DEC Tsunami 21272
 CONFIG_I2C_TSUNAMI
   If you say yes to this option, support will be included for the DEC
@@ -857,6 +866,7 @@
     dep_tristate '  VIA Technologies, Inc. VT82C586B' CONFIG_I2C_VIA $CONFIG_I2C_ALGOBIT
     dep_tristate '  VIA Technologies, Inc. VT596A/B, 686A/B, 8231, 8233, 8233A, 8235' CONFIG_I2C_VIAPRO $CONFIG_I2C
     dep_tristate '  Voodoo3 I2C interface' CONFIG_I2C_VOODOO3 $CONFIG_I2C_ALGOBIT
+    dep_tristate '  ProSavage I2C/DDC interface' CONFIG_I2C_PROSAVAGE $CONFIG_I2C_ALGOBIT
     dep_tristate '  Pseudo ISA adapter (for some hardware sensors)' CONFIG_I2C_ISA $CONFIG_I2C
   fi
 
@@ -1258,6 +1268,7 @@
 obj-$(CONFIG_I2C_VIA)			+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)		+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)		+= i2c-voodoo3.o
+obj-$(CONFIG_I2C_PROSAVAGE)		+= i2c-prosavage.o
 export-objs				+= dmi_scan.o
 EOF
       } else {
@@ -1398,6 +1409,14 @@
   endif
 endif
 
+ifeq ($(CONFIG_I2C_PROSAVAGE),y)
+  L_OBJS += i2c-prosavage.o
+else 
+  ifeq ($(CONFIG_I2C_PROSAVAGE),m)
+    M_OBJS += i2c-prosavage.o
+  endif
+endif
+
 EOF
       }
     }
@@ -1486,6 +1505,9 @@
 #ifdef CONFIG_I2C_VOODOO3
 	extern int i2c_voodoo3_init(void);
 #endif
+#ifdef CONFIG_I2C_PROSAVAGE
+	extern int i2c_prosavage_init(void);
+#endif
 EOF
       } elsif ($patch_nr = 2) {
       print OUTPUT << 'EOF';
@@ -1537,6 +1559,9 @@
 #ifdef CONFIG_I2C_VOODOO3
 	i2c_voodoo3_init();
 #endif
+#ifdef CONFIG_I2C_PROSAVAGE
+	i2c_prosavage_init();
+#endif
 #ifdef CONFIG_I2C_ISA
 	i2c_isa_init();
 #endif
