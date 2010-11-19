From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Nov 2010 13:55:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lis3lv02d_i2c) Fix compile
Message-Id: <20101119145510.1c59d6c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 18 Nov 2010 21:10:52 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

When sending a patch which removes a warning, I suggest including that
warning in the description. Without the warning, it's difficult to
review the proposed code change.

> ---
>  drivers/hwmon/lis3lv02d_i2c.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> index 9f4bae0..16c1f48 100644
> --- a/drivers/hwmon/lis3lv02d_i2c.c
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -213,12 +213,9 @@ static int lis3lv02d_i2c_resume(struct device *dev)/join  #bonjour j
>  
>  	return 0;
>  }
> -#else
> -#define lis3lv02d_i2c_suspend	NULL
> -#define lis3lv02d_i2c_resume	NULL
> -#define lis3lv02d_i2c_shutdown	NULL
> -#endif
> +#endif /* CONFIG_PM */
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

The fix looks sane to me.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
