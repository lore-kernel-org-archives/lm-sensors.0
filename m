From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jun 2008 12:21:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080608142151.59c0806d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Thu, 5 Jun 2008 18:05:56 +0100, Ben Hutchings wrote:
> Jean Delvare wrote:
> > It really depends on the board. A few boards initialize the limits
> > properly, but in general the user really wants to set them, or he/she
> > gets either spurious alarms or no alarms at all.
> 
> I have a hard time believing this because in my experience PCs normally
> shut down in case of an over-temperature alarm.

Have you experienced this often? It never happened to me personally but
my understanding is that the CPU will protect itself according to
hard-coded limits (unrelated to whatever hardware monitoring drivers
can be in used). On some systems ACPI or other BIOS code may write a
high CPU temperature limit to the hardware monitoring chip and expect an
interrupt if it is crossed (and will act upon it) but for the vast
majority of PC motherboards I've seen so far, nothing is done. Limits
of the hardware monitoring chips are either disabled or random, and
nothing happens when they are crossed (meaning that the user can set
them for fun but it's not really needed.) And the few motherboards
those BIOS sets a limit, set the CPU temperature limit and that's about
it. No voltage limits, no fan limits, and usually no care for system
temperature either.

I'm not saying that this shouldn't be done - I would love seeing BIOS
fully initializing the hardware monitoring chip. But that's not what I
have seen in the real world so far.

> > Why? In general, the limits and the alarms are informative only, and
> > nothing bad will happen if the limits aren't set immediately. So,
> > user-space has all the time to set the limits after the driver has been
> > loaded. All that matters is that the limits are set before the user
> > gets a chance to look at them.
> 
> The way this is supposed to work is that in case of a fault the hardware
> is shut down to prevent (further) damage.  For a PC motherboard the BIOS
> (possibly cooperating with the OS through ACPI) will do that.  In the case
> of our reference boards, we depend on either hard-wiring (SFE4001) or the
> driver (all others) to do this.

Can you describe the "hard wiring" in question? Does it mean that the
network adapter has the power to abruptly shut down the machine if any
limit is crossed? Meaning that the user could shut down the machine
just by playing with the limits?

Please also describe the software alternative. How do you plan to
implement this? I guess we want the user to be able to configure what
to do when a limit is crossed (depending on the event), much like we do
when a laptop or UPS gets low on battery. And if this is a pure
software implementation, then I guess it would make sense to make it
generic for all hardware monitoring chips, rather than specific to your
network adapter. If something of that kind does not already exist, that
is.

As a side note, I have to admit that I am very surprised to see that
level of hardware monitoring on network adapters. This seems redundant
with what the motherboard already offers, in particular for voltages
(you get them from the motherboard so they might as well be monitored
there.) I would understand a simple temperature sensor as some graphics
adapters do, but a full-featured hardware monitoring chip sounds
overkill.

> > You could make the configuration files available for download from your
> > web site directly (it really makes no sense to put these in RPMs), or
> > just ask for a wiki account on lm-sensors.org and upload them there.
> 
> I was assuming - not having looked - that we could install a configuration
> fragment into a directory which would then be included.  Now I see there
> is no support for that, either in the lm_sensors release nor Red Hat's
> packaging of it.

This is work in progress for a year now:
  http://www.lm-sensors.org/ticket/2174
But apparently Mark is too busy with real life to complete it. If more
daughter boards start including hardware monitoring chips, I agree that
this will become more needed.

>                   Also I see no provision for hotplug - so if a NIC is hot-
> swapped the new NIC won't have its limits initialised.

Good point. Hot-plugging of motherboard hardware monitoring chips has
never been an issue, obviously... But limits initialization is just one
of the problems here. libsensors scans for available hardware
monitoring chips at initialization time and will not be happy if a chip
goes away or is replaced with a different one. This didn't seem worth
working on so far, but maybe we'll have to look into it now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
