From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jul 2009 12:26:10 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.31
Message-Id: <20090711142610.048b69f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/abituguru3.c |    6 +++---
 drivers/hwmon/max6650.c    |    1 +
 drivers/hwmon/sht15.c      |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

---------------

Alistair John Strachan (1):
      hwmon: (abituguru3) DMI probing for AB9, AB9 QuadQT and IX38 QuadGT

Jiri Slaby (1):
      hwmon: (max6650) Fix lock imbalance

Joe Perches (1):
      hwmon: (sht15) Remove unnecessary semicolon

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
