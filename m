From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 18:50:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (f75375s) Fix automatic pwm mode setting for F75373 & F75375
Message-Id: <1328727040.2261.320.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328723771-22163-2-git-send-email-mail@microschulz.de>
In-Reply-To: <1328723771-22163-2-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 12:56 -0500, Nikolaus Schulz wrote:
> From: Nikolaus Schulz <schulz@macnetix.de>
> 
> In order to enable temperature mode aka automatic mode for the F75373 and
> F75375 chips, the two FANx_MODE bits in the fan configuration register
> need be set to 01, not 10.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> Cc: stable@kernel.org
> ---
>  drivers/hwmon/f75375s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index eedf574..c81ad45 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -369,7 +369,7 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
>  			fanmode  |= (3 << FAN_CTRL_MODE(nr));
>  			break;
>  		case 2: /* AUTOMATIC*/
> -			fanmode  |= (2 << FAN_CTRL_MODE(nr));
> +			fanmode  |= (1 << FAN_CTRL_MODE(nr));
>  			break;
>  		case 3: /* fan speed */
>  			break;
Nice catch.

Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
