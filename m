From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <Hz2U7XO0.1111750059.5582830.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> >It is blocked. It will wait until the lock is released and can be
> >acquired again. This is why forgetting to release a lock leads to a
> >driver lockup.
>
> readers don't check or take the lock?  only set_something callbacks?

If you look at the code, readers call the update function, which requests
the lock. Reader callbacks do never access the chip directly.

> > I will (try to) provide patches for the following drivers today: lm63,
> > lm80, lm83, lm87, lm90, lm92, pc87360.

All done. I'll go on with the lm 75, lm77 and lm78, so that the lm
series is all done. I'll take care of both smsc drivers as well, and
the adm1025 since it's not on your list.

> Then I go check ones didn't appear on survey list because they use
> different names.  Oh, they are off my list, they're yours? :)

Correct. The grep command you used was quite arbitrary, and the drivers I
wrote or ported myself happened not to get matched.

> my work list list at:
> http://scatter.mine.nu/lmsensors/list-driver-write-locking-check
>
> will add others to it as I see patches appear, just to scoreboard
> progress on locking issue.

That's nice, please keep it up-to-date. You could name the person who
worked on each driver (i.e. you or me so far) so it is easier to spot
misses.

> semi-related:
> I need a policy call on adm1026, adm1031 as they don't comply
> with other drivers data store, saving fan_div other than 0..3
> value.  It make fan_div update needlessly complex and different
> to other drivers I've encountered so far.  The conversion of
> 0..3 to 1,2,4,8 is a single '<<' operation, the reverse is more
> complex if-then-else-if-then-else... statement only needed once
> in other drivers.

That's a different issue, please don't merge it in there. Best patches
change only one thing, so that they can easily be reviewed, applied,
ported and reverted if needed. I know it's hard not to fix things as
you see them. I had to refrain myself from doing some changes to the
drivers I just worked on. Just take notes, and do the other changes
later. Even your via686a patch (which by the way won't apply here?)
does two things at once, which is no good. Ideally, we should be able to
prepare a big patch fixing all locking issues, and doing only that. The
rest can be done before, or later.

Thanks,
--
Jean Delvare
