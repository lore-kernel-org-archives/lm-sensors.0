From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 14 Aug 2007 01:50:28 +0000
Subject: [lm-sensors] [GIT PATCH] hwmon updates against ~v2.6.23-rc2-git
Message-Id: <20070814015028.GA7748@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070801010825.GC3747@jupiter.solarsys.private>
In-Reply-To: <20070801010825.GC3747@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Linus:

Please pull from:
	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

You'll get four bugfixes.  This takes care of all known hwmon regressions, and
hopefully it's the last you'll hear from me before v2.6.23 goes final.

This patch series was also posted to the lm-sensors list yesterday:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/020843.html

Thanks & regards,

 drivers/hwmon/smsc47m1.c  |    2 +
 drivers/hwmon/w83627ehf.c |   56 +++++++++++++++++++++++++-------------------
 drivers/hwmon/w83781d.c   |    4 +-
 3 files changed, 36 insertions(+), 26 deletions(-)

Jean Delvare (2):
      hwmon: (w83627ehf) don't assume bank 0
      hwmon: (smsc47m1) restore missing name attribute

Mark M. Hoffman (2):
      hwmon: fix w83781d temp sensor type setting
      hwmon: (w83627ehf) read fan_div values during probe

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
