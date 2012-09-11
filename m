From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Sep 2012 07:56:40 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (max1111) Add support for MAX1110, MAX1112, and MAX1113
Message-Id: <20120911095640.2f2865da@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347336566-32662-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347336566-32662-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 10 Sep 2012 21:09:24 -0700, Guenter Roeck wrote:
> MAX1110 is similar to MAX1111, with 8 instead of 4 channels. MAX1112 and MAX1113
> are similar to MAX1110 and MAX1111, with 4.096V reference voltage instead of
> 2.048V.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/Kconfig   |    5 +--
>  drivers/hwmon/max1111.c |   83 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 79 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8343cad..148903c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -770,10 +770,11 @@ config SENSORS_LM95245
>  	  will be called lm95245.
>  
>  config SENSORS_MAX1111
> -	tristate "Maxim MAX1111 Multichannel, Serial 8-bit ADC chip"
> +	tristate "Maxim MAX1111 Serial 8-bit ADC chip and compatibles"
>  	depends on SPI_MASTER
>  	help
> -	  Say y here to support Maxim's MAX1111 ADC chips.
> +	  Say y here to support Maxim's MAX1111, MAX1112, MAX1112, and MAX1113
> +	  ADC chips.

MAX1112 is listed twice, MAX1110 isn't listed at all.

>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called max1111.
> diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
> index f3978a4..5bf081d 100644
> --- a/drivers/hwmon/max1111.c
> +++ b/drivers/hwmon/max1111.c
> @@ -22,6 +22,8 @@
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  
> +enum chips { max1110, max1111, max1112, max1113 };
> +
>  #define MAX1111_TX_BUF_SIZE	1
>  #define MAX1111_RX_BUF_SIZE	2
>  
> @@ -30,10 +32,12 @@
>  #define MAX1111_CTRL_PD1      (1u << 1)
>  #define MAX1111_CTRL_SGL      (1u << 2)
>  #define MAX1111_CTRL_UNI      (1u << 3)
> +#define MAX1110_CTRL_SEL_SH   (4)
>  #define MAX1111_CTRL_SEL_SH   (5)	/* NOTE: bit 4 is ignored */
>  #define MAX1111_CTRL_STR      (1u << 7)
>  
>  struct max1111_data {
> +	const char		*name;
>  	struct spi_device	*spi;
>  	struct device		*hwmon_dev;
>  	struct spi_message	msg;
> @@ -42,6 +46,9 @@ struct max1111_data {
>  	uint8_t rx_buf[MAX1111_RX_BUF_SIZE];
>  	struct mutex		drvdata_lock;
>  	/* protect msg, xfer and buffers from multiple access */
> +	int			sel_sh;
> +	int			lsb;
> +	enum chips		chip;
>  };
>  
>  static int max1111_read(struct device *dev, int channel)
> @@ -53,7 +60,7 @@ static int max1111_read(struct device *dev, int channel)
>  	/* writing to drvdata struct is not thread safe, wait on mutex */
>  	mutex_lock(&data->drvdata_lock);
>  
> -	data->tx_buf[0] = (channel << MAX1111_CTRL_SEL_SH) |
> +	data->tx_buf[0] = (channel << data->sel_sh) |
>  		MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
>  		MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
>  
> @@ -93,12 +100,15 @@ EXPORT_SYMBOL(max1111_read_channel);
>  static ssize_t show_name(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "max1111\n");
> +	struct max1111_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);

Can't you use dev_name(dev) instead?

>  }
>  
>  static ssize_t show_adc(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
> +	struct max1111_data *data = dev_get_drvdata(dev);
>  	int channel = to_sensor_dev_attr(attr)->index;
>  	int ret;
>  
> @@ -107,10 +117,10 @@ static ssize_t show_adc(struct device *dev,
>  		return ret;
>  
>  	/*
> -	 * assume the reference voltage to be 2.048V, with an 8-bit sample,
> -	 * the LSB weight is 8mV
> +	 * Assume the reference voltage to be 2.048V or 4.096V, with an 8-bit
> +	 * sample. The LSB weight is 8mV or 16mV depending on the chip type.
>  	 */
> -	return sprintf(buf, "%d\n", ret * 8);
> +	return sprintf(buf, "%d\n", ret * data->lsb);
>  }
>  
>  #define MAX1111_ADC_ATTR(_id)		\
> @@ -121,6 +131,10 @@ static MAX1111_ADC_ATTR(0);
>  static MAX1111_ADC_ATTR(1);
>  static MAX1111_ADC_ATTR(2);
>  static MAX1111_ADC_ATTR(3);
> +static MAX1111_ADC_ATTR(4);
> +static MAX1111_ADC_ATTR(5);
> +static MAX1111_ADC_ATTR(6);
> +static MAX1111_ADC_ATTR(7);
>  
>  static struct attribute *max1111_attributes[] = {
>  	&dev_attr_name.attr,
> @@ -135,6 +149,18 @@ static const struct attribute_group max1111_attr_group = {
>  	.attrs	= max1111_attributes,
>  };
>  
> +static struct attribute *max1110_attributes[] = {
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max1110_attr_group = {
> +	.attrs	= max1110_attributes,
> +};
> +
>  static int __devinit setup_transfer(struct max1111_data *data)
>  {
>  	struct spi_message *m;
> @@ -159,6 +185,7 @@ static int __devinit setup_transfer(struct max1111_data *data)
>  
>  static int __devinit max1111_probe(struct spi_device *spi)
>  {
> +	enum chips chip = spi_get_device_id(spi)->driver_data;
>  	struct max1111_data *data;
>  	int err;
>  
> @@ -174,6 +201,29 @@ static int __devinit max1111_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	}
>  
> +	data->chip = chip;

You never use this value.

> +	switch (chip) {
> +	case max1110:
> +		data->name = "mmax1110";

Typo: duplicate "m".

> +		data->lsb = 8;
> +		data->sel_sh = MAX1110_CTRL_SEL_SH;
> +		break;
> +	case max1111:
> +		data->name = "max1111";
> +		data->lsb = 8;
> +		data->sel_sh = MAX1111_CTRL_SEL_SH;
> +		break;
> +	case max1112:
> +		data->name = "max1112";
> +		data->lsb = 16;
> +		data->sel_sh = MAX1110_CTRL_SEL_SH;
> +		break;
> +	case max1113:
> +		data->name = "max1113";
> +		data->lsb = 16;
> +		data->sel_sh = MAX1111_CTRL_SEL_SH;
> +		break;
> +	}
>  	err = setup_transfer(data);
>  	if (err)
>  		return err;
> @@ -188,6 +238,13 @@ static int __devinit max1111_probe(struct spi_device *spi)
>  		dev_err(&spi->dev, "failed to create attribute group\n");
>  		return err;
>  	}
> +	if (chip = max1110 || chip = max1112) {
> +		err = sysfs_create_group(&spi->dev.kobj, &max1110_attr_group);
> +		if (err) {
> +			dev_err(&spi->dev, "failed to create attribute group\n");

This is the exact same error message as above. Different error messages
would make debugging easier on problem report. (Not that I really
expect this specific error to ever happen, this is more of a general
piece of advice.)

> +			goto err_remove1;
> +		}
> +	}
>  
>  	data->hwmon_dev = hwmon_device_register(&spi->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
> @@ -202,6 +259,8 @@ static int __devinit max1111_probe(struct spi_device *spi)
>  	return 0;
>  
>  err_remove:
> +	sysfs_remove_group(&spi->dev.kobj, &max1110_attr_group);
> +err_remove1:

Don't bother. It's OK to remove files which do not exist, so almost all
drivers have a single jump label removing all files.

>  	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
>  	return err;
>  }
> @@ -211,16 +270,27 @@ static int __devexit max1111_remove(struct spi_device *spi)
>  	struct max1111_data *data = spi_get_drvdata(spi);
>  
>  	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&spi->dev.kobj, &max1110_attr_group);
>  	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
>  	mutex_destroy(&data->drvdata_lock);
>  	return 0;
>  }
>  
> +static const struct spi_device_id max1111_ids[] = {
> +	{ "max1110", max1110 },
> +	{ "max1111", max1111 },
> +	{ "max1112", max1112 },
> +	{ "max1113", max1113 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, max1111_ids);
> +
>  static struct spi_driver max1111_driver = {
>  	.driver		= {
>  		.name	= "max1111",
>  		.owner	= THIS_MODULE,
>  	},
> +	.id_table	= max1111_ids,
>  	.probe		= max1111_probe,
>  	.remove		= __devexit_p(max1111_remove),
>  };
> @@ -228,6 +298,5 @@ static struct spi_driver max1111_driver = {
>  module_spi_driver(max1111_driver);
>  
>  MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
> -MODULE_DESCRIPTION("MAX1111 ADC Driver");
> +MODULE_DESCRIPTION("MAX1110/MAX1111/MAX1112/MAX1113 ADC Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("spi:max1111");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
