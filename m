From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 Apr 2008 10:13:05 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <20080413121305.0bffafd2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412173221.7b2a2f41@hyperion.delvare>
In-Reply-To: <20080412173221.7b2a2f41@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trent,

On Sat, 12 Apr 2008 17:12:13 -0700 (PDT), Trent Piepho wrote:
> On Sat, 12 Apr 2008, Jean Delvare wrote:
> > On Thu, 3 Apr 2008 18:29:13 -0700 (PDT), Trent Piepho wrote:
> >> Add controls that configure settings normally done by the BIOS.  Turned on
> >> with CONFIG_SENSORS_LM63_SETUP
> >
> > What system do you need this for?
> 
> A new embedded device.  There is no bios, and we are the designers of the
> hardware.  I want to configure the lm63 using Linux, because it's by far the
> easiest and most convenient way to do it.  The hardware changes a lot, and the
> way I want the LM63 configured changes with it.  And how it should be
> configured isn't exactly written in stone somewhere.  I need to figure out
> what I want by changing things are seeing how it works.
> 
> I realize that some of these settings aren't something the average desktop
> user will want to change or see.  But for an embedded developer, they are
> useful.  That why I made it an config option.  There are plenty of other
> options in the kernel designed for embedded systems.
> 
> >> pwm1_polarity:  0 = low for fan off, 1 = low for fan on.  Changing the
> >
> > I am reluctant to accept this as a run-time option... It's a good thing
> > that you preserve the fan speed, but still, one of the polarities is
> > wrong, and wrong polarity doesn't bode well with automatic fan speed
> 
> If the default LM63 polarity is wrong, how is it supposed to be changed?

I'd say firmware, platform code, or i2cset, in this order of
preference. Relying on user-space to configure a hardware monitoring
chip is somewhat dangerous, user-space might as well never come up.

> Suppose the correct polarity depends on the hardware revision?  Or some
> kind of configuration setting?  It's possible that the polarity of the lm63
> will be controlled by a dip switch in the next hardware revision, as the
> polarity also controls whether the lm63 comes out of reset with the fan on
> or off, and if one can use pwm and fan speed monitoring at the same time.

I fail to see how this matters. You'll have to know what register
values to change anyway. How we change them is an implementation detail.

> 
> One of the benefits of using embedded Linux vs something like vxworks is
> that linux has things like sysfs.  You can debug your hardware just by
> reading and writing to easily named files with the shell.  Beats needing to
> recompile and and re-flash an entire image to change anything, or typing in
> cryptic hex sequences to a debugger.

We have debugfs for that, I don't think that sysfs is meant for this
kind of experiment.

> > control, which the LM63 implements: you'll end up with either fan at full
> > speed (bad) or stopped (worse). The polarity should really be set
> > before the driver is loaded and never changed after that.
> 
> Set by what?  Create a second lm63 setup only driver that does it?  Put a
> copy of the LM63 driver into U-Boot and then add this setting to that
> driver?  IMHO, it makes a lot more sense to add one more setting to a
> driver and infrastructure that is already there, than to create some
> entirely new system just to change one thing.

i2cset is already there for a long time, and it has the advantage that
you can use it to setup pretty much any I2C or SMBus device without
writing dedicated kernel code.

> 
> >> fan1_enable:  Enables/disables fan tach monitoring.  Turning this on/off
> >>  	will create/remove the other fan related sysfs files.
> >
> > Again I am reluctant to make this a run-time selection, because you're
> > not just enabling/disabling the tachometer function, you're also
> > disabling/enabling the ALERT output which shares the same pin. Only one
> > configuration is correct for the hardware setup, so it should be set
> > once and for all before the driver is loaded.
> 
> Again, set by what?  I can move one resistor on my board and change the
> lm63's connection from fan monitoring to alert output, so I want to be able
> to configure the lm63 as well.  I want to see if both work, so I need
> to be able to change the lm63 setting.

I'm not arguing the if, just the how.

> 
> Think of it from my perspective and anyone else who is designing hardware. 
> There is some LM63 setting we want to be able to change.  Do you add a
> small bit of code to a driver that's already written, that you're already
> loading, has all the infrastructure in place to make the code simple to
> write, and will present the same interface for changing this settings as
> changing all the other settings?  Or do you create some entirely new system
> from scratch, that doesn't give you macros for register names or anything to
> start with, and gives a different interface for changing this one setting than
> is used to change everything else?

I understand your point of view. You went for the most easy and
straightforward solution to solve the problem at hand (but not
necessarily the cleanest one, see below.)

Me, I am thinking long-term. You're creating a precedent with
CONFIG_SENSORS_LM63_SETUP. If one driver has this, I can see all the
embedded developers and power users rush in and ask for something
similar for their hardware monitoring driver. Not only that would be a
mess in menuconfig, but more importantly this could cause some
confusion with regards to the sysfs interface. We've been claiming that
the sysfs interface to hardware monitoring devices was essentially safe
to use, and that would no longer be always true.

We have also been claiming loudly that the sysfs interface to hardware
monitoring devices was now standardized. If we want this to be still
true, then all CONFIG_SENSORS_*_SETUP extensions would have to agree on
standards for the extra setup functions. That would be a lot of work
and I am definitely not willing to invest time in this. Alternatively,
we could just say that the advanced setup sysfs files are not standard,
but I can see this cause even more confusion when two drivers will offer
sysfs files by the same name but expecting different conventions.

Your approach works now for the problem you're willing to solve. But
even then it can be argued if this is the correct solution from an
engineering point of view. You are adding code to a kernel driver for
something that should be setup at device initialization time, but you
give it a run-time interface. This means that you have to keep the code
in memory forever while you really only need it once. Given that you
are working on a system with limited resources, I thought that this is
something you would care about.

>                                         And what about when you want to change
> these things while the system is running?  If you don't change them with the
> lm63 driver, how does the lm63 driver cope with "something else" changing the
> settings out from under it?

Changing the PWM polarity while the system is running? Hmmm ;)
Note that all the hwmon drivers actually cope mostly well with changes
happening behind their back, by design, as discussed later. But anyway,
these are settings you simply shouldn't change at run-time. If you're
debugging stuff, just unload the lm63 driver, run i2cset, and load the
lm63 driver again.

> 
> >> conv_rate:  Set the conversion rate, format is log2(frequency)
> >
> > I fail to see the point of this one, given that the driver caches the
> > data for 1 second anyway?
> 
> It might make sense to lower the frequency to 1 Hz then, no?  I think the
> default is 16 or 32 Hz.  I wonder how the conversion rate affects the
> automatic fan speed control?  It doesn't trip instantly, there is some
> filtering that goes on.  And the LM63's power consumption?  I suppose one
> could test and measure these things, if only there was a convenient way to
> change the conversion rate and then observe the effect.....

That's a tricky question. On the one hand, having a conversion rate
different from 1 or 2 Hz doesn't make much sense due to the caching
done by the driver. But on the other hand the refresh frequency has
many other implications as you found out (alert output, automatic fan
speed control, power consumption...) For this reason we decided to NOT
change the conversion rate in the driver, assuming that the BIOS would
have setup the conversion rate properly if it really matters to the
system. If anything, we could adjust the cache lifetime depending on
the conversion rate (with a safety minimum), but not the other way
around.

> 
> > pwm_auto_point1_temp_hyst: read/write
> > pwm_auto_point[2-8]_temp_hyst: read only
> 
> Why not make them all read/write?  Then they could all be defined to use
> the same store function and not need to worry if they should be read
> only or not.

Making them all writable would confuse user-space. This would look like
all hysteresis values can be set independently from each other. At
least when only one hysteresis value can be set, it's visible that the
other ones are computed automatically and cannot be changed on their
own.

It's not that difficult to implement the way I suggested, just give it
a try. Many other drivers do that already, see temp[1-4]_crit in the
lm83 driver for example.

> 
> > This basically leaves only two or three configuration bits (pwm1_polarity,
> > fan1_enable and maybe conv_rate if you can explain) that would belong
> > to CONFIG_SENSORS_LM63_SETUP. Quite frankly, I'd rather see you use
> > i2cset to write them to the LM63 chip at boot time, rather than adding
> > code to the lm63 driver, even as a separate option. You'll have to
> 
> Well, why write a lm63 driver at all?  Just use i2cset for everything.

Excellent idea, please do that.

You know, I have been spending about 2 hours reviewing your patch
originally, and now I'm spending again one hour just to reply to this
mail. If you're not going to listen to my experience with hardware
monitoring drivers, just tell me right away and I'll go spend my
precious time in a more useful way.

> Looking up register values in the datasheet and converting them to hex
> bytes in your head gets old fast.  It's also very convenient to put
> something like this:
> 
> echo $SYSCFG_PWM_POLARITY > /sys/class/hwmon/hwmon0/device/pwm1_polarity

Not very robust... If you have several hardware monitoring devices,
your lm63 chip could as well be hwmon1.

> 
> In your startup script.  Instead of having to include i2cset and i2cdump on
> your embedded device (there goes another sector of flash) and trying to
> implement a script that sets the necessary bit.

You shouldn't need i2cdump, i2cset (and the i2c-dev driver) should be
enough. If anything, I'd rather add i2cget (but again in most cases
i2cset should suffice.) i2cset weights about 18 kB, the i2c-dev driver
about 6 kB, that's pretty small, and more importantly, both can be
removed from memory after use, while the hardware monitoring drivers
cannot.

Anyway, i2cset is probably not the best solution for an embedded
solution either, see below for something better.

> >> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN, data->config_fan);
> >
> > You should not assume that data->config_fan was up-to-date. Do a proper
> > read/modify/write cycle instead.
> 
> I thought lm63_update_device() would refresh it, but I see that's not the
> case.
> 
> Still, only a few registers in the LM63 are "volatile" and will be changed
> by the lm63 device.  For those that aren't, it's just a waste to re-read
> them each time lm63_update_device() is called.  They won't change and
> usually one doesn't care about their value anyway.
> 
> Now, one could change these registers with i2cset.  But there is no way to
> have an *atomic* read/modify/write cycle with the i2c layer!  Assuming that
> data->config_fan will remain valid for a 1 second cache is just as wrong as
> assuming it's always valid in the face of something from outside the driver
> modifying the lm63.

You're all correct, but this is a design decision and all hardware
monitoring drivers are following it. The main reasons are that ACPI or
SMM code could actually change the register values in our back, and
also that multi-master I2C buses exist. So you will have to keep
following this design decision for the time being.

I'm not going to discuss the pros and cons of this approach here,
that's not the point. There is a discussion going on on the lm-sensors
list about this:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022813.html
Feel free to speak up there.

> 
> w.r.t config_fan, doesn't the existing code that uses it, e.g.
> show_pwm1_enable(), have the exact same problem?  It calls lm63_update_device,
> even though that doesn't update config_fan.  And then it prints config_fan
> without refreshing it.

You're right, that's a bug in the current lm63 driver. Should be fixed;
care to send a standalone patch?

<snip>

> > I don't like this... For one thing, removing files to create them right
> > after is ugly. For another, libsensors scans sysfs for attributes at
> > initialization time and doesn't expect attributes to be added or
> > removed after that.
> 
> This isn't something that changes a lot, if ever, and it's the easiest way
> to do it.  Otherwise it's a lot more work to become robust against sysfs
> and the config work becoming out of sync.  I thought code simplicity and
> clarity were more important than speed in this case.

"A lot of work"? Store a bit in struct lm63_data to remember whether
the files are created or not, and you're done.

> 
> libsensors would be OK, if one sets fan1_enable before starting whatever
> app uses it, right?

Yes it would, but your design can't guarantee that fan1_enable won't
change later. That's exactly the reason why I claim that your design is
not correct.

> 
> >> +	/* Value is log2(rate) */
> >> +	if (val < -4 || val > 5)
> >> +		return -EINVAL;
> >
> > What a friendly unit ;)
> 
> Do you have a better unit that easily covers the range 1/16 to 32?  And is
> easy to map to the closest power of two?  I didn't see any other controls for
> a value like this to copy the units from.  And I figured, why make the driver
> harder to write?  If someone doesn't like the units, they can convert them
> in userspace.

See my rant above about non-standard sysfs interface files. Basically
you're making the kernel code as simple as possible and rely on the
user to read the device datasheet and convert from human value to
register value. This goes against the sysfs interface design decisions.

If I had to find a standard way to implement this, I think I would name
the file conv_interval and express the value in ms. This covers your
immediate needs, and should be fine for other devices as well.
Converting from ms to a register value in the lm63 driver shouldn't be
that difficult, for example using the helpers in <linux/log2.h>.

> 
> >> +	data = i2c_smbus_read_byte_data(client, LM63_REG_CONV_RATE);
> >
> > Because this isn't cached, you're giving users an easy way to saturate
> > the SMBus. Either make the attribute readable by root only, or cache
> > its value.
> 
> I didn't want to add extra stuff to read in lm63_update_device().  Maybe I
> should just make this root readable only, it's the least amount of code.
> 
> >> +	/* Only support the ranges [23, 700] and [5806, 180000] */
> >
> > And even then... frequencies 180 kHz, 90 kHz, 700 Hz and 350 Hz are
> > hardly usable due to the chip design. I don't really consider PWM steps
> > of 50% or 25% as acceptable. In particular when using automatic fan
> > speed control, this would probably be awful. I think this is worth a
> > note in Documentation/hwmon/lm63. Maybe also output the resulting PWM
> > step resolution to the kernel log?
> 
> info or debug?  Even when there are just steps of 0%, 50%, 100%, it's still
> useful.  You could have a fan that is normally off, but can turn on in an
> emergency if the temp gets too high.  A simple on/off control could be enough. 
> I've also found that small fans don't like pwm much, they seem to either be
> off or nearly off, or on at full power.

I'd make this an info message. As I understand it, users set the PWM
frequency only once so it shouldn't spam the logs in practice, and I
think it's a useful information.

I agree that even a simple on/off switch can be useful, but still, the
way the LM63 is designed is rather unique and I expect this to surprise
some users who are used to other hardware monitoring devices where the
PWM step resolution doesn't depend on the PWM frequency. I was really
only thinking out loud - there's obviously nothing you can do at the
software level.

<snip>

> >> +	long val = simple_strtol(buf, NULL, 0);
> >> +
> >> +	if (!(data->config_fan & 0x20)) /* registers are read-only */
> >> +		return -EPERM;
> >
> > So basically the user has to set PWM in manual mode first before he/she
> > can change the points of the automatic mode. While it makes some sense,
> > other chips / drivers don't have this limitation, so it might be
> > confusing. This should be documented in Documentation/hwmon/lm63.
> 
> It's a chip limitation and it didn't seem like I should work around it in the
> driver, by turning auto fan mode off and back on.  What if there is an error
> half way through and the fan mode gets left in manual mode, with the fan off?
> Better to only turn the automatic fan off by explicit user request.

Again I was merely thinking out loud - I'm fine with your
implementation. I'm only suggesting that you document the (again
unique) behavior of the LM63 in this respect, to save some questions on
the lm-sensors list later.

> 
> >> +	int data = i2c_smbus_read_byte_data(client,
> >> +					    LM63_REG_PWM_AUTO_TEMP + nr * 2);
> >
> > Should be cached.
> 
> Adding all these registers to be read each time update_device is called would
> be wasteful.  They don't change on their own.  Cache them once when the driver
> loads?  Or have a lm63_update_pwmauto() function that just updates these
> registers?

You can indeed have a separate cache for these values, some drivers do
that already (the lm85 and w83793 drivers for example.)

> 
> Maybe there is a smbus function that can read them all in one go,
> I think the lm63 has an auto-incrementing index register.  That would
> be more nice to use.

The LM63 datasheet is exceptionally scarce about which SMBus (or I2C)
transactions are supported. As I don't have an LM63 chip, you'll have
to try by yourself. I hope they would have mentioned it if the SMBus
block reads were supported, so we can probably rule this one out. This
leaves us with (by order of preference):
* I2C block read.
* SMBus word read, giving you two register values per transaction.
  I doubt this will work if I2C block read failed.
* SMBus send byte followed by N SMBus receive bytes (also known as
  continuous byte read). Note that this may NOT be faster than
  simple byte reads on some systems, and may even be slightly slower.

Of course the underlying I2C adapter and its driver have to support
this. I2C block read isn't too widely supported, the other two are.


Back to the "where does the initialization go" problem...

Thinking about it, this seems to be a case where a new-style i2c driver
would help. As this is an embedded system, presumably you have some
dedicated platform code running at boot. The new i2c infrastructure
added by David Brownell would let you instantiate your lm63 device
explicitly from the platform code. The advantage is that you then can
pass an arbitrary structure containing initialization values to the lm63
driver. In your case, this could include the PWM polarity, the
conversion rate, the tachometer input / alert output setup, etc. This
has all the advantages:
* You have access to the lm63 driver facilities (register names, etc.)
* Most of the setup code can go away after initialization if it is
  tagged properly.
* You don't define a user-space interface so it doesn't have to follow
  any standard and can be changed later as needed.
* You no longer rely on user-space for device initialization, so
  nothing can go wrong if user-space doesn't come up for some reason.

The f75375s driver does exactly this already. It's an hybrid driver,
supporting both legacy mode (device probed automatically) and new-style
mode (device instantiated from platform code). I think that's what you
should do with the lm63 driver.

So basically the road map could be:
* Fix show_pwm1_enable().
* Add the functions which I said could be included unconditionally.
* Convert the lm63 driver to an hybrid driver.
* Instantiate the lm63 device from your platform code, with all the
  configuration parameters you want.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
