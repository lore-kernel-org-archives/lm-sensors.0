From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 May 2007 20:28:29 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.22
Message-Id: <20070527222829.28e193c9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Linus,

Please pull the hwmon subsystem fixes for Linux 2.6.22 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 drivers/hwmon/Kconfig     |    2 +-
 drivers/hwmon/applesmc.c  |    7 ++++++-
 drivers/hwmon/coretemp.c  |   32 +++++++++++++++++++++++++++++---
 drivers/hwmon/ds1621.c    |    8 ++++----
 drivers/hwmon/hwmon-vid.c |    4 +++-
 drivers/hwmon/w83627hf.c  |    4 +++-
 6 files changed, 46 insertions(+), 11 deletions(-)

---------------

Jean Delvare (4):
      hwmon/ds1621: Fix swapped temperature limits
      hwmon/w83627hf: Be quiet when no chip is found
      hwmon-vid: Don't spam the logs when VRM version is missing
      hwmon/applesmc: Simplify dependencies

Nicolas Boichat (1):
      hwmon/applesmc: Handle name file creation error and deletion

Rudolf Marek (1):
      hwmon/coretemp: Add more safety checks

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
