From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Dec 2009 20:47:21 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 2.6.33, round 2
Message-Id: <20091216214721.3a8a75d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209221721.3dc73a97@hyperion.delvare>
In-Reply-To: <20091209221721.3dc73a97@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem updates for Linux 2.6.33 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have 2 new drivers for integrated CPU sensors, one for the AMD
family 10h and 11h, and one for the VIA C7 and Nano. Plus random driver
fixes.

 Documentation/hwmon/k10temp |   60 +++++++
 drivers/hwmon/Kconfig       |   20 +++
 drivers/hwmon/Makefile      |    2 +
 drivers/hwmon/k10temp.c     |  197 ++++++++++++++++++++++++
 drivers/hwmon/sht15.c       |    6 +-
 drivers/hwmon/smsc47m1.c    |  153 +++++++++++++++---
 drivers/hwmon/via-cputemp.c |  356 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/w83627hf.c    |    2 +-
 8 files changed, 766 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/hwmon/k10temp
 create mode 100644 drivers/hwmon/k10temp.c
 create mode 100644 drivers/hwmon/via-cputemp.c

---------------

Christian Schulte (1):
      hwmon: (w83627hf) Fix for "No such device"

Clemens Ladisch (1):
      hwmon: New driver for AMD Family 10h/11h CPUs

Harald Welte (1):
      hwmon: Add driver for VIA CPU core temperature

Jean Delvare (3):
      hwmon: (smsc47m1) Only request I/O ports we really use
      hwmon: (smsc47m1) Fail module loading on error
      hwmon: (smsc47m1) Enable device if needed

Jonathan Cameron (1):
      hwmon: (sht15) Off-by-one error in array index + incorrect constants

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
