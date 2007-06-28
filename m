From: "Voipio Riku" <Riku.Voipio@movial.fi>
Date: Thu, 28 Jun 2007 23:10:03 +0000
Subject: Re: [lm-sensors] Subject: hwmon: Improve the pwmN_enable
Message-Id: <55662.80.222.56.248.1183072203.squirrel@webmail.movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Riku,
>
> On Wed, 27 Jun 2007 16:23:52 +0300, Riku Voipio wrote:
>> Jean Delvare wrote:
>> > Sounds like a bug in the driver then. Setting pwm1_enable to 0 should
>> > turn the fan to full speed.
>>
>> The sysfs interface states that pwm_enable to 0 turns off pwm control...
>> How would that turn fans to full speed?
>
> I agree that Documentation/hwmon/sysfs-interface is particularly
> confusing. I thought we had fixed it, but it seems not. What about the
> following patch?

Looks good for me. Thanks.

> * * * * *
>
> The documentation of the pwmN_enable interface file is not very clear,
> and has been confusing several driver authors already. Make it clearer.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/sysfs-interface |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> --- linux-2.6.22-rc6.orig/Documentation/hwmon/sysfs-interface	2007-06-27
> 21:08:40.000000000 +0200
> +++ linux-2.6.22-rc6/Documentation/hwmon/sysfs-interface	2007-06-27
> 21:21:57.000000000 +0200
> @@ -172,11 +172,10 @@ pwm[1-*]	Pulse width modulation fan cont
>  		255 is max or 100%.
>
>  pwm[1-*]_enable
> -		Switch PWM on and off.
> -		Not always present even if pwmN is.
> -		0: turn off
> -		1: turn on in manual mode
> -		2+: turn on in automatic mode
> +		Fan speed control method:
> +		0: no fan speed control (i.e. fan at full speed)
> +		1: manual fan speed control enabled (using pwm[1-*])
> +		2+: automatic fan speed control enabled
>  		Check individual chip documentation files for automatic mode
>  		details.
>  		RW
>
> Thanks,
> --
> Jean Delvare
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
