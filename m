From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 Feb 2011 19:33:55 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110214193355.GD26577@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 14, 2011 at 02:05:57PM -0500, Matthew Garrett wrote:
> On Mon, Feb 14, 2011 at 11:01:33AM -0800, Guenter Roeck wrote:
> > On Mon, Feb 14, 2011 at 11:23:38AM -0500, Matthew Garrett wrote:
> > [ ... ]
> > > 
> > > It's often the case that fan control on these cards is handled by an 
> > > external hwmon chip, while the thermal diode is integrated into the chip 
> > > core and therefore only readable by the PCI driver. In that case we need 
> > > to be able to access the fan control registers. In other cases, cooling 
> > > is implemented passively by reducing the clock on the card. In those 
> > > cases the PCI driver needs to be able to obtain the temperature from 
> > > off-card chips. Whether you think the hardware approach sucks or not, 
> > > the reality is that we have plenty of devices where maanging the thermal 
> > > state of the hardware requires a single driver to be able to access both 
> > > PCI and i2c devices.
> > > 
> > So what you actually want to do is to implement fan control and/or, more
> > generically, power management, in the kernel. Fan control is so far implemented
> > in userland, the idea being that it is too complex and not well enough understood
> > to implement in the kernel.
> 
> The kernel has generic support for thermal management. Making it work 
> for any device is just a matter of a driver generating the appropriate 
> thermal and cooling devices and associating them. ACPI already works 
> this way.
> 
Not sure what you suggest here. Thermal devices register as hwmon devices
if so configured, so having hwmon devices register as thermal devices
would not work, at least not without some serious thought to prevent
registration loops.

If you are looking for thermal device support, maybe the drivers in question 
should be implemented as thermal device drivers and provide hwmon functionality
through the thermal subsystem. Did you consider that option ?

Do you plan to use/utilize the thermal subsystem, or do you plan to duplicate
that functionality in the GPU driver(s) ? Guess that was one of the reasons
why Jean asked for a use case of the proposed API.

If you plan to use the thermal subsystem without having to rewrite hwmon drivers,
did you consider means to interconnect the hwmon subsystem with the thermal subsystem,
eg by creating a means for hwmon devices to register as thermal devices ?

> > So one of the questions is why you can not keep it that way - and that might include
> > clock management if the required attributes are made available through sysfs.
> > Once the code is stable, and if there are good arguments to move the functionality
> > into the kernel, one may still consider doing it. By then we would hopefully 
> > also have a better understanding of requirements, such as if and to what degree 
> > interrupt and event handling support would be required, and how to organize 
> > and/or create necessary subsystems to be usable for everyone, not just for GPUs.
> 
> Because hardware control is the kernel's job, not userspace's. Having 
> hardware melt just because userspace fell off a cliff isn't acceptable.
> 
The same argument would apply to system fan control, doesn't it ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
