From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Jun 2013 22:22:53 +0000
Subject: [lm-sensors] [PATCHv6 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <87hagzj9oi.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>


GMT G762/763 fan speed PWM controller is connected directly to a fan
and performs closed-loop or open-loop control of the fan speed. Two
modes - PWM or DC - are supported by the chip. Introduced driver
provides various knobs to control the operations of the chip (via
sysfs interface). Specific characteristics of the system can be passed
either using board init code or via DT. Documentation for both the
driver and DT bindings are also provided.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Guenter,

In the end, I think handling the clock properly for DT path
(clk_prepare_enable() and associated clk_disable_unprepare()
for both error and module unloading) adds some code but I
do not see how to spare this. Comments welcome.

If you have additional comments and a new version is required,
I'll handle those with Simon's tests on its platform.

Cheers,

a+

Changes since v5:
    fixed useless ret parameter init in various functions
    removed useless goto in favour of direct return
    enable fan detection and fan ooc protection in an init function
    correctly balance clk_prepare_enable() by clk_disable_unprepare()
    more tests w/o CONFIG_OF and with driver as module (load/unload)
    fixed missing ref_clk init in platform_data path
    fixed patch version (previous v5 was mistakenly named v4)

Changes since v4:
    Removed unused defines
    fixed some comments
    s/pwm_freq/clk_freq/g and fixed associated comments
    removed useless settings of data->valid to false
    do not hide original return code in g762_one_prop_commit()
    replaced ref_clk property by a required reference to a clock in .dts
    drop fan_pulses property in DT and provide sysfs attribute
    removed whole G762_VAL_TEST_BIT hack
    still not supporting 0 for pwm_enable: fixed comment
    fixed comment for get/set_pwm()
    fixed reversed polarity setter logic
    simplified do_set_pwm()
    merged all three patches into one
    Fixed issue reported by Simon (open-loop not working when set_cnt is 255)

Changes since v3:
    set is against current head of Linus tree
    removed dev_err() calls when i2c_smbus_read/write_byte_data() fails
    pwm1 sets SET_OUT reg, fan1_target sets SET_CNT reg, both unconditionally
    removed all DT and platform_data knobs available via sysfs
    updated documentation files to reflect two previous changes

Changes since v2:
    set ref_clk value to 32768 if not overloaded
    fixed multi-line comment format in g762.h
    removed static const G762_DEFAULT_PDATA in g762.h for a function
    CodingStyle: add spaces between operatoirs when missing
    check return value of i2c_smbus_{read,write}_byte_data()
    remove { } is not needed in single-statement conditionals
    introduced G762_ATTR_VAL() to allow sparse init of platform_data struc
    changed missed reference to linear mode for DC mode

Changes since v1
    Changed author
    removed bad tabs
    Provide datasheet link w/o fud in g762 documentation
    removed documentation for removed fan_gear_mode sysfs entry
    removed tested-by from patch
    removed FSF address in header file
    removed useless include of <linux/slab.h>
    removed useless parenthesis against HZ in define
    use spaces around binary operators
    use i2c_smbus_{read,write}_byte_data() instead of g762_{read,write}_value()
    use return value of i2c_smbus_write_byte_data()
    use true for initializing boolean
    removed useless blank lines
    do not enforce single return point rule where less readable
    use dev_err() and dev_dbg() instead of dev_info() when it makes sense
    remove leading '&' for function passed as pointers
    allow passing parameter via platform_data struct for non-DT enabled boards
    set data->valid to false when config is modified
    s/linear/DC/ for mode (g762 datasheet uses linear)
    more tests on rpm_from_cnt() and cnt_from_rpm() formula
    dont overload

Changes since v0
    removed forward declaration
    use bool for valid field instead of bit field.
    protect macro args
    fixed typo in subject line
    Added mention for G763 support in Kconfig
    fixed typo in driver name in Kconfig
    do not use DRVNAME in i2c_device_id g762_id[]
    Following discussions, kept DEVICE_ATTR (no switch to SENSOR_DEVICE_ATTR)
    removed useless casts when flipping bit values
    Sanity check user input value (e.g. to prevent 256 to silenty become 0)
    Added extra lines for multi line comments when needed
    removed various testing knobs
    make removed knobs available via DT
    passed checkpatch script on the patch
    removed useless lock protection againt clk setting
    moved all setter at the beginning of the file
    removed bad (u16) casts in g762_write_value() calls


 Documentation/devicetree/bindings/hwmon/g762.txt |   47 ++++++++++++++++
 Documentation/hwmon/g762                         |   65 ++++++++++++++++++++++
 drivers/hwmon/Kconfig                            |   10 ++++
 drivers/hwmon/Makefile                           |    1 +
 include/linux/platform_data/g762.h               |   37 ++++++++++++
 5 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/hwmon/g762
 create mode 100644 include/linux/platform_data/g762.h

diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
new file mode 100644
index 0000000..25cc6d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/g762.txt
@@ -0,0 +1,47 @@
+GMT G762/G763 PWM Fan controller
+
+Required node properties:
+
+ - "compatible": must be either "gmt,g762" or "gmt,g763"
+ - "reg": I2C bus address of the device
+ - "clocks": a fixed clock providing input clock frequency
+	     on CLK pin of the chip.
+
+Optional properties:
+
+ - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
+	       The higher the more.
+
+ - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
+	       and 1 (negative duty).
+
+ - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
+
+If an optional property is not set in .dts file, then current value is kept
+unmodified (e.g. u-boot installed value).
+
+Additional information on operational parameters for the device is available
+in Documentation/hwmon/g762. A detailed datasheet for the device is available
+at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
+
+Example g762 node:
+
+   clocks {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	g762_clk: fixedclk {
+		 compatible = "fixed-clock";
+		 #clock-cells = <0>;
+		 clock-frequency = <8192>;
+	}
+   }
+
+   g762: g762@3e {
+	compatible = "gmt,g762";
+	reg = <0x3e>;
+	clocks = <&g762_clk>
+	fan_gear_mode = <0>; /* chip default */
+	fan_startv = <1>;    /* chip default */
+	pwm_polarity = <0>;  /* chip default */
+   };
diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
new file mode 100644
index 0000000..923db9c
--- /dev/null
+++ b/Documentation/hwmon/g762
@@ -0,0 +1,65 @@
+Kernel driver g762
+=========
+
+The GMT G762 Fan Speed PWM Controller is connected directly to a fan
+and performs closed-loop or open-loop control of the fan speed. Two
+modes - PWM or DC - are supported by the device.
+
+For additional information, a detailed datasheet is available at
+http://natisbad.org/NAS/ref/GMT_EDS-762_763-080710-0.2.pdf. sysfs
+bindings are described in Documentation/hwmon/sysfs-interface.
+
+The following entries are available to the user in a subdirectory of
+/sys/bus/i2c/drivers/g762/ to control the operation of the device.
+This can be done manually using the following entries but is usually
+done via a userland daemon like fancontrol.
+
+Note that those entries do not provide ways to setup the specific
+hardware characteristics of the system (reference clock, pulses per
+fan revolution, ...); Those can be modified via devicetree bindings
+documented in Documentation/devicetree/bindings/hwmon/g762.txt or
+using a specific platform_data structure in board initialization
+file (see include/linux/platform_data/g762.h).
+
+  fan1_target: set desired fan speed. This only makes sense in closed-loop
+            fan speed control (i.e. when pwm1_enable is set to 2).
+
+  fan1_input: provide current fan rotation value in RPM as reported by
+            the fan to the device.
+
+  fan1_div: fan clock divisor. Supported value are 1, 2, 4 and 8.
+
+  fan1_pulses: number of pulses per fan revolution. Supported values
+            are 2 and 4.
+
+  fan1_fault: reports fan failure, i.e. no transition on fan gear pin for
+            about 0.7s (if the fan is not voluntarily set off).
+
+  fan1_alarm: in closed-loop control mode, if fan RPM value is 25% out
+            of the programmed value for over 6 seconds 'fan1_alarm' is
+            set to 1.
+
+  pwm1_enable: set current fan speed control mode i.e. 1 for manual fan
+            speed control (open-loop) via pwm1 described below, 2 for
+            automatic fan speed control (closed-loop) via fan1_target
+            above.
+
+  pwm1_mode: set or get fan driving mode: 1 for PWM mode, 0 for DC mode.
+
+  pwm1: get or set PWM fan control value in open-loop mode. This is an
+            integer value between 0 and 255. 0 stops the fan, 255 makes
+            it run at full speed.
+
+Both in PWM mode ('pwm1_mode' set to 1) and DC mode ('pwm1_mode' set to 0),
+when current fan speed control mode is open-loop ('pwm1_enable' set to 1),
+the fan speed is programmed by setting a value between 0 and 255 via 'pwm1'
+entry (0 stops the fan, 255 makes it run at full speed). In closed-loop mode
+('pwm1_enable' set to 2), the expected rotation speed in RPM can be passed to
+the chip via 'fan1_target'. In closed-loop mode, the target speed is compared
+with current speed (available via 'fan1_input') by the device and a feedback
+is performed to match that target value. The fan speed value is computed
+based on the parameters associated with the physical characteristics of the
+system: a reference clock source frequency, a number of pulses per fan
+revolution, etc.
+
+Note that the driver will update its values at most once per second.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0428e8a..142bdf8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -456,6 +456,16 @@ config SENSORS_G760A
 	  This driver can also be built as a module.  If so, the module
 	  will be called g760a.
 
+config SENSORS_G762
+	tristate "GMT G762 and G763"
+	depends on I2C
+	help
+	  If you say yes here you get support for Global Mixed-mode
+	  Technology Inc G762 and G763 fan speed PWM controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called g762.
+
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d17d3e6..4f0fb52 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
 obj-$(CONFIG_SENSORS_FAM15H_POWER) += fam15h_power.o
 obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
+obj-$(CONFIG_SENSORS_G762)	+= g762.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
diff --git a/include/linux/platform_data/g762.h b/include/linux/platform_data/g762.h
new file mode 100644
index 0000000..d3c5128
--- /dev/null
+++ b/include/linux/platform_data/g762.h
@@ -0,0 +1,37 @@
+/*
+ * Platform data structure for g762 fan controller driver
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __LINUX_PLATFORM_DATA_G762_H__
+#define __LINUX_PLATFORM_DATA_G762_H__
+
+/*
+ * Following structure can be used to set g762 driver platform specific data
+ * during board init. Note that passing a sparse structure is possible but
+ * will result in non-specified attributes to be set to default value, hence
+ * overloading those installed during boot (e.g. by u-boot).
+ */
+
+struct g762_platform_data {
+	u32 fan_startv;
+	u32 fan_gear_mode;
+	u32 pwm_polarity;
+	u32 clk_freq;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_G762_H__ */
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
