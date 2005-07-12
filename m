From: david-b@pacbell.net (david-b@pacbell.net)
Date: Tue, 12 Jul 2005 21:55:23 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <20050712195434.E8D54BF3D9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Date: Tue, 12 Jul 2005 15:54:42 +0200 (CEST)
> From: "Jean Delvare" <khali@linux-fr.org>
>
> ...
> > Tested only with AT24C04 so far, but support for many others is
> > coded and ready for you once you decide how you want to handle
> > the board-specific configuration issues.
>
> What "board-specific configuration issues" are you thinking of?

How to declare to the driver -- ideally as part of board-specific init,
rather than by modifying the driver -- what chips a given board has,
and where.  That shouldn't live in the driver, since so many boards
have I2C EEPROMS for various purposes.

This does _not_ look very amenable to probing, and from what you
wrote I suspect that other folk have confirmed that in practice.


> Now, my comments on the patch itself.
>
> > +obj-$(CONFIG_I2C_AT24C)		+= at24c.o
>
> FWIW, CONFIG_I2C_* have always been used for i2c core drivers and i2c
> adapter drivers (aka i2c bus drivers), not for i2c chip drivers. Those
> were using either CONFIG_SENSORS_* for hardware monitoring drivers (and
> some others, but this is a mistake), or no particular prefix for the
> other ones. Now that we moved the hardware monitoring drivers outside of
> the i2c/chips subdirectory, I'd like to make things a bit more
> standard. I have no strong opinion on what naming scheme we should use,
> but I sure would like us to pick one and stick to it.

Me too.  Though another option is to have no prefix at all.

I hadn't realized CONFIG_I2C_ was "claimed" in any sense; in
USB-land, the CONFIG_USB_ prefix is used for most everything,
both host side and peripheral side.


I did decide to NOT use the CONFIG_SENSORS_* stuff though.  :)

How would for example SPI sensors fit in?  I recently noticed
that chips like the TSC2101 and ADS7846 aren't just used for
touchscreen X/Y/presure sensors ... they also have temperature
and battery voltage sensors.  SENSOR should not imply I2C...



> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ osk/drivers/i2c/chips/at24c.c	2005-07-11 17:06:28.000000000 -0700
> > @@ -0,0 +1,502 @@
> > +/*
> > + * drivers/i2c/chips/at24c.c -- support some Atmel AT24C EEPROMs
>
> Having the full path in the comment is redundant and error-prone. We know
> where the file currently is, but that may change in the future, as was
> seen recently with all the hardware monitoring drivers.

Easily changed.  (Background noise:  keyboard clicking.)  There.


> > +#undef	DEBUG
>
> Needless.

Though conventional in many drivers, highlighting the fact that
to get _selective_ debugging (this driver only!) you just change
that one line ...


> > + *   - for one 4Kbit EEPROM with A0..A2 grounded, kernel params
> > + *       at24c.force=0,0x50,-1 at24c.sizes=4
> > + *   - one 2Kbit EEPROM with A0..A2 grounded; one with them pulled high
> > + *       at24c.force=0,0x50,0,0x57,-1 at24c.sizes=2,2
>
> I don't know where you got these "-1" from but they are not correct.
> i2c "force" parameters should always be given by pair.

I'm still not used to the way the I2C parameters are done.  The
notion of pre-allocating several large arrays, pre-initialized
with "end" tags, still feels odd to me.


> As the legacy parameter names were all singular, I would suggest "size"
> rather than "sizes" for the new parameter name.

Good enough, that part's not yet implemented anyway.
There should also be per-chip "is it readonly?" flag.
And maybe a non-I2C parameter limiting bus utilization.


> Also, why do you use "force" rather than "probe" here?

That's the model:  the driver will do NOTHING unless it's explicitly
told to.  Initializing "probe" (like "eeprom" does) would mean the
driver will mis-detect some chips.

And wasn't that 24RF08 problem a consequence of using probing?


> > + * It's also OK to leave off the 0x5 prefix.
>
> I consider this a bad idea, as this adds code with no benefit and is even
> error-prone as it breaks the compatibility with the way all other i2c
> chip drivers handle that parameter.

Thing is, the addresses do need to be filtered/munged since they
are user inputs and not all values are legit.  The code I used
to munge the things forced the 0x5 rather than create error cases.
Not that it couldn't be a bit cleaner, but that's what it is now.


> > +/* to a first approximation:  kbits = chiptype */
> > +enum chiptype {
> > +	/* generic 2Kbit, read-only; as seen on memory DIMMS etc */
> > +	generic = 0,
> > +	/* single byte addressing, sometimes using I2C addresses too */
> > +	at24c01 = 1,
> > +	at24c02 = 2,
>
> What you call "generic" are perfectly standard at24c02-like EEPROMs, so
> I see no point in making them a particular case.  If it's just to make
> them read-only and all the other ones read-write, this looks a bad idea
> to merge the writability with the size in a single parameter.

The issue was how to handle backward compat with "eeprom"...
and the plan was to treat all uninitialized sizes as "generic".

Which is _exactly_ what "eeprom" does.  If it's good enough
for that driver, it should be good enough here ... though as
I commented, "eeprom" mis-handles at least double byte address
cases, also chips of size != 2 Kbits, so maybe it's not really
"good enough" there.  ;)


>	Sooner or
> later someone will need a read-only access to a larger EEPROM, and this
> will break.

As I noted.  The whole board-specific config issue is incomplete,
and that's clearly one issue in that mix.


> What do you mean with "sometimes using I2C addresses too"?

Should have read "multiple" I2C addresses.  This is your issue
with (a) below.  I updated the code to have a comment at the
top explaining this a bit, using the xample of an at24c08
which uses four I2C address for one chip.


> > +struct at24c_data {
> > +	struct i2c_client	client;
> > +	struct semaphore	lock;
> > +	struct bin_attribute	bin;
> > +	u32			next_addr;
> > +	u16			chiptype;
> > +	u16			pagesize;
> > +	u8			addr_len;
> > +};
>
> Maybe some comments on what next_addr, pagesize and addr_len are for?

Comments are fine things.  I avoid documenting data structures
much while they're in flux though.


> (The mix of member names using underscores with names not using them
> isn't exactly nice, BTW.)

There must be a lot of code you count as "not exactly nice" then!!
I added underscores to chip_type and page_size.


> > +static int at24c_ee_address(
> > +	unsigned	chiptype,
> > +	struct i2c_msg	*msg,
> > +	unsigned	*offset,
> > +	u32		*next_addr
> > +)
> > +{
>
> Eek. What's this coding style?

You mean, "wrap lines at 80 characters"?  Or are you maybe
feeling religious about where the right paren goes?  :)

One could argue that function parameters are just single-purpose
structures that (often) live on the stack ... many style guidelines
say to format long parameter lists like structures.  The kernel
guidelines are agnostic on that point, and I've always found
that structured lists like that are easier to make sense of.


> > 	/* advantages of not using i2c_smbus_read_i2c_block_data() here
> > 	 * include both functionality and performance:
> > 	 *  (a) uses addresses after at24c->client.addr, as needed;
> > 	 *  (b) handles two-byte "register" addresses;
> > 	 *  (c) this can often omit the initial dummy write;
> > 	 *  (d) reads everything at once, not in 32-byte niblets;
> > 	 *  (e) less data copying.
> > 	 */
>
> Points (a) and (c) would need clarification.

Done.

> Point (b): You could as well implement a generic function in i2c-core.
> I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 is already reserved for that in i2c.h,
> which suggests that SMBus 2.0 defines it (although I can't remember of
> any hardware implementimg it).

If no SMBUS hardware implements it, I'm not sure what the point of
such a function would be!  For now, this version is portable enough.


> Points (d) and (e) suggest that the i2c-core API is not adapted to the
> needs. You are not the first one to complain about the i2c block
> transfers API, yet everyone always go coding its own implementation on
> its side. I'd like someone to properly analyze the situation and make
> concrete proposals for a change.

Hmm?  I thought I _was_ using the I2C block transfer API.  The
limitations I'm thinking of are SMBUS policy (32 byte niblets)
or from its API.  (Note that this driver doesn't escape copying
things written to EEPROM -- but that's relatively rare, and not
a case where zerocopy arguments should apply.)

You touched on a minor downside to (d) later:  this can mean
some BIG reads, denying the bus to other drivers..  Easily
addressed by putting a ceiling on the amount of data read
at once; and better a per-system ceiling than a global one.


> Note that your implementation requires a plain I2C bus master. SMBus
> masters won't possibly work with it. This is a significant drawback. If
> you want this driver to ever replace the eeprom driver, you will have to
> make it work on SMBus as well.

All the Linux systems I do I2C on seem to have full I2C controllers,
and don't need SMBUS limits.  They'll have no problem with this driver;
after all, it's for "I2C EEPROMs" not "SMBUS EEPROMs".  :)

Maybe there should be drivers that in Kconfig depend on SMBUS, and
others that depend on Real I2C(tm).  Configs that don't enable a
real I2C controller wouldn't be able to configure I2C-only drivers.


> > at24c_bin_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
>
> Could you possibly split the i2c-write part out of this function, just
> like you did for the read part? This would make it more modular and
> readable.

Maybe later; ideally, that'd be done as part of exporting some API
to other kernel drivers to let them maintain their persistent state.
I'm not sure having a kobject vs an at24c_data parameter helps much.


> > 	default:
> > 		/* don't know how to handle this chip type yet! */
> > 		return -ENOSYS;
>
> You have a memory leak here, and also a few lines later in the same
> function. You really should centralize your failure path to prevent that.

Done, thanks.


> > 		strcpy(at24c->client.name, "generic EEPROM");
>
> Please use strlcpy instead of strcpy.

I changed that a bit differently.


> > 	/* some chips take two or more addresses ... register using the
> > 	 * first one, and hope no other driver claims the others!
> > 	 */
>
> No, don't just hope. Properly register the other addresses as
> subclients. See the asb100 driver for an example of how to do that.

For now, this suffices.  Especially if the model is that all the
addresses in that range are statically configured.  It may be
worth cleaning that up at some point though, yes.


> > 	address |= 0x50;
>
> As said earlier, this is dangerous and shouldn't be done at all.

Dangerous how?  More dangerous than any other user error?
It's not as if an at24c08 has flexibility about the addresses
it will be using.


> > 	/* FIXME poke it, to see if there's actually a chip there! */
>
> This is the i2c-core job and you would have it for free if you were using
> "probe" rather than "force" as suggested above. Note that using
> "probe" would require you to include the 24RF08 corruption preventer
> (until I find some time to work around the problem more globally).

I see two models for system configuration here, loosely "hotplug"
and "static config".  They aren't always in conflict, but in the
case of these chips the "hotplug" dynamic config model fails since
the chips aren't self-identifying.

This driver uses _only_ static configuration since there's no safe
way to detect basics like whether the chip at the address needs one
byte addressing or two byte addressing; or what size it is...


> > static int at24c_attach_adapter(struct i2c_adapter *adapter)
> > {
> > 	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> > 		dev_dbg(&adapter->dev, "%s probe, no I2C\n",
> > 			at24c_driver.name);
> > 		return 0;
> > 	}
> > 	return i2c_probe(adapter, &addr_data, at24c_probe);
> > }
>
> This is interesting. In all other drivers we are checking for the
> functionality inside the *_probe (or *_detect) function rather than in
> the *_attach_adapter function. Now that I think of it, this sounds
> sub-optimal, your approach should be more efficient. Unless I'm missing
> something, we should probably change all other drivers to match this one.

Well, tps65010 and isp1301_omap do it in attach(), so maybe not
quite all drivers!  :)

But yes, I obviously agree this is a more natural place to
do this particular checking.  Luckily those changes will
be simple.

Maybe an even better place for it would be in the I2C core,
by having the I2C drivers declare what level of functionality
it needs from the adapter?  One word of data in each driver
(taken from struct padding?) replacing several instructions
and fault paths ... moving to one fault path in the core.


> > 	kfree(container_of(client, struct at24c_data, client));
>
> You should use i2c_get_clientdata() (just like you should have used
> i2c_set_clientdata() earlier.)

I don't see why.  It's not incorrect; it's just a simpler style.

In this case it's less expensive; the compiler will generate
less code since it will notice that the two pointer values are
always the same.


> No MODULE_AUTHOR?

Redundant given the copyright statement; unless there's something
special about showing up in "modinfo" output?


> Note that your driver does not cache the reads to the EEPROM. While it
> may be on purpose, it raises concerns because you gave read access to
> everyone through sysfs, which means that any random user could saturate
> the I2C bus the EEPROM is on. If there are other critical chips on the
> bus (think battery controller, hardware monitor...) then we are in
> trouble.

I'll remove group and "other" read access then; good point.
And add a parameter to constrain the read sizes.

I don't want to maintain any caches for data that's not
performance-critical.


> I really appreciate that you have made your driver non-intrusive, in that
> it won't attach to any device by default. However, I would go one step
> further, by having a "writable" attribute separate from the concept of
> "default eeprom" which I don't really like. This could either be a
> module parameter, or a second sysfs file (I think we had a proposal in
> that direction some times ago).

I'd been thinking of doing this with a module parameter.

However, the REALLY nice way to do this would be if the I2C bus
framework had a clean way to handle static device configuration
(like "platform_bus" does).  Then such a flag could be just one
of several bits of information provided to driver using driver
model infrastructure like platform_data.

- Dave


> --
> Jean Delvare
>
