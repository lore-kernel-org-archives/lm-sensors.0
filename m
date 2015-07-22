From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 22 Jul 2015 14:02:34 +0000
Subject: [lm-sensors] [PATCH 0/9] Platform support for thermal management on Junoe
Message-Id: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, edubezval@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com, linux@roeck-us.net, viresh.kumar@linaro.org

Hi,

The series adds support for thermal management on ARM Juno development
platform. As part of this development, common infrastructure is added
to support registering cpu cooling devices that work with the power
allocator thermal governor.

Patch 1 extends the CPU nodes binding to provide an optional dynamic
power coefficient which can be used to create a dynamic power model
for the CPUs. This model is used to constrain device power consumption
(using power_allocator governor) when the system is thermally
constrained.

Patches 2-3 extends the cpufreq-dt and arm_big_little driver to
register cpu cooling devices with the dynamic coefficient when
provided.

Patches 4-7 create a hwmon sensor driver for sensors provided by SCPI
firmware. Patch 7 adds support for the temperature sensors to register
with the thermal framework. This allows setting up platform thermals
using OF thermal bindings.

The last two patches add support for the sensors and the thermal zones
in the Juno device tree.

The Juno specific patches depend on SCPI and cpufreq patches[0] from Sudeep.

Thanks,
Punit

[0] http://thread.gmane.org/gmane.linux.power-management.general/61073

Punit Agrawal (9):
  devicetree: bindings: Add optional dynamic-power-coefficient property
  cpufreq-dt: Supply power coefficient when registering cooling devices
  cpufreq: arm_big_little: Add support to register a cpufreq cooling
    device
  Documentation: add DT bindings for ARM SCPI sensors
  firmware: arm_scpi: Extend to support sensors
  hwmon: Support sensors exported via ARM SCP interface
  hwmon: Support registration of thermal zones for SCP temperature
    sensors
  arm64: dts: Add sensor node to Juno dt
  arm64: dts: Create SoC thermal zone for Juno

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  15 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |  15 ++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   5 +
 arch/arm64/boot/dts/arm/juno.dts                   |  50 ++++
 drivers/cpufreq/arm_big_little.c                   |  52 +++-
 drivers/cpufreq/cpufreq-dt.c                       |   9 +-
 drivers/firmware/arm_scpi.c                        |  60 +++++
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scpi-hwmon.c                         | 265 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |  17 ++
 11 files changed, 493 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hwmon/scpi-hwmon.c

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
