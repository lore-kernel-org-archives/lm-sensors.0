From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Bugzilla
Message-Id: <20050319174457.202c104a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3Xg1uAGB.1110214165.5308430.khali@localhost>
In-Reply-To: <3Xg1uAGB.1110214165.5308430.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> > Would it be possible to tell Bugzilla to start at ticket #2000? That
> > way the new tickets wouldn't overlap with the older ones.
> 
> Yes, that's possible.
> 
> Is other than that the bugzilla instance OK?

Just taking a closer look to make sure, and in fact I don't think so. In
the current setup, we still have different versions for each "product",
were products are "bus drivers", "chip drivers", "i2c core drivers" and
"user-space". It makes very little sense to me. All these are parts of
the same product, and versions are common to all these parts. Isn't it
possible to do that? I think I remember this was discussed already but I
cannot remember the outcome.

Other than that, I would ask for:

* Less priorities. 7 priorities is too much. I think we could get rid of
blocker (critical will do), trivial and enhancement (minor will do).

* No target milestone. I see little use for these in our project.

* No OS. It is a Linux-only product anyway.

* No priority. Priorities might make sense when people are paid for
support. We are not. We fix things when we feel like it.

* No status whiteboard. What is it for?

* No bug aliases. No use.

Do we need a QA contact? Again, sounds overkill for our project.
Assignee should be sufficient.

What is the URL for? Can't users just include URLs in their comments if
they need to?

I guess you've understood that what I really want is that we keep things
as simple as possible. 10 needless fields are likely to frighten the
users and potential helpers. If we can stick to what is really needed,
I'd expect the support to be easier for everyone.

Thanks,
-- 
Jean Delvare
