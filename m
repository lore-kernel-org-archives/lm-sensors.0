From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 12 Jul 2005 16:00:04 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <AuhDNiaN.1121176481.9291260.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

On 2005-07-12, David Brownell wrote:
> I ran into one too many board with an I2C EEPROM that Linux handled poorly,
> and got a hack attack.

Could you please define "handled poorly"?

> If someone wants to pick this up and do things with this, feel free;
> there's an obvious gap in how it initializes, since these chips can't
> very usefully be probed.  I have no current plans to submit this, but
> feel free to fling patches my way.

You are not the first one complaining about the limitations of the simple
eeprom driver. So far we have been able to work around them, typically
by using user-space tools to program the eeproms. The question is
whether your case is different or not. Is eeprog not sufficient for your
needs?

http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/prog/eepromer

If you followed the story of Ben Gardner's max6875 driver, you must
realize that drivers for I2C devices in the 0x50-0x57 range should be
VERY careful not to accidentally write to an innocent EEPROM. The
I2C/SMBus protocols make it happen very easily, unfortunately.

> This is modeled more or less after "eeprom" but of course it handles not
> only read/write access, but also chips with more than 2 Kbits of storage.
> So there's the notion that on some systems it might replace "eeprom".

The eeprom driver *did* support EEPROMs of more than 2 Kbits (actually up
to 16 Kbits) although maybe not in a very elegant way.

If your driver is to replace the eeprom driver (you will have to convince
me it is needed and safe), then it better replace it completely on all
systems. Let's not duplicate such a simple functionality.

> Tested only with AT24C04 so far, but support for many others is
> coded and ready for you once you decide how you want to handle
> the board-specific configuration issues.

What "board-specific configuration issues" are you thinking of?

Now, my comments on the patch itself.

> +obj-$(CONFIG_I2C_AT24C)		+= at24c.o

FWIW, CONFIG_I2C_* have always been used for i2c core drivers and i2c
adapter drivers (aka i2c bus drivers), not for i2c chip drivers. Those
were using either CONFIG_SENSORS_* for hardware monitoring drivers (and
some others, but this is a mistake), or no particular prefix for the
other ones. Now that we moved the hardware monitoring drivers outside of
the i2c/chips subdirectory, I'd like to make things a bit more
standard. I have no strong opinion on what naming scheme we should use,
but I sure would like us to pick one and stick to it.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ osk/drivers/i2c/chips/at24c.c	2005-07-11 17:06:28.000000000 -0700
> @@ -0,0 +1,502 @@
> +/*
> + * drivers/i2c/chips/at24c.c -- support some Atmel AT24C EEPROMs

Having the full path in the comment is redundant and error-prone. We know
where the file currently is, but that may change in the future, as was
seen recently with all the hardware monitoring drivers.

> +#undef	DEBUG

Needless.

> + *   - for one 4Kbit EEPROM with A0..A2 grounded, kernel params
> + *       at24c.force=0,0x50,-1 at24c.sizes=4
> + *   - one 2Kbit EEPROM with A0..A2 grounded; one with them pulled high
> + *       at24c.force=0,0x50,0,0x57,-1 at24c.sizes=2,2

I don't know where you got these "-1" from but they are not correct.
i2c "force" parameters should always be given by pair.

As the legacy parameter names were all singular, I would suggest "size"
rather than "sizes" for the new parameter name.

Also, why do you use "force" rather than "probe" here?

> + * It's also OK to leave off the 0x5 prefix.

I consider this a bad idea, as this adds code with no benefit and is even
error-prone as it breaks the compatibility with the way all other i2c
chip drivers handle that parameter.

> +/* to a first approximation:  kbits = chiptype */
> +enum chiptype {
> +	/* generic 2Kbit, read-only; as seen on memory DIMMS etc */
> +	generic = 0,
> +	/* single byte addressing, sometimes using I2C addresses too */
> +	at24c01 = 1,
> +	at24c02 = 2,

What you call "generic" are perfectly standard at24c02-like EEPROMs, so
I see no point in making them a particular case. If it's just to make
them read-only and all the other ones read-write, this looks a bad idea
to merge the writability with the size in a single parameter. Sooner or
later someone will need a read-only access to a larger EEPROM, and this
will break.

What do you mean with "sometimes using I2C addresses too"?

> +struct at24c_data {
> +	struct i2c_client	client;
> +	struct semaphore	lock;
> +	struct bin_attribute	bin;
> +	u32			next_addr;
> +	u16			chiptype;
> +	u16			pagesize;
> +	u8			addr_len;
> +};

Maybe some comments on what next_addr, pagesize and addr_len are for?
(The mix of member names using underscores with names not using them
isn't exactly nice, BTW.)

> +static int at24c_ee_address(
> +	unsigned	chiptype,
> +	struct i2c_msg	*msg,
> +	unsigned	*offset,
> +	u32		*next_addr
> +)
> +{

Eek. What's this coding style?

> 	/* advantages of not using i2c_smbus_read_i2c_block_data() here
> 	 * include both functionality and performance:
> 	 *  (a) uses addresses after at24c->client.addr, as needed;
> 	 *  (b) handles two-byte "register" addresses;
> 	 *  (c) this can often omit the initial dummy write;
> 	 *  (d) reads everything at once, not in 32-byte niblets;
> 	 *  (e) less data copying.
> 	 */

Points (a) and (c) would need clarification.

Point (b): You could as well implement a generic function in i2c-core.
I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 is already reserved for that in i2c.h,
which suggests that SMBus 2.0 defines it (although I can't remember of
any hardware implementimg it).

Points (d) and (e) suggest that the i2c-core API is not adapted to the
needs. You are not the first one to complain about the i2c block
transfers API, yet everyone always go coding its own implementation on
its side. I'd like someone to properly analyze the situation and make
concrete proposals for a change.

Note that your implementation requires a plain I2C bus master. SMBus
masters won't possibly work with it. This is a significant drawback. If
you want this driver to ever replace the eeprom driver, you will have to
make it work on SMBus as well.

> at24c_bin_write(struct kobject *kobj, char *buf, loff_t off, size_t count)

Could you possibly split the i2c-write part out of this function, just
like you did for the read part? This would make it more modular and
readable.

> 	default:
> 		/* don't know how to handle this chip type yet! */
> 		return -ENOSYS;

You have a memory leak here, and also a few lines later in the same
function. You really should centralize your failure path to prevent that.

> 		strcpy(at24c->client.name, "generic EEPROM");

Please use strlcpy instead of strcpy.

> 	/* some chips take two or more addresses ... register using the
> 	 * first one, and hope no other driver claims the others!
> 	 */

No, don't just hope. Properly register the other addresses as
subclients. See the asb100 driver for an example of how to do that.

> 	address |= 0x50;

As said earlier, this is dangerous and shouldn't be done at all.

> 	/* FIXME poke it, to see if there's actually a chip there! */

This is the i2c-core job and you would have it for free if you were using
"probe" rather than "force" as suggested above. Note that using
"probe" would require you to include the 24RF08 corruption preventer
(until I find some time to work around the problem more globally).

> static int at24c_attach_adapter(struct i2c_adapter *adapter)
> {
> 	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> 		dev_dbg(&adapter->dev, "%s probe, no I2C\n",
> 			at24c_driver.name);
> 		return 0;
> 	}
> 	return i2c_probe(adapter, &addr_data, at24c_probe);
> }

This is interesting. In all other drivers we are checking for the
functionality inside the *_probe (or *_detect) function rather than in
the *_attach_adapter function. Now that I think of it, this sounds
sub-optimal, your approach should be more efficient. Unless I'm missing
something, we should probably change all other drivers to match this one.

> 	kfree(container_of(client, struct at24c_data, client));

You should use i2c_get_clientdata() (just like you should have used
i2c_set_clientdata() earlier.)

No MODULE_AUTHOR?

Note that your driver does not cache the reads to the EEPROM. While it
may be on purpose, it raises concerns because you gave read access to
everyone through sysfs, which means that any random user could saturate
the I2C bus the EEPROM is on. If there are other critical chips on the
bus (think battery controller, hardware monitor...) then we are in
trouble.

I really appreciate that you have made your driver non-intrusive, in that
it won't attach to any device by default. However, I would go one step
further, by having a "writable" attribute separate from the concept of
"default eeprom" which I don't really like. This could either be a
module parameter, or a second sysfs file (I think we had a proposal in
that direction some times ago).

--
Jean Delvare
