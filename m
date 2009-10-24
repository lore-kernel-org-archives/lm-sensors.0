From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Oct 2009 11:49:28 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.32
Message-Id: <20091024134928.3a6d5d0a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091009205722.5434b5c2@hyperion.delvare>
In-Reply-To: <20091009205722.5434b5c2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus


 MAINTAINERS             |    1 +
 drivers/hwmon/dme1737.c |   29 ++++++++++++++++++++++++-----
 drivers/hwmon/fschmd.c  |    2 +-
 drivers/hwmon/it87.c    |    5 ++---
 4 files changed, 28 insertions(+), 9 deletions(-)

---------------

Huaxu Wan (1):
      hwmon: (coretemp) Maintainer update

Jean Delvare (2):
      hwmon: (dme1737) No vid attributes for SCH311x
      hwmon: (it87) Fix VID reading on IT8718F/IT8720F

Roel Kluin (1):
      hwmon: (fschmd) Fix check on unsigned in watchdog_write()

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
