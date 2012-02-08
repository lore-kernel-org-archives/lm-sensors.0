From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 18:53:51 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (f75375s) Fix reading of wrong register when initializing the F7
Message-Id: <1328727231.2261.322.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328723771-22163-3-git-send-email-mail@microschulz.de>
In-Reply-To: <1328723771-22163-3-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 12:56 -0500, Nikolaus Schulz wrote:
> From: Nikolaus Schulz <schulz@macnetix.de>
> 
> Unlike the other chips supported by this driver, the F75387 stores the
> pwm_mode in register F75375_REG_FAN_TIMER, not F75375_REG_CONFIG1.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> Cc: stable@kernel.org
> ---
>  drivers/hwmon/f75375s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index c81ad45..b3eef44 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -723,7 +723,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
>  			if (data->kind = f75387) {
>  				bool manu, duty;
>  
> -				if (!(conf & (1 << F75387_FAN_CTRL_LINEAR(nr))))
> +				if (!(mode & (1 << F75387_FAN_CTRL_LINEAR(nr))))
>  					data->pwm_mode[nr] = 1;
>  
>  				manu = ((mode >> F75387_FAN_MANU_MODE(nr)) & 1);

Applied.

This code was only added for 3.3, so the patch does not apply to stable,
only to 3.3-rc.

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
