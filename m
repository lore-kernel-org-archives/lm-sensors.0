From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Jan 2012 17:26:21 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] drivers/hwmon/mc13783-adc.c: remove space before tab
Message-Id: <20120130182621.35f3996d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325789418-11276-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325789418-11276-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu,  5 Jan 2012 19:50:16 +0100, Frans Meulenbroeks wrote:

Signed-off-by is missing. I am assuming it was overlooked, and am
adding it back. Applied, thanks.

> ---
>  drivers/hwmon/mc13783-adc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index ef65ab5..04d13b3 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -220,7 +220,7 @@ static int __devexit mc13783_adc_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver mc13783_adc_driver = {
> -	.remove 	= __devexit_p(mc13783_adc_remove),
> +	.remove		= __devexit_p(mc13783_adc_remove),
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= MC13783_ADC_NAME,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
