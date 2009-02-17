From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 19:02:00 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.29
Message-Id: <20090217200200.3b9ce3ea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.29 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 MAINTAINERS               |    8 ++++----
 drivers/hwmon/f71882fg.c  |    4 ++--
 drivers/hwmon/vt1211.c    |    2 +-
 drivers/hwmon/w83627ehf.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

---------------

Frank Seidel (1):
      MAINTAINERS: Switch hdaps to Frank Seidel

Hans de Goede (1):
      hwmon: Fix ACPI resource check error handling

Jean Delvare (1):
      hwmon: (f71882fg) Hide misleading error message

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
