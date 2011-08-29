From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Aug 2011 09:08:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max16065) Fix current calculation
Message-Id: <20110829110835.5407b042@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314563645-12021-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314563645-12021-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Aug 2011 13:34:05 -0700, Guenter Roeck wrote:
> Current calculation is completely wrong. Add missing brackets to fix it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Candidate for stable (2.6.39+).
> 
>  drivers/hwmon/max16065.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
> index d94a24f..dd2d7b9 100644
> --- a/drivers/hwmon/max16065.c
> +++ b/drivers/hwmon/max16065.c
> @@ -124,7 +124,7 @@ static inline int MV_TO_LIMIT(int mv, int range)
>  
>  static inline int ADC_TO_CURR(int adc, int gain)
>  {
> -	return adc * 1400000 / gain * 255;
> +	return adc * 1400000 / (gain * 255);
>  }
>  
>  /*

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
