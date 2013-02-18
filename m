From: Wei Ni <wni@nvidia.com>
Date: Mon, 18 Feb 2013 11:30:22 +0000
Subject: [lm-sensors] [RFC PATCH 0/9] Support for tegra30 thermal.
Message-Id: <1361187031-3679-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org, Wei Ni <wni@nvidia.com>

This patch series is to add tegra30 thermal driver.
It use new linux thermal framework, which is developing by Durgadoss.

Note:
1. my series are based on the patches:
http://thread.gmane.org/gmane.linux.power-management.general/30692 ,
which come from Durgadoss.
And the tree is Rui's -next tree.

Next steps:
1. enhance the tegra30 thermal driver, something like handling the irq, setting
the sensor limit value.
2. seprate codes to create a new files which is for cooling device, something
like tegra3_cooling.c. it will handle dvfs.

Wei Ni (9):
  ARM: dt: t30 cardhu: add dt entry for lm90
  hwmon: (lm90) split set&show temp as common codes
  hwmon: (lm90) add support to handle irq
  hwmon: (lm90) use macros for the indexes of temp8 and temp11
  Thermal: Support using dt node to get sensor
  hwmon: (lm90) Register to the thermal framework
  thermal: tegra30: add tegra30 thermal driver
  ARM: dt: t30 cardhu: add dt entry for thermal driver
  ARM: tegra: defconfig: enable thermal framework

 .../devicetree/bindings/thermal/tegra3-thermal.txt |   41 ++
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   27 +
 arch/arm/configs/tegra_defconfig                   |    2 +
 drivers/hwmon/lm90.c                               |  514 +++++++++++++++-----
 drivers/thermal/Kconfig                            |    9 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/tegra3_thermal.c                   |  289 +++++++++++
 drivers/thermal/thermal_sys.c                      |   30 ++
 include/linux/thermal.h                            |    9 +
 9 files changed, 812 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/tegra3-thermal.txt
 create mode 100644 drivers/thermal/tegra3_thermal.c

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
