From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 03 Aug 2015 15:22:48 +0000
Subject: [lm-sensors] [PATCH v2 00/10] Platform support for thermal management on Juno
Message-Id: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, edubezval@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com, linux@roeck-us.net, viresh.kumar@linaro.org

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

Patch 4 is a fix that aligns the behaviour of
thermal_zone_of_sensor_register with it's documented return value when
THERMAL_OF is configured off.

Patches 5-8 create a hwmon sensor driver for sensors provided by SCPI
firmware. Patch 7 adds support for the temperature sensors to register
with the thermal framework. This allows setting up platform thermals
using OF thermal bindings.

The last two patches add support for the sensors and the thermal zones
in the Juno device tree.

The Juno specific patches depend on SCPI and cpufreq patches[0] from
Sudeep. The SCPI protocol document with details of the sensor
interface can be found at [1], [2].

Thanks,
Punit

Changes v1->v2
  - added documentation for the scpi-hwmon driver
  - replaced static allocation of platform structure in scpi-hwmon.c
    with dynamic allocation
  - re-structured registering of thermal zones to better handle
    error conditions
  - reduced chattiness in scpi-hwmon.c
  - corrected sensor numbering to align with hwmon documentation
  - dynamic allocation of attributes and attribute groups

[0] http://thread.gmane.org/gmane.linux.kernel/2009735
[1] http://community.arm.com/servlet/JiveServlet/download/8401-45-18326/DUI0922B_scp_message_interface.pdf
[2] https://wiki.linaro.org/ARM/Juno?action=AttachFile&do=get&target=DUI0922B_scp_message_interface.pdf
v1: http://thread.gmane.org/gmane.linux.kernel/2002152

Punit Agrawal (10):
  devicetree: bindings: Add optional dynamic-power-coefficient property
  cpufreq-dt: Supply power coefficient when registering cooling devices
  cpufreq: arm_big_little: Add support to register a cpufreq cooling
    device
  thermal: Fix thermal_zone_of_sensor_register to match documentation
  Documentation: add DT bindings for ARM SCPI sensors
  firmware: arm_scpi: Extend to support sensors
  hwmon: Support sensors exported via ARM SCP interface
  hwmon: Support registration of thermal zones for SCP temperature
    sensors
  arm64: dts: Add sensor node to Juno dt
  arm64: dts: Create SoC thermal zone for Juno

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  15 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |  15 ++
 Documentation/hwmon/scpi-hwmon                     |  33 +++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   5 +
 arch/arm64/boot/dts/arm/juno.dts                   |  50 ++++
 drivers/cpufreq/arm_big_little.c                   |  52 +++-
 drivers/cpufreq/cpufreq-dt.c                       |   9 +-
 drivers/firmware/arm_scpi.c                        |  60 +++++
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scpi-hwmon.c                         | 284 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |  17 ++
 include/linux/thermal.h                            |   2 +-
 13 files changed, 546 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/hwmon/scpi-hwmon
 create mode 100644 drivers/hwmon/scpi-hwmon.c

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
