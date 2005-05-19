From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <Pine.GSO.4.21.0308241307070.14784-100000@waterleaf.sonytel.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 23 Aug 2003, Greg KH wrote:
> On Thu, Aug 21, 2003 at 06:02:53PM +0200, Geert Uytterhoeven wrote:
> > On Thu, 21 Aug 2003, Greg KH wrote:
> > > On Thu, Aug 21, 2003 at 11:34:32AM +0200, Geert Uytterhoeven wrote:
> > > > Hmm... And all I have on the i2c bus is the SPD EEPROMs on my SDRAM DIMMs.
> > > > AFAIK there's no kernel `driver' for these?
> > > 
> > > There's one in my bk tree, but it's not "correct" and I haven't taken
> > > the time to fix it up in order to get it into shape for submission to
> > > the main kernel.
> > > 
> > > If you want, I can send a patch so you can test with.
> > 
> > Please do so, thanks!
> 
> Oops, forgot to send this out, sorry for the delay.
> 
> Here's a patch against 2.6.0-test3.  It should work just fine against
> 2.6.0-test4 too.  Let me know if you have any problems.

Thanks!

After applying this additional patch (BTW, can't this be done using Kconfig's
`select'?):

--- linux-ppc-2.6.0-test3/drivers/i2c/chips/Kconfig.orig	Mon Aug 11 02:21:29 2003
+++ linux-longtrail-2.6.0-test3/drivers/i2c/chips/Kconfig	Sun Aug 24 12:41:01 2003
@@ -119,8 +119,8 @@
 
 config I2C_SENSOR
 	tristate
-	default y if SENSORS_ADM1021=y || SENSORS_IT87=y || SENSORS_LM75=y || SENSORS_VIA686A=y || SENSORS_W83781D=y || SENSORS_LM85=y
-	default m if SENSORS_ADM1021=m || SENSORS_IT87=m || SENSORS_LM75=m || SENSORS_VIA686A=m || SENSORS_W83781D=m || SENSORS_LM85=m
+	default y if SENSORS_ADM1021=y || SENSORS_IT87=y || SENSORS_LM75=y || SENSORS_VIA686A=y || SENSORS_W83781D=y || SENSORS_LM85=y || SENSORS_EEPROM=y
+	default m if SENSORS_ADM1021=m || SENSORS_IT87=m || SENSORS_LM75=m || SENSORS_VIA686A=m || SENSORS_W83781D=m || SENSORS_LM85=m || SENSORS_EEPROM=m
 	default n
 
 endmenu

it links and detects 2 EEPROMs (0-0051 and 0-0052), so I guess the Hydra i2c
driver is working.

The Hydra i2c driver patch is below. BTW, it shows up as a legacy i2c device in
sysfs.  How can I link it to the Hydra's PCI device in sysfs?

--- linux-ppc-2.6.0-test3/drivers/i2c/i2c-hydra.c.orig	Sun Aug 17 12:07:47 2003
+++ linux-longtrail-2.6.0-test3/drivers/i2c/i2c-hydra.c	Sun Aug 17 12:36:09 2003
@@ -0,0 +1,173 @@
+/*
+    i2c-hydra.c - Part of lm_sensors,  Linux kernel modules
+                  for hardware monitoring
+
+    i2c Support for the Apple `Hydra' Mac I/O
+
+    Copyright (c) 1999-2003 Geert Uytterhoeven <geert@linux-m68k.org>
+
+    Based on i2c Support for Via Technologies 82C586B South Bridge
+    Copyright (c) 1998, 1999 Ky?sti M?lkki <kmalkki@cc.hut.fi>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+MODULE_LICENSE("GPL");
+
+
+#define HYDRA_CACHE_PD	0x00000030
+
+#define HYDRA_CPD_PD0	0x00000001	/* CachePD lines */
+#define HYDRA_CPD_PD1	0x00000002
+#define HYDRA_CPD_PD2	0x00000004
+#define HYDRA_CPD_PD3	0x00000008
+
+#define HYDRA_SCLK	HYDRA_CPD_PD0
+#define HYDRA_SDAT	HYDRA_CPD_PD1
+#define HYDRA_SCLK_OE	0x00000010
+#define HYDRA_SDAT_OE	0x00000020
+
+static inline void pdregw(void *hydra_base, u32 val)
+{
+	writel(val, (unsigned long)hydra_base + HYDRA_CACHE_PD);
+}
+
+static inline u32 pdregr(void *hydra_base)
+{
+	u32 val = readl((unsigned long)hydra_base + HYDRA_CACHE_PD);
+	return val;
+}
+
+static void hydra_bit_setscl(void *hydra_base, int state)
+{
+	u32 val = pdregr(hydra_base);
+	if (state)
+		val &= ~HYDRA_SCLK_OE;
+	else {
+		val &= ~HYDRA_SCLK;
+		val |= HYDRA_SCLK_OE;
+	}
+	pdregw(hydra_base, val);
+	pdregr(hydra_base);	/* flush posted write */
+}
+
+static void hydra_bit_setsda(void *hydra_base, int state)
+{
+	u32 val = pdregr(hydra_base);
+	if (state)
+		val &= ~HYDRA_SDAT_OE;
+	else {
+		val &= ~HYDRA_SDAT;
+		val |= HYDRA_SDAT_OE;
+	}
+	pdregw(hydra_base, val);
+	pdregr(hydra_base);	/* flush posted write */
+}
+
+static int hydra_bit_getscl(void *hydra_base)
+{
+	return (pdregr(hydra_base) & HYDRA_SCLK) != 0;
+}
+
+static int hydra_bit_getsda(void *hydra_base)
+{
+	return (pdregr(hydra_base) & HYDRA_SDAT) != 0;
+}
+
+/* ------------------------------------------------------------------------ */
+
+static struct i2c_algo_bit_data hydra_bit_data = {
+	.setsda		= hydra_bit_setsda,
+	.setscl		= hydra_bit_setscl,
+	.getsda		= hydra_bit_getsda,
+	.getscl		= hydra_bit_getscl,
+	.udelay		= 5,
+	.mdelay		= 5,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter hydra_adap = {
+	.owner		= THIS_MODULE,
+	.name		= "Hydra i2c",
+	.id		= I2C_HW_B_HYDRA,
+	.algo_data	= &hydra_bit_data,
+};
+
+static struct pci_device_id hydra_ids[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_APPLE,
+		.device		= PCI_DEVICE_ID_APPLE_HYDRA,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{ 0, }
+};
+
+static int __devinit hydra_probe(struct pci_dev *dev,
+				 const struct pci_device_id *id)
+{
+	unsigned int base_addr;
+
+	base_addr = dev->resource[0].start;
+	hydra_bit_data.data = ioremap(base_addr, 0x100);
+
+	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */
+	return i2c_bit_add_bus(&hydra_adap);
+}
+
+static void __devexit hydra_remove(struct pci_dev *dev)
+{
+	pdregw(hydra_bit_data.data, 0);	/* clear SCLK_OE and SDAT_OE */
+	i2c_bit_del_bus(&hydra_adap);
+}
+
+
+static struct pci_driver hydra_driver = {
+	.name		= "hydra smbus",
+	.id_table	= hydra_ids,
+	.probe		= hydra_probe,
+	.remove		= __devexit_p(hydra_remove),
+};
+
+static int __init i2c_hydra_init(void)
+{
+	return pci_module_init(&hydra_driver);
+}
+
+
+static void __exit i2c_hydra_exit(void)
+{
+	pci_unregister_driver(&hydra_driver);
+	iounmap(hydra_bit_data.data);
+}
+
+
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert@linux-m68k.org>");
+MODULE_DESCRIPTION("i2c for Apple Hydra Mac I/O");
+
+module_init(i2c_hydra_init);
+module_exit(i2c_hydra_exit);
+
--- linux-ppc-2.6.0-test3/drivers/i2c/Makefile.orig	Mon Aug 11 02:20:37 2003
+++ linux-longtrail-2.6.0-test3/drivers/i2c/Makefile	Sun Aug 17 12:14:24 2003
@@ -19,4 +19,5 @@
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
+obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-y				+= busses/ chips/
--- linux-ppc-2.6.0-test3/drivers/i2c/Kconfig.orig	Mon Aug 11 02:20:58 2003
+++ linux-longtrail-2.6.0-test3/drivers/i2c/Kconfig	Sun Aug 17 12:23:11 2003
@@ -211,6 +211,18 @@
 	tristate "Intel XScale IOP3xx on-chip I2C interface"
 	depends on ARCH_IOP3XX && I2C
 
+config I2C_HYDRA
+	tristate "CHRP Apple Hydra Mac I/O I2C interface"
+	depends on I2C_ALGOBIT && PCI && PPC_CHRP && EXPERIMENTAL
+	help
+	  This supports the use of the I2C interface in the Apple Hydra Mac
+	  I/O chip on some CHRP machines (e.g. the LongTrail).  Say Y if you
+	  have such a machine.
+
+	  This driver is also available as a module.  If you want to compile
+	  it as a module, say M here and read Documentation/modules.txt.
+	  The module will be called i2c-hydra.
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	depends on I2C

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
