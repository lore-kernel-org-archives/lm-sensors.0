From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 29 Dec 2005 22:33:30 +0000
Subject: [lm-sensors] project status and future
Message-Id: <20051229233330.063252ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AF1E4A.90902@sh.cvut.cz>
In-Reply-To: <43AF1E4A.90902@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael, Phil, all,

> On Wed, 2005-12-28 at 11:07 -0800, Philip Edelbrock wrote:
> > I've receintly been toying with Trac and importing a legacy bug database 
> > into it for another project.  It's a bug tracker and wiki.  You've 
> > probably used it before?
> > 
> > http://www.edgewall.com/trac/
> > 
> > What do you guys think of this?
> 
> As mentioned in my posting, I really like Trac. I already told it to
> Rudolf in IRC, but nevertheless: I'd be happy to help in case there are
> any questions/problems in case you guys want to try Trac for lm_sensors.

Well, if several of you guys have had a good experience with trac,
let's go with this. We do need a replacement for the current ticket
system which fits our needs so badly now (although I don't question the
fact it was helpful at the time it was implemented, some 7 years ago or
so; the number and nature of users was quite different back then.)

We had plans to go with bugzilla some times ago but we never actually
did it, so as long as someone actually does something, it's fine with
me. The faster we have a replacement and can get rid of the old system,
the better.

Phil, can you change the old ticket system code so that no new tickets
can be created there? This will motivate all of us to get the new
system setup fast, I think. And the old system is sucking too much of my
time and Ruik's too. We can handle the support requests more
efficiently on the mailing list in the meantime (we already do anyway.)

Then, everyone interested in trac can help setting it up. Michael, Phil
and others, please get in touch and decide who will do what, and where
the application will be hosted. It can be either at Phil's server
(which was hosting the older ticket system) or at Axel Thimm's facility
(which hosts the mailing list already). I'd rather avoid having a third
location for lm-sensors' stuff so as to not confuse people (starting
with ourselves).

Let's do it! As a general comment, please don't wait for my approval to
do things like this. Any of you may have much better ideas than I do -
and more importantly, more time to implement them. Just because I have
been handling a large part of the lm_sensors project on my own for some
times now doesn't mean my opinion matters more than any of yours. What
matters is that the work gets done, so anyone contributing something
useful in one way or another is right be definition. And I *really*
would like to see more people contributing to the project, not less.

And BTW: thanks Rudolf for the nice words :)

Thanks,
-- 
Jean Delvare

