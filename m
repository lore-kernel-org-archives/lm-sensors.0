From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Mar 2010 21:38:19 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 2.6.34
Message-Id: <20100305223819.5f86eed3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull some hwmon subsystem updates for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have support for 2 new devices (Andigilog aSC7621 and Analog devices
ADT7411), many improvements to the it87 and lm90 drivers, watchdog
support added to the w83793 driver, and a few other random fixes.

 Documentation/feature-removal-schedule.txt |    6 -
 Documentation/hwmon/adt7411                |   42 +
 Documentation/hwmon/adt7473                |   74 --
 Documentation/hwmon/asc7621                |  296 +++++++
 Documentation/hwmon/it87                   |   53 +-
 Documentation/hwmon/lm90                   |   22 +
 MAINTAINERS                                |   14 +
 drivers/hwmon/Kconfig                      |   45 +-
 drivers/hwmon/Makefile                     |    3 +-
 drivers/hwmon/adt7411.c                    |  366 ++++++++
 drivers/hwmon/adt7473.c                    | 1180 --------------------------
 drivers/hwmon/asc7621.c                    | 1255 ++++++++++++++++++++++++++++
 drivers/hwmon/fschmd.c                     |   15 +-
 drivers/hwmon/g760a.c                      |    2 +-
 drivers/hwmon/it87.c                       |  939 +++++++++++++++------
 drivers/hwmon/lm90.c                       |   89 ++-
 drivers/hwmon/tmp401.c                     |    7 +-
 drivers/hwmon/tmp421.c                     |   24 +-
 drivers/hwmon/w83793.c                     |  482 +++++++++++-
 19 files changed, 3335 insertions(+), 1579 deletions(-)
 create mode 100644 Documentation/hwmon/adt7411
 delete mode 100644 Documentation/hwmon/adt7473
 create mode 100644 Documentation/hwmon/asc7621
 create mode 100644 drivers/hwmon/adt7411.c
 delete mode 100644 drivers/hwmon/adt7473.c
 create mode 100644 drivers/hwmon/asc7621.c

---------------

Amerigo Wang (1):
      hwmon: Remove the deprecated adt7473 driver

George Joseph (1):
      hwmon: Driver for Andigilog aSC7621 family monitoring chips

Jean Delvare (18):
      hwmon: (lm90) Add support for the Winbond/Nuvoton W83L771AWG/ASG
      hwmon: (lm90) Restore configuration on exit
      hwmon: (lm90) Add SMBus alert support
      hwmon: (it87) Display fan outputs in automatic mode as such
      hwmon: (it87) Expose the PWM/temperature mappings
      hwmon: (it87) Refactor attributes creation and removal
      hwmon: (it87) Create vid attributes by group
      hwmon: (it87) Add support for beep on alarm
      hwmon: (it87) Fix many checkpatch errors and warnings
      hwmon: (it87) Use strict_strtol instead of simple_strtol
      hwmon: (it87) Add an entry in MAINTAINERS
      hwmon: (it87) Drop dead web links in documentation
      hwmon: (it87) Add support for old automatic fan speed control
      hwmon: (it87) Validate auto pwm settings
      hwmon: (g760a) Make rpm_from_cnt static
      hwmon: (tmp421) Restore missing inputs
      hwmon: (tmp421) Fix temperature conversions
      hwmon: Fix off-by-one kind values

Sven Anders (1):
      hwmon: (w83793) Add watchdog functionality

Wolfram Sang (2):
      hwmon: Add driver for ADT7411 voltage and temperature sensor
      hwmon: (adt7411) Improve locking

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
