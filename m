From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 09:01:29 +0000
Subject: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Message-Id: <20070227100129.fa962c81.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
	<20070226180635.GG2909@khazad-dum.debian.net>
In-Reply-To: <20070226180635.GG2909@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Henrique,

On Mon, 26 Feb 2007 15:06:35 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 26 Feb 2007, Jean Delvare wrote:
> > Either way, I do not think that knowing the last measured speed is that
> > useful. Given that it may be completely unrelated with the current
> 
> It is, actually, because it lets one mess with the embedded controller and
> completely override the fan control loop while not letting anyone else
> notice (i.e. without disturbing fan monitor applets, etc).
> 
> Check http://thinkwiki.org/wiki/Embedded_Controller_Firmware and
> http://thinkwiki.org/wiki/ACPI_fan_control_script if you are
> curious about the whys for these weird things.

I don't really have time for such long reads, sorry. If there's
anything in particular you think I should know, just tell me.

> > value, I'd rather return -ENXIO or -ERETRY if there is a reasonable
> > chance to get a valid reading soon after. If applications wants to
> 
> I will return the stale value or an error, then.  Not returning the stale
> value actually requires that I implement some sort of back/white lists to
> differentiate models which don't have the stale tachometer bug from those
> that do... or I need to detect that the tachometer seems to be stuck.

I see. In that case I am fine with you returning the stale value. After
all, the driver is supposed to return the value as read from the
hardware.

> > pwm#_enable = 0 means fan# at full speed, _not_ fan# stopped. Fan# stopped
> > is pwm#_enable = 1 and pwm# = 0.
> 
> The hwmon sysfs interface documentation is not clear on that.  Turning PWM
> off might lock the hardware into 0% duty or 100% duty depending on how it
> was designed.

Feel free to submit a patch improving the documentation.

> Anyway, I can map it to:
> 	pwm_enable = 0: disengaged mode on
> 		     1: manual mode on
> 		     2+: EC auto mode on (default)
> 
> no problem.
> (...)
> Ok. pwm = 0 in manual mode will stop fan, 1..255 will be mapped to 1..7 to
> select the thinkpad fan level, which the EC itself will map to (usually)
> three different speeds.

Yes, this looks good.

> BTW, ibm-acpi implements a "fan watchdog", to help fan-control userspace
> applications.  It resets the fan to a safe "on" mode if nothing tries any
> control operation on the fans in a given time period.
> 
> Is there any interest in trying for a fan-watchdog generic interface, or
> should I just implement that in sysfs as I see fit for ibm-acpi?

We don't have anything like that in the other drivers. I guess it only
applies to manual mode? The idea is interesting, I have to admit. I
don't have a particular opinion on how to implement that (specific vs
standard), do as you wish.

-- 
Jean Delvare

