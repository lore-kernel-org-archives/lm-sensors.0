From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 03 May 2007 17:51:14 +0000
Subject: Re: [lm-sensors] [PATCH 3/9] ACPI: thinkpad-acpi: fix a fan
Message-Id: <20070503175114.GH12292@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <11777220172751-git-send-email-hmh@hmh.eng.br> <11777220173445-git-send-email-hmh@hmh.eng.br> <1178211621.1231.818.camel@queen.suse.de>
In-Reply-To: <1178211621.1231.818.camel@queen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

(adding lm-sensors to the cc list)

On Thu, 03 May 2007, Thomas Renninger wrote:
> I didn't have a closer look to the fan watchdog, but it looks like a
> ThinkPad specific thing?

The fan watchdog could be generic and done for any driver that knows how to
set a fan to a default, "safe" state even during a temperature-zone-
is-critical situation (i.e. the driver must know enough to never slow down a
fan that has been kicked into emergency mode, if a fan watchdog
functionality is to be safe).

The hwmon interface and sysfs glue could indeed be generic, and need just
one callback to the driver-specific code.  If a fan control chip or firmware
can do it in hardware, the callback programs the hardware.  If it is done in
software by the driver, the callback schedules the watchdog task.

> IMO we could need some general fan watchdog as fans are breaking away
> here and there.
> Latest reports came from HPs and FSC models ...

It won't help if the breakage is due to the driver not being able to
communicate with the fan properly, but it would help very much so if it is
caused by something else that keeps turning the fan off.

I don't know how well it would work with a generic ACPI framework for fans,
given that the ACPI control model for fans is braindead (no fan speed
control or tachometer reading support -- that was an extreme oversight) and
not really trustable in the last crop of crap the laptop vendors are pushing
out as DSDTs.

We'd need a rearming watchdog for what you want, though.  The one I added
for thinkpad-acpi/ibm-acpi is a single-fire one that doesn't rearm, as it
targets userspace fan control applications that die or get stuck (userspace
fan control applications *are* quite popular in T4x ThinkPads both in Linux
and Windows).  It would be simple enough to add a "fan_watchdog_rearm"
attribute that is set to either zero (don't rearm) or one (rearm), and that
is less confusing than, e.g. using negative numbers for one sort of watchdog
and positive numbers for the other sort.

> A check whether the fan/power resource is still in the assumed state
> or whether something changed it behind the back is a general good idea?

That is a future feature I was thinking about adding to thinkpad-acpi, so I
vote yes for machines in which we can trust the firmware.

It would easily belly-flop the kind of crap people are delivering on laptop
DSDTs nowadays, though...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
