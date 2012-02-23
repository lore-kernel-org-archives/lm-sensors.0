From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Feb 2012 02:26:00 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enable
Message-Id: <20120223022600.GA5280@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-6-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-6-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 22, 2012 at 05:18:48PM -0500, Nikolaus Schulz wrote:
> From: Nikolaus Schulz <schulz@macnetix.de>
> 
> The F75387 supports automatic fan control using either PWM duty cycle or
> RPM speed values.  Make the driver detect the latter mode, and expose the
> different modes in sysfs as per pwm_enable, so that the user can switch
> between them.
> 
> The interpretation of the pwm_enable attribute for the F75387 is adjusted
> to be a superset of those values used for similar Fintek chips which do
> not support automatic duty mode, with 2 mapping to automatic speed mode,
> and moving automatic duty mode to the new value 4.
> 
> Toggling the duty mode via pwm_enable is currently denied for the F75387,
> as the chip then simply reinterprets the fan configuration register values
> according to the new mode, switching between RPM and PWM units, which
> makes this a dangerous operation.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> ---
>  drivers/hwmon/f75375s.c |   42 ++++++++++++++++++++++++++++++++++--------
>  1 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 3b06abf..29b11c6 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -266,6 +266,21 @@ static inline u16 rpm_to_reg(int rpm)
>  	return 1500000 / rpm;
>  }
>  
> +static bool duty_mode_enabled(u8 pwm_enable)
> +{
> +	switch (pwm_enable) {
> +	case 0: /* Manual, duty mode (full speed) */
> +	case 1: /* Manual, duty mode */
> +	case 4: /* Auto, duty mode */
> +		return true;
> +	case 2: /* Auto, speed mode */
> +	case 3: /* Manual, speed mode */
> +		return false;
> +	default:
> +		BUG();
> +	}
> +}

This keeps bugging me ... I think it would make sense to simplify it to

	return pwm_enable != 2 && pwm_enable != 3;

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
