From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Jan 2014 19:48:25 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.14
Message-Id: <20140129204825.4d6de026@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.14 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

This include it87 driver improvements, and a tree-wide change of my
e-mail address.

 CREDITS                                    |   4 +-
 Documentation/hwmon/adm1025                |   2 +-
 Documentation/hwmon/adm1031                |   2 +-
 Documentation/hwmon/adm9240                |   2 +-
 Documentation/hwmon/ds1621                 |   2 +-
 Documentation/hwmon/emc6w201               |   2 +-
 Documentation/hwmon/f71805f                |   2 +-
 Documentation/hwmon/gl518sm                |   2 +-
 Documentation/hwmon/it87                   |  29 +++++---
 Documentation/hwmon/lm63                   |   2 +-
 Documentation/hwmon/lm70                   |   2 +-
 Documentation/hwmon/lm78                   |   2 +-
 Documentation/hwmon/lm83                   |   2 +-
 Documentation/hwmon/lm87                   |   2 +-
 Documentation/hwmon/lm90                   |   2 +-
 Documentation/hwmon/lm92                   |   2 +-
 Documentation/hwmon/max1619                |   2 +-
 Documentation/hwmon/pc87360                |   2 +-
 Documentation/hwmon/pc87427                |   2 +-
 Documentation/hwmon/pcf8591                |   2 +-
 Documentation/hwmon/smsc47m1               |   2 +-
 Documentation/hwmon/w83627ehf              |   2 +-
 Documentation/hwmon/w83795                 |   2 +-
 Documentation/hwmon/w83l785ts              |   2 +-
 Documentation/i2c/busses/i2c-i801          |   2 +-
 Documentation/i2c/busses/i2c-parport       |   2 +-
 Documentation/i2c/busses/i2c-parport-light |   2 +-
 Documentation/i2c/busses/i2c-taos-evm      |   2 +-
 Documentation/i2c/busses/i2c-viapro        |   2 +-
 Documentation/misc-devices/eeprom          |   2 +-
 MAINTAINERS                                |  32 ++++-----
 drivers/char/i8k.c                         |   2 +-
 drivers/hwmon/Kconfig                      |   4 +-
 drivers/hwmon/adm1025.c                    |   4 +-
 drivers/hwmon/adm1029.c                    |   2 +-
 drivers/hwmon/adm1031.c                    |   2 +-
 drivers/hwmon/adt7475.c                    |   2 +-
 drivers/hwmon/ds1621.c                     |   2 +-
 drivers/hwmon/emc6w201.c                   |   4 +-
 drivers/hwmon/f71805f.c                    |   2 +-
 drivers/hwmon/gl518sm.c                    |   2 +-
 drivers/hwmon/it87.c                       | 108 +++++++++++++++++++++++------
 drivers/hwmon/lm63.c                       |   4 +-
 drivers/hwmon/lm78.c                       |   4 +-
 drivers/hwmon/lm83.c                       |   4 +-
 drivers/hwmon/lm85.c                       |   2 +-
 drivers/hwmon/lm87.c                       |   4 +-
 drivers/hwmon/lm90.c                       |   4 +-
 drivers/hwmon/lm92.c                       |   4 +-
 drivers/hwmon/lm93.c                       |   2 +-
 drivers/hwmon/max1619.c                    |   5 +-
 drivers/hwmon/max6642.c                    |   2 +-
 drivers/hwmon/nct6775.c                    |   2 +-
 drivers/hwmon/pc87360.c                    |   4 +-
 drivers/hwmon/pc87427.c                    |   4 +-
 drivers/hwmon/pcf8591.c                    |   2 +-
 drivers/hwmon/sis5595.c                    |   2 +-
 drivers/hwmon/smsc47b397.c                 |   2 +-
 drivers/hwmon/smsc47m1.c                   |   2 +-
 drivers/hwmon/w83627ehf.c                  |   4 +-
 drivers/hwmon/w83627hf.c                   |   2 +-
 drivers/hwmon/w83781d.c                    |   2 +-
 drivers/hwmon/w83795.c                     |   4 +-
 drivers/hwmon/w83l785ts.c                  |   6 +-
 drivers/i2c/algos/i2c-algo-bit.c           |   2 +-
 drivers/i2c/busses/i2c-amd756-s4882.c      |   4 +-
 drivers/i2c/busses/i2c-i801.c              |   5 +-
 drivers/i2c/busses/i2c-nforce2-s4985.c     |   4 +-
 drivers/i2c/busses/i2c-parport-light.c     |   4 +-
 drivers/i2c/busses/i2c-parport.c           |   4 +-
 drivers/i2c/busses/i2c-parport.h           |   2 +-
 drivers/i2c/busses/i2c-taos-evm.c          |   4 +-
 drivers/i2c/busses/i2c-viapro.c            |   4 +-
 drivers/i2c/i2c-core.c                     |   2 +-
 drivers/i2c/i2c-smbus.c                    |   4 +-
 drivers/i2c/i2c-stub.c                     |   2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c        |   2 +-
 drivers/misc/eeprom/eeprom.c               |   2 +-
 include/linux/i2c-smbus.h                  |   2 +-
 79 files changed, 225 insertions(+), 148 deletions(-)

---------------

Jean Delvare (2):
      hwmon: (it87) Print proper names for the IT8771E and IT8772E
      Update Jean Delvare's e-mail address

Rudolf Marek (1):
      hwmon: (it87) Add support for the ITE IT8603E

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
