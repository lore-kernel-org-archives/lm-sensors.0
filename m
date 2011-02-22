From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 22 Feb 2011 16:39:40 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110222163940.GG343@caffeine.csclub.uwaterloo.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 19, 2011 at 11:51:59AM +0100, Jean Delvare wrote:
> Hi Lennart,
> 
> Please send hwmon patches to the lm-sensors list, as specified in
> MAINTAINERS.

Hmm, I looked through there and thought I had found the right address.

> On Fri, 18 Feb 2011 14:30:00 -0500, Lennart Sorensen wrote:
> > The LM75A can not be detected with the same logic as previous LM75
> > designs.  Previous designs would return the last value read when an
> > unused register was read.  The LM75 returns 0xff when an usesed register
> > is read and it also has a new identity register.
> > 
> > This patch adds the new detection logic for the LM75A, allowing the lm75
> > driver to correctly detect the presence of an LM75A as well as older
> > LM75 designs.
> 
> Do you actually need to _detect_ an LM75A device? The only reason why
> the lm75 driver originally detected the LM75 was because it was very
> popular as a hardware monitoring chip on PC mainboards. This was in
> years 1998-2001, the LM75 is no longer used for this purpose on modern
> PC mainboards. So I would be very surprised if an LM75A was used on PC
> mainboards.

Not everything is a PC.  It is still a very common chip on embedded
systems.

> For embedded systems, or graphics cards, the preferred way is to
> explicitly instantiate the I2C device. Can't just you do this?

No, not really.  Auto detection just works, and the only reason I did
this patch is that natsemi is apparently discontinuing the original
LM75s ands starting to ship this new one, so existing designs now have
to start using this new slightly different one.  The coldfire (m68knommu)
doesn't have any board info to specify chips, unlike say powerpc where
it is easy.  I wish we didn't have to go to a new chip, but apparently
we get no choice.  I really don't want to have to design a bunch of
new code to handle detection and registration of lm75 chips with the
driver in user space, when this used to just work before the new chip
version happened.

> > Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> > 
> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > index f36eb80..6d04cf6 100644
> > --- a/drivers/hwmon/lm75.c
> > +++ b/drivers/hwmon/lm75.c
> > @@ -250,23 +250,40 @@ static int lm75_detect(struct i2c_client *new_client,
> >  	   addresses 0x04-0x07 returning the last read value.
> >  	   The cycling+unused addresses combination is not tested,
> >  	   since it would significantly slow the detection down and would
> > -	   hardly add any value. */
> > +	   hardly add any value.
> > +
> > +	   The LM75A is different.  It has an id byte of 0xaX (where
> > +	   X is the chip revision) in register 7, and unused registers
> > +	   return 0xff rather than the last read value. */
> 
> Maybe this holds for the National Semiconductor LM75A, but not for the
> Philips/NXP variant, at least according to the datasheet (no device ID
> register.)

Well the LM75B and LM75C didn't have one either, and they still work
fine given I did not remove the old detection method.

> >  
> > -	/* Unused addresses */
> >  	cur = i2c_smbus_read_word_data(new_client, 0);
> >  	conf = i2c_smbus_read_byte_data(new_client, 1);
> > -	hyst = i2c_smbus_read_word_data(new_client, 2);
> > -	if (i2c_smbus_read_word_data(new_client, 4) != hyst
> > -	 || i2c_smbus_read_word_data(new_client, 5) != hyst
> > -	 || i2c_smbus_read_word_data(new_client, 6) != hyst
> > -	 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> > -		return -ENODEV;
> > -	os = i2c_smbus_read_word_data(new_client, 3);
> > -	if (i2c_smbus_read_word_data(new_client, 4) != os
> > -	 || i2c_smbus_read_word_data(new_client, 5) != os
> > -	 || i2c_smbus_read_word_data(new_client, 6) != os
> > -	 || i2c_smbus_read_word_data(new_client, 7) != os)
> > -		return -ENODEV;
> > +
> > +	/* First check for LM75A */
> > +	if ((i2c_smbus_read_byte_data(new_client, 7) & 0xf0) = 0xa0) {
> > +		/* LM 75A returns 0xff on unused registers so
> > +		   just to be sure we check for that too. */
> 
> This is definitely a good idea. 4 bits for the device ID is weak, other
> devices could match. In fact I think we should check all 8 bits for
> value 0xa1, as this is what is documented in the datasheet.

Well the datasheet says 0xa is the ID, and 1 is a revision.  If you want
to fail as soon as they make a new revision, well fine, but I consider
that a bad idea.  The ID really is only the first 4 bits though.  I can
change that if you want, but I am not personally in favour of it, just
in case they do ever update the revision.

I am a bit peeved at natsemi for claiming to have a fully compatible
chip, when the new chip is completely incompatible with how people have
detected their existing chip for years.  Now existing software releases
won't work with new hardware builds because I have to update this
driver first.  How annoying.

> > +		if (i2c_smbus_read_byte_data(new_client, 4) != 0xff
> > +		 || i2c_smbus_read_byte_data(new_client, 5) != 0xff
> > +		 || i2c_smbus_read_byte_data(new_client, 6) != 0xff)
> > +			return -ENODEV;
> > +		hyst = i2c_smbus_read_word_data(new_client, 2);
> > +		os = i2c_smbus_read_word_data(new_client, 3);
> > +	} else { /* Traditional style LM75 detection */
> > +		/* Unused addresses */
> > +		hyst = i2c_smbus_read_word_data(new_client, 2);
> > +		if (i2c_smbus_read_word_data(new_client, 4) != hyst
> > +		 || i2c_smbus_read_word_data(new_client, 5) != hyst
> > +		 || i2c_smbus_read_word_data(new_client, 6) != hyst
> > +		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> > +			return -ENODEV;
> > +		os = i2c_smbus_read_word_data(new_client, 3);
> > +		if (i2c_smbus_read_word_data(new_client, 4) != os
> > +		 || i2c_smbus_read_word_data(new_client, 5) != os
> > +		 || i2c_smbus_read_word_data(new_client, 6) != os
> > +		 || i2c_smbus_read_word_data(new_client, 7) != os)
> > +			return -ENODEV;
> > +	}
> >  
> >  	/* Unused bits */
> >  	if (conf & 0xe0)
> > 
> 
> Your patch is incomplete, it should set the name to "lm75a" for the
> LM75A. Also, later in the detection routine, address cycling is tested
> of offsets 1, 2 and 3, it would make sense to do the same for offset 7
> (device ID) for the LM75A.

Hmm, good point.  I can fix that.  I wasn't sure if the name was supposed
to indicate the driver or the chip.  So if I fix the address cycling
check, and change the name to lm75a when detected, and possibly fix the
ID/rev check to include both, would that help?

-- 
Len Sorensen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
