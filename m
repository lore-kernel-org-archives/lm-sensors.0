From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Nov 2013 17:47:58 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 3.13-rc1 [#2]
Message-Id: <20131121174758.GA12141@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux 3.13-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit 2d3c627502f2a9b0a7de06a5a2df2365542a72c9:

  Revert "init/Kconfig: add option to disable kernel compression" (2013-11-17 11:17:36 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 3a4cbc190643d0c6f7ca36a84af8367947f558c7:

  hwmon: (acpi_power_meter) Fix acpi_bus_get_device() return value check (2013-11-20 08:31:01 -0800)

----------------------------------------------------------------
hwmon updates for 3.13-rc1 [#2]

acpi_power_meter: Fix return value check from call to acpi_bus_get_device
nct6775: Fix/improve NCT6791 support
lm75: Add support for GMT G751

----------------------------------------------------------------
Arnaud Ebalard (1):
      hwmon: (lm75) Add support for GMT G751 chip

Guenter Roeck (2):
      hwmon: (nct6775) Monitor additional temperature registers
      hwmon: (nct6775) NCT6791 supports weight control only for CPUFAN

Yijing Wang (1):
      hwmon: (acpi_power_meter) Fix acpi_bus_get_device() return value check

 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 drivers/hwmon/Kconfig                              |    1 +
 drivers/hwmon/acpi_power_meter.c                   |    5 +-
 drivers/hwmon/lm75.c                               |    3 +
 drivers/hwmon/nct6775.c                            |   91 +++++++++++++++++---
 5 files changed, 88 insertions(+), 13 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
