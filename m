From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 24 Jun 2008 11:45:01 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks
Message-Id: <20080624114501.GL7306@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no> <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no> <48605935.5070407@shaw.ca> <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Rene Herman <rene.herman@keyaccess.nl>, Hans de Goede <j.w.r.degoede@hhs.nl>, Zhang Rui <rui.zhang@intel.com>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Linus:

* Linus Torvalds <torvalds@linux-foundation.org> [2008-06-23 20:07:15 -0700]:
> 
> 
> On Mon, 23 Jun 2008, Robert Hancock wrote:
> 
> > Mark M. Hoffman wrote:
> > > 
> > > 1) The bug is in libsensors (2.10), not the kernel.
> > 
> > This doesn't matter. Breaking userspace in such a fashion is severely frowned
> > upon unless essentially unavoidable, even if it is just triggering a bug.
> 
> I do tend to agree. If it used to work, it should continue to work, even 
> if it wasn't _meant_ to work.
> 
> That's not always 100% possible, but the fact is, neither is updating user 
> space always possible. The kernel needs to try its best to maintain stable 
> interfaces, and no, "..but the interface was broken" is _not_ an 
> acceptable excuse for unbreaking it if it causes problems.

No excuses... it's just a simple case of userspace making a bad assumption.
(Queue rant about how sysfs interfaces are prone to this sort of thing.)

> > > - but more importantly -
> > > 
> > > 2) This patch is broken.
> > 
> > You didn't indicate what was wrong with the patch.
> 
> Yes. Leaving everybody wondering whether it's just an opinionated 
> expression of the former problem, or whether there is a real and 
> understandable reason why it was NACK'ed.

IMO Jean Delvare and Zhang Rui had explained this well enough elsewhere in the
thread, but...

In summary: the patch adds a meaningless symbolic link to an arbitrary thermal
zone device where the was none before.  This keeps (one version of) libsensors
from tripping over itself.  But if the TZ devices are unregistered in the wrong
order, OOPS.  Apparently this can't happen in practice; but it's a bad trade
to add an implicit dependency on the order of device reg/unreg just to wall-
paper over a bug in userspace (IMHO).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
