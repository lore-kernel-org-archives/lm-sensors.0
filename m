From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <Pine.OSF.4.50.0301131307360.32351-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 12 Jan 2003, Mark Studebaker wrote:

> We have a vote from Ky?sti for branching.
> Albert suggested the same thing to me in an email.
> Pavel suggested abandoning CVS and doing everything in Linus' tree.
>
> I'm really reluctant to branch but it may be the only realistic way to do it
> unless somebody volunteers to do patches manually (and perpetually).

There was still a choice of what to branch. Choosing wisely, we can
limit commits between branches to one direction.

I suggest we have main branch for 2.5 development,

- Some day 2.5 results become main anyway.
- Patches to 2.4 are not likely to touch kernel interfaces
  -> merging 2.4->2.5 painless
- Patches to 2.5 are likely to touch kernel interfaces only
  -> little to none merges 2.5->2.4

I see no reason to release 2.8.0 immediately. Just tag CVS before we
branch, then do 2.4<->2.5 cleanup and de release once there is something
new to offer.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
