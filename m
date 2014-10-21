From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 Oct 2014 16:48:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (i5500_temp) New driver for the Intel 5500/5520/X58 chipsets
Message-Id: <20141021164839.GB11799@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141021090337.36b5f33d@endymion.delvare>
In-Reply-To: <20141021090337.36b5f33d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 21, 2014 at 09:03:37AM +0200, Jean Delvare wrote:
> The Intel 5500, 5520 and X58 chipsets embed a digital thermal sensor.
> This new driver supports it.
> 
> Note that on many boards the sensor seems to be disabled and reports
> the minimum value (36.5 degrees Celsius) all the time.
> 

Hi Jean,

Guess that explains why it doesn't work for me.

Is it possible to detect that condition and fail to load the driver
if the sensor is disabled, or to enable the sensor in the driver 
in that case ?

Personally I would not bother with a timed update function for this driver;
pcie accesses are not as expensive as i2c accesses. Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

for both patches.

Thanks,
Guenter

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Tested-by: Romain Dolbeau <romain@dolbeau.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/Kconfig      |   10 +
>  drivers/hwmon/Makefile     |    1 
>  drivers/hwmon/i5500_temp.c |  228 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+)
> 
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-3.17/drivers/hwmon/i5500_temp.c	2014-10-19 22:06:08.460835707 +0200
> @@ -0,0 +1,228 @@
> +/*
> + * i5500_temp - Driver for Intel 5500/5520/X58 chipset thermal sensor
> + *
> + * Copyright (C) 2012, 2014 Jean Delvare <jdelvare@suse.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/pci.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +
> +/* Register definitions from datasheet */
> +#define REG_TSTHRCATA	0xE2
> +#define REG_TSCTRL	0xE8
> +#define REG_TSTHRRPEX	0xEB
> +#define REG_TSTHRLO	0xEC
> +#define REG_TSTHRHI	0xEE
> +#define REG_CTHINT	0xF0
> +#define REG_TSFSC	0xF3
> +#define REG_CTSTS	0xF4
> +#define REG_TSTHRRQPI	0xF5
> +#define REG_CTCTRL	0xF7
> +#define REG_TSTIMER	0xF8
> +
> +struct i5500_temp_data {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +	const char *name;
> +	char valid;		/* zero until following fields are valid */
> +	unsigned long last_updated;	/* in jiffies */
> +
> +	/* registers values */
> +	u16 tsthr[3];	/* 0: tsthrcata
> +			 * 1: tsthrlo
> +			 * 2: tsthrhi */
> +	s8 tsfsc;
> +	u8 ctsts;
> +};
> +
> +static struct i5500_temp_data *
> +i5500_temp_update_device(struct device *dev)
> +{
> +	struct i5500_temp_data *data = dev_get_drvdata(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (!data->valid
> +	    || time_after(jiffies, data->last_updated + HZ)) {
> +		pci_read_config_word(pdev, REG_TSTHRCATA, &data->tsthr[0]);
> +		pci_read_config_word(pdev, REG_TSTHRLO, &data->tsthr[1]);
> +		pci_read_config_word(pdev, REG_TSTHRHI, &data->tsthr[2]);
> +		pci_read_config_byte(pdev, REG_TSFSC, &data->tsfsc);
> +		pci_read_config_byte(pdev, REG_CTSTS, &data->ctsts);
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return data;
> +}
> +
> +/*
> + * Sysfs stuff
> + */
> +
> +/* Sensor resolution : 0.5 degree C */
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	struct i5500_temp_data *data = i5500_temp_update_device(dev);
> +	long temp;
> +
> +	temp = ((long)data->tsthr[2] - data->tsfsc) * 500;
> +
> +	return sprintf(buf, "%ld\n", temp);
> +}
> +
> +static ssize_t show_thresh(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	struct i5500_temp_data *data = i5500_temp_update_device(dev);
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	long temp;
> +
> +	temp = data->tsthr[nr] * 500;
> +
> +	return sprintf(buf, "%ld\n", temp);
> +}
> +
> +static ssize_t show_alarm(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	struct i5500_temp_data *data = i5500_temp_update_device(dev);
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +
> +	return sprintf(buf, "%u\n", (unsigned int)data->ctsts & (1 << nr));
> +}
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +			 *devattr, char *buf)
> +{
> +	struct i5500_temp_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_thresh, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_thresh, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_thresh, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +
> +static struct attribute *i5500_temp_attributes[] = {
> +	&dev_attr_temp1_input.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	&dev_attr_name.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group i5500_temp_group = {
> +	.attrs = i5500_temp_attributes,
> +};
> +
> +static const struct pci_device_id i5500_temp_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3438) },
> +	{ 0 },
> +};
> +
> +MODULE_DEVICE_TABLE(pci, i5500_temp_ids);
> +
> +static int i5500_temp_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	int err;
> +	struct i5500_temp_data *data;
> +
> +	data = kzalloc(sizeof(struct i5500_temp_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	data->name = "intel5500";
> +	mutex_init(&data->update_lock);
> +	dev_set_drvdata(&pdev->dev, data);
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to enable device\n");
> +		goto exit_free;
> +	}
> +
> +	/* Register sysfs hooks */
> +	err = sysfs_create_group(&pdev->dev.kobj, &i5500_temp_group);
> +	if (err)
> +		goto exit_free;
> +
> +	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove;
> +	}
> +
> +	return 0;
> +
> + exit_remove:
> +	sysfs_remove_group(&pdev->dev.kobj, &i5500_temp_group);
> + exit_free:
> +	kfree(data);
> + exit:
> +	return err;
> +}
> +
> +static void i5500_temp_remove(struct pci_dev *pdev)
> +{
> +	struct i5500_temp_data *data = dev_get_drvdata(&pdev->dev);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &i5500_temp_group);
> +	kfree(data);
> +}
> +
> +static struct pci_driver i5500_temp_driver = {
> +	.name = "i5500_temp",
> +	.id_table = i5500_temp_ids,
> +	.probe = i5500_temp_probe,
> +	.remove = i5500_temp_remove,
> +};
> +
> +static int __init i5500_temp_init(void)
> +{
> +	return pci_register_driver(&i5500_temp_driver);
> +}
> +
> +static void __exit i5500_temp_exit(void)
> +{
> +	pci_unregister_driver(&i5500_temp_driver);
> +}
> +
> +MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
> +MODULE_DESCRIPTION("Intel 5500/5200/X58 chipset thermal sensor driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(i5500_temp_init)
> +module_exit(i5500_temp_exit)
> --- linux-3.17.orig/drivers/hwmon/Kconfig	2014-10-19 21:23:45.113973545 +0200
> +++ linux-3.17/drivers/hwmon/Kconfig	2014-10-19 21:44:12.841029231 +0200
> @@ -574,6 +574,16 @@ config SENSORS_IIO_HWMON
>  	  for those channels specified in the map.  This map can be provided
>  	  either via platform data or the device tree bindings.
>  
> +config SENSORS_I5500
> +	tristate "Intel 5500/5520/X58 temperature sensor"
> +	depends on X86
> +	help
> +	  If you say yes here you get support for the temperature
> +	  sensor inside the Intel 5500, 5520 and X58 chipsets.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i5500_temp.
> +
>  config SENSORS_CORETEMP
>  	tristate "Intel Core/Core2/Atom temperature sensor"
>  	depends on X86
> --- linux-3.17.orig/drivers/hwmon/Makefile	2014-10-19 21:23:45.113973545 +0200
> +++ linux-3.17/drivers/hwmon/Makefile	2014-10-19 21:34:12.828297092 +0200
> @@ -68,6 +68,7 @@ obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-f
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
>  obj-$(CONFIG_SENSORS_HTU21)	+= htu21.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
> +obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
>  obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
>  obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
>  obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
