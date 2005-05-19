From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040104191349.GE30841@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-01-03 22:22:50 +0100]:
(replying to mds)

> > - tickets don't get forgotten or overlooked
> 
> They aren't answered in real time either. But I agree that they are less
> likely to be forgotten. The problem is that by the time we answer them,
> it's likely that the poster has solved the problem on its own, or has
> given up and won't benefit our help. So we are working for nothing
> (unless the solution is obvious and it can help future users browing the
> ticket base).

See [1] below.

> > - tickets are a real database that we control, easily searchable using
> > tools we control
> >   (as opposed to relying on google for the mail archive)
> 
> I can search the mailing-list directly in me e-mail client. And it seems
> to me that Google is doing a decent job on the mailing-list, while on
> contrary it cannot access the tickets if I'm not mistaking.

I definitely find it easier to search the mailing list than the database,
nevermind who controls what.

> > - searchable tickets allows users to help themselves and reduces
> > traffic on mailing list

See [2] below.  I don't see how reducing traffic on the list is a meaningful
goal.

> Likewise, we could point them to the mailing list archive. I don't think
> it'd change anything for them.
> 
> > - having a real bug tracking system is the essence of a
> > "professional" project
> 
> I agree there too. But our system isn't working as it should. See below.

The _definition_ of a professional project is that its developers get paid.
[1] This project does not pay me enough to "not forget" some bug reports, 
especially when more than half are correctly answered by "read the FAQ".

If anyone out there thinks that sounds harsh... I have some work on my
house that I'd like you to do for free.  What list should I put it on
to make sure you don't forget it?

> > Our ticket system has problems (need more of us using it, need a
> > method for followups); maybe something else would be better, but
> > email-only is a big step backwards.
> 
> As long as users cannot update their tickets, the ticket system
> efficiency will be limited. The users "complaining" about this on the
> list are countless. This is the main reason why I don't like this
> system: half of the time it ends up on the list anyway, so we have to
> both answer there and update the ticket - doubles the work.
> 
> A more interesting system would allow users to update their ticket *and*
> to answer other tickets. If any user could help any user, this would for
> sure reduce the amount of time we have to spend for support. But one

[2] This is the difference between "user" and "developer" mailing lists.
The need for this is apparent as well... go and search the user message
boards of mainboard makers for "lm_sensors" and see how often users do
in fact help themselves.

> drawback is that we also would miss problems, unless we regularly browse
> the growing ticket base, what I don't do and franckly don't plan to do
> (because yes, I'm lazy in a way).

I'm not advocating the ticket system be shut down (although I wouldn't be
opposed).  At the same time, I'm not about to be obligated to write
"read the FAQ, increase your fan_div" again and again just to tick off
some check-box.

You know, if we were truly interested in killing that particular nonsense,
we'd auto-increment the fan_div until we got a non-zero reading or we hit
the max.  Then the first set to a fan_div turns the feature off; that
would allow sensors.conf/sensors -s to override.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
