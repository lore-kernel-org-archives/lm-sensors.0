From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <20030807000006.4c01841e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> No. They don't, they show up in /proc/device-tree (one at the root
> of the tree, the one in the northbridge, and one lower below,
> within the macio PCI asic)

Interesting. I would need a concrete example to figure that out
properly. When you say "device-tree", is it the real directory name
(never seen that in i386) or is it to be replaced by something else,
depending on the machine?

> > We don't really care for 2.6 for now. However, I think you tell me
> > the*driver* will be visible in /sys. What we are after is a way to
> > know when that driver is useful, before it is loaded.
> 
> The devices will be visible too, not only the driver

It's usable by us then. If I understand you correctly, it already shows
in 2.4, but will be different (and better) in 2.6?

> > I'm not sure I understand you at all there. What's the problem?
> > (Please note that I don't know anything about PPC, I'm just trying
> > to solve some problem our package has on Linux PPC.)
> 
> Well... those chips on the i2c bus, like thermal sensors, thermostats,
> fan controllers, clock generators, etc... are configured precisely by
> the firmware for a given motherboard, especially the thermal
> thresholds, for example, or the fan configuration & speed which may
> depend on the type of fans attached and the way the air flows in the
> enclosure, is something that I'd rather not touch without proper
> knowledge of the per-machine model details, which we don't have.

Our script only read values, so we are unlikely to break anything.

> The firmware is setting that up in some "sane" way, what else would
> you want to do?

I don't know about PPC, but in the i386 world, we want to set our own
temperatures and fan limits. I guess it's a bit different because all
the hardware for a given PPC system is known, so the fan speeds, normal
temperature etc. are known and not subject to change. Anyway, drivers
are still welcome so that you can at least read the temperatures values,
etc...

> > So, do you have some time for that? It may be easy for you since you
> > know the PPC world well. Feel free to refuse if you are busy though.
> 
> Not much time lately... isadump will not work, I suppose, because it
> does ioperm and in/out accesses from userland right ? You don't want
> to do that on most PPCs, beleive me ;) What kind of stuffs do you want
> that for anyway ?

Yes, I think it does. What made me wonder is that some comments in the
code reveal that the code is meant to be run on PPCs. For example,
__powerpc__ is checked twice. There also is a log entry that mentions
PPC support support.

On the other hand, I don't know if PPC even have an I2C bus. A PPC user
reported today that our sensors-detect script locks when it comes to ISA
chipsets detection. So, what should I know about PPC and the ISA bus?

My primary goal here is to allow PPC users to compile lm_sensors. For
now, they can't because at some point isadump fails to compile because
of a header issue (I think PPC has asm/io.h instead of sys/io.h, is that
it?) so I was wondering if we should simply disable the compilation of
this tool on PPC, or try to fix it.

Thanks for your help and time.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
