From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Sun, 21 Jun 2015 13:54:44 +0000
Subject: [lm-sensors]  [PATCH v2] hwmon: add driver for Microchip TC74
Message-Id: <5586C224.3060303@maciej.szmigiero.name>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Add hwmon driver for the Microchip TC74.

The TC74 is a single-input 8-bit I2C temperature sensor,
with +-2 degrees centigrade accuracy.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/Documentation/hwmon/tc74 b/Documentation/hwmon/tc74
new file mode 100644
index 0000000..43027aa
--- /dev/null
+++ b/Documentation/hwmon/tc74
@@ -0,0 +1,20 @@
+Kernel driver tc74
+==========
+
+Supported chips:
+   * Microchip TC74
+     Prefix: 'tc74'
+     Datasheet: Publicly available at Microchip website.
+
+Description
+-----------
+
+Driver supports the above part.
+
+The tc74 has an 8-bit sensor, with 1 degree centigrade resolution
+and +- 2 degrees centigrade accuracy.
+
+Notes
+-----
+
+Currently entering low power standby mode is not supported.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 25d9e72..bbaaa2e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1452,6 +1452,16 @@ config SENSORS_INA2XX
 	  This driver can also be built as a module.  If so, the module
 	  will be called ina2xx.
 
+config SENSORS_TC74
+	tristate "Microchip TC74"
+	depends on I2C
+	help
+	  If you say yes here you get support for Microchip TC74 single
+	  input temperature sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tc74.
+
 config SENSORS_THMC50
 	tristate "Texas Instruments THMC50 / Analog Devices ADM1022"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b4a40f1..ab90402 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
+obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
 obj-$(CONFIG_SENSORS_TMP103)	+= tmp103.o
diff --git a/drivers/hwmon/tc74.c b/drivers/hwmon/tc74.c
new file mode 100644
index 0000000..f1fda35
--- /dev/null
+++ b/drivers/hwmon/tc74.c
@@ -0,0 +1,177 @@
+/*
+ * An hwmon driver for the Microchip TC74
+ *
+ * Copyright 2015 Maciej Szmigiero <mail@maciej.szmigiero.name>
+ *
+ * Based on ad7414.c:
+ *	Copyright 2006 Stefan Roese, DENX Software Engineering
+ *	Copyright 2008 Sean MacLennan, PIKA Technologies
+ *	Copyright 2008 Frank Edelhaeuser, Spansion Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+/* TC74 registers */
+#define TC74_REG_TEMP		0x00
+#define TC74_REG_CONFIG		0x01
+
+struct tc74_data {
+	struct i2c_client	*client;
+	struct mutex		lock;	/* atomic read data updates */
+	bool			valid;	/* validity of fields below */
+	unsigned long		next_update;	/* In jiffies */
+	s8			temp_input;	/* Temp value in dC */
+};
+
+static int tc74_update_device(struct device *dev)
+{
+	struct tc74_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	ret = mutex_lock_interruptible(&data->lock);
+	if (ret)
+		return ret;
+
+	if (time_after(jiffies, data->next_update) || !data->valid) {
+		s32 value;
+
+		value = i2c_smbus_read_byte_data(client, TC74_REG_CONFIG);
+		if (value < 0) {
+			dev_dbg(&client->dev, "TC74_REG_CONFIG read err %d\n",
+				(int)value);
+
+			ret = value;
+			goto ret_unlock;
+		}
+
+		if (!(value & BIT(6))) {
+			/* not ready yet */
+
+			ret = -EAGAIN;
+			goto ret_unlock;
+		}
+
+		value = i2c_smbus_read_byte_data(client, TC74_REG_TEMP);
+		if (value < 0) {
+			dev_dbg(&client->dev, "TC74_REG_TEMP read err %d\n",
+				(int)value);
+
+			ret = value;
+			goto ret_unlock;
+		}
+
+		data->temp_input = value;
+		data->next_update = jiffies + HZ / 4;
+		data->valid = true;
+	}
+
+ret_unlock:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static ssize_t show_temp_input(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct tc74_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = tc74_update_device(dev);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", data->temp_input * 1000);
+}
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
+
+static struct attribute *tc74_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(tc74);
+
+static int tc74_probe(struct i2c_client *client,
+			const struct i2c_device_id *dev_id)
+{
+	struct device *dev = &client->dev;
+	struct tc74_data *data;
+	struct device *hwmon_dev;
+	s32 conf;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	data = devm_kzalloc(dev, sizeof(struct tc74_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->lock);
+
+	/* Make sure the chip is powered up. */
+	conf = i2c_smbus_read_byte_data(client, TC74_REG_CONFIG);
+	if (conf < 0) {
+		dev_err(dev, "unable to read config register\n");
+
+		return conf;
+	}
+
+	if (conf & 0x3f) {
+		dev_err(dev, "invalid config register value\n");
+
+		return -ENODEV;
+	}
+
+	if (conf & BIT(7)) {
+		s32 ret;
+
+		conf &= ~BIT(7);
+
+		ret = i2c_smbus_write_byte_data(client, TC74_REG_CONFIG, conf);
+		if (ret)
+			dev_warn(dev, "unable to disable STANDBY\n");
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+							   client->name,
+							   data, tc74_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id tc74_id[] = {
+	{ "tc74", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, tc74_id);
+
+static struct i2c_driver tc74_driver = {
+	.driver = {
+		.name	= "tc74",
+	},
+	.probe	= tc74_probe,
+	.id_table = tc74_id,
+};
+
+module_i2c_driver(tc74_driver);
+
+MODULE_AUTHOR("Maciej Szmigiero <mail@maciej.szmigiero.name>");
+
+MODULE_DESCRIPTION("TC74 driver");
+MODULE_LICENSE("GPL");


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
