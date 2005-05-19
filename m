From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: LM93 vccp_limit_type "relative" does not work
Message-Id: <20041015040909.GE4035@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <416EDF3D.7090307@earthlink.net>
In-Reply-To: <416EDF3D.7090307@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-10-14 22:58:18 -0400]:
> * David Knierim <david_knierim@earthlink.net> [2004-10-14 16:19:09 -0400]:
> > On my box, the register 0xed has the dynamic vccp limit masked out when 
> > the box boots up.  Loading the driver makes no difference, so step #2 
> > does not appear to be being done.
> 
> Oops, that's a bug.

Also, #VRDHOT errors were masked by default - not sure if you had tested
that yet.  I fixed it as well in the same CVS commit.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
