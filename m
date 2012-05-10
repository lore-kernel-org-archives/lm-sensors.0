From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 May 2012 21:03:11 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (it87) Convert to use devm_kzalloc
Message-Id: <20120510230311.5d6958a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  8 May 2012 19:31:53 -0700, Guenter Roeck wrote:
> This makes the code a bit simpler and smaller.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index baf4173..47dbb2c 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -1967,7 +1967,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  		goto ERROR0;
>  	}
>  
> -	data = kzalloc(sizeof(struct it87_data), GFP_KERNEL);
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct it87_data), GFP_KERNEL);
>  	if (!data) {
>  		err = -ENOMEM;
>  		goto ERROR1;
> @@ -1982,7 +1982,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80)
>  	 || it87_read_value(data, IT87_REG_CHIPID) != 0x90) {
>  		err = -ENODEV;
> -		goto ERROR2;
> +		goto ERROR1;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -2114,9 +2114,6 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  
>  ERROR4:
>  	it87_remove_files(dev);
> -ERROR2:
> -	platform_set_drvdata(pdev, NULL);
> -	kfree(data);
>  ERROR1:
>  	release_region(res->start, IT87_EC_EXTENT);
>  ERROR0:
> @@ -2131,9 +2128,6 @@ static int __devexit it87_remove(struct platform_device *pdev)
>  	it87_remove_files(&pdev->dev);
>  
>  	release_region(data->addr, IT87_EC_EXTENT);
> -	platform_set_drvdata(pdev, NULL);
> -	kfree(data);
> -
>  	return 0;
>  }
>  

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
