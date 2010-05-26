From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 26 May 2010 23:12:53 +0000
Subject: [lm-sensors] [PATCH v2 2/2] hwmon: (ltc4245) expose all GPIO pins
Message-Id: <1274915573-9153-1-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for exposing all GPIO pins as analog voltages. Though this is
not an ideal use of the chip, some hardware engineers may decide that the
LTC4245 meets their design requirements when studying the datasheet.

The GPIO pins are sampled in round-robin fashion, meaning that a slow
reader will see stale data. A userspace application can detect this,
because it will get -EAGAIN when reading from a sysfs file which contains
stale data.

Users can choose to use this feature on a per-chip basis by using either
platform data or the OF device tree (where applicable).

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

v1 -> v2:
* use platform data or OF to configure extra GPIO support

Jean, I hope this patch isn't too bad. It is a lot of code, but I can't
come up with a way to make it shorter. Especially the round-robin code
in ltc4245_update_gpios() is pretty nasty. Feel free to offer more
suggestions!

Thanks,
Ira

 Documentation/hwmon/ltc4245 |   18 +++++-
 drivers/hwmon/ltc4245.c     |  169 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/i2c/ltc4245.h |   21 ++++++
 3 files changed, 197 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/i2c/ltc4245.h

diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
index 86b5880..6c2e7a8 100644
--- a/Documentation/hwmon/ltc4245
+++ b/Documentation/hwmon/ltc4245
@@ -72,9 +72,25 @@ in6_min_alarm		5v  output undervoltage alarm
 in7_min_alarm		3v  output undervoltage alarm
 in8_min_alarm		Vee (-12v) output undervoltage alarm
 
-in9_input		GPIO voltage data
+in9_input		GPIO voltage data (see note 1)
+in10_input		GPIO voltage data (see note 1)
+in11_input		GPIO voltage data (see note 1)
 
 power1_input		12v power usage (mW)
 power2_input		5v  power usage (mW)
 power3_input		3v  power usage (mW)
 power4_input		Vee (-12v) power usage (mW)
+
+
+Note 1
+------
+
+If you have configured the device to sample all GPIO pins as analog voltages,
+then they will be sampled in round-robin fashion. If userspace reads too
+slowly, -EAGAIN will be returned when you read the sysfs attribute containing
+the sensor reading.
+
+The LTC4245 chip can be configured to sample all GPIO pins with two methods:
+1) platform data -- see include/linux/i2c/ltc4245.h
+2) OF device tree -- add the "ltc4245,use-extra-gpios" property to each chip
+
diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 84e6f32..30d4233 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/i2c/ltc4245.h>
 
 /* Here are names of the chip's registers (a.k.a. commands) */
 enum ltc4245_cmd {
@@ -60,8 +61,64 @@ struct ltc4245_data {
 
 	/* Voltage registers */
 	u8 vregs[0x0d];
+
+	/* GPIO ADC registers */
+	bool use_extra_gpios;
+	unsigned int last_gpio;
+	int gpios[3];
 };
 
+/*
+ * Update the readings from the GPIO pins. If the driver has been configured to
+ * sample all GPIO's as analog voltages, a round-robin sampling method is used.
+ * Otherwise, only the configured GPIO pin is sampled.
+ *
+ * LOCKING: must hold data->update_lock
+ */
+static void ltc4245_update_gpios(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+	u8 gpio_curr, gpio_next, gpio;
+	int i;
+
+	/* no extra gpio support, we're basically done */
+	if (!data->use_extra_gpios) {
+		data->gpios[0] = data->vregs[LTC4245_GPIOADC - 0x10];
+		return;
+	}
+
+	/*
+	 * If the last reading was too long ago, then we mark all old GPIO
+	 * readings as stale by setting them to -EAGAIN
+	 */
+	if (time_after(jiffies, data->last_updated + 5 * HZ)) {
+		dev_dbg(&client->dev, "Marking GPIOs invalid\n");
+		for (i = 0; i < ARRAY_SIZE(data->gpios); i++)
+			data->gpios[i] = -EAGAIN;
+	}
+
+	/* Read the GPIO voltage from the GPIOADC register */
+	gpio_curr = data->last_gpio;
+	data->gpios[gpio_curr] = data->vregs[LTC4245_GPIOADC - 0x10];
+
+	/* Find the next GPIO pin to read */
+	gpio_next = (data->last_gpio + 1) % ARRAY_SIZE(data->gpios);
+
+	/*
+	 * Calculate the correct setting for the GPIO register so it will
+	 * sample the next GPIO pin
+	 */
+	gpio = (data->cregs[LTC4245_GPIO] & 0x3f) | ((gpio_next + 1) << 6);
+
+	/* Update the GPIO register */
+	i2c_smbus_write_byte_data(client, LTC4245_GPIO, gpio);
+
+	/* Update saved data */
+	data->cregs[LTC4245_GPIO] = gpio;
+	data->last_gpio = gpio_next;
+}
+
 static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -93,6 +150,9 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 				data->vregs[i] = val;
 		}
 
+		/* Update GPIO readings */
+		ltc4245_update_gpios(dev);
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -233,6 +293,22 @@ static ssize_t ltc4245_show_alarm(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", (reg & mask) ? 1 : 0);
 }
 
+static ssize_t ltc4245_show_gpio(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	int val = data->gpios[attr->index];
+
+	/* handle stale GPIO's */
+	if (val < 0)
+		return val;
+
+	/* Convert to millivolts and print */
+	return snprintf(buf, PAGE_SIZE, "%u\n", val * 10);
+}
+
 /* These macros are used below in constructing device attribute objects
  * for use with sysfs_create_group() to make a sysfs device file
  * for each register.
@@ -254,6 +330,10 @@ static ssize_t ltc4245_show_alarm(struct device *dev,
 	static SENSOR_DEVICE_ATTR_2(name, S_IRUGO, \
 	ltc4245_show_alarm, NULL, (mask), reg)
 
+#define LTC4245_GPIO_VOLTAGE(name, gpio_num) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show_gpio, NULL, gpio_num)
+
 /* Construct a sensor_device_attribute structure for each register */
 
 /* Input voltages */
@@ -293,7 +373,9 @@ LTC4245_ALARM(in7_min_alarm,	(1 << 2),	LTC4245_FAULT2);
 LTC4245_ALARM(in8_min_alarm,	(1 << 3),	LTC4245_FAULT2);
 
 /* GPIO voltages */
-LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC);
+LTC4245_GPIO_VOLTAGE(in9_input,			0);
+LTC4245_GPIO_VOLTAGE(in10_input,		1);
+LTC4245_GPIO_VOLTAGE(in11_input,		2);
 
 /* Power Consumption (virtual) */
 LTC4245_POWER(power1_input,			LTC4245_12VSENSE);
@@ -304,7 +386,7 @@ LTC4245_POWER(power4_input,			LTC4245_VEESENSE);
 /* Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
-static struct attribute *ltc4245_attributes[] = {
+static struct attribute *ltc4245_std_attributes[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
@@ -345,10 +427,77 @@ static struct attribute *ltc4245_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ltc4245_group = {
-	.attrs = ltc4245_attributes,
+static struct attribute *ltc4245_gpio_attributes[] = {
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ltc4245_std_group = {
+	.attrs = ltc4245_std_attributes,
+};
+
+static const struct attribute_group ltc4245_gpio_group = {
+	.attrs = ltc4245_gpio_attributes,
 };
 
+static int ltc4245_sysfs_create_groups(struct i2c_client *client)
+{
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
+	int ret;
+
+	/* register the standard sysfs attributes */
+	ret = sysfs_create_group(&dev->kobj, &ltc4245_std_group);
+	if (ret) {
+		dev_err(dev, "unable to register standard attributes\n");
+		return ret;
+	}
+
+	/* if we're using the extra gpio support, register it's attributes */
+	if (data->use_extra_gpios) {
+		ret = sysfs_create_group(&dev->kobj, &ltc4245_gpio_group);
+		if (ret) {
+			dev_err(dev, "unable to register gpio attributes\n");
+			sysfs_remove_group(&dev->kobj, &ltc4245_std_group);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void ltc4245_sysfs_remove_groups(struct i2c_client *client)
+{
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
+
+	if (data->use_extra_gpios)
+		sysfs_remove_group(&dev->kobj, &ltc4245_gpio_group);
+
+	sysfs_remove_group(&dev->kobj, &ltc4245_std_group);
+}
+
+static bool ltc4245_use_extra_gpios(struct i2c_client *client)
+{
+	struct ltc4245_platform_data *pdata = dev_get_platdata(&client->dev);
+#ifdef CONFIG_OF
+	struct device_node *np = client->dev.of_node;
+#endif
+
+	/* prefer platform data */
+	if (pdata)
+		return pdata->use_extra_gpios;
+
+#ifdef CONFIG_OF
+	/* fallback on OF */
+	if (of_find_property(np, "ltc4245,use-extra-gpios", NULL))
+		return true;
+#endif
+
+	return false;
+}
+
 static int ltc4245_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -367,15 +516,16 @@ static int ltc4245_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	data->use_extra_gpios = ltc4245_use_extra_gpios(client);
 
 	/* Initialize the LTC4245 chip */
 	i2c_smbus_write_byte_data(client, LTC4245_FAULT1, 0x00);
 	i2c_smbus_write_byte_data(client, LTC4245_FAULT2, 0x00);
 
 	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &ltc4245_group);
+	ret = ltc4245_sysfs_create_groups(client);
 	if (ret)
-		goto out_sysfs_create_group;
+		goto out_sysfs_create_groups;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -386,8 +536,8 @@ static int ltc4245_probe(struct i2c_client *client,
 	return 0;
 
 out_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &ltc4245_group);
-out_sysfs_create_group:
+	ltc4245_sysfs_remove_groups(client);
+out_sysfs_create_groups:
 	kfree(data);
 out_kzalloc:
 	return ret;
@@ -398,8 +548,7 @@ static int ltc4245_remove(struct i2c_client *client)
 	struct ltc4245_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ltc4245_group);
-
+	ltc4245_sysfs_remove_groups(client);
 	kfree(data);
 
 	return 0;
diff --git a/include/linux/i2c/ltc4245.h b/include/linux/i2c/ltc4245.h
new file mode 100644
index 0000000..56bda4b
--- /dev/null
+++ b/include/linux/i2c/ltc4245.h
@@ -0,0 +1,21 @@
+/*
+ * Platform Data for LTC4245 hardware monitor chip
+ *
+ * Copyright (c) 2010 Ira W. Snyder <iws@ovro.caltech.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef LINUX_LTC4245_H
+#define LINUX_LTC4245_H
+
+#include <linux/types.h>
+
+struct ltc4245_platform_data {
+	bool use_extra_gpios;
+};
+
+#endif /* LINUX_LTC4245_H */
-- 
1.6.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
