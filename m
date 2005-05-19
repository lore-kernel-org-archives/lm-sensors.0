From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Some thoughts about the sysfs interface (repost)
Message-Id: <20031115044451.GA10074@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109125157.51f9d552.khali@linux-fr.org>
In-Reply-To: <20031109125157.51f9d552.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2003-11-09 12:51:57 +0100]:

> 1* Most entries are described using sentences like "Fixed point value in
> form XXXXX and should be divided by 1000 to get degrees Celsius". I
> don't understand the "fixed point" thing, nor do I understand the

A fixed point number is not "just" an integer.  It has a whole part and/or
a fractional part.  The location of the split is "fixed" as a matter of
interpretation, nothing more.  E.g. the LM75 temperature reading is in
9 bits, with the LSB representing 0.5 degrees C.

The computer representation of plain integers is an example of fixed point -
it just happens that there is no fractional part.

Here is a link with more formal language, if you're into that:

http://www.cs.tau.ac.il/~nin/mivne99/fp.htm

> informational value of "in form XXXXX". Wouldn't it be much clearer to
> write "Integer value, thousandth of degrees Celsius"?

I like to document fixed point representations this way, e.g.:

/* temp: 0.5C/bit (-55C to +125C) */

> 2* temp_min[1-3] reads: "Temperature min or hysteresis value.". This is
> a Bad Idea (TM) IMHO. One very interesting point in the sysfs interface
> over the procfs one is that it could be easily be made chip-independant
> (libsensors and sensors could then be drastically simplified). If the
> file is named temp_minN, it has to be a min temp. Be it a hysteresis
> one, let's call the file temp_hystN instead. It's in no way harder to do
> it that way, and it will be way easier for the interface users
> (includind ourselves) if we stick to the one name, one use philosophy.

Agreed.

> 3* One additional note about hysteresis temperatures (and critical
> temperatures also). Some chips have several temperature channels, but a
> single hysteresis and/or critical temperature register, common to all
> channels. For example, the LM83 has four temperature channels, four max
> values, but one single critical value. The ADM1032 has two temperature
> channels, two min values, two max values, two critical temperatures, but
> a single, relative hysteresis value that applies to both critical
> values.
> 
> I propose that chips that values that are common to all channels simply
> have no digit appended. That's how I made it in the lm83 driver.

No, I like your other approach better... (1)

> Now, for the hysteresis, that's more complicated, since not only it may
> apply to one or more channels, but it can also happen to one or more
> limit, and be relative or absolute. I think that hysteresis files should

Re: relative vs. absolute... this is a detail of the hardware that
doesn't concern the user.  Whatever the hardware, the driver interface
should use absolute temps. (Oops, then I kept reading...)

> be named after the limit they are an hysteresis for. In the case of the
> lm90 driver, we would have the following files:
>   temp1_input
>   temp2_input
>   temp1_min
>   temp2_min
>   temp1_max
>   temp2_max
>   temp1_crit
>   temp2_crit
>   temp_crit_hyst
> Note that the digit is also omitted, since the value is common to both
> channels. An hysteresis that would apply to all temperatures of one
> channel would be named "temp1_hyst". An hysteresis that would apply to
> more than one channel and more than one limit for each channel would be
> called temp_hyst. I think you get the idea.
> 
> Remains the problem of relative hyst vs. absolute hyst temperature. The
> docs say we should prefer absolute, but in the case of the lm90 driver,
> it isn't possible (because the hysteresis value applies to two critical
> limits that can have different values). The only thing I can think of is

*Sigh*  Sometimes it feels like there is a conspiracy of h/w designers
to break every least little abstraction we s/w people try to make.

So, just make two absolute hyst values which are linked... a change in
one forces a change in the other.  Userland s/w should not assume any
sensors sysfs file to be static anyway.  It might be a little suprising
to the user - just document it as the hardware limitation that it is and
move on.

> A very different approach would be to simulate as much values as we
> need, regardless of how many registers there are. In the case of the
> lm83 driver, we would have temp1_crit and temp2_crit instead of
> temp_crit, and both files would access the same register. The advantage

(1) I like this.  It greatly simplifies the userland side.  Ultimately,
we should be able to add a chip driver and have immediate library support
for free, just by sticking to these conventions.

> of this method is that all future chips will necessarily be supportable,
> which isn't the case with my first proposal. We could imagine a chip
> that has four temperature channels, one critical limit for channels 1
> and 2, and one critical limit for channels 3 and 4. That's something my
> first model doesn't handle, while the second does. I can say how likely
> it is to see such a chip someday. All other scenarios I can think of at
> the moment are OK with that first model. The drawbacks of the second

Agreed.

> method are: we break the one-one link between sysfs and the hardware
> (which helps a lot to understand how a chip works, IMHO), we create more

Yes, but it's either that or make userland more complicated.

> sysfs entries, and writing to a register might have side effects to the
> other registers (might be already happening in some cases anyway).
> Another good point is that it solves the relative hysteresis problem
> mentioned above.

Right, and possibly others.

> Other possibilities may exist (might involve symlinks for example). It
> would be great to come to a decision before going on with porting chip
> drivers, methinks.

Agreed - a little bit of thought now saves a lot of work later.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
