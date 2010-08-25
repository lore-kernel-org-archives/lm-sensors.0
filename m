From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Aug 2010 14:59:51 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36
Message-Id: <20100825165951.0c5d0955@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.36 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 MAINTAINERS              |    3 +--
 drivers/hwmon/ads7871.c  |   38 +++++++++++++++++++-------------------
 drivers/hwmon/coretemp.c |    1 -
 drivers/hwmon/k8temp.c   |   35 ++++++++++++++++++++++++++++++++---
 4 files changed, 52 insertions(+), 25 deletions(-)

---------------

Andreas Herrmann (1):
      hwmon: (k8temp) Differentiate between AM2 and ASB1

Axel Lin (1):
      hwmon: (ads7871) Fix ads7871_probe error paths

Fenghua Yu (1):
      MAINTAINERS: hwmon/coretemp: Change maintainers

Jean Delvare (1):
      hwmon: (coretemp) Fix harmless build warning

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
