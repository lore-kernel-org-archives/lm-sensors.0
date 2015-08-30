From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 30 Aug 2015 22:34:22 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for v4.3
Message-Id: <1440974062-18608-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux v4.3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.3

Thanks,
Guenter
------

The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f49:

  Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.3

for you to fetch changes up to 1ed32160dba643e61504b334f45b002198c88254:

  hwmon: (fam15h_power) Add ratio of Tsample to the PTSC period (2015-08-27 07:53:19 -0700)

----------------------------------------------------------------
hwmon updates for v4.3 commit window

Notable changes:

Added support for LTM4675, LTC3886, LTC2980, LTM2987, LTC2975,
	LTC3887, LTC3882, MAX20751, ADM1293, and ADM1294 to PMBus drivers.
Added support for IT8732F to it87 driver.
Added support for AMD Carrizo to fam15h_power driver.
Added support for various new attributes to nct7802 driver.
Added support for F81866 and F71868 to f71882fg driver.

----------------------------------------------------------------
Axel Lin (2):
      hwmon: (pmbus) Explicitly set regulator type for pmbus_regulator_ops
      hwmon: (pmbus_core) Constify pmbus_regulator_ops

Constantine Shulyupin (5):
      hwmon: (nct7802) add temperature sensor type attribute
      hwmon: (nct7802) Add pwm control
      hwmon: (nct7802) Add pwm mode attributes
      hwmon: (nct7802) Add pwmX_enable attribute
      hwmon: (nct7802) Add auto_point attributes

George Joseph (1):
      hwmon: (f71882fg) Add support for f81768d

Guenter Roeck (24):
      hwmon: (adm1275) Use BIT macro
      hwmon: (adm1275) Introduce configuration data structure for coeffcients
      hwmon: (adm1275) Introduce new feature flags
      hwmon: (pmbus) Add support for lowest power value attributes
      hwmon: (adm1275) Add support for ADM1293 and ADM1294
      hwmon: (ltc2978) LTM4676 supports CLEAR_PEAKS
      hwmon: (pmbus) Add support for VR12
      hwmon: (pmbus) Add support for MAX20751
      hwmon: (pmbus) Add device IDs for TPS544{B,C}2{0,5}
      hwmon: (ltc2978) Move code to read chip ID into separate function
      hwmon: (ltc2978) Add support for LTC3882
      hwmon: (ltc2978) Add additional chip IDs for LTM4676 and LTM4676A
      hwmon: (ltc2978) Add support for LTC3887
      hwmon: (ltc2978) Add support for LTC2975
      hwmon: (pmbus) Convert command register definitions to enum
      hwmon: (ltc2978) Introduce feature flags
      hwmon: (ltc2978) Introduce helper functions for min and max values
      hwmon: (ltc2978) Use correct ID mask to detect all chips
      hwmon: (ltc2978) Add missing chip IDs for LTC2978 and LTC3882
      hwmon: (ltc2978) Add support for LTC2980 and LTM2987
      hwmon: (ltc2978) Add support for LTC3886
      hwmon: (pmbus) Use BIT macro
      hwmon: (pmbus) Enable PEC if the controller supports it
      hwmon: (ltc2978) Add support for LTM4675

Huang Rui (5):
      hwmon: (fam15h_power) Add support for AMD Carrizo
      hwmon: (fam15h_power) Rename fam15h_power_is_internal_node0 function
      hwmon: (fam15h_power) Update running_avg_capture bit field to 28
      hwmon: (fam15h_power) Add documentation for new processors support
      hwmon: (fam15h_power) Add ratio of Tsample to the PTSC period

Justin Maggard (1):
      hwmon: (it87) Add support for IT8732F

Krzysztof Kozlowski (1):
      hwmon: (g762) Drop owner assignment from struct i2c_driver

Michael Jones (1):
      hwmon: (ltc2978) Add polling for chips requiring it

Peter Hung (3):
      hwmon: (f71882fg) Add support for F81866 and F71868
      hwmon: (f71882fg) Fix f81866a temp/beep setting
      hwmon:(f71882fg) Fix f81866a voltage protection

Rabin Vincent (1):
      hwmon: (lm70) add device tree support

yalin wang (1):
      hwmon:change sht15_reverse()

 Documentation/devicetree/bindings/hwmon/lm70.txt   |  21 +
 .../devicetree/bindings/hwmon/ltc2978.txt          |  12 +-
 Documentation/hwmon/adm1275                        |  40 +-
 Documentation/hwmon/fam15h_power                   |  10 +-
 Documentation/hwmon/it87                           |  35 +-
 Documentation/hwmon/ltc2978                        | 132 ++++--
 Documentation/hwmon/max20751                       |  77 ++++
 Documentation/hwmon/nct7802                        |   3 +-
 Documentation/hwmon/pmbus                          |   8 +-
 MAINTAINERS                                        |   7 +
 drivers/hwmon/Kconfig                              |   4 +-
 drivers/hwmon/f71882fg.c                           | 176 ++++++--
 drivers/hwmon/fam15h_power.c                       |  36 +-
 drivers/hwmon/g762.c                               |   1 -
 drivers/hwmon/it87.c                               |  43 +-
 drivers/hwmon/lm70.c                               |  34 +-
 drivers/hwmon/nct7802.c                            | 317 +++++++++++++-
 drivers/hwmon/pmbus/Kconfig                        |  20 +-
 drivers/hwmon/pmbus/Makefile                       |   1 +
 drivers/hwmon/pmbus/adm1275.c                      | 358 ++++++++++-----
 drivers/hwmon/pmbus/lm25066.c                      |   7 +-
 drivers/hwmon/pmbus/ltc2978.c                      | 482 ++++++++++++++++-----
 drivers/hwmon/pmbus/max20751.c                     |  64 +++
 drivers/hwmon/pmbus/max34440.c                     |   9 +-
 drivers/hwmon/pmbus/max8688.c                      |  19 +-
 drivers/hwmon/pmbus/pmbus.c                        |   5 +
 drivers/hwmon/pmbus/pmbus.h                        | 448 +++++++++----------
 drivers/hwmon/pmbus/pmbus_core.c                   |  31 +-
 drivers/hwmon/pmbus/zl6100.c                       |  11 +-
 drivers/hwmon/sht15.c                              |  20 +-
 30 files changed, 1808 insertions(+), 623 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm70.txt
 create mode 100644 Documentation/hwmon/max20751
 create mode 100644 drivers/hwmon/pmbus/max20751.c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
