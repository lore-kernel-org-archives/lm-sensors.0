From: <atull@opensource.altera.com>
Date: Thu, 02 Oct 2014 18:37:47 +0000
Subject: [lm-sensors] [PATCH v5 0/4] This set of patches adds regulator support for pmbus_core.c and ltc2978.
Message-Id: <1412275071-6417-1-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Each output has individual on/off control.

From PMBus_Specification_Part_II_Rev_1-3_20140318.pdf:
12.1.1. OPERATION Command Bit [7]
  Bit [7] controls whether the PMBus device output is on or off.
   If bit [7] is cleared (equals 0), then the output is off.
   If bit [7] is set (equals 1), then the output is on.

This patchset now uses "regulator: of: Provide simplified DT parsing method"
I don't see this patch in Linus's tree or for-next yet, so I applied it to my branch.

New in v5:
  clean whitespace in the DT bindings document
  add prototypes for the two new functions in pmbus_core.c
  use "regulator: of: Provide simplified DT parsing method"
   - remove #include <linux/regulator/of_regulator.h>
   - remove of_regulator_match in pmbus_driver_info
   - add of_match and regulators_node for regulator_desc macro
   - remove pmbus_regulator_parse_dt
   - remove unneeded 'else' that set init_data and of_node

Patch 1: document device tree bindings for ltc2978

Patch 2: add two helper functions for byte pmbus byte operations
  * byte write and byte read/modify/write

Patch 3: regulator support added in pmbus_core.c and pmbus.h
  * regulator_ops functions (is_enabled, enable, and disable)
  * gets regulator init data from device tree or platform data
  * registers the regulators
  * header has a macro for chip drivers to build their
    regulator_desc data

Patch 4: changes for ltc2978.c
  * Add Kconfig to enable/disable ltc2978 regulator functionality.
  * Update list of parts supported in Kconfig.
  * add regulator_desc info.
  * use same structs for all parts; set num_regulators appropriately.

Alan Tull (4):
  hwmon: ltc2978: device tree bindings documentation
  pmbus: core: add helpers for byte write and read modify write
  pmbus: add regulator support
  pmbus: ltc2978: add regulator support

 .../devicetree/bindings/hwmon/ltc2978.txt          |   41 +++++++
 drivers/hwmon/pmbus/Kconfig                        |   11 +-
 drivers/hwmon/pmbus/ltc2978.c                      |   24 ++++
 drivers/hwmon/pmbus/pmbus.h                        |   30 +++++
 drivers/hwmon/pmbus/pmbus_core.c                   |  118 ++++++++++++++++++++
 include/linux/i2c/pmbus.h                          |    4 +
 6 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
