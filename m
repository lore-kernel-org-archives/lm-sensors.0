From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Dec 2009 16:22:40 +0000
Subject: Re: [lm-sensors] [PATCH] [hwmon] mc13783-adc: handle failure of
Message-Id: <20091204172240.52143aa8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1259874014-14621-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1259874014-14621-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 4 Dec 2009 16:50:46 +0100, Uwe Kleine-König wrote:
> Hi Jean,
> 
> > The usual coding style says: no blank line between assignation and
> > error test.
> OK, fixed.
>  
> > > +
> > >  	channel &= 0x7;
> > >  
> > > -	return (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> > > +	*res = (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> > > +
> > > +	return ret;
> > 
> > This will always be 0, so you might as well make it clearer.
> ditto.
> 
> > >  }
> > >  
> > >  static ssize_t mc13783_adc_read_bp(struct device *dev,
> > >  		struct device_attribute *devattr, char *buf)
> > >  {
> > > -	unsigned res = mc13783_adc_read(dev, devattr);
> > > +	unsigned res;
> > > +	int ret = mc13783_adc_read(dev, devattr, &res);
> > 
> > Having two variables named "res" and "ret" respectively in the same
> > scope seems to be a recipe for disaster.
> I renamed res to val.
>  
> Thanks for your input.
> 
> Best regards
> Uwe
> 
> ---->8----
> From d9310e1c256d8f40964aee0b85f5b5c4302bcdd4 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Uwe Kleine-König?= <u.kleine-koenig@pengutronix.de>
> Date: Mon, 12 Oct 2009 10:15:00 +0200
> Subject: [PATCH] [hwmon] mc13783-adc: handle failure of mc13783_adc_do_conversion ...
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> If reading the result of a channel fails pass the failure to userspace.
> 
> res is renamed to val to prevent confusion with the new variable ret.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/hwmon/mc13783-adc.c |   36 +++++++++++++++++++++++++-----------
>  1 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index fafb193..ed0453d 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -40,49 +40,63 @@ static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
>  	return sprintf(buf, "mc13783_adc\n");
>  }
>  
> -static unsigned int mc13783_adc_read(struct device *dev,
> -		struct device_attribute *devattr)
> +static int mc13783_adc_read(struct device *dev,
> +		struct device_attribute *devattr, unsigned int *val)
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
> +	if (ret)
> +		return ret;
>  
>  	channel &= 0x7;
>  
> -	return (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> +	*val = (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> +
> +	return 0;
>  }
>  
>  static ssize_t mc13783_adc_read_bp(struct device *dev,
>  		struct device_attribute *devattr, char *buf)
>  {
> -	unsigned res = mc13783_adc_read(dev, devattr);
> +	unsigned val;
> +	int ret = mc13783_adc_read(dev, devattr, &val);
> +
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
>  	 * the input range of the ADC.  unit = 2.25mV = 9/4 mV.
>  	 */
> -	res = DIV_ROUND_CLOSEST(res * 9, 4) + 2400;
> +	val = DIV_ROUND_CLOSEST(val * 9, 4) + 2400;
>  
> -	return sprintf(buf, "%u\n", res);
> +	return sprintf(buf, "%u\n", val);
>  }
>  
>  static ssize_t mc13783_adc_read_gp(struct device *dev,
>  		struct device_attribute *devattr, char *buf)
>  {
> -	unsigned res = mc13783_adc_read(dev, devattr);
> +	unsigned val;
> +	int ret = mc13783_adc_read(dev, devattr, &val);
> +
> +	if (ret)
> +		return ret;
>  
>  	/*
> -	 * input range is [0, 2.3V], res has 10 bits, so each bit
> +	 * input range is [0, 2.3V], val has 10 bits, so each bit
>  	 * is worth 9/4 mV.
>  	 */
> -	res = DIV_ROUND_CLOSEST(res * 9, 4);
> +	val = DIV_ROUND_CLOSEST(val * 9, 4);
>  
> -	return sprintf(buf, "%u\n", res);
> +	return sprintf(buf, "%u\n", val);
>  }
>  
>  static DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL);

Merged, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
