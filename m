From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 20:50:34 +0000
Subject: Re: [lm-sensors] #2361: i2c and lm_sensors do not work on Slackware
Message-Id: <20081118215034.296cdbfa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <040.878a61a6a191c2ece367aefb3b3bc643@lm-sensors.org>
	<200811182017.43109.twinreverb@puresimplicity.net>
	<20081118170205.2c48d793@hyperion.delvare>
	<200811190443.42354.twinreverb@puresimplicity.net>
In-Reply-To: <200811190443.42354.twinreverb@puresimplicity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: twinreverb@puresimplicity.net
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Robert,

Please, pretty please, keep the lists Cc'd.

On Wed, 19 Nov 2008 04:43:39 +0900, Robert Delahunt wrote:
> Sir,
> 
> 	ACPI and lm_sensors are not the same concept or system.  ACPI is meant to 
> control power consumption.

Not really. ACPI is meant for so many things that it is difficult to
give a complete list. That's probably a key problem of ACPI: trying to
do too many things, it fails to do most things properly (or, in some
cases, BIOS authors fail to implement things properly.)

> lm_sensors is meant to simply show information.

Who decided this? The lm-sensors project goes well beyond just showing
information.

> These seem to get blurred in concept, however, at the Linux kernel.  If 
> anything, ACPI and lm_sensors should be working together (which they are).

No, they are (unfortunately) not. If they were, you wouldn't have
reported a bug, would you?

> However, their goals are not the same.  ACPI shouldn't be telling me 
> temperatures: that's the job of lm_sensors.  However, lm_sensors shouldn't be 
> setting fans and such: that's ACPI's job.

That's your (totally incorrect IMHO) view of the situation. The ACPI
people's view is that ACPI should be taking care of everything where
available and lm-sensors shouldn't be used. My own view is that ACPI
should either not touch hardware monitoring chips at all, or it should
drive them completely in a standard way. The current approach (each
BIOS author implements things his/her own often broken way and the OS
and user don't have their say) sucks.

So as you can see there are many ways to look at the problem. On top of
that, one technical issue is that "showing temperatures" and
"controlling fans" are in practice done by the same piece of hardware,
so claiming that lm-sensors should do one and ACPI the other is highly
impractical: if both access the hardware at the same time, havoc ensues.

> 	Much less on this chipset combination (see my lspci.txt) the system hardware 
> automatically schedules fans and such.

How do you know for sure? If I had to place a bet, I'd say that this is
in fact handled by your BIOS using SMM code. If I am right, then this
is one more reason to keep lm-sensors away from your hardware
monitoring chip.

>  You'd think that this means I don't 
> need ACPI, but instead lm_sensors.  However, to boot with acpi=off on this 
> machine results in your CD drive not being registered at all, regardless of 
> what the user does to try and manually tell the kernel that it exists.

See my rant above: the problem is that ACPI is doing way too many
unrelated things. This makes the acpi=off option pretty much useless.
You'd need an acpi=notherm option or some such, which unfortunately
doesn't exist. (Note that this wouldn't be enough if my assumption
about SMM is correct anyway.)

> 	I already spoke with khali and he and an ACPI developer on the linux kernel 
> team are working this issue.  I don't blame you guys: I blame ACPI.  However, 
> for now, we're stuck with it.  So at this point it becomes more of an 
> attitude check.  Do the developers try to fix something that they maintain, 
> or do they blame ACPI and move on?

Me, I blame ACPI (and SMM even more, and BIOS designers even more) and
move on. There's almost nothing that can be done, easy as that. The
best we can do is prevent lm-sensors from being used on systems where
it would break, and that's something we are (slowly) working on. Trying
to get lm-sensors and ACPI to cooperate beyond that has so little
chance of success that my time is much better spent on other tasks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
