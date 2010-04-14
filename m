From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Apr 2010 14:47:08 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.34
Message-Id: <20100414164708.6bfd7521@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 MAINTAINERS              |    4 ++--
 drivers/hwmon/applesmc.c |   18 ++++++++++++++++++
 drivers/hwmon/it87.c     |   32 +++++++++++++++-----------------
 drivers/hwmon/sht15.c    |   13 +++++++++----
 4 files changed, 44 insertions(+), 23 deletions(-)

---------------

Henrik Rydberg (1):
      hwmon: (applesmc) Switch maintainers

Jean Delvare (4):
      hwmon: (sht15) Properly handle the case CONFIG_REGULATOR=n
      hwmon: (it87) Don't arbitrarily enable temperature channels
      hwmon: (it87) Properly handle wrong sensor type requests
      hwmon: (it87) Invalidate cache on temperature sensor change

Jerome Oufella (1):
      hwmon: (sht15) Fix sht15_calc_temp interpolation function

Justin P. Mattock (1):
      hwmon: (applesmc) Add iMac9,1 and MacBookPro2,2 support

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
