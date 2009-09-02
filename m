From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 19:10:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Disable s3c-hwmon build for S3C64xx
Message-Id: <20090902211048.5c424d07@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251110906-19010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1251110906-19010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On Mon, 24 Aug 2009 11:48:26 +0100, Mark Brown wrote:
> The s3c-hwmon driver depends on the arch/arm implementation of the core
> ADC support for the chip.  Since the S3C64xx version has not yet been
> merged disable building of the driver on S3C64xx for now.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/hwmon/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a54407b..fa94b56 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -704,7 +704,7 @@ config SENSORS_SHT15
>  
>  config SENSORS_S3C
>  	tristate "S3C24XX/S3C64XX Inbuilt ADC"
> -	depends on ARCH_S3C2410 || ARCH_S3C64XX
> +	depends on ARCH_S3C2410
>  	help
>  	  If you say yes here you get support for the on-board ADCs of
>  	  the Samsung S3C24XX or S3C64XX series of SoC

I presume this is meant for 2.6.31 and should be sent to Linus very
quickly?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
