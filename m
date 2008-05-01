From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 01 May 2008 11:58:12 +0000
Subject: [lm-sensors] [GIT PATCH] hwmon update against v2.6.25
Message-Id: <20080501115812.GJ6034@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus:

Please pull from:
	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

You'll get a relatively small number of minor changes, all of which have been
in -next for many weeks.

Also, there is a larger pile of changes queued in my email, most of which have
been reviewed by other hwmon contributors even.  It is absolutely my fault for
not getting through this pile by now.  To all hwmon contributors, I apologize.
I have done a crappy job as maintainer this past month.

Linus: I'll ask you to pull again between rc1 and rc2, in order to kill that
backlog.  However, I understand if you choose to reject that request.

Thanks & regards,

 Documentation/hwmon/w83l785ts |    3 +-
 drivers/hwmon/adt7473.c       |   45 +++++++++++++++++++++---------------------
 drivers/hwmon/asb100.c        |    4 ---
 drivers/hwmon/lm75.c          |    5 ----
 drivers/hwmon/smsc47b397.c    |   17 +++++++++++++--
 drivers/hwmon/w83793.c        |   26 +++++++++++++-----------
 drivers/hwmon/w83l785ts.c     |    4 +--
 7 files changed, 56 insertions(+), 48 deletions(-)

Craig Kelley (1):
      hwmon: (smsc47b397) add a new chip id (0x8c)

Jean Delvare (3):
      hwmon: (w83l785ts) Don't ask the user to report failures
      hwmon: (w83793) VID and VRM handling cleanups
      hwmon: (lm75) Fix an incorrect comment

Mark M. Hoffman (3):
      hwmon: (asb100) Remove some dead code
      hwmon: (adt7473) minor cleanup / refactoring
      Merge branch 'smsc47b397-new-id' into release

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
