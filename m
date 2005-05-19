From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: i2c_force_data
Message-Id: <20041111083917.689150c9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109005252.GA26855@kroah.com>
In-Reply-To: <20041109005252.GA26855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> You can now add pci ids on the fly through sysfs, which causes drivers
> to accept new devices from what they were originally compiled with.
> 
> We're extending that logic to say, "try to bind this driver to that
> device" from userspace through sysfs, which should be sufficient to
> replace this force logic, right?

So basically we would load the driver first, it wouldn't recognize the
device at first, then we would write something to sysfs and the driver
would attempt to recognize the device again, successfully this time?

This matches the "force" module parameter we have pretty well. However
we also have e.g. force_w83782d, force_lm84 etc... which not only
forcibly bind a driver to a device, but also invite the driver to handle
that chip in a specific way. Will this be doable as well?

> > I'm more concerned about bus load. We have seen poor hardware
> > implementations and messy BIOSes causing SMBus locks on high load.
> > We don't want this to happen at boot time.
> 
> Hm, I'll have to think about this.  I really don't want a white/black
> list of busses that this will work on, as if you look at the kernel
> code today, we already scan all addresses for validity in i2c_detect()
> before handing off to the chip driver (yeah, that's a bit different
> from scanning all addresses, I agree, but conceptually it's the same.)

That's not quite what I was thinking about. My point was that
sensors-detect will issue dozens of register reads for each responsive
address, including several reads on the very same registers. This is
caused by a faulty design in the first place (well the script knew about
half a dozen client chips in the first place, and 85 now, that explains
it). For a family of chip we would need one detection function that
tells what the most likely chip of the family is. Instead we have one
function per chip type returning its own confidence value (zero for
almost all and non-zero for one or sometimes two). Each function is
probing the registers again, thus the bus load. This could be improved
by introducing a local cache of the registers, but this ain't trivial
either because some chips have "banks" which means that a given address
may be a different register next time you ask for it. Rewriting the
whole thing with a better design would probably be even better, but
sensors-detect is a very sensible piece of code and it simply seems that
nobody wants to take the risk.

The client drivers, in that respect, behave much better than
sensors-detect does.

The bus load issue in sensors-detect wasn't critical as long as it was a
stand-alone script meant to be run just once. Now that a similar action
is supposed to be taken on each boot (or bus driver load) this is a
different matter.

My proposal would be not to blacklist any bus, but to limit the bus
traffic we will be generating. One way to do that is to only support
autoloading of the easy-to-identify chips through the hotplug interface.
Recent chips have chip ID and manufacturer ID registers at relatively
standard locations. These can be easily identified. Older chips cannot
and we use bus-intensive, half-reliable heuristics to detect them. See
the CVS log of sensors-detect if you want to figure out how much I have
been refining detection heuristics in the last year. Maybe we don't want
to support such chips through hotplug.

> Wonder if we just sleep for a second or two between bus address
> probes, if that will help out or not :)

You must be kidding, right?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
