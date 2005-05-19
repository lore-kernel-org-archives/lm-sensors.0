From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: i2c-algo-bit timing
Message-Id: <3DF66EB2.1D0D8948@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kyosti
(sorry, don't know how to make the dots over the o!),

thanks for the notes and the opportunity to make comments.

As I've already said, I like the 50/50 duty cycle, with 
1 ns hold and (udelay - 1) setup. That's the way it should be.

One question - is clock low time = udelay at end of a
read, including end of i2c_inb and i2c_stop? it looks to me like
it's only Tmin + Tmin? 

One other general comment - sdalo() and sdahi() could be deleted
and inlined into test_bus(), which is the only place they're used?

Other comments below.

Ky?sti M?lkki wrote:
> 
> On Sun, 1 Dec 2002, Ky?sti M?lkki wrote:
> 
> > First, included gzipped patch against latest CVS, it's my current local
> > work I told I would not commit before release and round for comments.
> >
> 
> Some notes to comment on the changes in the patch..
> 
> I have been reading the "Fast Mode" specs to test my setup, at some
> points the 1 us I use violates this.

Disagree. If you think about it, the max hold spec really only applies
when you are an i2c slave. When you are a master and driving the clock,
you can exceed the max hold time since you are essentially
"extending the clock low time" as described in the footnote.
If 1 us > 0.9 us spec is a problem, then we certainly have a
problem now with a hold time = udelay.

> 
> For debug use, we need adapter name from i2c_adapter everywhere.
> Current debugging is useless, while the original was simply
> incomprehensible. Sorry about the misspelling.
> 

Agreed that it wasn't very good in the past.

> Improved symmetry; outb/inb now both handle the acknowledge timeslot.
> Sendbytes/readbytes only loop over the buffer and test for failures.
> Pass i2c_msg->flags deeper down to support more i2c mangling.
> 

Sounds good.

> The i2c_adapter->retry now applies to complete message. Previously
> it would fail on any [NA] after the address [A].
> I am not 100% sure how auto-incrementing EEPs will tolerate it,
> if we fail in the middle of a page and then resend from the beginning.
> 

We may want to think about this more. Or maybe do something different
on reads than on writes. We don't want to corrupt eeproms.

> A message may be sent correctly after ignored [NA], retry or timeout.
> The caller could check this in i2c_msg->err, if necessary.
> 

OK. But the whole mechanism of saving and checking the error, etc. is somewhat elaborate,
not sure if useful or not. If you look at the smbus-layer calls (which in turn use
the "emulation layer" if the adapter is i2c-only), errors aren't returned at all.
Which isn't great but that's the way it is now. In fact we have a two-year-old ticket
(#517 http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticketQ7 )
asking for improvement. I don't have any answers, just wondering if anybody
has a "vision" (!) on error handling and whether the changes in i2c-algo-bit
fit that vision. 

> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
