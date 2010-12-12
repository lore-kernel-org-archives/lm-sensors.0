From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Dec 2010 21:38:20 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: sysfs ABI updates
Message-Id: <20101212223820.41bcb18d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1291936455-6195-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1291936455-6195-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 9 Dec 2010 15:14:15 -0800, Guenter Roeck wrote:
> Add attributes supported by various PMBus devices to hwmon sysfs ABI.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> The proposed additional attributes reflect the functionality provided by the
> upcoming PMBus driver. I figured it makes sense to submit those now so I can
> adjust the driver as needed.
> 
>  Documentation/hwmon/sysfs-interface |   39 ++++++++++++++++++++++++++++++----
>  1 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 6456990..2b8737b 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -384,6 +384,14 @@ curr[1-*]_min	Current min value.
>  		Unit: milliampere
>  		RW
>  
> +curr[1-*]_lcrit	Current critical low value
> +		Unit: milliampere
> +		RW
> +
> +curr[1-*]_crit	Current critical high value.
> +		Unit: milliampere
> +		RW
> +
>  curr[1-*]_input	Current input value
>  		Unit: milliampere
>  		RO
> @@ -450,11 +458,12 @@ power[1-*]_accuracy		Accuracy of the power meter.
>  				Unit: Percent
>  				RO
>  
> -power[1-*]_alarm		1 if the system is drawing more power than the
> -				cap allows; 0 otherwise.  A poll notification is
> -				sent to this file when the power use exceeds the
> -				cap.  This file only appears if the cap is known
> -				to be enforced by hardware.
> +power[1-*]_alarm		1 if the system is drawing more power than cap
> +				or max allows; 0 otherwise.  A poll notification
> +				is sent to this file when the power use exceeds
> +				the cap or max limit. If only cap is supported,
> +				this file only appears if the cap is known to be
> +				enforced by hardware.

The last sentence seems unneeded and confusing to me. Obviously the
file is present if and only if the hardware can report that the limit
(whatever it is) has been exceeded.

Also, I fail to see why power[1-*]_crit couldn't trigger the alarm too.

>  				RO
>  
>  power[1-*]_cap			If power use rises above this limit, the
> @@ -479,6 +488,18 @@ power[1-*]_cap_min		Minimum cap that can be set.
>  				Unit: microWatt
>  				RO
>  
> +power[1-*]_max			Maximum power.
> +				Unit: microWatt
> +				RW
> +
> +power[1-*]_crit			Critical maximum power.
> +				If power rises to or above this limit, the
> +				system is expected take drastic action to reduce
> +				power consumption, such as a system shutdown or
> +				a forced powerdown of some devices.
> +				Unit: microWatt
> +				RW
> +
>  **********
>  * Energy *
>  **********
> @@ -501,6 +522,7 @@ implementation.
>  
>  in[0-*]_alarm
>  curr[1-*]_alarm
> +power[1-*]_alarm

Well well. If it's there, there's little reason to document it
verbosely above, is there? After all, it's just an alarm attribute as
every other.

>  fan[1-*]_alarm
>  temp[1-*]_alarm
>  		Channel alarm
> @@ -512,12 +534,19 @@ OR
>  
>  in[0-*]_min_alarm
>  in[0-*]_max_alarm
> +in[0-*]_lcrit_alarm
> +in[0-*]_crit_alarm
>  curr[1-*]_min_alarm
>  curr[1-*]_max_alarm
> +curr[1-*]_lcrit_alarm
> +curr[1-*]_crit_alarm
> +power[1-*]_max_alarm
> +power[1-*]_crit_alarm
>  fan[1-*]_min_alarm
>  fan[1-*]_max_alarm
>  temp[1-*]_min_alarm
>  temp[1-*]_max_alarm
> +temp[1-*]_lcrit_alarm
>  temp[1-*]_crit_alarm
>  temp[1-*]_emergency_alarm
>  		Limit alarm

The rest looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
