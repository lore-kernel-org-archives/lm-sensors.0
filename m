From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 13 Jul 2005 13:17:29 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <9vXyAyc1.1121253126.1841930.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

A few comments on top of your comments to my comments ;)

> This does _not_ look very amenable to probing, and from what you
> wrote I suspect that other folk have confirmed that in practice.

There are several levels of problems. First, the quick writes used for
I2C probing aren't 24RF08-safe. This could be worked around (I have
plans). Second, you can really only probe for the existence of an EEPROM
at a given address. You can't reliably detect the size of the EEPROM,
as you found yourself. Third, there are a few chips living in the
0x50-0x57 range which are NOT EEPROMs. Hopefully we can do some positive
discrimination for these, but that's tricky.

Overall I agree that doing as much as possible based on the platform
makes full sense, especially for all these systems heavily relying on
large EEPROMs.

> > I have no strong opinion on what naming scheme we should use,
> > but I sure would like us to pick one and stick to it.
>
> Me too.  Though another option is to have no prefix at all.

"No prefix at all" is one possible naming scheme ;)

> I hadn't realized CONFIG_I2C_ was "claimed" in any sense; in
> USB-land, the CONFIG_USB_ prefix is used for most everything,
> both host side and peripheral side.

I didn't say it was claimed, not officially anyway. It just happens to
be that way at the moment. I am fine with changing this, but then we'd
do it consistently. Now that the hardware mnonitoring drivers have gone
away, there are really only a few chip drivers remaining.

> I did decide to NOT use the CONFIG_SENSORS_* stuff though.  :)

And quite rightly so, thanks :) I will have to fix the few ones using it
improperly (which is why I insist on agreeing on a naming scheme now
rather sooner than later).

> How would for example SPI sensors fit in?  I recently noticed
> that chips like the TSC2101 and ADS7846 aren't just used for
> touchscreen X/Y/presure sensors ... they also have temperature
> and battery voltage sensors.  SENSOR should not imply I2C...

This is the very reason why we just moved all the hardware monitoring
stuff (AKA sensors) to a different place. Drivers for W1 or SPI hardware
monitoring decices will be welcome there. There are many articicial
links between the hardware monitoring drivers and the i2c subsystem,
mostly for historical reasons. These prevent us from doing a number of
cleanups. I will work on separating both sides as clearly as possible in
the next few weeks. Hopefully this will open the doors to better
integration and lower footprint as well.

> I'm still not used to the way the I2C parameters are done.  The
> notion of pre-allocating several large arrays, pre-initialized
> with "end" tags, still feels odd to me.

True. Historical. On my list of things to cleanup.

> There should also be per-chip "is it readonly?" flag.

Yup, either as a module parameter or a second sysfs file.

> And maybe a non-I2C parameter limiting bus utilization.

I would make it mandatory, like the original eeprom does. Reading from or
writing to an EEPROM isn't time-critical enough that anyone wouldn't
possibly cope with a limit.

> > Also, why do you use "force" rather than "probe" here?
>
> That's the model:  the driver will do NOTHING unless it's explicitly
> told to.  Initializing "probe" (like "eeprom" does) would mean the
> driver will mis-detect some chips.

The only difference between probe and force at the i2c-core level is that
force won't even try to check whether there is anything responsive at
the given address. Then the driver itself may or may not want to make a
difference between both (using the kind parameter of the detect
function), but your driver doesn't.

> And wasn't that 24RF08 problem a consequence of using probing?

True, although a weak workaround exist.

I am fine with you using force for now, but once I have come up with a
real, safe workaround, you may consider switching to probe, as it offers
an additional check of the EEPROM presence.

> > What you call "generic" are perfectly standard at24c02-like EEPROMs, so
> > I see no point in making them a particular case.  If it's just to make
> > them read-only and all the other ones read-write, this looks a bad idea
> > to merge the writability with the size in a single parameter.
>
> The issue was how to handle backward compat with "eeprom"...
> and the plan was to treat all uninitialized sizes as "generic".
>
> Which is _exactly_ what "eeprom" does.  If it's good enough
> for that driver, it should be good enough here ...

This ain't compatible, as you still need to provide the addresses while
they are built-in for the "eeprom" driver. A really backward
compatible driver would need to behave like the old driver did when no
module parameter are provided.

> though as I commented, "eeprom" mis-handles at least double byte
> address cases, also chips of size != 2 Kbits, so maybe it's not really
> "good enough" there.  ;)

I think we really only need to be backward compatible with "eeprom" for
the 24C02. This is the most popular EEPROM in consumer PCs. It's
probably not a problem to break comaptibility for larger EEPROMs, as
there are less users and these users (hopefully) knew better support
could come later, which would imply incompatibility.

> There must be a lot of code you count as "not exactly nice" then!!

You have no idea. People hate me for that. It's not really important and
you might as well ignore my pointless rants.

> > > +static int at24c_ee_address(
> > > +	unsigned	chiptype,
> > > +	struct i2c_msg	*msg,
> > > +	unsigned	*offset,
> > > +	u32		*next_addr
> > > +)
> > > +{
> >
> > Eek. What's this coding style?
>
> You mean, "wrap lines at 80 characters"?  Or are you maybe
> feeling religious about where the right paren goes?  :)

I mean that, among the various coding styles that exist for function
declarations, I had never seen this one, neither in the kernel code nor
even elsewhere. And this isn't exactly easy to read, as it ressembles a
structure declaration.

> > Point (b): You could as well implement a generic function in i2c-core.
> > I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 is already reserved for that in i2c.h,
> > which suggests that SMBus 2.0 defines it (although I can't remember of
> > any hardware implementimg it).
>
> If no SMBUS hardware implements it, I'm not sure what the point of
> such a function would be!  For now, this version is portable enough.

If nothing else, this could avoid code duplication (the max6875 driver
needs something similar, for example). And hardware support might be
added later, and we get immediate benefit.

> > Points (d) and (e) suggest that the i2c-core API is not adapted to the
> > needs. You are not the first one to complain about the i2c block
> > transfers API, yet everyone always go coding its own implementation on
> > its side. I'd like someone to properly analyze the situation and make
> > concrete proposals for a change.
>
> Hmm?  I thought I _was_ using the I2C block transfer API.  The
> limitations I'm thinking of are SMBUS policy (32 byte niblets)
> or from its API.  (Note that this driver doesn't escape copying
> things written to EEPROM -- but that's relatively rare, and not
> a case where zerocopy arguments should apply.)

Yup, I misexpressed myself. The API offered by i2c-core is really the
SMBus one, as I2C doesn't exactly have an API. It happens that most I2C
devices do work with I2C commands that have a name in the SMBus API, so
we easily mix both.

Still, what I meant is that this SMBus API doesn't seem to make everyone
happy, especially the block transfer functions. I am wondering if
something better could be done so that people actually use that API
rather than implementing their own.

> All the Linux systems I do I2C on seem to have full I2C controllers,
> and don't need SMBUS limits.  They'll have no problem with this driver;
> after all, it's for "I2C EEPROMs" not "SMBUS EEPROMs".  :)

There is no such thing as SMBus EEPROMS, all EEPROMs I know of are I2C
chips, and it happens that EEPROMs up to 24C16 can be accessed using
standard SMBus commands, and manufacturers are relying on this. All x86
motherboards have an SMBus master and most use it to give access to some
24C02 EEPROMs, be it SPD on memory modules, laptop proprietary ones or
ones on network adapters. Most EEPROMs I have access to myself are on
SMBus (except for EDID/DDC).

> Maybe there should be drivers that in Kconfig depend on SMBUS, and
> others that depend on Real I2C(tm).  Configs that don't enable a
> real I2C controller wouldn't be able to configure I2C-only drivers.

This is handled by i2c capabilities, which are more flexible. There is no
such thing as a SMBus master, each physical device (and each driver on
top of that) may implement a subset of the SMBus commands. Even Real
I2C(tm) masters can differ, some can do protocol mangling, some can't.

What you propose would prevent some I2C/SMBus interactions which exist
now and we are perfectly happy with. Additionally, a given system can
have both an SMBus and an I2C master, with different devices on them.
Your approach wouldn't play well with this.

Now, I agree that mixing I2C and SMBus led us to a rather complex
situation in the Linux kernel. Blame it to Philips and Intel, as we only
reproduced the mess that physically exist.

> > > 	/* some chips take two or more addresses ... register using the
> > > 	 * first one, and hope no other driver claims the others!
> > > 	 */
> >
> > No, don't just hope. Properly register the other addresses as
> > subclients. See the asb100 driver for an example of how to do that.
>
> For now, this suffices.  Especially if the model is that all the
> addresses in that range are statically configured.  It may be
> worth cleaning that up at some point though, yes.

Sorry but no, it doesn't suffice, not even for now.

If you don't request all addresses for a given device, it means that
anyone else may do. This includes: the eeprom driver, and user-space
through i2c-dev, for example the sensors-detect driver.

If both your driver and a third party access the chip at the same time,
the internal address register of the EEPROM will be overwritten and/or
reads will be interlaced and the read/written data will be corrupted in
no time. You don't want this to happen.

> > > 	address |= 0x50;
> >
> > As said earlier, this is dangerous and shouldn't be done at all.
>
> Dangerous how?  More dangerous than any other user error?
> It's not as if an at24c08 has flexibility about the addresses
> it will be using.

Dangerous in that someone asking for address 0x30 will end up with 0x70,
which is irrational, and someone asking for 0x5C (which happens to be
the page protection address of the 24RF08) will get it. As much as I'd
like to agree with you that people are responsible for the module
parameter they pass, I see no point in not checking strictly for the
parameter value. These checks are cheap, and can prevent huge damage.

> > This is interesting. In all other drivers we are checking for the
> > functionality inside the *_probe (or *_detect) function rather than in
> > the *_attach_adapter function. Now that I think of it, this sounds
> > sub-optimal, your approach should be more efficient. Unless I'm missing
> > something, we should probably change all other drivers to match this one.
>
> Well, tps65010 and isp1301_omap do it in attach(), so maybe not
> quite all drivers!  :)
>
> But yes, I obviously agree this is a more natural place to
> do this particular checking.  Luckily those changes will
> be simple.
> 
> Maybe an even better place for it would be in the I2C core,
> by having the I2C drivers declare what level of functionality
> it needs from the adapter?  One word of data in each driver
> (taken from struct padding?) replacing several instructions
> and fault paths ... moving to one fault path in the core.

Exactly the conclusion I had come to. Just like adapter drivers can say
what they can do, device drivers would say what they require for proper
operation (but are still free to use more later for improved speed or
whatever). I need to think about it some more. but that sounds promising
for sure.

(But I want to kill i2c-isa first, as it's in the way somehow.)

> > You should use i2c_get_clientdata() (just like you should have used
> > i2c_set_clientdata() earlier.)
>
> I don't see why.  It's not incorrect; it's just a simpler style.

For maintainability I suppose. I'd guess there is a reason why Greg
introduced i2c_get/set_clientdata in the first place. I admit I don't
exactly know myself.

> In this case it's less expensive; the compiler will generate
> less code since it will notice that the two pointer values are
> always the same.

I don't think we really care, speed is not really important here. You
don't unload kernel modules every now and then.

> > No MODULE_AUTHOR?
>
> Redundant given the copyright statement; unless there's something
> special about showing up in "modinfo" output?

Not every user reads the source code, while simple users may want to get
in touch with a driver author for some reason. If not, MODULE_AUTHOR
wouldn't even exist, as all drivers do have their author name in the
source.

> > Note that your driver does not cache the reads to the EEPROM. While it
> > may be on purpose, it raises concerns because you gave read access to
> > everyone through sysfs, which means that any random user could saturate
> > the I2C bus the EEPROM is on. If there are other critical chips on the
> > bus (think battery controller, hardware monitor...) then we are in
> > trouble.
>
> I'll remove group and "other" read access then; good point.

If you do, you will never be compatible with the legacy eeprom driver.

> I don't want to maintain any caches for data that's not
> performance-critical.

The cache isn't about performance, although it incidentally helps on
that front. It's about preventing local DoS through bus saturation.

> However, the REALLY nice way to do this would be if the I2C bus
> framework had a clean way to handle static device configuration
> (like "platform_bus" does).  Then such a flag could be just one
> of several bits of information provided to driver using driver
> model infrastructure like platform_data.

Where are the patches? ;)

You might want to wait for the i2c-isa cleanup to happen first, as the
i2c subsystem will be much cleaner and somewhat less sensors-centric
after I am done.

Thanks,
--
Jean Delvare
