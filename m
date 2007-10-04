From: David Brownell <david-b@pacbell.net>
Date: Thu, 04 Oct 2007 03:34:42 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 3/3] lm75: use 12 bit samples
Message-Id: <20071004033442.6141E23942C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > (...)
> > > The rounding is there because the user doesn't know the resolution.
> > 
> > That could now be exposed...
>
> We do not have a standard sysfs file name for this, and quite frankly I
> don't see the value.

Me either; I was just pointing out that we now have the option.
(Since your "why bother rounding?" explanation was effectively
that the option wasn't available before...)


> > (...)
> > But I updated it to just say that it's "round away from zero",
> > which is "unusual".  The squirrely bit is that rounding should
> > be done on the fixed point binary value, although I don't see
> > any motivation for using "round away from zero" here.
>
> It's not rounding "away from zero" (whatever you mean with that
> expression).

It is; see http://www.diycalculator.com/popup-m-round.shtml for
a decent survey of rounding schemes.


>	It's just rounding to the nearest representable value, I
> see nothing unusual there. If you see anything else than regular
> rounding, that would be a bug, please explain and we'll fix it.

No, it's not "Round-Toward-Nearest" since it considers the sign of
the orignal value, and changes the rounding direction accordingly.
That's what makes it "Round-Away-From-Zero" rather than one of the
more typical rounding schemes.


> > (...)
> > > The original code was stripping away the undefined bits, while yours
> > > doesn't. You can't assume that these unused bits will always be 0. So it
> > > matters to divide first and multiply last, taking the effective chip
> > > resolution into account. Please fix.
> > 
> > No can do ... that's where the fractional precision is stored!
> > Dividing by 256 would discard all fractional bits, producing
> > a resolution of 8 bits not (max) 12.  These routines are set
> > to handle arbitrary resolution, not just 9 bits.
> > 
> > I can mask off those low order bits though.
>
> You could do it, it's mathematically doable.

Only by discarding the fractional precision, unless you mean to
imply changing the representation first.  (And there's no point
to doing that, near as I can tell.)  But the point of these
new conversion routines is to use *all* the available precision.


>	Masking the unused bits
> afterwards as you plan to do is probably more efficient and cleaner
> though.

The followup patch did exactly that:  mask after converting from
signed millidegrees to signed binary fixed point.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
