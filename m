From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Sep 2008 11:02:44 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: add max1111/max1110 Low-power
Message-Id: <20080921130244.212b217f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
In-Reply-To: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

Sorry for the late answer.

On Wed, 3 Sep 2008 14:12:26 +0800, Eric Miao wrote:
> Driver based on corgi_ssp.c and sharpsl_pm.c, previously done by Richard
> Purdie and many others.
> 
> Now changed to generic HWMON device and expose all the ADC input value
> through sysfs.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> ---
> 
> Updated and incorporated most feedback. Jean, could you please take a
> look and Ack, or let me know know who's the right guy to ack this, thanks.

Code looks reasonable, so you get my:

Acked-by: Jean Delvare <khali@linux-fr.org>

However, please read my few suggestions below to make the driver even
better.

> 
>  drivers/hwmon/Kconfig   |    9 ++
>  drivers/hwmon/Makefile  |    1 +
>  drivers/hwmon/max1111.c |  235 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 245 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/max1111.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index d402e8d..3309e86 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -540,6 +540,15 @@ config SENSORS_LM93
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm93.
> 
> +config SENSORS_MAX1111
> +	tristate "Maxim MAX1111 Multichannel, Serial 8-bit ADC chip"
> +	depends on SPI_MASTER
> +	help
> +	  Say y here to support Maxim's MAX1111 ADC chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max1111.
> +
>  config SENSORS_MAX1619
>  	tristate "Maxim MAX1619 sensor chip"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 950134a..6babc80 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
>  obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
>  obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
>  obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
> +obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
>  obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
>  obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
> diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
> new file mode 100644
> index 0000000..5a974f8
> --- /dev/null
> +++ b/drivers/hwmon/max1111.c
> @@ -0,0 +1,235 @@
> +/*
> + * max1111.c - +2.7V, Low-Power, Multichannel, Serial 8-bit ADCs
> + *
> + * Based on arch/arm/mach-pxa/corgi_ssp.c
> + *
> + * Copyright (C) 2004-2005 Richard Purdie
> + *
> + * Copyright (C) 2008 Marvell International Ltd.
> + * 	Eric Miao <eric.miao@marvell.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publishhed by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/spi/spi.h>
> +
> +#define MAX1111_TX_BUF_SIZE	(1)
> +#define MAX1111_RX_BUF_SIZE	(2)

Note that parentheses aren't needed here.

> +
> +/* MAX1111 Commands */
> +#define MAX1111_CTRL_PD0      (1u << 0)
> +#define MAX1111_CTRL_PD1      (1u << 1)
> +#define MAX1111_CTRL_SGL      (1u << 2)
> +#define MAX1111_CTRL_UNI      (1u << 3)
> +#define MAX1111_CTRL_SEL_SH   (4)
> +#define MAX1111_CTRL_STR      (1u << 7)
> +
> +static ssize_t show_adc(struct device *, struct device_attribute *, char *);
> +static ssize_t show_name(struct device *, struct device_attribute *, char *);

You could easily get rid of these forward declarations by moving the
attribute declarations below after the functions themselves.

> +static int max1111_read(struct device *, int);
> +
> +#define MAX1111_ADC_ATTR(_id)		\
> +	SENSOR_DEVICE_ATTR(adc##_id##_in, S_IRUGO, show_adc, NULL, _id)
> +
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +static MAX1111_ADC_ATTR(0);
> +static MAX1111_ADC_ATTR(1);
> +static MAX1111_ADC_ATTR(2);
> +static MAX1111_ADC_ATTR(3);
> +
> +static struct attribute *max1111_attributes[] = {
> +	&dev_attr_name.attr,
> +	&sensor_dev_attr_adc0_in.dev_attr.attr,
> +	&sensor_dev_attr_adc1_in.dev_attr.attr,
> +	&sensor_dev_attr_adc2_in.dev_attr.attr,
> +	&sensor_dev_attr_adc3_in.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max1111_attr_group = {
> +	.attrs	= max1111_attributes,
> +};
> +
> +/*
> + * NOTE: SPI devices do not have a default 'name' attribute, which is
> + * likely to be used by hwmon applications to distinguish between
> + * different devices, explicitly add a name attribute here.
> + */
> +static ssize_t show_name(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "max1111\n");
> +}
> +
> +static ssize_t show_adc(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	int channel = to_sensor_dev_attr(attr)->index;
> +	int ret;
> +
> +	ret = max1111_read(dev, channel);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret);
> +}
> +
> +struct max1111_data {
> +	struct spi_device	*spi;
> +	struct device		*hwmon_dev;
> +	struct spi_message	msg;
> +	struct spi_transfer	xfer[2];
> +	uint8_t *tx_buf;
> +	uint8_t *rx_buf;
> +};
> +
> +static int max1111_read(struct device *dev, int channel)
> +{
> +	struct max1111_data *data = dev_get_drvdata(dev);
> +	uint8_t v1, v2;
> +	int err;
> +
> +	data->tx_buf[0] = (channel << MAX1111_CTRL_SEL_SH) |
> +		MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
> +		MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
> +
> +	err = spi_sync(data->spi, &data->msg);
> +	if (err < 0) {
> +		dev_err(dev, "spi_sync failed with %d\n", err);
> +		return err;
> +	}
> +
> +	v1 = data->rx_buf[0];
> +	v2 = data->rx_buf[1];
> +
> +	if ((v1 & 0xc0) || (v2 & 0x3f))
> +		return -EINVAL;
> +
> +	return ((v1 << 2) & 0xfc) | ((v2 >> 6) & 0x03);

The masking is not needed: you have explicitly checked right above that
the bits you're masking out are 0s.

> +}
> +
> +static int setup_transfer(struct max1111_data *data)
> +{
> +	struct spi_message *m;
> +	struct spi_transfer *x;
> +
> +	data->tx_buf = kmalloc(MAX1111_TX_BUF_SIZE, GFP_KERNEL);
> +	if (!data->tx_buf)
> +		return -ENOMEM;
> +
> +	data->rx_buf = kmalloc(MAX1111_RX_BUF_SIZE, GFP_KERNEL);
> +	if (!data->rx_buf) {
> +		kfree(data->tx_buf);
> +		return -ENOMEM;
> +	}

Allocating such small buffers using kmalloc seems pretty inefficient.
At the very least, I would allocate both buffers at once. But quite
frankly I don't get why you don't just make these buffers part of
struct max1111_data. This would even make the structure smaller!

> +
> +	m = &data->msg;
> +	x = &data->xfer[0];
> +
> +	spi_message_init(m);
> +
> +	x->tx_buf = &data->tx_buf[0];
> +	x->len = 1;
> +	spi_message_add_tail(x, m);
> +
> +	x++;
> +	x->rx_buf = &data->rx_buf[0];
> +	x->len = 2;
> +	spi_message_add_tail(x, m);
> +
> +	return 0;
> +}
> +
> +static int __devinit max1111_probe(struct spi_device *spi)
> +{
> +	struct max1111_data *data;
> +	int err;
> +
> +	spi->bits_per_word = 8;
> +	spi->mode = SPI_MODE_0;
> +	err = spi_setup(spi);
> +	if (err < 0)
> +		return err;
> +
> +	data = kzalloc(sizeof(struct max1111_data), GFP_KERNEL);
> +	if (data = NULL) {
> +		dev_err(&spi->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	err = setup_transfer(data);
> +	if (err)
> +		goto err_free_data;
> +
> +	data->spi = spi;
> +	spi_set_drvdata(spi, data);
> +
> +	err = sysfs_create_group(&spi->dev.kobj, &max1111_attr_group);
> +	if (err) {
> +		dev_err(&spi->dev, "failed to create attribute group\n");
> +		goto err_free_all;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(&spi->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		dev_err(&spi->dev, "failed to create hwmon device\n");
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto err_remove;
> +	}
> +
> +	return 0;
> +
> +err_remove:
> +	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
> +err_free_all:
> +	kfree(data->rx_buf);
> +	kfree(data->tx_buf);
> +err_free_data:
> +	kfree(data);
> +	return err;
> +}
> +
> +static int __devexit max1111_remove(struct spi_device *spi)
> +{
> +	struct max1111_data *data = spi_get_drvdata(spi);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
> +	kfree(data->rx_buf);
> +	kfree(data->tx_buf);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct spi_driver max1111_driver = {
> +	.driver		= {
> +		.name	= "max1111",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= max1111_probe,
> +	.remove		= __devexit_p(max1111_remove),
> +};
> +
> +static int __init max1111_init(void)
> +{
> +	return spi_register_driver(&max1111_driver);
> +}
> +module_init(max1111_init);
> +
> +static void __exit max1111_exit(void)
> +{
> +	spi_unregister_driver(&max1111_driver);
> +}
> +module_exit(max1111_exit);
> +
> +MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
> +MODULE_DESCRIPTION("MAX1111 ADC Driver");
> +MODULE_LICENSE("GPL");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
