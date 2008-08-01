From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Aug 2008 04:10:27 +0000
Subject: [lm-sensors] [GIT PATCH] hwmon updates against v2.6.26
Message-Id: <20080801041026.GI3375@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Linus:

Please pull from:
	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

You'll get what few patches I've managed to look at in the last few months,
including a patch to MAINTAINERS which makes it official.  I'm sorry I was
not able to keep up - I should have admitted defeat much sooner.

To all lm-sensors/hwmon developers: please resend/CC patches to Andrew.

Thanks & regards,

 Documentation/hwmon/dme1737 |    4 
 Documentation/hwmon/lm85    |   11 
 MAINTAINERS                 |    6 
 drivers/hwmon/Kconfig       |   25 +
 drivers/hwmon/adt7473.c     |   16 -
 drivers/hwmon/dme1737.c     |  297 ++++++++++++-------
 drivers/hwmon/lm75.c        |  282 +++++++++++++-----
 drivers/hwmon/lm85.c        |  672 ++++++++++++++++++--------------------------
 8 files changed, 692 insertions(+), 621 deletions(-)

David Brownell (2):
      hwmon: (lm75) cleanup/reorg
      hwmon: (lm75) add new-style driver binding

Jean Delvare (6):
      hwmon: (adt7473) Remove unused defines
      hwmon: (lm85) Coding-style cleanups
      hwmon: (lm85) Drop dead code
      hwmon: (lm85) Don't write back cached values
      hwmon: (lm85) Misc cleanups
      hwmon: (lm85) Simplify device initialization function

Juerg Haefliger (3):
      hwmon: (dme1737) demacrofy for readability
      hwmon: (dme1737) probe all addresses
      hwmon: (dme1737) fix voltage scaling

Mark M. Hoffman (2):
      hwmon: (adt7473) clarify an awkward bit of code
      hwmon: needs new maintainer

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
