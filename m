From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Sep 2012 03:11:40 +0000
Subject: Re: [lm-sensors] [Patch v1 5/7] DA9055 HWMON driver
Message-Id: <20120915031140.GA20410@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347629518.18587.17.camel@dhruva>
In-Reply-To: <1347629518.18587.17.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 14, 2012 at 07:01:58PM +0530, Ashish Jangam wrote:
> This is the HWMON patch for DA9055 PMIC and has got dependency on the
> DA9055 MFD core.
> 
> This patch monitors the DA9055 PMIC's ADC channels vddout, junction
> temperature and auxiliary channels.
> 
> This patch is functionally tested on Samsung SMDKV6410.
> 
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
> ---
>  Documentation/hwmon/da9055   |   47 ++++++
>  drivers/hwmon/Kconfig        |   10 ++
>  drivers/hwmon/Makefile       |    1 +
>  drivers/hwmon/da9055-hwmon.c |  342 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 400 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/da9055
>  create mode 100644 drivers/hwmon/da9055-hwmon.c
> 
> diff --git a/Documentation/hwmon/da9055 b/Documentation/hwmon/da9055
> new file mode 100644
> index 0000000..2673dfb
> --- /dev/null
> +++ b/Documentation/hwmon/da9055
> @@ -0,0 +1,47 @@
> +Supported chips:
> +  * Dialog Semiconductors DA9055 PMIC
> +    Prefix: 'da9055'
> +    Datasheet: Datasheet is not publicly available.
> +
> +Authors: David Dajun Chen <dchen@diasemi.com>
> +
> +Description
> +-----------
> +
> +The DA9055 provides an Analogue to Digital Converter (ADC) with 10 bits
> +resolution and track and hold circuitry combined with an analogue input
> +multiplexer. The analogue input multiplexer will allow conversion of up to 5
> +different inputs. The track and hold circuit ensures stable input voltages at
> +the input of the ADC during the conversion.
> +
> +The ADC is used to measure the following inputs:
> +Channel 0: VDDOUT - measurement of the system voltage
> +Channel 1: ADC_IN1 - high impedance input (0 - 2.5V)
> +Channel 2: ADC_IN2 - high impedance input (0 - 2.5V)
> +Channel 3: ADC_IN3 - high impedance input (0 - 2.5V)
> +Channel 4: Internal Tjunc. - sense (internal temp. sensor)
> +
> +By using sysfs attributes we can measure the system voltage VDDOUT,
> +chip junction temperature and auxiliary channels voltages.
> +
> +Voltage Monitoring
> +------------------
> +
> +Voltages are sampled in a AUTO mode it can be manually sampled too and results
> +are stored in a 10 bit ADC.
> +
> +The system voltage is calculated as:
> +	Milli volt = ((ADC value * 1000) / 85) + 2500
> +
> +The voltages on ADC channels 1, 2 and 3 are calculated as:
> +	Milli volt = (ADC value * 1000) / 102
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are sampled by a 10 bit ADC.  Junction temperatures
> +are monitored by the ADC channels.
> +
> +The junction temperature is calculated:
> +	Degrees celsius = -0.4084 * (ADC_RES - T_OFFSET) - 307.6332
> +The junction temperature attribute is supported by the driver.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index df463a3..139010b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -334,6 +334,16 @@ config SENSORS_DA9052_ADC
>  	  This driver can also be built as module. If so, the module
>  	  will be called da9052-hwmon.
>  
> +config SENSORS_DA9055
> +	tristate "Dialog Semiconductor DA9055 ADC"
> +	depends on MFD_DA9055
> +	help
> +	  If you say yes here you get support for ADC on the Dialog
> +	  Semiconductor DA9055 PMIC.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called da9055-hwmon.
> +
>  config SENSORS_I5K_AMB
>  	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
>  	depends on PCI && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b622dcb..da03eef 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
> +obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>  obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
>  obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
>  obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
> diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
> new file mode 100644
> index 0000000..3f35574
> --- /dev/null
> +++ b/drivers/hwmon/da9055-hwmon.c
> @@ -0,0 +1,342 @@
> +/*
> + * HWMON Driver for Dialog DA9055
> + *
> + * Copyright(c) 2012 Dialog Semiconductor Ltd.
> + *
> + * Author: David Dajun Chen <dchen@diasemi.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/completion.h>
> +
> +#include <linux/mfd/da9055/core.h>
> +#include <linux/mfd/da9055/reg.h>
> +
> +#define DA9055_ADCIN_DIV	102
> +#define DA9055_VSYS_DIV		85
> +
> +#define DA9055_ADC_VSYS		0
> +#define DA9055_ADC_ADCIN1	1
> +#define DA9055_ADC_ADCIN2	2
> +#define DA9055_ADC_ADCIN3	3
> +#define DA9055_ADC_TJUNC	4
> +
> +struct da9055_hwmon {
> +	struct da9055	*da9055;
> +	struct device	*class_device;
> +	struct mutex	hwmon_lock;
> +	struct mutex	irq_lock;
> +	struct completion done;
> +};
> +
> +static const char * const input_names[] = {
> +	[DA9055_ADC_VSYS]	=	"VSYS",
> +	[DA9055_ADC_ADCIN1]	=	"ADC IN1",
> +	[DA9055_ADC_ADCIN2]	=	"ADC IN2",
> +	[DA9055_ADC_ADCIN3]	=	"ADC IN3",
> +	[DA9055_ADC_TJUNC]	=	"CHIP TEMP",

Why tab after = ? Inconsistent with code below.

> +};
> +
> +static const u8 chan_mux[DA9055_ADC_TJUNC + 1] = {
> +	[DA9055_ADC_VSYS]	= DA9055_ADC_MUX_VSYS,
> +	[DA9055_ADC_ADCIN1]	= DA9055_ADC_MUX_ADCIN1,
> +	[DA9055_ADC_ADCIN2]	= DA9055_ADC_MUX_ADCIN2,
> +	[DA9055_ADC_ADCIN3]	= DA9055_ADC_MUX_ADCIN1,
> +	[DA9055_ADC_TJUNC]	= DA9055_ADC_MUX_T_SENSE,
> +};
> +
> +static int da9055_adc_manual_read(struct da9055_hwmon *hwmon,
> +					unsigned char channel)
> +{
> +	int ret;
> +	unsigned short calc_data;
> +	unsigned short data;
> +	unsigned char mux_sel;
> +	struct da9055 *da9055 = hwmon->da9055;
> +
> +	if (channel > DA9055_ADC_TJUNC)
> +		return -EINVAL;
> +
> +	mutex_lock(&hwmon->irq_lock);
> +
> +	/* Selects desired MUX for manual conversion */
> +	mux_sel = chan_mux[channel] | DA9055_ADC_MAN_CONV;
> +
> +	ret = da9055_reg_write(da9055, DA9055_REG_ADC_MAN, mux_sel);
> +	if (ret < 0)
> +		goto err;
> +
> +	/* Wait for an interrupt */
> +	if (!wait_for_completion_timeout(&hwmon->done,
> +					msecs_to_jiffies(500))) {
> +		dev_err(da9055->dev,
> +			"timeout waiting for ADC conversion interrupt\n");
> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}
> +
> +	ret = da9055_reg_read(da9055, DA9055_REG_ADC_RES_H);
> +	if (ret < 0)
> +		goto err;
> +
> +	calc_data = (unsigned short)ret;
> +	data = calc_data << 2;
> +
> +	ret = da9055_reg_read(da9055, DA9055_REG_ADC_RES_L);
> +	if (ret < 0)
> +		goto err;
> +
> +	calc_data = (unsigned short)(ret & DA9055_ADC_LSB_MASK);
> +	data |= calc_data;
> +
> +	ret = data;
> +
> +err:
> +	mutex_unlock(&hwmon->irq_lock);
> +	return ret;
> +}
> +
> +static irqreturn_t da9055_auxadc_irq(int irq, void *irq_data)
> +{
> +	struct da9055_hwmon *hwmon = irq_data;
> +
> +	complete(&hwmon->done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Conversion function for VSYS and ADCINx */
> +static inline int volt_reg_to_mV(int value, int channel)
> +{
> +	if (channel = DA9055_ADC_VSYS)
> +		return DIV_ROUND_CLOSEST(value * 1000, DA9055_VSYS_DIV) + 2500;
> +	else
> +		return DIV_ROUND_CLOSEST(value * 1000, DA9055_ADCIN_DIV);
> +}
> +
> +static int da9055_enable_auto_mode(struct da9055 *da9055, int channel)
> +{
> +
> +	return da9055_reg_update(da9055, DA9055_REG_ADC_CONT, 1 << channel,
> +				1 << channel);
> +
> +}
> +
> +static int da9055_disable_auto_mode(struct da9055 *da9055, int channel)
> +{
> +
> +	return da9055_reg_update(da9055, DA9055_REG_ADC_CONT, 1 << channel, 0);
> +}
> +
> +static ssize_t da9055_read_auto_ch(struct device *dev,
> +				struct device_attribute *devattr, char *buf)
> +{
> +	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
> +	int ret, adc;
> +	int channel = to_sensor_dev_attr(devattr)->index;
> +
> +	mutex_lock(&hwmon->hwmon_lock);
> +
> +	ret = da9055_enable_auto_mode(hwmon->da9055, channel);
> +	if (ret < 0)
> +		goto hwmon_err;
> +
> +	mdelay(10);
> +
> +	adc = da9055_reg_read(hwmon->da9055, DA9055_REG_VSYS_RES + channel);
> +	if (adc < 0) {
> +		ret = adc;
> +		goto hwmon_err_release;
> +	}
> +
> +	ret = da9055_disable_auto_mode(hwmon->da9055, channel);
> +	if (ret < 0)
> +		goto hwmon_err;
> +
> +	mutex_unlock(&hwmon->hwmon_lock);
> +
> +	return sprintf(buf, "%d\n", volt_reg_to_mV(adc, channel));
> +
> +hwmon_err_release:
> +	da9055_disable_auto_mode(hwmon->da9055, channel);
> +hwmon_err:
> +	mutex_unlock(&hwmon->hwmon_lock);
> +	return ret;
> +}
> +
> +static ssize_t da9055_read_tjunc(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
> +	int tjunc;
> +	int toffset;
> +
> +	tjunc = da9055_adc_manual_read(hwmon, DA9055_ADC_TJUNC);
> +	if (tjunc < 0)
> +		return tjunc;
> +
Just wondering ... is this a dynamic value ? Becaue if not, it is quite an
expensive operation to perform for each conversion.

> +	toffset = da9055_reg_read(hwmon->da9055, DA9055_REG_T_OFFSET);
> +	if (toffset < 0)
> +		return toffset;
> +
> +	/*
> +	 * Degrees celsius = -0.4084 * (ADC_RES - T_OFFSET) - 307.6332
> +	 * T_OFFSET is a trim value used to improve accuracy of the result
> +	 */
> +	return sprintf(buf, "%d\n", DIV_ROUND_CLOSEST(-4084 * (tjunc - toffset)
> +							+ 3076332, 10000));

Either the calculation or the comment is wrong here.

> +}
> +
> +static ssize_t da9055_hwmon_show_name(struct device *dev,
> +				      struct device_attribute *devattr,
> +				      char *buf)
> +{
> +	return sprintf(buf, "da9055-hwmon\n");
> +}
> +
> +static ssize_t show_label(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	return sprintf(buf, "%s\n",
> +		       input_names[to_sensor_dev_attr(devattr)->index]);
> +}
> +
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9055_read_auto_ch, NULL,
> +			  DA9055_ADC_VSYS);
> +static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
> +			  DA9055_ADC_VSYS);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, da9055_read_auto_ch, NULL,
> +			  DA9055_ADC_ADCIN1);
> +static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_label, NULL,
> +			  DA9055_ADC_ADCIN1);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, da9055_read_auto_ch, NULL,
> +			  DA9055_ADC_ADCIN2);
> +static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_label, NULL,
> +			  DA9055_ADC_ADCIN2);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, da9055_read_auto_ch, NULL,
> +			  DA9055_ADC_ADCIN3);
> +static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL,
> +			  DA9055_ADC_ADCIN3);
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, da9055_read_tjunc, NULL,
> +			  DA9055_ADC_TJUNC);
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
> +			  DA9055_ADC_TJUNC);
> +
> +static DEVICE_ATTR(name, S_IRUGO, da9055_hwmon_show_name, NULL);
> +
> +static struct attribute *da9055_attr[] = {
> +	&dev_attr_name.attr,
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in0_label.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_label.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_label.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_label.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group da9055_attr_group = {.attrs = da9055_attr};
> +
> +static int __init da9055_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct da9055_hwmon *hwmon;
> +	int hwmon_irq, ret;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9055_hwmon),
> +			     GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	mutex_init(&hwmon->hwmon_lock);
> +	mutex_init(&hwmon->irq_lock);
> +
I wasn't copied on all the code, so I don't see the actual register read and
write operations. I do wonder, though, if the operations protected by hwmon_lock
and the operations protected by irq_lock can interfer with each other.

> +	init_completion(&hwmon->done);
> +	hwmon->da9055 = dev_get_drvdata(pdev->dev.parent);
> +
> +	platform_set_drvdata(pdev, hwmon);
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &da9055_attr_group);
> +	if (ret)
> +		return ret;
> +
You have a race condition here - the files are created and its access functions
can be called, but the irq has not been installed yet. You should install the
irq first, then create the attribute files.

> +	hwmon_irq = platform_get_irq_byname(pdev, "HWMON");

This can return -ENXIO.

> +	ret = request_threaded_irq(hwmon_irq,
> +					NULL, da9055_auxadc_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"adc irq", hwmon);

There is now devm_request_threaded_irq which you can use to simplify the code
further.

> +	if (ret != 0)
> +		goto err_sysfs;
> +
> +	hwmon->class_device = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(hwmon->class_device)) {
> +		ret = PTR_ERR(hwmon->class_device);
> +		goto err_free_irq;
> +	}
> +
> +	return 0;
> +err_free_irq:
> +	free_irq(hwmon_irq, hwmon);
> +err_sysfs:
> +	sysfs_remove_group(&pdev->dev.kobj, &da9055_attr_group);
> +	return ret;
> +}
> +
> +static int __devexit da9055_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct da9055_hwmon *hwmon = platform_get_drvdata(pdev);
> +	int hwmon_irq;
> +
> +	hwmon_irq = platform_get_irq_byname(pdev, "HWMON");
> +
> +	free_irq(hwmon_irq, hwmon);
> +	hwmon_device_unregister(hwmon->class_device);
> +	sysfs_remove_group(&pdev->dev.kobj, &da9055_attr_group);
> +	platform_set_drvdata(pdev, NULL);
> +
I thought this taken care of by the infrastructure and no longer needed.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
