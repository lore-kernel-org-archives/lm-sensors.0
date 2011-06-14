From: Donggeun Kim <dg77.kim@samsung.com>
Date: Tue, 14 Jun 2011 05:36:06 +0000
Subject: [lm-sensors] [PATCH v7] drivers/hwmon NTC Thermistor Initial
Message-Id: <1308029766-3254-1-git-send-email-dg77.kim@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for NTC Thermistor series. In this release, the
following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
and NCP15WL333. This driver is based on the datasheet of MURATA.

The driver in the patch does conversion from the raw ADC value
(either voltage or resistence) to temperature. In order to use
voltage values as input, the circuit schematics should be provided
with the platform data. A compensation table for each type of thermistor
is provided for the conversion.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>

--
Updates
v7
- move header file location
- rename header and driver file
- style fixes
v6
- updated Documentation/hwmon/ntc
- style fixes
v5
- use binary search on sorted table
- removed unnecessary attributes
- style fixes
v4
- put in alphabetic order in Kconfig/Makefile
- handle additional error cases
- remove the exported function
v3
- style fixes
- removed symbol exports
- avoid divide-by-zero
- omitted files added (Kconfig/Makefile)
- removed unnecessary codes
- return error values, not default values for errors.
v2
- added Documentation/hwmon/ntc
- followed hwmon sysfs
- detached the monitoring service
(thank you for the comments, Guenter Roeck)
---
 Documentation/hwmon/ntc_thermistor           |   95 +++++
 drivers/hwmon/Kconfig                        |   13 +
 drivers/hwmon/Makefile                       |    1 +
 drivers/hwmon/ntc_thermistor.c               |  477 ++++++++++++++++++++++++++
 include/linux/platform_data/ntc_thermistor.h |   53 +++
 5 files changed, 639 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ntc_thermistor
 create mode 100644 drivers/hwmon/ntc_thermistor.c
 create mode 100644 include/linux/platform_data/ntc_thermistor.h

diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_thermistor
new file mode 100644
index 0000000..2ee3e0d
--- /dev/null
+++ b/Documentation/hwmon/ntc_thermistor
@@ -0,0 +1,95 @@
+Kernel driver ntc_thermistor
+========+
+Supported thermistors:
+* Murata NTC Thermistors "Chip" Type
+  Prefix: 'ncp'
+  NCPxxWB473: NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473
+  NCPxxWL333: NCP15WL333
+  Datasheet: Publicly available at Murata
+
+Other NTC thermistors can be supported simply by adding compensation
+tables; e.g., NCP15WL333 support is added by the table ncpXXwl333.
+
+Authors:
+	MyungJoo Ham <myungjoo.ham@samsung.com>
+
+Description
+-----------
+
+The NTC thermistor is a simple thermistor that requires users to provide the
+resistance and lookup the corresponding compensation table to get the
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
+are suitable or the user can get the resistance directly, the user should
+provide read_ohm and _not_ provide the others.
+
+Sysfs Interface
+---------------
+name		the mandatory global attribute, the thermistor name.
+
+temp1_type	always 4 (thermistor)
+		RO
+
+temp1_input	measure the temperature and provide the measured value.
+		(reading this file initiates the reading procedure.)
+		RO
+
+Note that each NTC thermistor has only _one_ thermistor; thus, only temp1 exists.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 16db83c..ebf0b74 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -767,6 +767,19 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.
 
+config SENSORS_NTC_THERMISTOR
+	tristate "NTC thermistor support"
+	help
+	  This driver supports NTC thermistors sensor reading and its
+	  interpretation. The driver can also monitor the temperature and
+	  send notifications about the temperature.
+
+	  Currently, this driver supports
+	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ntc-thermistor.
+
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	select HWMON_VID
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 28061cf..e4ab597 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
+obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
new file mode 100644
index 0000000..494137b
--- /dev/null
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -0,0 +1,477 @@
+/*
+ * ntc_thermistor.c - NTC Thermistors
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
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/math64.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+
+#include <linux/platform_data/ntc_thermistor.h>
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+struct ntc_compensation {
+	int		temp_C;
+	unsigned int	ohm;
+};
+
+/*
+ * A compensation table should be sorted by the values of .ohm
+ * in descending order.
+ * The following compensation tables are from the specification of Murata NTC
+ * Thermistors Datasheet
+ */
+const struct ntc_compensation ncpXXwb473[] = {
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
+const struct ntc_compensation ncpXXwl333[] = {
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
+	const struct ntc_compensation *comp;
+	struct device *dev;
+	int n_comp;
+	char name[PLATFORM_NAME_SIZE];
+	int maxtemp;
+	int mintemp;
+};
+
+static inline u64 div64_u64_safe(u64 dividend, u64 divisor)
+{
+	if (divisor = 0 && dividend = 0)
+		return 0;
+	if (divisor = 0)
+		return UINT_MAX;
+	return div64_u64(dividend, divisor);
+}
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
+	if (mV = 0) {
+		if (pdata->connect = NTC_CONNECTED_POSITIVE)
+			return UINT_MAX;
+		return 0;
+	}
+	if (mV >= pmV)
+		return (pdata->connect = NTC_CONNECTED_POSITIVE) ?
+			0 : UINT_MAX;
+
+	if (pdata->connect = NTC_CONNECTED_POSITIVE && puO = 0)
+		N = div64_u64_safe(pdO * (pmV - mV), mV);
+	else if (pdata->connect = NTC_CONNECTED_GROUND && pdO = 0)
+		N = div64_u64_safe(puO * mV, pmV - mV);
+	else if (pdata->connect = NTC_CONNECTED_POSITIVE)
+		N = div64_u64_safe(pdO * puO * (pmV - mV),
+				puO * mV - pdO * (pmV - mV));
+	else
+		N = div64_u64_safe(pdO * puO * mV, pdO * (pmV - mV) - puO * mV);
+
+	return (unsigned int) N;
+}
+
+static int lookup_comp(struct ntc_data *data,
+		unsigned int ohm, int *i_low, int *i_high)
+{
+	int start, end, mid;
+
+	/* Do a binary search on compensation table */
+	start = 0;
+	end = data->n_comp;
+
+	while (end > start) {
+		mid = start + (end - start) / 2;
+		if (data->comp[mid].ohm < ohm)
+			end = mid;
+		else if (data->comp[mid].ohm > ohm)
+			start = mid + 1;
+		else
+			break;
+	}
+
+	if (mid = 0) {
+		if (data->comp[mid].ohm > ohm) {
+			*i_high = mid;
+			*i_low = mid + 1;
+			return 0;
+		} else {
+			*i_low = mid;
+			*i_high = -1;
+			return -EINVAL;
+		}
+	}
+	if (mid = (data->n_comp - 1)) {
+		if (data->comp[mid].ohm <= ohm) {
+			*i_low = mid;
+			*i_high = mid - 1;
+			return 0;
+		} else {
+			*i_low = -1;
+			*i_high = mid;
+			return -EINVAL;
+		}
+	}
+
+	if (data->comp[mid].ohm <= ohm) {
+		*i_low = mid;
+		*i_high = mid - 1;
+	}
+	if (data->comp[mid].ohm > ohm) {
+		*i_low = mid + 1;
+		*i_high = mid;
+	}
+
+	return 0;
+}
+
+static int get_temp_mC(struct ntc_data *data, unsigned int ohm, int *temp)
+{
+	int low, high;
+	int ret;
+
+	ret = lookup_comp(data, ohm, &low, &high);
+	if (ret) {
+		/* Unable to use linear approximation */
+		if (low != -1)
+			*temp = data->comp[low].temp_C * 1000;
+		else if (high != -1)
+			*temp = data->comp[high].temp_C * 1000;
+		else
+			return ret;
+	} else {
+		*temp = data->comp[low].temp_C * 1000 +
+			((data->comp[high].temp_C - data->comp[low].temp_C) *
+			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
+			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
+	}
+
+	return 0;
+}
+
+static int _ntc_thermistor_read(struct ntc_data *data, int *temp)
+{
+	int ret;
+	int read_ohm, read_uV;
+	unsigned int ohm = 0;
+
+	if (data->pdata->read_ohm) {
+		read_ohm = data->pdata->read_ohm();
+		if (read_ohm < 0)
+			return -EINVAL;
+		ohm = (unsigned int)read_ohm;
+	}
+
+	if (data->pdata->read_uV) {
+		read_uV = data->pdata->read_uV();
+		if (read_uV < 0)
+			return -EINVAL;
+		ohm = get_ohm_of_thermistor(data, (unsigned int)read_uV);
+	}
+
+	ret = get_temp_mC(data, ohm, temp);
+	if (ret) {
+		dev_dbg(data->dev, "Sensor reading function not available.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t ntc_show_name(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->name);
+}
+
+static ssize_t ntc_show_type(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "4\n");
+}
+
+static ssize_t ntc_show_temp(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ntc_data *data = dev_get_drvdata(dev);
+	int temp, ret;
+
+	ret = _ntc_thermistor_read(data, &temp);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%d\n", temp);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);
+static DEVICE_ATTR(name, S_IRUGO, ntc_show_name, NULL);
+
+static struct attribute *ntc_attributes[] = {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_temp1_type.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ntc_attr_group = {
+	.attrs = ntc_attributes,
+};
+
+static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
+{
+	struct ntc_data *data;
+	struct ntc_thermistor_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0, i;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform init data supplied.\n");
+		return -ENODEV;
+	}
+
+	/* Either one of the two is required. */
+	if (!pdata->read_uV && !pdata->read_ohm) {
+		dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
+				"Need either one of the two.\n");
+		return -EINVAL;
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
+		return -EINVAL;
+	}
+
+	data = kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = &pdev->dev;
+	data->pdata = pdata;
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
+		goto err;
+	}
+
+	data->mintemp = INT_MAX;
+	data->maxtemp = INT_MIN;
+
+	/*
+	 * The compensation table is sorted by ohm value. Although it is
+	 * normally assumed that the temperature value monotonically
+	 * increases or decreases with the ohm value, but there could be
+	 * different thermistors.
+	 */
+	for (i = 0; i < data->n_comp; i++) {
+		if (data->comp[i].temp_C > data->maxtemp)
+			data->maxtemp = data->comp[i].temp_C;
+		if (data->comp[i].temp_C < data->mintemp)
+			data->mintemp = data->comp[i].temp_C;
+	}
+
+	if (data->mintemp != INT_MAX || data->maxtemp != INT_MIN) {
+		dev_err(data->dev, "error in compensation table\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, data);
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
+	dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully probed.\n",
+			pdev->name, pdev->id, pdev->id_entry->name,
+			pdev->id_entry->driver_data);
+	return 0;
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
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
+	platform_set_drvdata(pdev, NULL);
+
+	kfree(data);
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
+
+module_init(ntc_thermistor_init);
+
+static void __exit ntc_thermistor_cleanup(void)
+{
+	platform_driver_unregister(&ntc_thermistor_driver);
+}
+
+module_exit(ntc_thermistor_cleanup);
+
+MODULE_DESCRIPTION("NTC Thermistor Driver");
+MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("ntc-thermistor");
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/platform_data/ntc_thermistor.h
new file mode 100644
index 0000000..abd2862
--- /dev/null
+++ b/include/linux/platform_data/ntc_thermistor.h
@@ -0,0 +1,53 @@
+/*
+ * ntc_thermistor.h - NTC Thermistors
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
+struct ntc_thermistor_platform_data {
+	/*
+	 * One (not both) of read_uV and read_ohm should be provided and only
+	 * one of the two should be provided.
+	 * Both functions should return negative value for an error case.
+	 *
+	 * pullup_uV, pullup_ohm, pulldown_ohm, and connect are required to use
+	 * read_uV()
+	 *
+	 * How to setup pullup_ohm, pulldown_ohm, and connect is
+	 * described at Documentation/hwmon/ntc
+	 *
+	 * pullup/down_ohm: 0 for infinite / not-connected
+	 */
+	int (*read_uV)(void);
+	unsigned int pullup_uV;
+
+	unsigned int pullup_ohm;
+	unsigned int pulldown_ohm;
+	enum { NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND } connect;
+
+	int (*read_ohm)(void);
+};
+
+#endif /* _LINUX_NTC_H */
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
