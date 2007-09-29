From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Sep 2007 20:33:16 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 3/3] lm75: use 12 bit samples
Message-Id: <20070929223316.49bcc9f6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 27 Sep 2007 16:02:03 -0700, David Brownell wrote:
> >	The lm75 driver caches
> > the sampled temperature value for 1.5 second, so assuming that the chip
> > stops converting when I2C transactions are in progress (the LM75 does
> > that!), it is crucial that the conversion takes less than 1.5 second.
> > And a resolution of 0.0625 degrees C is probably better than most
> > people need anyway, 0.125 degree C is already very nice to have.
> 
> Not all chips that take 12 bit samples (0.0625) can take 11 bit
> samples (0.125) ... what drawback could there be in using that
> extra bit?

None, you're right.

> (...)
> > The rounding is there because the user doesn't know the resolution.
> 
> That could now be exposed...

We do not have a standard sysfs file name for this, and quite frankly I
don't see the value.

> (...)
> But I updated it to just say that it's "round away from zero",
> which is "unusual".  The squirrely bit is that rounding should
> be done on the fixed point binary value, although I don't see
> any motivation for using "round away from zero" here.

It's not rounding "away from zero" (whatever you mean with that
expression). It's just rounding to the nearest representable value, I
see nothing unusual there. If you see anything else than regular
rounding, that would be a bug, please explain and we'll fix it.

> (...)
> > The original code was stripping away the undefined bits, while yours
> > doesn't. You can't assume that these unused bits will always be 0. So it
> > matters to divide first and multiply last, taking the effective chip
> > resolution into account. Please fix.
> 
> No can do ... that's where the fractional precision is stored!
> Dividing by 256 would discard all fractional bits, producing
> a resolution of 8 bits not (max) 12.  These routines are set
> to handle arbitrary resolution, not just 9 bits.
> 
> I can mask off those low order bits though.

You could do it, it's mathematically doable. Masking the unused bits
afterwards as you plan to do is probably more efficient and cleaner
though.

> (...)
> > > +	} else if (strcmp(client->name, "ds75") = 0
> > > +			|| strcmp(client->name, "mcp980x") = 0
> > > +			|| strcmp(client->name, "tmp100") = 0
> > > +			|| strcmp(client->name, "tmp101") = 0
> >
> > Please align things better than that.
> 
> It *is* aligned.  All tabs, per CodingStyle.

It is indented, but not aligned. There's nothing wrong with using tabs
followed by spaces for alignment, as long as the amount of spaces is <
8. Just try and run scripts/checkpatch.pl on your patch, you'll see it
doesn't complain. So I have to insist, please align your code to make
it look nicer, as everybody else does.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
