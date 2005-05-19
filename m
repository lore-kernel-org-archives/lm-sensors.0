From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: driver design question
Message-Id: <20030731093915.499480e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Quick note: The refresh frequency limit was introduced because the 
> > hardware would give bad results if you polled it too fast.  So, 
> > depending on what the datasheet for the chip says, we adjust the
> > max polling frequency to match.  So this was to ensure accurate
> > results from the hardware, not as a performace optimization.

> Take a look at the ADM1026 driver (by Phil P.) as a counter-example. 
> The update routine is apropos to this thread.  He uses two different
> refresh frequencies - the slower one for config data.  I thought this
> was a good idea when I first saw it.

Exactly what I had in mind. I didn't know someone else already did that
:)

After some more thinking however, I'm not sure it's what we really want.
We are talking (correct me if I'm wrong there) about data that should
not change *at all*, not data that should not change *often*. So
sampling their value every 5 minutes doesn't make much sense. If they
change and we are not aware of the change, it's likely to cause trouble
that will solve only up to 5 minutes later. The user will probably get
mad about this (by the time he/she tries to figure out what's wrong, the
problem will solve by itself). So I think we should opt for one of the
following policy:

1* We refresh these values as often as the other ones (what most of our
drivers do) and don't care about the performance cost. Play it safe,
Phil E. said.

2* We say these values should *NOT* change, we don't sample them, and if
something goes wrong, obviously it's not our fault (though the user will
certainly complain to us). We can enable a check (that is, sampling the
should-not-change data as in 1* and emit a warning if we see a change in
the values) in debug mode (or additional parameter?) to catch the
problem.

One more thought though: remember that these things are very unlikely to
happen. We have the adm1026 driver which as a different policy, now the
adm1025 has its own one too. These are good tests. If we have no bad
feedback about these, it must mean it's safe to change our global policy
to either of those.

> > Now, your point about reducing a significant amount of latency is a
> > good one.  That's a reasonable reason for such an optimization.  I'm
> > not sure if it is a strong enough reason, though.  I think we'd need
> > to do a little math to figure out exactly how much it 'costs' to
> > read limits and what it would save us to poll them less frequently.
> 
> It depends on the chip of course - but I think the ADM1026 driver
> might be a good model to follow for others which are deemed worth
> optimizing.

What about trying some real-life tests (that's what it's all about after
all)? I could try the different policies on the w83781d driver and
measure how much time module loads and data refreshs take.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
