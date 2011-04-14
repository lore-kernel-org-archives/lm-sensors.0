From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Apr 2011 18:41:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] i8k: Integrate with the hwmon subsystem
Message-Id: <1302806507.26780.419.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110413172856.06682baf@endymion.delvare>
In-Reply-To: <20110413172856.06682baf@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-04-13 at 11:28 -0400, Jean Delvare wrote:
> Let i8k create an hwmon class device so that libsensors will expose
> the CPU temperature and fan speeds to monitoring applications.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Massimo Dal Zotto <dz@debian.org>
> ---
> Note: I don't get why CONFIG_I8K is the "Processor type and features"
> menu, and why the driver lives in drivers/char. Wouldn't
> drivers/arch/x86 be a better place?
> 
>  arch/x86/Kconfig   |    1 
>  drivers/char/i8k.c |  148 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 149 insertions(+)
> 
> --- linux-2.6.39-rc3.orig/drivers/char/i8k.c	2011-03-15 19:45:31.000000000 +0100
> +++ linux-2.6.39-rc3/drivers/char/i8k.c	2011-04-13 16:51:33.000000000 +0200
> @@ -5,6 +5,9 @@
>   *
>   * Copyright (C) 2001  Massimo Dal Zotto <dz@debian.org>
>   *
> + * Hwmon integration:
> + * Copyright (C) 2011  Jean Delvare <khali@linux-fr.org>
> + *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
>   * Free Software Foundation; either version 2, or (at your option) any
> @@ -24,6 +27,8 @@
>  #include <linux/dmi.h>
>  #include <linux/capability.h>
>  #include <linux/mutex.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  
> @@ -58,6 +63,7 @@
>  
>  static DEFINE_MUTEX(i8k_mutex);
>  static char bios_version[4];
> +static struct device *i8k_hwmon_dev;
>  
>  MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
>  MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
> @@ -455,6 +461,142 @@ static int i8k_open_fs(struct inode *ino
>  	return single_open(file, i8k_proc_show, NULL);
>  }
>  
> +
> +/*
> + * Hwmon interface
> + */
> +
> +static ssize_t i8k_hwmon_show_temp(struct device *dev,
> +				   struct device_attribute *devattr,
> +				   char *buf)
> +{
> +	int cpu_temp;
> +
> +	cpu_temp = i8k_get_temp(0);
> +	return sprintf(buf, "%d\n", cpu_temp * 1000);
> +}
> +
> +static ssize_t i8k_hwmon_show_fan(struct device *dev,
> +				  struct device_attribute *devattr,
> +				  char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	int fan_speed;
> +
> +	fan_speed = i8k_get_fan_speed(index);
> +	return sprintf(buf, "%d\n", fan_speed);
> +}
> +
> +static ssize_t i8k_hwmon_show_label(struct device *dev,
> +				    struct device_attribute *devattr,
> +				    char *buf)
> +{
> +	static const char *labels[4] = {
> +		"i8k",
> +		"CPU",
> +		"Left Fan",
> +		"Right Fan",
> +	};
> +	int index = to_sensor_dev_attr(devattr)->index;
> +
> +	return sprintf(buf, "%s\n", labels[index]);
> +}
> +
> +static DEVICE_ATTR(temp1_input, S_IRUGO, i8k_hwmon_show_temp, NULL);
> +static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, i8k_hwmon_show_fan, NULL,
> +			  I8K_FAN_LEFT);
> +static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, i8k_hwmon_show_fan, NULL,
> +			  I8K_FAN_RIGHT);
> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, i8k_hwmon_show_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, i8k_hwmon_show_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, i8k_hwmon_show_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(fan2_label, S_IRUGO, i8k_hwmon_show_label, NULL, 3);
> +
> +static void i8k_hwmon_remove_files(struct device *dev)
> +{
> +	device_remove_file(dev, &dev_attr_temp1_input);
> +	device_remove_file(dev, &sensor_dev_attr_fan1_input.dev_attr);
> +	device_remove_file(dev, &sensor_dev_attr_fan2_input.dev_attr);
> +	device_remove_file(dev, &sensor_dev_attr_temp1_label.dev_attr);
> +	device_remove_file(dev, &sensor_dev_attr_fan1_label.dev_attr);
> +	device_remove_file(dev, &sensor_dev_attr_fan2_label.dev_attr);
> +	device_remove_file(dev, &sensor_dev_attr_name.dev_attr);
> +}
> +
> +static int __init i8k_init_hwmon(void)
> +{
> +	int err;
> +
> +	i8k_hwmon_dev = hwmon_device_register(NULL);
> +	if (IS_ERR(i8k_hwmon_dev)) {
> +		err = PTR_ERR(i8k_hwmon_dev);
> +		i8k_hwmon_dev = NULL;
> +		printk(KERN_ERR "i8k: hwmon registration failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	/* Required name attribute */
> +	err = device_create_file(i8k_hwmon_dev,
> +				 &sensor_dev_attr_name.dev_attr);
> +	if (err)
> +		goto exit_unregister;
> +
> +	/* CPU temperature attributes */
> +	err = device_create_file(i8k_hwmon_dev, &dev_attr_temp1_input);
> +	if (err)
> +		goto exit_remove_files;
> +	err = device_create_file(i8k_hwmon_dev,
> +				 &sensor_dev_attr_temp1_label.dev_attr);
> +	if (err)
> +		goto exit_remove_files;
> +
> +	/* Left fan attributes, if left fan is present */
> +	err = i8k_get_fan_status(I8K_FAN_LEFT);
> +	if (err < 0) {
> +		dev_dbg(i8k_hwmon_dev,
> +			"Not creating %s fan attributes (%d)\n", "left", err);
> +	} else {
> +		err = device_create_file(i8k_hwmon_dev,
> +					 &sensor_dev_attr_fan1_input.dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +		err = device_create_file(i8k_hwmon_dev,
> +					 &sensor_dev_attr_fan1_label.dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +	}
> +
> +	/* Right fan attributes, if right fan is present */
> +	err = i8k_get_fan_status(I8K_FAN_RIGHT);
> +	if (err < 0) {
> +		dev_dbg(i8k_hwmon_dev,
> +			"Not creating %s fan attributes (%d)\n", "right", err);
> +	} else {
> +		err = device_create_file(i8k_hwmon_dev,
> +					 &sensor_dev_attr_fan2_input.dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +		err = device_create_file(i8k_hwmon_dev,
> +					 &sensor_dev_attr_fan2_label.dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +	}
> +
> +	return 0;
> +
> + exit_remove_files:
> +	i8k_hwmon_remove_files(i8k_hwmon_dev);
> + exit_unregister:
> +	hwmon_device_unregister(i8k_hwmon_dev);
> +	return err;
> +}
> +
> +static void __exit i8k_exit_hwmon(void)
> +{
> +	i8k_hwmon_remove_files(i8k_hwmon_dev);
> +	hwmon_device_unregister(i8k_hwmon_dev);
> +}
> +
>  static struct dmi_system_id __initdata i8k_dmi_table[] = {
>  	{
>  		.ident = "Dell Inspiron",
> @@ -590,6 +732,11 @@ static int __init i8k_init(void)
>  	if (!proc_i8k)
>  		return -ENOENT;
>  
> +	if (i8k_init_hwmon()) {
> +		remove_proc_entry("i8k", NULL);
> +		return -ENODEV;
> +	}
> +
Should that be something like
	err = i8k_init_hwmon();
	if (err)
		goto remove_proc;

	...

remove_proc:
	remove_proc_entry("i8k", NULL);
	return err;

>  	printk(KERN_INFO
>  	       "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
>  	       I8K_VERSION);
> @@ -599,6 +746,7 @@ static int __init i8k_init(void)
>  
>  static void __exit i8k_exit(void)
>  {
> +	i8k_exit_hwmon();
>  	remove_proc_entry("i8k", NULL);
>  }
>  
> --- linux-2.6.39-rc3.orig/arch/x86/Kconfig	2011-03-30 10:57:16.000000000 +0200
> +++ linux-2.6.39-rc3/arch/x86/Kconfig	2011-04-13 17:10:16.000000000 +0200
> @@ -919,6 +919,7 @@ config TOSHIBA
>  
>  config I8K
>  	tristate "Dell laptop support"
> +	select HWMON
>  	---help---
>  	  This adds a driver to safely access the System Management Mode
>  	  of the CPU on the Dell Inspiron 8000. The System Management Mode
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
