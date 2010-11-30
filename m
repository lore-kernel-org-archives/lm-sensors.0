From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 30 Nov 2010 15:50:41 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101130155041.GA27044@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 30, 2010 at 03:04:59AM -0500, Gabriele Gorla wrote:
> On Mon, Nov 29, 2010 at 06:29:08PM -0800, Phil Pokorny wrote:
> > Thanks for the patch.
> > 
> > On Mon, Nov 29, 2010 at 5:49 PM, Gabriele Gorla <gorlik@penguintown.net>wrote:
> > 
> > > Prevent setting fan_div from stomping on other fans that share the same i2c
> > > register.
> > >
> > 
> > Ugh...  Wow, that was clearly wrong logic now that you point it out...
> 
> :-)
> 
> 
> > > Also allow div=1 (this is allowed in the ADM1026 datasheet)
> > 
> > 
> > The old code didn't throw an EINVAL on most invalid divisors, it just
> > silently converted them to the next reasonable value in the way that
> > DIV_TO_REG worked.  If you're going to change the behavior and throw EINVAL
> > for divisors greater than 8, perhaps you should check explicilty for the
> > four legal values (val != 1 && val != 2 && val != 4 && val != 8)
> 
> the original code would refuse setting div to 1 since DIV_TO_REG(1) = 0
> I changed to return -EINVAL for values not in the 1-8 range.
> Anything in between gets the old behavior. If you think I should change to 
> allow only 1,2,4,8 I can send another patch.
> 
> > Then you could eliminate the new_div DIV_TO_REG/REG_TO_DIV conversions and
> > just test fan_div[nr] against val.  That would eliminate the "new_div"
> > variable which would be good since it doesn't actually hold a "div" but a
> > "reg" value, so it's somewhat mis-named.
> 
> 
> > > and prevent the mutex lock
> > > when no update is necessary.
> > >
> > If you don't take the mutex before testing the fan_div, then isn't there a
> > possible race where you test first, but then it changes before you take the
> > mutex to "change" it?  Is there any possible harm?  If multiple threads are
> > trying to set the same divisor or different divisors for the same or
> > different fans?  Just thinking out loud...
> 
> updates to data->fandiv[x] are atomic as there are no read-modify-writes to the 
> structure members. If the values changes between the test and the lock, it will 
> just be replaced with a new value.
> The lock will take care of multiple threads trying to change div values for different 
> fans. 


> If multiple threads change the div to a different value for the same fan, I think, 
> even with the lock around the entire function, it will not be possible to figure out 
> which value will end up in the register at the end.

The value is well defined: The last thread to acquire the lock wins.

> Let me know what you think.
> 
Problem occurs if the 1st access (the one holding the lock) changes the value for
a fan and the second tries to change it back to the old value. As a result of your code,
the change will happen, but the revert to the old value may be ignored (if fan_div was
not yet updated by the time the if() statement outside the lock is executed).
This is not ok, since it changes execution sequence. The if statement should be inside
the lock.

The argument about unnecessary locking is really irrelevant; this code is not executed often
enough to warrant introducing a race condition.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
