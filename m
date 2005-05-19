From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: MAX 6650
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B3B1@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030827130542.45ced665.khali@linux-fr.org>
In-Reply-To: <20030827130542.45ced665.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I mis-typed: that would be the MAX6650, not the MAX6550, which does
> > not seem to exist.
> > 
> > Do you still want it?
> 
> Yes, we do want it.

OK, I've just committed it to CVS. Although we don't use them, I've also
made and tested 
the necessary changes (weekend finger exercise :-) to sensors-detect and the
"sensors"
program. The latter could probably benefit from more work.

This was all developed and tested for an embedded system in a cross
compilation environment,
which is a bit different to the regular Linux build envoronment, where you
run on the
same machine as you compile on. That changes a lot of the assumptions about
include paths
and so on, so I haven't been able to do a completely clean build using the
regular
make system. Let me know if I've broken anything.

John.
