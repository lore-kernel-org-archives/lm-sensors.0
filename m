From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 May 2015 22:37:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ntc: use iio_read_channel_processed if possible
Message-Id: <20150527223758.GA13245@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432740591-21313-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1432740591-21313-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 27, 2015 at 10:29:51AM -0500, Chris Lesiak wrote:
> The function ntc_adc_iio_read assumes both a 12 bit ADC and that
> pullup_uv is the same as the ADC reference voltage.  If either
> assumption is false, then the result is incorrect.
> 
> For iio channels supporting either IIO_CHAN_INFO_PROCESSED or
> IIO_CHAN_INFO_SCALE, a new function, ntc_adc_iio_read_processed,
> will be used.  That function gets microvolts directly with a call to
> iio_read_channel_processed.
> 
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>

Hi Chris,

Couple of comments below.

When sending a new version of a patch, please provide versions and change logs
as suggested in Documentation/SubmittingPatches. Otherwise you are making it
difficult for us to track patch version and changes made.

Thanks,
Guenter

> ---
>  drivers/hwmon/ntc_thermistor.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 6880011..311df86 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -206,6 +206,20 @@ static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>  	return (int)result;
>  }
>  
> +static int ntc_adc_iio_read_processed(struct ntc_thermistor_platform_data *pdata)

checkpatch warning (line too long). You could rename the function to
ntc_adc_iio_read() and the current ntc_adc_iio_read() to
ntc_adc_iio_read_raw() as possible solution, or move 'static int'
to a separate line.

> +{
> +	struct iio_channel *channel = pdata->chan;
> +	int val, ret;
> +
> +	ret = iio_read_channel_processed(channel, &val);
> +	if (ret < 0) {
> +		pr_err("read channel() error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return val;
> +}
> +
>  static const struct of_device_id ntc_match[] = {
>  	{ .compatible = "murata,ncp15wb473",
>  		.data = &ntc_thermistor_id[0] },
> @@ -275,7 +289,12 @@ ntc_thermistor_parse_dt(struct platform_device *pdev)
>  		pdata->connect = NTC_CONNECTED_GROUND;
>  
>  	pdata->chan = chan;
> -	pdata->read_uv = ntc_adc_iio_read;
> +
> +	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)
> +		|| iio_channel_has_info(chan->channel, IIO_CHAN_INFO_SCALE))

checkpatch check message (from --strict) - please address as recommended.

	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED) ||
	    iio_channel_has_info(chan->channel, IIO_CHAN_INFO_SCALE))

> +		pdata->read_uv = ntc_adc_iio_read_processed;
> +	else
> +		pdata->read_uv = ntc_adc_iio_read;
>  
>  	return pdata;
>  }
> -- 
> 1.9.3
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
