From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <qN571diF.1106130129.6907070.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Axel & all,

> > 1* We would need a list of versions of lm_sensors that existed to be
> > picked from.
>
> Yes, I had forgotten to place some versions to play with. I added some
> to "bus drivers" as a demo.

This raises another point. If we go with multiple "products", this
suggests that each one has its own set of versions, right? It doesn't
quite work (simply becuse what we have are products, but components). I
don't quite feel like adding each new version 4 times. Is there a way
around this?

Also, the versions show older first, I guess it would make more sense
with newer first?

> > 2* I would replace Platform with Architecture, and list there all
> > architectures supposedly supported by lm_sensors (+ "other" just in
> > case).
>
> Which are these? i386 and x86_64?

And alpha and ppc, and sparc64 at least. I *think* that's all for now,
but the list may grow later if needed.

> > 3* I don't feel a need for a Priority setting. Severity should be
> > sufficient.
>
> I think this cannot be dumbed. It is also a bit different. A blocker
> severity in a development version could be of lower priority than a
> major serverity of security issues in a released version. Or you could
> move an enhancement at higher priority than a trivial fix etc.

I understand the difference between priority and severity. What I meant
is that we have no need for priorities due to the way we work. We have
no roadmaps for the releases. Basically we release a new version every
three months or so, with no named goal in mind. And, when there are high
priority tasks, they are usually not bug reports so they won't show in
bugzilla.

> Unconfirmed means it may be not a bug at all. New means it is a bug
> but has not yet been assigned to anyone. You can drop the unconfirmed,
> I currently set it up for having to vote (with one vote) to make a bug
> new. Personally I don't think voting in general makes sense, but I
> left it for playing.

Frankly I don't count on the reporters to properly fill this. People are
always sure that hey found a bug - it is then up to us to make them
realize it might be something different.

I agree that the votes don't make much sense at least for us. We don't
have a sufficient volume of users and reports to take benefit of it.
Better let users add a "me too" comment on an existing comment when
they want us to take a look at a specific bug.

> flags can be used for example to ask for a review before commiting
> something. check out the example on
> http://www.bugzilla.org/docs/2.18/html/flags-overview.html

Ah, that's nice, especially for patches. We don't have a need for these
right now but I guess that switching to bugzilla will change the way
people report bugs, which in turn may change the way we work. Time will
tell.

> > Is QA Contact something different than the default assignee for this
> > category? If yes, I don't think we need this.
>
> It's the supervisor of the poor assignee, I also don't like him ;)

We don't need this at all then.

Another point: migration of the exiting base. Phil, I guess this would
fall under your responsability? I guess we would need some script that
can access both the old base (in pgsql) and the new one (I guess in
mysql) and transfer all the tickets. It is particularly important that
ticket numbers are preserved. Then the attributs of each ticket have to
be set manually since I can't think of a way to automate this. I guess
we would also need a special user for these imported tickets since we
won't possibly create accounts for all previous reporters.

Thanks,
--
Jean Delvare
