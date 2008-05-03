From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 15:48:54 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-git] lm75: add new-style driver
Message-Id: <20080503174854.45bab9fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805020940.04227.david-b@pacbell.net>
In-Reply-To: <200805020940.04227.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sat, 3 May 2008 08:20:41 -0700, David Brownell wrote:
> On Saturday 03 May 2008, Jean Delvare wrote:
> > > +enum lm75_type {		/* keep sorted in alphabetical order */
> > > +	ds1775,
> > > +	ds75,
> > > +	LM75,			/* UPPERCASE prevents INSMOD_1 conflict(!) */
> > > +	lm75a,
> > > +	max6625,
> > > +	max6626,
> > > +	mcp980x,
> > > +	stds75,
> > > +	tcn75,
> > > +	tmp100,
> > > +	tmp101,
> > > +	tmp175,
> > > +	tmp275,
> > > +	tmp75,
> > > +};
> > 
> > Do you really need that many different types? I though that some of
> > those parts were 100% compatible, at least as far as this driver is
> > concerned. The more different types, the more tests you'll have to do
> > at initialization time or even at run time.
> 
> ISTR most of them handle 12-bit encodings.  And it turns
> out that the probe() code has most need to know about the
> differences:  it's what will set up the state used by the rest
> of the driver.  (Albeit not in this particular patch...)
> 
> Re compatibility, I think explicit listings inside driver
> code lead to a lot less confusion and time wasted on writing
> needless drivers; and it also avoids wondering "is it *really*
> compatible?".  Plus it's easier to trust board init code that
> matches the schematics (and other board docs).

I didn't mean to object to having that many device names, only that many
different enum values. When 2 parts are 100% compatible, I think it
makes sense to have the two names map to the same enum value in
lm75_ids, so that later code can only check for one enum value instead
of 2.

But well it's up to you, that was only a suggestion, I don't care that
much.

> > > -	u16			temp[3];	/* Register values,
> > > +	s16			temp[3];	/* Register values,
> > 
> > This too doesn't seem to belong to this patch any longer.
> 
> First time you commented on that, and that bugfix has been
> in this patch for ages.  :)

Up to the previous version, the patch included min/max stuff and
wrappers for the conversions, so it made some sense to include this
change along. Now it no longer does.

> > > +	{ "tmp75", tmp75, },
> > > +	{ /* LIST END */ },
> > 
> > Trailing comma not needed - you can't grow the list beyond its end.
> 
> Doesn't hurt either.

Well, I think it does. A trailing comma is an invitation to add new
lines after it. The big fat comment you inserted somewhat mitigates
this, but still.

> I think adding new chip support to legacy driver side
> should be avoided.  ;)

So do I, but as long as the new-style drivers do not offer a way to
forcibly instantiate a device from user-space, we might have to do that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
