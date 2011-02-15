From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 15 Feb 2011 22:23:39 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <1297808619.24938.199.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-02-15 at 17:07 -0500, Jean Delvare wrote:
> On Mon, 14 Feb 2011 19:40:14 +0000, Matthew Garrett wrote:
> > On Mon, Feb 14, 2011 at 11:33:55AM -0800, Guenter Roeck wrote:
> > > On Mon, Feb 14, 2011 at 02:05:57PM -0500, Matthew Garrett wrote:
> > > > The kernel has generic support for thermal management. Making it work 
> > > > for any device is just a matter of a driver generating the appropriate 
> > > > thermal and cooling devices and associating them. ACPI already works 
> > > > this way.
> > > > 
> > > Not sure what you suggest here. Thermal devices register as hwmon devices
> > > if so configured, so having hwmon devices register as thermal devices
> > > would not work, at least not without some serious thought to prevent
> > > registration loops.
> > 
> > That's really an implementation detail - the worst case at present is 
> > that you'd end up with the same sensor providing data twice, but that's 
> > fixable.
> 
> I agree. I tend to believe that this approach would be superior to the
> initial proposal for the problem at hand. The few required hwmon
> drivers would simply register their temperature sensors as thermal
> zones, and their fan control outputs as cooling devices, to the thermal
> subsystem. This requires no change to the hwmon core, nor to all other
> individual hwmon drivers.
> 
> > > If you are looking for thermal device support, maybe the drivers in question 
> > > should be implemented as thermal device drivers and provide hwmon functionality
> > > through the thermal subsystem. Did you consider that option ?
> > 
> > We could definitely change the existing hwmon drivers to be thermal 
> > drivers instead, but not everything they do fits into that model.
> 
> Not instead. Additionally.
> 
> > > Do you plan to use/utilize the thermal subsystem, or do you plan to duplicate
> > > that functionality in the GPU driver(s) ? Guess that was one of the reasons
> > > why Jean asked for a use case of the proposed API.
> > 
> > Use the thermal subsystem. That's why I made the ACPI thermal code 
> > generic in the first place.
> 
> This sounds good.
> 
> > > If you plan to use the thermal subsystem without having to rewrite hwmon drivers,
> > > did you consider means to interconnect the hwmon subsystem with the thermal subsystem,
> > > eg by creating a means for hwmon devices to register as thermal devices ?
> > 
> > As I said, we could rework the hwmon drivers into thermal devices
> > instead, but we'd still need a mechanism for providing the thermal 
> > device back to the registering device.
> 
> Correct.
> 
> > > > Because hardware control is the kernel's job, not userspace's. Having 
> > > > hardware melt just because userspace fell off a cliff isn't acceptable.
> > > > 
> > > The same argument would apply to system fan control, doesn't it ?
> > 
> > Yes, which is why it belongs in the kernel.
> 
> The truth is IMHO more complex than this. I tend to believe that fan
> speed control (or more generally thermal management) can be implemented
> at different levels. Think about it, it's just like CPU frequency
> scaling. You have kernel governors and one user-space governor for
> people unhappy about the in-kernel ones and/or for hardware which can't
> be supported by these.
> 
> Ideally, thermal management would be implemented by the hardware, and
> neither the kernel drivers nor user-space should have to care. Less
> ideally, the kernel driver has to care, but has enough knowledge to do
> this by itself without user intervention. The worse case is where the
> kernel doesn't know and the user has to configure everything manually.
> This is the case of many PC motherboards out there, for which users
> rely on the user-space fancontrol script (or anything similar.) It can
> be pretty useful, but I still avoid when I can. And I definitely
> wouldn't recommend this approach for GPUs.
> 
> So I can envision a similarly layered thermal management logic, where
> the kernel drivers take care of what they have to and can handle, and
> leave the rest to user-space (as is already the case today.) In other
> words, please let me be clear that I have no objection to what Matthew
> and Martin are trying to achieve. My objections relate to the
> implementation and the way to submit it for review.

Same here.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
