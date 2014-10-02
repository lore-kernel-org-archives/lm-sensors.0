From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 02 Oct 2014 03:25:09 +0000
Subject: Re: [lm-sensors] [PATCH v4 0/4] regulator support for pmbus and ltc2978
Message-Id: <542CC595.1050102@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412190349-16343-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1412190349-16343-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: atull@opensource.altera.com, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On 10/01/2014 12:05 PM, atull@opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
>
> This set of patches adds regulator support for pmbus_core.c and ltc2978.c
>
> Each output has individual on/off control.
>
>>From PMBus_Specification_Part_II_Rev_1-3_20140318.pdf:
> 12.1.1. OPERATION Command Bit [7]
>    Bit [7] controls whether the PMBus device output is on or off.
>     If bit [7] is cleared (equals 0), then the output is off.
>     If bit [7] is set (equals 1), then the output is on.
>
> Fixes in v4 are not huge:
>    Add device tree bindings documentation for ltc2978.
>    rename _pmbus_regulator_enable to _pmbus_regulator_on_off
>    simplify _pmbus_regulator_on_off code
>    s/regulator_regulator/regulator/
>    fix build break when !CONFIG_REGULATOR
>    remove unused #define PB_OPERATION_CONTROL_SEQ_OFF
>    fix a #endif comment
>    simplify probe code, remove added switch statement
>    remove BUG_ON(), add error message and fix num_regulators
>
> Patch 1: document device tree bindings for ltc2978
>
> Patch 2: add two helper functions for byte pmbus byte operations
>    * byte write and byte read/modify/write
>
> Patch 3: regulator support added in pmbus_core.c and pmbus.h
>    * regulator_ops functions (is_enabled, enable, and disable)
>    * gets regulator init data from device tree or platform data
>    * registers the regulators
>    * header has a macro for chip drivers to build their
>      regulator_desc data
>
> Patch 4: changes for ltc2978.c
>    * Add Kconfig to enable/disable ltc2978 regulator functionality
>    * add regulator_desc and of_regulator_match info
>    * use same structs for all parts; set num_regulators appropriately.
>
> Alan Tull (3):
>    pmbus: core: add helpers for byte write and read modify write
>    pmbus: add regulator support
>    pmbus: ltc2978: add regulator support
>
> Alan Tull (4):
>    hwmon: ltc2978: device tree bindings documentation
>    pmbus: core: add helpers for byte write and read modify write
>    pmbus: add regulator support
>    pmbus: ltc2978: add regulator support
>
>   .../devicetree/bindings/hwmon/ltc2978.txt          |   42 +++++
>   drivers/hwmon/pmbus/Kconfig                        |    7 +
>   drivers/hwmon/pmbus/ltc2978.c                      |   37 +++++
>   drivers/hwmon/pmbus/pmbus.h                        |   26 ++++
>   drivers/hwmon/pmbus/pmbus_core.c                   |  160 ++++++++++++++++++++
>   include/linux/i2c/pmbus.h                          |    4 +
>   6 files changed, 276 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
>

Overall looks ok. There is a whitespace error in patch #1, and the revision history
should be after --- since we don't want it in the commit log. I fixed those up,
and applied the series to my local hwmon-next branch. I'll do some more testing
on a real system and then push it into -next. That should happen tomorrow
unless I encounter some problems.

We can take care of the Kconfig messages with a follow-up patch.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
