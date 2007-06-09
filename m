From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 09 Jun 2007 16:00:31 +0000
Subject: [lm-sensors] New hwmon maintainer
Message-Id: <20070609160031.GE3357@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Andrew:

I am maintaining a git tree for the hwmon subsystem now.  You may pull from
it here:

	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git testing

The current contents include the remainder of Jean Delvare's quilt patch
series, plus a single patch to MAINTAINERS.  Once you start pulling from
this git tree, Jean said he will delete his patch series entirely.

BTW: None of these patches are needed before 2.6.23.

Thanks & regards,

PS: Thanks for your good work and help, Jean.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
