From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 15 Sep 2008 20:06:36 +0000
Subject: [lm-sensors] [PATCH] hwmon: TI TMP121 SPI temperature sensor driver.
Message-Id: <20080915200636.GA11608@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver for the Texas Instruments TMP121/TMP123 SPI temperature sensors.
The code is 99% identical to the LM70 driver;  only the formula to
calculate the temperature (in 1/1000 deg celsius) has been adjusted.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/hwmon/Kconfig  |   10 +++
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/tmp121.c |  168 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/tmp121.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d402e8d..1b209c1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -670,6 +670,16 @@ config SENSORS_THMC50
 	  This driver can also be built as a module.  If so, the module
 	  will be called thmc50.
 
+config SENSORS_TMP121
+	tristate "Texas Instruments TMP121/TMP123 SPI Temperature sensor"
+	depends on SPI
+	help
+	  If you say yes here you get support for the Texas Instruments
+	  TMP121/TMP123 SPI temperature sensor.
+
+	  This driver can be built as a module.  If so, the module
+	  will be called tmp121.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 950134a..58b143c 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
+obj-$(CONFIG_SENSORS_TMP121)	+= tmp121.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
 obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
diff --git a/drivers/hwmon/tmp121.c b/drivers/hwmon/tmp121.c
new file mode 100644
index 0000000..0feb948
--- /dev/null
+++ b/drivers/hwmon/tmp121.c
@@ -0,0 +1,168 @@
+/*
+ * TI TMP121/TMP123 SPI temperature Sensor.
+ *
+ * Copyright (c) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * All new formula! Contains 99% code from lm70.c which is
+ *   Copyright (C) 2006 Kaiwan N Billimoria <kaiwan@designergraphix.com>
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
+
+#define DRVNAME		"tmp121"
+
+struct tmp121 {
+	struct device *hwmon_dev;
+	struct mutex lock;
+};
+
+/* sysfs hook function */
+static ssize_t tmp121_sense_temp(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int status, val;
+	u8 rxbuf[2];
+	s16 raw=0;
+	struct tmp121 *p_tmp121 = dev_get_drvdata(&spi->dev);
+
+	if (mutex_lock_interruptible(&p_tmp121->lock))
+		return -ERESTARTSYS;
+
+	/*
+	 * spi_read() requires a DMA-safe buffer; so we use
+	 * spi_write_then_read(), transmitting 0 bytes.
+	 */
+	status = spi_write_then_read(spi, NULL, 0, &rxbuf[0], 2);
+	if (status < 0) {
+		printk(KERN_WARNING
+		"spi_write_then_read failed with status %d\n", status);
+		goto out;
+	}
+	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
+
+	raw = (rxbuf[0] << 8) + rxbuf[1];
+	dev_dbg(dev, "raw=0x%x\n", raw);
+
+	/*
+	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
+	 * complement value. Only the MSB 13 bits (1 sign + 12 temperature
+	 * bits) are meaningful; the LSB 3 bits are to be discarded.
+	 * Each bit represents 0.0625 degrees Celsius.
+	 */
+	val = (raw * 625) / 80;
+	status = sprintf(buf, "%d\n", val);
+out:
+	mutex_unlock(&p_tmp121->lock);
+	return status;
+}
+
+static DEVICE_ATTR(temp1_input, S_IRUGO, tmp121_sense_temp, NULL);
+
+static ssize_t tmp121_show_name(struct device *dev, struct device_attribute
+			      *devattr, char *buf)
+{
+	return sprintf(buf, "tmp121\n");
+}
+
+static DEVICE_ATTR(name, S_IRUGO, tmp121_show_name, NULL);
+
+/*----------------------------------------------------------------------*/
+
+static int __devinit tmp121_probe(struct spi_device *spi)
+{
+	struct tmp121 *p_tmp121;
+	int status;
+
+	p_tmp121 = kzalloc(sizeof *p_tmp121, GFP_KERNEL);
+	if (!p_tmp121)
+		return -ENOMEM;
+
+	mutex_init(&p_tmp121->lock);
+
+	/* sysfs hook */
+	p_tmp121->hwmon_dev = hwmon_device_register(&spi->dev);
+	if (IS_ERR(p_tmp121->hwmon_dev)) {
+		dev_dbg(&spi->dev, "hwmon_device_register failed.\n");
+		status = PTR_ERR(p_tmp121->hwmon_dev);
+		goto out_dev_reg_failed;
+	}
+	dev_set_drvdata(&spi->dev, p_tmp121);
+
+	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))
+	 || (status = device_create_file(&spi->dev, &dev_attr_name))) {
+		dev_dbg(&spi->dev, "device_create_file failure.\n");
+		goto out_dev_create_file_failed;
+	}
+
+	return 0;
+
+out_dev_create_file_failed:
+	device_remove_file(&spi->dev, &dev_attr_temp1_input);
+	hwmon_device_unregister(p_tmp121->hwmon_dev);
+out_dev_reg_failed:
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(p_tmp121);
+	return status;
+}
+
+static int __devexit tmp121_remove(struct spi_device *spi)
+{
+	struct tmp121 *p_tmp121 = dev_get_drvdata(&spi->dev);
+
+	device_remove_file(&spi->dev, &dev_attr_temp1_input);
+	device_remove_file(&spi->dev, &dev_attr_name);
+	hwmon_device_unregister(p_tmp121->hwmon_dev);
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(p_tmp121);
+
+	return 0;
+}
+
+static struct spi_driver tmp121_driver = {
+	.driver = {
+		.name	= "tmp121",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= tmp121_probe,
+	.remove	= __devexit_p(tmp121_remove),
+};
+
+static int __init init_tmp121(void)
+{
+	return spi_register_driver(&tmp121_driver);
+}
+
+static void __exit cleanup_tmp121(void)
+{
+	spi_unregister_driver(&tmp121_driver);
+}
+
+module_init(init_tmp121);
+module_exit(cleanup_tmp121);
+
+MODULE_AUTHOR("Manuel Lauss");
+MODULE_DESCRIPTION("TI TMP121 SPI temperature sensor hwmon driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
