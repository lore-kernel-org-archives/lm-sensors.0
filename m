From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Aug 2008 08:39:03 +0000
Subject: Re: [lm-sensors] [GIT PATCH] hwmon updates against v2.6.26
Message-Id: <20080806103903.6b9eec76@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080801041026.GI3375@mars.solarsys.private>
In-Reply-To: <20080801041026.GI3375@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Mark, Andrew,

On Fri, 1 Aug 2008 00:10:27 -0400, Mark M. Hoffman wrote:
> Hi Linus:
> 
> Please pull from:
> 	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release
> 
> You'll get what few patches I've managed to look at in the last few months,
> including a patch to MAINTAINERS which makes it official.  I'm sorry I was
> not able to keep up - I should have admitted defeat much sooner.

I'm sad to see you go (and can only hope that you won't leave the
project entirely). But I would also like to thank you for the good work
you've done. Even if it was short, everything you did is done and
that's something you can be proud of. Especially given the conditions
in which you started in this new role - please forgive me for that.

> To all lm-sensors/hwmon developers: please resend/CC patches to Andrew.

I have a number of hwmon patches in my local kernel tree which I wrote
and that have been reviewed by a trusted developer, or that have been
posted to the lm-sensors list and that I have reviewed. I consider
these ready to go upstream. I plan to gather these into a public tree
and push them to Linus today or tomorrow. In the future, I will
probably have such a tree available to be included in linux-next.

Don't get me wrong, I am _not_ volunteering to become the new hwmon
subsystem maintainer. Remember, I've been there before and you know how
it ended. But in the absence of a subsystem maintainer, I don't want
hwmon patches to be lost (and especially not mine) and I don't think
that pushing everything to Andrew is a good solution either. So I'm
just proposing to do my part of the work. But if Andrew really prefers
to pick all the patches, I am not insisting either.

In the future, I would like to suggest to have 2 hwmon subsystem
maintainers instead of 1. Apparently none of us has the time to do all
the work, but maybe some of us would have the time to do half of it.
This is the path I took for the i2c subsystem, and while the change is
still fairly recent, it seems to be working well enough.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
