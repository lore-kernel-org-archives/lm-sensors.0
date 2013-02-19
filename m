From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 01:39:33 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (adt7x10) Add alarm interrupt support
Message-Id: <20130219013933.GD25124@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <1361194739-16525-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1361194739-16525-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Mon, Feb 18, 2013 at 02:38:58PM +0100, Lars-Peter Clausen wrote:
> This allows a userspace application to poll() on the alarm files to get notified
> in case of an temperature threshold event.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Changes since v1:
> 	* Switch from level triggered and interrupt mode to edge triggered and
> 	  comparator mode. In interrupt mode the status register get's cleared after
> 	  the first read and so the _alarm files will always read 0, which is not
> 	  really what we want.
> 	* Use dev_name(dev) for the interrupt name, instead of 'name' which will be
> 	  NULL for I2C devices
> ---
>  drivers/hwmon/adt7310.c |  4 ++--
>  drivers/hwmon/adt7410.c |  4 ++--
>  drivers/hwmon/adt7x10.c | 43 +++++++++++++++++++++++++++++++++++++++----
>  drivers/hwmon/adt7x10.h |  4 ++--
>  4 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
> index 2196ac3..e58bb68 100644
> --- a/drivers/hwmon/adt7310.c
> +++ b/drivers/hwmon/adt7310.c
> @@ -82,13 +82,13 @@ static const struct adt7410_ops adt7310_spi_ops = {
>  
>  static int adt7310_spi_probe(struct spi_device *spi)
>  {
> -	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name,
> +	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name, spi->irq,
>  			&adt7310_spi_ops);
>  }
>  
>  static int adt7310_spi_remove(struct spi_device *spi)
>  {
> -	return adt7410_remove(&spi->dev);
> +	return adt7410_remove(&spi->dev, spi->irq);
>  }
>  
>  static const struct spi_device_id adt7310_id[] = {
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index b500ab3..3a7d905 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -48,12 +48,12 @@ static int adt7410_i2c_probe(struct i2c_client *client,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
>  
> -	return adt7410_probe(&client->dev, NULL, &adt7410_i2c_ops);
> +	return adt7410_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
>  }
>  
>  static int adt7410_i2c_remove(struct i2c_client *client)
>  {
> -	return adt7410_remove(&client->dev);
> +	return adt7410_remove(&client->dev, client->irq);
>  }
>  
>  static const struct i2c_device_id adt7410_ids[] = {
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index eeff198c..2340a70 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -30,6 +30,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  
>  #include "adt7x10.h"
>  
> @@ -112,6 +113,25 @@ static const u8 ADT7410_REG_TEMP[4] = {
>  	ADT7410_T_CRIT,			/* critical */
>  };
>  
> +static irqreturn_t adt7410_irq_handler(int irq, void *private)
> +{
> +	struct device *dev = private;
> +	int status;
> +
> +	status = adt7410_read_byte(dev, ADT7410_STATUS);
> +	if (status < 0)
> +		return IRQ_HANDLED;
> +
> +	if (status & ADT7410_STAT_T_HIGH)
> +		sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
> +	if (status & ADT7410_STAT_T_LOW)
> +		sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
> +	if (status & ADT7410_STAT_T_CRIT)
> +		sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");
> +
Question about semantics: Do you want a notification on all attributes each time
one is set during an interrupt, or do you want a notification each time an
attribute changes state ? With the above code, the 1->0 transition does not
result in a notification. Is that on purpose ?

> +	return IRQ_HANDLED;
> +}
> +
>  static int adt7410_temp_ready(struct device *dev)
>  {
>  	int i, status;
> @@ -357,7 +377,7 @@ static const struct attribute_group adt7410_group = {
>  	.attrs = adt7410_attributes,
>  };
>  
> -int adt7410_probe(struct device *dev, const char *name,
> +int adt7410_probe(struct device *dev, const char *name, int irq,
>  	const struct adt7410_ops *ops)
>  {
>  	struct adt7410_data *data;
> @@ -383,11 +403,13 @@ int adt7410_probe(struct device *dev, const char *name,
>  	data->oldconfig = ret;
>  
>  	/*
> -	 * Set to 16 bit resolution, continous conversion and comparator mode.
> +	 * Set to 16 bit resolution and continous conversion
>  	 */
>  	data->config = data->oldconfig;
> -	data->config &= ~ADT7410_MODE_MASK;
> +	data->config &= ~(ADT7410_MODE_MASK | ADT7410_CT_POLARITY |
> +			ADT7410_INT_POLARITY);
>  	data->config |= ADT7410_FULL | ADT7410_RESOLUTION | ADT7410_EVENT_MODE;
> +
>  	if (data->config != data->oldconfig) {
>  		ret = adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
>  		if (ret)
> @@ -421,8 +443,18 @@ int adt7410_probe(struct device *dev, const char *name,
>  		goto exit_remove_name;
>  	}
>  
> +	if (irq > 0) {
> +		ret = request_threaded_irq(irq, NULL, adt7410_irq_handler,
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				dev_name(dev), dev);

If you use devm_request_threaded_irq, you don't have to release it on remove.

> +		if (ret)
> +			goto exit_hwmon_device_unregister;
> +	}
> +

This code should be before hwmon registration.

>  	return 0;
>  
> +exit_hwmon_device_unregister:
> +	hwmon_device_unregister(data->hwmon_dev);
>  exit_remove_name:
>  	if (name)
>  		device_remove_file(dev, &dev_attr_name);
> @@ -434,10 +466,13 @@ exit_restore:
>  }
>  EXPORT_SYMBOL_GPL(adt7410_probe);
>  
> -int adt7410_remove(struct device *dev)
> +int adt7410_remove(struct device *dev, int irq)
>  {
>  	struct adt7410_data *data = dev_get_drvdata(dev);
>  
> +	if (irq > 0)
> +		free_irq(irq, dev);
> +
>  	hwmon_device_unregister(data->hwmon_dev);
>  	if (data->name)
>  		device_remove_file(dev, &dev_attr_name);
> diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
> index a7165e6..d67badf 100644
> --- a/drivers/hwmon/adt7x10.h
> +++ b/drivers/hwmon/adt7x10.h
> @@ -33,9 +33,9 @@ struct adt7410_ops {
>  	int (*write_word)(struct device *, u8 reg, u16 data);
>  };
>  
> -int adt7410_probe(struct device *dev, const char *name,
> +int adt7410_probe(struct device *dev, const char *name, int irq,
>  	const struct adt7410_ops *ops);
> -int adt7410_remove(struct device *dev);
> +int adt7410_remove(struct device *dev, int irq);
>  
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 1.8.0
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
