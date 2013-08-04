From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 04 Aug 2013 09:42:48 +0000
Subject: Re: [lm-sensors] [PATCH] iio: Add tmp006 IR temperature sensor
Message-Id: <51FE2F54.4050104@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375136888-19978-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375136888-19978-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>

On 07/29/13 23:28, Peter Meerwald wrote:
> the TI TMP006 is a non-contact temperature sensor with I2C interface;
> it measures the surface temperature of a distance object using a
> thermophile to absorb IR energy emitted from the object
>
> the sensor has two channels: IR sensor voltage (16-bit) and reference
> temperature of the chip (14-bit)
Couple of nitpicks inline.

I've cc'd lmsensors mostly to let them know I'm intending to take this into
IIO.  It's clearly unconventional enough I would imagine it isn't going
to get often used for hardware monitoring/
Best to keep everyone informed (and check no one has strong views on
this!)  We do have iio-hwmon these days if anyone does need that
functionality.

Jonathan
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  drivers/iio/Kconfig              |   1 +
>  drivers/iio/Makefile             |   1 +
>  drivers/iio/temperature/Kconfig  |  16 +++
>  drivers/iio/temperature/Makefile |   5 +
>  drivers/iio/temperature/tmp006.c | 288 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 311 insertions(+)
>  create mode 100644 drivers/iio/temperature/Kconfig
>  create mode 100644 drivers/iio/temperature/Makefile
>  create mode 100644 drivers/iio/temperature/tmp006.c
>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b682f6f..f3a4303 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -80,5 +80,6 @@ if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
>  source "drivers/iio/pressure/Kconfig"
> +source "drivers/iio/temperature/Kconfig"
>
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 6e43e5b..62a08a8 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -25,3 +25,4 @@ obj-y += light/
>  obj-y += magnetometer/
>  obj-y += trigger/
>  obj-y += pressure/
> +obj-y += temperature/
ouch, we seem to have lost ordering in here...
Do the best you can (eg. above trigger and we will get pressure moved to the right
place).
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> new file mode 100644
> index 0000000..85506bb
> --- /dev/null
> +++ b/drivers/iio/temperature/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# Temperature sensor drivers
> +#
> +menu "Temperature sensors"
> +
> +config TMP006
> +	tristate "TMP006 infrared thermophile sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the Texas Instruments
> +	  TMP006 infrared thermophile sensor.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called tmp006.
> +
> +endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> new file mode 100644
> index 0000000..24d7b60
> --- /dev/null
> +++ b/drivers/iio/temperature/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for industrial I/O temperature drivers
> +#
> +
> +obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> new file mode 100644
> index 0000000..fca1ca0
> --- /dev/null
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -0,0 +1,288 @@
> +/*
> + * tmp006.c - Support for TI TMP006 IR thermophile sensor
> + *
> + * Copyright (c) 2013 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Driver for the Texas Instruments I2C 16-bit IR thermophile sensor
> + *
> + * (7-bit I2C slave address 0x40, changeable via ADR pins)
> + *
> + * TODO: data ready irq
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define TMP006_VOBJECT 0x00
> +#define TMP006_TAMBIENT 0x01
> +#define TMP006_CONFIG 0x02
> +#define TMP006_MANUFACTURER_ID 0xfe
> +#define TMP006_DEVICE_ID 0xff
> +
> +#define TMP006_CONFIG_RESET BIT(15)
> +#define TMP006_CONFIG_DRDY_EN BIT(8)
> +#define TMP006_CONFIG_DRDY BIT(7)
> +
> +#define TMP006_CONFIG_MOD_MASK 0x7000
> +
> +#define TMP006_CONFIG_CR_MASK 0x0e00
> +#define TMP006_CONFIG_CR_SHIFT 9
> +
> +#define MANUFACTURER_MAGIC 0x5449
> +#define DEVICE_MAGIC 0x0067
> +
> +struct tmp006_data {
> +	struct i2c_client *client;
> +	u16 config;
> +};
> +
> +static int tmp006_read_measurement(struct tmp006_data *data, u8 reg)
> +{
> +	s32 ret;
> +	int tries = 50;
> +
> +	while (tries-- > 0) {
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +			TMP006_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & TMP006_CONFIG_DRDY)
> +			break;
> +		msleep(100);
> +	}
> +
> +	if (tries < 0)
> +		return -EIO;
> +
> +	return i2c_smbus_read_word_swapped(data->client, reg);
> +}
> +
> +static int tmp006_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct tmp006_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel->type = IIO_VOLTAGE) {
> +			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
> +			if (ret < 0)
> +				return ret;
> +			*val = (s16) ret;
I would marginally prefer you used sign_extend32 to do this (little
bit clearer what is going on).
> +		} else if (channel->type = IIO_TEMP) {
> +			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
> +			if (ret < 0)
> +				return ret;
> +			*val = (s16) ret >> 2;
> +		} else
> +			break;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type = IIO_VOLTAGE) {
> +			*val = 0;
> +			*val2 = 156250;
> +		} else if (channel->type = IIO_TEMP) {
> +			*val = 31;
> +			*val2 = 250000;
> +		} else
> +			break;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const char * const tmp006_freqs[] = { "4", "2", "1", "0.5", "0.25" };
> +
> +static ssize_t tmp006_show_freq(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct tmp006_data *data = iio_priv(dev_to_iio_dev(dev));
> +	int cr = (data->config & TMP006_CONFIG_CR_MASK)
> +		>> TMP006_CONFIG_CR_SHIFT;
> +	return sprintf(buf, "%s\n", tmp006_freqs[cr]);
> +}
> +
> +static ssize_t tmp006_store_freq(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tmp006_data *data = iio_priv(indio_dev);
> +	int i;
> +	bool found = false;
> +
> +	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
> +		if (sysfs_streq(buf, tmp006_freqs[i])) {
> +			found = true;
> +			break;
> +		}
> +	if (!found)
> +		return -EINVAL;
> +
> +	data->config &= ~TMP006_CONFIG_CR_MASK;
> +	data->config |= i << TMP006_CONFIG_CR_SHIFT;
> +
> +	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
> +		data->config);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
> +			tmp006_show_freq, tmp006_store_freq);
> +
> +static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0.5 0.25");
> +
> +static struct attribute *tmp006_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tmp006_attribute_group = {
> +	.attrs = tmp006_attributes,
> +};
> +
> +static const struct iio_chan_spec tmp006_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	},
}, { is slightly more compact with no loss of readability.
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static const struct iio_info tmp006_info = {
> +	.read_raw = tmp006_read_raw,
> +	.attrs = &tmp006_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static bool tmp006_check_identification(struct tmp006_data *data)
> +{
> +	int mid, did;
> +
> +	mid = i2c_smbus_read_word_swapped(data->client,
> +		TMP006_MANUFACTURER_ID);
> +	if (mid < 0)
> +		return false;
> +
> +	did = i2c_smbus_read_word_swapped(data->client, TMP006_DEVICE_ID);
> +	if (did < 0)
> +		return false;
> +
> +	if (mid != MANUFACTURER_MAGIC || did != DEVICE_MAGIC)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int tmp006_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct tmp006_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &tmp006_info;
> +
> +	indio_dev->channels = tmp006_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tmp006_channels);
> +
> +	if (!tmp006_check_identification(data)) {
> +		dev_err(&client->dev, "no TMP006 sensor\n");
> +		return -ENODEV;
> +	}
> +
> +	dev_info(&client->dev, "TMP006 IR thermophile sensor\n");
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, TMP006_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +	data->config = ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		return ret;
Return ret instead of 0 below and loose this final test.
> +
> +	return 0;
> +}
> +
> +static int tmp006_remove(struct i2c_client *client)
> +{
> +	iio_device_unregister(i2c_get_clientdata(client));
blank line.
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tmp006_suspend(struct device *dev)
> +{
> +	struct tmp006_data *data = iio_priv(dev_to_iio_dev(dev));
> +	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
> +		data->config & ~TMP006_CONFIG_MOD_MASK);
> +}
> +
> +static int tmp006_resume(struct device *dev)
> +{
> +	struct tmp006_data *data = iio_priv(dev_to_iio_dev(dev));
> +	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
> +		data->config | TMP006_CONFIG_MOD_MASK);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
> +#define TMP006_PM_OPS (&tmp006_pm_ops)
> +#else
> +#define TMP006_PM_OPS NULL
> +#endif
> +
> +static const struct i2c_device_id tmp006_id[] = {
> +	{ "tmp006", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tmp006_id);
> +
> +static struct i2c_driver tmp006_driver = {
> +	.driver = {
> +		.name = "tmp006",
> +		.pm = TMP006_PM_OPS,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = tmp006_probe,
> +	.remove = tmp006_remove,
> +	.id_table = tmp006_id,
> +};
> +module_i2c_driver(tmp006_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("TI TMP006 IR thermophile sensor driver");
> +MODULE_LICENSE("GPL");
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
