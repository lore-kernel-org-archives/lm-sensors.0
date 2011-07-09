From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Jul 2011 06:51:24 +0000
Subject: Re: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch in mutex
Message-Id: <20110709085124.401dba10@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310129879-4748-1-git-send-email-premi@ti.com>
In-Reply-To: <1310129879-4748-1-git-send-email-premi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sanjeev Premi <premi@ti.com>
Cc: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org

On Fri, 8 Jul 2011 18:27:59 +0530, Sanjeev Premi wrote:
> A mutex is locked on entry into twl4030_madc_conversion().
> Immediate return on some error conditions leaves the
> mutex locked.
> 
> This patch ensures that mutex is always unlocked before
> leaving the function.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> ---
> 
>  Compile tested only.
> 
> 
>  drivers/mfd/twl4030-madc.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> index 3941ddc..b5d598c 100644
> --- a/drivers/mfd/twl4030-madc.c
> +++ b/drivers/mfd/twl4030-madc.c
> (...)

Wrong list. This isn't a hwmon driver, so lm-sensors isn't suitable.
scripts/get_maintainer.pl says that you should send this patch to:
Samuel Ortiz <sameo@linux.intel.com>

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
