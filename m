From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Some thoughts about the sysfs interface (repost)
Message-Id: <20031116162516.0d202025.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109125157.51f9d552.khali@linux-fr.org>
In-Reply-To: <20031109125157.51f9d552.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> A fixed point number is not "just" an integer.  It has a whole part
> and/or a fractional part.  The location of the split is "fixed" as a
> matter of interpretation, nothing more.  E.g. the LM75 temperature
> reading is in 9 bits, with the LSB representing 0.5 degrees C.

Thanks for the clarification. I had never seen fixed point arithmerics
that way before. I must have been troubled by the fact there was no
(visible) dot, so it couldn't be anything but an integer.

This doesn't make the "in form XXXXX" clearer. Wouldn't something like
"with a 3 digit fractional part" be better?

The fact that fixed point binary representation cannot easily be
converted to and from fixed point decimal representation adds to (my)
confusion. What motivated the choice of fixed point decimals? Fixed
point binaries would have been faster since this is how chipsets do
work. But I agree it would have been less easily readable from sysfs.
That said, users are not supposed to browse sysfs to get the hardware
monitoring information for their system.

> > informational value of "in form XXXXX". Wouldn't it be much clearer
> > to write "Integer value, thousandth of degrees Celsius"?
> 
> I like to document fixed point representations this way, e.g.:
> 
> /* temp: 0.5C/bit (-55C to +125C) */

Do you suggest we could say something like "temp1_input: 1mC/bit"? Using
"bits" here isn't really natural since we are in fixed point decimals.
This is why speaking of integers in a given unit (millidegree Celcius
here) makes more sense to me. But it might be just me.

> So, just make two absolute hyst values which are linked... a change in
> one forces a change in the other.  Userland s/w should not assume any
> sensors sysfs file to be static anyway.  It might be a little
> suprising to the user - just document it as the hardware limitation
> that it is and move on.

I would prefer it that way too, or at least I do think so at the moment.

> (1) I like this.  It greatly simplifies the userland side. 
> Ultimately, we should be able to add a chip driver and have immediate
> library support for free, just by sticking to these conventions.

This is precisely what I am after (and what I believe the sysfs
interface was intended for from the very begnining).

> > The drawbacks of the second
> > method are: we break the one-one link between sysfs and the hardware
> > (which helps a lot to understand how a chip works, IMHO), we create
> > more
> 
> Yes, but it's either that or make userland more complicated.

You got it, there's a choice to make. I believe that a simplified (and
over-standardized) interface with user-land would be great enough to
allow for some sacrifices.

That said, it would obvisouly require some changes to existing drivers.
At least my lm83, not taken a look at the others yet.

Thanks a lot for your insights and opinions.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
