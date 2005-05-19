From: dconradin@gmx.net (Detlef Conradin)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-i810.c
Message-Id: <Pine.LNX.4.21.0307191049170.2687-100000@conradin.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
In-Reply-To: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > the same in 2.7.0 and 2.8.0. Only the get family was changed. Please
> > > take a look at the attached patch and tell us if reverting this part
> > > is enough to get the driver to work again for you.
> > Then I will have 2.7.0 again... And this version doesn't work, as
> > stated in my first message.
> No, no. There have been a *lot* of changes between 2.7.0 and 2.8.0. What
> I want you to do is revert a very small portion of these changes on your
> 2.8.0 version, and see what happens. If it is enough to make it work
> (which means it is functionally equivalent to the changes you proposed),
> it would give us a point to start from.
Of course... But i'm sure the problem is in getsda, setsda, getscl or 
setscl. Since 2.7.0 didn't work at all, although the bit_test passed.
It makes IMHO no senso to check this patch....

> > > Also, could you tell us which chip driver is used for your tv
> > > encoder? And is your monitor DDC capable or not?
> > No my monitor is not DDC capable.
> i2c-algo-bit's bit_test failing is normal in this case, this is even the
> wanted behavior. Or what would this parameter be useful for?
1. i2c-algo-bit's bit_test failed for both busses.
2. I don't think that this is the normal case. The bit test just checks
   wether it is possible setting the clock and data line to high or
   low. This should also work without any connected device if the
   manufacturer didn't force the line to be high (or low) by some 
   electrical circuit. But then the bus would not be usable anymore.
3. i2c-algo-bit's bit_test succeds with my patch on both busses.

> We don't really have such a directory, but we still can give the patch
> to anyone contacting us with the same problem as you have.
Would be a possibility....

> Yeah of course, I understand. It's always great to solve that kind of
> problem and you are very welcome to share your experience with us. All I
> meant is that we can't apply patches just because one use says it works
> for him/her. We need to know why it works, especially if the change does
> not match the specs, as it seem to be the case here.
Okay ......


