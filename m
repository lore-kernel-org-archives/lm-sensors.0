From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Date: Sat, 03 Mar 2012 11:18:03 +0000
Subject: [lm-sensors] [PATCH 0/4] thermal: exynos: Add kernel thermal support for exynos platform
Message-Id: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

Changes since RFC:
*Moved the Temperature sensor driver from driver/hwmon/ to driver/mfd
 as discussed with Guenter Roeck <guenter.roeck@ericsson.com> and 
 Donggeun Kim <dg77.kim@samsung.com> (https://lkml.org/lkml/2012/1/5/7)
*Some changes according to the changes in common cpu cooling APIs

All the patchset based on Kernel version 3.3-rc5 and uses the cpufreq
cooling registration APIs implemented in earlier patchset 
https://lkml.org/lkml/2012/2/22/123

The code added in this patchset adds a thermal interface layer for samsung
exynos platforms. This layer is registered from the temperature sensor driver 
and recieves/monitor the temperature from the sensor and informs the
generic thermal layer to take the necessary cooling action. Currently, this
layer can be used to create only one thermal zone and hence only one
temperature sensor can register. The future goal is to make this handle
multiple thermal zones.

Some modifications are done in the temperature sensor driver to export the
information needed for the thermal interface to register with the core linux
thermal framework and with the cpu frequency based cooling devices.

A simple data/control flow diagrams to illustrate this,

Core Linux thermal <------->  Exynos thermal  <-------- Temperature Sensor
	  |                             |
	 \|/                            |
  Cpufreq cooling device <-----


Amit Daniel Kachhap (4):
  thermal: exynos: Add thermal interface support for linux thermal
    layer
  hwmon: exynos4: Move thermal sensor driver to driver/mfd directory
  thermal: exynos4: Register the tmu sensor with the thermal interface
    layer
  ARM: exynos4: Add thermal sensor driver platform device support

 Documentation/hwmon/exynos4_tmu           |   81 -----
 Documentation/mfd/exynos4_tmu             |   52 +++
 arch/arm/mach-exynos/Kconfig              |   11 +
 arch/arm/mach-exynos/Makefile             |    1 +
 arch/arm/mach-exynos/clock.c              |    4 +
 arch/arm/mach-exynos/dev-tmu.c            |   64 ++++
 arch/arm/mach-exynos/include/mach/irqs.h  |    2 +
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-origen.c        |    1 +
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 drivers/hwmon/Kconfig                     |   10 -
 drivers/hwmon/Makefile                    |    1 -
 drivers/hwmon/exynos4_tmu.c               |  514 -----------------------------
 drivers/mfd/Kconfig                       |   10 +
 drivers/mfd/Makefile                      |    1 +
 drivers/mfd/exynos4_tmu.c                 |  443 +++++++++++++++++++++++++
 drivers/thermal/Kconfig                   |    8 +
 drivers/thermal/Makefile                  |    1 +
 drivers/thermal/exynos_thermal.c          |  272 +++++++++++++++
 include/linux/exynos_thermal.h            |   72 ++++
 include/linux/platform_data/exynos4_tmu.h |    7 +
 21 files changed, 951 insertions(+), 606 deletions(-)
 delete mode 100644 Documentation/hwmon/exynos4_tmu
 create mode 100644 Documentation/mfd/exynos4_tmu
 create mode 100644 arch/arm/mach-exynos/dev-tmu.c
 delete mode 100644 drivers/hwmon/exynos4_tmu.c
 create mode 100644 drivers/mfd/exynos4_tmu.c
 create mode 100644 drivers/thermal/exynos_thermal.c
 create mode 100644 include/linux/exynos_thermal.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
