From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 15 Jan 2009 21:30:42 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.29
Message-Id: <20090115223042.5106b964@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.29 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 Documentation/hwmon/adt7475 |   87 +++
 drivers/hwmon/Kconfig       |   10 +
 drivers/hwmon/Makefile      |    2 +
 drivers/hwmon/abituguru3.c  |   24 +-
 drivers/hwmon/adt7475.c     | 1221 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/k8temp.c      |   55 ++-
 6 files changed, 1384 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/hwmon/adt7475
 create mode 100644 drivers/hwmon/adt7475.c

---------------

Alistair John Strachan (3):
      hwmon: (abituguru3) Match partial DMI board name strings
      hwmon: (abituguru3) Enable DMI probing feature on IN9 32X MAX
      hwmon: (abituguru3) Fix CONFIG_DMI=n fallback to probe

Andreas Herrmann (3):
      hwmon: (k8temp) Warn about fam F rev F errata
      hwmon: (k8temp) Fix wrong sensor selection for AMD K8 RevF/RevG CPUs
      hwmon: (k8temp) Fix temperature reporting for (most) K8 RevG CPUs

Jordan Crouse (1):
      hwmon: Add a driver for the ADT7475 hardware monitoring chip

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
