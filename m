From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Yay for 2.8.0
Message-Id: <20030717212111.0e8968e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16EBA8.145CD9FD@paradyne.com>
In-Reply-To: <3F16EBA8.145CD9FD@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Congratulations and thanks to everyone for helping get out
> our first release in 7 months.
> 
> Let's try to get back to a 2-4 month release cycle if possible.

I definitely agree. 7 months is just too much.

> - Please don't forget to update CHANGES, it's the only way we can keep
>   track of things and when I try to record what others have done I
>   inevitably miss things

I'll try. I admit I generally don't feel like my changes are important
enough to be added to the file, but maybe I'm wrong.

> - Please help with tickets

OK, no problem. How?

> - Khali can you copy i2c lk2-4 over to HEAD and update the CVS docs?

I don't think I should. This is a very sensible operation that would
require a complete CVS repository backup, and only Phil can to that.
However, I have been searching a way to move the HEAD tag to another
branch. It does not seem to be possible. All answers I have read in
mailing lists say you have to merge the changes of the branch (lk2-4)
into the trunk (HEAD) and not the other way around.

Two threads I would like everyone to read:
http://mail.gnu.org/archive/html/info-cvs/2002-09/msg00225.html
http://mail.gnu.org/archive/html/info-cvs/2000-11/msg00108.html

My conclusion are that if we have a tag matching the start of the lm2-4
branch (refered to as branch-2-4-ROOTPOINT in the lines below), we can
do the following (as suggested by my friend Pollux):

   # Go to HEAD.
   cvs up -PdA
   cvs tag HEAD-before-revert-of-2-5-changes
   # Revert all HEAD changes since branch-2-4-ROOTPOINT
   cvs up -j HEAD-before-revert-of-2-5-changes -j branch-2-4-ROOTPOINT
   cvs commit
   cvs tag HEAD-after-revert-of-2-5-changes

However, it does *not* seem to be the case. I could not see a tag at
this point of the tree, unless one of MK's are. That would help. I
guess.

Anyway, I think the above commands would add the changes of the lk2-4
branch to the ones in the trunk, not *replace* them as I think we want
to do. So the big "diff, patch, commit" solution as suggested by Philip
Pokorny may be what we want to do.

> - Khali can you please change all the "CVS" entries to "2.8.0" on the
>   new drivers page?

I'll do so. I think there is more to do than just that. All drivers that
are in 2.8.0 should be moved to the "supported devices" page. The tables
on this page should have a "first in release" column as the new drivers
tables do for now. I think this column does not make sense for the new
drivers page. If the drivers are new, the MUST be new in CVS, or they
are not really new. Do you agree?

> - I'll update freshmeat tomorrow.

Great. I'll go and buy a hey-you-it-doesnt-work-proof jacket right now
:)

Oh and BTW, glad to see you back. I was wondering if you had been
hijacked by some nasty aliens or something ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
