From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jun 2012 05:20:32 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <20120628052032.GA16364@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com>
 <20120627171505.GB12712@roeck-us.net>
 <4FEB90A8.8050901@googlemail.com>
In-Reply-To: <4FEB90A8.8050901@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, Jun 28, 2012 at 12:00:56AM +0100, Michael Zintakis wrote:
> Hello Guenter and All,
> 
[ .. ]

> One last question (though this is more specific to the f71882fg
> driver): I have a procfs file called "pwmX_auto_pointY" (Y being

Do you mean sysfs ?

> from 1-5), which indicates the various pwm current value which is to
> be applied for different points: 4 being when the controlling
> temperature is low (the value of pwmX_auto_point4_temp to be
> precise) and 1 being where the current is at its maximum - normally
> 255.
> 
> Now, what is the purpose of pwmX_auto_point5 - does this hold the
> pwm value where the fan is in an idle state (i.e. the temperature is
> below pwmX_auto_point4_temp)? Because on all 3 fans, I have this set
> to 1, which, I am assuming is when the fans are stopped.
> 
Correct. 1 is too low, though. Default value per datasheet is 0x80.
Whatever it is, it should be high enough for the fans to start spinning.
The F71882FG does not have a register to set a "start spinning" pwm value,
so your minimum must guarantee that the fans do start to spin.

What is your setting for pwmX_enable ? It should probably be set to
automatic(2) so the chip can automatically control the fan speed depending
on the temperature.

> Even if I bring this value to some "idle" current, that won't help
> much because when I first boot the system, the fans are *always*
> still, so even if the idle state is >1, that won't help me much, so
> there must be another - better - way than using a script to
> "kickstart" the fans initially, surely!
> 
Maybe fan control is not set to automatic by the BIOS ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
