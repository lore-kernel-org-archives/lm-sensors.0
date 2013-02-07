From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 07 Feb 2013 09:00:52 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] ab8500_btemp: export two symblols
Message-Id: <CAJLyvQzTeOz2kh=DxyO=wCPnghoOSVF0eZFcPXXP0Jw68ctEiQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360149039-7038-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1360149039-7038-3-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anton and David,
Sorry there is a typo, symblols should be symbols, what's more I will
send v3 of this patch set, there should be more lines changed in this
ab8500_btemp.c, so let's focus on the coming v3 iteration.
Thanks.

On 6 February 2013 19:10, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> Export ab8500_btemp_get and ab8500_btemp_get_batctrl_temp, thus the ab8500
> hwmon driver can be compiled as module.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  drivers/power/ab8500_btemp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
> index 20e2a7d..852f14a8 100644
> --- a/drivers/power/ab8500_btemp.c
> +++ b/drivers/power/ab8500_btemp.c
> @@ -123,6 +123,7 @@ struct ab8500_btemp *ab8500_btemp_get(void)
>
>         return btemp;
>  }
> +EXPORT_SYMBOL(ab8500_btemp_get);
>
>  /**
>   * ab8500_btemp_batctrl_volt_to_res() - convert batctrl voltage to resistance
> @@ -774,6 +775,7 @@ int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp)
>  {
>         return btemp->bat_temp * 1000;
>  }
> +EXPORT_SYMBOL(ab8500_btemp_get_batctrl_temp);
>
>  /**
>   * ab8500_btemp_get_property() - get the btemp properties
> --
> 1.8.0
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
