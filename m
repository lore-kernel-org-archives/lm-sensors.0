From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 28 Mar 2011 06:43:33 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: twl4030-madc-hwmon: add
Message-Id: <20110328064333.GA3890@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299466949.3879.0.camel@mola>
 <1299467133.3879.5.camel@mola>
In-Reply-To: <1299467133.3879.5.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Mar 07, 2011 at 11:05:33AM +0800, Axel Lin wrote:
> Since 43cc71eed1250755986da4c0f9898f9a635cb3bf (platform: prefix MODALIAS
> with "platform:"), the platform modalias is prefixed with "platform:".
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Cc: J Keerthy <j-keerthy@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

Looks like this fell through the cracks. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/twl4030-madc-hwmon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
> index 97e22be..de58191 100644
> --- a/drivers/hwmon/twl4030-madc-hwmon.c
> +++ b/drivers/hwmon/twl4030-madc-hwmon.c
> @@ -154,4 +154,4 @@ module_exit(twl4030_madc_hwmon_exit);
>  MODULE_DESCRIPTION("TWL4030 ADC Hwmon driver");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("J Keerthy");
> -MODULE_ALIAS("twl4030_madc_hwmon");
> +MODULE_ALIAS("platform:twl4030_madc_hwmon");
> -- 
> 1.7.2
> 
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
