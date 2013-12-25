From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Dec 2013 10:37:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20131225103723.GA18256@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1387923847-1294-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Tue, Dec 24, 2013 at 11:24:04PM +0100, Hans de Goede wrote:
> The sun4i resisitive touchscreen controller also comes with a built-in
> temperature sensor. This commit adds support for it.
> 
> This commit also introduces a new "ts-attached" device-tree attribute,
> when this is not set, the input part of the driver won't register. This way
> the internal temperature sensor can be used to measure the SoC temperature
> independent of there actually being a touchscreen attached to the controller.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans,

can you use the new hwmon_device_register_with_groups API instead,
or even devm_hwmon_device_register_with_groups ?

This way you don't have to create and remove the sysfs group, you don't have to
create the name attribute, and if you use the devm_ API you don't have to remove
anything. Also, the hwmon attributes will be attached to the hwmon device,
meaning the platform device won't be cluttered with hwmon attributes and
vice versa.

Couple of related comments inline below.

Thanks,
Guenter

> ---
>  drivers/input/touchscreen/sun4i-ts.c | 106 +++++++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index b3f01c0..15a486d 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (C) 2013 - 2014 Hans de Goede <hdegoede@redhat.com>
>   *
> + * The hwmon parts are based on work by Corentin LABBE which is:
> + * Copyright (C) 2013 Corentin LABBE <clabbe.montjoie@gmail.com>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -31,6 +34,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/hwmon.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> @@ -97,10 +101,16 @@
>  #define TP_UP_PENDING		(1 << 1)
>  #define TP_DOWN_PENDING		(1 << 0)
>  
> +/* TP_TPR bits */
> +#define TEMP_ENABLE(x)		((x) << 16)
> +#define TEMP_PERIOD(x)		((x) << 0)  /* t = x * 256 * 16 / clkin */
> +
>  struct sun4i_ts_data {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct input_dev *input;
> +	struct device *hwmon;
> +	atomic_t temp_data;

Unless I am missing something, this variable does not have to be an atomic.
Either it was written or it wasn't, but the order should not matter.

>  	int ignore_fifo_data;
>  };
>  
> @@ -111,6 +121,12 @@ static irqreturn_t sun4i_ts_irq(int irq, void *dev_id)
>  
>  	reg_val  = readl(ts->base + TP_INT_FIFOS);
>  
> +	if (reg_val & TEMP_DATA_PENDING)
> +		atomic_set(&ts->temp_data, readl(ts->base + TEMP_DATA));
> +
> +	if (!ts->input)
> +		goto leave;
> +
>  	if (reg_val & FIFO_DATA_PENDING) {
>  		x = readl(ts->base + TP_DATA);
>  		y = readl(ts->base + TP_DATA);
> @@ -135,6 +151,7 @@ static irqreturn_t sun4i_ts_irq(int irq, void *dev_id)
>  		input_sync(ts->input);
>  	}
>  
> +leave:
>  	writel(reg_val, ts->base + TP_INT_FIFOS);
>  
>  	return IRQ_HANDLED;
> @@ -170,6 +187,66 @@ static int sun4i_ts_register_input(struct sun4i_ts_data *ts,
>  	return 0;
>  }
>  
> +static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	return sprintf(buf, "sun4i_ts\n");
> +}
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	struct sun4i_ts_data *ts = dev_get_drvdata(dev);
> +	int temp_data;
> +
> +	temp_data = atomic_read(&ts->temp_data);
> +	/* No temp_data until the first irq */
> +	if (temp_data = -1)
> +		return -EAGAIN;
> +
> +	return sprintf(buf, "%d\n", (temp_data - 1447) * 100);
> +}
> +
> +static ssize_t show_temp_label(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	return sprintf(buf, "SoC temperature\n");
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
> +static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);
> +
> +static struct attribute *sun4i_ts_attributes[] = {
> +	&dev_attr_name.attr,
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_label.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sun4i_ts_attr_group = {
> +	.attrs = sun4i_ts_attributes,
> +};

If you rename the attributes to sun4i_ts_attrs, you should be able to use
ATTRIBUTE_GROUPS() here (this gives you a list of groups which you'll need
if you use the new API).

> +
> +static int sun4i_ts_register_hwmon(struct sun4i_ts_data *ts)
> +{
> +	int ret;
> +
> +	atomic_set(&ts->temp_data, -1);
> +
> +	ret = sysfs_create_group(&ts->dev->kobj, &sun4i_ts_attr_group);
> +	if (ret)
> +		return ret;
> +
> +	ts->hwmon = hwmon_device_register(ts->dev);
> +	if (IS_ERR(ts->hwmon)) {
> +		ret = PTR_ERR(ts->hwmon);
> +		ts->hwmon = NULL;
> +	}
> +
> +	return ret;

With the new API, this would be something like

	hwmon_dev = devm_hwmon_device_register_with_groups(ts->dev, "sun4i_ts",
							   ts, sun4i_ts_attrs);
	return PTR_ERR_OR_ZERO(hwmon_dev);

With the devm_ API, you don't have to store the hwmon device as you don't need
to access it anymore from within the driver. Note that you can only use it if
you also use devm_kzalloc to allocate ts; otherwise you would have a race condition
during cleanup.

> +}
> +
>  static int sun4i_ts_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_ts_data *ts = platform_get_drvdata(pdev);
> @@ -178,9 +255,13 @@ static int sun4i_ts_remove(struct platform_device *pdev)
>  	writel(0, ts->base + TP_INT_FIFOC);
>  	msleep(20);
>  
> +	if (ts->hwmon)
> +		hwmon_device_unregister(ts->hwmon);
> +
>  	if (ts->input)
>  		input_unregister_device(ts->input);
>  
> +	sysfs_remove_group(&ts->dev->kobj, &sun4i_ts_attr_group);
>  	kfree(ts);
>  
>  	return 0;
> @@ -189,7 +270,11 @@ static int sun4i_ts_remove(struct platform_device *pdev)
>  static int sun4i_ts_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_ts_data *ts;
> +	struct device_node *np = pdev->dev.of_node;
>  	int ret = -ENOMEM;
> +	u32 ts_attached = 0;
> +
> +	of_property_read_u32(np, "ts-attached", &ts_attached);
>  
>  	ts = kzalloc(sizeof(struct sun4i_ts_data), GFP_KERNEL);

Different patch, but why not just use devm_kzalloc() ? Since you are using devm_
functions elsewhere, that would seem natural. I'll also comment on that in the
other patch.

>  	if (!ts)
> @@ -210,7 +295,13 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error;
>  
> -	ret = sun4i_ts_register_input(ts, pdev->name);
> +	if (ts_attached) {
> +		ret = sun4i_ts_register_input(ts, pdev->name);
> +		if (ret)
> +			goto error;
> +	}
> +
> +	ret = sun4i_ts_register_hwmon(ts);
>  	if (ret)
>  		goto error;
>  
> @@ -231,9 +322,16 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	/* Enable median filter, type 1 : 5/3 */
>  	writel(FILTER_EN(1) | FILTER_TYPE(1), ts->base + TP_CTRL3);
>  
> -	/* Flush fifo, set trig level to 1, enable data and pen up irqs */
> -	writel(DATA_IRQ_EN(1) | FIFO_TRIG(1) | FIFO_FLUSH(1) | TP_UP_IRQ_EN(1),
> -	       ts->base + TP_INT_FIFOC);
> +	if (ts_attached) {
> +		/* Flush, set trig level to 1, enable temp, data and up irqs */
> +		writel(TEMP_IRQ_EN(1) | DATA_IRQ_EN(1) | FIFO_TRIG(1) |
> +			FIFO_FLUSH(1) | TP_UP_IRQ_EN(1),
> +		       ts->base + TP_INT_FIFOC);
> +	} else
> +		writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> +
> +	/* Enable temperature measurement, period 1953 (2 seconds) */
> +	writel(TEMP_ENABLE(1) | TEMP_PERIOD(1953), ts->base + TP_TPR);
>  
>  	/*
>  	 * Set stylus up debounce to aprox 10 ms, enable debounce, and
> -- 
> 1.8.4.2
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
