From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 22 Sep 2011 17:50:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: OMAP4460+: On die temperature
Message-Id: <1316713841.3888.6.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316713013-14751-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1316713013-14751-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, 2011-09-22 at 13:36 -0400, Keerthy wrote:
> On chip temperature sensor driver. The driver monitors the temperature of
> on die subsystems. It sends notifications to the user space if
> the temperature crosses user defined thresholds via kobject_uevent interface.
> The user is allowed to configure the temperature thresholds vis sysfs nodes
> exposed using hwmon interface.
> 
> The patch depends on the the following series:
> http://comments.gmane.org/gmane.linux.ports.arm.omap/64436
> and
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/64446
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: lm-sensors@lm-sensors.org
> ---
>  Documentation/hwmon/omap_temp_sensor     |   25 +++
>  drivers/hwmon/Kconfig                    |   11 ++
>  drivers/hwmon/Makefile                   |    1 +
>  drivers/hwmon/omap4460plus_temp_sensor.c |  244 ++++++++++++++++++++++++++++++
>  4 files changed, 281 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/omap_temp_sensor
>  create mode 100644 drivers/hwmon/omap4460plus_temp_sensor.c
> 
> Index: linux-omap-2.6/Documentation/hwmon/omap_temp_sensor
> =================================> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/Documentation/hwmon/omap_temp_sensor	2011-09-22 18:57:23.180918857 +0530
> @@ -0,0 +1,25 @@
> +Kernel driver omap_temp_sensor
> +===============
> +
> +Supported chips:
> +  * Texas Instruments OMAP4460
> +    Prefix: 'omap_temp_sensor'
> +
> +Author:
> +        J Keerthy <j-keerthy@ti.com>
> +
> +Description
> +-----------
> +
> +The Texas Instruments OMAP4 family of chips have a bandgap temperature sensor.
> +The temperature sensor feature is used to convert the temperature of the device
> +into a decimal value coded on 10 bits. An internal ADC is used for conversion.
> +The recommended operating temperatures must be in the range -40 degree Celsius
> +to 123 degree celsius for standard conversion.
> +The thresholds are programmable and upon crossing the thresholds an interrupt
> +is generated. The OMAP temperature sensor has a programmable update rate in
> +milli seconds.
> +(Currently the driver programs a default of 2000 milliseconds).
> +
> +The driver provides the common sysfs-interface for temperatures (see
> +Documentation/hwmon/sysfs-interface under Temperatures).
> Index: linux-omap-2.6/drivers/hwmon/Kconfig
> =================================> --- linux-omap-2.6.orig/drivers/hwmon/Kconfig	2011-09-22 17:48:38.032575702 +0530
> +++ linux-omap-2.6/drivers/hwmon/Kconfig	2011-09-22 19:02:28.744575604 +0530
> @@ -323,6 +323,17 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called f71805f.
>  
> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
> +	bool "OMAP on-die temperature sensor hwmon driver"
> +	depends on HWMON && ARCH_OMAP && OMAP4460PLUS_SCM
> +	help
> +	  If you say yes here you get support for hardware
> +	  monitoring features of the OMAP on die temperature
> +	  sensor.
> +
> +	  Continuous conversion programmable delay
> +	  mode is used for temperature conversion.
> +
>  config SENSORS_F71882FG
>  	tristate "Fintek F71882FG and compatibles"
>  	help
> Index: linux-omap-2.6/drivers/hwmon/Makefile
> =================================> --- linux-omap-2.6.orig/drivers/hwmon/Makefile	2011-09-22 17:48:38.020575728 +0530
> +++ linux-omap-2.6/drivers/hwmon/Makefile	2011-09-22 18:57:23.192574712 +0530
> @@ -93,6 +93,7 @@
>  obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
>  obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR)  += omap4460plus_temp_sensor.o
>  obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
> Index: linux-omap-2.6/drivers/hwmon/omap4460plus_temp_sensor.c
> =================================> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/drivers/hwmon/omap4460plus_temp_sensor.c	2011-09-22 19:02:11.096575567 +0530
> @@ -0,0 +1,242 @@
> +/*
> + *
> + * OMAP4460 Plus bandgap on die sensor hwmon driver.
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * J Keerthy <j-keerthy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl4030-madc.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/stddef.h>
> +#include <linux/sysfs.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <plat/scm.h>
> +
> +static ssize_t show_name(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, tsh->name);
> +}
> +
> +static ssize_t show_temp_max(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id;
> +	int temp;
> +
> +	temp = omap4460plus_scm_show_temp_max(tsh->scm_ptr, id);
> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +
> +static ssize_t set_temp_max(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id, ret;
> +	long val;
> +
> +	if (strict_strtol(buf, 10, &val))
> +		return -EINVAL;
> +	ret = omap4460plus_scm_set_temp_max(tsh->scm_ptr, id, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp_max_hyst(struct device *dev,
> +				  struct device_attribute *devattr, char *buf)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id;
> +	int temp;
> +
> +	temp = omap4460plus_scm_show_temp_max_hyst(tsh->scm_ptr, id);
> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +
> +static ssize_t set_temp_max_hyst(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 const char *buf, size_t count)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id, ret;
> +	long val;
> +
> +	if (strict_strtol(buf, 10, &val))
> +		return -EINVAL;

Value range [-MAXLONG, MAXLONG] is ok for set functions ? Or does the
called functions check the range ?

> +	ret = omap4460plus_scm_set_temp_max_hyst(tsh->scm_ptr, id, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t show_update_interval(struct device *dev,
> +				    struct device_attribute *devattr, char *buf)
> +{
> +	int time = 0;
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id;
> +
> +	time = omap4460plus_scm_show_update_interval(tsh->scm_ptr, id);
> +
> +	return sprintf(buf, "%d\n", time);
> +}
> +
> +static ssize_t set_update_interval(struct device *dev,
> +				   struct device_attribute *devattr,
> +				   const char *buf, size_t count)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id;
> +	long val;
> +
> +	if (strict_strtol(buf, 10, &val))
> +		count = -EINVAL;
> +
This is really odd. You are going to return an error, yet set the update
interval to whatever happens to be in val even if it was not set (unless
that value is < 0).

You should directly return -EINVAL here. Also, since you don't accept
negative values, you might as well use strict_strtoul() instead.

> +
> +	if (val < 0)
> +		return -EINVAL;

The value range [0, MAXLONG] is ok ?

> +	omap4460plus_scm_set_update_interval(tsh->scm_ptr, val, id);
> +	return count;
> +}
> +
> +static int read_temp(struct device *dev,
> +		     struct device_attribute *devattr, char *buf)
> +{
> +	struct temp_sensor_hwmon *tsh = dev_get_drvdata(dev);
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	int id = pdev->id;
> +	int temp;
> +
> +	temp = omap4460plus_scm_read_temp(tsh->scm_ptr, id);
> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, read_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> +			  set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_max_hyst,
> +			  set_temp_max_hyst, 0);
> +static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
> +			  show_update_interval, set_update_interval, 0);
> +
> +static struct attribute *temp_sensor_attributes[] = {
> +	&dev_attr_name.attr,
> +
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_update_interval.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group temp_sensor_group = {
> +	.attrs = temp_sensor_attributes,
> +};
> +
> +static int __devinit omap4460plus_temp_sensor_probe(struct platform_device
> +							*pdev)
> +{
> +	int ret;
> +	struct device *hwmon;
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &temp_sensor_group);
> +	if (ret)
> +		goto err_sysfs;
> +	hwmon = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(hwmon)) {
> +		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> +		ret = PTR_ERR(hwmon);
> +		goto err_reg;
> +	}
> +
> +	return 0;
> +
> +err_reg:
> +	sysfs_remove_group(&pdev->dev.kobj, &temp_sensor_group);
> +err_sysfs:
> +
> +	return ret;
> +}
> +
> +static int __devexit omap4460plus_temp_sensor_remove(struct platform_device
> +						     *pdev)
> +{
> +	hwmon_device_unregister(&pdev->dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &temp_sensor_group);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver omap4460plus_temp_sensor_driver = {
> +	.probe = omap4460plus_temp_sensor_probe,
> +	.remove = omap4460plus_temp_sensor_remove,
> +	.driver = {
> +		   .name = "temp_sensor_hwmon",
> +		   },
> +};
> +
> +int __init omap4460plus_temp_sensor_init(void)
> +{
> +	return platform_driver_register(&omap4460plus_temp_sensor_driver);
> +}
> +
> +module_init(omap4460plus_temp_sensor_init);
> +
> +static void __exit omap4460plus_temp_sensor_exit(void)
> +{
> +	platform_driver_unregister(&omap4460plus_temp_sensor_driver);
> +}
> +
> +module_exit(omap4460plus_temp_sensor_exit);
> +
> +MODULE_DESCRIPTION("OMAP446X temperature sensor Hwmon Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
