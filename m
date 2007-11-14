From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 14 Nov 2007 02:24:39 +0000
Subject: Re: [lm-sensors] [GIT PATCH] hwmon updates against v2.6.24-rc2
Message-Id: <20071114022439.GD2674@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071113131210.GA2674@jupiter.solarsys.private> <20071113220030.6dd5e0d7@hyperion.delvare>
In-Reply-To: <20071113220030.6dd5e0d7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Jean:

> On Tue, 13 Nov 2007 08:12:10 -0500, Mark M. Hoffman wrote:
> > Hi Linus:
> > 
> > Please pull from:
> > 	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release
> > 
> > You'll get one new driver, a few cleanups, and a few bugfixes.  This
> > takes care of all known regressions; hopefully it's the last you hear
> > from me before 2.6.24-final.
> > 
> > Note: the f75375s/n2100 patches especially are critical to avoid
> > possible overheating problems on that platform (yay crappy BIOS).
> > 
> > All of these patches have spent considerable time in -mm.

* Jean Delvare <khali@linux-fr.org> [2007-11-13 22:00:30 +0100]:
> Let me have a doubt, considering that the last public -mm kernel was
> released over a month ago (October 12th), which is before your previous
> pull request (October 14th). I don't think that any of these patches
> has been in even one public -mm tree, so in practice they probably
> didn't receive any public testing at all.

Well, zero is a "considerable" number. ;)

Seriously though, my bad.  In my (weak) defense, I will point out that
all but a couple of these patches were *available* for -mm on my testing
branch for at least two weeks; Oct 28 was the most recent addition.

> Now let's hope that nothing breaks.

I admit: post-rc2 was later than it should have been for some of this.
But there was no rocket science in any of these.  I think we'll be OK.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
