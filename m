From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 26 Sep 2011 15:07:50 +0000
Subject: [lm-sensors] [PATCH] hwmon/mc13xxx-adc: add support for the MC13892
Message-Id: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: David Jander <david.jander@protonic.nl>

[ukleinek: rebase, adapt Kconfig, rename driver file, remove
MODULE_ALIAS in favour of MODULE_DEVICE_TABLE]

Signed-off-by: David Jander <david.jander@protonic.nl>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/Kconfig       |    8 +-
 drivers/hwmon/Makefile      |    2 +-
 drivers/hwmon/mc13783-adc.c |  246 ---------------------------------------=
--
 drivers/hwmon/mc13xxx-adc.c |  255 +++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 260 insertions(+), 251 deletions(-)
 delete mode 100644 drivers/hwmon/mc13783-adc.c
 create mode 100644 drivers/hwmon/mc13xxx-adc.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0b62c3c..239f19f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1321,11 +1321,11 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
=20
-config SENSORS_MC13783_ADC
-        tristate "Freescale MC13783 ADC"
-        depends on MFD_MC13783
+config SENSORS_MC13XXX_ADC
+        tristate "Freescale MC13XXX ADC"
+        depends on MFD_MC13XXX
         help
-          Support for the A/D converter on MC13783 PMIC.
+          Support for the A/D converter on the MC13783 and MC13892 PMIC.
=20
 if ACPI
=20
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3c9ccef..751c6e9 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -92,7 +92,7 @@ obj-$(CONFIG_SENSORS_MAX1668)	+=3D max1668.o
 obj-$(CONFIG_SENSORS_MAX6639)	+=3D max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+=3D max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+=3D max6650.o
-obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
+obj-$(CONFIG_SENSORS_MC13XXX_ADC)+=3D mc13xxx-adc.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+=3D ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+=3D pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+=3D pc87427.o
diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
deleted file mode 100644
index ef65ab5..0000000
--- a/drivers/hwmon/mc13783-adc.c
+++ /dev/null
@@ -1,246 +0,0 @@
-/*
- * Driver for the Freescale Semiconductor MC13783 adc.
- *
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (C) 2009 Sascha Hauer, Pengutronix
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along=
 with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#include <linux/mfd/mc13783.h>
-#include <linux/platform_device.h>
-#include <linux/hwmon-sysfs.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/hwmon.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/err.h>
-
-#define MC13783_ADC_NAME	"mc13783-adc"
-
-struct mc13783_adc_priv {
-	struct mc13xxx *mc13xxx;
-	struct device *hwmon_dev;
-};
-
-static ssize_t mc13783_adc_show_name(struct device *dev, struct device_att=
ribute
-			      *devattr, char *buf)
-{
-	return sprintf(buf, "mc13783_adc\n");
-}
-
-static int mc13783_adc_read(struct device *dev,
-		struct device_attribute *devattr, unsigned int *val)
-{
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
-	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	unsigned int channel =3D attr->index;
-	unsigned int sample[4];
-	int ret;
-
-	ret =3D mc13xxx_adc_do_conversion(priv->mc13xxx,
-			MC13XXX_ADC_MODE_MULT_CHAN,
-			channel, sample);
-	if (ret)
-		return ret;
-
-	channel &=3D 0x7;
-
-	*val =3D (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
-
-	return 0;
-}
-
-static ssize_t mc13783_adc_read_bp(struct device *dev,
-		struct device_attribute *devattr, char *buf)
-{
-	unsigned val;
-	int ret =3D mc13783_adc_read(dev, devattr, &val);
-
-	if (ret)
-		return ret;
-
-	/*
-	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
-	 * the input range of the ADC.  unit =3D 2.25mV =3D 9/4 mV.
-	 */
-	val =3D DIV_ROUND_CLOSEST(val * 9, 4) + 2400;
-
-	return sprintf(buf, "%u\n", val);
-}
-
-static ssize_t mc13783_adc_read_gp(struct device *dev,
-		struct device_attribute *devattr, char *buf)
-{
-	unsigned val;
-	int ret =3D mc13783_adc_read(dev, devattr, &val);
-
-	if (ret)
-		return ret;
-
-	/*
-	 * input range is [0, 2.3V], val has 10 bits, so each bit
-	 * is worth 9/4 mV.
-	 */
-	val =3D DIV_ROUND_CLOSEST(val * 9, 4);
-
-	return sprintf(buf, "%u\n", val);
-}
-
-static DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2=
);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5=
);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13783_adc_read_gp, NULL, 6=
);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, mc13783_adc_read_gp, NULL, 7=
);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, mc13783_adc_read_gp, NULL, 8=
);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, mc13783_adc_read_gp, NULL, 9=
);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
10);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
11);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
12);
-static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
13);
-static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
14);
-static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
15);
-
-static struct attribute *mc13783_attr[] =3D {
-	&dev_attr_name.attr,
-	&sensor_dev_attr_in2_input.dev_attr.attr,
-	&sensor_dev_attr_in5_input.dev_attr.attr,
-	&sensor_dev_attr_in6_input.dev_attr.attr,
-	&sensor_dev_attr_in7_input.dev_attr.attr,
-	&sensor_dev_attr_in8_input.dev_attr.attr,
-	&sensor_dev_attr_in9_input.dev_attr.attr,
-	&sensor_dev_attr_in10_input.dev_attr.attr,
-	&sensor_dev_attr_in11_input.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group mc13783_group =3D {
-	.attrs =3D mc13783_attr,
-};
-
-/* last four channels may be occupied by the touchscreen */
-static struct attribute *mc13783_attr_ts[] =3D {
-	&sensor_dev_attr_in12_input.dev_attr.attr,
-	&sensor_dev_attr_in13_input.dev_attr.attr,
-	&sensor_dev_attr_in14_input.dev_attr.attr,
-	&sensor_dev_attr_in15_input.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group mc13783_group_ts =3D {
-	.attrs =3D mc13783_attr_ts,
-};
-
-static int mc13783_adc_use_touchscreen(struct platform_device *pdev)
-{
-	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
-	unsigned flags =3D mc13xxx_get_flags(priv->mc13xxx);
-
-	return flags & MC13XXX_USE_TOUCHSCREEN;
-}
-
-static int __init mc13783_adc_probe(struct platform_device *pdev)
-{
-	struct mc13783_adc_priv *priv;
-	int ret;
-
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
-
-	platform_set_drvdata(pdev, priv);
-
-	/* Register sysfs hooks */
-	ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group);
-	if (ret)
-		goto out_err_create1;
-
-	if (!mc13783_adc_use_touchscreen(pdev)) {
-		ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
-		if (ret)
-			goto out_err_create2;
-	}
-
-	priv->hwmon_dev =3D hwmon_device_register(&pdev->dev);
-	if (IS_ERR(priv->hwmon_dev)) {
-		ret =3D PTR_ERR(priv->hwmon_dev);
-		dev_err(&pdev->dev,
-				"hwmon_device_register failed with %d.\n", ret);
-		goto out_err_register;
-	}
-
-
-	return 0;
-
-out_err_register:
-
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
-out_err_create2:
-
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group);
-out_err_create1:
-
-	platform_set_drvdata(pdev, NULL);
-	kfree(priv);
-
-	return ret;
-}
-
-static int __devexit mc13783_adc_remove(struct platform_device *pdev)
-{
-	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(priv->hwmon_dev);
-
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
-
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group);
-
-	platform_set_drvdata(pdev, NULL);
-	kfree(priv);
-
-	return 0;
-}
-
-static struct platform_driver mc13783_adc_driver =3D {
-	.remove 	=3D __devexit_p(mc13783_adc_remove),
-	.driver		=3D {
-		.owner	=3D THIS_MODULE,
-		.name	=3D MC13783_ADC_NAME,
-	},
-};
-
-static int __init mc13783_adc_init(void)
-{
-	return platform_driver_probe(&mc13783_adc_driver, mc13783_adc_probe);
-}
-
-static void __exit mc13783_adc_exit(void)
-{
-	platform_driver_unregister(&mc13783_adc_driver);
-}
-
-module_init(mc13783_adc_init);
-module_exit(mc13783_adc_exit);
-
-MODULE_DESCRIPTION("MC13783 ADC driver");
-MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" MC13783_ADC_NAME);
diff --git a/drivers/hwmon/mc13xxx-adc.c b/drivers/hwmon/mc13xxx-adc.c
new file mode 100644
index 0000000..9221b27
--- /dev/null
+++ b/drivers/hwmon/mc13xxx-adc.c
@@ -0,0 +1,255 @@
+/*
+ * Driver for the Freescale Semiconductor MC13XXX-Family adc.
+ * Currently mc13783 and mc13892 are supported.
+ *
+ * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2009 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/mfd/mc13xxx.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/hwmon.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+
+struct mc13xxx_adc_priv {
+	struct mc13xxx *mc13xxx;
+	struct device *hwmon_dev;
+};
+
+static ssize_t mc13xxx_adc_show_name(struct device *dev, struct device_att=
ribute
+			      *devattr, char *buf)
+{
+	return sprintf(buf, "mc13xxx_adc\n");
+}
+
+static int mc13xxx_adc_read(struct device *dev,
+		struct device_attribute *devattr, unsigned int *val)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct mc13xxx_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	unsigned int channel =3D attr->index;
+	unsigned int sample[4];
+	int ret;
+
+	ret =3D mc13xxx_adc_do_conversion(priv->mc13xxx,
+			MC13XXX_ADC_MODE_MULT_CHAN,
+			channel, sample);
+	if (ret)
+		return ret;
+
+	channel &=3D 0x7;
+
+	*val =3D (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
+
+	return 0;
+}
+
+static ssize_t mc13xxx_adc_read_bp(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	unsigned val;
+	int ret =3D mc13xxx_adc_read(dev, devattr, &val);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
+	 * the input range of the ADC.  unit =3D 2.25mV =3D 9/4 mV.
+	 */
+	val =3D DIV_ROUND_CLOSEST(val * 9, 4) + 2400;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t mc13xxx_adc_read_gp(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	unsigned val;
+	int ret =3D mc13xxx_adc_read(dev, devattr, &val);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * input range is [0, 2.3V], val has 10 bits, so each bit
+	 * is worth 9/4 mV.
+	 */
+	val =3D DIV_ROUND_CLOSEST(val * 9, 4);
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, mc13xxx_adc_show_name, NULL);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13xxx_adc_read_bp, NULL, 2=
);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 5=
);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 6=
);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 7=
);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 8=
);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 9=
);
+static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, =
10);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, =
11);
+static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, =
12);
+static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, =
13);
+static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, =
14);
+static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, =
15);
+
+static struct attribute *mc13xxx_attr[] =3D {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mc13xxx_group =3D {
+	.attrs =3D mc13xxx_attr,
+};
+
+/* last four channels may be occupied by the touchscreen */
+static struct attribute *mc13xxx_attr_ts[] =3D {
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_in13_input.dev_attr.attr,
+	&sensor_dev_attr_in14_input.dev_attr.attr,
+	&sensor_dev_attr_in15_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mc13xxx_group_ts =3D {
+	.attrs =3D mc13xxx_attr_ts,
+};
+
+static int mc13xxx_adc_use_touchscreen(struct platform_device *pdev)
+{
+	struct mc13xxx_adc_priv *priv =3D platform_get_drvdata(pdev);
+	unsigned flags =3D mc13xxx_get_flags(priv->mc13xxx);
+
+	return flags & MC13XXX_USE_TOUCHSCREEN;
+}
+
+static int __init mc13xxx_adc_probe(struct platform_device *pdev)
+{
+	struct mc13xxx_adc_priv *priv;
+	int ret;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
+
+	platform_set_drvdata(pdev, priv);
+
+	/* Register sysfs hooks */
+	ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13xxx_group);
+	if (ret)
+		goto out_err_create1;
+
+	if (!mc13xxx_adc_use_touchscreen(pdev)) {
+		ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13xxx_group_ts);
+		if (ret)
+			goto out_err_create2;
+	}
+
+	priv->hwmon_dev =3D hwmon_device_register(&pdev->dev);
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret =3D PTR_ERR(priv->hwmon_dev);
+		dev_err(&pdev->dev,
+				"hwmon_device_register failed with %d.\n", ret);
+		goto out_err_register;
+	}
+
+
+	return 0;
+
+out_err_register:
+
+	if (!mc13xxx_adc_use_touchscreen(pdev))
+		sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_ts);
+out_err_create2:
+
+	sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group);
+out_err_create1:
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(priv);
+
+	return ret;
+}
+
+static int __devexit mc13xxx_adc_remove(struct platform_device *pdev)
+{
+	struct mc13xxx_adc_priv *priv =3D platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	if (!mc13xxx_adc_use_touchscreen(pdev))
+		sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_ts);
+
+	sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(priv);
+
+	return 0;
+}
+
+static const struct platform_device_id mc13xxx_adc_idtable[] =3D {
+	{
+		.name =3D "mc13783-adc",
+	}, {
+		.name =3D "mc13892-adc",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mc13xxx_adc_idtable);
+
+static struct platform_driver mc13xxx_adc_driver =3D {
+	.remove 	=3D __devexit_p(mc13xxx_adc_remove),
+	.driver		=3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D "mc13xxx-adc",
+	},
+};
+
+static int __init mc13xxx_adc_init(void)
+{
+	return platform_driver_probe(&mc13xxx_adc_driver, mc13xxx_adc_probe);
+}
+
+static void __exit mc13xxx_adc_exit(void)
+{
+	platform_driver_unregister(&mc13xxx_adc_driver);
+}
+
+module_init(mc13xxx_adc_init);
+module_exit(mc13xxx_adc_exit);
+
+MODULE_DESCRIPTION("MC13XXX ADC driver");
+MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
+MODULE_LICENSE("GPL");
--=20
1.7.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
