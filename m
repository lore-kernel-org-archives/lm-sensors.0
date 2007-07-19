From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 19 Jul 2007 18:26:46 +0000
Subject: Re: [lm-sensors] patches vs. 2.6.22 for release - last chance
Message-Id: <20070719182646.GE3406@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070718203038.GC3406@jupiter.solarsys.private>
In-Reply-To: <20070718203038.GC3406@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-18 23:28:16 +0200]:
> Mark M. Hoffman wrote:
> >Hi all:
> >
> >I'm back from my vacation, and of course the email has piled up.
> >
> >Linus released 2.6.22 so I've updated my testing and release trees; they 
> >are
> >now identical:
> >
> >http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=release
> >
> >Unless I hear good reasons, I'll ask Linus to pull from this tomorrow.
> >
> >Also, I realize there's still a backlog of patches.  In the past, Linus has
> >not objected to merging brand new drivers in addition to bugfixes after 
> >-rc1,
> >so I think there is still the chance to get some of these in if we can work
> >quickly.  Unfortunately, the alarm file patches qualify as neither of 
> >these,
> >so they'll have to wait until the next round.
> >
> 
> Mark can you please drop the:
> "hwmon: fix Abit Uguru3 driver detection on some motherboards" Patch, there 
> is an updated version in your inbox with skips the dmi vendor check when 
> the force module param is present.
> 
> If that is a problem I can make that an incremental patch.

No problem, I've dropped it.  We'll try to get the updated one in after -rc1.

BTW: I would have liked to keep a consistent revision history on my release
branch, but of course dropping a patch will blow that up.  I could just revert
it to keep the history intact, but I don't think Linus considers *that* to be
kosher for *him* to pull from.  My mistake, basically: I should have updated
just the testing tree, and only updated the release tree just before asking
Linus to pull.  Next time around, that's what I'll do.

So for other GIT users out there... what this means is if you pulled from my
release branch yesterday, you should blow that away and redo it.  Sorry.

(some time later...)

Argh, at the last second I realized that you didn't mean this one:

	"hwmon: fix Abit Uguru3 driver detection on some motherboards"

you actually meant this one:

	PATCH: hwmon-abituguru-check-dmi-vendor.patch

Since I see that Jean acked it and it's trivial enough, I'll stuff it in there.
Please let's not make a habit of this last-minute business.

(grumble, redo, grumble)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
