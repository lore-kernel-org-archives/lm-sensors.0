From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Oct 2007 15:16:39 +0000
Subject: Re: [lm-sensors] Compaq EVO W8000 Sensor/Chip Support
Message-Id: <20071017171639.200c4201@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
In-Reply-To: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg, Keith,

> On Tue, 2007-10-16 at 19:33 -0700, Juerg Haefliger wrote:
> > Hmm... Don't count on it. I'm not sure how safe it is to unhide things...

Depends on how old the hardware is, and what the BIOS is doing. Keith's
system seems to be relatively old so it may be safe. On more recent
systems it's more risky.

The first thing to check is the ACPI DSDT table. If it somehow accesses
the SMBus I/O ports (0xfc00-0xfc1f) then unhiding the SMBus is a bad
idea. Keith, can you please send your DSDT table to Juerg and myself in
private?

You can also try loading the ACPI "fan" and "thermal" drivers, and see
if anything interesting shows up in /proc/acpi/fan
and /proc/acpi/thermal_zone, respectively. If nothing shows up, chances
are good that ACPI isn't making use of the ADM1023 chips.

Lastly, you should also pay attention to the ADM1023 limits. If you see
them change magically, this means that the BIOS is using the ADM1023
chips somehow. If this happens, then it's not safe to unhide the SMBus.

I can't help but notice that the CPU temperature limit is set to 61
degrees C which is _not_ the chip default according to the datasheet -
so this suggests that the BIOS has set this limit at boot time.
Although this doesn't imply that it's touching the chip after that.

If you go through all these tests and nothing suspect shows up, then we
can patch the kernel to unhide the SMBus automatically on your
system... Although it might not be easy because not many PCI devices
have a sub-ID on your system.

On Wed, 17 Oct 2007 06:42:57 -0600, Keith Romberg wrote:
> So far things are stable under continuous changing load over 12 hours
> now.  I am sure the reason why Compaq hide the sensors/chips/buses is
> that they want the 'customer' to use their crappy system management
> software.

That's possible, yeah.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
