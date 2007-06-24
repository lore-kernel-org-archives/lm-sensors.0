From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 24 Jun 2007 13:50:55 +0000
Subject: [lm-sensors] guidelines for kernel patches (was Re: [PATCH] hwmon:
Message-Id: <20070624135055.GC3289@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

* Mark M. Hoffman <mhoffman@lightlink.com> [2007-06-24 09:27:44 -0400]:
> Indeed, that went well.  So in general, people don't have to worry too much
> about the base version for their patches.

Some clarifications though...

1) I need to be able to *tell* what the base version was.  Juerg's patch was
clearly based on 2.6.21.1.

2) Speaking of that... I would strongly prefer patches against Linus' tree,
rather than any of the stable branches.  If it happens to apply to Linus' tree
without trouble (as this one did) then that's fine, but otherwise I'll toss it
back for a respin.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
