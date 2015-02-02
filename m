From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 02 Feb 2015 17:23:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: tmp102: add hibernation callbacks
Message-Id: <20150202172311.GA22638@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1422897271-24068-1-git-send-email-grygorii.strashko@linaro.org>
In-Reply-To: <1422897271-24068-1-git-send-email-grygorii.strashko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grygorii.strashko@linaro.org
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Feb 02, 2015 at 07:14:31PM +0200, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Setting a dev_pm_ops suspend/resume pair but not a set of
> hibernation functions means those pm functions will not be
> called upon hibernation.
> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
> assigns the suspend and hibernation handlers.
> 
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>  drivers/hwmon/tmp102.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index 6748b45..4f790f5 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -281,17 +281,10 @@ static int tmp102_resume(struct device *dev)
>  	config &= ~TMP102_CONF_SD;
>  	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
>  }
> -
> -static const struct dev_pm_ops tmp102_dev_pm_ops = {
> -	.suspend	= tmp102_suspend,
> -	.resume		= tmp102_resume,
> -};
> -
> -#define TMP102_DEV_PM_OPS (&tmp102_dev_pm_ops)
> -#else
> -#define	TMP102_DEV_PM_OPS NULL
>  #endif /* CONFIG_PM */
>  
> +SIMPLE_DEV_PM_OPS(tmp102_dev_pm_ops, tmp102_suspend, tmp102_resume);
> +

SIMPLE_DEV_PM_OPS is defined in the context of CONFIG_PM_SLEEP,
while tmp102_suspend and tmp102_resume above are defined in the
context of CONFIG_PM. This will result in situations where the
functions are defined but not used, resulting in build warnings.

Please change the condition in the driver to #ifdef CONFIG_PM_SLEEP
to avoid this problem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
