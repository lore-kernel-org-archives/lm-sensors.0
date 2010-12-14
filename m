From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Tue, 14 Dec 2010 06:30:03 +0000
Subject: [lm-sensors] [PATCH v2] drivers/hwmon NTC Thermistor Initial Support
Message-Id: <1292308203-4627-1-git-send-email-myungjoo.ham@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for NTC Thermistor series. In this initial
release, the followings are supported: NCP15WB473, NCP18WB473,
NCP03WB473, and NCP15WL333. This driver is based on the datasheet of
MURATA.

The driver in the patch does conversion from the raw ADC value
(either voltage or resistence) to temperature. In order to use
voltage value as the input, the cirsuit schematics should be provided
with platform data. Compensation tables for each type of thermistor
is provided for the convertion.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--
Updates from v1
- added Documentation/hwmon/ntc
- followed hwmon sysfs
- detached the monitoring service
(thank you for the comments, Guenter Roeck)
---
 Documentation/hwmon/ntc |  112 +++++++++++
 drivers/hwmon/ntc.c     |  485 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ntc.h     |   58 ++++++
 3 files changed, 655 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ntc
 create mode 100644 drivers/hwmon/ntc.c
 create mode 100644 include/linux/ntc.h

diff --git a/Documentation/hwmon/ntc b/Documentation/hwmon/ntc
new file mode 100644
index 0000000..a85bf34
--- /dev/null
+++ b/Documentation/hwmon/ntc
@@ -0,0 +1,112 @@
+Kernel driver ntc
+========+
+Supported thermistors:
+* Murata NTC Thermistors "Chip" Type
+  Prefix: 'ncp'
+  NCPxxWB473: NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473
+  NCPxxWL333: NCP15WL333
+  Datasheet: Publicly available at Murata
+
+Other NTC thermisors including types other than "chip" can be supported
+simply by adding compensation tables. (NCP15WL333 is added for an example)
+
+Authors:
+	MyungJoo Ham <myungjoo.ham@samsung.com>
+
+Description
+-----------
+
+The NTC thermistor is a simple thermistor that requires users to measure the
+resistence and lookup the corresponding compensation table to get the
+temperature input.
+
+The NTC driver provides lookup tables with a linear approximation function
+and four circuit models with an option not to use any of the four models.
+
+The four circuit models provided are:
+
+	$: resister, [TH]: the thermistor
+
+ 1. connect = NTC_CONNECTED_POSITIVE, pullup_ohm > 0
+
+   [pullup_uV]
+       |    |
+      [TH]  $ (pullup_ohm)
+       |    |
+       +----+-----------------------[read_uV]
+       |
+       $ (pulldown_ohm)
+       |
+      --- (ground)
+
+ 2. connect = NTC_CONNECTED_POSITIVE, pullup_ohm = 0 (not-connected)
+
+   [pullup_uV]
+       |
+      [TH]
+       |
+       +----------------------------[read_uV]
+       |
+       $ (pulldown_ohm)
+       |
+      --- (ground)
+
+ 3. connect = NTC_CONNECTED_GROUND, pulldown_ohm > 0
+
+   [pullup_uV]
+       |
+       $ (pullup_ohm)
+       |
+       +----+-----------------------[read_uV]
+       |    |
+      [TH]  $ (pulldown_ohm)
+       |    |
+      -------- (ground)
+
+ 4. connect = NTC_CONNECTED_GROUND, pulldown_ohm = 0 (not-connected)
+
+   [pullup_uV]
+       |
+       $ (pullup_ohm)
+       |
+       +----------------------------[read_uV]
+       |
+      [TH]
+       |
+      --- (ground)
+
+When one of the four circuit models is used, read_uV, pullup_uV, pullup_ohm,
+pulldown_ohm, and connect should be provided. When none of the four models
+are suitable or the user can get the resistence directly, the user should
+provide read_ohm and do _not_ provide the others.
+
+Sysfs Interface
+---------------
+name		the mandatory global attribute, the thermistor name.
+
+temp1_type	always 4 (thermistor)
+		RO
+
+temp1_crit	the highest temperature possible from the compensation table.
+		RO
+
+temp1_lcrit	the lowest temperature possible from the compensation table.
+		RO
+
+temp1_input	the measures temperature
+		RO
+
+temp1_highest	the highest temperature measured
+		RO
+
+temp1_lowest	the lowest temperature measured
+		RO
+
+temp1_reset_history	clear the highest/lowest temperature history
+			WO
+
+temp_reset_history	clear the highest/lowest temperature history
+			WO
+
+Note that each NTC thermistor has only _one_ thermistor; thus, only temp1 exists.
diff --git a/drivers/hwmon/ntc.c b/drivers/hwmon/ntc.c
new file mode 100644
index 0000000..7e806b2
--- /dev/null
+++ b/drivers/hwmon/ntc.c
@@ -0,0 +1,485 @@
+/*
+ * ntc.c - NTC Thermistors
+ *
+ *  Copyright (C) 2010 Samsung Electronics
+ *  MyungJoo Ham <myungjoo.ham@samsung.com>
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
+ *
+ * In the initial version, it only supports ncp15wb473. However, adding
+ * device ids and compenstation tables provides support for more chips
+ * easily.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/math64.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+
+#include <linux/ntc.h>
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+struct ntc_compensation {
+	int		temp_C;
+	unsigned int	ohm;
+};
+
+/* Specification from Murata NTC Thermistors Datasheet */
+struct ntc_compensation ncpXXwb473[] = {
+	{ .temp_C	= -40, .ohm	= 1747920 },
+	{ .temp_C	= -35, .ohm	= 1245428 },
+	{ .temp_C	= -30, .ohm	= 898485 },
+	{ .temp_C	= -25, .ohm	= 655802 },
+	{ .temp_C	= -20, .ohm	= 483954 },
+	{ .temp_C	= -15, .ohm	= 360850 },
+	{ .temp_C	= -10, .ohm	= 271697 },
+	{ .temp_C	= -5, .ohm	= 206463 },
+	{ .temp_C	= 0, .ohm	= 158214 },
+	{ .temp_C	= 5, .ohm	= 122259 },
+	{ .temp_C	= 10, .ohm	= 95227 },
+	{ .temp_C	= 15, .ohm	= 74730 },
+	{ .temp_C	= 20, .ohm	= 59065 },
+	{ .temp_C	= 25, .ohm	= 47000 },
+	{ .temp_C	= 30, .ohm	= 37643 },
+	{ .temp_C	= 35, .ohm	= 30334 },
+	{ .temp_C	= 40, .ohm	= 24591 },
+	{ .temp_C	= 45, .ohm	= 20048 },
+	{ .temp_C	= 50, .ohm	= 16433 },
+	{ .temp_C	= 55, .ohm	= 13539 },
+	{ .temp_C	= 60, .ohm	= 11209 },
+	{ .temp_C	= 65, .ohm	= 9328 },
+	{ .temp_C	= 70, .ohm	= 7798 },
+	{ .temp_C	= 75, .ohm	= 6544 },
+	{ .temp_C	= 80, .ohm	= 5518 },
+	{ .temp_C	= 85, .ohm	= 4674 },
+	{ .temp_C	= 90, .ohm	= 3972 },
+	{ .temp_C	= 95, .ohm	= 3388 },
+	{ .temp_C	= 100, .ohm	= 2902 },
+	{ .temp_C	= 105, .ohm	= 2494 },
+	{ .temp_C	= 110, .ohm	= 2150 },
+	{ .temp_C	= 115, .ohm	= 1860 },
+	{ .temp_C	= 120, .ohm	= 1615 },
+	{ .temp_C	= 125, .ohm	= 1406 },
+};
+struct ntc_compensation ncpXXwl333[] = {
+	{ .temp_C	= -40, .ohm	= 1610154 },
+	{ .temp_C	= -35, .ohm	= 1130850 },
+	{ .temp_C	= -30, .ohm	= 802609 },
+	{ .temp_C	= -25, .ohm	= 575385 },
+	{ .temp_C	= -20, .ohm	= 416464 },
+	{ .temp_C	= -15, .ohm	= 304219 },
+	{ .temp_C	= -10, .ohm	= 224193 },
+	{ .temp_C	= -5, .ohm	= 166623 },
+	{ .temp_C	= 0, .ohm	= 124850 },
+	{ .temp_C	= 5, .ohm	= 94287 },
+	{ .temp_C	= 10, .ohm	= 71747 },
+	{ .temp_C	= 15, .ohm	= 54996 },
+	{ .temp_C	= 20, .ohm	= 42455 },
+	{ .temp_C	= 25, .ohm	= 33000 },
+	{ .temp_C	= 30, .ohm	= 25822 },
+	{ .temp_C	= 35, .ohm	= 20335 },
+	{ .temp_C	= 40, .ohm	= 16115 },
+	{ .temp_C	= 45, .ohm	= 12849 },
+	{ .temp_C	= 50, .ohm	= 10306 },
+	{ .temp_C	= 55, .ohm	= 8314 },
+	{ .temp_C	= 60, .ohm	= 6746 },
+	{ .temp_C	= 65, .ohm	= 5503 },
+	{ .temp_C	= 70, .ohm	= 4513 },
+	{ .temp_C	= 75, .ohm	= 3721 },
+	{ .temp_C	= 80, .ohm	= 3084 },
+	{ .temp_C	= 85, .ohm	= 2569 },
+	{ .temp_C	= 90, .ohm	= 2151 },
+	{ .temp_C	= 95, .ohm	= 1809 },
+	{ .temp_C	= 100, .ohm	= 1529 },
+	{ .temp_C	= 105, .ohm	= 1299 },
+	{ .temp_C	= 110, .ohm	= 1108 },
+	{ .temp_C	= 115, .ohm	= 949 },
+	{ .temp_C	= 120, .ohm	= 817 },
+	{ .temp_C	= 125, .ohm	= 707 },
+};
+
+struct ntc_data {
+	struct device *hwmon_dev;
+	struct ntc_thermistor_platform_data *pdata;
+	struct ntc_compensation *comp;
+	struct device *dev;
+	int n_comp;
+	char name[PLATFORM_NAME_SIZE];
+
+	int highest;
+	int lowest;
+};
+
+static unsigned int get_ohm_of_thermistor(struct ntc_data *data,
+		unsigned int uV)
+{
+	struct ntc_thermistor_platform_data *pdata = data->pdata;
+	u64 mV = uV / 1000;
+	u64 pmV = pdata->pullup_uV / 1000;
+	u64 N, puO, pdO;
+	puO = pdata->pullup_ohm;
+	pdO = pdata->pulldown_ohm;
+
+	if (mV >= pmV)
+		return (pdata->connect = NTC_CONNECTED_POSITIVE) ?
+			0 : UINT_MAX;
+
+	if (pdata->connect = NTC_CONNECTED_POSITIVE &&
+			puO = 0)
+		N = div64_u64(pdO * (pmV - mV), mV);
+	else if (pdata->connect = NTC_CONNECTED_GROUND &&
+			pdO = 0)
+		N = div64_u64(puO * mV, pmV - mV);
+	else if (pdata->connect = NTC_CONNECTED_POSITIVE)
+		N = div64_u64(pdO * puO * (pmV - mV),
+				puO * mV -
+				pdO * (pmV - mV));
+	else
+		N = div64_u64(pdO * puO * mV,
+				pdO * (pmV - mV) -
+				puO * mV);
+
+	return (u32) N;
+}
+
+static int lookup_comp(struct ntc_data *data,
+		unsigned int ohm, int *i_low, int *i_high)
+{
+	/*  greatest lower bound and least upper bound */
+	int glb = -1, lub = -1;
+	unsigned int glb_ohm = 0, lub_ohm = 0;
+	int i;
+	for (i = 0; i < data->n_comp; i++) {
+		if (data->comp[i].ohm <= ohm &&
+				(glb = -1 || glb_ohm < data->comp[i].ohm)) {
+			glb = i;
+			glb_ohm = data->comp[i].ohm;
+		}
+
+		if (data->comp[i].ohm >= ohm &&
+				(lub = -1 || lub_ohm > data->comp[i].ohm)) {
+			lub = i;
+			lub_ohm = data->comp[i].ohm;
+		}
+	}
+	*i_low = glb;
+	*i_high = lub;
+
+	if (glb = -1 || lub = -1)
+		return -EINVAL;
+	return 0;
+}
+
+static int get_temp_mC(struct ntc_data *data,
+		unsigned int ohm)
+{
+	int low, high;
+	int ret;
+
+	ret = lookup_comp(data, ohm, &low, &high);
+	if (ret) {
+		/* Unable to use linear approximation */
+		if (low != -1)
+			return data->comp[low].temp_C * 1000;
+		if (high != -1)
+			return data->comp[high].temp_C * 1000;
+
+		pr_err("ntc thermistor: data not valid: %dohm.\n", ohm);
+		return 25 * 1000; /* Assume 25C */
+	}
+
+	return data->comp[low].temp_C * 1000 +
+		((data->comp[high].temp_C - data->comp[low].temp_C) * 1000 *
+		((int)ohm - (int)data->comp[low].ohm)) /
+		((int)data->comp[high].ohm - (int)data->comp[low].ohm);
+}
+
+static int _ntc_thermistor_read(struct ntc_data *data)
+{
+	int temp = INT_MIN;
+	if (data->pdata->read_ohm)
+		temp = get_temp_mC(data, data->pdata->read_ohm());
+
+	if (data->pdata->read_uV)
+		temp = get_temp_mC(data,
+				get_ohm_of_thermistor(data,
+					data->pdata->read_uV()));
+	if (temp > data->highest)
+		data->highest = temp;
+	if (temp < data->lowest)
+		data->lowest = temp;
+	if (temp != INT_MIN)
+		return temp;
+
+	dev_err(data->dev, "Sensor reading function not available.\n");
+	return 25*1000;
+}
+
+int ntc_thermistor_read(struct device *dev)
+{
+	return _ntc_thermistor_read(dev_get_drvdata(dev));
+}
+EXPORT_SYMBOL_GPL(ntc_thermistor_read);
+
+static ssize_t ntc_show_name(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->name);
+}
+
+static ssize_t ntc_show_type(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "4\n");
+}
+
+static ssize_t ntc_show_temp_max(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	int maxtemp = INT_MIN;
+	int i;
+	for (i = 0; i < data->n_comp; i++)
+		if (data->comp[i].temp_C > maxtemp)
+			maxtemp = data->comp[i].temp_C;
+	return sprintf(buf, "%d\n", maxtemp * 1000);
+}
+
+static ssize_t ntc_show_temp_min(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	int mintemp = INT_MAX;
+	int i;
+	for (i = 0; i < data->n_comp; i++)
+		if (data->comp[i].temp_C < mintemp)
+			mintemp = data->comp[i].temp_C;
+	return sprintf(buf, "%d\n", mintemp * 1000);
+}
+
+static ssize_t ntc_show_temp(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int temp = ntc_thermistor_read(dev);
+	return sprintf(buf, "%d\n", temp);
+}
+
+static ssize_t ntc_show_temp_highest(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	if (data->highest = INT_MIN)
+		_ntc_thermistor_read(data);
+	return sprintf(buf, "%d\n", data->highest);
+}
+
+static ssize_t ntc_show_temp_lowest(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	if (data->lowest = INT_MAX)
+		_ntc_thermistor_read(data);
+	return sprintf(buf, "%d\n", data->lowest);
+}
+
+static ssize_t ntc_reset_history(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	data->highest = INT_MIN;
+	data->lowest = INT_MAX;
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, ntc_show_temp_max, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_lcrit, S_IRUGO, ntc_show_temp_min, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_highest, S_IRUGO, ntc_show_temp_highest,
+		NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_lowest, S_IRUGO, ntc_show_temp_lowest,
+		NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_reset_history, S_IWUSR, NULL,
+		ntc_reset_history, 0);
+static SENSOR_DEVICE_ATTR(temp_reset_history, S_IWUSR, NULL,
+		ntc_reset_history, 0);
+static DEVICE_ATTR(name, S_IRUGO, ntc_show_name, NULL);
+
+static struct attribute *ntc_attributes[] = {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_temp1_type.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_lcrit.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_highest.dev_attr.attr,
+	&sensor_dev_attr_temp1_lowest.dev_attr.attr,
+	&sensor_dev_attr_temp1_reset_history.dev_attr.attr,
+	&sensor_dev_attr_temp_reset_history.dev_attr.attr,
+	NULL,
+};
+static const struct attribute_group ntc_attr_group = {
+	.attrs = ntc_attributes,
+};
+
+static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
+{
+	struct ntc_data *data;
+	struct ntc_thermistor_platform_data *pdata +		pdev->dev.platform_data;
+	int ret = 0;
+
+	data = kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform init data supplied.\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	data->dev = &pdev->dev;
+	data->pdata = pdata;
+	data->highest = INT_MIN;
+	data->lowest = INT_MAX;
+
+	ret = sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
+	if (ret) {
+		dev_err(data->dev, "unable to create sysfs files\n");
+		goto err;
+	}
+
+	data->hwmon_dev = hwmon_device_register(data->dev);
+	if (IS_ERR_OR_NULL(data->hwmon_dev)) {
+		dev_err(data->dev, "unable to register as hwmon device.\n");
+		ret = -EINVAL;
+		goto err_after_sysfs;
+	}
+
+	/* Either one of the two is required. */
+	if (!pdata->read_uV && !pdata->read_ohm) {
+		dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
+				"Need either one of the two.\n");
+		ret = -EINVAL;
+		goto err_after_hwmon;
+	}
+
+	if (pdata->read_uV && pdata->read_ohm) {
+		dev_warn(&pdev->dev, "Only one of read_uV and read_ohm "
+				"is needed; ignoring read_uV.\n");
+		pdata->read_uV = NULL;
+	}
+
+	if (pdata->read_uV && (pdata->pullup_uV = 0 ||
+				(pdata->pullup_ohm = 0 && pdata->connect =
+				 NTC_CONNECTED_GROUND) ||
+				(pdata->pulldown_ohm = 0 && pdata->connect =
+				 NTC_CONNECTED_POSITIVE) ||
+				(pdata->connect != NTC_CONNECTED_POSITIVE &&
+				 pdata->connect != NTC_CONNECTED_GROUND))) {
+		dev_err(&pdev->dev, "Required data to use read_uV not "
+				"supplied.\n");
+		ret = -EINVAL;
+		goto err_after_hwmon;
+	}
+
+	strncpy(data->name, pdev->id_entry->name, PLATFORM_NAME_SIZE);
+
+	switch (pdev->id_entry->driver_data) {
+	case TYPE_NCPXXWB473:
+		data->comp = ncpXXwb473;
+		data->n_comp = ARRAY_SIZE(ncpXXwb473);
+		break;
+	case TYPE_NCPXXWL333:
+		data->comp = ncpXXwl333;
+		data->n_comp = ARRAY_SIZE(ncpXXwl333);
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
+				pdev->id_entry->driver_data,
+				pdev->id_entry->name);
+		ret = -EINVAL;
+		goto err_after_hwmon;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully probed.\n",
+			pdev->name, pdev->id,
+			pdev->id_entry->name,
+			pdev->id_entry->driver_data);
+	return 0;
+err_after_hwmon:
+	hwmon_device_unregister(data->hwmon_dev);
+err_after_sysfs:
+	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
+err:
+	kfree(data);
+	return ret;
+}
+
+static int __devexit ntc_thermistor_remove(struct platform_device *pdev)
+{
+	struct ntc_data *data = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->hwmon_dev); /* Root of unload warning */
+	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
+
+	kfree(data);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct platform_device_id ntc_thermistor_id[] = {
+	{ "ncp15wb473", TYPE_NCPXXWB473 },
+	{ "ncp18wb473", TYPE_NCPXXWB473 },
+	{ "ncp21wb473", TYPE_NCPXXWB473 },
+	{ "ncp03wb473", TYPE_NCPXXWB473 },
+	{ "ncp15wl333", TYPE_NCPXXWL333 },
+	{ },
+};
+
+static struct platform_driver ntc_thermistor_driver = {
+	.driver = {
+		.name = "ntc-thermistor",
+		.owner = THIS_MODULE,
+	},
+	.probe = ntc_thermistor_probe,
+	.remove = __devexit_p(ntc_thermistor_remove),
+	.id_table = ntc_thermistor_id,
+};
+
+static int __init ntc_thermistor_init(void)
+{
+	return platform_driver_register(&ntc_thermistor_driver);
+}
+module_init(ntc_thermistor_init);
+
+static void __exit ntc_thermistor_cleanup(void)
+{
+	platform_driver_unregister(&ntc_thermistor_driver);
+}
+module_exit(ntc_thermistor_cleanup);
+
+MODULE_DESCRIPTION("NTC Thermistor Driver");
+MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ntc.h b/include/linux/ntc.h
new file mode 100644
index 0000000..3487d6b
--- /dev/null
+++ b/include/linux/ntc.h
@@ -0,0 +1,58 @@
+/*
+ * ntc.h - NTC Thermistors
+ *
+ *  Copyright (C) 2010 Samsung Electronics
+ *  MyungJoo Ham <myungjoo.ham@samsung.com>
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
+ */
+#ifndef _LINUX_NTC_H
+#define _LINUX_NTC_H
+
+enum ntc_thermistor_type {
+	TYPE_NCPXXWB473,
+	TYPE_NCPXXWL333,
+};
+
+enum ntc_status {
+	NTC_NORMAL = 0,
+	NTC_TOO_HOT,
+	NTC_TOO_COLD,
+};
+
+struct ntc_thermistor_platform_data {
+	/* To use read_uV, set pullup_uV, pullup_ohm, pulldown_ohm,
+	 * and connect, but you don't need read_ohm.
+	 * To use read_ohm, you don't need read_ohm and all of those.
+	 **/
+	unsigned int (*read_uV)(void);
+	unsigned int pullup_uV;
+
+	/*
+	 * How to setup pullup_ohm, pulldown_ohm, and connect is
+	 * described at Documentation/hwmon/ntc
+	 *
+	 * pullup/down_ohm: 0 for infinite / not-connected
+	 **/
+	unsigned int pullup_ohm;
+	unsigned int pulldown_ohm;
+	enum {NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND} connect;
+
+	unsigned int (*read_ohm)(void);
+};
+
+extern int ntc_thermistor_read(struct device *dev);
+
+#endif /* _LINUX_NTC_H */
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
