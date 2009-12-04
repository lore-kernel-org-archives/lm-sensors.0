From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Dec 2009 13:41:47 +0000
Subject: Re: [lm-sensors] [PATCH] [hwmon] mc13783-adc: handle failure of
Message-Id: <20091204144147.7b931949@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1259874014-14621-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1259874014-14621-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Uwe,

On Thu,  3 Dec 2009 22:00:14 +0100, Uwe Kleine-König wrote:
> If reading the result of a channel fails pass the failure to userspace.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Luotao Fu <l.fu@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> Hello Jean,
> 
> can you please squash this into the commit "hwmon: Add Freescale MC13783 ADC
> driver" you already took?  Assuming it looks OK of course.

I can certainly do this. A few comments though:

>  drivers/hwmon/mc13783-adc.c |   27 +++++++++++++++++++++------
>  1 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index fafb193..4018757 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -40,27 +40,38 @@ static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
>  	return sprintf(buf, "mc13783_adc\n");
>  }
>  
> -static unsigned int mc13783_adc_read(struct device *dev,
> -		struct device_attribute *devattr)
> +static int mc13783_adc_read(struct device *dev,
> +		struct device_attribute *devattr, unsigned int *res)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	unsigned int channel = attr->index;
>  	unsigned int sample[4];
> +	int ret;
>  
> -	mc13783_adc_do_conversion(priv->mc13783, MC13783_ADC_MODE_MULT_CHAN,
> +	ret = mc13783_adc_do_conversion(priv->mc13783,
> +			MC13783_ADC_MODE_MULT_CHAN,
>  			channel, sample);
>  
> +	if (ret)
> +		return ret;

The usual coding style says: no blank line between assignation and
error test.

> +
>  	channel &= 0x7;
>  
> -	return (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> +	*res = (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> +
> +	return ret;

This will always be 0, so you might as well make it clearer.

>  }
>  
>  static ssize_t mc13783_adc_read_bp(struct device *dev,
>  		struct device_attribute *devattr, char *buf)
>  {
> -	unsigned res = mc13783_adc_read(dev, devattr);
> +	unsigned res;
> +	int ret = mc13783_adc_read(dev, devattr, &res);

Having two variables named "res" and "ret" respectively in the same
scope seems to be a recipe for disaster.

> +
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
> @@ -74,7 +85,11 @@ static ssize_t mc13783_adc_read_bp(struct device *dev,
>  static ssize_t mc13783_adc_read_gp(struct device *dev,
>  		struct device_attribute *devattr, char *buf)
>  {
> -	unsigned res = mc13783_adc_read(dev, devattr);
> +	unsigned res;
> +	int ret = mc13783_adc_read(dev, devattr, &res);
> +
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * input range is [0, 2.3V], res has 10 bits, so each bit


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
