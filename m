From: Lucas Stach <dev@lynxeye.de>
Date: Mon, 28 Feb 2011 17:50:45 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <1298915445.5974.18.camel@workstation>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,
 
let me revive this discussion a bit. After reading some things about the
matter I think the way to go is to use Intels thermal framework. It
should be easy to add the needed temp_get and fan_set functions to the
affected hwmon drivers. 

But then one problem still persists: when the hwmon driver probes a
device it automatically creates the sysfs entries. This is unintended
behaviour from nouveau's point of view. The sensor value is not the real
temperature value; it has to be scaled with some factor and an offset
hard-coded in the video bios tables. This scaling could only be done on
nouveau's side, so the hwmon driver is exposing an interface with wrong
values to the userspace.

We need a way to use the hwmon i2c driver without exposing this
interface. Do you have any preferred way how we could achieve this?

I see two ways to do this:
1. Sort out if we need the sysfs entries in the probe function. This
could be done with some name postfix in the board_info. Downside: adds
some noise to this function.

2. Creating a new module which only exposes the thermal framework API.
This leads to code duplication and we end up with two drivers for the
same i2c monitoring chip. On the other hand this _could_ lead to cleaner
code and we could move this part to drivers/thermal instead of
drivers/hwmon. I don't like the code duplication, do you see any chance
to avoid this in case this is the way to go?

Please comment on my thoughts, we need your feedback to bring up an API
everyone could agree on. I'm willing to hack together a prototype over
the next week, but want to avoid running in a completely wrong
direction.

-- Lucas

Am Sonntag, den 13.02.2011, 23:08 +0100 schrieb Jean Delvare:
> On Sun, 13 Feb 2011 09:16:40 -0800, Guenter Roeck wrote:
> > On Sun, Feb 13, 2011 at 07:18:44AM -0500, Martin Peres wrote:
> > > Hi,
> > > 
> > > I am working on power management on the nouveau driver and I need a way 
> > > to get data out of and send commands to the i2c drivers from the kernel 
> > > space.
> 
> Why? You already have a way to get data out of and send commands to the
> I2C devices themselves (Using the i2c_smbus_* functions). Why do you
> insist on going through the I2C device drivers?
> 
> > > We can already change the clocks of the card, but we need a way to 
> 
> How is this relevant to the discussion? Are the clock chips connected
> to the I2C bus too?
> 
> > > monitor the temperature and bump the fan speed if needed.
> 
> Hardware is very badly designed if the driver actually has to take care
> of this. Thermal management should be handled by the hardware directly.
> And as a matter of fact, the Analog Devices ADT7473 and the Fintek
> F75375S support this.
> 
> > > Another problem with letting users mess with the i2c driver by 
> > > themselves is that some cards use the i2c driver for fan management 
> > > while others don't. This is why I would like to introduce nouveau as an 
> 
> I guess you mean I2C device, not i2c driver. You will have to be
> precise in your wording if you want others to understand where you are
> going.
> 
> When the I2C device isn't used for fan management, how is it done?
> 
> > > hwmon driver, exporting the temperature, fan management and clock speeds 
> > > so as we can use the thermal zone to monitor the temperature and react 
> > > when needed.
> 
> It only makes sense to instantiate a hwmon device from nouveau directly
> if the temperature sensor or the fan management is _not_ done by an I2C
> device. So it seems unrelated with your patch. Why are you mentioning
> it then?
> 
> And clock speeds don't have anything to do with hwmon, BTW.
> 
> > > So far, we use:
> > > - w83l785ts
> > > - w83781d
> > > - adt7473 (most common one)
> > > - f75375
> > > - lm99
> > > 
> > > With the help of Matthew Garret, I updated his previous proposal for an 
> > > in-kernel API for hwmon. The patch should apply cleanly on Linux 
> 
> I can't remember this proposal. A link would be appreciated.
> 
> > > 2.6.38-rc4. This patch only provides the API, no modification to the 
> > > drivers has been completed yet.
> 
> Do you mean that you don't have the code at all yet, or that you did
> not include it in this patch set? Either way, this is wrong. There is
> no point in asking for a review of only half of your solution. We can't
> comment on the relevance of your proposal without seeing how you intend
> to use it.
> 
> > > Looking forward to your review and feedback.
> 
> I have no plan to review your patch, sorry. You did not provide a
> proper description of your problem, and you didn't explain why it can't
> be solved with the current kernel infrastructures. Worse, you propose a
> brand new hwmon subsystem, but you don't even provide a description of
> its design, let alone an explanation of why you think this design is
> appropriate. And you don't show us code using it either.
> 
> All I can say after a quick look at the patch, is that you are
> overengineering a lot. You have enumerated all sensor properties which
> exist, and are trying to handle all sensor types. You have a specific
> need (thermal management of graphics cards), but you are already trying
> to provide a generic access to all hwmon attributes which exist,
> regardless of the needs or relevance. Do you really think you'll need
> information about the case intrusion status in nouveau? Seriously?
> 
> > > From 059b647b7b8bd98c04cf48b4062048b8ae963593 Mon Sep 17 00:00:00 2001
> > > From: Martin Peres <martin.peres@ensi-bourges.fr>
> > > Date: Sun, 13 Feb 2011 11:35:17 +0100
> > > Subject: [PATCH] hwmon API update
> > > 
> > > Original creator: Matthew Garrett <mjg@redhat.com>
> > > 
> > > Signed-off-by: Martin Peres <martin.peres@ensi-bourges.fr>
> > 
> > This is an extremely complex change just for the benefit of one driver,
> > with a huge potential of misuse. The changes required in each driver
> > to actually implement the API are substantial, and pretty much only add
> > complexity to each hwmon driver with no real benefit.
> 
> I would be very curious to know how comes that the radeon driver
> apparently works just fine without this change, if the nouveau driver
> can't do without it.
> 
> My main concern is that the code you will have to add to every new
> hwmon driver you will want nouveau to be able to use, is likely to be
> larger than the code needed to access the device registers directly
> from nouveau. Getting a temperature value from a hwmon device is
> typically done with a single call to i2c_smbus_read_byte_data().
> 
> > The cost gets even larger if one has to consider that some may want or
> > have to to backport drivers to earlier kernel versions. This patchset
> > would result in significant efforts to do such backports.
> 
> This will never be a good reason to reject a change, sorry. Just look
> at the many changes the i2c subsystem went through in the past 2 years.
> They make it difficult to backport i2c device drivers to older kernels,
> but they still happened, because they were needed. When backporting a
> driver, you have to deal with the history of the kernel at large,
> that's life.
> 
> > For the API itself, there are lots of functions with similar parameters, 
> > and those parameters are needed in the drivers to determine which attribute
> > is affected. A single function would have accomplished the same, as the drivers
> > will need case statements anyway to identify the actual attribute to be read
> > or written. What we end up here with is a large number of functions to be
> > supported by each driver, all with pretty much the same set of arguments.
> 
> This is the kind of thing which would show up immediately if we could
> see a few actual implementations of the hwmon driver side of the API.
> In general, I would tend to agree with Guenter that exporting a dozen
> functions from the hwmon core driver seems just wrong, especially given
> the specific problem you claim you are trying to solve.
> 
> > I don't know what current thinking is about kernel size increases, but it
> > looks like this patch will result in quite significant kernel size increase
> > (some 18*8 = 144 bytes per driver for all the pointers, plus the actual 
> > functions, adds up to a lot). Again this would be with no benefit for most
> > of the users of the hwmon subsystem. Sure, one can argue that the size increases
> > will only occur if the drivers are actually loaded, but that is a pretty weak
> > argument since the code size increase will still show up in each driver.
> > 
> > In summary I am not in favor for this change. Maybe Jean thinks differently,
> > but for my part I don't plan to approve it.
> 
> I don't plan to approve it either, at least not in its current state.
> As I said above already, I want a complete description of the problem
> first, an explanation of why the change is needed, why a more
> lightweight solution wouldn't do, and why nouveau needs it when radeon
> doesn't. And I want to see actual implementations of the API on both
> sides.
> 
> Sorry but you can't push for a new API affecting 100 drivers without
> justifying everything you do. An API with no implementers and no users
> is not how you'll convince me.
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
