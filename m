From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Dec 2014 04:01:44 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 3.19
Message-Id: <1418097704-29232-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux 3.19 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v3.19

Thanks,
Guenter
------

The following changes since commit 009d0431c3914de64666bec0d350e54fdd59df6a:

  Linux 3.18-rc7 (2014-11-30 16:42:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-3.19

for you to fetch changes up to 907a6d5824599d09e986105a5a880d119a996c4b:

  hwmon: (tmp401) Detect TMP435 on all addresses it supports (2014-12-08 06:48:37 -0800)

----------------------------------------------------------------
Notable changes:
New driver for NCT7802Y
Add support for TMP435, LM95233, LM95235, NCT6792D, and NXP LM75B
Add regulator support for PMBus chips, specifically LTX2978
Add support for humidity sensors to iio-hwmon bridge driver

----------------------------------------------------------------
Alan Tull (4):
      hwmon: (ltc2978) device tree bindings documentation
      hwmon: (pmbus) add helpers for byte write and read modify write
      hwmon: (pmbus) Add regulator support
      hwmon: (ltc2978) Add regulator support

Axel Lin (1):
      hwmon: (ibmpowernv) Convert to module_platform_driver

Bartosz Golaszewski (2):
      hwmon: (ina2xx) bail-out from ina2xx_probe() in case of configuration errors
      hwmon: (tmp401) Bail out from tmp401_probe() in case of write errors

Guenter Roeck (9):
      hwmon: (iio_hwmon) Add support for humidity sensors
      hwmon: Driver for Nuvoton NCT7802Y
      hwmon: (nct6775) Documentation updates
      hwmon: (nct6775) Add support for NCT6792D
      hwmon: (nct6775) Add blank lines after declarations
      hwmon: (lm95245) Add support for LM95235
      hwmon: (lm95234) Add support for LM95233
      hwmon: (lm75) Strengthen detect function
      hwmon: (tmp401) Detect TMP435 on all addresses it supports

Michael Thalmeier (1):
      hwmon: (lm75) Add support for the NXP LM75B

Neelesh Gupta (1):
      hwmon: (ibmpowernv) Use platform 'id_table' to probe the device

Nishanth Menon (2):
      hwmon: (gpio-fan) Allow usage of gpio operations that may sleep
      hwmon: (gpio-fan) Add a shutdown handler to poweroff the fans

Patrick Titiano (1):
      hwmon: (tmp401) Add support for TI TMP435

 .../devicetree/bindings/hwmon/ltc2978.txt          |  39 +
 Documentation/hwmon/lm75                           |   5 +
 Documentation/hwmon/lm95234                        |  15 +-
 Documentation/hwmon/lm95245                        |  14 +-
 Documentation/hwmon/nct6775                        |  14 +-
 Documentation/hwmon/nct7802                        |  32 +
 Documentation/hwmon/tmp401                         |   8 +-
 arch/powerpc/platforms/powernv/opal-sensor.c       |  20 +
 drivers/hwmon/Kconfig                              |  28 +-
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/gpio-fan.c                           |  18 +-
 drivers/hwmon/ibmpowernv.c                         |  78 +-
 drivers/hwmon/iio_hwmon.c                          |   7 +-
 drivers/hwmon/ina2xx.c                             |  26 +-
 drivers/hwmon/lm75.c                               |  12 +
 drivers/hwmon/lm95234.c                            |  91 ++-
 drivers/hwmon/lm95245.c                            |  41 +-
 drivers/hwmon/nct6775.c                            |  77 +-
 drivers/hwmon/nct7802.c                            | 860 +++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig                        |  11 +-
 drivers/hwmon/pmbus/ltc2978.c                      |  39 +-
 drivers/hwmon/pmbus/pmbus.h                        |  30 +
 drivers/hwmon/pmbus/pmbus_core.c                   | 118 +++
 drivers/hwmon/tmp401.c                             |  42 +-
 include/linux/i2c/pmbus.h                          |   4 +
 25 files changed, 1465 insertions(+), 165 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
 create mode 100644 Documentation/hwmon/nct7802
 create mode 100644 drivers/hwmon/nct7802.c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
