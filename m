From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2012 19:14:10 +0000
Subject: Re: [lm-sensors] [PATCH 23/39] hwmon: (lm70) Convert to use devm_ functions
Message-Id: <20120917211410.03f83821@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  7 Aug 2012 08:20:12 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm70.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index 472f795..dd7f0ca 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -149,7 +149,7 @@ static int __devinit lm70_probe(struct spi_device *spi)
>  
>  	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
>  
> -	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
> +	p_lm70 = devm_kzalloc(&spi->dev, sizeof(*p_lm70), GFP_KERNEL);
>  	if (!p_lm70)
>  		return -ENOMEM;
>  
> @@ -181,7 +181,6 @@ out_dev_create_file_failed:
>  	device_remove_file(&spi->dev, &dev_attr_temp1_input);
>  out_dev_create_temp_file_failed:
>  	spi_set_drvdata(spi, NULL);
> -	kfree(p_lm70);
>  	return status;
>  }
>  
> @@ -193,7 +192,6 @@ static int __devexit lm70_remove(struct spi_device *spi)
>  	device_remove_file(&spi->dev, &dev_attr_temp1_input);
>  	device_remove_file(&spi->dev, &dev_attr_name);
>  	spi_set_drvdata(spi, NULL);
> -	kfree(p_lm70);
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
