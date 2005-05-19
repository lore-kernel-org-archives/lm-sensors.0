From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Some thoughts about the sysfs interface (repost)
Message-Id: <20031116164500.490652e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109125157.51f9d552.khali@linux-fr.org>
In-Reply-To: <20031109125157.51f9d552.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > 1* Most entries are described using sentences like "Fixed point
> > value in form XXXXX and should be divided by 1000 to get degrees
> > Celsius". I don't understand the "fixed point" thing, nor do I
> > understand the informational value of "in form XXXXX". Wouldn't it
> > be much clearer to write "Integer value, thousandth of degrees
> > Celsius"?
> 
> They are pretty much the same thing, right?  Either way is fine with
> me.

Yes, that means the same (or I wouldn't propose it as a replacement).
But it sound more understandable to me. I might not be a genius, but it
took me some time before I understood what it was supposed to me - and I
am in the sensors business for quite some time now. So I suppose that a
newcomer would feel as confused as I first was. Especially, the "in form
XXXXX" part has no particular sense I can think of. I'd go for either
"fixed point value, 3 digit fractional part, in degrees Celsius", or
"integer value, in thousandth of degrees Celsius", the one you like
better.

> > 2* temp_min[1-3] reads: "Temperature min or hysteresis value.". This
> > is a Bad Idea (TM) IMHO. One very interesting point in the sysfs
> > interface over the procfs one is that it could be easily be made
> > chip-independant(libsensors and sensors could then be drastically
> > simplified). If the file is named temp_minN, it has to be a min
> > temp. Be it a hysteresis one, let's call the file temp_hystN
> > instead. It's in no way harder to do it that way, and it will be way
> > easier for the interface users(includind ourselves) if we stick to
> > the one name, one use philosophy.
> 
> Ah, I like this proposal, it makes a lot more sense.  Care to also fix
> up the drivers that are in the current 2.6 tree to follow this rule?

Greg, Greg... You are soooo predictable ;) OK, will do.

> As you stated, this has some problems.  I think we should probably not
> do this for now, and if we have some real compilcated chips in the
> future, that we need these changes for, we can revisit it.
> 
> Sound ok?

Not really. I'd prefer if we could decide ourselves for an interface we
could stick to for the next 10 years or so (yes, I'm a dreamer). If such
a chip exist someday, we'll have to fix *all* the existing drivers to
match the new interface. Or at least the ones that use either critical,
either hysteresis - and that's most of them.

I would tend to think that Mark Hoffman's point of view should be
considered. It matches one of my proposal, and guarantees that what a
sysfs file does is all in its name. This is a requirement if we want
libsensors to be simplified and free of chipset-dependant code. The only
thing it breaks is the one-one link between sysfs file and hardware
register, but that's not a high price to pay if you consider what we get
in exchange.

> > --- linux-2.6.0-test9/Documentation/i2c/sysfs-interface
> > +++ linux-2.6.0-test9/Documentation/i2c/sysfs-interface.lm83
> 
> Should I still apply this patch?

Yes, that's a different problem. The LM83 has 4 temperature channels
while the maximum specified in the docs is 3. The patch mostly fixes
that. Since it was already applied to our CVS docs, you can apply it on
your side too. That said, it doesn't really make sense before you also
apply the lm83 driver patch, which is delayed if I remember correctly.

If you prefer that I integrate this patch into the one I'll do for the
min vs. hyst thing, I can do that too. But I heard you prefer many small
patches over one big ;) (OMG am I really so evil?)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
