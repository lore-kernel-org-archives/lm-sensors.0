From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Oct 2014 23:38:45 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for v3.18
Message-Id: <1412811525-26992-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux v3.18 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v3.18

Thanks,
Guenter
------

The following changes since commit 4e66cd13ff9cd7eaae69e2fae0335d8d99d8afdf:

  hwmon: (tmp103) Fix resource leak bug in tmp103 temperature sensor driver (2014-09-22 11:11:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v3.18

for you to fetch changes up to 3afb57fa721f94206e642f8fda51f5a89dda3dfb:

  hwmon: (ab8500) Call kernel_power_off instead of pm_power_off (2014-10-03 08:19:02 -0700)

----------------------------------------------------------------
New driver for menf21bmc.
Convert k10temp, smsc47b397, da9052, da9055 to new hwmon API.
Register ntc_thermistor driver with thermal subsystem.
Add support for F15h M60h to k10temp driver.
Add driver for MEN14F021P00 BMC HWMON driver; this required a merge
with tag mfd-hwmon-leds-watchdog-v3.18.

----------------------------------------------------------------
Andreas Werner (4):
      mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
      watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog driver
      leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
      hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver

Aravind Gopalakrishnan (1):
      hwmon: (k10temp) Add support for F15h M60h

Axel Lin (4):
      hwmon: (ads1015) Use of_property_read_u32 at appropriate places
      hwmon: (da9055) Convert to devm_hwmon_device_register_with_groups
      hwmon: (da9052) Convert to devm_hwmon_device_register_with_groups
      hwmon: (smsc47b397) Convert to devm_hwmon_device_register_with_groups

Guenter Roeck (3):
      hwmon: (k10temp) Convert to devm_hwmon_device_register_with_groups
      Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into hwmon-next
      hwmon: (ab8500) Call kernel_power_off instead of pm_power_off

Jonghwa Lee (1):
      hwmon: (ntc_thermistor) Add ntc thermistor to thermal subsystem as a sensor.

Kamil Debski (1):
      MAINTAINERS: add entry for the PWM fan driver

 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |   3 +
 Documentation/hwmon/k10temp                        |   2 +-
 Documentation/hwmon/menf21bmc                      |  50 +++++
 MAINTAINERS                                        |   8 +
 drivers/hwmon/Kconfig                              |  15 +-
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/ab8500.c                             |   5 +-
 drivers/hwmon/ads1015.c                            |  21 +-
 drivers/hwmon/da9052-hwmon.c                       |  54 +----
 drivers/hwmon/da9055-hwmon.c                       |  52 +----
 drivers/hwmon/k10temp.c                            | 157 +++++++-------
 drivers/hwmon/menf21bmc_hwmon.c                    | 230 +++++++++++++++++++++
 drivers/hwmon/ntc_thermistor.c                     |  25 +++
 drivers/hwmon/smsc47b397.c                         |  51 +----
 drivers/leds/Kconfig                               |   9 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-menf21bmc.c                      | 131 ++++++++++++
 drivers/mfd/Kconfig                                |  15 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/menf21bmc.c                            | 132 ++++++++++++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/menf21bmc_wdt.c                   | 203 ++++++++++++++++++
 23 files changed, 949 insertions(+), 228 deletions(-)
 create mode 100644 Documentation/hwmon/menf21bmc
 create mode 100644 drivers/hwmon/menf21bmc_hwmon.c
 create mode 100644 drivers/leds/leds-menf21bmc.c
 create mode 100644 drivers/mfd/menf21bmc.c
 create mode 100644 drivers/watchdog/menf21bmc_wdt.c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
