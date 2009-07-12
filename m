From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Jul 2009 17:59:11 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <20090712195911.5c09a582@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tobias,

On Sun, 12 Jul 2009 19:20:41 +0200, Tobias Hain wrote:
> Hello all,
> 
> Jean Delvare wrote:
> 
> > lu zhihe wrote:
> >
> >> +static unsigned long chipset_ids[] = {
> >> +	PCI_DEVICE_ID_INTEL_82965GM,
> >> +	PCI_DEVICE_ID_INTEL_82965GME,
> >> +	0
> >> +};
> >
> > I am also curious what these PCI devices are. We do not want to have
> > driver conflicts, so it might make more sense to add hardware
> > monitoring functionality to an existing driver than writing a brand new
> > driver.
> 
> He is talking to the Host Bridge Device 0 (D0:F0) of the Mobile Intel 965
> Express Chipset. This includes the following intel chipsets:
> PM965/GM965/GL960/GME965/GLE960. Basically the Santa Rosa chipset
> northbridges.
> 
> This northbridges does have two temperature sensors according to the intel
> spec (316273.pdf). He's reading one of the sensors and displaying its
> temperature. I've tested the coded on my GM965 and it reports meaningful
> values. I also put the northbridge under load (shared graphics) and its
> temperature rises.
> 
> I see that other chipsets although southbridges also have their own  driver
> e.g. SENSORS_VIA686A. To me it makes perfectly sense to put a hwmon driver
> for intel MCH here and nowhere else.

And the via686a happens to be one of these drivers which caused trouble
in the past because other drivers would also bind to the same PCI
device and the first one would win. We have worked around this since
then, by not letting the driver bind to the device, but this is not
clean. I'd rather avoid having more drivers like that.

> Even if other parts of the kernel touch
> the same device, their functions should be orthogonal.

It's not a question whether functions are orthogonal. It's a limitation
of the device driver model to only let one driver bind to a given
device at any given time. Hardware vendor should use PCI function
numbers for separate functions, when they do there is no problem. But
VIA usually doesn't.

> If you look at the
> VIA686A again: You wouldn't remove the driver from here just because the ATA
> component of the same device is used by the libata drivers.

There's a big difference between the VIA 686 and the Intel 965: the
VIA 686 embeds a full hardware monitoring component for fans,
temperatures and voltages. The Intel 965 on the other hand simply has
one or maybe two temperature sensors. It is not a hardware monitoring
chip. So while I wouldn't want to hide the hardware monitoring support
of the VIA 686 in another driver, I would be totally fine with adding
temperature reporting to whatever driver is already handling the Intel
965. At this point I still believe this is the way to go.

> The intel Montevina (Centrino 2) platform comprised of GM45/GL40/GS45/PM45
> also features the same registers and likely works with this driver (once
> hardware support is extended to device id 0x2E10h, 2E20h, 2E30h, 2E40h,
> 2E90h).
> 
> All those are intel MCH (memory controller hub) north bridges. Some feature
> a graphics engine - some not (such as PM965/PM45). I can't tell yet whether
> for all those devices the sensors deliver meaningful values, but they
> feature the same registers and documentation. However the hwmon module
> shouldn't be called gm965temp in this case. I suggest something more general
> like "imhc" to express "intel memory controller hub" and the documentation
> to this module should refine for which chipsets support has been added and
> tested.

"imhc" is as cryptic as you can think, I don't like it, while
"gm965temp" was much clearer (if we really want a separate driver.)
There is no problem naming a driver after the first device it supports,
actually this is the case of almost all hardware monitoring drivers.

> Intel desktop Series 3 and 4 also feature similar temperature measurement
> facilities. Slightly different registers (see TSTTP), but given that they
> also report meaningful values those could be added to this driver in future.

Thanks for all the information.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
