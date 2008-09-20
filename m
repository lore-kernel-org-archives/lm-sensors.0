From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Sep 2008 08:31:11 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.27
Message-Id: <20080920103111.2f0f512b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.27 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus


 drivers/hwmon/ad7414.c |    2 +-
 drivers/hwmon/atxp1.c  |   18 +++++++++---------
 drivers/hwmon/it87.c   |    4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

---------------

Adrian Bunk (1):
      hwmon: (ad7414) Make ad7414_update_device() static

Andrew Paprocki (1):
      hwmon: (it87) Fix fan tachometer reading in IT8712F rev 0x7 (I)

Jean Delvare (1):
      hwmon: (atxp1) Fix device detection logic

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
