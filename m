From: Sean MacLennan <seanm@seanm.ca>
Date: Thu, 19 Jun 2008 18:02:22 +0000
Subject: Re: [lm-sensors] [PATCH] ad7414 driver
Message-Id: <20080619140222.6ffab309@lappy.seanm.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080613221221.50c642ee@lappy.seanm.ca>
In-Reply-To: <20080613221221.50c642ee@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver for the Analog Devices AD7414 temperature monitoring chip.


Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 00ff533..3c21d57 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -57,6 +57,16 @@ config SENSORS_ABITUGURU3
 	  This driver can also be built as a module.  If so, the module
 	  will be called abituguru3.
 
+config SENSORS_AD7414
+	tristate "Analog Devices AD7414"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  AD7414 temperature monitoring chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ad7414.
+
 config SENSORS_AD7418
 	tristate "Analog Devices AD7416, AD7417 and AD7418"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d098677..7943e5c 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
 
 obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
 obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
+obj-$(CONFIG_SENSORS_AD7414)	+= ad7414.o
 obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
new file mode 100644
index 0000000..ce8d94f
--- /dev/null
+++ b/drivers/hwmon/ad7414.c
@@ -0,0 +1,268 @@
+/*
+ * An hwmon driver for the Analog Devices AD7414
+ *
+ * Copyright 2006 Stefan Roese <sr at denx.de>, DENX Software Engineering
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * Copyright (c) 2008 Spansion Inc.
+ *   Frank Edelhaeuser <frank.edelhaeuser at spansion.com>
+ *   (converted to "new style" I2C driver model, removed checkpatch.pl warnings)
+ *
+ * Based on ad7418.c
+ * Copyright 2006 Tower Technologies, Alessandro Zummo <a.zummo at towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+
+/* AD7414 registers */
+#define AD7414_REG_TEMP		0x00
+#define AD7414_REG_CONF		0x01
+#define AD7414_REG_T_HIGH	0x02
+#define AD7414_REG_T_LOW	0x03
+
+static u8 AD7414_REG_LIMIT[] = { AD7414_REG_T_HIGH, AD7414_REG_T_LOW };
+
+struct ad7414_data {
+	struct device		*hwmon_dev;
+	struct mutex		lock;	/* atomic read data updates */
+	char			valid;	/* !=0 if following fields are valid */
+	unsigned long		next_update;	/* In jiffies */
+	s16			temp_input;	/* Register values */
+	s8			temps[ARRAY_SIZE(AD7414_REG_LIMIT)];
+};
+
+/* REG: (0.25C/bit, two's complement) << 6 */
+static inline int ad7414_temp_from_reg(s16 reg)
+{
+	/* use integer division instead of equivalent right shift to
+	 * guarantee arithmetic shift and preserve the sign
+	 */
+	return ((int)reg / 64) * 250;
+}
+
+static inline int ad7414_read(struct i2c_client *client, u8 reg)
+{
+	if (reg = AD7414_REG_TEMP) {
+		int value = i2c_smbus_read_word_data(client, reg);
+		return (value < 0) ? value : swab16(value);
+	} else
+		return i2c_smbus_read_byte_data(client, reg);
+}
+
+static inline int ad7414_write(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+struct ad7414_data *ad7414_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ad7414_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->lock);
+
+	if (time_after(jiffies, data->next_update) || !data->valid) {
+		int value, i;
+
+		dev_dbg(&client->dev, "starting ad7414 update\n");
+
+		value = ad7414_read(client, AD7414_REG_TEMP);
+		if (value < 0)
+			dev_dbg(&client->dev, "AD7414_REG_TEMP err %d\n",
+				value);
+		else
+			data->temp_input = value;
+
+		for (i = 0; i < ARRAY_SIZE(AD7414_REG_LIMIT); ++i) {
+			value = ad7414_read(client, AD7414_REG_LIMIT[i]);
+			if (value < 0)
+				dev_dbg(&client->dev, "AD7414 reg %d err %d\n",
+					AD7414_REG_LIMIT[i], value);
+			else
+				data->temps[i] = value;
+		}
+
+		data->next_update = jiffies + HZ + HZ / 2;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return data;
+}
+
+static ssize_t show_temp_input(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct ad7414_data *data = ad7414_update_device(dev);
+	return sprintf(buf, "%d\n", ad7414_temp_from_reg(data->temp_input));
+}
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
+
+static ssize_t show_max_min(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct ad7414_data *data = ad7414_update_device(dev);
+	return sprintf(buf, "%d\n", data->temps[index] * 1000);
+}
+
+static ssize_t set_max_min(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ad7414_data *data = i2c_get_clientdata(client);
+	int index = to_sensor_dev_attr(attr)->index;
+	u8 reg = AD7414_REG_LIMIT[index];
+	long temp = simple_strtol(buf, NULL, 10);
+
+	temp = SENSORS_LIMIT(temp, -40000, 85000);
+	temp = (temp + (temp < 0 ? -500 : 500)) / 1000;
+
+	mutex_lock(&data->lock);
+	data->temps[index] = temp;
+	ad7414_write(client, reg, temp);
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
+			  show_max_min, set_max_min, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
+			  show_max_min, set_max_min, 1);
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct ad7414_data *data = ad7414_update_device(dev);
+	int value = (data->temp_input >> bitnr) & 1;
+	return sprintf(buf, "%d\n", value);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+
+static struct attribute *ad7414_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7414_group = {
+	.attrs = ad7414_attributes,
+};
+
+static int ad7414_probe(struct i2c_client *client,
+			const struct i2c_device_id *dev_id)
+{
+	struct ad7414_data *data;
+	int conf;
+	int err = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		goto exit;
+
+	data = kzalloc(sizeof(struct ad7414_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
+
+	dev_info(&client->dev, "chip found\n");
+
+	/* Make sure the chip is powered up. */
+	conf = i2c_smbus_read_byte_data(client, AD7414_REG_CONF);
+	if (conf < 0)
+		dev_warn(&client->dev,
+			 "ad7414_probe unable to read config register.\n");
+	else {
+		conf &= ~(1 << 7);
+		i2c_smbus_write_byte_data(client, AD7414_REG_CONF, conf);
+	}
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &ad7414_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int __devexit ad7414_remove(struct i2c_client *client)
+{
+	struct ad7414_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
+	kfree(data);
+	return 0;
+}
+
+static const struct i2c_device_id ad7414_id[] = {
+	{ "ad7414", 0 },
+	{}
+};
+
+static struct i2c_driver ad7414_driver = {
+	.driver = {
+		.name	= "ad7414",
+	},
+	.probe	= ad7414_probe,
+	.remove	= __devexit_p(ad7414_remove),
+	.id_table = ad7414_id,
+};
+
+static int __init ad7414_init(void)
+{
+	return i2c_add_driver(&ad7414_driver);
+}
+module_init(ad7414_init);
+
+static void __exit ad7414_exit(void)
+{
+	i2c_del_driver(&ad7414_driver);
+}
+module_exit(ad7414_exit);
+
+MODULE_AUTHOR("Stefan Roese <sr at denx.de>, "
+	      "Frank Edelhaeuser <frank.edelhaeuser at spansion.com>");
+
+MODULE_DESCRIPTION("AD7414 driver");
+MODULE_LICENSE("GPL");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
