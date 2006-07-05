From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Wed, 05 Jul 2006 13:58:16 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
Message-Id: <20060705135816.GA8452@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <20060704162346.GE9447@khazad-dum.debian.net> <20060704235717.GD11872@elf.ucw.cz> <20060705073455.GA6027@suse.cz>
In-Reply-To: <20060705073455.GA6027@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>

On Wed, 05 Jul 2006, Vojtech Pavlik wrote:
> > > I don't know about AMS, but talking to HDAPS when
> > > you don't need to does waste enough system resources and power to actually
> > > justify implementing this.
> 
> I'd doubt any of the accelerometer implementations would consume much
> power or CPU.

It is not just CPU or power, although IMO striving for perfection on power
management in a laptop is almost always a good thing if it can be done
safely.

HDAPS talks to the embedded controller using IO over the LPC bus, and not to
the accelerometer chip or to a simple A/D i2c chip which is used excusively
for accelerometer access.  The EC interface for HDAPS data retrieval is
not friendly to any errors, and hardlocks the machine somehow if any
firmware bugs hit or if we violate any of the rules (that are not written
anywhere) about how to access the EC without geting the SMBIOS unhappy.

So, turning off HDAPS polling while it is not necessary really looks like a
good idea overall.

We are investigating the ACPI global lock as a way to at least get the
SMBIOS to stay away from the EC while we talk to it, but we don't know if
the entire SMBIOS firmware respects that lock.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

