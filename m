From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Apr 2009 13:37:09 +0000
Subject: [lm-sensors] [GIT PULL] More hwmon updates for 2.6.30
Message-Id: <20090407153709.5cdc8c1a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem updates for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 drivers/acpi/acpica/nsxfeval.c |    3 +-
 drivers/hwmon/Kconfig          |   12 +
 drivers/hwmon/Makefile         |    1 +
 drivers/hwmon/asus_atk0110.c   | 1009 ++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm95241.c        |  112 ++---
 include/acpi/acpixf.h          |    2 -
 6 files changed, 1070 insertions(+), 69 deletions(-)
 create mode 100644 drivers/hwmon/asus_atk0110.c

---------------

Jean Delvare (1):
      hwmon: (lm95241) Convert to new-style i2c driver

Luca Tettamanti (1):
      hwmon: Add Asus ATK0110 support

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
