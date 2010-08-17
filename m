From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Aug 2010 14:10:48 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ads7871) Fix ads7871_probe
Message-Id: <20100817161048.51b42394@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282048884.2626.2.camel@phoenix>
In-Reply-To: <1282048884.2626.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Paul Thomas <pthomas8589@gmail.com>, lm-sensors@lm-sensors.org

On Tue, 17 Aug 2010 20:41:24 +0800, Axel Lin wrote:
> This patch moves hwmon_device_register() to the end of ads7871_probe().
> So we can make sure the device exists and is properly initialized
> before the device is exposed to user-space.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/hwmon/ads7871.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
> index b300a20..45f5829 100644
> --- a/drivers/hwmon/ads7871.c
> +++ b/drivers/hwmon/ads7871.c
> @@ -176,12 +176,6 @@ static int __devinit ads7871_probe(struct spi_device *spi)
>  	if (status < 0)
>  		goto error_free;
>  
> -	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
> -	if (IS_ERR(pdata->hwmon_dev)) {
> -		err = PTR_ERR(pdata->hwmon_dev);
> -		goto error_remove;
> -	}
> -
>  	spi_set_drvdata(spi, pdata);
>  
>  	/* Configure the SPI bus */
> @@ -204,6 +198,12 @@ static int __devinit ads7871_probe(struct spi_device *spi)
>  		goto error_remove;
>  	}
>  
> +	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
> +	if (IS_ERR(pdata->hwmon_dev)) {
> +		err = PTR_ERR(pdata->hwmon_dev);
> +		goto error_remove;
> +	}
> +
>  	return 0;
>  
>  error_remove:

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
