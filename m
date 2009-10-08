From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Oct 2009 12:01:15 +0000
Subject: Re: [lm-sensors] [PATCH v3] [hwmon] add Freescale MC13783 adc driver
Message-Id: <20091008140115.026f9bff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1254990977-32295-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1254990977-32295-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hallo Uwe,

On Thu,  8 Oct 2009 10:36:17 +0200, Uwe Kleine-König wrote:
> From: Luotao Fu <l.fu@pengutronix.de>
> 
> This driver provides support for the ADC integrated into the
> Freescale MC13783 PMIC.
> 
> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> ---
> Hello,
> 
> I picked up on a patch that was sent by Sascha Hauer back in August.  The only
> comment was to report actual voltages (requested by Mark Brown).  This together with a few minor things is done in v3 of this patch.
> 
> Best regards
> Uwe
> 
> Changes since v3:
> 
> - remove channels 0, 1, 3 and 4 as reading them needs more work
> - report actual voltages not raw values
> - some formatting cosmetics
> - zero pad the sysfs device entries

No, you shouldn't have done this. Our sysfs standard doesn't ask for
zero-padding, and I'm not sure libsensors and other applications will
like it. And I can't see any benefit.

> 
> Changes since v2:
> 
> - Add Documentation Documentation/hwmon/mc13783
> - use sysfs_create_group
> 
> Changes since v1:
> 
> - add MODULE_ALIAS
> - __init -> __devinit in probe function
> - use platform_driver_probe instead of platform_driver_register
> ---
>  Documentation/hwmon/mc13783 |   50 +++++++++
>  drivers/hwmon/Kconfig       |    6 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/mc13783-adc.c |  233 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/mc13783
>  create mode 100644 drivers/hwmon/mc13783-adc.c
> 
> diff --git a/Documentation/hwmon/mc13783 b/Documentation/hwmon/mc13783
> new file mode 100644
> index 0000000..ba0f8f4
> --- /dev/null
> +++ b/Documentation/hwmon/mc13783
> @@ -0,0 +1,50 @@
> +Kernel driver mc13783

Doesn't match the actual driver name.

> +==========> +
> +Supported chips:
> +  * Freescale Atlas MC13783
> +    Prefix: 'mc13783'

Doesn't match the actual prefix (but see below.)

> +    Datasheet: http://www.freescale.com/files/rf_if/doc/data_sheet/MC13783.pdf?fsrch=1
> +
> +Authors:
> +       Sascha Hauer <s.hauer@pengutronix.de>
> +       Luotao Fu <l.fu@pengutronix.de>
> +
> +Description
> +-----------
> +
> +The Freescale MC13783 is a Power Management and Audio Circuit. Among
> +other things it contains a 10bit A/D converter. The converter has 16
> +channels which can be used in different modes.
> +The A/D converter has a resolution of 2.25mV. Channels 0-4 have
> +a dedicated meaning with chip internal scaling applied. Channels 5-7
> +can be used as general purpose inputs or alternatively in a dedicated
> +mode. Channels 12-15 are occupied by the touchscreen if it's active.
> +
> +Currently the driver only supports channels 2 and 5-15 with no alternative
> +modes for channels 5-7.
> +
> +See this table for the meaning of the different channels and their chip
> +internal scaling:
> +
> +Channel	Signal						Input Range	Scaling
> +-------------------------------------------------------------------------------
> +0	Battery Voltage (BATT)				2.50 – 4.65V	-2.40V
> +1	Battery Current (BATT – BATTISNS)		-50 - 50 mV	x20
> +2	Application Supply (BP)				2.50 – 4.65V	-2.40V
> +3	Charger Voltage (CHRGRAW)			0 – 10V /	/5
> +							0 – 20V		/10
> +4	Charger Current (CHRGISNSP-CHRGISNSN)		-0.25V – 0.25V	x4
> +5	General Purpose ADIN5 / Battery Pack Thermistor	0 – 2.30V	No
> +6	General Purpose ADIN6 / Backup Voltage (LICELL)	0 – 2.30V /	No /
> +							1.50 – 3.50V	-1.20V
> +7	General Purpose ADIN7 / UID / Die Temperature	0 – 2.30V /	No /
> +							0 – 2.55V /	x0.9 / No
> +8	General Purpose ADIN8				0 - 2.30V	No
> +9	General Purpose ADIN9				0 - 2.30V	No
> +10	General Purpose ADIN10				0 - 2.30V	No
> +11	General Purpose ADIN11				0 - 2.30V	No
> +12	General Purpose TSX1 / Touchscreen X-plate 1	0 - 2.30V	No
> +13	General Purpose TSX2 / Touchscreen X-plate 2	0 - 2.30V	No
> +14	General Purpose TSY1 / Touchscreen Y-plate 1	0 - 2.30V	No
> +15	General Purpose TSY2 / Touchscreen Y-plate 2	0 - 2.30V	No

I don't quite see the point in using non-ASCII characters in the table
above. The same can be achieved easily with standard ASCII characters.

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 6857560..dd5d982 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1008,6 +1008,12 @@ config SENSORS_APPLESMC
>  	  Say Y here if you have an applicable laptop and want to experience
>  	  the awesome power of applesmc.
>  
> +config SENSORS_MC13783_ADC
> +        tristate "Freescale MC13783 ADC"
> +        depends on MFD_MC13783
> +        help
> +          Support for the ad converter on mc13783 pmic.
> +
>  if ACPI
>  
>  comment "ACPI drivers"
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 9f46cb0..ab5a005 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
>  obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
>  obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
>  obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
> +obj-$(CONFIG_SENSORS_MC13783_ADC)       += mc13783-adc.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> new file mode 100644
> index 0000000..0a68bd8
> --- /dev/null
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -0,0 +1,233 @@
> +/*
> + * Driver for the Freescale Semiconductor MC13783 adc.
> + *
> + * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2009 Sascha Hauer, Pengutronix
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 51
> + * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/mfd/mc13783-private.h>
> +#include <linux/platform_device.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/completion.h>

I don't see where you need this.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>

Nor this.

> +#include <linux/hwmon.h>
> +#include <linux/input.h>

Nor this.

> +#include <linux/mutex.h>

Nor this.

> +#include <linux/sched.h>

Nor this.

> +#include <linux/init.h>
> +
> +#define MC13783_ADC_NAME	"mc13783-adc"
> +
> +struct mc13783_adc_priv {
> +	struct mc13783 *mc13783;
> +	struct device *hwmon_dev;
> +};
> +
> +static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
> +			      *devattr, char *buf)
> +{
> +	return sprintf(buf, MC13783_ADC_NAME "\n");

hwmon device names can't include dashes. Please make this "mc13783_adc"
or just "mc13783" (if there's no room for confusion), at your option.

> +}
> +
> +static unsigned int mc13783_adc_read(struct device *dev,
> +		struct device_attribute *devattr)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	unsigned int channel = attr->index;
> +	unsigned int sample[4];
> +
> +	mc13783_adc_do_conversion(priv->mc13783, MC13783_ADC_MODE_MULT_CHAN,
> +			channel, sample);
> +
> +	channel &= 0x7;
> +
> +	return (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> +}
> +
> +static ssize_t mc13783_adc_read_raw(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	unsigned res = mc13783_adc_read(dev, devattr);
> +
> +	return sprintf(buf, "%u\n", res);
> +}
> +
> +static ssize_t mc13783_adc_read_bp(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	unsigned res = mc13783_adc_read(dev, devattr);
> +
> +	/*
> +	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
> +	 * the input range of the ADC.  unit = 2.25mV = 9/4 mV.
> +	 */
> +	res *= 9;
> +	res += 2400 << 2;
> +
> +	return sprintf(buf, "%u.%02umV\n", res >> 2, (res & 3) * 25);

Err, no. Please read Documentation/hwmon/sysfs-interface again. Sysfs
files never include the unit, and they are always integer numbers. For
voltages we use mV as the unit so you want:

	res = DIV_ROUND_CLOSEST(res * 9, 4) + 2400;
	return sprintf(buf, "%u\n", res);

> +}
> +
> +static ssize_t mc13783_adc_read_gp(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	unsigned res = mc13783_adc_read(dev, devattr);
> +
> +	/*
> +	 * input range is [0, 2.3V], res has 10 bits, so each bit
> +	 * is worth 9/4 mV.
> +	 */
> +	res *= 9;
> +
> +	return sprintf(buf, "%u.%02umV\n", res >> 2, (res & 3) * 25);

Ditto.

> +}
> +
> +SENSOR_DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL, 0);

You don't use this attribute anywhere, you should.

You also don't need SENSOR_DEVICE_ATTR here, DEVICE_ATTR would do.

> +SENSOR_DEVICE_ATTR(in02_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
> +SENSOR_DEVICE_ATTR(in05_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
> +SENSOR_DEVICE_ATTR(in06_input, S_IRUGO, mc13783_adc_read_gp, NULL, 6);
> +SENSOR_DEVICE_ATTR(in07_input, S_IRUGO, mc13783_adc_read_gp, NULL, 7);
> +SENSOR_DEVICE_ATTR(in08_input, S_IRUGO, mc13783_adc_read_gp, NULL, 8);
> +SENSOR_DEVICE_ATTR(in09_input, S_IRUGO, mc13783_adc_read_gp, NULL, 9);
> +SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, mc13783_adc_read_gp, NULL, 10);
> +SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, mc13783_adc_read_gp, NULL, 11);
> +SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, mc13783_adc_read_gp, NULL, 12);
> +SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, 13);
> +SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
> +SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);

All these attributes should be declared static.

> +
> +static struct attribute *mc13783_attr[] > +{
> +	&sensor_dev_attr_in02_input.dev_attr.attr,
> +	&sensor_dev_attr_in05_input.dev_attr.attr,
> +	&sensor_dev_attr_in06_input.dev_attr.attr,
> +	&sensor_dev_attr_in07_input.dev_attr.attr,
> +	&sensor_dev_attr_in08_input.dev_attr.attr,
> +	&sensor_dev_attr_in09_input.dev_attr.attr,
> +	&sensor_dev_attr_in10_input.dev_attr.attr,
> +	&sensor_dev_attr_in11_input.dev_attr.attr,
> +	NULL,

Trailing comma not needed.

> +};
> +
> +static const struct attribute_group mc13783_group = {
> +	.attrs = mc13783_attr,
> +};
> +
> +/* last four channels may be occupied by the touchscreen */
> +static struct attribute *mc13783_attr_ts[] > +{
> +	&sensor_dev_attr_in12_input.dev_attr.attr,
> +	&sensor_dev_attr_in13_input.dev_attr.attr,
> +	&sensor_dev_attr_in14_input.dev_attr.attr,
> +	&sensor_dev_attr_in15_input.dev_attr.attr,
> +	NULL,

Ditto.

> +};
> +
> +static const struct attribute_group mc13783_group_ts = {
> +	.attrs = mc13783_attr_ts,
> +};
> +
> +static int __devinit mc13783_adc_probe(struct platform_device *pdev)

Shouldn't this one be marked __init instead?

> +{
> +	struct mc13783_adc_priv *priv;
> +	int ret;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mc13783 = dev_get_drvdata(pdev->dev.parent);
> +
> +	/* Register sysfs hooks */
> +	ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group);
> +	if (ret)
> +		goto out_err_create1;
> +
> +	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN))
> +		ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
> +		if (ret)
> +			goto out_err_create2;
> +
> +	priv->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(priv->hwmon_dev)) {
> +		ret = PTR_ERR(priv->hwmon_dev);
> +		dev_err(&pdev->dev,
> +				"hwmon_device_register failed with %d.\n", ret);
> +		goto out_err_register;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);

You have a race condition here, get_drvdata could be called from a
sysfs file before the driver data pointer is set.

> +
> +	return 0;
> +
> +out_err_register:
> +
> +	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN))
> +		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
> +out_err_create2:
> +
> +	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group);
> +out_err_create1:
> +
> +	kfree(priv);
> +
> +	return ret;
> +}
> +
> +static int __devexit mc13783_adc_remove(struct platform_device *pdev)
> +{
> +	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
> +
> +	hwmon_device_unregister(&pdev->dev);
> +
> +	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN))
> +		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
> +
> +	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group);
> +
> +	kfree(priv);

Please set driver data to NULL first.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver mc13783_adc_driver = {
> +	.remove 	= __devexit_p(mc13783_adc_remove),
> +	.driver		= {
> +		.owner	= THIS_MODULE,
> +		.name	= MC13783_ADC_NAME,
> +	},
> +};
> +
> +static int __init mc13783_adc_init(void)
> +{
> +	return platform_driver_probe(&mc13783_adc_driver, mc13783_adc_probe);
> +}
> +
> +static void __exit mc13783_adc_exit(void)
> +{
> +	platform_driver_unregister(&mc13783_adc_driver);
> +}
> +
> +module_init(mc13783_adc_init);
> +module_exit(mc13783_adc_exit);
> +
> +MODULE_DESCRIPTION("MC13783 input touchscreen driver");

This doesn't look right.

> +MODULE_AUTHOR("Luotao Fu, <l.fu@pengutronix.de>");

Stray comma.

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" MC13783_ADC_NAME);

Please fix all of the above points and resubmit. And pretty please
_test_ your driver with libsensors. This is the best way to make sure
you have implemented the sysfs interface properly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
