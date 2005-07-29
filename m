From: icampbell@arcom.com (Ian Campbell)
Date: Fri, 29 Jul 2005 12:16:28 +0000
Subject: [lm-sensors] [PATCH] GPIO bit bang driver for Xscale/ARM PXA2xx
Message-Id: <1122632146.19718.94.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The following contains a GPIO based bit bang driver in the same vein as
drivers/i2c/busses/i2c-ixp{4xx,2000}.c.

As the commentary in the patch says, there is a hardware i2c controller
on the PXA2xx so I don't know if this patch would see widespread use.
Since the platform I use it on is not intended for merging you might
reasonably choose not to merge but I thought I'd at least put it out so
it would be available. If you do want to merge it I'll be happy to let
you though ;-)

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/i2c/busses/Kconfig
=================================--- 2.6.orig/drivers/i2c/busses/Kconfig	2005-07-29 10:30:42.000000000 +0100
+++ 2.6/drivers/i2c/busses/Kconfig	2005-07-29 10:31:21.000000000 +0100
@@ -152,6 +152,17 @@
 	tristate "Intel PXA2XX I2C Slave comms support"
 	depends on I2C_PXA
 
+config I2C_PXA2XX_GPIO
+	tristate "PXA2xx GPIO-Based I2C Interface"
+	depends on I2C && ARCH_PXA
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have an Intel PXA2xx based system and are using
+	  GPIO lines for an I2C bus.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-pxa2xx-gpio.
+
 config I2C_PIIX4
 	tristate "Intel PIIX4"
 	depends on I2C && PCI
Index: 2.6/drivers/i2c/busses/Makefile
=================================--- 2.6.orig/drivers/i2c/busses/Makefile	2005-07-29 10:30:42.000000000 +0100
+++ 2.6/drivers/i2c/busses/Makefile	2005-07-29 10:31:21.000000000 +0100
@@ -29,6 +29,7 @@
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
+obj-$(CONFIG_I2C_PXA2XX_GPIO)	+= i2c-pxa2xx-gpio.o
 obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
 obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
Index: 2.6/drivers/i2c/busses/i2c-pxa2xx-gpio.c
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6/drivers/i2c/busses/i2c-pxa2xx-gpio.c	2005-07-29 10:55:16.000000000 +0100
@@ -0,0 +1,164 @@
+/* The PXA2xx processors have an i2c controller on chip, however it is
+ * not always possible to use this controller or you may require more
+ * than one i2c bus for your platform. It is possible to create
+ * additional i2c busses using two GPIO lines.
+ *
+ * To use this driver you should create a platform device in your
+ * platform code:
+ *
+ *	static struct i2c_pxa2xx_gpio_pins i2c_bus_data = {
+ *		.name = "i2c",
+ *		.sda = XX, .scl = YY,
+ *	};
+ *	static struct platform_device i2c_bus_device = {
+ *		.name		= "pxa2xx-gpio-i2c",
+ *		.id		= 0,
+ *		.num_resources	= 0,
+ *		.dev = {
+ *			.platform_data = &i2c_bus_data,
+ *		}
+ *	};
+ *	[...]
+ *	static void __init platform_init(void)
+ *	{
+ *		[...]
+ *		platform_device_register(&i2c_bus_device);
+ *		[...]
+ *	}
+ *
+ * Copyright (c) 2005 Arcom Control Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/i2c-gpio.h>
+
+#include <asm/hardware.h>
+
+static void pxa2xx_gpio_setscl(void *data, int state)
+{
+	struct i2c_pxa2xx_gpio_pins *pins = data;
+	if (state)
+		GPSR(pins->scl) = GPIO_bit(pins->scl);
+	else
+		GPCR(pins->scl) = GPIO_bit(pins->scl);
+}
+
+static void pxa2xx_gpio_setsda(void *data, int state)
+{
+	struct i2c_pxa2xx_gpio_pins *pins = data;
+	if (state)
+		pxa_gpio_mode(pins->sda | GPIO_IN | GPIO_DFLT_LOW);
+	else
+		pxa_gpio_mode(pins->sda | GPIO_OUT | GPIO_DFLT_LOW);
+}
+
+static int pxa2xx_gpio_getscl(void *data)
+{
+	struct i2c_pxa2xx_gpio_pins *pins = data;
+	return GPLR(pins->scl) & GPIO_bit(pins->scl);
+}
+
+static int pxa2xx_gpio_getsda(void *data)
+{
+	struct i2c_pxa2xx_gpio_pins *pins = data;
+	pxa_gpio_mode(pins->sda | GPIO_IN);
+	return GPLR(pins->sda) & GPIO_bit(pins->sda);
+}
+
+struct pxa2xx_gpio_i2c_drvdata {
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo_data;
+};
+
+static int pxa2xx_gpio_i2c_probe(struct device *dev)
+{
+	int err;
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct pxa2xx_gpio_i2c_drvdata *drv_data +		kmalloc(sizeof(struct pxa2xx_gpio_i2c_drvdata), GFP_KERNEL);
+	struct i2c_pxa2xx_gpio_pins *pins = dev->platform_data;
+
+	if (!drv_data)
+		return -ENOMEM;
+
+	memzero(drv_data, sizeof(*drv_data));
+
+	drv_data->algo_data.data	= pins;
+	drv_data->algo_data.setsda	= pxa2xx_gpio_setsda;
+	drv_data->algo_data.setscl	= pxa2xx_gpio_setscl;
+	drv_data->algo_data.getsda	= pxa2xx_gpio_getsda;
+	drv_data->algo_data.getscl	= pxa2xx_gpio_getscl;
+	drv_data->algo_data.udelay	= 10;
+	drv_data->algo_data.mdelay	= 10;
+	drv_data->algo_data.timeout	= 100;
+
+	drv_data->adapter.id = 0xf000; /* fixme */
+	drv_data->adapter.algo_data = &drv_data->algo_data;
+
+	strcpy(drv_data->adapter.name, pins->name);
+
+	drv_data->adapter.dev.parent = &plat_dev->dev;
+
+	pxa_gpio_mode(pins->sda | GPIO_OUT | GPIO_DFLT_HIGH);
+	pxa_gpio_mode(pins->scl | GPIO_OUT | GPIO_DFLT_HIGH);
+
+	if ((err = i2c_bit_add_bus(&drv_data->adapter) != 0)) {
+		printk(KERN_ERR "ERROR: Could not install %s\n", dev->bus_id);
+		kfree(drv_data);
+		return err;
+	}
+
+	dev_set_drvdata(&plat_dev->dev, drv_data);
+
+	return 0;
+}
+
+static int pxa2xx_gpio_i2c_remove(struct device *dev)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct pxa2xx_gpio_i2c_drvdata *drv_data = dev_get_drvdata(&plat_dev->dev);
+
+	dev_set_drvdata(&plat_dev->dev, NULL);
+
+	i2c_bit_del_bus(&drv_data->adapter);
+
+	kfree(drv_data);
+
+	return 0;
+}
+
+static struct device_driver pxa2xx_gpio_i2c_driver = {
+	.name	= "pxa2xx-gpio-i2c",
+	.bus	= &platform_bus_type,
+	.probe	= pxa2xx_gpio_i2c_probe,
+	.remove	= pxa2xx_gpio_i2c_remove,
+};
+
+static int __init pxa2xx_gpio_i2c_init(void)
+{
+	return driver_register(&pxa2xx_gpio_i2c_driver);
+}
+
+static void __exit pxa2xx_gpio_i2c_exit(void)
+{
+	driver_unregister(&pxa2xx_gpio_i2c_driver);
+}
+
+module_init(pxa2xx_gpio_i2c_init);
+module_exit(pxa2xx_gpio_i2c_exit);
+
+MODULE_AUTHOR("Ian Campbell <icampbell@arcom.com>");
+MODULE_DESCRIPTION("i2c bus adapter routines for pxa2xx gpio lines");
+MODULE_LICENSE("GPL");
Index: 2.6/include/asm-arm/arch-pxa/i2c-gpio.h
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6/include/asm-arm/arch-pxa/i2c-gpio.h	2005-07-29 10:32:13.000000000 +0100
@@ -0,0 +1,10 @@
+#ifndef _INCLUDE_ASM_ARCH_I2C_GPIO_H_
+#define _INCLUDE_ASM_ARCH_I2C_GPIO_H_
+
+struct i2c_pxa2xx_gpio_pins {
+	const char *name;
+	unsigned sda;
+	unsigned scl;
+};
+
+#endif

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

