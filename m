From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 29 Nov 2015 16:33:35 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] iio: ina2xx: provide a sysfs parameter to allow async readout of the AD
Message-Id: <565B28DF.60002@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1448450896-24387-1-git-send-email-mtitinger@baylibre.com>
 <1448450896-24387-3-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1448450896-24387-3-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux@roeck-us.net, jdelvare@suse.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 25/11/15 11:28, Marc Titinger wrote:
> This can lead to repeated or skipped samples depending on the clock beat
> between the capture thread and the chip sampling clock, but will also spare
> reading/waiting for the Capture Ready Flag and improve the available i2c
> bandwidth for reading measurements.
> 
> Output of iio_info:
> ...snip...
> 4 device-specific attributes found:
>   attr 0: in_oversampling_ratio value: 4
>   attr 1: in_allow_async_readout value: 0
>   attr 2: integration_time_available value: 140 204 332 588 1100 2116 4156 8244
>   attr 3: in_sampling_frequency value: 114
>
This is a good compromise if it is needed to get the rates as high as
you need.

One suggestion inline.

Jonathan

> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>  drivers/iio/adc/ina2xx-iio.c | 48 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-iio.c b/drivers/iio/adc/ina2xx-iio.c
> index 4a0026c..c153164 100644
> --- a/drivers/iio/adc/ina2xx-iio.c
> +++ b/drivers/iio/adc/ina2xx-iio.c
> @@ -114,6 +114,7 @@ struct ina2xx_chip_info {
>  	int avg;
>  	int itb; /* Bus voltage integration time uS */
>  	int its; /* Shunt voltage integration tim uS */
> +	bool allow_async_readout;
>  };
>  
>  static const struct ina2xx_config ina2xx_config[] = {
> @@ -335,6 +336,33 @@ _err:
>  }
>  
>  
> +static ssize_t ina2xx_allow_async_readout_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", chip->allow_async_readout);
> +}
> +
> +static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +	unsigned long val;
> +	int ret;
> +
strtobool would simplify this.
> +	ret = kstrtoul((const char *) buf, 10, &val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	chip->allow_async_readout = !!val;
> +
> +	return len;
> +}
> +
> +
>  #define INA2XX_CHAN(_type, _index, _address) { \
>  	.type = _type, \
>  	.address = _address, \
> @@ -402,11 +430,12 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	 * GPIO a triggered buffer could be used instead.
>  	 * For now, we pay for that extra read of the ALERT register
>  	 */
> -	do {
> -		ret = regmap_read(chip->regmap, INA226_ALERT_MASK,
> -				  &alert);
> -		if (ret < 0)
> -			goto _err;
> +	if (!chip->allow_async_readout)
> +		do {
> +			ret = regmap_read(chip->regmap, INA226_ALERT_MASK,
> +					  &alert);
> +			if (ret < 0)
> +				goto _err;
>  
>  		alert &= INA266_CVRF;
>  		trace_printk("Conversion ready: %d\n", !!alert);
> @@ -457,7 +486,8 @@ static int ina2xx_capture_thread(void *data)
>  	 * Poll a bit faster than the chip internal Fs, in case
>  	 * we wish to sync with the conversion ready flag.
>  	 */
> -	sampling_us -= 200;
> +	if (!chip->allow_async_readout)
> +		sampling_us -= 200;
>  
>  	do {
>  		buffer_us = ina2xx_work_buffer(indio_dev);
> @@ -480,6 +510,7 @@ int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>  		     1000000/sampling_us, chip->avg);
>  
>  	trace_printk("Expected work period: %u us\n", sampling_us);
> +	trace_printk("Async readout mode: %d\n", chip->allow_async_readout);
>  
>  	prev_ns = iio_get_time_ns();
>  
> @@ -519,7 +550,12 @@ static int ina2xx_debug_reg(struct iio_dev *indio_dev,
>  /* frequencies matching the cummulated integration times for vshunt and vbus */
>  static IIO_CONST_ATTR_INT_TIME_AVAIL("140 204 332 588 1100 2116 4156 8244");
>  
> +static IIO_DEVICE_ATTR(in_allow_async_readout, S_IRUGO | S_IWUSR,
> +		       ina2xx_allow_async_readout_show,
> +		       ina2xx_allow_async_readout_store, 0);
> +
>  static struct attribute *ina2xx_attributes[] = {
> +	&iio_dev_attr_in_allow_async_readout.dev_attr.attr,
>  	&iio_const_attr_integration_time_available.dev_attr.attr,
>  	NULL,
>  };
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
