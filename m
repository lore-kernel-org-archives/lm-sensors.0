From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 20 Mar 2013 22:21:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: Move the IIO client driver for hwmon out of staging
Message-Id: <1363818079-31470-1-git-send-email-jic23@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org, Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>

This driver uses channel maps, defined either through device tree
or platform data, to create a hwmon driver which acts as a client
for the underlying IIO device channels.  Thus a general purpose
IIO adc driver can be used to provide hardware monitoring using a subset
of its channels.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Guenter Roeck <linux@roeck-us.net>

--
 The only non move changes here concern the description and changes to the
 dependencies to IIO explicit and hwmon implicit.

 I'm proposing moving this into hwmon on the basis of placing drivers
 based on what they provide rather than what their underlying hardware
 is.

 drivers/hwmon/Kconfig           |   9 ++
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/iio_hwmon.c       | 196 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/Kconfig     |   8 --
 drivers/staging/iio/Makefile    |   2 -
 drivers/staging/iio/iio_hwmon.c | 196 ----------------------------------------
 6 files changed, 206 insertions(+), 206 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 89ac1cb..96e00c9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -499,6 +499,15 @@ config SENSORS_IBMPEX
 	  This driver can also be built as a module.  If so, the module
 	  will be called ibmpex.
 
+config SENSORS_IIO_HWMON
+      	tristate "Hwmon driver that uses channels specified via iio maps"
+	depends on IIO
+	help
+	  This is a platform driver that in combination with a suitable
+	  map allows IIO devices to provide basic hwmon functionality
+	  for those channels specified in the map.  This map can be provided
+	  either via platform data or the device tree bindings.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8d6d97e..a87fdab 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
+obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
 obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
new file mode 100644
index 0000000..aafa453
--- /dev/null
+++ b/drivers/hwmon/iio_hwmon.c
@@ -0,0 +1,196 @@
+/* Hwmon client for industrial I/O devices
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/of.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
+
+/**
+ * struct iio_hwmon_state - device instance state
+ * @channels:		filled with array of channels from iio
+ * @num_channels:	number of channels in channels (saves counting twice)
+ * @hwmon_dev:		associated hwmon device
+ * @attr_group:	the group of attributes
+ * @attrs:		null terminated array of attribute pointers.
+ */
+struct iio_hwmon_state {
+	struct iio_channel *channels;
+	int num_channels;
+	struct device *hwmon_dev;
+	struct attribute_group attr_group;
+	struct attribute **attrs;
+};
+
+/*
+ * Assumes that IIO and hwmon operate in the same base units.
+ * This is supposed to be true, but needs verification for
+ * new channel types.
+ */
+static ssize_t iio_hwmon_read_val(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	int result;
+	int ret;
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct iio_hwmon_state *state = dev_get_drvdata(dev);
+
+	ret = iio_read_channel_processed(&state->channels[sattr->index],
+					&result);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	const char *name = "iio_hwmon";
+
+	if (dev->of_node && dev->of_node->name)
+		name = dev->of_node->name;
+
+	return sprintf(buf, "%s\n", name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static int iio_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_hwmon_state *st;
+	struct sensor_device_attribute *a;
+	int ret, i;
+	int in_i = 1, temp_i = 1, curr_i = 1;
+	enum iio_chan_type type;
+	struct iio_channel *channels;
+
+	channels = iio_channel_get_all(dev);
+	if (IS_ERR(channels))
+		return PTR_ERR(channels);
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (st = NULL)
+		return -ENOMEM;
+
+	st->channels = channels;
+
+	/* count how many attributes we have */
+	while (st->channels[st->num_channels].indio_dev)
+		st->num_channels++;
+
+	st->attrs = devm_kzalloc(dev,
+				 sizeof(*st->attrs) * (st->num_channels + 2),
+				 GFP_KERNEL);
+	if (st->attrs = NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+
+	for (i = 0; i < st->num_channels; i++) {
+		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
+		if (a = NULL) {
+			ret = -ENOMEM;
+			goto error_release_channels;
+		}
+
+		sysfs_attr_init(&a->dev_attr.attr);
+		ret = iio_get_channel_type(&st->channels[i], &type);
+		if (ret < 0)
+			goto error_release_channels;
+
+		switch (type) {
+		case IIO_VOLTAGE:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "in%d_input",
+							  in_i++);
+			break;
+		case IIO_TEMP:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "temp%d_input",
+							  temp_i++);
+			break;
+		case IIO_CURRENT:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "curr%d_input",
+							  curr_i++);
+			break;
+		default:
+			ret = -EINVAL;
+			goto error_release_channels;
+		}
+		if (a->dev_attr.attr.name = NULL) {
+			ret = -ENOMEM;
+			goto error_release_channels;
+		}
+		a->dev_attr.show = iio_hwmon_read_val;
+		a->dev_attr.attr.mode = S_IRUGO;
+		a->index = i;
+		st->attrs[i] = &a->dev_attr.attr;
+	}
+	st->attrs[st->num_channels] = &dev_attr_name.attr;
+	st->attr_group.attrs = st->attrs;
+	platform_set_drvdata(pdev, st);
+	ret = sysfs_create_group(&dev->kobj, &st->attr_group);
+	if (ret < 0)
+		goto error_release_channels;
+
+	st->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(st->hwmon_dev)) {
+		ret = PTR_ERR(st->hwmon_dev);
+		goto error_remove_group;
+	}
+	return 0;
+
+error_remove_group:
+	sysfs_remove_group(&dev->kobj, &st->attr_group);
+error_release_channels:
+	iio_channel_release_all(st->channels);
+	return ret;
+}
+
+static int iio_hwmon_remove(struct platform_device *pdev)
+{
+	struct iio_hwmon_state *st = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(st->hwmon_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
+	iio_channel_release_all(st->channels);
+
+	return 0;
+}
+
+static struct of_device_id iio_hwmon_of_match[] = {
+	{ .compatible = "iio-hwmon", },
+	{ }
+};
+
+static struct platform_driver __refdata iio_hwmon_driver = {
+	.driver = {
+		.name = "iio_hwmon",
+		.owner = THIS_MODULE,
+		.of_match_table = iio_hwmon_of_match,
+	},
+	.probe = iio_hwmon_probe,
+	.remove = iio_hwmon_remove,
+};
+
+module_platform_driver(iio_hwmon_driver);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
+MODULE_DESCRIPTION("IIO to hwmon driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index dc26717..db4d6dc 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -4,14 +4,6 @@
 menu "IIO staging drivers"
 	depends on IIO
 
-config IIO_ST_HWMON
-	tristate "Hwmon driver that uses channels specified via iio maps"
-	depends on HWMON
-	help
-	  This is a platform driver that in combination with a suitable
-	  map allows IIO devices to provide  basic hwmon functionality
-	  for those channels specified in the map.
-
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 158e0a0..d871061 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -9,8 +9,6 @@ iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
 
 obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 
-obj-$(CONFIG_IIO_ST_HWMON) += iio_hwmon.o
-
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
deleted file mode 100644
index aafa453..0000000
--- a/drivers/staging/iio/iio_hwmon.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/* Hwmon client for industrial I/O devices
- *
- * Copyright (c) 2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/platform_device.h>
-#include <linux/hwmon.h>
-#include <linux/of.h>
-#include <linux/hwmon-sysfs.h>
-#include <linux/iio/consumer.h>
-#include <linux/iio/types.h>
-
-/**
- * struct iio_hwmon_state - device instance state
- * @channels:		filled with array of channels from iio
- * @num_channels:	number of channels in channels (saves counting twice)
- * @hwmon_dev:		associated hwmon device
- * @attr_group:	the group of attributes
- * @attrs:		null terminated array of attribute pointers.
- */
-struct iio_hwmon_state {
-	struct iio_channel *channels;
-	int num_channels;
-	struct device *hwmon_dev;
-	struct attribute_group attr_group;
-	struct attribute **attrs;
-};
-
-/*
- * Assumes that IIO and hwmon operate in the same base units.
- * This is supposed to be true, but needs verification for
- * new channel types.
- */
-static ssize_t iio_hwmon_read_val(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
-{
-	int result;
-	int ret;
-	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
-	struct iio_hwmon_state *state = dev_get_drvdata(dev);
-
-	ret = iio_read_channel_processed(&state->channels[sattr->index],
-					&result);
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", result);
-}
-
-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	const char *name = "iio_hwmon";
-
-	if (dev->of_node && dev->of_node->name)
-		name = dev->of_node->name;
-
-	return sprintf(buf, "%s\n", name);
-}
-
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
-static int iio_hwmon_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct iio_hwmon_state *st;
-	struct sensor_device_attribute *a;
-	int ret, i;
-	int in_i = 1, temp_i = 1, curr_i = 1;
-	enum iio_chan_type type;
-	struct iio_channel *channels;
-
-	channels = iio_channel_get_all(dev);
-	if (IS_ERR(channels))
-		return PTR_ERR(channels);
-
-	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
-	if (st = NULL)
-		return -ENOMEM;
-
-	st->channels = channels;
-
-	/* count how many attributes we have */
-	while (st->channels[st->num_channels].indio_dev)
-		st->num_channels++;
-
-	st->attrs = devm_kzalloc(dev,
-				 sizeof(*st->attrs) * (st->num_channels + 2),
-				 GFP_KERNEL);
-	if (st->attrs = NULL) {
-		ret = -ENOMEM;
-		goto error_release_channels;
-	}
-
-	for (i = 0; i < st->num_channels; i++) {
-		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
-		if (a = NULL) {
-			ret = -ENOMEM;
-			goto error_release_channels;
-		}
-
-		sysfs_attr_init(&a->dev_attr.attr);
-		ret = iio_get_channel_type(&st->channels[i], &type);
-		if (ret < 0)
-			goto error_release_channels;
-
-		switch (type) {
-		case IIO_VOLTAGE:
-			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
-							  "in%d_input",
-							  in_i++);
-			break;
-		case IIO_TEMP:
-			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
-							  "temp%d_input",
-							  temp_i++);
-			break;
-		case IIO_CURRENT:
-			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
-							  "curr%d_input",
-							  curr_i++);
-			break;
-		default:
-			ret = -EINVAL;
-			goto error_release_channels;
-		}
-		if (a->dev_attr.attr.name = NULL) {
-			ret = -ENOMEM;
-			goto error_release_channels;
-		}
-		a->dev_attr.show = iio_hwmon_read_val;
-		a->dev_attr.attr.mode = S_IRUGO;
-		a->index = i;
-		st->attrs[i] = &a->dev_attr.attr;
-	}
-	st->attrs[st->num_channels] = &dev_attr_name.attr;
-	st->attr_group.attrs = st->attrs;
-	platform_set_drvdata(pdev, st);
-	ret = sysfs_create_group(&dev->kobj, &st->attr_group);
-	if (ret < 0)
-		goto error_release_channels;
-
-	st->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(st->hwmon_dev)) {
-		ret = PTR_ERR(st->hwmon_dev);
-		goto error_remove_group;
-	}
-	return 0;
-
-error_remove_group:
-	sysfs_remove_group(&dev->kobj, &st->attr_group);
-error_release_channels:
-	iio_channel_release_all(st->channels);
-	return ret;
-}
-
-static int iio_hwmon_remove(struct platform_device *pdev)
-{
-	struct iio_hwmon_state *st = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(st->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
-	iio_channel_release_all(st->channels);
-
-	return 0;
-}
-
-static struct of_device_id iio_hwmon_of_match[] = {
-	{ .compatible = "iio-hwmon", },
-	{ }
-};
-
-static struct platform_driver __refdata iio_hwmon_driver = {
-	.driver = {
-		.name = "iio_hwmon",
-		.owner = THIS_MODULE,
-		.of_match_table = iio_hwmon_of_match,
-	},
-	.probe = iio_hwmon_probe,
-	.remove = iio_hwmon_remove,
-};
-
-module_platform_driver(iio_hwmon_driver);
-
-MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("IIO to hwmon driver");
-MODULE_LICENSE("GPL v2");
-- 
1.8.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
