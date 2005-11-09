From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 09 Nov 2005 00:55:16 +0000
Subject: [lm-sensors] i2c-simtec platform driver
Message-Id: <20051108235403.GA23645@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver for the new range of boards from Simtec Electronics
which use an simple bitwise gpio i2c implementation in an
memory mapped CPLD

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
--- linux-2.6.14-git10/drivers/i2c/busses/Makefile	2005-10-28 11:28:29.000000000 +0100
+++ linux-2.6.14-simtec2p1/drivers/i2c/busses/Makefile	2005-10-31 16:50:32.000000000 +0000
@@ -34,6 +34,7 @@ obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
 obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
+obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
--- linux-2.6.14-git10/drivers/i2c/busses/Kconfig	2005-11-07 15:07:25.000000000 +0000
+++ linux-2.6.14-simtec2p1/drivers/i2c/busses/Kconfig	2005-11-07 15:01:53.000000000 +0000
@@ -369,6 +369,19 @@ config I2C_SIBYTE
 	help
 	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).
 
+config I2C_SIMTEC
+	tristate "Simtec Generic I2C interface"
+	depends on I2C
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be inclyded for
+	  the Simtec Generic I2C interface. This driver is for the
+	  simple I2C bus used on newer Simtec products for general
+	  I2C, such as DDC on the Simtec BBD2016A.
+
+	  This driver can also be build as a module. If so, the module
+	  will be called i2c-simtec.
+
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
 	depends on SCx200_GPIO && I2C
--- linux-2.6.14-git10/drivers/i2c/busses/i2c-simtec.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-simtec2p1/drivers/i2c/busses/i2c-simtec.c	2005-11-08 10:36:28.000000000 +0000
@@ -0,0 +1,201 @@
+/* linux/drivers/i2c/busses/i2c-simtec.c
+ *
+ * Copyright (C) 2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Simtec Generic I2C Controller
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+struct simtec_i2c_data {
+	struct resource		*ioarea;
+	void __iomem		*reg;
+	struct i2c_adapter	 adap;
+	struct i2c_algo_bit_data bit;
+};
+
+#define CMD_SET_SDA	(1<<2)
+#define CMD_SET_SCL	(1<<3)
+
+#define STATE_SDA	(1<<0)
+#define STATE_SCL	(1<<1)
+
+/* i2c bit-bus functions */
+
+static void simtec_i2c_setsda(void *pw, int state)
+{
+	struct simtec_i2c_data *pd = pw;
+	writeb(CMD_SET_SDA | (state ? STATE_SDA : 0), pd->reg);
+}
+
+static void simtec_i2c_setscl(void *pw, int state)
+{
+	struct simtec_i2c_data *pd = pw;
+	writeb(CMD_SET_SCL | (state ? STATE_SCL : 0), pd->reg);
+}
+
+static int simtec_i2c_getsda(void *pw)
+{
+	struct simtec_i2c_data *pd = pw;
+	return readb(pd->reg) & STATE_SDA ? 1 : 0;
+}
+
+static int simtec_i2c_getscl(void *pw)
+{
+	struct simtec_i2c_data *pd = pw;
+	return readb(pd->reg) & STATE_SCL ? 1 : 0;
+}
+
+/* device registration */
+
+static int simtec_i2c_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct simtec_i2c_data *pd;
+	struct resource *res;
+	int size;
+	int ret;
+
+	pd = kzalloc(sizeof(struct simtec_i2c_data), GFP_KERNEL);
+	if (pd = NULL) {
+		dev_err(dev, "cannot allocate private data\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, pd);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res = NULL) {
+		dev_err(dev, "cannot find IO resource\n");
+		ret = -ENOENT;
+		goto exit_err;
+	}
+
+	size = (res->end-res->start)+1;
+
+	pd->ioarea = request_mem_region(res->start, size, pdev->name);
+
+	if (pd->ioarea = NULL) {
+		dev_err(dev, "cannot request IO\n");
+		ret = -ENXIO;
+		goto exit_err;
+	}
+
+	pd->reg = ioremap(res->start, size);
+
+	if (pd->reg = NULL) {
+		dev_err(dev, "cannot map IO\n");
+		ret = -ENXIO;
+		goto exit_err_res;
+	}
+
+	/* setup the private data */
+
+	pd->adap.owner      = THIS_MODULE;
+	pd->adap.algo_data  = &pd->bit;
+	pd->adap.dev.parent = dev;
+
+	strlcpy(pd->adap.name, "Simtec I2C", sizeof(pd->adap.name));
+
+	pd->bit.data	    = pd;
+	pd->bit.setsda	    = simtec_i2c_setsda;
+	pd->bit.setscl	    = simtec_i2c_setscl;
+	pd->bit.getsda	    = simtec_i2c_getsda;
+	pd->bit.getscl	    = simtec_i2c_getscl;
+	pd->bit.timeout	    = HZ;
+	pd->bit.udelay	    = 20;
+
+	ret = i2c_bit_add_bus(&pd->adap);
+	if (ret)
+		goto exit_err_all;
+
+	return 0;
+
+ exit_err_all:
+	iounmap(pd->reg);
+
+ exit_err_res:
+	release_resource(pd->ioarea);
+	kfree(pd->ioarea);
+
+ exit_err:
+	kfree(pd);
+	return ret;
+}
+
+static int simtec_i2c_remove(struct device *dev)
+{
+	struct simtec_i2c_data *pd = dev_get_drvdata(dev);
+
+	if (pd) {
+		i2c_bit_del_bus(&pd->adap);
+
+		if (pd->reg) {
+			iounmap(pd->reg);
+			pd->reg = NULL;
+		}
+
+		if (pd->ioarea) {
+			release_resource(pd->ioarea);
+			kfree(pd->ioarea);
+			pd->ioarea = NULL;
+		}
+
+		kfree(pd);
+	}
+
+	return 0;
+}
+
+
+/* device driver */
+
+static struct device_driver simtec_i2c_driver = {
+	.name		= "simtec-i2c",
+	.owner		= THIS_MODULE,
+	.bus		= &platform_bus_type,
+	.probe		= simtec_i2c_probe,
+	.remove		= simtec_i2c_remove,
+};
+
+static int __init i2c_adap_simtec_init(void)
+{
+	return driver_register(&simtec_i2c_driver);
+}
+
+static void __exit i2c_adap_simtec_exit(void)
+{
+	driver_unregister(&simtec_i2c_driver);
+}
+
+module_init(i2c_adap_simtec_init);
+module_exit(i2c_adap_simtec_exit);
+
+MODULE_DESCRIPTION("Simtec Generic I2C Bus driver");
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
