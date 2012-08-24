From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 08:32:00 +0000
Subject: [lm-sensors] [RFC PATCH 0/8] DA906x PMIC driver
Message-Id: <201208240830@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, Richard Purdie <rpurdie@rpsys.net>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

Greetings,

The following patch set adds new multifunction device providing support for
DA906x PMIC chips.

Please add some comments to the driver, which targets Linux Kernel v3.6.

Thank you,

---
Krystian Garbaciak (8):
  mfd: Add Dialog DA906x core driver.
  regulator: Add Dialog DA906x voltage regulators support.
  rtc: Add RTC driver for DA906x PMIC.
  hwmon: Add DA906x hardware monitoring support.
  input: Add support for DA906x PMIC OnKey detection.
  input: Add support for DA906x vibration motor driver.
  watchdog: Add DA906x PMIC watchdog driver.
  leds: Add DA906x PMIC LED driver.

 drivers/hwmon/Kconfig                 |    6 +
 drivers/hwmon/Makefile                |    1 +
 drivers/hwmon/da906x-hwmon.c          |  393 ++++++++++++
 drivers/input/misc/Kconfig            |   13 +
 drivers/input/misc/Makefile           |    2 +
 drivers/input/misc/da906x-onkey.c     |  139 +++++
 drivers/input/misc/da906x-vibration.c |  153 +++++
 drivers/leds/Kconfig                  |    8 +
 drivers/leds/Makefile                 |    1 +
 drivers/leds/leds-da906x.c            |  438 +++++++++++++
 drivers/mfd/Kconfig                   |   11 +
 drivers/mfd/Makefile                  |    4 +
 drivers/mfd/da906x-core.c             |  228 +++++++
 drivers/mfd/da906x-i2c.c              |  389 ++++++++++++
 drivers/mfd/da906x-irq.c              |  192 ++++++
 drivers/regulator/Kconfig             |    6 +
 drivers/regulator/Makefile            |    1 +
 drivers/regulator/da906x-regulator.c  | 1018 ++++++++++++++++++++++++++++++
 drivers/rtc/Kconfig                   |    7 +
 drivers/rtc/Makefile                  |    1 +
 drivers/rtc/rtc-da906x.c              |  379 ++++++++++++
 drivers/watchdog/Kconfig              |   27 +
 drivers/watchdog/Makefile             |    1 +
 drivers/watchdog/da906x_wdt.c         |  276 +++++++++
 include/linux/mfd/da906x/core.h       |  121 ++++
 include/linux/mfd/da906x/pdata.h      |  114 ++++
 include/linux/mfd/da906x/registers.h  | 1093 +++++++++++++++++++++++++++++++++
 27 files changed, 5022 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/da906x-hwmon.c
 create mode 100644 drivers/input/misc/da906x-onkey.c
 create mode 100644 drivers/input/misc/da906x-vibration.c
 create mode 100644 drivers/leds/leds-da906x.c
 create mode 100644 drivers/mfd/da906x-core.c
 create mode 100644 drivers/mfd/da906x-i2c.c
 create mode 100644 drivers/mfd/da906x-irq.c
 create mode 100644 drivers/regulator/da906x-regulator.c
 create mode 100644 drivers/rtc/rtc-da906x.c
 create mode 100644 drivers/watchdog/da906x_wdt.c
 create mode 100644 include/linux/mfd/da906x/core.h
 create mode 100644 include/linux/mfd/da906x/pdata.h
 create mode 100644 include/linux/mfd/da906x/registers.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
