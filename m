From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Jun 2010 07:29:48 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.35
Message-Id: <20100620092948.3a417672@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.35 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/i5k_amb.c |    6 ++++++
 drivers/hwmon/k10temp.c |   14 ++++++++++++--
 drivers/hwmon/k8temp.c  |    2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

---------------

Jean Delvare (2):
      hwmon: (k10temp) Do not blacklist known working CPU models
      hwmon: (k8temp) Bypass core swapping on single-core processors

KAMEZAWA Hiroyuki (1):
      hwmon: (i5k_amb) Fix sysfs attribute for lockdep

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
