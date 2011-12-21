From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Date: Wed, 21 Dec 2011 12:11:55 +0000
Subject: [lm-sensors] [RFC PATCH 0/3] thermal: exynos: Add kernel thermal
Message-Id: <1324468798-20423-1-git-send-email-amit.kachhap@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linaro-dev@lists.linaro.org, lm-sensors@lm-sensors.org, amit.kachhap@linaro.org, patches@linaro.org

All the patchset based on Kernel version 3.2-rc6 and uses the cpufreq
cooling registration api's implemented in earlier patchset 
http://www.spinics.net/lists/linux-pm/msg26500.html

The code added in this patchset adds a thermal interface layer for samsung
exynos platforms. This layer is registered from the hwmon based temperature
sensor and recieves/monitor the temperature from the sensor and informs the
generic thermal layer to take the necessary cooling action. Currently this
layer can be used to create only one thermal zone and hence only one
temperature sensor can register.

Some modifications are done in the temperature sensor driver to export the
information needed for the thermal interface to register with the core linux
thermal framework and with the cpu frequency based cooling devices.

A simple data/control flow diagrams to illustrate this,

Core Linux thermal <------->  Exynos thermal  <-------- Temperature Sensor
	  |                             |
	 \|/                            |
  Cpufreq cooling device <-----

Amit Daniel Kachhap (3):
  thermal: exynos: Add thermal interface support for linux thermal
    layer
  thermal: exynos4: Register the tmu sensor with the thermal interface
    layer
  ARM: exynos4: Add thermal sensor driver platform device support

 arch/arm/mach-exynos/Kconfig              |   12 ++
 arch/arm/mach-exynos/Makefile             |    1 +
 arch/arm/mach-exynos/clock.c              |    4 +
 arch/arm/mach-exynos/dev-tmu.c            |   64 +++++++
 arch/arm/mach-exynos/include/mach/irqs.h  |    2 +
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-origen.c        |    1 +
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 drivers/hwmon/exynos4_tmu.c               |   34 ++++-
 drivers/thermal/Kconfig                   |    8 +
 drivers/thermal/Makefile                  |    1 +
 drivers/thermal/exynos_thermal.c          |  255 +++++++++++++++++++++++++++++
 include/linux/exynos_thermal.h            |   59 +++++++
 include/linux/platform_data/exynos4_tmu.h |    7 +
 14 files changed, 447 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-exynos/dev-tmu.c
 create mode 100644 drivers/thermal/exynos_thermal.c
 create mode 100644 include/linux/exynos_thermal.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
