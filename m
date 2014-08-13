From: Andreas Werner <andreas.werner@men.de>
Date: Wed, 13 Aug 2014 08:38:20 +0000
Subject: [lm-sensors] [PATCH v4 0/4] Introduce MEN 14F021P BMC driver series
Message-Id: <cover.1407918792.git.andreas.werner@men.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: andreas.werner@men.de, sameo@linux.intel.com, lee.jones@linaro.org, wim@iguana.be, linux-watchdog@vger.kernel.org, cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org

This patch set add support for the MEN 14F021P00 Board Management called BMC.

The BMC is a PIC Mikrocontroller which assembled on almost all of our
3U Compact PCI CPU board and a few Box PCs.
main part of the BMC is to start and monitor the board, but there are a
lot more features which can be accessed using an I2C Host interface

Features supported in this Patchset:
        - Watchdog
        - LEDs
	- HWMON

The Patchset includes a MFD Core driver, Watchdog, hwmon  and LEDs driver.

Changes in v4:
	- fixed some style issues
	- fixed GPL license version
	- added hwmon voltage monitoring slave driver

Changes in v3:
        - deleted i2c_smbus wrapper functions and use native one
        - some cosmentics and variable renaming to be more clear
        - renamed "leave production" mode to "exit production mode"

Changes in v2:
        - changed i2c_smbus_read wrapper function to return both, value
          and error.
        - moved "leave production mode" from Watchdog driver to mfd core.
        - fixed some return values in the watchdog driver to return the original
          error value instead of -EIO.


Andreas Werner (4):
  drivers/mfd/menf21bmc: introduce MEN 14F021P00 BMC MFD Core driver
  drivers/watchdog/menf21bmc_wdt: introduce MEN 14F021P00 BMC Watchdog
    driver
  drivers/leds/leds-menf21bmc: introduce MEN 14F021P00 BMC LED driver
  drivers/hwmon/menf21bmc_hwmon: introduce MEN14F021P00 BMC HWMON driver

 drivers/hwmon/Kconfig            |   7 ++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/menf21bmc_hwmon.c  | 238 +++++++++++++++++++++++++++++++++++++++
 drivers/leds/Kconfig             |   6 +
 drivers/leds/Makefile            |   1 +
 drivers/leds/leds-menf21bmc.c    | 131 +++++++++++++++++++++
 drivers/mfd/Kconfig              |  12 ++
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/menf21bmc.c          | 132 ++++++++++++++++++++++
 drivers/watchdog/Kconfig         |   7 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/menf21bmc_wdt.c | 203 +++++++++++++++++++++++++++++++++
 12 files changed, 740 insertions(+)
 create mode 100644 drivers/hwmon/menf21bmc_hwmon.c
 create mode 100644 drivers/leds/leds-menf21bmc.c
 create mode 100644 drivers/mfd/menf21bmc.c
 create mode 100644 drivers/watchdog/menf21bmc_wdt.c

-- 
2.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
