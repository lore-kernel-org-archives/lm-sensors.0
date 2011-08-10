From: Keerthy <j-keerthy@ti.com>
Date: Wed, 10 Aug 2011 12:37:16 +0000
Subject: [lm-sensors] [RFC PATCH 0/6] OMAP4: Temperature sensor driver
Message-Id: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, j-keerthy@ti.com

Hello,

The rfc patch series for the on die temperature sensor driver. I need
feedback on the overall structure of the driver.
The rfc patch set has the device file, omap4 on die temperature sensor
hwmon driver. hwmod, clk support. The patch set compiles
on top of LO tree Master branch.

This patch series is tested for boot-up on OMAP4460. The temperature
reading and the interrupts generation on crossing the temperature
thresholds also tested.

Keerthy (6):
  OMAP4: Clock: Associate clocks for OMAP temperature sensor
  OMAP4: Adding the temperature sensor register set bit fields
  OMAP4: Hwmod: OMAP temperature sensor
  OMAP4: Temperature sensor device support
  OMAP4460: Temperature sensor data
  OMAP4: On die temperature sensor driver

 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
 .../include/mach/ctrl_module_core_44xx.h           |   70 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   61 ++
 arch/arm/mach-omap2/temp_sensor4460_data.c         |   63 ++
 arch/arm/mach-omap2/temp_sensor_device.c           |   85 ++
 arch/arm/plat-omap/Kconfig                         |   12 +
 .../plat-omap/include/plat/temperature_sensor.h    |   87 ++
 drivers/hwmon/Kconfig                              |   11 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/omap_temp_sensor.c                   |  950 ++++++++++++++++++++
 11 files changed, 1330 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
 create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c
 create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor.h
 create mode 100644 drivers/hwmon/omap_temp_sensor.c


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
