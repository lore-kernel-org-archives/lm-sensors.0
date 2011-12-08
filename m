From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 08 Dec 2011 14:08:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: jz4740: Staticise
Message-Id: <4EE0C4D8.4050106@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323351217.3398.0.camel@phoenix>
In-Reply-To: <1323351217.3398.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On 12/08/2011 02:33 PM, Axel Lin wrote:
> It is not used outside this driver so no need to make the symbol global.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  drivers/hwmon/jz4740-hwmon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
> index 3d7e590..5253d23 100644
> --- a/drivers/hwmon/jz4740-hwmon.c
> +++ b/drivers/hwmon/jz4740-hwmon.c
> @@ -203,7 +203,7 @@ static int __devexit jz4740_hwmon_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -struct platform_driver jz4740_hwmon_driver = {
> +static struct platform_driver jz4740_hwmon_driver = {
>  	.probe	= jz4740_hwmon_probe,
>  	.remove = __devexit_p(jz4740_hwmon_remove),
>  	.driver = {



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
