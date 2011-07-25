From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jul 2011 19:51:16 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.1
Message-Id: <20110725215116.161aed47@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have support for one new device (SMSC SCH5636), and minor
improvements and cleanups to a few drivers.

 Documentation/hwmon/it87       |    3 +-
 Documentation/hwmon/lm78       |    3 +-
 Documentation/hwmon/sch5636    |   31 +++
 MAINTAINERS                    |    7 +
 drivers/hwmon/Kconfig          |   21 ++
 drivers/hwmon/Makefile         |    2 +
 drivers/hwmon/hwmon-vid.c      |   42 +++-
 drivers/hwmon/it87.c           |   29 +++
 drivers/hwmon/lm78.c           |  305 +++++++++++++----------
 drivers/hwmon/max1111.c        |   27 +--
 drivers/hwmon/sch5627.c        |  334 ++-----------------------
 drivers/hwmon/sch5636.c        |  539 ++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/sch56xx-common.c |  340 +++++++++++++++++++++++++
 drivers/hwmon/sch56xx-common.h |   24 ++
 drivers/hwmon/sht15.c          |    2 +-
 drivers/hwmon/via-cputemp.c    |   44 +++-
 16 files changed, 1285 insertions(+), 468 deletions(-)
 create mode 100644 Documentation/hwmon/sch5636
 create mode 100644 drivers/hwmon/sch5636.c
 create mode 100644 drivers/hwmon/sch56xx-common.c
 create mode 100644 drivers/hwmon/sch56xx-common.h

---------------

Hans de Goede (2):
      hwmon: (sch5627) Factor out some code shared with sch5636 driver
      hwmon: New driver sch5636

Jean Delvare (7):
      hwmon-vid: Add support for VIA family 6 model D CPU
      hwmon: (via-cputemp) Add VID reporting support
      hwmon: (it87) Add chassis intrusion detection support
      hwmon: (max1111) Avoid extra memory allocations
      hwmon: (lm78) Avoid forward declarations
      hwmon: (lm78) Make ISA interface depend on CONFIG_ISA
      hwmon: (lm78) Become the maintainer

Vivien Didelot (1):
      hwmon: (sht15) Correct a comment mistake

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
