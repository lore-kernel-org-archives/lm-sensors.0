From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Nov 2011 19:39:42 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.2
Message-Id: <20111106203942.1829bf78@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Guenter Roeck <guenter.roeck@ericsson.com>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.2 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/coretemp.c  |    3 +--
 drivers/hwmon/w83627ehf.c |    9 ++++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

---------------

Guenter Roeck (1):
      hwmon: (w83627ehf) Fix broken driver init

Jean Delvare (1):
      hwmon: (coretemp) Fix for non-SMP builds

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
