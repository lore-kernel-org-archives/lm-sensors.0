From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Feb 2011 21:50:25 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110215225025.7c508358@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthew,

On Mon, 14 Feb 2011 16:23:38 +0000, Matthew Garrett wrote:
> On Sun, Feb 13, 2011 at 11:08:33PM +0100, Jean Delvare wrote:
> > On Sun, 13 Feb 2011 09:16:40 -0800, Guenter Roeck wrote:
> > > On Sun, Feb 13, 2011 at 07:18:44AM -0500, Martin Peres wrote:
> > > > Hi,
> > > > 
> > > > I am working on power management on the nouveau driver and I need a way 
> > > > to get data out of and send commands to the i2c drivers from the kernel 
> > > > space.
> > 
> > Why? You already have a way to get data out of and send commands to the
> > I2C devices themselves (Using the i2c_smbus_* functions). Why do you
> > insist on going through the I2C device drivers?
> 
> Because implementing support for every sensor chip when there's already 
> code in the kernel to deal with them isn't the usual way of handling 
> problems.

Have you looked at what the hwmon drivers actually do? 95% of the code
is about exposing the measured values and limits to user-space through
sysfs in a standard way, including caching of register access. You
don't need this at all for thermal management of GPUs. So the code
duplication you are trying to avoid, probably doesn't exist in the
first place. If you need to poll a single temperature value on a
regular basis, I am certain that you wouldn't want to call the hwmon
drivers update functions which read all the registers at once. This
would be horrible performance-wise.

This is one of the reasons why I insist on you providing a full patch
set showing implementers and consumers of your proposed API. The
relevance of the API will depend (amongst other things) on the amount
of code needed on each side.

> > > > We can already change the clocks of the card, but we need a way to 
> > 
> > How is this relevant to the discussion? Are the clock chips connected
> > to the I2C bus too?
> 
> It's all part of the power management setup.
> 
> > > > monitor the temperature and bump the fan speed if needed.
> > 
> > Hardware is very badly designed if the driver actually has to take care
> > of this. Thermal management should be handled by the hardware directly.
> > And as a matter of fact, the Analog Devices ADT7473 and the Fintek
> > F75375S support this.
> 
> It's often the case that fan control on these cards is handled by an 
> external hwmon chip, while the thermal diode is integrated into the chip 
> core and therefore only readable by the PCI driver. In that case we need 
> to be able to access the fan control registers. In other cases, cooling 
> is implemented passively by reducing the clock on the card. In those 
> cases the PCI driver needs to be able to obtain the temperature from 
> off-card chips. Whether you think the hardware approach sucks or not, 
> the reality is that we have plenty of devices where maanging the thermal 
> state of the hardware requires a single driver to be able to access both 
> PCI and i2c devices.

OK, I understand this.

> > > > 2.6.38-rc4. This patch only provides the API, no modification to the 
> > > > drivers has been completed yet.
> > 
> > Do you mean that you don't have the code at all yet, or that you did
> > not include it in this patch set? Either way, this is wrong. There is
> > no point in asking for a review of only half of your solution. We can't
> > comment on the relevance of your proposal without seeing how you intend
> > to use it.
> 
> There's no point in adapting drivers if the API is unacceptable to the 
> upstream maintainers.

This is a dead end I'm afraid. There is no way a new API can be
commented on without seeing the big picture.

> We need a mechanism for in-kernel drivers to read 
> and write from hwmon devices. What should the interface to do so look 
> like? This is one proposal which would satisfy the current consumers and 
> could potentially be used for other devices as well.
> 
> > I have no plan to review your patch, sorry. You did not provide a
> > proper description of your problem, and you didn't explain why it can't
> > be solved with the current kernel infrastructures. Worse, you propose a
> > brand new hwmon subsystem, but you don't even provide a description of
> > its design, let alone an explanation of why you think this design is
> > appropriate. And you don't show us code using it either.
> 
> I hope I've provided a bit more context, but to summarise:
> 
> Power and thermal management of GPUs requires that the GPU driver be 
> able to obtain the GPU temperature and control the GPU fan. On many 
> shipping devices, doing so requires the ability for the GPU driver to 
> obtain values from devices attached via i2c. The kernel already has 
> drivers for these devices and so it makes sense to use them rather than 
> duplicating them. Adding a generic hwmon interface for in-kernel use 
> would allow these drivers to be used for this purpose.

My feeling at the moment is that you don't really want "a generic hwmon
interface for in-kernel use". What you want is thermal sensors of some
hwmon devices to be available as thermal zones, and fan outputs of some
hwmon devices to be available as cooling devices, both for in-kernel
use. This is much more specific.

> > All I can say after a quick look at the patch, is that you are
> > overengineering a lot. You have enumerated all sensor properties which
> > exist, and are trying to handle all sensor types. You have a specific
> > need (thermal management of graphics cards), but you are already trying
> > to provide a generic access to all hwmon attributes which exist,
> > regardless of the needs or relevance. Do you really think you'll need
> > information about the case intrusion status in nouveau? Seriously?
> 
> If we're adding an in-kernel API then it makes sense for it to be 
> generic enoguh that anyone could use it,

There is nothing generic about the current proposal. It is exhaustive,
if anything. But that doesn't make sense. Commit this, and next week
someone will come and say "hey, these exported functions have no users,
let's get rid of them." This has happened in the past.

> but there's no real problem in 
> just cutting out any functions that wouldn't be used by anyone as yet.

Either that, of make the functions generic enough that a pair, and not
a dozen, is sufficient.

> > > This is an extremely complex change just for the benefit of one driver,
> > > with a huge potential of misuse. The changes required in each driver
> > > to actually implement the API are substantial, and pretty much only add
> > > complexity to each hwmon driver with no real benefit.
> > 
> > I would be very curious to know how comes that the radeon driver
> > apparently works just fine without this change, if the nouveau driver
> > can't do without it.
> 
> It doesn't. Right now the fan control is left up to the card firmware, 
> which means that it runs far faster than necessary and also means that 

I don't really care, I only use fanless cards ;)

> the card can't drop clock rates in response to reaching temperature 
> limits.

I would certainly hope that we can drop clock rates dynamically based
on the (lack of) demand, a la cpufreq, to save power, regardless of the
thermal status. But yes, I get your point.

> Radeon will benefit from this just as much as nouveau.

Now this is interesting.

> > My main concern is that the code you will have to add to every new
> > hwmon driver you will want nouveau to be able to use, is likely to be
> > larger than the code needed to access the device registers directly
> > from nouveau. Getting a temperature value from a hwmon device is
> > typically done with a single call to i2c_smbus_read_byte_data().
> 
> Duplicating the functionality directly in novueau (and again in radeon) 
> just means that every time we find a bug in an hwmon driver we have to 
> fix it in three places. Upstream is typically resistant to this kind of 
> thing.

The duplication between nouveau and radeon is way more likely than
between each of these and the current hwmon drivers IMHO. The design of
the new API should have this in mind.

> > (...)
> > This is the kind of thing which would show up immediately if we could
> > see a few actual implementations of the hwmon driver side of the API.
> > In general, I would tend to agree with Guenter that exporting a dozen
> > functions from the hwmon core driver seems just wrong, especially given
> > the specific problem you claim you are trying to solve.
> 
> Replacing it with a read/set function with a type enum as the first 
> argument would work as well. Would that be more reasonable?

Probably yes, but I'm not sure. Again, how could I comment on the
relevance of an API without seeing the code which will use it?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
