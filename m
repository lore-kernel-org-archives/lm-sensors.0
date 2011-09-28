From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 28 Sep 2011 12:57:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: ad7314 driver (ported from IIO).
Message-Id: <1317214661-31282-2-git-send-email-jic23@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317214661-31282-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317214661-31282-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-iio@vger.kernel.org, Device-drivers-devel@blackfin.uclinux.org, Jonathan Cameron <jic23@cam.ac.uk>

Currently dropped power down mode support.
Not tested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/hwmon/Kconfig  |   10 +++
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/ad7314.c |  181 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0b62c3c..e5d4daa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -68,6 +68,16 @@ config SENSORS_ABITUGURU3
 	  This driver can also be built as a module.  If so, the module
 	  will be called abituguru3.
 
+config SENSORS_AD7314
+	tristate "Analog Devices AD7314 and compatibles"
+	depends on SPI && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  AD7314, ADT7301 and ADT7302 temperature sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ad7314.
+
 config SENSORS_AD7414
 	tristate "Analog Devices AD7414"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3c9ccef..228a4b7 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
 
 obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
 obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
+obj-$(CONFIG_SENSORS_AD7314)	+= ad7314.o
 obj-$(CONFIG_SENSORS_AD7414)	+= ad7414.o
 obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
 obj-$(CONFIG_SENSORS_ADCXX)	+= adcxx.o
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
new file mode 100644
index 0000000..9cabe7b
--- /dev/null
+++ b/drivers/hwmon/ad7314.c
@@ -0,0 +1,181 @@
+/*
+ * AD7314 digital temperature sensor driver for AD7314, ADT7301 and ADT7302
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ *
+ * Conversion to hwmon from IIO done by Jonathan Cameron <jic23@cam.ac.uk>
+ */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+/*
+ * AD7314 power mode
+ */
+#define AD7314_PD		0x2000
+
+/*
+ * AD7314 temperature masks
+ */
+#define AD7314_TEMP_SIGN		0x200
+#define AD7314_TEMP_MASK		0x7FE0
+#define AD7314_TEMP_OFFSET		5
+#define AD7314_TEMP_FLOAT_OFFSET	2
+#define AD7314_TEMP_FLOAT_MASK		0x3
+
+/*
+ * ADT7301 and ADT7302 temperature masks
+ */
+#define ADT7301_TEMP_SIGN		0x2000
+#define ADT7301_TEMP_MASK		0x2FFF
+#define ADT7301_TEMP_FLOAT_OFFSET	5
+#define ADT7301_TEMP_FLOAT_MASK		0x1F
+
+enum ad7314_variant {
+	adt7301,
+	adt7302,
+	ad7314,
+};
+
+struct ad7314_data {
+	struct spi_device	*spi_dev;
+	struct device		*hwmon_dev;
+	u16 rx ____cacheline_aligned;
+};
+
+static int ad7314_spi_read(struct spi_device *spi_dev, u16 *data)
+{
+	int ret = 0;
+	u16 value;
+
+	ret = spi_read(spi_dev, (u8 *)&value, sizeof(value));
+	if (ret < 0) {
+		dev_err(&spi_dev->dev, "SPI read error\n");
+		return ret;
+	}
+
+	*data = be16_to_cpu((u16)value);
+
+	return ret;
+}
+
+static ssize_t ad7314_show_temperature(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct ad7314_data *chip = dev_get_drvdata(dev);
+	s16 data;
+	int ret;
+
+	ret = ad7314_spi_read(chip->spi_dev, &chip->rx);
+	if (ret < 0)
+		return ret;
+	data = chip->rx;
+	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
+	case ad7314:
+		data = (data & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
+		data = (data << 6) >> 6;
+
+		return sprintf(buf, "%d.%.2d\n",
+			       data >> AD7314_TEMP_FLOAT_OFFSET,
+			       (data & AD7314_TEMP_FLOAT_MASK) * 25);
+	case adt7301:
+	case adt7302:
+		data &= ADT7301_TEMP_MASK;
+		data = (data << 3) >> 3;
+
+		return sprintf(buf, "%d.%.5d\n",
+			       data >> ADT7301_TEMP_FLOAT_OFFSET,
+			       (data & ADT7301_TEMP_FLOAT_MASK) * 3125);
+	default:
+		return -EINVAL;
+	}
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+			  ad7314_show_temperature, NULL, 0);
+
+static struct attribute *ad7314_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7314_group = {
+	.attrs = ad7314_attributes,
+};
+
+static int __devinit ad7314_probe(struct spi_device *spi_dev)
+{
+	int ret;
+	struct ad7314_data *chip;
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip = NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	dev_set_drvdata(&spi_dev->dev, chip);
+
+	ret = sysfs_create_group(&spi_dev->dev.kobj, &ad7314_group);
+	if (ret < 0)
+		goto error_free_chip;
+
+	return 0;
+error_free_chip:
+	kfree(chip);
+error_ret:
+	return ret;
+}
+
+static int __devexit ad7314_remove(struct spi_device *spi_dev)
+{
+	struct ad7314_data *chip = dev_get_drvdata(&spi_dev->dev);
+
+	hwmon_device_unregister(chip->hwmon_dev);
+	sysfs_remove_group(&spi_dev->dev.kobj, &ad7314_group);
+	kfree(chip);
+
+	return 0;
+}
+
+static const struct spi_device_id ad7314_id[] = {
+	{ "adt7301", adt7301 },
+	{ "adt7302", adt7302 },
+	{ "ad7314", ad7314 },
+	{}
+};
+
+static struct spi_driver ad7314_driver = {
+	.driver = {
+		.name = "ad7314",
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe = ad7314_probe,
+	.remove = __devexit_p(ad7314_remove),
+	.id_table = ad7314_id,
+};
+
+static __init int ad7314_init(void)
+{
+	return spi_register_driver(&ad7314_driver);
+}
+module_init(ad7314_init);
+
+static __exit void ad7314_exit(void)
+{
+	spi_unregister_driver(&ad7314_driver);
+}
+module_exit(ad7314_exit);
+
+MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7314, ADT7301 and ADT7302 digital"
+			" temperature sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.3.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
