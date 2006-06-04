From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 17:45:38 +0000
Subject: [lm-sensors] [PATCH 00/11] i2c and hwmon updates
Message-Id: <20060604194538.1616ef10.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes an 11-piece i2c and hwmon update patchset. We have a new
hardware monitoring driver (abituguru, supporting the Abit uGuru
chip), a new i2c bus driver (i2c-ocore, supporting the OpenCores I2C
controller), fixes to the w83792d driver and documentation updates. All
of this is meant for -mm/2.6.18.

Here's the summary:

Hans de Goede:
 o abituguru: New hardware monitoring driver
 o abituguru: Review fixes
 o abituguru: Fix fan detection

Jean Delvare:
 o i2c: Suggest N for rare devices in Kconfig
 o hwmon: Sysfs interface documentation update, 2 of 2
 o hwmon: Fix a typo in the hdaps driver
 o hwmon: Drop some maintainers entries

Peter Korsgaard:
 o i2c: New bus driver for the OpenCores I2C controller

Rudolf Marek:
 o hwmon: Sysfs interface documentation update, 1 of 2

Yuan Mu:
 o w83792d: Fix setting the PWM value
 o w83792d: Add missing data access locks

Statistics:

 Documentation/hwmon/abituguru           |   59 +
 Documentation/hwmon/abituguru-datasheet |  312 +++++++
 Documentation/hwmon/sysfs-interface     |  222 +++--
 Documentation/i2c/busses/i2c-ocores     |   51 +
 MAINTAINERS                             |   18 -
 drivers/hwmon/Kconfig                   |   12 +
 drivers/hwmon/Makefile                  |    1 +
 drivers/hwmon/abituguru.c               | 1415 +++++++++++++++++++++++++++++++
 drivers/hwmon/hdaps.c                   |    2 
 drivers/hwmon/w83792d.c                 |   86 +-
 drivers/i2c/busses/Kconfig              |   17 +
 drivers/i2c/busses/Makefile             |    1 +
 drivers/i2c/busses/i2c-ocores.c         |  343 ++++++++
 drivers/i2c/chips/Kconfig               |    8 +
 include/linux/i2c-ocores.h              |   19 +
 15 files changed, 2433 insertions(+), 133 deletions(-)

-- 
Jean Delvare

