From: Trent Piepho <tpiepho@freescale.com>
Date: Mon, 26 May 2008 17:27:50 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <Pine.LNX.4.64.0805261000010.16969@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080526152601.GA16874@mars.solarsys.private>
In-Reply-To: <20080526152601.GA16874@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 May 2008, Mark M. Hoffman wrote:
> I agree completely with Jean, sorry.  If you have no firmware, and refuse to
> put these one-time config options in platform data... that's your choice.

I've changed these one time options a lot more than once.  You don't seem to
realize that most of the options are not something that's fixed into the
hardware.  Their desired value changes based on what fan is attached, how the
hardware is configured, and what features the user wants.

> That said, there were some parts of your original patch that do make sense to
> expose through the driver, as Jean pointed out.  I encourage you to respin the
> patch with just those parts.

Then instead of maintaining a patch adding new code, I get to maintain a patch
to existing code.  Every time some slave to checkpatch decides a space just
has to be added somewhere I'll get a merge conflict.

I'm much better off not adding anything at all and I've come to regret ever
posting the patch in the first place.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
