From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <1060206159.586.30.camel@gaston>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2003-08-06 at 21:44, Jean Delvare wrote:
> Hi Benjamin, thanks for the fast reply.
> 
> > > I would like to add support for the Keywest to our sensors-detect
> > > script. I wonder if I should add it to the detectable adapters list
> > > or to the undetectable adapters list. Is there any way to detect it?
> > > Usually, we detect the adapters by matching a given PCI
> > > manufacturer:device ID and function.
> > 
> > Hrm... On 2.4, it's not that simple, there can be 2 keywest
> > controllers, one on the northbridge, one on the southbridge, driving
> > various parts.
> 
> You don't really help me ;) Does it show in lspci or somewhere else?

No. They don't, they show up in /proc/device-tree (one at the root
of the tree, the one in the northbridge, and one lower below,
within the macio PCI asic)

> > With 2.6, these will be visible in sysfs once i'm done with the
> > porting of pmac drivers to the new model.
> 
> We don't really care for 2.6 for now. However, I think you tell me the
> *driver* will be visible in /sys. What we are after is a way to know
> when that driver is useful, before it is loaded.

The devices will be visible too, not only the driver

> Our scripts tries to identifiy what is present on i2c busses, so we have
> to load i2c bus drivers, such as i2c-keywest, at first. But we don't
> want to load all of them "just in case". We prefer being able to detect
> them, and load only these drivers.
> 
> > I'm not sure I like the idea of having drivers tapping things on those
> > i2c busses if those drivers aren't specially designed for the pmacs. I
> > hate the idea of something preventing proper cooling of the machine
> > and thus causing HW damage, or around those lines...
> 
> I'm not sure I understand you at all there. What's the problem? (Please
> note that I don't know anything about PPC, I'm just trying to solve some
> problem our package has on Linux PPC.)

Well... those chips on the i2c bus, like thermal sensors, thermostats,
fan controllers, clock generators, etc... are configured precisely by
the firmware for a given motherboard, especially the thermal thresholds,
for example, or the fan configuration & speed which may depend on the
type of fans attached and the way the air flows in the enclosure, is
something that I'd rather not touch without proper knowledge of the
per-machine model details, which we don't have.

THe firmware is setting that up in some "sane" way, what else would
you want to do ? For a couple of machines, I do have some experimental
drivers that will do "smoother" fan management (avoiding them to be
always full speed on some G4 towers), but those were done after
reverse engineering the precise thresholds & values used by MacOS
on these models.

> > > Also, since you seem to have much knowledge about Linux PPC, maybe
> > > you could help us on another problem. We have some dump tools that
> > > come with the lm_sensors package, and one of them, isadump, doesn't
> > > seem to compile on PPC. Could you take a look and tell us if you
> > > know how to fix it? Or maybe this tool is of no use on PPC systems?
> 
> So, do you have some time for that? It may be easy for you since you
> know the PPC world well. Feel free to refuse if you are busy though.

Not much time lately... isadump will not work, I suppose, because it
does ioperm and in/out accesses from userland right ? You don't want
to do that on most PPCs, beleive me ;) What kind of stuffs do you want
that for anyway ?


Ben.

