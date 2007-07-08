From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 12:26:37 +0000
Subject: [lm-sensors] [PATCH] i2c: Delete the i2c-isa pseudo bus driver
Message-Id: <20070708142637.7cdb7616@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

After thinking about it some more, I think it'll be much easier for
everyone if you take the patch killing i2c-isa in your hwmon tree, both
for the testing and later to send it to Linus for 2.6.23-rc1.

Thanks.

* * * * *

There are no users of i2c-isa left, so we can finally get rid of it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/feature-removal-schedule.txt |    9 -
 arch/arm/configs/badge4_defconfig          |    1 
 arch/arm/configs/clps7500_defconfig        |    1 
 arch/arm/configs/footbridge_defconfig      |    1 
 arch/arm/configs/neponset_defconfig        |    1 
 arch/arm/configs/picotux200_defconfig      |    1 
 arch/arm/configs/rpc_defconfig             |    1 
 arch/arm/configs/s3c2410_defconfig         |    1 
 arch/m32r/m32104ut/defconfig.m32104ut      |    1 
 arch/ppc/configs/ev64260_defconfig         |    1 
 arch/ppc/configs/mpc8540_ads_defconfig     |    1 
 arch/ppc/configs/mpc8548_cds_defconfig     |    1 
 arch/ppc/configs/mpc8555_cds_defconfig     |    1 
 arch/ppc/configs/mpc8560_ads_defconfig     |    1 
 arch/ppc/configs/radstone_ppc7d_defconfig  |    1 
 arch/ppc/configs/stx_gp3_defconfig         |    1 
 arch/ppc/configs/sycamore_defconfig        |    1 
 drivers/i2c/busses/Kconfig                 |    3 
 drivers/i2c/busses/Makefile                |    1 
 drivers/i2c/busses/i2c-isa.c               |  192 ----------------------------
 drivers/i2c/i2c-core.c                     |    2 
 include/linux/i2c-isa.h                    |   36 -----
 include/linux/i2c.h                        |    1 
 23 files changed, 260 deletions(-)

--- linux-2.6.22-rc7.orig/Documentation/feature-removal-schedule.txt	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/Documentation/feature-removal-schedule.txt	2007-07-08 14:04:47.000000000 +0200
@@ -181,15 +181,6 @@ Who:	Kay Sievers <kay.sievers@suse.de>
 
 ---------------------------
 
-What:	i2c-isa
-When:	December 2006
-Why:	i2c-isa is a non-sense and doesn't fit in the device driver
-	model. Drivers relying on it are better implemented as platform
-	drivers.
-Who:	Jean Delvare <khali@linux-fr.org>
-
----------------------------
-
 What:	i2c_adapter.list
 When:	July 2007
 Why:	Superfluous, this list duplicates the one maintained by the driver
--- linux-2.6.22-rc7.orig/arch/arm/configs/badge4_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/badge4_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -708,7 +708,6 @@ CONFIG_I2C_ALGOPCF=m
 # I2C Hardware Bus support
 #
 CONFIG_I2C_ELEKTOR=m
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_STUB is not set
--- linux-2.6.22-rc7.orig/arch/arm/configs/clps7500_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/clps7500_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -536,7 +536,6 @@ CONFIG_I2C_ALGOBIT=y
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_ELEKTOR is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PCA_ISA is not set
--- linux-2.6.22-rc7.orig/arch/arm/configs/footbridge_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/footbridge_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -748,7 +748,6 @@ CONFIG_I2C=m
 # CONFIG_I2C_ELEKTOR is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/arm/configs/neponset_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/neponset_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -698,7 +698,6 @@ CONFIG_I2C_ALGOBIT=y
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_ELEKTOR is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_PCA_ISA is not set
--- linux-2.6.22-rc7.orig/arch/arm/configs/picotux200_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/picotux200_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -735,7 +735,6 @@ CONFIG_I2C_CHARDEV=m
 # I2C Hardware Bus support
 #
 CONFIG_I2C_AT91=m
-CONFIG_I2C_ISA=m
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_STUB is not set
--- linux-2.6.22-rc7.orig/arch/arm/configs/rpc_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/rpc_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -558,7 +558,6 @@ CONFIG_I2C_ALGOBIT=y
 #
 # I2C Hardware Bus support
 #
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_STUB is not set
--- linux-2.6.22-rc7.orig/arch/arm/configs/s3c2410_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/arm/configs/s3c2410_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -826,7 +826,6 @@ CONFIG_I2C_ALGOBIT=m
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_ELEKTOR is not set
-CONFIG_I2C_ISA=m
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/m32r/m32104ut/defconfig.m32104ut	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/m32r/m32104ut/defconfig.m32104ut	2007-07-08 14:04:47.000000000 +0200
@@ -699,7 +699,6 @@ CONFIG_I2C_ALGOPCF=m
 # I2C Hardware Bus support
 #
 CONFIG_I2C_ELEKTOR=m
-CONFIG_I2C_ISA=m
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/ev64260_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/ev64260_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -531,7 +531,6 @@ CONFIG_I2C_CHARDEV=m
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PIIX4 is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/mpc8540_ads_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/mpc8540_ads_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -452,7 +452,6 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
-# CONFIG_I2C_ISA is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/mpc8548_cds_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/mpc8548_cds_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -413,7 +413,6 @@ CONFIG_I2C_CHARDEV=y
 #
 # I2C Hardware Bus support
 #
-# CONFIG_I2C_ISA is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PCA_ISA is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/mpc8555_cds_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/mpc8555_cds_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -518,7 +518,6 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
-# CONFIG_I2C_ISA is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/mpc8560_ads_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/mpc8560_ads_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -489,7 +489,6 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
-# CONFIG_I2C_ISA is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/radstone_ppc7d_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/radstone_ppc7d_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -710,7 +710,6 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/stx_gp3_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/stx_gp3_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -661,7 +661,6 @@ CONFIG_I2C_ALGOBIT=m
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT is not set
--- linux-2.6.22-rc7.orig/arch/ppc/configs/sycamore_defconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/arch/ppc/configs/sycamore_defconfig	2007-07-08 14:04:47.000000000 +0200
@@ -461,7 +461,6 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_IBM_IIC is not set
-# CONFIG_I2C_ISA is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PIIX4 is not set
--- linux-2.6.22-rc7.orig/drivers/i2c/busses/Kconfig	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/drivers/i2c/busses/Kconfig	2007-07-08 14:04:47.000000000 +0200
@@ -237,9 +237,6 @@ config I2C_IOP3XX
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-iop3xx.
 
-config I2C_ISA
-	tristate
-
 config I2C_IXP4XX
 	tristate "IXP4xx GPIO-Based I2C Interface (DEPRECATED)"
 	depends on ARCH_IXP4XX
--- linux-2.6.22-rc7.orig/drivers/i2c/busses/Makefile	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/drivers/i2c/busses/Makefile	2007-07-08 14:04:47.000000000 +0200
@@ -18,7 +18,6 @@ obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
-obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
 obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
 obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
--- linux-2.6.22-rc7.orig/drivers/i2c/busses/i2c-isa.c	2007-07-08 13:41:52.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,192 +0,0 @@
-/*
-    i2c-isa.c - an i2c-core-like thing for ISA hardware monitoring chips
-    Copyright (C) 2005  Jean Delvare <khali@linux-fr.org>
-
-    Based on the i2c-isa pseudo-adapter from the lm_sensors project
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-/* This implements an i2c-core-like thing for ISA hardware monitoring
-   chips. Such chips are linked to the i2c subsystem for historical
-   reasons (because the early ISA hardware monitoring chips such as the
-   LM78 had both an I2C and an ISA interface). They used to be
-   registered with the main i2c-core, but as a first step in the
-   direction of a clean separation between I2C and ISA chip drivers,
-   we now have this separate core for ISA ones. It is significantly
-   more simple than the real one, of course, because we don't have to
-   handle multiple busses: there is only one (fake) ISA adapter.
-   It is worth noting that we still rely on i2c-core for some things
-   at the moment - but hopefully this won't last. */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
-#include <linux/platform_device.h>
-#include <linux/completion.h>
-
-/* Exported by i2c-core for i2c-isa only */
-extern void i2c_adapter_dev_release(struct device *dev);
-extern struct class i2c_adapter_class;
-
-static u32 isa_func(struct i2c_adapter *adapter);
-
-/* This is the actual algorithm we define */
-static const struct i2c_algorithm isa_algorithm = {
-	.functionality	= isa_func,
-};
-
-/* There can only be one... */
-static struct i2c_adapter isa_adapter = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_HW_ISA,
-	.class          = I2C_CLASS_HWMON,
-	.algo		= &isa_algorithm,
-	.name		= "ISA main adapter",
-};
-
-/* We can't do a thing... */
-static u32 isa_func(struct i2c_adapter *adapter)
-{
-	return 0;
-}
-
-
-/* We implement an interface which resembles i2c_{add,del}_driver,
-   but for i2c-isa drivers. We don't have to remember and handle lists
-   of drivers and adapters so this is much more simple, of course. */
-
-int i2c_isa_add_driver(struct i2c_driver *driver)
-{
-	int res;
-
-	/* Add the driver to the list of i2c drivers in the driver core */
-	driver->driver.bus = &i2c_bus_type;
-	res = driver_register(&driver->driver);
-	if (res)
-		return res;
-	dev_dbg(&isa_adapter.dev, "Driver %s registered\n", driver->driver.name);
-
-	/* Now look for clients */
-	res = driver->attach_adapter(&isa_adapter);
-	if (res) {
-		dev_dbg(&isa_adapter.dev,
-			"Driver %s failed to attach adapter, unregistering\n",
-			driver->driver.name);
-		driver_unregister(&driver->driver);
-	}
-	return res;
-}
-
-int i2c_isa_del_driver(struct i2c_driver *driver)
-{
-	struct list_head *item, *_n;
-	struct i2c_client *client;
-	int res;
-
-	/* Detach all clients belonging to this one driver */
-	list_for_each_safe(item, _n, &isa_adapter.clients) {
-		client = list_entry(item, struct i2c_client, list);
-		if (client->driver != driver)
-			continue;
-		dev_dbg(&isa_adapter.dev, "Detaching client %s at 0x%x\n",
-			client->name, client->addr);
-		if ((res = driver->detach_client(client))) {
-			dev_err(&isa_adapter.dev, "Failed, driver "
-				"%s not unregistered!\n",
-				driver->driver.name);
-			return res;
-		}
-	}
-
-	/* Get the driver off the core list */
-	driver_unregister(&driver->driver);
-	dev_dbg(&isa_adapter.dev, "Driver %s unregistered\n", driver->driver.name);
-
-	return 0;
-}
-
-
-static int __init i2c_isa_init(void)
-{
-	int err;
-
-	mutex_init(&isa_adapter.clist_lock);
-	INIT_LIST_HEAD(&isa_adapter.clients);
-
-	isa_adapter.nr = ANY_I2C_ISA_BUS;
-	isa_adapter.dev.parent = &platform_bus;
-	sprintf(isa_adapter.dev.bus_id, "i2c-%d", isa_adapter.nr);
-	isa_adapter.dev.release = &i2c_adapter_dev_release;
-	isa_adapter.dev.class = &i2c_adapter_class;
-	err = device_register(&isa_adapter.dev);
-	if (err) {
-		printk(KERN_ERR "i2c-isa: Failed to register device\n");
-		goto exit;
-	}
-
-	dev_dbg(&isa_adapter.dev, "%s registered\n", isa_adapter.name);
-
-	return 0;
-
-exit:
-	return err;
-}
-
-static void __exit i2c_isa_exit(void)
-{
-#ifdef DEBUG
-	struct list_head  *item, *_n;
-	struct i2c_client *client = NULL;
-#endif
-
-	/* There should be no more active client */
-#ifdef DEBUG
-	dev_dbg(&isa_adapter.dev, "Looking for clients\n");
-	list_for_each_safe(item, _n, &isa_adapter.clients) {
-		client = list_entry(item, struct i2c_client, list);
-		dev_err(&isa_adapter.dev, "Driver %s still has an active "
-			"ISA client at 0x%x\n", client->driver->driver.name,
-			client->addr);
-	}
-	if (client != NULL)
-		return;
-#endif
-
-	/* Clean up the sysfs representation */
-	dev_dbg(&isa_adapter.dev, "Unregistering from sysfs\n");
-	init_completion(&isa_adapter.dev_released);
-	device_unregister(&isa_adapter.dev);
-
-	/* Wait for sysfs to drop all references */
-	dev_dbg(&isa_adapter.dev, "Waiting for sysfs completion\n");
-	wait_for_completion(&isa_adapter.dev_released);
-
-	dev_dbg(&isa_adapter.dev, "%s unregistered\n", isa_adapter.name);
-}
-
-EXPORT_SYMBOL(i2c_isa_add_driver);
-EXPORT_SYMBOL(i2c_isa_del_driver);
-
-MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
-MODULE_DESCRIPTION("ISA bus access through i2c");
-MODULE_LICENSE("GPL");
-
-module_init(i2c_isa_init);
-module_exit(i2c_isa_exit);
--- linux-2.6.22-rc7.orig/drivers/i2c/i2c-core.c	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/drivers/i2c/i2c-core.c	2007-07-08 14:04:47.000000000 +0200
@@ -288,7 +288,6 @@ void i2c_adapter_dev_release(struct devi
 	struct i2c_adapter *adap = to_i2c_adapter(dev);
 	complete(&adap->dev_released);
 }
-EXPORT_SYMBOL_GPL(i2c_adapter_dev_release);	/* exported to i2c-isa */
 
 static ssize_t
 show_adapter_name(struct device *dev, struct device_attribute *attr, char *buf)
@@ -307,7 +306,6 @@ struct class i2c_adapter_class = {
 	.name			= "i2c-adapter",
 	.dev_attrs		= i2c_adapter_attrs,
 };
-EXPORT_SYMBOL_GPL(i2c_adapter_class);		/* exported to i2c-isa */
 
 static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 {
--- linux-2.6.22-rc7.orig/include/linux/i2c-isa.h	2007-07-08 13:41:52.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,36 +0,0 @@
-/*
- * i2c-isa.h - definitions for the i2c-isa pseudo-i2c-adapter interface
- *
- * Copyright (C) 2005 Jean Delvare <khali@linux-fr.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef _LINUX_I2C_ISA_H
-#define _LINUX_I2C_ISA_H
-
-#include <linux/i2c.h>
-
-extern int i2c_isa_add_driver(struct i2c_driver *driver);
-extern int i2c_isa_del_driver(struct i2c_driver *driver);
-
-/* Detect whether we are on the isa bus. This is only useful to hybrid
-   (i2c+isa) drivers. */
-#define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->id = I2C_HW_ISA)
-#define i2c_is_isa_client(clientptr) \
-        i2c_is_isa_adapter((clientptr)->adapter)
-
-#endif /* _LINUX_I2C_ISA_H */
--- linux-2.6.22-rc7.orig/include/linux/i2c.h	2007-07-08 13:41:52.000000000 +0200
+++ linux-2.6.22-rc7/include/linux/i2c.h	2007-07-08 14:04:47.000000000 +0200
@@ -368,7 +368,6 @@ struct i2c_client_address_data {
 
 /* The numbers to use to set I2C bus address */
 #define ANY_I2C_BUS		0xffff
-#define ANY_I2C_ISA_BUS		9191
 
 
 /* ----- functions exported by i2c.o */

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
