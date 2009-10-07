From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Wed, 07 Oct 2009 14:22:34 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.32] hwmon: Disable s3c-hwmon build for
Message-Id: <4ACCA42A.5060508@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <mailman.3211.1254922769.2256.linux-arm-kernel@lists.infradead.org>
In-Reply-To: <mailman.3211.1254922769.2256.linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Op 07-10-09 15:39, linux-arm-kernel-request@lists.infradead.org schreef:
> The s3c-hwmon driver depends on the arch/arm implementation of the core
> ADC support for the chip.  Since the S3C64xx version has not yet been
> merged disable building of the driver on S3C64xx for now.
>
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   drivers/hwmon/Kconfig |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4d0d0cd..87184b5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -684,7 +684,7 @@ config SENSORS_SHT15
>
>   config SENSORS_S3C
>   	tristate "S3C24XX/S3C64XX Inbuilt ADC"
> -	depends on ARCH_S3C2410 || ARCH_S3C64XX
> +	depends on ARCH_S3C2410
>   	help
>   	  If you say yes here you get support for the on-board ADCs of
>   	  the Samsung S3C24XX or S3C64XX series of SoC
> -- 1.6.4.3

Have you seen this?

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001787.html

Regards,

Maurus Cuelenaere


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
