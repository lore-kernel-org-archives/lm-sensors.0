From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 17:44:12 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207174412.GA2452@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Mon, Feb 07, 2011 at 11:50:48AM -0500, Andrew Lutomirski wrote:
[ ... ]
> >
> > So what you'll have to do is to set a minimum speed, and the problem will go away.
> 
> I admit I'm a bit confused as to what fan2_min does.  I have a minimum
> (to warn?) fan speed set in BIOS, which seems to have nothing to do
> with the initial value of fan2_min.  Changing fan2_min will cause
> fan2_alarm to become set or unset, when I decrease min below input,
> alarm stays set until I read it once.
> 
Interesting; it means that it works, but the BIOS seems to use another set
of registers to set the minimum speed.

> This is rather curious -- it means that the sequence:
> echo 200 >fan2_min
> echo 100 >fan2_min
> cat fan2_input
> cat fan2_alarm
> 
> shows alarm=0 but
> 
> echo 200 >fan2_min
> echo 100 >fan2_min
> cat fan2_alarm
> cat fan2_input
> 
> shows alarm=1
> 
> In any case, what does alarm (and, hence, min) do?  Userspace can
> compare two numbers on its own, but no uevent seems to be generated
> when an alarm is hit.
> 

The driver simply reports what it gets from the real-time status monitoring
registers.

It might make sense to improve the code to report interrupt status bits instead,
and even better to actually handle interrupts and report status changes via udev.
But that goes a bit beyond of adding support for a couple of new chips ...

Linking of alarm status changes with udev events has only just recently been
considered, and is currently only supported for GPIO fans. For the most part,
hwmon depends on polling to detect alarm conditions. This is defintely something
to be considered as an improvement to the hwmon subsystem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
