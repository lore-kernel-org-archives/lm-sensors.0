From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Nov 2010 20:36:46 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lis3lv02d_i2c) Fix compile
Message-Id: <20101119213646.635d91eb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1290188321-31841-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1290188321-31841-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 19 Nov 2010 09:38:41 -0800, Guenter Roeck wrote:
> This commit fixes the following compile warnings.
> 
> From v2.6.37-rc2/m68k/m68k-allmodconfig, v2.6.37-rc2/powerpc/powerpc-randconfig:
> drivers/hwmon/lis3lv02d_i2c.c:222: warning: 'lis3_i2c_runtime_suspend' defined but not used
> drivers/hwmon/lis3lv02d_i2c.c:231: warning: 'lis3_i2c_runtime_resume' defined but not used
> 
> Seen if CONFIG_PM_RUNTIME is not set.
> 
> From v2.6.37-rc2/sh4/sh-allyesconfig:
> drivers/hwmon/lis3lv02d_i2c.c:191: warning: 'lis3lv02d_i2c_suspend' defined but not used
> drivers/hwmon/lis3lv02d_i2c.c:201: warning: 'lis3lv02d_i2c_resume' defined but not used
> 
> Seen if CONFIG_PM is set but CONFIG_PM_SLEEP is not.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> v2: Replaced ifdef CONFIG_PM with ifdef CONFIG_PM_SLEEP
> 
>  drivers/hwmon/lis3lv02d_i2c.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> index 9f4bae0..8853afc 100644
> --- a/drivers/hwmon/lis3lv02d_i2c.c
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -186,7 +186,7 @@ static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int lis3lv02d_i2c_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
> @@ -213,12 +213,9 @@ static int lis3lv02d_i2c_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#else
> -#define lis3lv02d_i2c_suspend	NULL
> -#define lis3lv02d_i2c_resume	NULL
> -#define lis3lv02d_i2c_shutdown	NULL
> -#endif
> +#endif /* CONFIG_PM_SLEEP */
>  
> +#ifdef CONFIG_PM_RUNTIME
>  static int lis3_i2c_runtime_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
> @@ -236,6 +233,7 @@ static int lis3_i2c_runtime_resume(struct device *dev)
>  	lis3lv02d_poweron(lis3);
>  	return 0;
>  }
> +#endif /* CONFIG_PM_RUNTIME */
>  
>  static const struct i2c_device_id lis3lv02d_id[] = {
>  	{"lis3lv02d", 0 },


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
