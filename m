From: David Brownell <david-b@pacbell.net>
Date: Thu, 27 Sep 2007 23:02:03 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 3/3] lm75: use 12 bit samples
Message-Id: <20070927230202.42A73235187@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Make the lm75 driver so that use the best resolution available on
> > each chip it finds ... usually this is 12 bits (0.0625 degrees C),
> > though some chips only handle the original 9 bits.
>
> Is there no drawback to using the best resolution? Like the chip draws
> more current, or is slower to perform updates?

Docs say it's a bit slower, still within the 1.5 second boundary.
Some chips are faster with 12 bit sampling than others with 9-bit,
so there's no useful guideline there.

Since it's in continuous sampling mode, I can't see how this would
cause extra power drain.  A shorter sample times just means more
samples.  The way to take less power is to switch to a oneshot mode,
on chips which support that.


>	The lm75 driver caches
> the sampled temperature value for 1.5 second, so assuming that the chip
> stops converting when I2C transactions are in progress (the LM75 does
> that!), it is crucial that the conversion takes less than 1.5 second.
> And a resolution of 0.0625 degrees C is probably better than most
> people need anyway, 0.125 degree C is already very nice to have.

Not all chips that take 12 bit samples (0.0625) can take 11 bit
samples (0.125) ... what drawback could there be in using that
extra bit?


> > Note that this preserves the quirky "round away from zero" behavior
> > for converting temperatures to sensor values.  (I'd think no rounding
> > at all would be better.)
>
> The rounding is there because the user doesn't know the resolution.

That could now be exposed...


> Rounding properly ensures that we use the nearest possible value for
> every chip. Admittedly this becomes less useful when the chip happens
> to have a high resolution, in 12-bit resolution mode it is pretty
> useless.
>
> I have to admit that I wonder if anyone has ever really set a
> non-integer temperature limit, but given that some chips and drivers
> support that...

I certainly did that for testing purposes.  ;)


> > +	u16			round;		/* f(resolution) */
>
> I think it would be much clearer is you were storing the resolution
> itself.

Except that resolution isn't used anywhere outside of probing,
while rounding is used with all sysfs writes.


> > -	return LM75_TEMP_TO_REG(temp);
> > +	/* this "rounding" is squirrely but backwards-compatible */
>
> "Squirrely" isn't in my dictionary. 

Easily found on-line:

  http://www.m-w.com/dictionary/squirrelly
  http://www.bartelby.org/61/71/S0687100.html
  http://www.yourdictionary.com/ahd/s/s0687100.html

But I updated it to just say that it's "round away from zero",
which is "unusual".  The squirrely bit is that rounding should
be done on the fixed point binary value, although I don't see
any motivation for using "round away from zero" here.


> > +	temp += (temp < 0) ? -lm75->round : lm75->round;
> > +	return (temp * 256) / 1000;
>
> This is indeed quite tricky. It took me some time to admit that the
> rounding _may_ work properly, but I'm not even certain yet. You should
> really round just before you divide, to make it obviously correct.

At this point I'm sticking to what was there before ... if I were
to aim for correctness, I'd round the fixed-point binary value,
not the millidegrees value.


> More importantly, your code doesn't zero the unused bits. You should
> not assume that all chips will enjoy a 1 being written to these bits.
> The original code was properly zeroing unused bits, and I think you
> should do the same. I know that it means more computations, but that's
> the safe way.

OK, I'll just save a mask and use it.


> >  }
> >  
> >  static inline int reg_to_temp(s16 reg)
> >  {
> > -	return LM75_TEMP_FROM_REG(reg);
> > +	/* Use integer division instead of logical right shift to
> > +	 * preserve sign (compiler uses arithmetic right shift).
> > +	 */
> > +	return (reg * 1000) / 256;
>
> The original code was stripping away the undefined bits, while yours
> doesn't. You can't assume that these unused bits will always be 0. So it
> matters to divide first and multiply last, taking the effective chip
> resolution into account. Please fix.

No can do ... that's where the fractional precision is stored!
Dividing by 256 would discard all fractional bits, producing
a resolution of 8 bits not (max) 12.  These routines are set
to handle arbitrary resolution, not just 9 bits.

I can mask off those low order bits though.


> > +	/* for ds1175, use name "ds75". */
>
> Typo: ds1775. And the trailing dot is inconsistent with the previous
> comment ;)

Fixed.


> > +	} else if (strcmp(client->name, "ds75") = 0
> > +			|| strcmp(client->name, "mcp980x") = 0
> > +			|| strcmp(client->name, "tmp100") = 0
> > +			|| strcmp(client->name, "tmp101") = 0
>
> Please align things better than that.

It *is* aligned.  All tabs, per CodingStyle.


>		Also, why make tmp100 and tmp101
> separate names, when you decided to use ds75 for the ds1775 and tmp75
> for the tmp175 and tmp275?

Because the tmp101 issues SMBALERT# but tmp100 doesn't.
They're not as equilvalent as the other parts.


> > +			) {
>
> This goes at the end of the previous line.

OK, though that particular style makes adding values after "tmp101"
produce (needlessly) larger patches.


> > +	dev_info(&client->dev,
> > +		"%s: sensor '%s', resolution %d millidegrees C\n",
>
> Doesn't it make more sense to express it as 1/%d degree C, as you did
> in Kconfig?

Sysfs talks in milledegrees C.  If anything should change, it
should be Kconfig ... but I used a binary fraction there to
provide at least a strong hint that there will be rounding
issues, since this isn't a sensor which emits decimal units.


> > +		data->hwmon_dev->bus_id, client->name, data->round * 2);
>
> One more space for alignment.

Indents should be pure tabs...


Updated patch to follow.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
