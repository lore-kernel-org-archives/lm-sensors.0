From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 01 Aug 2008 04:32:21 +0000
Subject: Re: [lm-sensors] [GIT PATCH] hwmon updates against v2.6.26
Message-Id: <20080731213221.bb3830d6.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080801041026.GI3375@mars.solarsys.private>
In-Reply-To: <20080801041026.GI3375@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Fri, 1 Aug 2008 00:10:27 -0400 "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:

> Hi Linus:
> 
> Please pull from:
> 	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

ack.

> You'll get what few patches I've managed to look at in the last few months,
> including a patch to MAINTAINERS which makes it official.  I'm sorry I was
> not able to keep up - I should have admitted defeat much sooner.

Thanks for all the work.  There are many subsystems for which the
maintainer is, err, me.

> To all lm-sensors/hwmon developers: please resend/CC patches to Andrew.

Yup.  I'll subscribe to those lists and shall do the occasional
troll-for-missed-stuff there.

You'll also find that I'll still cc yourself on everything (including
patches) so please do keep an eye out for goofups.

>  MAINTAINERS                 |    6 

 HARDWARE MONITORING
-P:     Mark M. Hoffman
-M:     mhoffman@lightlink.com
 L:     lm-sensors@lm-sensors.org
 W:     http://www.lm-sensors.org/
-T:     git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git testing
-T:     git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git release
-S:     Maintained
+S:     Orphaned


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
