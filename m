From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 26 May 2008 18:24:17 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <20080526182417.GA23046@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080526152601.GA16874@mars.solarsys.private>
In-Reply-To: <20080526152601.GA16874@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Trent Piepho <tpiepho@freescale.com> [2008-05-26 10:27:50 -0700]:
> On Mon, 26 May 2008, Mark M. Hoffman wrote:
> > I agree completely with Jean, sorry.  If you have no firmware, and refuse to
> > put these one-time config options in platform data... that's your choice.
> 
> I've changed these one time options a lot more than once.  You don't seem to
> realize that most of the options are not something that's fixed into the
               ^^^^
> hardware.  Their desired value changes based on what fan is attached, how the
> hardware is configured, and what features the user wants.

I was referring to those which *are* fixed into the hardware.  I'm sorry if my
wording was unclear.

> > That said, there were some parts of your original patch that do make sense to
> > expose through the driver, as Jean pointed out.  I encourage you to respin the
> > patch with just those parts.
> 
> Then instead of maintaining a patch adding new code, I get to maintain a patch
> to existing code.  Every time some slave to checkpatch decides a space just
> has to be added somewhere I'll get a merge conflict.

I'll try again: I encourage you to respin the patch to include the options on
which we all agree.  Then you can maintain a smaller patch of just those things
that I won't take.  This is to your benefit, no?

> I'm much better off not adding anything at all and I've come to regret ever
> posting the patch in the first place.

Well it seems you took Jean's original review a little too personally right
from the start.  That's your choice, but I hope you'll reconsider.  No code
is immune to criticism around here.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
