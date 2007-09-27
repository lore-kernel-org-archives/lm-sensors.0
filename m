From: David Brownell <david-b@pacbell.net>
Date: Thu, 27 Sep 2007 21:33:40 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 2/3] lm75: new style driver
Message-Id: <20070927213340.6433B23532C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Mon, 24 Sep 2007 22:19:26 -0700, David Brownell wrote:
> > Teach LM75 driver how to use new-style driver binding.
>
> +the +the

Only one "the" could be needed...


> >  - More careful initialization.  Chips are put into 9-bit mode so
> >    the current interconversion routines will never fail.
>
> I don't follow you here. How could the conversions fail at all? I don't
> see anything wrong with the original code in this respect.

Well, the lm75.h code expects 9 bit precision.  It trashes any
extra LSBs in either direction.  Perhaps "fail" is too strong,
but certainly the alarm mechanism checks those LSBs if they're
available ... so discarding available precision can lead to
some odd results.  Disabling extra precision prevents that.


> > @@ -312,9 +312,12 @@ config SENSORS_LM75
> >  		- TelCom (now Microchip) TCN75
> >  		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
> >  
> > -	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
> > -	  a force module parameter. The driver will not handle the extra
> > -	  precision anyhow.
> > +	  This driver supports driver model based binding through board
> > +	  specific I2C device tables.
> > +
> > +	  It also supports the "legacy" style of driver binding.  To use
> > +	  that with some chips which don't replicate lm75 quirks exactly,
>
> s/lm75/the LM75/

A "the" would be superfluous in English.  Possibly not wrong
in a grammatical sense, but certainly a violation of modern
usage guides (which stress concision over prolixity).


> > +	int			min, max;
>
> I would prefer these to be long, as this is what the conversion
> functions use.
>
> > +	char			orig_conf;
>
> Should be u8.

OK.

Also, "temp[3]" should be s16; those values are fixed-point with sign.
(I accidentally dropped that.)


> >  	char			valid;		/* !=0 if registers are valid */
> >  	unsigned long		last_updated;	/* In jiffies */
> >  	u16			temp[3];	/* Register values,
> > @@ -65,7 +67,6 @@ struct lm75_data {
> >  						   2 = hyst */
> >  };
> >  
> > -static void lm75_init_client(struct i2c_client *client);
> >  static int lm75_read_value(struct i2c_client *client, u8 reg);
> >  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
> >  static struct lm75_data *lm75_update_device(struct device *dev);
> > @@ -75,13 +76,28 @@ static struct lm75_data *lm75_update_dev
> >  
> >  /* sysfs attributes for hwmon */
> >  
> > +static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
> > +{
> > +	if (temp < lm75->min)
> > +		temp = lm75->min;
> > +	else if (temp > lm75->max)
> > +		temp = lm75->max;
>
> SENSORS_LIMIT() is your friend.

Not _my_ friend; hiding logic that simple is just obfuscation.
Plus, function names should NEVER SHOUT AT ME. ;)


> > +
> > +	return LM75_TEMP_TO_REG(temp);
> > +}
>
> This is inefficient. Your have already done half of what
> LM75_TEMP_TO_REG() does, so you're better copying the rest in your
> function.

Addressed in the third patch ... which replaces those macro calls
with ones that behave properly with 10/11/12-bit precision.

The only functional change made here is to handle temperature ranges
that aren't exact clones of the original LM75.


> In the long run, I think that we need a generalized LM75_TEMP_TO_REG()
> function that would take limits and resolution as parameters. This
> function could live in <linux/hwmon.h>, or drivers/hwmon/hwmon.c if it
> ends up being too large to be reasonably inlined.

I noticed there are other drivers using "lm75.h"; those all looked
kind of ugly to me.  Drivers should never grot around in other
drivers' header files.


> > +
> > +static inline int reg_to_temp(s16 reg)
> > +{
> > +	return LM75_TEMP_FROM_REG(reg);
> > +}
>
> Useless. Either keep calling LM75_TEMP_FROM_REG() directly, or
> duplicate its contents.

Again, that's fully addressed in the third patch.  This one
is consistent in the style change:  the conversion routines
called in the sysfs attribute logic are normal no-shouting
inline functions.


> > +static int lm75_probe(struct i2c_client *client)
> > +{
> > +	struct lm75_data	*data;
> > +	int			status;
> > +	u8			set_mask, clr_mask;
> > +	int			new;
>
> Please use the same coding style for variable declarations that is use
> in the rest of the driver: just one space between type and name(s).

That's ugly and hard to read, but ... ok.


> > +	/* Set to LM75 resolution (9 bits, 0.5 degrees C) and range.
>
> degree

Only if it's "1/2 degree".  "Five" (tenths) is plural ...


> > +	/* NOTE:  also need to ensure that the chip is in interrupt mode
> > +	 * in various cases, and maybe handle SMBALERT#.
> > +	 */
>
> This comment doesn't make any sense to me.

In what way?  When the chip's IRQ is wired up, that should
be handled ...


> > +
> > +	/* configure as specified */
> > +	status = lm75_read_value(client, LM75_REG_CONF);
> > +	if (status < 0) {
> > +		dev_dbg(&client->dev, "can't read config? %d\n", status);
>
> Please uppercase the first letter, and add parentheses around %d. Just
> because it's a debug message doesn't mean it doesn't have to look
> nice ;) BTW, shouldn't this rather be a dev_warn or even dev_err?

CodingStyle ch13 say no useless parens.  I don't much like
non-sentences to be capitalized, but I'll change that for you.

Warn or error?  Why?

As a general policy, I avoid non-dbg messaging from driver probe
faults.  They just waste object file space, except in systems
which are misbehaving and thus need debugging.  When debugging,
the first thing to do is enable debug messaging.  Then turn it off
again when done, and the memory footprint goes back to "slim".


> > +	kfree(data);
> > +	i2c_set_clientdata(client, NULL);
>
> These two lines would better be swapped.

OK (later too).  Not that it's allowed to matter; in fact,
the clientdata field is undefined unless a driver is bound.


> When you're done, your patch will be a very nice example of how
> i2c-based hwmon drivers can be turned into hybrid legacy/new-style
> driver. Good.

Yeah ... and once that's all done, phasing out legacy binding
can begin in earnest!


Updated patch to follow.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
