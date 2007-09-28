From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 28 Sep 2007 21:18:02 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 2/3] lm75: new style driver
Message-Id: <20070928231802.340cdb14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 27 Sep 2007 14:33:40 -0700, David Brownell wrote:
> Well, the lm75.h code expects 9 bit precision.  It trashes any
> extra LSBs in either direction.  Perhaps "fail" is too strong,
> but certainly the alarm mechanism checks those LSBs if they're
> available ... so discarding available precision can lead to
> some odd results.  Disabling extra precision prevents that.

Ah, good point, I had missed that problem. I doubt it caused much
trouble in practice, but that's still worth fixing.

> (...)
> Also, "temp[3]" should be s16; those values are fixed-point with sign.
> (I accidentally dropped that.)

Yes, it should. I've fixed many drivers that way already, but not all.

> (...)
> > SENSORS_LIMIT() is your friend.
> 
> Not _my_ friend; hiding logic that simple is just obfuscation.
> Plus, function names should NEVER SHOUT AT ME. ;)

It used to be a macro, this is why. Admittedly it could (and should)
have been renamed since then.

> (...)
> I noticed there are other drivers using "lm75.h"; those all looked
> kind of ugly to me.  Drivers should never grot around in other
> drivers' header files.

Who said that "lm75.h" was lm75.c's header file? The functions in
lm75.h are for all drivers of chips which behave like the (de-facto
standard) LM75 chip does. lm75.c is one of these drivers. There's
really nothing wrong there.

> (...)
> > Useless. Either keep calling LM75_TEMP_FROM_REG() directly, or
> > duplicate its contents.
> 
> Again, that's fully addressed in the third patch.  This one
> is consistent in the style change:  the conversion routines
> called in the sysfs attribute logic are normal no-shouting
> inline functions.

"Badness of this patch is fixed in the next patch" is a recurrent lame
excuse. This isn't how things work, sorry. Each patch should be
reviewable and acceptable in its own right. The maintainer might not
like your patch #3 for whatever reason, and reject it. Now, if your
patch #2 is not acceptable without patch #3, it has to be rejected as
well.

The whole point of splitting patches is because smaller patches are
easier to review. If your patches are not independent and I need to
read patch #3 to find out whether patch #2 is acceptable, then all the
benefit is lost.

> > > +static int lm75_probe(struct i2c_client *client)
> > > +{
> > > +	struct lm75_data	*data;
> > > +	int			status;
> > > +	u8			set_mask, clr_mask;
> > > +	int			new;
> >
> > Please use the same coding style for variable declarations that is use
> > in the rest of the driver: just one space between type and name(s).
> 
> That's ugly and hard to read, but ... ok.

No, the above is ugly and hard to read :p And more importantly, is
rarely used in the kernel tree, and not at all in the hwmon drivers.

> > > +	/* NOTE:  also need to ensure that the chip is in interrupt mode
> > > +	 * in various cases, and maybe handle SMBALERT#.
> > > +	 */
> >
> > This comment doesn't make any sense to me.
> 
> In what way?  When the chip's IRQ is wired up, that should
> be handled ...

If you "need" to do it, and your patch doesn't, then we can't accept
your patch, can we? ;) What confuses me is that the comment doesn't
correspond to any code, and looks more like an item of your personal
to-do list having leaked into public source code.

> > > +	/* configure as specified */
> > > +	status = lm75_read_value(client, LM75_REG_CONF);
> > > +	if (status < 0) {
> > > +		dev_dbg(&client->dev, "can't read config? %d\n", status);
> >
> > Please uppercase the first letter, and add parentheses around %d. Just
> > because it's a debug message doesn't mean it doesn't have to look
> > nice ;) BTW, shouldn't this rather be a dev_warn or even dev_err?
> 
> CodingStyle ch13 say no useless parens.

I didn't know about that rule, and I fail to see the point. Sometimes
having parentheses around the number makes sense, sometimes it doesn't.
Stating as a universal rule that parentheses should never be used is
silly. As a matter of fact, this rule doesn't seem to be respected at
all: grepping the kernel source tree for '(%d)' and its variants
returns more than 3000 occurrences.

I'll send a patch to remove this sentence from CodingStyle.

> Warn or error?  Why?
> 
> As a general policy, I avoid non-dbg messaging from driver probe
> faults.  They just waste object file space, except in systems
> which are misbehaving and thus need debugging.  When debugging,
> the first thing to do is enable debug messaging.  Then turn it off
> again when done, and the memory footprint goes back to "slim".

As someone doing Linux support for a living, I hate having to tell the
customer that they have to recompile their kernel with debugging
enabled before I can look into their problems. The above is a run-time
error, something that should not happen, but could if for example the
underlying I2C bus is broken. If it does, as a user, I would like to
know about it, without recompiling everything. The additional 32 bytes
or so, compared to the 13 kB of the lm75 driver, are negligible.

I'm not saying that we should bloat all out drivers with dozens of
useless log messages. But errors need to be reported as such, and in a
way which lets the users do useful reports.

> (...)
> Yeah ... and once that's all done, phasing out legacy binding
> can begin in earnest!

As far as hardware monitoring drivers are concerned, I don't know how
this is going to happen at all.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
