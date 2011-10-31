From: Paul Fertser <fercerpav@gmail.com>
Date: Mon, 31 Oct 2011 12:10:23 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon: add support for MCP3204/3208
Message-Id: <201110311247.p9VClrVx017871@home.pavel.comp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for these simple low-power cheap ADC ICs.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Well, adc*_in and adc_diff*_in are not mentioned in the sysfs-attributes.txt
but at least the max1111 uses the former. Waiting for your feedback.

 drivers/hwmon/Kconfig   |   12 +++
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/mcp3208.c |  254 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/mcp3208.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0b62c3c..48ac1ab 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -787,6 +787,18 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.
 
+config SENSORS_MCP3208
+	tristate "Microchip MCP3204/3208 Multichannel, Serial 12-bit ADC chip"
+	depends on SPI_MASTER
+	help
+	  Say y here to support Microchips's MCP3204/3208 ADC chips.
+
+	  Since MCP3204 has only half the channels, use only adc[0-3]_in and
+	  adc_diff[0-1]_in with it.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called mcp3208.
+
 config SENSORS_NTC_THERMISTOR
 	tristate "NTC thermistor support"
 	depends on EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3c9ccef..847f6af 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
+obj-$(CONFIG_SENSORS_MCP3208)	+= mcp3208.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
diff --git a/drivers/hwmon/mcp3208.c b/drivers/hwmon/mcp3208.c
new file mode 100644
index 0000000..30bd631
--- /dev/null
+++ b/drivers/hwmon/mcp3208.c
@@ -0,0 +1,254 @@
+/*
+ * mcp3208.c - MCP3204/3208 +2.7V, Low-Power, Multichannel, Serial 12-bit ADCs
+ *
+ * Heavily based on drivers/hwmon/max1111.c
+ *
+ * Copyright (C) 2004-2005 Richard Purdie
+ *
+ * Copyright (C) 2008 Marvell International Ltd.
+ *	Eric Miao <eric.miao@marvell.com>
+ *
+ * Copyright (C) 2011 Paul Fertser <fercerpav@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+
+#define MCP3208_TX_BUF_SIZE	1
+#define MCP3208_RX_BUF_SIZE	2
+
+#define MCP3208_CTRL_START	(1<<4)
+#define MCP3208_CTRL_SINGLE	(1<<3)
+
+struct mcp3208_data {
+	struct spi_device	*spi;
+	struct device		*hwmon_dev;
+	struct spi_message	msg;
+	struct spi_transfer	xfer[2];
+	uint8_t tx_buf[MCP3208_TX_BUF_SIZE];
+	uint8_t rx_buf[MCP3208_RX_BUF_SIZE];
+	struct mutex		drvdata_lock;
+	/* protect msg, xfer and buffers from multiple access */
+};
+
+static int mcp3208_read(struct device *dev, int channel)
+{
+	struct mcp3208_data *data = dev_get_drvdata(dev);
+	uint8_t v1, v2;
+	int err;
+
+	/* writing to drvdata struct is not thread safe, wait on mutex */
+	mutex_lock(&data->drvdata_lock);
+
+	data->tx_buf[0] = MCP3208_CTRL_START | channel;
+
+	err = spi_sync(data->spi, &data->msg);
+	if (err < 0) {
+		dev_err(dev, "spi_sync failed with %d\n", err);
+		mutex_unlock(&data->drvdata_lock);
+		return err;
+	}
+
+	v1 = data->rx_buf[0];
+	v2 = data->rx_buf[1];
+
+	mutex_unlock(&data->drvdata_lock);
+
+	if (v1 & (1<<6))
+		return -EINVAL;
+
+	return (v1 & 0x3f) << 6 | (v2 >> 2);
+}
+
+/*
+ * NOTE: SPI devices do not have a default 'name' attribute, which is
+ * likely to be used by hwmon applications to distinguish between
+ * different devices, explicitly add a name attribute here.
+ */
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "mcp3208\n");
+}
+
+static ssize_t show_adc(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+	int ret;
+
+	ret = mcp3208_read(dev, channel);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+#define MCP3208_ADC_ATTR(_id)		\
+	SENSOR_DEVICE_ATTR(adc##_id##_in, S_IRUGO, show_adc,	\
+			   NULL, _id | MCP3208_CTRL_SINGLE)
+
+#define MCP3208_DIFF_ADC_ATTR(_id)	\
+	SENSOR_DEVICE_ATTR(adc_diff##_id##_in, S_IRUGO,	\
+			   show_adc, NULL, _id)
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static MCP3208_ADC_ATTR(0);
+static MCP3208_ADC_ATTR(1);
+static MCP3208_ADC_ATTR(2);
+static MCP3208_ADC_ATTR(3);
+static MCP3208_ADC_ATTR(4);
+static MCP3208_ADC_ATTR(5);
+static MCP3208_ADC_ATTR(6);
+static MCP3208_ADC_ATTR(7);
+
+static MCP3208_DIFF_ADC_ATTR(0);
+static MCP3208_DIFF_ADC_ATTR(1);
+static MCP3208_DIFF_ADC_ATTR(2);
+static MCP3208_DIFF_ADC_ATTR(3);
+static MCP3208_DIFF_ADC_ATTR(4);
+static MCP3208_DIFF_ADC_ATTR(5);
+static MCP3208_DIFF_ADC_ATTR(6);
+static MCP3208_DIFF_ADC_ATTR(7);
+
+static struct attribute *mcp3208_attributes[] = {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_adc0_in.dev_attr.attr,
+	&sensor_dev_attr_adc1_in.dev_attr.attr,
+	&sensor_dev_attr_adc2_in.dev_attr.attr,
+	&sensor_dev_attr_adc3_in.dev_attr.attr,
+	&sensor_dev_attr_adc4_in.dev_attr.attr,
+	&sensor_dev_attr_adc5_in.dev_attr.attr,
+	&sensor_dev_attr_adc6_in.dev_attr.attr,
+	&sensor_dev_attr_adc7_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff0_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff1_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff2_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff3_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff4_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff5_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff6_in.dev_attr.attr,
+	&sensor_dev_attr_adc_diff7_in.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mcp3208_attr_group = {
+	.attrs	= mcp3208_attributes,
+};
+
+static int __devinit setup_transfer(struct mcp3208_data *data)
+{
+	struct spi_message *m;
+	struct spi_transfer *x;
+
+	m = &data->msg;
+	x = &data->xfer[0];
+
+	spi_message_init(m);
+
+	x->tx_buf = &data->tx_buf[0];
+	x->len = MCP3208_TX_BUF_SIZE;
+	spi_message_add_tail(x, m);
+
+	x++;
+	x->rx_buf = &data->rx_buf[0];
+	x->len = MCP3208_RX_BUF_SIZE;
+	spi_message_add_tail(x, m);
+
+	return 0;
+}
+
+static int __devinit mcp3208_probe(struct spi_device *spi)
+{
+	struct mcp3208_data *data;
+	int err;
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	err = spi_setup(spi);
+	if (err < 0)
+		return err;
+
+	data = kzalloc(sizeof(struct mcp3208_data), GFP_KERNEL);
+	if (data = NULL) {
+		dev_err(&spi->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	err = setup_transfer(data);
+	if (err)
+		goto err_free_data;
+
+	mutex_init(&data->drvdata_lock);
+
+	data->spi = spi;
+	spi_set_drvdata(spi, data);
+
+	err = sysfs_create_group(&spi->dev.kobj, &mcp3208_attr_group);
+	if (err) {
+		dev_err(&spi->dev, "failed to create attribute group\n");
+		goto err_free_data;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&spi->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		dev_err(&spi->dev, "failed to create hwmon device\n");
+		err = PTR_ERR(data->hwmon_dev);
+		goto err_remove;
+	}
+
+	return 0;
+
+err_remove:
+	sysfs_remove_group(&spi->dev.kobj, &mcp3208_attr_group);
+err_free_data:
+	kfree(data);
+	return err;
+}
+
+static int __devexit mcp3208_remove(struct spi_device *spi)
+{
+	struct mcp3208_data *data = spi_get_drvdata(spi);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&spi->dev.kobj, &mcp3208_attr_group);
+	mutex_destroy(&data->drvdata_lock);
+	kfree(data);
+	return 0;
+}
+
+static struct spi_driver mcp3208_driver = {
+	.driver		= {
+		.name	= "mcp3208",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= mcp3208_probe,
+	.remove		= __devexit_p(mcp3208_remove),
+};
+
+static int __init mcp3208_init(void)
+{
+	return spi_register_driver(&mcp3208_driver);
+}
+module_init(mcp3208_init);
+
+static void __exit mcp3208_exit(void)
+{
+	spi_unregister_driver(&mcp3208_driver);
+}
+module_exit(mcp3208_exit);
+
+MODULE_AUTHOR("Paul Fertser <fercerpav@gmail.com>");
+MODULE_DESCRIPTION("MCP3208 ADC Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:mcp3208");
-- 
1.7.2.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
