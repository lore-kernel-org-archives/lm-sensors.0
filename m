From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 Feb 2011 21:25:15 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110214212515.GB27154@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 14, 2011 at 02:40:14PM -0500, Matthew Garrett wrote:
> On Mon, Feb 14, 2011 at 11:33:55AM -0800, Guenter Roeck wrote:
> > On Mon, Feb 14, 2011 at 02:05:57PM -0500, Matthew Garrett wrote:
> > > The kernel has generic support for thermal management. Making it work 
> > > for any device is just a matter of a driver generating the appropriate 
> > > thermal and cooling devices and associating them. ACPI already works 
> > > this way.
> > > 
> > Not sure what you suggest here. Thermal devices register as hwmon devices
> > if so configured, so having hwmon devices register as thermal devices
> > would not work, at least not without some serious thought to prevent
> > registration loops.
> 
> That's really an implementation detail - the worst case at present is 
> that you'd end up with the same sensor providing data twice, but that's 
> fixable.
> 
> > If you are looking for thermal device support, maybe the drivers in question 
> > should be implemented as thermal device drivers and provide hwmon functionality
> > through the thermal subsystem. Did you consider that option ?
> 
> We could definitely change the existing hwmon drivers to be thermal 
> drivers instead, but not everything they do fits into that model.
> 
> > Do you plan to use/utilize the thermal subsystem, or do you plan to duplicate
> > that functionality in the GPU driver(s) ? Guess that was one of the reasons
> > why Jean asked for a use case of the proposed API.
> 
> Use the thermal subsystem. That's why I made the ACPI thermal code 
> generic in the first place.
> 
Seems to me a better approach would then be to have hwmon temperature sensor drivers
register themselves as thermal drivers. Not that I would know how to do that,
though.

> > If you plan to use the thermal subsystem without having to rewrite hwmon drivers,
> > did you consider means to interconnect the hwmon subsystem with the thermal subsystem,
> > eg by creating a means for hwmon devices to register as thermal devices ?
> 
> As I said, we could rework the hwmon drivers into thermal devices
> instead, but we'd still need a mechanism for providing the thermal 
> device back to the registering device.
> 
Not sure I understand the second part. How do you do that today for ACPI 
thermal devices ?

> > > Because hardware control is the kernel's job, not userspace's. Having 
> > > hardware melt just because userspace fell off a cliff isn't acceptable.
> > > 
> > The same argument would apply to system fan control, doesn't it ?
> 
> Yes, which is why it belongs in the kernel.
> 
Accepted, but that implies a generic solution, not one restricted/limited to GPUs.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
