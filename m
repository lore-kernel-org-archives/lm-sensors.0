From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Thu, 28 Jun 2012 11:31:30 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FEC4092.7090104@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com> <20120627171505.GB12712@roeck-us.net> <4FEB90A8.8050901@googlemail.com> <20120628052032.GA16364@roeck-us.net>
In-Reply-To: <20120628052032.GA16364@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


> Do you mean sysfs ?
>   
Yeah, sorry. Everything under /sys/class/hwmon/...

> Correct. 1 is too low, though. Default value per datasheet is 0x80.
> Whatever it is, it should be high enough for the fans to start spinning.
>   
That won't be enough! I did a bit of experimenting and discovered the 
following:

The minimum value for pwm on all fans necessary to keep them going is 75 
(decimal) - below that value the fan just stops. The minimum value to 
kick-start the fan and make it spin from standstill is 190 (also 
decimal) - nothing below this value is sufficient to move the fan from 
its standstill position (in my script I use the maximum value - 255 - to 
be on the safe side).

So, even if I set the pwmX_auto_point5_pwm to 75 that won't be enough to 
kick-start the fan initially. On the other hand, if I set it to 190 that 
would be enough, but the fan will continue to spin at this rate which is 
very high (I may as well abandon fan/temperature management then).

> The F71882FG does not have a register to set a "start spinning" pwm value,
> so your minimum must guarantee that the fans do start to spin.
>
> What is your setting for pwmX_enable ? It should probably be set to
> automatic(2) so the chip can automatically control the fan speed depending
> on the temperature.
>   
It is indeed set to 2.

>> Even if I bring this value to some "idle" current, that won't help
>> much because when I first boot the system, the fans are *always*
>> still, so even if the idle state is >1, that won't help me much, so
>> there must be another - better - way than using a script to
>> "kickstart" the fans initially, surely!
>>
>>     
> Maybe fan control is not set to automatic by the BIOS ?
>   
It is and it is why I am keeping this automatic BIOS fan management in 
place and my script only intervenes to kick-start the fans when they are 
still, otherwise this automatic control is doing a good job. The problem 
is the actual kick-start (and the fact that there is no way I could 
force ACPI to abandon the region of memory used by the driver).


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
