From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 31 Jul 2013 22:11:28 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20130731221127.GA10105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 29, 2013 at 05:27:35PM +0200, Harald Judt wrote:
[ ... ]
> 
> -- 
> `Experience is the best teacher.'
> 
> PGP Key ID: 0xB29C7F8F

> From c3961cf2fa1d6975b9bcffeb746c57bda09e7489 Mon Sep 17 00:00:00 2001
> From: Harald Judt <h.judt@gmx.at>
> Date: Mon, 29 Jul 2013 17:00:27 +0200
> Subject: hwmon: (nct6775) Add support for hibernate
> 
Hi Harald,

Signed-off-by: is missing. Ok if I add your Signed-off to the patch ?

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 99cec18..b66bc74 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -4056,6 +4056,8 @@ static int nct6775_resume(struct device *dev)
>  static const struct dev_pm_ops nct6775_dev_pm_ops = {
>  	.suspend = nct6775_suspend,
>  	.resume = nct6775_resume,
> +	.freeze = nct6775_suspend,
> +	.restore = nct6775_resume
>  };
>  
>  #define NCT6775_DEV_PM_OPS	(&nct6775_dev_pm_ops)
> -- 
> 1.8.3.2
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
