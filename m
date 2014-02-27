From: Roland Stigge <stigge@antcom.de>
Date: Thu, 27 Feb 2014 12:14:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6639) Use SIMPLE_DEV_PM_OPS macro
Message-Id: <530F2C3C.7010704@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <000a01cf33b0$6a40dc50$3ec294f0$%han@samsung.com>
In-Reply-To: <000a01cf33b0$6a40dc50$3ec294f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/27/2014 12:38 PM, Jingoo Han wrote:
> Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/hwmon/max6639.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index e4852bb..2852894 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -592,9 +592,7 @@ static const struct i2c_device_id max6639_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, max6639_id);
>  
> -static const struct dev_pm_ops max6639_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(max6639_suspend, max6639_resume)
> -};
> +static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
>  
>  static struct i2c_driver max6639_driver = {
>  	.class = I2C_CLASS_HWMON,
> 

Acked-by: Roland Stigge <stigge@antcom.de>

Thanks!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
