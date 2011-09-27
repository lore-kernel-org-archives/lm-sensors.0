From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Tue, 27 Sep 2011 21:16:09 +0000
Subject: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the
Message-Id: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Based on a patch by David Jander that mostly did s/mc13783/mc13xxx/

Cc: David Jander <david.jander@protonic.nl>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
changes since (implicit) v1:
 - update documentation
 - undo driver renaming
 - fix show_name callback (not 100% sure it is correct to give a different =
name
   on mc13892. I think name contains the prefix documented in
   Documentation/hwmon/mc13783-adc?!)
 - implement some differences between mc13783 and mc13892 that I noticed wh=
en
   updating the docs
   - different scaling for bp channel
   - no general purpose channels 8-15 on mc13892
 - take over authorship as the patch got much more complicated now compared=
 to
   David's original.

 Documentation/hwmon/mc13783-adc |   48 ++++++++++++----
 drivers/hwmon/Kconfig           |    6 +-
 drivers/hwmon/mc13783-adc.c     |  113 +++++++++++++++++++++++++++++------=
----
 3 files changed, 123 insertions(+), 44 deletions(-)

diff --git a/Documentation/hwmon/mc13783-adc b/Documentation/hwmon/mc13783-=
adc
index 044531a..8b717f5 100644
--- a/Documentation/hwmon/mc13783-adc
+++ b/Documentation/hwmon/mc13783-adc
@@ -5,6 +5,9 @@ Supported chips:
   * Freescale Atlas MC13783
     Prefix: 'mc13783_adc'
     Datasheet: http://www.freescale.com/files/rf_if/doc/data_sheet/MC13783=
.pdf?fsrch=3D1
+  * Freescale Atlas MC13892
+    Prefix: 'mc13892_adc'
+    Datasheet: http://cache.freescale.com/files/analog/doc/data_sheet/MC13=
892.pdf?fsrch=3D1&sr=3D1
=20
 Authors:
     Sascha Hauer <s.hauer@pengutronix.de>
@@ -13,20 +16,21 @@ Authors:
 Description
 -----------
=20
-The Freescale MC13783 is a Power Management and Audio Circuit. Among
-other things it contains a 10-bit A/D converter. The converter has 16
-channels which can be used in different modes.
-The A/D converter has a resolution of 2.25mV. Channels 0-4 have
-a dedicated meaning with chip internal scaling applied. Channels 5-7
-can be used as general purpose inputs or alternatively in a dedicated
-mode. Channels 12-15 are occupied by the touchscreen if it's active.
+The Freescale MC13783 and MC13892 are Power Management and Audio Circuits.
+Among other things they contain a 10-bit A/D converter. The converter has =
16
+(MC13783) resp. 12 (MC13892) channels which can be used in different modes=
. The
+A/D converter has a resolution of 2.25mV.
=20
-Currently the driver only supports channels 2 and 5-15 with no alternative
-modes for channels 5-7.
+Some channels can be used as General Purpose inputs or in a dedicated mode=
 with
+a chip internal scaling applied .
=20
-See this table for the meaning of the different channels and their chip
-internal scaling:
+Currently the driver only supports BP, the General Purpose inputs and
+touchscreen.
=20
+See the following tables for the meaning of the different channels and the=
ir
+chip internal scaling:
+
+MC13783:
 Channel	Signal						Input Range	Scaling
 --------------------------------------------------------------------------=
-----
 0	Battery Voltage (BATT)				2.50 - 4.65V	-2.40V
@@ -34,7 +38,7 @@ Channel	Signal						Input Range	Scaling
 2	Application Supply (BP)				2.50 - 4.65V	-2.40V
 3	Charger Voltage (CHRGRAW)			0 - 10V /	/5
 							0 - 20V		/10
-4	Charger Current (CHRGISNSP-CHRGISNSN)		-0.25V - 0.25V	x4
+4	Charger Current (CHRGISNSP-CHRGISNSN)		-0.25 - 0.25V	x4
 5	General Purpose ADIN5 / Battery Pack Thermistor	0 - 2.30V	No
 6	General Purpose ADIN6 / Backup Voltage (LICELL)	0 - 2.30V /	No /
 							1.50 - 3.50V	-1.20V
@@ -48,3 +52,23 @@ Channel	Signal						Input Range	Scaling
 13	General Purpose TSX2 / Touchscreen X-plate 2	0 - 2.30V	No
 14	General Purpose TSY1 / Touchscreen Y-plate 1	0 - 2.30V	No
 15	General Purpose TSY2 / Touchscreen Y-plate 2	0 - 2.30V	No
+
+MC13892:
+Channel	Signal						Input Range	Scaling
+--------------------------------------------------------------------------=
-----
+0	Battery Voltage (BATT)				0 - 4.8V	/2
+1	Battery Current (BATT - BATTISNSCC)		-60 - 60 mV	x20
+2	Application Supply (BPSNS)			0 - 4.8V	/2
+3	Charger Voltage (CHRGRAW)			0 - 12V /	/5
+							0 - 20V		/10
+4	Charger Current (CHRGISNS-BPSNS) /		-0.3 - 0.3V /	x4 /
+	Touchscreen X-plate 1				0 - 2.4V	No
+5	General Purpose ADIN5 /	Battery Pack Thermistor	0 - 2.4V	No
+6	General Purpose ADIN6 / Backup Voltage (LICELL)	0 - 2.4V /	No
+	Backup Voltage (LICELL)                        	0 - 3.6V	x2/3
+7	General Purpose ADIN7 / UID / Die Temperature	0 - 2.4V /	No /
+							0 - 4.8V	/2
+12	Touchscreen X-plate 1				0 - 2.4V	No
+13	Touchscreen X-plate 2				0 - 2.4V	No
+14	Touchscreen Y-plate 1				0 - 2.4V	No
+15	Touchscreen Y-plate 2				0 - 2.4V	No
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0b62c3c..e3e3bc0 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1322,10 +1322,10 @@ config SENSORS_APPLESMC
 	  the awesome power of applesmc.
=20
 config SENSORS_MC13783_ADC
-        tristate "Freescale MC13783 ADC"
-        depends on MFD_MC13783
+        tristate "Freescale MC13783/MC13892 ADC"
+        depends on MFD_MC13XXX
         help
-          Support for the A/D converter on MC13783 PMIC.
+          Support for the A/D converter on MC13783 and MC13892 PMIC.
=20
 if ACPI
=20
diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index ef65ab5..0d796f7 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -1,5 +1,5 @@
 /*
- * Driver for the Freescale Semiconductor MC13783 adc.
+ * Driver for the adc on Freescale Semiconductor MC13783 and MC13892 PMICs.
  *
  * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright (C) 2009 Sascha Hauer, Pengutronix
@@ -18,7 +18,7 @@
  * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
  */
=20
-#include <linux/mfd/mc13783.h>
+#include <linux/mfd/mc13xxx.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/kernel.h>
@@ -28,7 +28,11 @@
 #include <linux/init.h>
 #include <linux/err.h>
=20
-#define MC13783_ADC_NAME	"mc13783-adc"
+#define DRIVER_NAME	"mc13783-adc"
+
+/* platform device id driver data */
+#define MC13783_ADC_16CHANS	1
+#define MC13783_ADC_BPDIV2	2
=20
 struct mc13783_adc_priv {
 	struct mc13xxx *mc13xxx;
@@ -38,7 +42,13 @@ struct mc13783_adc_priv {
 static ssize_t mc13783_adc_show_name(struct device *dev, struct device_att=
ribute
 			      *devattr, char *buf)
 {
-	return sprintf(buf, "mc13783_adc\n");
+	struct platform_device *pdev =3D to_platform_device(dev);
+	ssize_t ret =3D sprintf(buf, "%s\n", pdev->name);
+
+	if (ret > 7 && buf[7] =3D '-')
+		buf[7] =3D '_';
+
+	return ret;
 }
=20
 static int mc13783_adc_read(struct device *dev,
@@ -68,16 +78,21 @@ static ssize_t mc13783_adc_read_bp(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
 	unsigned val;
+	struct platform_device *pdev =3D to_platform_device(dev);
+	kernel_ulong_t driver_data =3D platform_get_device_id(pdev)->driver_data;
 	int ret =3D mc13783_adc_read(dev, devattr, &val);
=20
 	if (ret)
 		return ret;
=20
-	/*
-	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
-	 * the input range of the ADC.  unit =3D 2.25mV =3D 9/4 mV.
-	 */
-	val =3D DIV_ROUND_CLOSEST(val * 9, 4) + 2400;
+	if (driver_data & MC13783_ADC_BPDIV2)
+		val =3D DIV_ROUND_CLOSEST(val * 9, 2);
+	else
+		/*
+		 * BP (channel 2) reports with offset 2.4V to the actual value
+		 * to fit the input range of the ADC.  unit =3D 2.25mV =3D 9/4 mV.
+		 */
+		val =3D DIV_ROUND_CLOSEST(val * 9, 4) + 2400;
=20
 	return sprintf(buf, "%u\n", val);
 }
@@ -114,12 +129,21 @@ static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc1378=
3_adc_read_gp, NULL, 13);
 static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
14);
 static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, =
15);
=20
-static struct attribute *mc13783_attr[] =3D {
+static struct attribute *mc13783_attr_base[] =3D {
 	&dev_attr_name.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in7_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mc13783_group_base =3D {
+	.attrs =3D mc13783_attr_base,
+};
+
+/* these are only used if MC13783_ADC_16CHANS is provided in driver data */
+static struct attribute *mc13783_attr_16chan[] =3D {
 	&sensor_dev_attr_in8_input.dev_attr.attr,
 	&sensor_dev_attr_in9_input.dev_attr.attr,
 	&sensor_dev_attr_in10_input.dev_attr.attr,
@@ -127,8 +151,8 @@ static struct attribute *mc13783_attr[] =3D {
 	NULL
 };
=20
-static const struct attribute_group mc13783_group =3D {
-	.attrs =3D mc13783_attr,
+static const struct attribute_group mc13783_group_16chan =3D {
+	.attrs =3D mc13783_attr_16chan,
 };
=20
 /* last four channels may be occupied by the touchscreen */
@@ -156,6 +180,7 @@ static int __init mc13783_adc_probe(struct platform_dev=
ice *pdev)
 {
 	struct mc13783_adc_priv *priv;
 	int ret;
+	kernel_ulong_t driver_data =3D platform_get_device_id(pdev)->driver_data;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -166,14 +191,22 @@ static int __init mc13783_adc_probe(struct platform_d=
evice *pdev)
 	platform_set_drvdata(pdev, priv);
=20
 	/* Register sysfs hooks */
-	ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group);
+	ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group_base);
 	if (ret)
-		goto out_err_create1;
+		goto out_err_create_base;
=20
-	if (!mc13783_adc_use_touchscreen(pdev)) {
-		ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (driver_data & MC13783_ADC_16CHANS) {
+		ret =3D sysfs_create_group(&pdev->dev.kobj,
+				&mc13783_group_16chan);
 		if (ret)
-			goto out_err_create2;
+			goto out_err_create_16chan;
+
+		if (!mc13783_adc_use_touchscreen(pdev)) {
+			ret =3D sysfs_create_group(&pdev->dev.kobj,
+					&mc13783_group_ts);
+			if (ret)
+				goto out_err_create_ts;
+		}
 	}
=20
 	priv->hwmon_dev =3D hwmon_device_register(&pdev->dev);
@@ -184,17 +217,21 @@ static int __init mc13783_adc_probe(struct platform_d=
evice *pdev)
 		goto out_err_register;
 	}
=20
-
 	return 0;
=20
 out_err_register:
=20
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
-out_err_create2:
+	if (driver_data & MC13783_ADC_16CHANS) {
+		if (!mc13783_adc_use_touchscreen(pdev))
+			sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
+out_err_create_ts:
+
+		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chan);
+	}
+out_err_create_16chan:
=20
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group);
-out_err_create1:
+	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
+out_err_create_base:
=20
 	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
@@ -205,13 +242,18 @@ out_err_create1:
 static int __devexit mc13783_adc_remove(struct platform_device *pdev)
 {
 	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
+	kernel_ulong_t driver_data =3D platform_get_device_id(pdev)->driver_data;
=20
 	hwmon_device_unregister(priv->hwmon_dev);
=20
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (driver_data & MC13783_ADC_16CHANS) {
+		if (!mc13783_adc_use_touchscreen(pdev))
+			sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
=20
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group);
+		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chan);
+	}
+
+	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
=20
 	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
@@ -219,12 +261,26 @@ static int __devexit mc13783_adc_remove(struct platfo=
rm_device *pdev)
 	return 0;
 }
=20
+static const struct platform_device_id mc13783_adc_idtable[] =3D {
+	{
+		.name =3D "mc13783-adc",
+		.driver_data =3D MC13783_ADC_16CHANS,
+	}, {
+		.name =3D "mc13892-adc",
+		.driver_data =3D MC13783_ADC_BPDIV2,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mc13783_adc_idtable);
+
 static struct platform_driver mc13783_adc_driver =3D {
-	.remove 	=3D __devexit_p(mc13783_adc_remove),
+	.remove		=3D __devexit_p(mc13783_adc_remove),
 	.driver		=3D {
 		.owner	=3D THIS_MODULE,
-		.name	=3D MC13783_ADC_NAME,
+		.name	=3D DRIVER_NAME,
 	},
+	.id_table	=3D mc13783_adc_idtable,
 };
=20
 static int __init mc13783_adc_init(void)
@@ -243,4 +299,3 @@ module_exit(mc13783_adc_exit);
 MODULE_DESCRIPTION("MC13783 ADC driver");
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" MC13783_ADC_NAME);
--=20
1.7.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
