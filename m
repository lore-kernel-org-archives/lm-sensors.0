From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 11:21:15 +0000
Subject: [lm-sensors] Hardware monitoring support for SMSC 47M192/47M997
Message-Id: <MwESoPiv.1141039275.0012950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602270128360.3209@Laila>
In-Reply-To: <Pine.LNX.4.63.0602270128360.3209@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Harmut, Rudolf,

> >  I've seen a few inquiries about temperature and voltage
> > sensor support for the SMSC Super-I/O chips for 2.6 kernels,
> > but there was no clear statement about who is actually working
> > on that.
> >
> > While waiting for support, I tried to set up a driver myself,
> > and finally managed to produce the attached file 'smsc47m192.c'.
>
> Cool

Yes, this is good news. There have been a Linux 2.4 driver floating
around but it never made it into lm_sensors, and no 2.6 driver at all.

> > Linking this into the 2.6.15.1 kernel gives me access to
> > voltages and temperature readings in /sys/bus/i2c/devices/0-002d
> >
> > I have a Gigabyte K8U motherboard with SMSC 47M997 chip and would
> > be interested to hear whether this works anywhere else.
> >
> > The chip supports 8 voltage input channels:
> >         in0     +2.5V
> >         in1     VCCP (CPU supply voltage)
> >         in2     +3.3V
> >         in3     +5V
> >         in4     +12V
> >         in5     HVCC (supply voltage of the LPC47Mxxx chip)
> >         in6     +1.5V
> >         in7     +1.8V

I have never seen any chip monitoring +1.8V before. Do you know what it
is supposed to be wired to?

> > and 3 temperatures:
> >         temp1   remote diode sensor (probably on the CPU)
> >         temp2   local sensor (inside the 47Mxxx chip)
> >         temp3   second remote diode sensor (corresponds to
> >             'System temperature' on the K8U mainboard)
>
> Wore, leshaste
> Please can you test the hartmut work? If it works OK I can do the review.

It would be easier for everyone (i.e. testers and me) if Hartmut could
provide his work as a (unified, -p1) patch against some recent kernel
(2.6.15.1 will do).

A proper patch would add the new driver in drivers/hwmon, and alter
drivers/hwmon/Kconfig and drivers/hwmon/Makefile so that users can
select the new driver. It's quite easy, just make sure to keep things
in alphabetical order, and make the new driver depend on EXPERIMENTAL.

A documentation file (in Documentation/hwmon) would be welcome as well.
It can be made a separate patch.

> > There are also 2 registers which I called 'temp1_offset' and
> > 'temp3_offset'. They can be written with an offset which the chip adds
> > to the temperature readings temp1_input and temp3_input.
> > Not particularly useful as such, since adding an offset can easily
> > be done in software, but I found that it can be used in order to
> > identify which temperature readings correspond to CPU and System
> > temperatures as shown by the BIOS. When soft-booting into the
> > BIOS setup, the offsets are still active and I can see
> > which temperature is different from what it was before.

There's a more simple way to find out which input corresponds to the CPU
temperature. Just run some CPU-consumming task (e.g. "md5sum
/dev/zero"), the CPU temperature will usually rise much faster and
higher.

So if you implemented the feature only to serve this testing purpose, you
might want to drop it. So far, most other drivers have been assuming
that the BIOS was doing the right thing with offset registers so these
were not exposed to the user. The only exception is the adm1026 driver,
I think. If you still want to keep that feature, fine with me, but then
please extend Documentation/hwmon/sysfs-interface appropriately.

> Wow that is strange that BIOS is doing the computation that way. Never
> seen it like this.

As I understand it, the BIOS doesn't compute anything; the chip does.
The BIOS simply displays the value as returned by the chip, and this
include the fake offset value set by Hartmut for testing purpose.

> When done, please send us the sample sensors.conf.
>
> I would like to ask if you have some userspace support for lm-sensors done
> or not yet. Best would be if you can develop it too as far I remember
> there was none.

I remember the same. User-space support is a good way to find bugs in the
drivers, so it would be great to have it before the driver makes it into
the official kernel tree. Shouldn't be very difficult, it's mostly
copy'n'paste work. The adm1025 support could be used as an example,
although some parts may probably be improved.

Thanks,
--
Jean Delvare

