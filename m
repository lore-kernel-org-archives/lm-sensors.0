From: "David Dajun Chen" <Dajun.Chen@diasemi.com>
Date: Mon, 05 Jul 2010 15:08:37 +0000
Subject: [lm-sensors] [PATCHv2 6/11] HWMON: Reformatting of files and
Message-Id: <3495EC08FA53E94AAA00CC4743D5BA7E013FA985@pandora.diasemi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

ADC module of the device driver for DA9052 PMIC device from Dialog
Semiconductor.

Changes made since last submission:
. removal of redundant printk and comments
. removal of test framework

Linux Kernel Version: 2.6.34

Signed-off-by: D. Chen <dchen@diasemi.com>
---
diff -urpN linux-2.6.34/drivers/hwmon/da9052-adc.c
linux-2.6.34_test/drivers/hwmon/da9052-adc.c
--- linux-2.6.34/drivers/hwmon/da9052-adc.c	1970-01-01
05:00:00.000000000 +0500
+++ linux-2.6.34_test/drivers/hwmon/da9052-adc.c	2010-07-05
18:36:25.000000000 +0500
@@ -0,0 +1,613 @@
+#include <linux/platform_device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/hwmon.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/mfd/da9052/da9052.h>
+#include <linux/mfd/da9052/reg.h>
+#include <linux/mfd/da9052/adc.h>
+
+#define DRIVER_NAME "da9052-adc"
+
+struct da9052_adc_priv {
+	struct da9052 *da9052;
+	struct device *hwmon_dev;
+	/* Mutex for ADC manual conversion */
+	struct mutex manconv_lock;
+};
+
+static int da9052_manual_read(struct da9052_adc_priv *priv,
+			unsigned char channel, u16 *data)
+{
+	unsigned char man_timeout_cnt DA9052_ADC_MAX_MANCONV_RETRY_COUNT;
+	struct da9052_ssc_msg msg;
+	unsigned short calc_data;
+	unsigned int ret;
+
+	msg.addr =3D DA9052_ADCMAN_REG;
+	msg.data =3D channel;
+	msg.data =3D  (msg.data | DA9052_ADCMAN_MANCONV);
+
+	mutex_lock(&priv->manconv_lock);
+
+	da9052_lock(priv->da9052);
+
+	ret =3D priv->da9052->write(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	/* Wait for the event */
+	do {
+		msg.addr =3D DA9052_ADCCONT_REG;
+		msg.data =3D 0;
+		da9052_lock(priv->da9052);
+		ret =3D priv->da9052->read(priv->da9052, &msg);
+		if (ret)
+			goto err_ssc_comm;
+		da9052_unlock(priv->da9052);
+
+		if (DA9052_ADCCONT_ADCMODE & msg.data)
+			msleep(1);
+		else
+			msleep(10);
+
+		msg.addr =3D DA9052_ADCMAN_REG;
+		msg.data =3D 0;
+		da9052_lock(priv->da9052);
+		ret =3D priv->da9052->read(priv->da9052, &msg);
+		if (ret)
+			goto err_ssc_comm;
+		da9052_unlock(priv->da9052);
+
+		/* Counter to avoid endless while loop */
+		man_timeout_cnt--;
+		if (man_timeout_cnt =3D 1) {
+			if (!(msg.data & DA9052_ADCMAN_MANCONV)) {
+				break;
+			} else {
+				mutex_unlock(&priv->manconv_lock);
+				return -EIO;
+			}
+		}
+	/* Wait until the MAN_CONV bit is cleared to zero */
+	} while (msg.data & DA9052_ADCMAN_MANCONV);
+
+	msg.addr =3D DA9052_ADCRESH_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	calc_data =3D (unsigned short)msg.data;
+	*data =3D (calc_data << 2);
+
+	msg.addr =3D DA9052_ADCRESL_REG; /* Read LSB data */
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	/* Clear first 14 bits before ORing */
+	calc_data =3D (unsigned short)msg.data & 0x0003;
+	*data |=3D calc_data;
+
+	mutex_unlock(&priv->manconv_lock);
+
+	return 0;
+err_ssc_comm:
+	mutex_unlock(&priv->manconv_lock);
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static int da9052_start_adc(struct da9052 *da9052, unsigned channel)
+{
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	msg.addr =3D DA9052_ADCCONT_REG;
+	msg.data =3D 0;
+
+	da9052_lock(da9052);
+	ret =3D da9052->read(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+
+	if (channel =3D DA9052_ADC_VDDOUT)
+		msg.data =3D (msg.data | DA9052_ADCCONT_AUTOVDDEN);
+	else if (channel =3D DA9052_ADC_ADCIN4)
+		msg.data =3D (msg.data | DA9052_ADCCONT_AUTOAD4EN);
+	else if (channel =3D DA9052_ADC_ADCIN5)
+		msg.data =3D (msg.data | DA9052_ADCCONT_AUTOAD5EN);
+	else if (channel =3D DA9052_ADC_ADCIN6)
+		msg.data =3D (msg.data | DA9052_ADCCONT_AUTOAD6EN);
+	else
+		return -EINVAL;
+
+	ret =3D da9052->write(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+	return 0;
+
+err_ssc_comm:
+	da9052_unlock(da9052);
+	return -EIO;
+}
+
+static int da9052_stop_adc(struct da9052 *da9052, unsigned channel)
+{
+	int ret;
+	struct da9052_ssc_msg msg;
+
+	msg.addr =3D DA9052_ADCCONT_REG;
+	msg.data =3D 0;
+	da9052_lock(da9052);
+	ret =3D da9052->read(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+
+	if (channel =3D DA9052_ADC_VDDOUT)
+		msg.data =3D (msg.data & ~(DA9052_ADCCONT_AUTOVDDEN));
+	else if (channel =3D DA9052_ADC_ADCIN4)
+		msg.data =3D (msg.data & ~(DA9052_ADCCONT_AUTOAD4EN));
+	else if (channel =3D DA9052_ADC_ADCIN5)
+		msg.data =3D (msg.data & ~(DA9052_ADCCONT_AUTOAD5EN));
+	else if (channel =3D DA9052_ADC_ADCIN6)
+		msg.data =3D  (msg.data & ~(DA9052_ADCCONT_AUTOAD6EN));
+	else
+		return -EINVAL;
+
+	da9052_lock(da9052);
+	ret =3D da9052->write(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+
+	return 0;
+err_ssc_comm:
+	da9052_unlock(da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_read_vddout(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	ret =3D da9052_start_adc(priv->da9052, DA9052_ADC_VDDOUT);
+	if (ret)
+		return ret;
+
+	/* Read the ADC converted value */
+	msg.addr =3D DA9052_VDDRES_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	ret =3D da9052_stop_adc(priv->da9052, DA9052_ADC_VDDOUT);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", msg.data);
+
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_read_ich(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	/* Read charging conversion register */
+	msg.addr =3D DA9052_ICHGAV_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	return sprintf(buf, "%u\n", msg.data);
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_read_tbat(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	/* Read TBAT conversion result */
+	msg.addr =3D DA9052_TBATRES_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	return sprintf(buf, "%u\n", msg.data);
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_read_vbat(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	u16 data;
+	int ret;
+
+	ret =3D da9052_manual_read(priv, DA9052_ADC_VBAT, &data);
+
+	if (!ret)
+		return sprintf(buf, "%u\n", data);
+	else
+		return ret;
+}
+
+static ssize_t da9052_adc_4_gp(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	ret =3D da9052_start_adc(priv->da9052, DA9052_ADC_ADCIN4);
+	if (ret)
+		return ret;
+
+	/* Read the ADC converted value */
+	msg.addr =3D DA9052_ADCIN4RES_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	ret =3D da9052_stop_adc(priv->da9052, DA9052_ADC_ADCIN4);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", msg.data);
+
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_5_gp(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	ret =3D da9052_start_adc(priv->da9052, DA9052_ADC_ADCIN5);
+	if (ret)
+		return ret;
+
+	/* Read the ADC converted value */
+	msg.addr =3D DA9052_ADCIN5RES_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	ret =3D da9052_stop_adc(priv->da9052, DA9052_ADC_ADCIN5);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", msg.data);
+
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_6_gp(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	ret =3D da9052_start_adc(priv->da9052, DA9052_ADC_ADCIN6);
+	if (ret)
+		return ret;
+
+	/* Read the ADC converted value */
+	msg.addr =3D DA9052_ADCIN6RES_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	ret =3D da9052_stop_adc(priv->da9052, DA9052_ADC_ADCIN6);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", msg.data);
+
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_read_tjunc(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	struct da9052_ssc_msg msg;
+	unsigned char temp;
+	int ret;
+
+	msg.addr =3D DA9052_TJUNCRES_REG;
+	msg.data =3D 0;
+
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	temp =3D msg.data;
+
+	msg.addr =3D DA9052_TOFFSET_REG;
+	msg.data =3D 0;
+	da9052_lock(priv->da9052);
+	ret =3D priv->da9052->read(priv->da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(priv->da9052);
+
+	/* Calculate Junction temperature */
+	temp =3D (temp - msg.data);
+
+	return sprintf(buf, "%u\n", temp);
+
+err_ssc_comm:
+	da9052_unlock(priv->da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_read_vbbat(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+	u16 temp;
+	int ret;
+
+	ret =3D da9052_manual_read(priv, DA9052_ADC_VBBAT, &temp);
+
+	if (!ret)
+		return sprintf(buf, "%u\n", temp);
+	else
+	return ret;
+}
+
+static int da9052_adc_hw_init(struct da9052 *da9052)
+{
+	struct da9052_ssc_msg msg;
+	int ret;
+
+	/* ADC channel 4 and 5 are by default enabled */
+#if (DA9052_ADC_CONF_ADC4)
+	msg.addr =3D DA9052_GPIO0001_REG;
+	msg.data =3D 0;
+	da9052_lock(da9052);
+	ret =3D da9052->read(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+
+	msg.data =3D (msg.data & ~(DA9052_GPIO0001_GPIO0PIN));
+	ret =3D da9052->write(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+#endif
+
+#if (DA9052_ADC_CONF_ADC5)
+	msg.addr =3D DA9052_GPIO0001_REG;
+	msg.data =3D 0;
+	da9052_lock(da9052);
+	ret =3D da9052->read(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+
+	msg.data =3D (msg.data & ~(DA9052_GPIO0001_GPIO0PIN));
+	ret =3D da9052->write(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+#endif
+
+#if (DA9052_ADC_CONF_ADC6)
+	msg.addr =3D DA9052_GPIO0203_REG;
+	msg.data =3D 0;
+	da9052_lock(da9052);
+	ret =3D da9052->read(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+
+	msg.data =3D (msg.data & ~(DA9052_GPIO0203_GPIO2PIN));
+	ret =3D da9052->write(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+#endif
+
+	/* By default configure the Measurement sequence interval to
10ms */
+	msg.addr =3D DA9052_ADCCONT_REG;
+	msg.data =3D 0;
+	da9052_lock(da9052);
+	ret =3D da9052->read(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+
+	/* Set the ADC MODE bit for 10msec sampling timer */
+	msg.data =3D (msg.data & ~(DA9052_ADCCONT_ADCMODE));
+	ret =3D da9052->write(da9052, &msg);
+	if (ret)
+		goto err_ssc_comm;
+	da9052_unlock(da9052);
+
+	return 0;
+err_ssc_comm:
+	da9052_unlock(da9052);
+	return -EIO;
+}
+
+static ssize_t da9052_adc_show_name(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	return sprintf(buf, "da9052-adc\n");
+}
+
+static DEVICE_ATTR(name, S_IRUGO, da9052_adc_show_name, NULL);
+static SENSOR_DEVICE_ATTR(read_vddout, S_IRUGO,
+				da9052_adc_read_vddout, NULL, 0);
+static SENSOR_DEVICE_ATTR(read_ich, S_IRUGO, da9052_adc_read_ich, NULL,
1);
+static SENSOR_DEVICE_ATTR(read_tbat, S_IRUGO, da9052_adc_read_tbat,
NULL, 2);
+static SENSOR_DEVICE_ATTR(read_vbat, S_IRUGO, da9052_adc_read_vbat,
NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, da9052_adc_4_gp, NULL,
4);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, da9052_adc_5_gp, NULL,
5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, da9052_adc_6_gp, NULL,
6);
+static SENSOR_DEVICE_ATTR(read_tjunc, S_IRUGO, da9052_adc_read_tjunc,
NULL, 8);
+static SENSOR_DEVICE_ATTR(read_vbbat, S_IRUGO, da9052_adc_read_vbbat,
NULL, 9);
+
+static struct attribute *da9052_attr[] =3D {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_read_vddout.dev_attr.attr,
+	&sensor_dev_attr_read_ich.dev_attr.attr,
+	&sensor_dev_attr_read_tbat.dev_attr.attr,
+	&sensor_dev_attr_read_vbat.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_read_tjunc.dev_attr.attr,
+	&sensor_dev_attr_read_vbbat.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group da9052_group =3D {
+	.attrs =3D da9052_attr,
+};
+
+static int __init da9052_adc_probe(struct platform_device *pdev)
+{
+	struct da9052_adc_priv *priv;
+	int ret;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->da9052 =3D dev_get_drvdata(pdev->dev.parent);
+
+	platform_set_drvdata(pdev, priv);
+
+	/* Register sysfs hooks */
+	ret =3D sysfs_create_group(&pdev->dev.kobj, &da9052_group);
+	if (ret)
+		goto out_err_create1;
+
+	priv->hwmon_dev =3D hwmon_device_register(&pdev->dev);
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret =3D PTR_ERR(priv->hwmon_dev);
+		goto out_err_create2;
+	}
+	/* Initializes the hardware for ADC module */
+	da9052_adc_hw_init(priv->da9052);
+
+	/* Initialize mutex required for ADC Manual read */
+	mutex_init(&priv->manconv_lock);
+
+	return 0;
+
+out_err_create2:
+	sysfs_remove_group(&pdev->dev.kobj, &da9052_group);
+out_err_create1:
+	platform_set_drvdata(pdev, NULL);
+	kfree(priv);
+
+	return ret;
+}
+
+static int __devexit da9052_adc_remove(struct platform_device *pdev)
+{
+	struct da9052_adc_priv *priv =3D platform_get_drvdata(pdev);
+
+	mutex_destroy(&priv->manconv_lock);
+
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &da9052_group);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct platform_driver da9052_adc_driver =3D {
+	.remove		=3D __devexit_p(da9052_adc_remove),
+	.driver		=3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D DRIVER_NAME,
+	},
+};
+
+static int __init da9052_adc_init(void)
+{
+	return platform_driver_probe(&da9052_adc_driver,
da9052_adc_probe);
+}
+module_init(da9052_adc_init);
+
+static void __exit da9052_adc_exit(void)
+{
+	platform_driver_unregister(&da9052_adc_driver);
+}
+module_exit(da9052_adc_exit);
+
+MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>")
+MODULE_DESCRIPTION("DA9052 ADC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
diff -urpN linux-2.6.34/drivers/hwmon/Kconfig
linux-2.6.34_test/drivers/hwmon/Kconfig
--- linux-2.6.34/drivers/hwmon/Kconfig	2010-05-17 02:17:36.000000000
+0500
+++ linux-2.6.34_test/drivers/hwmon/Kconfig	2010-07-05
18:36:32.000000000 +0500
@@ -1087,6 +1087,12 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 PMIC.
=20
+config SENSORS_DA9052_ADC
+        tristate "Dialog DA9052 ADC"
+        depends on PMIC_DA9052
+        help
+          Support for the A/D converter on DA9052 PMIC.
+
 if ACPI
=20
 comment "ACPI drivers"
diff -urpN linux-2.6.34/drivers/hwmon/Makefile
linux-2.6.34_test/drivers/hwmon/Makefile
--- linux-2.6.34/drivers/hwmon/Makefile	2010-05-17 02:17:36.000000000
+0500
+++ linux-2.6.34_test/drivers/hwmon/Makefile	2010-07-05
18:36:41.000000000 +0500
@@ -100,6 +100,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+=3D w83l7
 obj-$(CONFIG_SENSORS_W83L786NG)	+=3D w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+=3D wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+=3D wm8350-hwmon.o
+obj-$(CONFIG_SENSORS_DA9052_ADC)+=3D da9052-adc.o
=20
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS +=3D -DDEBUG
diff -urpN linux-2.6.34/include/linux/mfd/da9052/adc.h
linux-2.6.34_test/include/linux/mfd/da9052/adc.h
--- linux-2.6.34/include/linux/mfd/da9052/adc.h	1970-01-01
05:00:00.000000000 +0500
+++ linux-2.6.34_test/include/linux/mfd/da9052/adc.h	2010-07-05
18:38:52.000000000 +0500
@@ -0,0 +1,45 @@
+/*
+ * Copyright(c) 2009 Dialog Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * da9052_adc.h: ADC driver header file for DA9052
+ *
+ * History:
+ *
+ *  (05/08/2009):	Initial version
+ *
+ * (27/04/2010):	Updated for Linux Community release
+ *
+ * Best Viewed with TabSize=3D8 and ColumnWidth=80
+ */
+
+
+#ifndef _DA9052_ADC_H
+#define _DA9052_ADC_H
+
+#define DA9052_ADC_DEVICE_NAME				"da9052_adc"
+
+/* Channel Definations */
+#define DA9052_ADC_VDDOUT					0
+#define DA9052_ADC_ICH						1
+#define DA9052_ADC_TBAT
2
+#define DA9052_ADC_VBAT
3
+#define DA9052_ADC_ADCIN4					4
+#define DA9052_ADC_ADCIN5					5
+#define DA9052_ADC_ADCIN6					6
+#define DA9052_ADC_TSI						7
+#define DA9052_ADC_TJUNC					8
+#define DA9052_ADC_VBBAT					9
+
+#define DA9052_ADC_CONF_ADC4					1
+#define DA9052_ADC_CONF_ADC5					1
+#define DA9052_ADC_CONF_ADC6					1
+
+/* Maximum retry count to check manual conversion over */
+#define DA9052_ADC_MAX_MANCONV_RETRY_COUNT			8
+
+#endif /* _DA9052_ADC_H */
Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information,=20
some or all of which may be legally privileged. It is intended solely for t=
he use of the individual or entity to which it
is addressed. Access to this email by anyone else is unauthorized. If you a=
re not the intended recipient, any disclosure,=20
copying, distribution or any action taken or omitted to be taken in relianc=
e on it, is prohibited and may be unlawful.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
