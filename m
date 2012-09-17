From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2012 19:01:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (adcxx) Simplify show_name function
Message-Id: <20120917210159.5857d14c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396773-32108-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347396773-32108-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Sep 2012 13:52:51 -0700, Guenter Roeck wrote:
> Display device name using to_spi_device(dev)->modalias instead of computing it
> from the number of ADC channels. This is cleaner and reduces code size.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adcxx.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
> index 111af7c..f4c5867 100644
> --- a/drivers/hwmon/adcxx.c
> +++ b/drivers/hwmon/adcxx.c
> @@ -141,10 +141,7 @@ static ssize_t adcxx_set_max(struct device *dev,
>  static ssize_t adcxx_show_name(struct device *dev, struct device_attribute
>  			      *devattr, char *buf)
>  {
> -	struct spi_device *spi = to_spi_device(dev);

As many other functions in this driver have this, you could have kept
it and used spi-> below. But that's a minor detail.

> -	struct adcxx *adc = spi_get_drvdata(spi);
> -
> -	return sprintf(buf, "adcxx%ds\n", adc->channels);
> +	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
>  }
>  
>  static struct sensor_device_attribute ad_input[] = {

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
