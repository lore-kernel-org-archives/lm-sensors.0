From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 May 2015 23:00:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ntc: Don't assume a 12 bit ADC
Message-Id: <20150526230043.GC26454@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432672902-28185-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1432672902-28185-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 26, 2015 at 03:41:42PM -0500, Chris Lesiak wrote:
> The function ntc_adc_iio_read was using iio_read_channel_raw and
> converting to microVolts using the assumption of a 12 bit ADC.  If a
> converter with different precision was used, the result was in error.
> 
> Instead, use iio_read_channel_processed, which does the conversion to
> microVolts itself.
> 
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
> ---
>  drivers/hwmon/ntc_thermistor.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 6880011..0d3a686 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -190,20 +190,15 @@ struct ntc_data {
>  static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>  {
>  	struct iio_channel *channel = pdata->chan;
> -	s64 result;
>  	int val, ret;
>  
> -	ret = iio_read_channel_raw(channel, &val);
> +	ret = iio_read_channel_processed(channel, &val);
>  	if (ret < 0) {
>  		pr_err("read channel() error: %d\n", ret);
>  		return ret;
>  	}
>  
> -	/* unit: mV */
> -	result = pdata->pullup_uv * (s64) val;
> -	result >>= 12;
> -
> -	return (int)result;
> +	return val;

The calculation used to need pullup_uv. As far as I can see,
the iio driver knows nothing about pullup_uv, which makes me
wonder how this can work. Can you explain ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
