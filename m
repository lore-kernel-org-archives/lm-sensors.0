From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 21:13:35 +0000
Subject: [lm-sensors] [PATCH 00/17] i2c and hwmon updates
Message-Id: <20060118221335.2f0f4e23.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 17-piece i2c and hwmon update patchset. There are two
large changes in there: the scx200_acb driver updates from Ben Gardner,
and the semaphore/mutex conversions from Ingo Molnar. Also, the first
patch of this set is meant for Linux 2.6.16, and should be sent to
Linus ASAP. I've marked it specifically (*) in the summary below. All
the rest should spend some times in -mm for now.

Here's the summary:

Ben Gardner
 o scx200_acb: Whitespace and comment cleanup
 o scx200_acb: Debug log cleanup
 o scx200_acb: Refactor/simplify code
 o scx200_acb: Remove use of lock_kernel
 o scx200_acb: Add support for the CS5535/CS5536
 o scx200_acb: Fix and speed up the poll loop
 o scx200_acb: Minimal documentation update

Ingo Molnar:
 o i2c: Semaphore to mutex conversions, part 2
 o hwmon: Semaphore to mutex conversions

Jean Delvare
 o it87: Fix reboot on driver load (*, bug #5889)
 o w83792d: Drop 3 useless macros
 o i2c: Speed up block transfers
 o i2c: Semaphore to mutex conversions, part 3
 o f71805f: Semaphore to mutex conversions
 o hwmon: Add support for the Winbond W83687THF

Jim Cromie
 o hwmon: Refactor SENSOR_DEVICE_ATTR_2

Yuan Mu
 o w83792d: Use arrays of attributes

Statistics:

 Documentation/feature-removal-schedule.txt |    9 +
 Documentation/hwmon/it87                   |    2 
 Documentation/hwmon/w83627hf               |    4 +
 Documentation/i2c/busses/scx200_acb        |    5 +
 drivers/hwmon/Kconfig                      |    7 +
 drivers/hwmon/adm1021.c                    |   13 +
 drivers/hwmon/adm1025.c                    |   25 +
 drivers/hwmon/adm1026.c                    |   87 +++--
 drivers/hwmon/adm1031.c                    |   49 ++-
 drivers/hwmon/adm9240.c                    |   29 +
 drivers/hwmon/asb100.c                     |   45 +-
 drivers/hwmon/atxp1.c                      |    9 +
 drivers/hwmon/ds1621.c                     |   13 +
 drivers/hwmon/f71805f.c                    |   57 ++-
 drivers/hwmon/fscher.c                     |   41 +-
 drivers/hwmon/fscpos.c                     |   29 +
 drivers/hwmon/gl518sm.c                    |   25 +
 drivers/hwmon/gl520sm.c                    |   45 +-
 drivers/hwmon/hdaps.c                      |   37 +
 drivers/hwmon/it87.c                       |   69 +++-
 drivers/hwmon/lm63.c                       |   29 +
 drivers/hwmon/lm75.c                       |   13 +
 drivers/hwmon/lm77.c                       |   21 +
 drivers/hwmon/lm78.c                       |   47 +-
 drivers/hwmon/lm80.c                       |   27 +
 drivers/hwmon/lm83.c                       |   13 +
 drivers/hwmon/lm85.c                       |   67 ++-
 drivers/hwmon/lm87.c                       |   39 +-
 drivers/hwmon/lm90.c                       |   21 +
 drivers/hwmon/lm92.c                       |   17 +
 drivers/hwmon/max1619.c                    |   13 +
 drivers/hwmon/pc87360.c                    |   61 ++-
 drivers/hwmon/sis5595.c                    |   47 +-
 drivers/hwmon/smsc47b397.c                 |   17 +
 drivers/hwmon/smsc47m1.c                   |   41 +-
 drivers/hwmon/via686a.c                    |   33 +
 drivers/hwmon/vt8231.c                     |   51 ++-
 drivers/hwmon/w83627ehf.c                  |   33 +
 drivers/hwmon/w83627hf.c                   |  129 +++++--
 drivers/hwmon/w83781d.c                    |   55 ++-
 drivers/hwmon/w83792d.c                    |  538 ++++++++++++----------------
 drivers/hwmon/w83l785ts.c                  |    9 +
 drivers/i2c/busses/Kconfig                 |    5 +
 drivers/i2c/busses/i2c-ali1535.c           |    1 -
 drivers/i2c/busses/i2c-amd756-s4882.c      |   13 +
 drivers/i2c/busses/i2c-isa.c               |    2 
 drivers/i2c/busses/i2c-pxa.c               |    2 
 drivers/i2c/busses/scx200_acb.c            |  283 +++++++--------
 drivers/i2c/chips/eeprom.c                 |    9 +
 drivers/i2c/chips/max6875.c                |   10 
 drivers/i2c/chips/pcf8591.c                |   13 +
 drivers/i2c/chips/tps65010.c               |   45 +-
 drivers/i2c/i2c-core.c                     |   49 +--
 include/linux/hwmon-sysfs.h                |   12 +
 include/linux/i2c.h                        |    6 
 55 files changed, 1204 insertions(+), 1167 deletions(-)

Thanks,
-- 
Jean Delvare

