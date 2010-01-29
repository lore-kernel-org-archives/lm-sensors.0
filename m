From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jan 2010 16:46:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (s3c-hwmon): S3C hwmon requires
Message-Id: <20100129174602.7b72c507@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1264694548-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1264694548-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Thu, 28 Jan 2010 16:02:28 +0000, Mark Brown wrote:
> The S3C hwmon driver uses the core s3c ADC API so needs to either depend
> on or select it otherwise the kernel will fail to link.  For ease of use
> selecting seems simpler, the shared ADC core is pretty much an
> implementation detail.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/hwmon/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 90db0ba..cc810e7 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -704,6 +704,7 @@ config SENSORS_SHT15
>  config SENSORS_S3C
>  	tristate "S3C24XX/S3C64XX Inbuilt ADC"
>  	depends on ARCH_S3C2410 || ARCH_S3C64XX
> +	select S3C_ADC
>  	help
>  	  If you say yes here you get support for the on-board ADCs of
>  	  the Samsung S3C24XX or S3C64XX series of SoC

Which tree are you looking at? I can't find an option named S3C_ADC.

What I do see is CONFIG_S3C24XX_ADC, however it seems to be
platform-specific, so I doubt you can just "select" it on ARCH_S3C64XX.

Looking at the source tree, I also don't see ADC support for
ARCH_S3C64XX at all, so I am curious if this patch was correct:

http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027712.html

Maybe it's correct for some external tree and/or linux-next, but not
Linus' current kernel.

So, Mark, I can't take your patch, and Ben, I'll remove the other patch
from my tree right now. These changes should go together with the
related platform changes. Carrying them in the hwmon tree when all the
related changes are in another tree can only cause trouble.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
