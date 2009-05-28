From: Ben Dooks <ben@simtec.co.uk>
Date: Thu, 28 May 2009 11:22:41 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <4A1E7401.9000902@simtec.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben,
> 
> On Tue, 26 May 2009 09:07:01 +0100, Ben Dooks wrote:
>> Add support for the ADC controller on the S3C
>> series of processors to drivers/hwmon for use with
>> hardware monitoring systems.
> 
> Random comments:
> 
>> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
>>
>> Index: linux.git/drivers/hwmon/Kconfig
>> =================================>> --- linux.git.orig/drivers/hwmon/Kconfig	2009-05-20 22:02:06.000000000 +0100
>> +++ linux.git/drivers/hwmon/Kconfig	2009-05-20 22:02:43.000000000 +0100
>> @@ -702,6 +702,16 @@ config SENSORS_SHT15
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called sht15.
>>  
>> +config SENSORS_S3C_ADC
>> +	tristate "S3C24XX/S3C64XX Inbuilt ADC"
>> +	depends on HWMON && (ARCH_S3C2410 || ARCH_S3C64XX)
> 
> This item is inside a big "if HWMON" block, no need to repeat the
> condition.
> 
>> +	help
>> +	  If you say yes here you get support for the on-board ADCs of
>> +	  the Samsung S3C24XX or S3C64XX series of SoC
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called s3c-adc.
>> +
>>  config SENSORS_SIS5595
>>  	tristate "Silicon Integrated Systems Corp. SiS5595"
>>  	depends on PCI
>> Index: linux.git/drivers/hwmon/Makefile
>> =================================>> --- linux.git.orig/drivers/hwmon/Makefile	2009-05-20 22:02:06.000000000 +0100
>> +++ linux.git/drivers/hwmon/Makefile	2009-05-20 22:02:43.000000000 +0100
>> @@ -76,6 +76,7 @@ obj-$(CONFIG_SENSORS_MAX6650)	+= max6650
>>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>> +obj-$(CONFIG_SENSORS_S3C_ADC)	+= s3c-adc.o
>>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>>  obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
>>  obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>> Index: linux.git/drivers/hwmon/s3c-adc.c
>> =================================>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ linux.git/drivers/hwmon/s3c-adc.c	2009-05-26 09:00:22.000000000 +0100
>> @@ -0,0 +1,371 @@
>> +/* linux/drivers/hwmon/s3c-adc.c
>> + *
>> + * Copyright (C) 2005, 2008, 2009 Simtec Electronics
>> + *	http://armlinux.simtec.co.uk/
>> + *	Ben Dooks <ben@simtec.co.uk>
>> + *
>> + * S3C24XX/S3C64XX ADC hwmon support
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/init.h>
>> +#include <linux/err.h>
>> +#include <linux/clk.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +
>> +#include <plat/adc.h>
>> +#include <plat/hwmon.h>
>> +
>> +/**
>> + * struct s3c_hwmon - ADC hwmon client information
>> + * @lock: Access lock for conversion.
> 
> This gives us zero idea what the lock is protecting.

changed to:
  @lock: Access lock to serialise the conversions.

>> + * @wait: Wait queue for conversions to complete.
>> + * @client: The client we registered with the S3C ADC core.
>> + * @dev: The platform device we bound to.
>> + * @hwmon_dev: The hwmon device we created.
>> + * @in_attr: The device attributes we created.
>> +*/
>> +struct s3c_hwmon {
>> +	struct semaphore	lock;
> 
> 
>> +	wait_queue_head_t	wait;
>> +	int			val;
> 
> This is an horribly vague struct member name, and undocumented at that.

Added documentation and renamed to ret_val.

  * @ret_val: Value returned from current conversion to return to caller.

>> +
>> +	struct s3c_adc_client	*client;
>> +	struct platform_device	*dev;
> 
> The fact that you need this suggests a wrong calling convention
> somewhere in the code.
> 
>> +	struct device		*hwmon_dev;
>> +
>> +	struct sensor_device_attribute *in_attr[8];
> 
> What is the benefit of allocating these attributes dynamically? You are
> likely to fragment your memory and require ugly code to make it work.
> 
>> +};
>> +
>> +static inline struct s3c_hwmon *dev_to_ourhwmon(struct platform_device *dev)
>> +{
>> +	return (struct s3c_hwmon *)platform_get_drvdata(dev);
> 
> Useless cast. Not to mention that this function is pretty much
> pointless... just call platform_get_drvdata directly.

ok, removed.

>> +}
>> +
>> +static struct s3c_hwmon *done_adc;
> 
> What is this?

The core adc driver doesn't keep any private data, so we need
this to get back to our state when the conversion ends.

>> +
>> +/**
>> + * s3c_hwmon_adcdone - ADC core callback
>> + * @value: The value that we got from the ADC core
>> + * @ignore: Only used for the touchscreen client.
>> + * @left: The number of conversions left (not used here).
>> + *
>> + * This is called when the ADC has finished its conversion to
>> + * inform us of the result.
>> + */
>> +static void s3c_hwmon_adcdone(unsigned value, unsigned ignore, unsigned *left)
>> +{
>> +	struct s3c_hwmon *hwmon = done_adc;
>> +
>> +	hwmon->val = value;
>> +	wake_up(&hwmon->wait);
>> +}
>> +
>> +/**
>> + * s3c_hwmon_read_ch - read a value from a given adc channel.
>> + * @hwmon: Our state.
>> + * @channel: The channel we're reading from.
>> + *
>> + * Read a value from the @channel with the proper locking and sleep until
>> + * either the read completes or we timeout awaiting the ADC core to get
>> + * back to us.
>> + */
>> +static int s3c_hwmon_read_ch(struct s3c_hwmon *hwmon, int channel)
>> +{
>> +	unsigned long timeout;
>> +	int ret;
>> +
>> +	ret = down_interruptible(&hwmon->lock);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_dbg(&hwmon->dev->dev, "reading channel %d\n", channel);
>> +
>> +	hwmon->val = -1;
>> +	done_adc = hwmon;
>> +
>> +	ret = s3c_adc_start(hwmon->client, channel, 1);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	timeout = wait_event_timeout(hwmon->wait, hwmon->val >= 0, HZ / 2);
>> +	ret = (timeout = 0) ? -ETIMEDOUT : hwmon->val;
>> +
>> + err:
>> +	up(&hwmon->lock);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * s3c_hwmon_show_raw - show a conversion from the raw channel number.
>> + * @dev: The device that the attribute belongs to.
>> + * @attr: The attribute being read.
>> + * @buf: The result buffer.
>> + *
>> + * This show deals with the raw attribute, registered for each possible
>> + * ADC channel. This does a conversion and returns the raw (un-scaled)
>> + * value returned from the hardware.
>> + */
>> +static ssize_t s3c_hwmon_show_raw(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct s3c_hwmon *adc = dev_to_ourhwmon(to_platform_device(dev));
> 
> aka dev_get_drvdata().

removed.

>> +	int ret, nr;
>> +
>> +	nr = attr->attr.name[3] - '0';
> 
> This is pretty fragile. Please use SENSOR_ATTR() instead.

ok, done.

>> +	ret = s3c_hwmon_read_ch(adc, nr);
>> +
>> +	return  (ret < 0) ? ret : snprintf(buf, PAGE_SIZE, "%d\n", ret);
>> +}
>> +
>> +#define DEF_ADC_ATTR(x)	\
>> +	static DEVICE_ATTR(adc##x##_raw, S_IRUGO, s3c_hwmon_show_raw, NULL)
>> +
>> +DEF_ADC_ATTR(0);
>> +DEF_ADC_ATTR(1);
>> +DEF_ADC_ATTR(2);
>> +DEF_ADC_ATTR(3);
>> +DEF_ADC_ATTR(4);
>> +DEF_ADC_ATTR(5);
>> +DEF_ADC_ATTR(6);
>> +DEF_ADC_ATTR(7);
>> +
>> +static struct device_attribute *s3c_hwmon_attrs[8] = {
>> +	&dev_attr_adc0_raw,
>> +	&dev_attr_adc1_raw,
>> +	&dev_attr_adc2_raw,
>> +	&dev_attr_adc3_raw,
>> +	&dev_attr_adc4_raw,
>> +	&dev_attr_adc5_raw,
>> +	&dev_attr_adc6_raw,
>> +	&dev_attr_adc7_raw,
>> +};
> 
> This looks like debugging stuff. Does it really need to stay in the
> final code? I would make it conditional, at least.

Added config to include them.

>> +
>> +/**
>> + * s3c_hwmon_ch_show - show value of a given channel
>> + * @dev: The device that the attribute belongs to.
>> + * @attr: The attribute being read.
>> + * @buf: The result buffer.
>> + *
>> + * Read a value from the ADC and scale it before returning it to the
>> + * caller. The scale factor is gained from the channel configuration
>> + * passed via the platform data when the device was registered.
>> + */
>> +static ssize_t s3c_hwmon_ch_show(struct device *dev,
>> +				 struct device_attribute *attr,
>> +				 char *buf)
>> +{
>> +	struct sensor_device_attribute *sen_attr = to_sensor_dev_attr(attr);
>> +	struct s3c_hwmon_pdata *pdata = dev->platform_data;
>> +	struct s3c_hwmon *hwmon = dev_to_ourhwmon(to_platform_device(dev));
>> +	struct s3c_hwmon_chcfg *cfg;
>> +
>> +	int ret;
>> +
>> +	cfg = pdata->in[sen_attr->index];
>> +	if (!cfg)
>> +		return -EINVAL;
>> +
>> +	ret = s3c_hwmon_read_ch(hwmon, sen_attr->index);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret *= cfg->mult;
>> +	ret /= cfg->div;
> 
> Division lacks rounding.
>

Which rounding should be used?

>> +
>> +	return snprintf(buf, PAGE_SIZE, "%d\n", ret);
>> +}
>> +
>> +#define MAX_LABEL (16)
>> +
>> +/**
>> + * s3c_hwmon_create_attr - create hwmon attribute for given channel.
>> + * @hwmon: Our hwmon instance.
>> + * @pdata: The platform data provided by the device.
>> + * @channel: The ADC channel number to process.
>> + *
>> + * Create the scaled attribute for use with hwmon from the specified
>> + * platform data in @pdata. The sysfs entry is handled by the routine
>> + * s3c_hwmon_ch_show().
>> + *
>> + * The attribute name is taken from the configuration data if present
>> + * otherwise the name is taken by concatenating in_ with the channel
>> + * number.
>> + */
>> +static int s3c_hwmon_create_attr(struct s3c_hwmon *hwmon,
>> +				 struct s3c_hwmon_pdata *pdata,
>> +				 int channel)
>> +{
>> +	struct s3c_hwmon_chcfg *cfg = pdata->in[channel];
>> +	struct sensor_device_attribute *attr;
>> +	const char *name;
>> +
>> +	if (!cfg)
>> +		return 0;
>> +
>> +	attr = kzalloc(sizeof(*attr) + MAX_LABEL, GFP_KERNEL);
>> +	if (attr = NULL)
>> +		return -ENOMEM;
>> +
>> +	if (cfg->name)
>> +		name = cfg->name;
>> +	else {
>> +		name = (char *)(attr+1);
>> +		snprintf((char *)(attr+1), MAX_LABEL, "in_%d", channel);
> 
> This name doesn't match what is described in
> Documentation/hwmon/sysfs-interface, which means that your driver won't
> work with libsensors. This is a blocker.

ok, fixed.

>> +	}
>> +
>> +	attr->dev_attr.attr.name  = name;
>> +	attr->dev_attr.attr.mode  = S_IRUGO;
>> +	attr->dev_attr.attr.owner = THIS_MODULE;
>> +	attr->dev_attr.show = s3c_hwmon_ch_show;
>> +
>> +	attr->index = channel;
>> +	hwmon->in_attr[channel] = attr;
>> +
>> +	return device_create_file(&hwmon->dev->dev, &attr->dev_attr);
>> +}
>> +
>> +/**
>> + * s3c_hwmon_probe - device probe entry.
>> + * @dev: The device being probed.
>> +*/
>> +static int s3c_hwmon_probe(struct platform_device *dev)
> 
> No __devinit?

fixed.

>> +{
>> +	struct s3c_hwmon_pdata *pdata = dev->dev.platform_data;
>> +	struct s3c_hwmon *hwmon;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	hwmon = kzalloc(sizeof(struct s3c_hwmon), GFP_KERNEL);
>> +	if (hwmon = NULL) {
>> +		dev_err(&dev->dev, "no memory\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	platform_set_drvdata(dev, hwmon);
>> +	hwmon->dev = dev;
>> +
>> +	/* only enable the clock when we are actually using the adc */
>> +
>> +	init_waitqueue_head(&hwmon->wait);
>> +	init_MUTEX(&hwmon->lock);
>> +
>> +	/* Register with the core ADC driver. */
>> +
>> +	hwmon->client = s3c_adc_register(dev, NULL, s3c_hwmon_adcdone, 0);
>> +	if (IS_ERR(hwmon->client)) {
>> +		dev_err(&dev->dev, "cannot register adc\n");
>> +		ret = PTR_ERR(hwmon->client);
>> +		goto err_mem;
>> +	}
>> +
>> +	/* add attributes for our adc devices. */
>> +
>> +	for (i = 0; i < ARRAY_SIZE(s3c_hwmon_attrs); i++) {
>> +		ret = device_create_file(&dev->dev, s3c_hwmon_attrs[i]);
>> +		if (ret) {
>> +			dev_err(&dev->dev, "error creating channel %d\n", i);
>> +
>> +			for (i--; i >= 0; i--)
>> +				device_remove_file(&dev->dev, s3c_hwmon_attrs[i]);
>> +
>> +			goto err_registered;
>> +		}
>> +	}
>> +
>> +	/* register with the hwmon core */
>> +
>> +	hwmon->hwmon_dev = hwmon_device_register(&dev->dev);
>> +	if (IS_ERR(hwmon->hwmon_dev)) {
>> +		dev_err(&dev->dev, "error registering with hwmon\n");
>> +		ret = PTR_ERR(hwmon->hwmon_dev);
>> +		goto err_attribute;
>> +	}
>> +
>> +	if (pdata) {
>> +		for (i = 0; i < ARRAY_SIZE(pdata->in); i++)
>> +			s3c_hwmon_create_attr(hwmon, pdata, i);
> 
> No error check?

added

>> +	}
>> +
>> +	return 0;
>> +
>> + err_attribute:
>> +	for (i = 0; i < ARRAY_SIZE(s3c_hwmon_attrs); i++)
>> +		device_remove_file(&dev->dev, s3c_hwmon_attrs[i]);
>> +
>> + err_registered:
>> +	s3c_adc_release(hwmon->client);
>> +
>> + err_mem:
>> +	kfree(hwmon);
>> +	return ret;
>> +}
>> +
>> +static int __devexit s3c_hwmon_remove(struct platform_device *dev)
>> +{
>> +	struct s3c_hwmon *hwmon = dev_to_ourhwmon(dev);
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(s3c_hwmon_attrs); i++)
>> +		device_remove_file(&dev->dev, s3c_hwmon_attrs[i]);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hwmon->in_attr); i++) {
>> +		if (!hwmon->in_attr[i])
>> +			continue;
>> +
>> +		device_remove_file(&dev->dev, &hwmon->in_attr[i]->dev_attr);
>> +		kfree(hwmon->in_attr[i]);
>> +	}
>> +
>> +	hwmon_device_unregister(hwmon->hwmon_dev);
>> +	s3c_adc_release(hwmon->client);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver s3c_hwmon_driver = {
>> +	.driver	= {
>> +		.name		= "s3c-hwmon",
> 
> Please make this match the module name.

right, will rename driver file to s3c-hwmon.c

>> +		.owner		= THIS_MODULE,
>> +	},
>> +	.probe		= s3c_hwmon_probe,
>> +	.remove		= __devexit_p(s3c_hwmon_remove),
>> +};
>> +
>> +static int __init s3c_hwmon_init(void)
>> +{
>> +	return platform_driver_register(&s3c_hwmon_driver);
>> +}
>> +
>> +static void __exit s3c_hwmon_exit(void)
>> +{
>> +	platform_driver_unregister(&s3c_hwmon_driver);
>> +}
>> +
>> +module_init(s3c_hwmon_init);
>> +module_exit(s3c_hwmon_exit);
>> +
>> +MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
>> +MODULE_DESCRIPTION("S3C ADC HWMon driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:s3c-hwmon");
>> Index: linux.git/arch/arm/plat-s3c/include/plat/hwmon.h
>> =================================>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ linux.git/arch/arm/plat-s3c/include/plat/hwmon.h	2009-05-20 22:02:43.000000000 +0100
>> @@ -0,0 +1,43 @@
>> +/* linux/arch/arm/plat-s3c/include/plat/hwmon.h
>> + *
>> + * Copyright 2005 Simtec Electronics
>> + *	Ben Dooks <ben@simtec.co.uk>
>> + *	http://armlinux.simtec.co.uk/
>> + *
>> + * S3C - HWMon interface for ADC
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef __ASM_ARCH_ADC_HWMON_H
>> +#define __ASM_ARCH_ADC_HWMON_H __FILE__
>> +
>> +/**
>> + * s3c_hwmon_chcfg - channel configuration
>> + * @name: The name to give this channel.
>> + * @mult: Multiply the ADC value read by this.
>> + * @div: Divide the value from the ADC by this.
>> + *
>> + * The value read from the ADC is converted to a value that
>> + * hwmon expects (mV) by result = (value_read * @mult) / @div.
>> + */
>> +struct s3c_hwmon_chcfg {
>> +	const char	*name;
>> +	unsigned int	min;
>> +	unsigned int	max;
> 
> Unused attributes?

will remove.

>> +	unsigned int	mult;
>> +	unsigned int	div;
>> +};
>> +
>> +/**
>> + * s3c_hwmon_pdata - HWMON platform data
>> + * @in: One configuration for each possible channel used.
>> + */
>> +struct s3c_hwmon_pdata {
>> +	struct s3c_hwmon_chcfg	*in[8];
>> +};
>> +
>> +#endif /* __ASM_ARCH_ADC_HWMON_H */

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
