From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Add support for Intel IXP42x GPIO-based I2C
Message-Id: <20040213235906.GA5551@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Greg,

The following patch against Linus' BK tree adds a driver for using GPIO 
pins on Intel's IXP42x ARM SOCs for an I2C interface.  

Tnx,
~Deepak

diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri Feb 13 16:56:09 2004
+++ b/drivers/i2c/busses/Kconfig	Fri Feb 13 16:56:09 2004
@@ -144,6 +144,17 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-ite.
 
+config I2C_IXP42X
+	tristate "IXP42x GPIO-Based I2C Interface"
+	depends on I2C && ARCH_IXP425
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have an Intel IXP42x(420,421,422,425) based 
+	  system and are using GPIO lines for an I2C bus.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-ixp42x.
+
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
 	depends on I2C && PPC_PMAC
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Fri Feb 13 16:56:09 2004
+++ b/drivers/i2c/busses/Makefile	Fri Feb 13 16:56:09 2004
@@ -15,6 +15,7 @@
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
+obj-$(CONFIG_I2C_IXP42X)	+= i2c-ixp42x.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
diff -Nru a/drivers/i2c/busses/i2c-ixp42x.c b/drivers/i2c/busses/i2c-ixp42x.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-ixp42x.c	Fri Feb 13 16:56:09 2004
@@ -0,0 +1,170 @@
+/*
+ * drivers/i2c/i2c-adap-ixp425.c
+ *
+ * Driver for gpio-based i2c adapter on Intel IXP42x systems.
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright (c) 2003-2004 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public 
+ * License version 2. This program is licensed "as is" without any 
+ * warranty of any kind, whether express or implied.
+ *
+ * NOTE: Do NOT add board specific hooks here. All that belongs in platform
+ *       specific code in arch/arm/mach-ixp425/your_platform.c. See 
+ *       arch/arm/mach-ixp425/ixdp425.c for an example of building a 
+ *       device list and filling in the ixp425_i2c_pins data structure 
+ *       that is passed as the platform_data to this driver.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/i2c-id.h>
+
+#include <asm/hardware.h>
+
+static inline int ixp425_scl_pin(void *data)
+{
+	return ((struct ixp425_i2c_pins*)data)->scl_pin;
+}
+
+static inline int ixp425_sda_pin(void *data)
+{
+	return ((struct ixp425_i2c_pins*)data)->sda_pin;
+}
+
+static void ixdp425_bit_setscl(void *data, int val)
+{
+	gpio_line_set(ixp425_scl_pin(data), 0);
+	gpio_line_config(ixp425_scl_pin(data),
+		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
+}
+
+static void ixdp425_bit_setsda(void *data, int val)
+{
+	gpio_line_set(ixp425_sda_pin(data), 0);
+	gpio_line_config(ixp425_sda_pin(data),
+		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
+}
+
+static int ixdp425_bit_getscl(void *data)
+{
+	int scl;
+
+	gpio_line_config(ixp425_scl_pin(data), IXP425_GPIO_IN );
+	gpio_line_get(ixp425_scl_pin(data), &scl);
+
+	return scl;
+}	
+
+static int ixdp425_bit_getsda(void *data)
+{
+	int sda;
+
+	gpio_line_config(ixp425_sda_pin(data), IXP425_GPIO_IN );
+	gpio_line_get(ixp425_sda_pin(data), &sda);
+
+	return sda;
+}	
+
+struct ixp425_i2c_data {
+	struct ixp425_i2c_pins *gpio_pins;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo_data;
+};
+
+static int ixp425_i2c_remove(struct device *dev)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct ixp425_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
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
+static int ixp425_i2c_probe(struct device *dev)
+{
+	int err;
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct ixp425_i2c_pins *gpio = plat_dev->dev.platform_data;
+	struct ixp425_i2c_data *drv_data = 
+		kmalloc(sizeof(struct ixp425_i2c_data), GFP_KERNEL);
+
+	if(!drv_data)
+		return -ENOMEM;
+
+	memzero(drv_data, sizeof(struct ixp425_i2c_data));
+	drv_data->gpio_pins = gpio;
+
+	/*
+	 * We could make a lot of these structures static, but
+	 * certain platforms may have multiple GPIO-based I2C
+	 * buses for various device domains, so we need per-device
+	 * algo_data->data. 
+	 */
+	drv_data->algo_data.data = gpio;
+	drv_data->algo_data.setsda = ixdp425_bit_setsda;
+	drv_data->algo_data.setscl = ixdp425_bit_setscl;
+	drv_data->algo_data.getsda = ixdp425_bit_getsda;
+	drv_data->algo_data.getscl = ixdp425_bit_getscl;
+	drv_data->algo_data.udelay = 10;
+	drv_data->algo_data.mdelay = 10;
+	drv_data->algo_data.timeout = 100;
+
+	drv_data->adapter.id = I2C_HW_B_IXP425,
+	drv_data->adapter.algo_data = &drv_data->algo_data,
+
+	drv_data->adapter.dev.parent = &plat_dev->dev;
+
+	gpio_line_config(gpio->scl_pin, IXP425_GPIO_IN);
+	gpio_line_config(gpio->sda_pin, IXP425_GPIO_IN);
+	gpio_line_set(gpio->scl_pin, 0);
+	gpio_line_set(gpio->sda_pin, 0);
+
+	if ((err = i2c_bit_add_bus(&drv_data->adapter) != 0)) {
+		printk(KERN_ERR "ERROR: Could not install %s\n", dev->bus_id);
+
+		kfree(drv_data);
+		return err;
+	}
+
+	dev_set_drvdata(&plat_dev->dev, drv_data);
+
+	return 0;
+}
+
+static struct device_driver ixp425_i2c_driver = {
+	.name		= "IXP425-I2C",
+	.bus		= &platform_bus_type,
+	.probe		= ixp425_i2c_probe,
+	.remove		= ixp425_i2c_remove,
+};
+
+static int __init ixp425_i2c_init(void)
+{
+	return driver_register(&ixp425_i2c_driver);
+}
+
+static void __exit ixp425_i2c_exit(void)
+{
+	driver_unregister(&ixp425_i2c_driver);
+}
+
+module_init(ixp425_i2c_init);
+module_exit(ixp425_i2c_exit);
+
+MODULE_DESCRIPTION("GPIO-based I2C adapter for IXP425 systems");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Deepak Saxena<dsaxena@plexity.net>");
+

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
