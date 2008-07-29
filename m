From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 29 Jul 2008 04:35:48 +0000
Subject: Re: [lm-sensors] [RFC,PATCH v1] hwmon: ADC124S501 generic driver
Message-Id: <20080728213548.156af744.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807231307.54837.marc.pignat@hevs.ch>
In-Reply-To: <200807231307.54837.marc.pignat@hevs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Pignat <marc.pignat@hevs.ch>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>

On Wed, 23 Jul 2008 13:07:54 +0200 Marc Pignat <marc.pignat@hevs.ch> wrote:

> SPI driver for analog to digital converters national semiconductor ADC081S101,
> ADC124S501, ...
> 
> Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
> 
> Hi all!
> 
> patch against 2.6.26, tested on a custom arm board and only compil-tested on
> x86.
> 
> This driver add support for National Semiconductor ADC<bb><c>S<sss> chip family,
> where:
>  * bb  is the resolution in number of bits (8, 10, 12)
>  * c   is the number of channels (1, 2, 4)
>  * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500
>    kSPS and 101 for 1 MSPS)
> 
> Some remarks:
>  * The chip type (-> the number of inputs) are determined by the module alias,
>    is it a good idea? it could be implemented using platform data.
> 
>  * The Makefile seems ordered alphabetically, what order should be used for
>    the Konfig file?
> 

That changelog is a bit of a mess.  I cleaned up up as:

SPI driver for analog to digital converters national semiconductor
ADC081S101, ADC124S501, ...

This driver adds support for National Semiconductor ADC<bb><c>S<sss> chip
family, where:

 * bb  is the resolution in number of bits (8, 10, 12)
 * c   is the number of channels (1, 2, 4)
 * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500
   kSPS and 101 for 1 MSPS)

Some remarks:

* The chip type (-> the number of inputs) are determined by the module
  alias, is it a good idea?  it could be implemented using platform data.

Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: David Brownell <david-b@pacbell.net>

but then didn't apply the patch.

>
> ...
>
> +/* sysfs hook function */
> +static ssize_t adcxx_read(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adcxx *adc = dev_get_drvdata(&spi->dev);
> +
> +	u8 tx_buf[2] = { attr->index << 3 }; /* other bits are don't care */
> +	u8 rx_buf[2];
> +	int status;
> +	int value;

The driver has rather a lot of inexplicable blank lines in the middle
of the automatic variable definitions.  The preferred style is no blank
lines within the definitions and a single blank line after them all,
thanks.

>
> ...
>
> +static int __devinit adcxx_probe(struct spi_device *spi, int channels)
> +{
> +	struct adcxx *adc;
> +	int status;
> +	int i;
> +
> +	adc = kzalloc(sizeof *adc, GFP_KERNEL);
> +	if (!adc)
> +		return -ENOMEM;
> +
> +	/* set a default value for the reference */
> +	adc->reference = 3300;
> +
> +	adc->channels = channels;
> +
> +	mutex_init(&adc->lock);
> +
> +	dev_set_drvdata(&spi->dev, adc);
> +
> +	for (i = 0; i < 3 + adc->channels; i++) {
> +		status = device_create_file(&spi->dev, &ad_input[i].dev_attr);
> +		if (status)
> +			goto out_dev_create_file_failed;
> +	}
> +
> +	adc->hwmon_dev = hwmon_device_register(&spi->dev);
> +	if (IS_ERR(adc->hwmon_dev)) {
> +		dev_dbg(&spi->dev, "hwmon_device_register failed.\n");
> +		status = PTR_ERR(adc->hwmon_dev);
> +		goto out_dev_reg_failed;
> +	}
> +
> +	return 0;
> +
> +out_dev_create_file_failed:
> +	hwmon_device_unregister(adc->hwmon_dev);
> +	for (i = 0; i < 3 + adc->channels; i++)
> +		device_remove_file(&spi->dev, &ad_input[i].dev_attr);
> +out_dev_reg_failed:
> +	dev_set_drvdata(&spi->dev, NULL);
> +	kfree(adc);
> +	return status;
> +}

The error recovery here is messed up.  The targets of the `goto's are
reversed.  But even if that is fixed, we can end up doing
device_remove_file() of objects which weren't successfully created. 
That might work, or it might generate runtime warnings or it might
crash.  I don't know.  It'd be best to just avoid doing it?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
