From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Mon, 29 Nov 2010 06:38:04 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon NTC Thermistor Initial Support
Message-Id: <1291012684-15386-1-git-send-email-myungjoo.ham@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This patch adds support for NTC Thermistor series. In this initial
release, the followings are supported: NCP15WB473, NCP18WB473,
NCP03WB473, and NCP15WL333. This driver is based on the datasheet of
MURATA.

The driver in the patch includes:
1. Conversion from the raw ADC value (either voltage or resistence) to
temperature. In order to use voltage value as the input, the cirsuit
schematics should be provided with platform data.
2. Monitor the temperature periodically and calls notifier provided with
the platform data.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/hwmon/Kconfig  |   10 +
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/ntc.c    |  652 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/ntc.h    |  154 ++++++++++++
 4 files changed, 817 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/ntc.c
 create mode 100644 include/linux/ntc.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 97499d0..639f362 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1173,6 +1173,16 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 PMIC.
=20
+config SENSORS_NTC_THERMISTOR
+	bool "NTC thermistor support"
+	help
+	  This driver supports NTC thermistors sensor reading and its
+	  interpretation. The driver can also monitor the temperature and
+	  send notifications about the temperature.
+
+	  Currently, among those many NTC thermistors, this driver supports
+	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
+
 if ACPI
=20
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e3c2484..6cf160f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+=3D w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+=3D w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+=3D wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+=3D wm8350-hwmon.o
+obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+=3D ntc.o
=20
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS +=3D -DDEBUG
diff --git a/drivers/hwmon/ntc.c b/drivers/hwmon/ntc.c
new file mode 100644
index 0000000..2a44c83
--- /dev/null
+++ b/drivers/hwmon/ntc.c
@@ -0,0 +1,652 @@
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
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
+#include <linux/notifier.h>
+#include <linux/workqueue.h>
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
+struct ntc_compensation ncpXXwb473[] =3D {
+	{ .temp_C	=3D -40, .ohm	=3D 1747920 },
+	{ .temp_C	=3D -35, .ohm	=3D 1245428 },
+	{ .temp_C	=3D -30, .ohm	=3D 898485 },
+	{ .temp_C	=3D -25, .ohm	=3D 655802 },
+	{ .temp_C	=3D -20, .ohm	=3D 483954 },
+	{ .temp_C	=3D -15, .ohm	=3D 360850 },
+	{ .temp_C	=3D -10, .ohm	=3D 271697 },
+	{ .temp_C	=3D -5, .ohm	=3D 206463 },
+	{ .temp_C	=3D 0, .ohm	=3D 158214 },
+	{ .temp_C	=3D 5, .ohm	=3D 122259 },
+	{ .temp_C	=3D 10, .ohm	=3D 95227 },
+	{ .temp_C	=3D 15, .ohm	=3D 74730 },
+	{ .temp_C	=3D 20, .ohm	=3D 59065 },
+	{ .temp_C	=3D 25, .ohm	=3D 47000 },
+	{ .temp_C	=3D 30, .ohm	=3D 37643 },
+	{ .temp_C	=3D 35, .ohm	=3D 30334 },
+	{ .temp_C	=3D 40, .ohm	=3D 24591 },
+	{ .temp_C	=3D 45, .ohm	=3D 20048 },
+	{ .temp_C	=3D 50, .ohm	=3D 16433 },
+	{ .temp_C	=3D 55, .ohm	=3D 13539 },
+	{ .temp_C	=3D 60, .ohm	=3D 11209 },
+	{ .temp_C	=3D 65, .ohm	=3D 9328 },
+	{ .temp_C	=3D 70, .ohm	=3D 7798 },
+	{ .temp_C	=3D 75, .ohm	=3D 6544 },
+	{ .temp_C	=3D 80, .ohm	=3D 5518 },
+	{ .temp_C	=3D 85, .ohm	=3D 4674 },
+	{ .temp_C	=3D 90, .ohm	=3D 3972 },
+	{ .temp_C	=3D 95, .ohm	=3D 3388 },
+	{ .temp_C	=3D 100, .ohm	=3D 2902 },
+	{ .temp_C	=3D 105, .ohm	=3D 2494 },
+	{ .temp_C	=3D 110, .ohm	=3D 2150 },
+	{ .temp_C	=3D 115, .ohm	=3D 1860 },
+	{ .temp_C	=3D 120, .ohm	=3D 1615 },
+	{ .temp_C	=3D 125, .ohm	=3D 1406 },
+};
+struct ntc_compensation ncpXXwl333[] =3D {
+	{ .temp_C	=3D -40, .ohm	=1610154 },
+	{ .temp_C	=3D -35, .ohm	=1130850 },
+	{ .temp_C	=3D -30, .ohm	=802609 },
+	{ .temp_C	=3D -25, .ohm	W5385 },
+	{ .temp_C	=3D -20, .ohm	A6464 },
+	{ .temp_C	=3D -15, .ohm	04219 },
+	{ .temp_C	=3D -10, .ohm	"4193 },
+	{ .temp_C	=3D -5, .ohm	=166623 },
+	{ .temp_C	=3D 0, .ohm	=124850 },
+	{ .temp_C	=3D 5, .ohm	=94287 },
+	{ .temp_C	=3D 10, .ohm	q747 },
+	{ .temp_C	=3D 15, .ohm	T996 },
+	{ .temp_C	=3D 20, .ohm	B455 },
+	{ .temp_C	=3D 25, .ohm	3000 },
+	{ .temp_C	=3D 30, .ohm	%822 },
+	{ .temp_C	=3D 35, .ohm	 335 },
+	{ .temp_C	=3D 40, .ohm	=16115 },
+	{ .temp_C	=3D 45, .ohm	=12849 },
+	{ .temp_C	=3D 50, .ohm	=10306 },
+	{ .temp_C	=3D 55, .ohm	=8314 },
+	{ .temp_C	=3D 60, .ohm	g46 },
+	{ .temp_C	=3D 65, .ohm	U03 },
+	{ .temp_C	=3D 70, .ohm	E13 },
+	{ .temp_C	=3D 75, .ohm	721 },
+	{ .temp_C	=3D 80, .ohm	084 },
+	{ .temp_C	=3D 85, .ohm	%69 },
+	{ .temp_C	=3D 90, .ohm	!51 },
+	{ .temp_C	=3D 95, .ohm	=1809 },
+	{ .temp_C	=3D 100, .ohm	=1529 },
+	{ .temp_C	=3D 105, .ohm	=1299 },
+	{ .temp_C	=3D 110, .ohm	=1108 },
+	{ .temp_C	=3D 115, .ohm	=949 },
+	{ .temp_C	=3D 120, .ohm	=817 },
+	{ .temp_C	=3D 125, .ohm	p7 },
+};
+
+struct ntc_data {
+	struct device *hwmon_dev;
+	struct ntc_thermistor_platform_data *pdata;
+	struct ntc_compensation *comp;
+	struct device *dev;
+	int n_comp;
+
+	struct mutex monitor_lock;
+	enum ntc_status status;
+	struct delayed_work work;
+	unsigned long interval_jiffies;
+};
+
+static unsigned int get_ohm_of_thermistor(struct ntc_data *data,
+		unsigned int uV)
+{
+	struct ntc_thermistor_platform_data *pdata =3D data->pdata;
+	u64 mV =3D uV / 1000;
+	u64 pmV =3D pdata->pullup_uV / 1000;
+	u64 N, puO, pdO;
+	puO =3D pdata->pullup_ohm;
+	pdO =3D pdata->pulldown_ohm;
+
+	if (mV >=3D pmV)
+		return (pdata->connect =3D NTC_CONNECTED_POSITIVE) ?
+			0 : UINT_MAX;
+
+	if (pdata->connect =3D NTC_CONNECTED_POSITIVE &&
+			puO =3D 0)
+		N =3D div64_u64(pdO * (pmV - mV), mV);
+	else if (pdata->connect =3D NTC_CONNECTED_GROUND &&
+			pdO =3D 0)
+		N =3D div64_u64(puO * mV, pmV - mV);
+	else if (pdata->connect =3D NTC_CONNECTED_POSITIVE)
+		N =3D div64_u64(pdO * puO * (pmV - mV),
+				puO * mV -
+				pdO * (pmV - mV));
+	else
+		N =3D div64_u64(pdO * puO * mV,
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
+	int glb =3D -1, lub =3D -1;
+	unsigned int glb_ohm =3D 0, lub_ohm =3D 0;
+	int i;
+	for (i =3D 0; i < data->n_comp; i++) {
+		if (data->comp[i].ohm <=3D ohm &&
+				(glb =3D -1 || glb_ohm < data->comp[i].ohm)) {
+			glb =3D i;
+			glb_ohm =3D data->comp[i].ohm;
+		}
+
+		if (data->comp[i].ohm >=3D ohm &&
+				(lub =3D -1 || lub_ohm > data->comp[i].ohm)) {
+			lub =3D i;
+			lub_ohm =3D data->comp[i].ohm;
+		}
+	}
+	*i_low =3D glb;
+	*i_high =3D lub;
+
+	if (glb =3D -1 || lub =3D -1)
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
+	ret =3D lookup_comp(data, ohm, &low, &high);
+	if (ret) {
+		/* Unable to use linear approximation */
+		if (low !=3D -1)
+			return data->comp[low].temp_C * 1000;
+		if (high !=3D -1)
+			return data->comp[high].temp_C * 1000;
+
+		pr_err("ntc thermistor: data not valid: %dohm.\n", ohm);
+		return 25 * 1000; /* Assume 25C */
+	}
+
+	return data->comp[low].temp_C * 1000 +
+		((data->comp[high].temp_C - data->comp[low].temp_C ) * 1000 *
+		((int)ohm - (int)data->comp[low].ohm)) /
+		((int)data->comp[high].ohm - (int)data->comp[low].ohm);
+}
+
+static int _ntc_thermistor_read(struct ntc_data *data);
+static int ntc_monitor_measure(struct ntc_data *data)
+{
+	struct ntc_temperature_monitor *mon =3D &data->pdata->monitor;
+	int measure, min =3D INT_MAX, max =3D INT_MIN;
+	int i;
+
+	measure =3D _ntc_thermistor_read(data);
+	for (i =3D 1; i < mon->number_of_measure; i++) {
+		int m =3D _ntc_thermistor_read(data);
+		measure +=3D m;
+		if (m < min)
+			min =3D m;
+		if (m > max)
+			max =3D m;
+	}
+
+	if (mon->number_of_measure >=3D 3 && mon->discard_extreme)
+		return (measure - min - max) / (mon->number_of_measure - 2) / 1000;
+
+	return measure / ((mon->number_of_measure > 1) ?
+			mon->number_of_measure : 1) / 1000;
+}
+
+static void ntc_monitor(struct work_struct *work)
+{
+	struct delayed_work *dwork +		container_of(work, struct delayed_work, wor=
k);
+	struct ntc_data *data =3D container_of(dwork, struct ntc_data, work);
+	struct ntc_temperature_monitor *mon =3D &data->pdata->monitor;
+
+	dev_dbg(data->dev, "NTC Monitor Event..\n");
+
+	/* Worth measure it? */
+	if (mon->notifier &&
+			(mon->too_hot < INT_MAX || mon->too_cold > INT_MIN)) {
+		mon->last_measure =3D ntc_monitor_measure(data);
+		dev_info(data->dev, "Temperature: %dC\n", mon->last_measure);
+
+		if (mon->last_measure >=3D mon->too_hot) {
+			srcu_notifier_call_chain(mon->notifier, 1, mon);
+			data->status =3D NTC_TOO_HOT;
+		} else if (mon->last_measure <=3D mon->too_cold) {
+			srcu_notifier_call_chain(mon->notifier, -1, mon);
+			data->status =3D NTC_TOO_COLD;
+		} else if (mon->last_measure >=3D mon->hot &&
+				data->status =3D NTC_TOO_HOT) {
+			srcu_notifier_call_chain(mon->notifier, 1, mon);
+			data->status =3D NTC_TOO_HOT;
+		} else if (mon->last_measure <=3D mon->cold &&
+				data->status =3D NTC_TOO_COLD) {
+			srcu_notifier_call_chain(mon->notifier, -1, mon);
+			data->status =3D NTC_TOO_COLD;
+		} else if (data->status =3D NTC_TOO_COLD ||
+				data->status =3D NTC_TOO_HOT) {
+			srcu_notifier_call_chain(mon->notifier, 0, mon);
+			data->status =3D NTC_NORMAL;
+		} else
+			data->status =3D NTC_NORMAL;
+	}
+
+	/* Appoint the next monitor execution */
+	mutex_lock(&data->monitor_lock);
+
+	if (data->interval_jiffies) {
+		cancel_delayed_work(&data->work);
+		schedule_delayed_work(&data->work, data->interval_jiffies);
+	}
+
+	mutex_unlock(&data->monitor_lock);
+}
+
+static ssize_t ntc_show_status(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct platform_device *pdev =3D container_of
+		(dev, struct platform_device, dev);
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	switch (data->status) {
+	case NTC_NORMAL:
+		return sprintf(buf, "normal\n");
+		break;
+	case NTC_TOO_HOT:
+		return sprintf(buf, "too hot\n");
+		break;
+	case NTC_TOO_COLD:
+		return sprintf(buf, "too cold\n");
+		break;
+	}
+	return -EINVAL;
+}
+
+static ssize_t ntc_show_temp(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct platform_device *pdev =3D container_of
+		(dev, struct platform_device, dev);
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	int temp =3D ntc_monitor_measure(data);
+	return sprintf(buf, "%d C\n", temp);
+}
+
+static ssize_t ntc_show_interval(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct platform_device *pdev =3D container_of
+		(dev, struct platform_device, dev);
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	return sprintf(buf, "%d ms\n", data->pdata->monitor.interval_ms);
+}
+
+static ssize_t ntc_set_interval(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct platform_device *pdev =3D container_of
+		(dev, struct platform_device, dev);
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	unsigned long val;
+	unsigned long jiffies;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	jiffies =3D msecs_to_jiffies(val);
+
+	mutex_lock(&data->monitor_lock);
+
+	data->interval_jiffies =3D jiffies;
+	cancel_delayed_work(&data->work);
+	if (jiffies > 0)
+		schedule_delayed_work(&data->work, jiffies);
+
+	mutex_unlock(&data->monitor_lock);
+
+	return count;
+}
+
+static ssize_t ntc_show_mon_cond(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int index =3D to_sensor_dev_attr(attr)->index;
+	struct platform_device *pdev =3D container_of
+		(dev, struct platform_device, dev);
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	int show =3D INT_MIN;
+	switch (index) {
+	case 0:
+		show =3D data->pdata->monitor.too_hot;
+		break;
+	case 1:
+		show =3D data->pdata->monitor.too_cold;
+		break;
+	case 2:
+		show =3D data->pdata->monitor.hot;
+		break;
+	case 3:
+		show =3D data->pdata->monitor.cold;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%d\n", show);
+}
+
+static ssize_t ntc_set_mon_cond(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int index =3D to_sensor_dev_attr(attr)->index;
+	struct platform_device *pdev =3D container_of
+		(dev, struct platform_device, dev);
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	long val;
+
+	if (strict_strtol(buf, 10, &val))
+		return -EINVAL;
+
+	switch (index) {
+	case 0:
+		data->pdata->monitor.too_hot =3D val;
+		break;
+	case 1:
+		data->pdata->monitor.too_cold =3D val;
+		break;
+	case 2:
+		data->pdata->monitor.hot =3D val;
+		break;
+	case 3:
+		data->pdata->monitor.cold =3D val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(status, S_IRUGO, ntc_show_status, NULL, 0);
+static SENSOR_DEVICE_ATTR(temperature, S_IRUGO, ntc_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(measure_interval, S_IWUSR | S_IRUGO,
+		ntc_show_interval, ntc_set_interval, 0);
+static SENSOR_DEVICE_ATTR(too_hot, S_IWUSR | S_IRUGO, ntc_show_mon_cond,
+		ntc_set_mon_cond, 0);
+static SENSOR_DEVICE_ATTR(too_cold, S_IWUSR | S_IRUGO, ntc_show_mon_cond,
+		ntc_set_mon_cond, 1);
+static SENSOR_DEVICE_ATTR(hot, S_IWUSR | S_IRUGO, ntc_show_mon_cond,
+		ntc_set_mon_cond, 2);
+static SENSOR_DEVICE_ATTR(cold, S_IWUSR | S_IRUGO, ntc_show_mon_cond,
+		ntc_set_mon_cond, 3);
+static struct attribute *ntc_attributes[] =3D {
+	&sensor_dev_attr_status.dev_attr.attr,
+	&sensor_dev_attr_temperature.dev_attr.attr,
+	&sensor_dev_attr_measure_interval.dev_attr.attr,
+	&sensor_dev_attr_too_hot.dev_attr.attr,
+	&sensor_dev_attr_too_cold.dev_attr.attr,
+	&sensor_dev_attr_hot.dev_attr.attr,
+	&sensor_dev_attr_cold.dev_attr.attr,
+	NULL,
+};
+static const struct attribute_group ntc_attr_group =3D {
+	.attrs =3D ntc_attributes,
+};
+
+static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
+{
+	struct ntc_data *data;
+	struct ntc_thermistor_platform_data *pdata +		pdev->dev.platform_data;
+	int ret =3D 0;
+
+	data =3D kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform init data supplied.\n");
+		ret =3D -ENODEV;
+		goto err;
+	}
+
+	data->dev =3D &pdev->dev;
+	data->pdata =3D pdata;
+	data->status =3D NTC_NORMAL;
+	mutex_init(&data->monitor_lock);
+
+	ret =3D sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
+	if (ret) {
+		dev_err(data->dev, "unable to create sysfs files\n");
+		goto err;
+	}
+
+	data->hwmon_dev =3D hwmon_device_register(data->dev);
+	if (IS_ERR_OR_NULL(data->hwmon_dev)) {
+		dev_err(data->dev, "unable to register as hwmon device.\n");
+		ret =3D -EINVAL;
+		goto err_after_sysfs;
+	}
+
+	/* Either one of the two is required. */
+	if (!pdata->read_uV && !pdata->read_ohm) {
+		dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
+				"Need either one of the two.\n");
+		ret =3D -EINVAL;
+		goto err_after_sysfs;
+	}
+
+	if (pdata->read_uV && pdata->read_ohm) {
+		dev_warn(&pdev->dev, "Only one of read_uV and read_ohm "
+				"is needed; ignoring read_uV.\n");
+		pdata->read_uV =3D NULL;
+	}
+
+	if (pdata->read_uV && (pdata->pullup_uV =3D 0 ||
+				(pdata->pullup_ohm =3D 0 && pdata->connect =3D NTC_CONNECTED_GROUND) ||
+				(pdata->pulldown_ohm =3D 0 && pdata->connect =3D NTC_CONNECTED_POSITIV=
E) ||
+				(pdata->connect !=3D NTC_CONNECTED_POSITIVE &&
+				 pdata->connect !=3D NTC_CONNECTED_GROUND))) {
+		dev_err(&pdev->dev, "Required data to use read_uV not "
+				"supplied.\n");
+		ret =3D -EINVAL;
+		goto err_after_sysfs;
+	}
+
+	switch (pdev->id_entry->driver_data) {
+	case TYPE_NCPXXWB473:
+		data->comp =3D ncpXXwb473;
+		data->n_comp =3D ARRAY_SIZE(ncpXXwb473);
+		break;
+	case TYPE_NCPXXWL333:
+		data->comp =3D ncpXXwl333;
+		data->n_comp =3D ARRAY_SIZE(ncpXXwl333);
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
+				pdev->id_entry->driver_data,
+				pdev->id_entry->name);
+		ret =3D -EINVAL;
+		goto err_after_sysfs;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	INIT_DELAYED_WORK(&data->work, ntc_monitor);
+
+	mutex_lock(&data->monitor_lock);
+
+	if (pdata->monitor.interval_ms) {
+		data->interval_jiffies +			msecs_to_jiffies(pdata->monitor.interval_ms);
+
+		if (data->interval_jiffies > 0)
+			schedule_delayed_work(&data->work, jiffies);
+		else
+			dev_warn(&pdev->dev, "interval_ms %u is too small and regarded as 0.\n",
+					pdata->monitor.interval_ms);
+	}
+
+	mutex_unlock(&data->monitor_lock);
+
+	dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully probed=
.\n",
+			pdev->name, pdev->id,
+			pdev->id_entry->name,
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
+	struct ntc_data *data =3D platform_get_drvdata(pdev);
+	kfree(data);
+	return 0;
+}
+
+static const struct platform_device_id ntc_thermistor_id[] =3D {
+	{ "ncp15wb473", TYPE_NCPXXWB473 },
+	{ "ncp18wb473", TYPE_NCPXXWB473 },
+	{ "ncp21wb473", TYPE_NCPXXWB473 },
+	{ "ncp03wb473", TYPE_NCPXXWB473 },
+	{ "ncp15wl333", TYPE_NCPXXWL333 },
+	{ },
+};
+
+static struct platform_driver ntc_thermistor_driver =3D {
+	.driver =3D {
+		.name =3D "ntc-thermistor",
+		.owner =3D THIS_MODULE,
+	},
+	.probe =3D ntc_thermistor_probe,
+	.remove =3D __devexit_p(ntc_thermistor_remove),
+	.id_table =3D ntc_thermistor_id,
+};
+
+static int __init ntc_thermistor_init(void)
+{
+	return platform_driver_register(&ntc_thermistor_driver);
+}
+device_initcall(ntc_thermistor_init);
+
+static void __exit ntc_thermistor_cleanup(void)
+{
+	platform_driver_unregister(&ntc_thermistor_driver);
+}
+module_exit(ntc_thermistor_cleanup);
+
+static int _ntc_thermistor_read(struct ntc_data *data)
+{
+	if (data->pdata->read_ohm)
+		return get_temp_mC(data, data->pdata->read_ohm());
+
+	if (data->pdata->read_uV)
+		return get_temp_mC(data,
+				get_ohm_of_thermistor(data,
+					data->pdata->read_uV()));
+
+	dev_err(data->dev, "Sensor reading function not available.\n");
+	return 25*1000;
+}
+
+int ntc_thermistor_read(struct device *dev)
+{
+	return _ntc_thermistor_read(dev_get_drvdata(dev));
+}
+
+void ntc_thermistor_monitor_set_too_hot(struct device *dev, int too_hot)
+{
+	struct ntc_data *data =3D dev_get_drvdata(dev);
+
+	mutex_lock(&data->monitor_lock);
+	data->pdata->monitor.too_hot =3D too_hot;
+	mutex_unlock(&data->monitor_lock);
+}
+
+void ntc_thermistor_monitor_set_too_cold(struct device *dev, int too_cold)
+{
+	struct ntc_data *data =3D dev_get_drvdata(dev);
+
+	mutex_lock(&data->monitor_lock);
+	data->pdata->monitor.too_cold =3D too_cold;
+	mutex_unlock(&data->monitor_lock);
+}
+
+int ntc_thermistor_monitor_start(struct device *dev, unsigned int interval=
_ms)
+{
+	struct ntc_data *data =3D dev_get_drvdata(dev);
+	unsigned long jiffies =3D msecs_to_jiffies(interval_ms);
+
+	mutex_lock(&data->monitor_lock);
+	data->pdata->monitor.interval_ms =3D interval_ms;
+	data->interval_jiffies =3D jiffies;
+
+	if (jiffies > 0) {
+		cancel_delayed_work(&data->work);
+		schedule_delayed_work(&data->work, jiffies);
+	}
+
+	mutex_unlock(&data->monitor_lock);
+
+	if (interval_ms > 0 && jiffies =3D 0)
+		return -EINVAL;
+	return 0;
+}
+
+MODULE_DESCRIPTION("NTC Thermistor Driver");
+MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/ntc.h b/include/linux/ntc.h
new file mode 100644
index 0000000..4515466
--- /dev/null
+++ b/include/linux/ntc.h
@@ -0,0 +1,154 @@
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
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
+	NTC_NORMAL =3D 0,
+	NTC_TOO_HOT,
+	NTC_TOO_COLD,
+};
+
+struct ntc_temperature_monitor {
+	unsigned int interval_ms; /* 0 to disable */
+
+	int too_hot;	/* INT_MAX to disable */
+	int hot;	/* denotes "recover" temp from too_hot */
+	int too_cold;	/* INT_MIN to disable */
+	int cold;	/* denotes "recover" temp from too_cold */
+
+	/* Monitor based on the average of multiple measurement */
+	int number_of_measure;
+	/* if number_of_measure >=3D 3, we may discard max and min */
+	bool discard_extreme;
+
+	int last_measure; /* The recently measure temperature */
+
+	struct srcu_notifier_head *notifier;
+	/*
+	 * Invoked if at least one of the following conditions meets:
+	 *	1. temp >=3D too_hot
+	 *	2. temp <=3D too_cold
+	 *	3. temp >=3D hot and was temp >=3D too_hot and never have
+	 *		recovered to temp < hot since then
+	 *	4. temp <=3D cold and was temp <=3D too_cold and never have
+	 *		recovered to temp > cold since then
+	 *	5. temp recovered to normal from an exception
+	 *		(from 1 or 3 to temp > too_cold && temp < hot
+	 *		OR
+	 *		 from 2 or 4 to temp < too_hot && temp > cold)
+	 */
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
+	/* pullup/down_ohm: 0 for infinite / not-connected */
+	unsigned int pullup_ohm;
+	unsigned int pulldown_ohm;
+	enum {NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND} connect;
+
+	/*
+	 * How to setup pullup_ohm, pulldown_ohm, connect
+	 * Note: $: resister, [TH]: thermistor
+	 *
+	 * 1. connect =3D NTC_CONNECTED_POSITIVE, pullup_ohm > 0
+	 *
+	 *   [pullup_uV]
+	 *       |    |
+	 *      [TH]  $ (pullup_ohm)
+	 *       |    |
+	 *       +----+-----------------------[read_uV]
+	 *       |
+	 *       $ (pulldown_ohm)
+	 *       |
+	 *      --- (ground)
+	 *
+	 * 2. connect =3D NTC_CONNECTED_POSITIVE, pullup_ohm =3D 0
+	 *
+	 *   [pullup_uV]
+	 *       |
+	 *      [TH]
+	 *       |
+	 *       +----------------------------[read_uV]
+	 *       |
+	 *       $ (pulldown_ohm)
+	 *       |
+	 *      --- (ground)
+	 *
+	 * 3. connect =3D NTC_CONNECTED_GROUND, pulldown_ohm > 0
+	 *
+	 *   [pullup_uV]
+	 *       |
+	 *       $ (pullup_ohm)
+	 *       |
+	 *       +----+-----------------------[read_uV]
+	 *       |    |
+	 *      [TH]  $ (pulldown_ohm)
+	 *       |    |
+	 *      -------- (ground)
+	 *
+	 * 4. connect =3D NTC_CONNECTED_GROUND, pulldown_ohm =3D 0
+	 *
+	 *   [pullup_uV]
+	 *       |
+	 *       $ (pullup_ohm)
+	 *       |
+	 *       +----------------------------[read_uV]
+	 *       |
+	 *      [TH]
+	 *       |
+	 *      --- (ground)
+	 */
+
+	unsigned int (*read_ohm)(void);
+
+	struct ntc_temperature_monitor monitor;
+};
+
+extern int ntc_thermistor_read(struct device *dev);
+
+extern void ntc_thermistor_monitor_set_too_hot(
+		struct device *dev, int too_hot);
+#define ntc_thermistor_monitor_unset_too_hot(dev)	\
+	ntc_thermistor_monitor_set_too_hot(dev, INT_MAX)
+
+extern void ntc_thermistor_monitor_set_too_cold(
+		struct device *dev, int too_cold);
+#define ntc_thermistor_monitor_unset_too_cold(dev)	\
+	ntc_thermistor_monitor_set_too_cold(dev, INT_MIN)
+
+extern int ntc_thermistor_monitor_start(
+		struct device *dev, unsigned int interval_ms);
+#define ntc_thermistor_monitor_stop(dev)	\
+	ntc_thermistor_monitor_start(dev, 0)
+
+#endif /* _LINUX_NTC_H */
--=20
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
