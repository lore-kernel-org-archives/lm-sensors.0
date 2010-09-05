From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 05 Sep 2010 16:45:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (f75375s) Shift control mode to
Message-Id: <20100905184522.0825f390@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100903025459.GA15996@gaara.hadrons.org>
In-Reply-To: <20100903025459.GA15996@gaara.hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillem Jover <guillem@hadrons.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Guillem,

On Fri, 3 Sep 2010 04:54:59 +0200, Guillem Jover wrote:
> The spec notes that fan0 and fan1 control mode bits are located in bits
> 7-6 and 5-4 respectively, but the FAN_CTRL_MODE macro was making the
> bits shift by 5 instead of by 4.
> 
> Signed-off-by: Guillem Jover <guillem@hadrons.org>
> ---
>  drivers/hwmon/f75375s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 0f58ecc..e5828c0 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -79,7 +79,7 @@ enum chips { f75373, f75375 };
>  #define F75375_REG_PWM2_DROP_DUTY	0x6C
>  
>  #define FAN_CTRL_LINEAR(nr)		(4 + nr)
> -#define FAN_CTRL_MODE(nr)		(5 + ((nr) * 2))
> +#define FAN_CTRL_MODE(nr)		(4 + ((nr) * 2))
>  
>  /*
>   * Data structures and manipulation thereof

Good catch, patch applied, thanks.

Note though that it seems that this driver needs some more love in this
area. Struct f75375_data has a member fan_timer to which the contents
of register 0x60 (F75375_REG_FAN_TIMER) is written in
f75375_update_device(), but this value isn't used anywhere. Secondly,
struct member pwm_mode is _not_ initialized anywhere, although
show_pwm_mode() exports it to user-space. And member pwm_enable is
worse, the fans are set to full speed arbitrarily when the driver is
loaded (in function f75375_init()), which is bad practice. So there is
definitely room for cleanups and improvements, if you are interested in
this driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
