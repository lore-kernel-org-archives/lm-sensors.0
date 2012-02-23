From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Feb 2012 02:27:22 +0000
Subject: Re: [lm-sensors] [PATCH 6/6] hwmon: (f75375s) Catch some attempts to write to r/o registers
Message-Id: <20120223022722.GB5280@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-7-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-7-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 22, 2012 at 05:18:49PM -0500, Nikolaus Schulz wrote:
> It makes no sense to attempt to manually configure the fan in auto mode,
> or set the duty cycle directly in closed loop mode.  The corresponding
> registers are then read-only.  If the user tries it nonetheless, error out
> with EBUSY instead of silently doing nothing.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> ---
>  drivers/hwmon/f75375s.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 29b11c6..0e7fe3a 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -281,6 +281,21 @@ static bool duty_mode_enabled(u8 pwm_enable)
>  	}
>  }
>  
> +static bool auto_mode_enabled(u8 pwm_enable)
> +{
> +	switch (pwm_enable) {
> +	case 0: /* Manual, duty mode (full speed) */
> +	case 1: /* Manual, duty mode */
> +	case 3: /* Manual, speed mode */
> +		return false;
> +	case 2: /* Auto, speed mode */
> +	case 4: /* Auto, duty mode */
> +		return true;
> +	default:
> +		BUG();
> +	}
> +}
> +
Same as the other one ...

	return pwm_enable = 2 || pwm_enable = 4;

would be much simpler.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
