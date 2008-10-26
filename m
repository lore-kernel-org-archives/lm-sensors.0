From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 26 Oct 2008 16:07:53 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.28
Message-Id: <20081026170753.6442a7fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.28 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 Documentation/hwmon/lm90   |    2 +-
 drivers/hwmon/abituguru3.c |   30 ++++++++++++------------
 drivers/hwmon/adt7473.c    |   29 +++++++-----------------
 drivers/hwmon/hwmon-vid.c  |    1 +
 drivers/hwmon/lm90.c       |   52 ++++++++++++++++++++++++++++++++++++++------
 drivers/hwmon/w83781d.c    |    4 +-
 6 files changed, 73 insertions(+), 45 deletions(-)

---------------

Alistair John Strachan (2):
      hwmon: (abituguru3) Cosmetic whitespace fixes
      hwmon: (abituguru3) enable DMI probing feature on AW9D-MAX

Geert Uytterhoeven (1):
      hwmon: (w83781d) Fix linking when built-in

Jean Delvare (4):
      hwmon-vid: Add support for AMD family 10h CPUs
      hwmon: (lm90) Fix handling of hysteresis value
      hwmon: (lm90) Add support for the LM99 16 degree offset
      hwmon: (adt7473) Fix voltage conversion routines

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
