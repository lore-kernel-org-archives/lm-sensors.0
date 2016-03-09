From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 09 Mar 2016 21:35:22 +0000
Subject: [lm-sensors] [PATCH 00/13] thermal: convert users of thermal_zone_of_sensor_register to devm_
Message-Id: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>

Hello,

Given that now we have a devm version of thermal_zone_of_sensor_register [1],
I am sending this series of patches to convert its users to use the devm_
API.

Driver's authors, please comment.

BR,

Eduardo Valentin (13):
  hwmon: convert lm75 to use devm_thermal_zone_of_sensor_register
  hwmon: convert ntc_thermistor to use
    devm_thermal_zone_of_sensor_register
  hwmon: convert tmp102 to use devm_thermal_zone_of_sensor_register
  hwmon: convert scpi-hwmon to use devm_thermal_zone_of_sensor_register
  input: convert sun4i-ts to use devm_thermal_zone_of_sensor_register
  thermal: convert hisi_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert mtk_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert qcom-spmi to use devm_thermal_zone_of_sensor_register
  thermal: convert rcar_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert rockchip_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert exynos to use devm_thermal_zone_of_sensor_register
  thermal: convert tegra_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert ti-thermal to use
    devm_thermal_zone_of_sensor_register

 drivers/hwmon/lm75.c                               | 10 ++----
 drivers/hwmon/ntc_thermistor.c                     | 12 +++----
 drivers/hwmon/scpi-hwmon.c                         | 41 +++++-----------------
 drivers/hwmon/tmp102.c                             |  8 ++---
 drivers/input/touchscreen/sun4i-ts.c               |  9 +----
 drivers/thermal/hisi_thermal.c                     |  5 ++-
 drivers/thermal/mtk_thermal.c                      | 12 ++-----
 drivers/thermal/qcom-spmi-temp-alarm.c             |  3 +-
 drivers/thermal/rcar_thermal.c                     |  2 +-
 drivers/thermal/rockchip_thermal.c                 | 17 +++------
 drivers/thermal/samsung/exynos_tmu.c               | 12 +++----
 drivers/thermal/tegra_soctherm.c                   | 31 +++++-----------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  5 +--
 13 files changed, 42 insertions(+), 125 deletions(-)

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
