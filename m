From: Ben Hutchings <bhutchings@solarflare.com>
Date: Sun, 08 Jun 2008 16:13:09 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080608161307.GV11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben,
> 
> On Thu, 5 Jun 2008 18:05:56 +0100, Ben Hutchings wrote:
> > Jean Delvare wrote:
> > > It really depends on the board. A few boards initialize the limits
> > > properly, but in general the user really wants to set them, or he/she
> > > gets either spurious alarms or no alarms at all.
> > 
> > I have a hard time believing this because in my experience PCs normally
> > shut down in case of an over-temperature alarm.
> 
> Have you experienced this often?

I have when using inadequate cooling on PCs I assembled myself.

[...]
> > The way this is supposed to work is that in case of a fault the hardware
> > is shut down to prevent (further) damage.  For a PC motherboard the BIOS
> > (possibly cooperating with the OS through ACPI) will do that.  In the case
> > of our reference boards, we depend on either hard-wiring (SFE4001) or the
> > driver (all others) to do this.
> 
> Can you describe the "hard wiring" in question? Does it mean that the
> network adapter has the power to abruptly shut down the machine if any
> limit is crossed? Meaning that the user could shut down the machine
> just by playing with the limits?

The SFE4001 has one of the hardware monitor's interrupt lines wired into
the IO-expander that controls power to the PHY.

> Please also describe the software alternative. How do you plan to
> implement this?

If the hardware monitor raises an interrupt, turn off or reduce power to
the PHY and disable the port.  This is already implemented for the
SFE4002 in our out-of-tree driver.

[...]
> As a side note, I have to admit that I am very surprised to see that
> level of hardware monitoring on network adapters. This seems redundant
> with what the motherboard already offers, in particular for voltages
> (you get them from the motherboard so they might as well be monitored
> there.)

PCI Express only supplies 12V and 3.3V.  Everything else has to be
converted from those.

> I would understand a simple temperature sensor as some graphics
> adapters do, but a full-featured hardware monitoring chip sounds
> overkill.

Well, it's there on the SFE4002 and you already wrote most of the
necessary code to support it, so...

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
