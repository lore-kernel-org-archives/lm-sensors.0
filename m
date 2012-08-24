From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 14:05:00 +0000
Subject: [lm-sensors] [RFC PATCH 4/8] hwmon: Add DA906x hardware monitoring support.
Message-Id: <201208241505@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241500@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241500@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

DA906x PMIC provides ADC for voltage and temperature monitoring.

The driver provides results of following ADC channels:
 - in0 - system voltage (2500 - 5500 mV)
 - in1 - universal voltage channel #1 (0 - 2500 mV)
 - in2 - universal voltage channel #2 (0 - 2500 mV)
 - in3 - universal voltage channel #3 (0 - 2500 mV)
 - in4 - backup battery voltage (0 - 5000 mV)
 - temp1 - PMIC internal junction temperature (-88 - 333 Celcius degrees)

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/hwmon/Kconfig        |    6 +
 drivers/hwmon/Makefile       |    1 +
 drivers/hwmon/da906x-hwmon.c |  393 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 400 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/da906x-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b0a2e4c..7abc9a0 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1373,6 +1373,12 @@ config SENSORS_WM8350
 	  This driver can also be built as a module.  If so, the module
 	  will be called wm8350-hwmon.
 
+config SENSORS_DA906X
+	tristate "DA906X HWMON device drivers"
+	depends on MFD_DA906X
+	help
+	  Support for the HWMON DA906X device driver.
+
 config SENSORS_ULTRA45
 	tristate "Sun Ultra45 PIC16F747"
 	depends on SPARC64
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 7aa9811..ffbe151 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
+obj-$(CONFIG_SENSORS_DA906X)	+= da906x-hwmon.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
diff --git a/drivers/hwmon/da906x-hwmon.c b/drivers/hwmon/da906x-hwmon.c
new file mode 100644
index 0000000..8ece931
--- /dev/null
+++ b/drivers/hwmon/da906x-hwmon.c
@@ -0,0 +1,393 @@
+/*
+ * HW Monitor support for Dialog DA906X PMIC series
+ *
+ * Copyright 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
+ *         Michal Hajduk <michal.hajduk@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/pdata.h>
+
+/* ADC resolutions for manual and auto modes */
+#define DA906X_ADC_RES		\
+		(1 << (DA906X_ADC_RES_L_BITS + DA906X_ADC_RES_M_BITS))
+#define DA906X_ADC_MAX		(DA906X_ADC_RES - 1)
+#define	DA906X_ADC_AUTO_RES	(1 << DA906X_ADC_RES_M_BITS)
+#define	DA906X_ADC_AUTO_MAX	(DA906X_ADC_AUTO_RES - 1)
+
+/* Define interpolation table to calculate ADC values  */
+struct i_table {
+	int x0;
+	int a;
+	int b;
+};
+#define ILINE(x1, x2, y1, y2)	{ \
+		.x0 = (x1), \
+		.a = ((y2) - (y1)) * DA906X_ADC_RES / ((x2) - (x1)), \
+		.b = (y1) - ((y2) - (y1)) * (x1) / ((x2) - (x1)), \
+	}
+
+struct channel_info {
+	const char *name;
+	const struct i_table *tbl;
+	int tbl_max;
+	u16 reg_auto_en;
+};
+
+enum da906x_adc {
+	DA906X_VSYS,
+	DA906X_ADCIN1,
+	DA906X_ADCIN2,
+	DA906X_ADCIN3,
+	DA906X_TJUNC,
+	DA906X_VBBAT,
+
+	DA906X_CHAN_NUM
+};
+
+static const struct i_table vsys_tbl[] = {
+	ILINE(0, DA906X_ADC_MAX, 2500, 5500)
+};
+
+static const struct i_table adcin_tbl[] = {
+	ILINE(0, DA906X_ADC_MAX, 0, 2500)
+};
+
+static const struct i_table tjunc_tbl[] = {
+	ILINE(0, DA906X_ADC_MAX, 333, -86)
+};
+
+static const struct i_table vbbat_tbl[] = {
+	ILINE(0, DA906X_ADC_MAX, 0, 5000)
+};
+
+static const struct channel_info da906x_channels[] = {
+	[DA906X_VSYS]	= { "VSYS",
+			    vsys_tbl, ARRAY_SIZE(vsys_tbl) - 1,
+			    DA906X_REG_VSYS_RES },
+	[DA906X_ADCIN1]	= { "ADCIN1",
+			    adcin_tbl,	ARRAY_SIZE(adcin_tbl) - 1,
+			    DA906X_REG_ADCIN1_RES },
+	[DA906X_ADCIN2]	= { "ADCIN2",
+			    adcin_tbl,	ARRAY_SIZE(adcin_tbl) - 1,
+			    DA906X_REG_ADCIN2_RES },
+	[DA906X_ADCIN3]	= { "ADCIN3",
+			    adcin_tbl,	ARRAY_SIZE(adcin_tbl) - 1,
+			    DA906X_REG_ADCIN3_RES },
+	[DA906X_TJUNC]	= { "TJUNC",
+			    tjunc_tbl,	ARRAY_SIZE(tjunc_tbl) - 1 },
+	[DA906X_VBBAT]	= { "VBBAT",
+			    vbbat_tbl,	ARRAY_SIZE(vbbat_tbl) - 1}
+};
+#define DA906X_ADC_AUTO_MODE_SUPPORT_MASK	(DA906X_ADC_AUTO_VSYS_EN | \
+						 DA906X_ADC_AUTO_AD1_EN | \
+						 DA906X_ADC_AUTO_AD2_EN | \
+						 DA906X_ADC_AUTO_AD3_EN)
+
+struct da906x_hwmon {
+	struct da906x *da906x;
+	struct device *class_dev;
+	struct completion man_adc_rdy;	/* Manual read completion flag */
+	struct mutex hwmon_mutex;	/* Queue concurent manual reads */
+	int irq;
+	u8 adc_auto_en;     /* Bitmask of channels with auto mode enabled */
+	s8 tjunc_offset;    /* Calibration offset for junction temperature */
+};
+
+int da906x_adc_convert(int channel, int x)
+{
+	const struct channel_info *info = &da906x_channels[channel];
+	int i, ret;
+
+	for (i = info->tbl_max; i > 0; i--)
+		if (info->tbl[i].x0 <= x)
+			break;
+
+	ret = info->tbl[i].a * x;
+	if (ret >= 0)
+		ret += DA906X_ADC_RES / 2;
+	else
+		ret -= DA906X_ADC_RES / 2;
+	ret = ret / DA906X_ADC_RES + info->tbl[i].b;
+	return ret;
+}
+
+static int da906x_adc_manual_read(struct da906x_hwmon *hwmon, int channel)
+{
+	int ret;
+	u8 data[2];
+
+	mutex_lock(&hwmon->hwmon_mutex);
+
+	init_completion(&hwmon->man_adc_rdy);
+
+	/* Start measurment on selected channel */
+	data[0] = (channel << DA906X_ADC_MUX_SHIFT) & DA906X_ADC_MUX_MASK;
+	data[0] |= DA906X_ADC_MAN;
+	ret = da906x_reg_update(hwmon->da906x, DA906X_REG_ADC_MAN,
+				DA906X_ADC_MUX_MASK | DA906X_ADC_MAN, data[0]);
+	if (ret < 0)
+		goto out;
+
+	/* Wait for interrupt from ADC */
+	ret = wait_for_completion_timeout(&hwmon->man_adc_rdy,
+					  msecs_to_jiffies(1000));
+	if (ret = 0) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Get results */
+	ret = da906x_block_read(hwmon->da906x, DA906X_REG_ADC_RES_L, 2, data);
+	if (ret < 0)
+		goto out;
+	ret = (data[0] & DA906X_ADC_RES_L_MASK) >> DA906X_ADC_RES_L_SHIFT;
+	ret |= data[1] << DA906X_ADC_RES_L_BITS;
+out:
+	mutex_unlock(&hwmon->hwmon_mutex);
+	return ret;
+}
+
+static int da906x_adc_auto_read(struct da906x *da906x, int channel)
+{
+	const struct channel_info *info = &da906x_channels[channel];
+
+	return da906x_reg_read(da906x, info->reg_auto_en);
+}
+
+static irqreturn_t da906x_hwmon_irq_handler(int irq, void *irq_data)
+{
+	struct da906x_hwmon *hwmon = irq_data;
+
+	complete(&hwmon->man_adc_rdy);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t da906x_adc_read(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	struct da906x_hwmon *hwmon = dev_get_drvdata(dev);
+	int channel = to_sensor_dev_attr(devattr)->index;
+	int val;
+
+	if (hwmon->adc_auto_en & (1 << channel)) {
+		val = da906x_adc_auto_read(hwmon->da906x, channel);
+		if (val < 0)
+			return val;
+
+		val *= DA906X_ADC_RES / DA906X_ADC_AUTO_RES;
+		val = da906x_adc_convert(channel, val);
+	} else {
+		val = da906x_adc_manual_read(hwmon, channel);
+		if (val < 0)
+			return val;
+
+		if (channel = DA906X_TJUNC)
+			val += hwmon->tjunc_offset;
+		val = da906x_adc_convert(channel, val);
+	}
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t da906x_show_name(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, DA906X_DRVNAME_HWMON "\n");
+}
+
+static ssize_t da906x_show_label(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	const struct channel_info *info;
+
+	info = &da906x_channels[to_sensor_dev_attr(devattr)->index];
+	return sprintf(buf, "%s\n", info->name);
+}
+
+/* Vsys voltage */
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO,
+			  da906x_adc_read, NULL, DA906X_VSYS);
+static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO,
+			  da906x_show_label, NULL, DA906X_VSYS);
+
+/* Universal ADC channel #1 */
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
+			  da906x_adc_read, NULL, DA906X_ADCIN1);
+static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO,
+			  da906x_show_label, NULL, DA906X_ADCIN1);
+
+/* Universal ADC channel #2 */
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO,
+			  da906x_adc_read, NULL,
+			  DA906X_ADCIN2);
+static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO,
+			  da906x_show_label, NULL, DA906X_ADCIN2);
+
+/* Universal ADC channel #3 */
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO,
+			  da906x_adc_read, NULL, DA906X_ADCIN3);
+static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO,
+			  da906x_show_label, NULL, DA906X_ADCIN3);
+
+/* Backup battery voltage */
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO,
+			  da906x_adc_read, NULL, DA906X_VBBAT);
+static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO,
+			  da906x_show_label, NULL, DA906X_VBBAT);
+
+/* Junction temperature */
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+			  da906x_adc_read, NULL, DA906X_TJUNC);
+
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO,
+			  da906x_show_label, NULL, DA906X_TJUNC);
+
+/* Device name */
+static DEVICE_ATTR(name, S_IRUGO, da906x_show_name, NULL);
+
+static struct attribute *da906x_attributes[] = {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_label.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group da906x_attr_group = {
+	.attrs = da906x_attributes,
+};
+
+static int __devinit da906x_hwmon_probe(struct platform_device *pdev)
+{
+	struct da906x *da906x = dev_get_drvdata(pdev->dev.parent);
+	struct da906x_pdata *da906x_pdata = dev_get_platdata(da906x->dev);
+	struct da906x_hwmon *hwmon;
+	int ret;
+
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da906x_hwmon),
+			     GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	mutex_init(&hwmon->hwmon_mutex);
+	init_completion(&hwmon->man_adc_rdy);
+	hwmon->da906x = da906x;
+
+	ret = da906x_reg_read(da906x, DA906X_REG_ADC_CONT);
+	if (ret < 0)
+		return ret;
+	hwmon->adc_auto_en = ret & DA906X_ADC_AUTO_MODE_SUPPORT_MASK;
+
+	if (da906x_pdata->flags & DA906X_FLG_FORCE_IN0_MANUAL_MODE)
+		hwmon->adc_auto_en &= ~DA906X_ADC_AUTO_VSYS_EN;
+	else if (da906x_pdata->flags & DA906X_FLG_FORCE_IN0_AUTO_MODE)
+		hwmon->adc_auto_en |= DA906X_ADC_AUTO_VSYS_EN;
+
+	if (da906x_pdata->flags & DA906X_FLG_FORCE_IN1_MANUAL_MODE)
+		hwmon->adc_auto_en &= ~DA906X_ADC_AUTO_AD1_EN;
+	else if (da906x_pdata->flags & DA906X_FLG_FORCE_IN1_AUTO_MODE)
+		hwmon->adc_auto_en |= DA906X_ADC_AUTO_AD1_EN;
+
+	if (da906x_pdata->flags & DA906X_FLG_FORCE_IN2_MANUAL_MODE)
+		hwmon->adc_auto_en &= ~DA906X_ADC_AUTO_AD2_EN;
+	else if (da906x_pdata->flags & DA906X_FLG_FORCE_IN2_AUTO_MODE)
+		hwmon->adc_auto_en |= DA906X_ADC_AUTO_AD2_EN;
+
+	if (da906x_pdata->flags & DA906X_FLG_FORCE_IN3_MANUAL_MODE)
+		hwmon->adc_auto_en &= ~DA906X_ADC_AUTO_AD3_EN;
+	else if (da906x_pdata->flags & DA906X_FLG_FORCE_IN3_AUTO_MODE)
+		hwmon->adc_auto_en |= DA906X_ADC_AUTO_AD3_EN;
+
+	ret = da906x_reg_update(da906x, DA906X_REG_ADC_CONT,
+				DA906X_ADC_AUTO_MODE_SUPPORT_MASK,
+				hwmon->adc_auto_en);
+	if (ret < 0)
+		return ret;
+
+	hwmon->class_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(hwmon->class_dev))
+		return PTR_ERR(hwmon->class_dev);
+
+	hwmon->irq = platform_get_irq_byname(pdev, DA906X_DRVNAME_HWMON);
+	ret = devm_request_threaded_irq(&pdev->dev, hwmon->irq, NULL,
+					da906x_hwmon_irq_handler,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					"HWMON", hwmon);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request IRQ.\n");
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, hwmon);
+
+	ret = da906x_reg_read(da906x, DA906X_REG_T_OFFSET);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Could not read temp1 callibration offset.\n");
+	else
+		hwmon->tjunc_offset = (s8)ret;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &da906x_attr_group);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	hwmon_device_unregister(hwmon->class_dev);
+	return ret;
+}
+
+static int __devexit da906x_hwmon_remove(struct platform_device *pdev)
+{
+	struct da906x_hwmon *hwmon = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(hwmon->class_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &da906x_attr_group);
+
+	return 0;
+}
+
+static struct platform_driver da906x_hwmon_driver = {
+	.probe = da906x_hwmon_probe,
+	.remove = __devexit_p(da906x_hwmon_remove),
+	.driver = {
+		.name = DA906X_DRVNAME_HWMON,
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(da906x_hwmon_driver);
+
+MODULE_DESCRIPTION("DA906X Hardware monitoring");
+MODULE_AUTHOR("Krystian Garbaciak <krystian.garbaciak@diasemi.com>, Michal Hajduk <michal.hajduk@diasemi.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("paltform:" DA906X_DRVNAME_HWMON);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
