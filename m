From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Date: Fri, 14 Sep 2012 13:32:12 +0000
Subject: [lm-sensors] [Patch v1 0/7] DA9055 PMIC driver
Message-Id: <1347628812.18587.4.camel@dhruva>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Alessandro Zummo <a.zummo@towertech.it>, Wim Van Sebroeck <wim@iguana.be>, Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rtc-linux@googlegroups.com, linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>

The following patch series adds support to the DA9055 PMIC.

The DA9055 is a low power Power Management Integrated Circuit. This PMIC
device is only controlled from an I2C device.

The driver for the DA9055 consists of a core (i2c) device driver and its
dependent component device drivers for:
regulator - 2 BUCKS, 6 LDOs
rtc - low power clock
gpio - 3 pins
hwmon - 5 ADC channels
watchdog - system monitor
onkey - button device

These drivers has been tested on a Samsung SMDK6410.

Ashish Jangam (7):
  DA9058 MFD core
  DA9058 REGULATOR driver
  DA9058 RTC driver
  DA9058 GPIO driver
  DA9058 HWMON driver
  DA9058 WATCHDOG driver
  DA9058 ONKEY driver

 Documentation/hwmon/da9055           |   47 +++
 drivers/gpio/Kconfig                 |   11 +
 drivers/gpio/Makefile                |    1 +
 drivers/gpio/gpio-da9055.c           |  204 ++++++++++
 drivers/hwmon/Kconfig                |   10 +
 drivers/hwmon/Makefile               |    1 +
 drivers/hwmon/da9055-hwmon.c         |  342 ++++++++++++++++
 drivers/input/misc/Kconfig           |   10 +
 drivers/input/misc/Makefile          |    1 +
 drivers/input/misc/da9055_onkey.c    |  121 ++++++
 drivers/mfd/Kconfig                  |   17 +
 drivers/mfd/Makefile                 |    3 +
 drivers/mfd/da9055-core.c            |  423 ++++++++++++++++++++
 drivers/mfd/da9055-i2c.c             |   93 +++++
 drivers/regulator/Kconfig            |   10 +
 drivers/regulator/Makefile           |    1 +
 drivers/regulator/da9055-regulator.c |  727
++++++++++++++++++++++++++++++++++
 drivers/rtc/Kconfig                  |   10 +
 drivers/rtc/Makefile                 |    1 +
 drivers/rtc/rtc-da9055.c             |  430 ++++++++++++++++++++
 drivers/watchdog/Kconfig             |   10 +
 drivers/watchdog/Makefile            |    1 +
 drivers/watchdog/da9055_wdt.c        |  227 +++++++++++
 include/linux/mfd/da9055/core.h      |   94 +++++
 include/linux/mfd/da9055/pdata.h     |   32 ++
 include/linux/mfd/da9055/reg.h       |  699
++++++++++++++++++++++++++++++++
 26 files changed, 3526 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/da9055
 create mode 100644 drivers/gpio/gpio-da9055.c
 create mode 100644 drivers/hwmon/da9055-hwmon.c
 create mode 100644 drivers/input/misc/da9055_onkey.c
 create mode 100644 drivers/mfd/da9055-core.c
 create mode 100644 drivers/mfd/da9055-i2c.c
 create mode 100644 drivers/regulator/da9055-regulator.c
 mode change 100644 => 100755 drivers/rtc/Kconfig
 create mode 100644 drivers/rtc/rtc-da9055.c
 create mode 100644 drivers/watchdog/da9055_wdt.c
 create mode 100644 include/linux/mfd/da9055/core.h
 create mode 100644 include/linux/mfd/da9055/pdata.h
 create mode 100644 include/linux/mfd/da9055/reg.h



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
