From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2012 19:23:46 +0000
Subject: Re: [lm-sensors] [PATCH 06/39] hwmon: (adcxx) Convert to use devm_ functions
Message-Id: <20120917212346.175c7021@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  7 Aug 2012 08:19:55 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adcxx.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
> index a3d3183..111af7c 100644
> --- a/drivers/hwmon/adcxx.c
> +++ b/drivers/hwmon/adcxx.c
> @@ -171,7 +171,7 @@ static int __devinit adcxx_probe(struct spi_device *spi)
>  	int status;
>  	int i;
>  
> -	adc = kzalloc(sizeof *adc, GFP_KERNEL);
> +	adc = devm_kzalloc(&spi->dev, sizeof(*adc), GFP_KERNEL);
>  	if (!adc)
>  		return -ENOMEM;
>  
> @@ -208,7 +208,6 @@ out_err:
>  
>  	spi_set_drvdata(spi, NULL);
>  	mutex_unlock(&adc->lock);
> -	kfree(adc);
>  	return status;
>  }
>  
> @@ -224,7 +223,6 @@ static int __devexit adcxx_remove(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, NULL);
>  	mutex_unlock(&adc->lock);
> -	kfree(adc);
>  
>  	return 0;
>  }

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
