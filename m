From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Jul 2012 15:43:34 +0000
Subject: [lm-sensors] [PATCH v4] hwmon: Driver for Nuvoton NCT6775F, NCT6776F, and NCT6779D
Message-Id: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This driver will replace the w83627ehf driver for NCT6775F and NCT6776F,
and provides support for NCT6779D.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4:
- Fix "temp" array size (reported by smatch)
- Fix whitespace errors reported by "git am" (but not by checkpatch).
- Order register definition data by chip type
- Improve parameter alignment

v3:
- Variables pwm_temp, REG_TEMP_MON, and NCT6775_REG_TEMP_MON are not used,
  drop it.

v2:
- superio region access protection
- Add support for pwmX_step_enable attribute
- Improved documentation

 Documentation/hwmon/nct6775 |  187 +++
 drivers/hwmon/Kconfig       |   13 +
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/nct6775.c     | 3887 +++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 4088 insertions(+)
 create mode 100644 Documentation/hwmon/nct6775
 create mode 100644 drivers/hwmon/nct6775.c

diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
new file mode 100644
index 0000000..09139a6
--- /dev/null
+++ b/Documentation/hwmon/nct6775
@@ -0,0 +1,187 @@
+Note
+=3D=3D
+
+This driver supercedes the NCT6775F and NCT6776F support in the W83627EHF
+driver.
+
+Kernel driver NCT6775
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Nuvoton NCT6775F/W83667HG-I
+    Prefix: 'nct6775'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Available from Nuvoton upon request
+  * Nuvoton NCT6776F
+    Prefix: 'nct6776'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Available from Nuvoton upon request
+  * Nuvoton NCT6779D
+    Prefix: 'nct6779'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Available from Nuvoton upon request
+
+Authors:
+        Guenter Roeck <linux@roeck-us.net>
+
+Description
+-----------
+
+This driver implements support for the Nuvoton NCT6775F, NCT6776F, and NCT=
6779D
+super I/O chips. We will refer to them collectively as Nuvoton chips.
+
+The chips implement up to 8 temperature sensors depending on the chip type=
 and
+configuration. Temperatures used to control fan speed are reported separat=
ely.
+There are 4 to 5 fan rotation speed sensors, 8 to 15 analog voltage sensor=
s,
+one VID, alarms with beep warnings (control unimplemented), and some autom=
atic
+fan regulation strategies (plus manual fan control mode).
+
+The temperature sensor sources on all chips are configurable. temp4 and hi=
gher
+attributes are only reported if its temperature source differs from the
+temperature sources of the already reported temperature sensors.
+The configured source for each of the temperature sensors is provided
+in tempX_label.
+
+Temperatures are measured in degrees Celsius and measurement resolution is
+either 1 degC or 0.5 degC, depending on the temperature source and
+configuration. An alarm is triggered when the temperature gets higher than
+the high limit; it stays on until the temperature falls below the hysteres=
is
+value. Alarms are only supported for temp1, temp2, and temp3.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64 =
or
+128) to give the readings more range or accuracy. The driver sets the most
+suitable fan divisor itself. Some fans might not be present because they
+share pins with other functions.
+
+Voltage sensors (also known as IN sensors) report their values in millivol=
ts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit.
+
+The driver supports automatic fan control mode known as Thermal Cruise.
+In this mode, the chip attempts to keep the measured temperature in a
+predefined temperature range. If the temperature goes out of range, fan
+is driven slower/faster to reach the predefined range again.
+
+The mode works for fan1-fan5.
+
+sysfs attributes
+----------------
+
+name - this is a standard hwmon device entry, it contains the name of
+       the device (see the prefix in the list of supported devices at
+       the top of this file)
+
+pwm[1-5] - this file stores PWM duty cycle or DC value (fan speed) in rang=
e:
+	   0 (stop) to 255 (full)
+
+pwm[1-5]_enable - this file controls mode of fan/temperature control:
+	* 0 Fan control disabled (fans set to maximum speed)
+	* 1 Manual mode, write to pwm file any value 0-255 (full speed)
+	* 2 "Thermal Cruise" mode
+	* 3 "Fan Speed Cruise" mode
+	* 4 "Smart Fan III" mode (NCT6775F only)
+	* 5 "Smart Fan IV" mode
+
+pwm[1-5]_mode - controls if output is PWM or DC level
+        * 0 DC output (0 - 12v)
+        * 1 PWM output
+
+Common fan control attributes
+-----------------------------
+
+pwm[1-5]_temp_sel	Temperature source. Value is temperature sensor index.
+			For example, select '1' for temp1_input.
+pwm[1-5]_weight_temp_sel
+			Secondary temperature source. Value is temperature
+			sensor index. For example, select '1' for temp1_input.
+pwm[1-5]_weight_enable	Set to 1 to enable secondary temperature control.
+
+If secondary temperature functionality is enabled, it is controlled with t=
he
+following attributes.
+
+pwm[1-5]_weight_duty_step
+			Duty step size.
+pwm[1-5]_weight_temp_step
+			Temperature step size. With each step over
+			temp_step_base, the value of weight_duty_step is added
+			to the current pwm value.
+pwm[1-5]_weight_temp_step_base
+			Temperature at which secondary temperature control kicks
+			in.
+pwm[1-5]_weight_temp_step_tol
+			Temperature step tolerance or hysteresis. This is a
+			relative value.
+
+
+Thermal Cruise mode (2)
+-----------------------
+
+If the temperature is in the range defined by:
+
+pwm[1-5]_target		Target temperature, unit millidegree Celsius
+			(range 0 - 127000)
+pwm[1-5]_auto_temp1_hyst
+			Hysteresis, unit millidegree Celsius
+			Hysteresis value is relative to pwm[1-5]_auto_temp1.
+
+there are no changes to fan speed. Once the temperature leaves the interva=
l,
+fan speed increases (temp is higher) or decreases if lower than desired,
+using the following steps and times.
+
+pwm[1-5]_start_output	fan pwm start value (range 1 - 255), to start fan
+			when the temperature is above defined range.
+pwm[1-5]_stop_output	lowest fan pwm (range 1 - 255) if temperature is below
+			the defined range.
+pwm[1-5]_stop_output_enable
+			Set to 1 to enable pwm[1-5]_stop_output. If disabled
+			(set to 0), the fan will stop if the temperature is
+			below the defined range.
+pwm[1-5]_step_up_time	milliseconds [ms] before fan speed is increased
+pwm[1-5]_step_down_time	milliseconds [ms] before fan speed is decreased
+pwm[1-5]_stop_time	how many milliseconds [ms] must elapse to switch
+			corresponding fan off (when the temperature was below
+			defined range).
+
+Speed Cruise mode (3)
+---------------------
+
+This modes tries to keep the fan speed constant.
+Untested; use at your own risk.
+
+Smart Fan IV mode (5)
+---------------------
+
+The fan is regulated to maintain a target temperature. There are five data
+points. Subsequent data points should be set to higher temperatures and hi=
gher
+pwm values to achieve higher fan speeds with increasing temperature. The l=
ast
+data point reflects critical temperature mode, in which the fans should ru=
n at
+full speed.
+
+pwm[1-5]_auto_point[1-5]_pwm
+			pwm value to be set if temperature reaches matching
+			temperature range.
+pwm[1-5]_auto_point[1-5]_temp
+			Temperature at which the matching pwm is enabled.
+pwm[1-5]_step_up_time	milliseconds [ms] before fan speed is increased
+pwm[1-5]_step_down_time	milliseconds [ms] before fan speed is decreased
+pwm[1-5]_step_enable	Set to 1 to enable fine grain speed control.
+			If disabled, pwm values will increase or decrease to
+			the values configured in the auto_point_pwm attributes.
+			If enabled, pwm values will be interpolated, resulting
+			in a more fine-grained fan control, resulting in a more
+			fine-grained fan control
+
+
+Usage Notes
+-----------
+
+On various ASUS boards with NCT6776F, it appears that CPUTIN is not really
+connected to anything and floats, or that it is connected to some non-stan=
dard
+temperature measurement device. As a result, the temperature reported on C=
PUTIN
+will not reflect a usable value. It often reports unreasonablyy high
+temperatures, and in some cases the reported temperature declines if the a=
ctual
+temperature increases (similar to the raw PECI temperature value - see PECI
+specification for details). CPUTIN should therefore be be ignored on ASUS
+boards. The CPU temperature on ASUS boards is reported from PECI 0.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b0a2e4c..131a7a1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -844,6 +844,19 @@ config SENSORS_MCP3021
 	  This driver can also be built as a module.  If so, the module
 	  will be called mcp3021.
=20
+config SENSORS_NCT6775
+	tristate "Nuvoton NCT6775F, NCT6776F, NCT6779D"
+	depends on !PPC && EXPERIMENTAL
+	select HWMON_VID
+	help
+	  If you say yes here you get support for the hardware monitoring
+	  functionality of the Nuvoton NCT6775F, NCT6776F, and NCT6779D
+	  Super-I/O chips. It replaces the w83627ehf driver for NCT6775F
+	  and NCT6776F.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called nct6775.
+
 config SENSORS_NTC_THERMISTOR
 	tristate "NTC thermistor support"
 	depends on EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 7aa9811..7856141 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_SENSORS_MAX6642)	+=3D max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+=3D max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
 obj-$(CONFIG_SENSORS_MCP3021)	+=3D mcp3021.o
+obj-$(CONFIG_SENSORS_NCT6775)	+=3D nct6775.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+=3D ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+=3D pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+=3D pc87427.o
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
new file mode 100644
index 0000000..a82f21d
--- /dev/null
+++ b/drivers/hwmon/nct6775.c
@@ -0,0 +1,3887 @@
+/*
+ * nct6775 - Driver for the hardware monitoring functionality of
+ *	       Nuvoton NCT677x Super-I/O chips
+ *
+ * Copyright (C) 2012  Guenter Roeck <linux@roeck-us.net>
+ *
+ * Derived from w83627ehf driver
+ * Copyright (C) 2005-2011  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2006  Yuan Mu (Winbond),
+ *		       Rudolf Marek <r.marek@assembler.cz>
+ *		       David Hubbard <david.c.hubbard@gmail.com>
+ *		       Daniel J Blueman <daniel.blueman@gmail.com>
+ * Copyright (C) 2010  Sheng-Yuan Huang (Nuvoton) (PS00)
+ *
+ * Shamelessly ripped from the w83627hf driver
+ * Copyright (C) 2003  Mark Studebaker
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * Supports the following chips:
+ *
+ * Chip        #vin    #fan    #pwm    #temp  chip IDs       man ID
+ * nct6775f     9      4       3       6+3    0xb470 0xc1    0x5ca3
+ * nct6776f     9      5       3       6+3    0xc330 0xc1    0x5ca3
+ * nct6779d    15      5       5       2+5    0xc560 0xc1    0x5ca3
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include "lm75.h"
+
+#define TESTING
+
+enum kinds { nct6775, nct6776, nct6779 };
+
+/* used to set data->name =3D nct6775_device_names[data->sio_kind] */
+static const char * const nct6775_device_names[] =3D {
+	"nct6775",
+	"nct6776",
+	"nct6779",
+};
+
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Override the detected device ID");
+
+static unsigned short fan_debounce;
+module_param(fan_debounce, ushort, 0);
+MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
+
+#define DRVNAME "nct6775"
+
+/*
+ * Super-I/O constants and functions
+ */
+
+#define NCT6775_LD_ACPI		0x0a
+#define NCT6775_LD_HWM		0x0b
+#define NCT6775_LD_VID		0x0d
+
+#define SIO_REG_LDSEL		0x07	/* Logical device select */
+#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
+#define SIO_REG_EN_VRM10	0x2C	/* GPIO3, GPIO4 selection */
+#define SIO_REG_ENABLE		0x30	/* Logical device enable */
+#define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
+#define SIO_REG_VID_CTRL	0xF0	/* VID control */
+#define SIO_REG_VID_DATA	0xF1	/* VID data */
+
+#define SIO_NCT6775_ID		0xb470
+#define SIO_NCT6776_ID		0xc330
+#define SIO_NCT6779_ID		0xc560
+#define SIO_ID_MASK		0xFFF0
+
+static inline void
+superio_outb(int ioreg, int reg, int val)
+{
+	outb(reg, ioreg);
+	outb(val, ioreg + 1);
+}
+
+static inline int
+superio_inb(int ioreg, int reg)
+{
+	outb(reg, ioreg);
+	return inb(ioreg + 1);
+}
+
+static inline void
+superio_select(int ioreg, int ld)
+{
+	outb(SIO_REG_LDSEL, ioreg);
+	outb(ld, ioreg + 1);
+}
+
+static inline int
+superio_enter(int ioreg)
+{
+	/*
+	 * Try to reserve <ioreg> and <ioreg + 1> for exclusive access.
+	 */
+	if (!request_muxed_region(ioreg, 2, DRVNAME))
+		return -EBUSY;
+
+	outb(0x87, ioreg);
+	outb(0x87, ioreg);
+
+	return 0;
+}
+
+static inline void
+superio_exit(int ioreg)
+{
+	outb(0xaa, ioreg);
+	outb(0x02, ioreg);
+	outb(0x02, ioreg + 1);
+	release_region(ioreg, 2);
+}
+
+/*
+ * ISA constants
+ */
+
+#define IOREGION_ALIGNMENT	(~7)
+#define IOREGION_OFFSET		5
+#define IOREGION_LENGTH		2
+#define ADDR_REG_OFFSET		0
+#define DATA_REG_OFFSET		1
+
+#define NCT6775_REG_BANK	0x4E
+#define NCT6775_REG_CONFIG	0x40
+
+/*
+ * Not currently used:
+ * REG_MAN_ID has the value 0x5ca3 for all supported chips.
+ * REG_CHIP_ID =3D 0x88/0xa1/0xc1 depending on chip model.
+ * REG_MAN_ID is at port 0x4f
+ * REG_CHIP_ID is at port 0x58
+ */
+
+#define NUM_TEMP	10	/* Max number of temp attribute sets w/ limits*/
+#define NUM_TEMP_FIXED	6	/* Max number of fixed temp attribute sets */
+
+#define NUM_REG_ALARM	4	/* Max number of alarm registers */
+
+/* Common and NCT6775 specific data */
+
+/* Voltage min/max registers for nr=3D7..14 are in bank 5 */
+
+static const u16 NCT6775_REG_IN_MAX[] =3D {
+	0x2b, 0x2d, 0x2f, 0x31, 0x33, 0x35, 0x37, 0x554, 0x556, 0x558, 0x55a,
+	0x55c, 0x55e, 0x560, 0x562 };
+static const u16 NCT6775_REG_IN_MIN[] =3D {
+	0x2c, 0x2e, 0x30, 0x32, 0x34, 0x36, 0x38, 0x555, 0x557, 0x559, 0x55b,
+	0x55d, 0x55f, 0x561, 0x563 };
+static const u16 NCT6775_REG_IN[] =3D {
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x550, 0x551, 0x552
+};
+
+#define NCT6775_REG_VBAT		0x5D
+#define NCT6775_REG_DIODE		0x5E
+
+#define NCT6775_REG_FANDIV1		0x506
+#define NCT6775_REG_FANDIV2		0x507
+
+#define NCT6775_REG_CR_FAN_DEBOUNCE	0xf0
+
+static const u16 NCT6775_REG_ALARM[NUM_REG_ALARM] =3D { 0x459, 0x45A, 0x45=
B };
+
+/* 0..15 voltages, 16..23 fans, 24..31 temperatures */
+
+static const s8 NCT6775_ALARM_BITS[] =3D {
+	0, 1, 2, 3, 8, 21, 20, 16,	/* in0.. in7 */
+	17, -1, -1, -1, -1, -1, -1,	/* in8..in14 */
+	-1,				/* unused */
+	6, 7, 11, 10, 23,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
+	12, -1 };			/* intrusion0, intrusion1 */
+
+#define FAN_ALARM_BASE		16
+#define TEMP_ALARM_BASE		24
+#define INTRUSION_ALARM_BASE	30
+
+static const u8 NCT6775_REG_CR_CASEOPEN_CLR[] =3D { 0xe6, 0xee };
+static const u8 NCT6775_CR_CASEOPEN_CLR_MASK[] =3D { 0x20, 0x01 };
+
+/* DC or PWM output fan configuration */
+static const u8 NCT6775_REG_PWM_MODE[] =3D { 0x04, 0x04, 0x12 };
+static const u8 NCT6775_PWM_MODE_MASK[] =3D { 0x01, 0x02, 0x01 };
+
+/* Advanced Fan control, some values are common for all fans */
+
+static const u16 NCT6775_REG_FAN_PULSES[] =3D { 0x641, 0x642, 0x643, 0x644=
, 0 };
+
+static const u16 NCT6775_REG_TARGET[] =3D { 0x101, 0x201, 0x301, 0x801, 0x=
901 };
+static const u16 NCT6775_REG_FAN_MODE[] =3D { 0x102, 0x202, 0x302, 0x802, =
0x902 };
+static const u16 NCT6775_REG_FAN_STEP_DOWN_TIME[] =3D {
+	0x103, 0x203, 0x303, 0x803, 0x903 };
+static const u16 NCT6775_REG_FAN_STEP_UP_TIME[] =3D {
+	0x104, 0x204, 0x304, 0x804, 0x904 };
+static const u16 NCT6775_REG_FAN_STOP_OUTPUT[] =3D {
+	0x105, 0x205, 0x305, 0x805, 0x905 };
+static const u16 NCT6775_REG_FAN_START_OUTPUT[]
+	=3D { 0x106, 0x206, 0x306, 0x806, 0x906 };
+static const u16 NCT6775_REG_FAN_STEP_ENABLE[] =3D {
+	0x120, 0x220, 0x320, 0x820, 0x920 };
+static const u16 NCT6775_REG_FAN_MAX_OUTPUT[] =3D { 0x10a, 0x20a, 0x30a };
+static const u16 NCT6775_REG_FAN_STEP_OUTPUT[] =3D { 0x10b, 0x20b, 0x30b };
+
+static const u16 NCT6775_REG_FAN_STOP_TIME[] =3D {
+	0x107, 0x207, 0x307, 0x807, 0x907 };
+static const u16 NCT6775_REG_PWM[] =3D { 0x109, 0x209, 0x309, 0x809, 0x909=
 };
+static const u16 NCT6775_REG_PWM_READ[] =3D { 0x01, 0x03, 0x11, 0x13, 0x15=
 };
+
+static const u16 NCT6775_REG_FAN[] =3D { 0x630, 0x632, 0x634, 0x636, 0x638=
 };
+static const u16 NCT6775_REG_FAN_MIN[] =3D { 0x3b, 0x3c, 0x3d };
+
+static const u16 NCT6775_REG_TEMP[] =3D {
+	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
+
+static const u16 NCT6775_REG_TEMP_CONFIG[] =3D {
+	0, 0x152, 0x252, 0x628, 0x629, 0x62A };
+static const u16 NCT6775_REG_TEMP_HYST[] =3D {
+	0x3a, 0x153, 0x253, 0x673, 0x678, 0x67D };
+static const u16 NCT6775_REG_TEMP_OVER[] =3D {
+	0x39, 0x155, 0x255, 0x672, 0x677, 0x67C };
+
+static const u16 NCT6775_REG_TEMP_SOURCE[] =3D {
+	0x621, 0x622, 0x623, 0x624, 0x625, 0x626 };
+
+static const u16 NCT6775_REG_TEMP_SEL[] =3D {
+	0x100, 0x200, 0x300, 0x800, 0x900 };
+
+static const u16 NCT6775_REG_WEIGHT_TEMP_SEL[] =3D {
+	0x139, 0x239, 0x339, 0x839, 0x939 };
+static const u16 NCT6775_REG_WEIGHT_TEMP_STEP[] =3D {
+	0x13a, 0x23a, 0x33a, 0x83a, 0x93a };
+static const u16 NCT6775_REG_WEIGHT_TEMP_STEP_TOL[] =3D {
+	0x13b, 0x23b, 0x33b, 0x83b, 0x93b };
+static const u16 NCT6775_REG_WEIGHT_DUTY_STEP[] =3D {
+	0x13c, 0x23c, 0x33c, 0x83c, 0x93c };
+static const u16 NCT6775_REG_WEIGHT_TEMP_BASE[] =3D {
+	0x13d, 0x23d, 0x33d, 0x83d, 0x93d };
+
+static const u16 NCT6775_REG_TEMP_OFFSET[] =3D { 0x454, 0x455, 0x456 };
+
+static const u16 NCT6775_REG_AUTO_TEMP[] =3D {
+	0x121, 0x221, 0x321, 0x821, 0x921 };
+static const u16 NCT6775_REG_AUTO_PWM[] =3D {
+	0x127, 0x227, 0x327, 0x827, 0x927 };
+
+#define NCT6775_AUTO_TEMP(data, nr, p)	((data)->REG_AUTO_TEMP[nr] + (p))
+#define NCT6775_AUTO_PWM(data, nr, p)	((data)->REG_AUTO_PWM[nr] + (p))
+
+static const u16 NCT6775_REG_CRITICAL_ENAB[] =3D { 0x134, 0x234, 0x334 };
+
+static const u16 NCT6775_REG_CRITICAL_TEMP[] =3D {
+	0x135, 0x235, 0x335, 0x835, 0x935 };
+static const u16 NCT6775_REG_CRITICAL_TEMP_TOLERANCE[] =3D {
+	0x138, 0x238, 0x338, 0x838, 0x938 };
+
+static const char *const nct6775_temp_label[] =3D {
+	"",
+	"SYSTIN",
+	"CPUTIN",
+	"AUXTIN",
+	"AMD SB-TSI",
+	"PECI Agent 0",
+	"PECI Agent 1",
+	"PECI Agent 2",
+	"PECI Agent 3",
+	"PECI Agent 4",
+	"PECI Agent 5",
+	"PECI Agent 6",
+	"PECI Agent 7",
+	"PCH_CHIP_CPU_MAX_TEMP",
+	"PCH_CHIP_TEMP",
+	"PCH_CPU_TEMP",
+	"PCH_MCH_TEMP",
+	"PCH_DIM0_TEMP",
+	"PCH_DIM1_TEMP",
+	"PCH_DIM2_TEMP",
+	"PCH_DIM3_TEMP"
+};
+
+static const u16 NCT6775_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6775_temp_label)=
 - 1]
+	=3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x661, 0x662, 0x664 };
+
+static const u16 NCT6775_REG_TEMP_CRIT[ARRAY_SIZE(nct6775_temp_label) - 1]
+	=3D { 0, 0, 0, 0, 0xa00, 0xa01, 0xa02, 0xa03, 0xa04, 0xa05, 0xa06,
+	    0xa07 };
+
+/* NCT6776 specific data */
+
+static const s8 NCT6776_ALARM_BITS[] =3D {
+	0, 1, 2, 3, 8, 21, 20, 16,	/* in0.. in7 */
+	17, -1, -1, -1, -1, -1, -1,	/* in8..in14 */
+	-1,				/* unused */
+	6, 7, 11, 10, 23,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
+	12, 9 };			/* intrusion0, intrusion1 */
+
+static const u8 NCT6776_REG_PWM_MODE[] =3D { 0x04, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] =3D { 0x01, 0, 0 };
+
+static const u16 NCT6776_REG_FAN_PULSES[] =3D { 0x644, 0x645, 0x646, 0, 0 =
};
+static const u16 NCT6776_REG_FAN_MIN[] =3D { 0x63a, 0x63c, 0x63e, 0x640, 0=
x642 };
+
+static const u16 NCT6776_REG_WEIGHT_DUTY_BASE[] =3D {
+	0x13e, 0x23e, 0x33e, 0x83e, 0x93e };
+
+static const u16 NCT6776_REG_TEMP_CONFIG[11] =3D {
+	0x18, 0x152, 0x252, 0x628, 0x629, 0x62A };
+
+static const char *const nct6776_temp_label[] =3D {
+	"",
+	"SYSTIN",
+	"CPUTIN",
+	"AUXTIN",
+	"SMBUSMASTER 0",
+	"SMBUSMASTER 1",
+	"SMBUSMASTER 2",
+	"SMBUSMASTER 3",
+	"SMBUSMASTER 4",
+	"SMBUSMASTER 5",
+	"SMBUSMASTER 6",
+	"SMBUSMASTER 7",
+	"PECI Agent 0",
+	"PECI Agent 1",
+	"PCH_CHIP_CPU_MAX_TEMP",
+	"PCH_CHIP_TEMP",
+	"PCH_CPU_TEMP",
+	"PCH_MCH_TEMP",
+	"PCH_DIM0_TEMP",
+	"PCH_DIM1_TEMP",
+	"PCH_DIM2_TEMP",
+	"PCH_DIM3_TEMP",
+	"BYTE_TEMP"
+};
+
+static const u16 NCT6776_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6776_temp_label)=
 - 1]
+	=3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x401, 0x402, 0x404 };
+
+static const u16 NCT6776_REG_TEMP_CRIT[ARRAY_SIZE(nct6776_temp_label) - 1]
+	=3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x709, 0x70a };
+
+/* NCT6779 specific data */
+
+static const u16 NCT6779_REG_IN[] =3D {
+	0x480, 0x481, 0x482, 0x483, 0x484, 0x485, 0x486, 0x487,
+	0x488, 0x489, 0x48a, 0x48b, 0x48c, 0x48d, 0x48e };
+
+static const u16 NCT6779_REG_ALARM[NUM_REG_ALARM] =3D {
+	0x459, 0x45A, 0x45B, 0x568 };
+
+static const s8 NCT6779_ALARM_BITS[] =3D {
+	0, 1, 2, 3, 8, 21, 20, 16,	/* in0.. in7 */
+	17, 24, 25, 26, 27, 28, 29,	/* in8..in14 */
+	-1,				/* unused */
+	6, 7, 11, 10, 23,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
+	12, 9 };			/* intrusion0, intrusion1 */
+
+static const u16 NCT6779_REG_FAN_PULSES[] =3D {
+	0x644, 0x645, 0x646, 0x647, 0x648 };
+
+static const u16 NCT6779_REG_FAN[] =3D { 0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8=
 };
+
+static const u16 NCT6779_REG_TOLERANCE_H[] =3D {
+	0x10c, 0x20c, 0x30c, 0x80c, 0x90c };
+
+static const u16 NCT6779_REG_CRITICAL_PWM_ENABLE[] =3D {
+	0x136, 0x236, 0x336, 0x836, 0x936 };
+static const u16 NCT6779_REG_CRITICAL_PWM[] =3D {
+	0x137, 0x237, 0x337, 0x837, 0x937 };
+
+static const u16 NCT6779_REG_TEMP[] =3D { 0x27, 0x150 };
+static const u16 NCT6779_REG_TEMP_HYST[] =3D { 0x3a, 0x153, 0, 0, 0, 0 };
+static const u16 NCT6779_REG_TEMP_OVER[] =3D { 0x39, 0x155, 0, 0, 0, 0 };
+static const u16 NCT6779_REG_TEMP_OFFSET[] =3D {
+	0x454, 0x455, 0x456, 0x44a, 0x44b, 0x44c };
+
+static const u16 NCT6779_REG_TEMP_CONFIG[11] =3D { 0x18, 0x152 };
+
+static const char *const nct6779_temp_label[] =3D {
+	"",
+	"SYSTIN",
+	"CPUTIN",
+	"AUXTIN0",
+	"AUXTIN1",
+	"AUXTIN2",
+	"AUXTIN3",
+	"",
+	"SMBUSMASTER 0",
+	"SMBUSMASTER 1",
+	"SMBUSMASTER 2",
+	"SMBUSMASTER 3",
+	"SMBUSMASTER 4",
+	"SMBUSMASTER 5",
+	"SMBUSMASTER 6",
+	"SMBUSMASTER 7",
+	"PECI Agent 0",
+	"PECI Agent 1",
+	"PCH_CHIP_CPU_MAX_TEMP",
+	"PCH_CHIP_TEMP",
+	"PCH_CPU_TEMP",
+	"PCH_MCH_TEMP",
+	"PCH_DIM0_TEMP",
+	"PCH_DIM1_TEMP",
+	"PCH_DIM2_TEMP",
+	"PCH_DIM3_TEMP",
+	"BYTE_TEMP"
+};
+
+static const u16 NCT6779_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6779_temp_label)=
 - 1]
+	=3D { 0x490, 0x491, 0x492, 0x493, 0x494, 0x495, 0, 0,
+	    0, 0, 0, 0, 0, 0, 0, 0,
+	    0, 0x400, 0x401, 0x402, 0x404, 0x405, 0x406, 0x407,
+	    0x408, 0 };
+
+static const u16 NCT6779_REG_TEMP_CRIT[ARRAY_SIZE(nct6779_temp_label) - 1]
+	=3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x709, 0x70a };
+
+static inline int reg_to_pwm_enable(int pwm, int mode)
+{
+	if (mode =3D 0 && pwm =3D 255)
+		return 0;	/* off	*/
+	return mode + 1;
+}
+
+static inline int pwm_enable_to_reg(int mode)
+{
+	if (mode =3D 0)
+		return 0;
+	return mode - 1;
+}
+
+/*
+ * Conversions
+ */
+
+/* 1 is DC mode, output in ms */
+static inline unsigned int step_time_from_reg(u8 reg, u8 mode)
+{
+	return mode ? 400 * reg : 100 * reg;
+}
+
+static inline u8 step_time_to_reg(unsigned int msec, u8 mode)
+{
+	return SENSORS_LIMIT((mode ? (msec + 200) / 400 :
+					(msec + 50) / 100), 1, 255);
+}
+
+static unsigned int fan_from_reg8(u16 reg, unsigned int divreg)
+{
+	if (reg =3D 0 || reg =3D 255)
+		return 0;
+	return 1350000U / (reg << divreg);
+}
+
+static unsigned int fan_from_reg13(u16 reg, unsigned int divreg)
+{
+	if ((reg & 0xff1f) =3D 0xff1f)
+		return 0;
+
+	reg =3D (reg & 0x1f) | ((reg & 0xff00) >> 3);
+
+	if (reg =3D 0)
+		return 0;
+
+	return 1350000U / reg;
+}
+
+static unsigned int fan_from_reg16(u16 reg, unsigned int divreg)
+{
+	if (reg =3D 0 || reg =3D 0xffff)
+		return 0;
+
+	/*
+	 * Even though the registers are 16 bit wide, the fan divisor
+	 * still applies.
+	 */
+	return 1350000U / (reg << divreg);
+}
+
+static inline unsigned int
+div_from_reg(u8 reg)
+{
+	return 1 << reg;
+}
+
+/*
+ * Some of the voltage inputs have internal scaling, the tables below
+ * contain 8 (the ADC LSB in mV) * scaling factor * 100
+ */
+static const u16 scale_in[15] =3D {
+	800, 800, 1600, 1600, 800, 800, 800, 1600, 1600, 800, 800, 800, 800,
+	800, 800
+};
+
+static inline long in_from_reg(u8 reg, u8 nr)
+{
+	return DIV_ROUND_CLOSEST(reg * scale_in[nr], 100);
+}
+
+static inline u8 in_to_reg(u32 val, u8 nr)
+{
+	return SENSORS_LIMIT(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0,
+			     255);
+}
+
+/*
+ * Data structures and manipulation thereof
+ */
+
+struct nct6775_data {
+	int addr;	/* IO base of hw monitor block */
+	enum kinds kind;
+	const char *name;
+
+	struct device *hwmon_dev;
+	struct mutex lock;
+
+	u16 reg_temp[4][NUM_TEMP]; /* 0=3Dtemp, 1=3Dtemp_over, 2=3Dtemp_hyst,
+				    * 3=3Dtemp_crit
+				    */
+	u8 temp_src[NUM_TEMP];
+	u16 reg_temp_config[NUM_TEMP];
+	const char * const *temp_label;
+	int temp_label_num;
+
+	u16 REG_CONFIG;
+	u16 REG_VBAT;
+	u16 REG_DIODE;
+
+	const s8 *ALARM_BITS;
+
+	const u16 *REG_VIN;
+	const u16 *REG_IN_MINMAX[2];
+
+	const u16 *REG_TARGET;
+	const u16 *REG_FAN;
+	const u16 *REG_FAN_MODE;
+	const u16 *REG_FAN_MIN;
+	const u16 *REG_FAN_TIME[3];
+
+	const u8 *REG_PWM_MODE;
+	const u8 *PWM_MODE_MASK;
+
+	const u16 *REG_PWM[7];	/* [0]=3Dpwm, [1]=3Dstart_output, [2]=3Dstop_outpu=
t,
+				 * [3]=3Dmax_output, [4]=3Dstep_output,
+				 * [5]=3Dweight_duty_step, [6]=3Dweight_duty_base
+				 */
+	const u16 *REG_PWM_READ;
+
+	const u16 *REG_AUTO_TEMP;
+	const u16 *REG_AUTO_PWM;
+
+	const u16 *REG_CRITICAL_TEMP;
+	const u16 *REG_CRITICAL_TEMP_TOLERANCE;
+
+	const u16 *REG_TEMP_SOURCE;	/* temp register sources */
+	const u16 *REG_TEMP_SEL[3];	/* pwm temp:
+					 * 0=BAse, 1=3Dweight, 2=3Dstep enable
+					 */
+
+	const u16 *REG_WEIGHT_TEMP[3];	/* 0=BAse, 1=3Dhyst, 2=3Dstep */
+
+	const u16 *REG_TEMP_OFFSET;
+
+	const u16 *REG_ALARM;
+
+	unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
+	unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divreg);
+
+	struct mutex update_lock;
+	char valid;		/* !=3D0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	/* Register values */
+	u8 bank;		/* current register bank */
+	u8 in_num;		/* number of in inputs we have */
+	u8 in[15][3];		/* [0]=3Din, [1]=3Din_max, [2]=3Din_min */
+	unsigned int rpm[5];
+	u16 fan_min[5];
+	u8 fan_div[5];
+	u8 has_pwm;
+	u8 has_fan;		/* some fan inputs can be disabled */
+	u8 has_fan_min;		/* some fans don't have min register */
+	bool has_fan_div;
+
+	u8 temp_fixed_num;	/* 3 or 6 */
+	u8 temp_type[NUM_TEMP_FIXED];
+	s8 temp_offset[NUM_TEMP_FIXED];
+	s16 temp[4][NUM_TEMP]; /* 0=3Dtemp, 1=3Dtemp_over, 2=3Dtemp_hyst,
+				* 3=3Dtemp_crit */
+	u64 alarms;
+
+	u8 pwm_num;	/* number of pwm */
+
+	u8 pwm_mode[5]; /* 1->DC variable voltage, 0->PWM variable duty cycle */
+	u8 pwm_enable[5]; /* 0->off
+			   * 1->manual
+			   * 2->thermal cruise mode (also called SmartFan I)
+			   * 3->fan speed cruise mode
+			   * 4->SmartFan III
+			   * 5->enhanced variable thermal cruise (SmartFan IV)
+			   */
+	u8 pwm[7][5];	/* [0]=3Dpwm, [1]=3Dstart_output, [2]=3Dstop_output,
+			 * [3]=3Dmax_output, [4]=3Dstep_output,
+			 * [5]=3Dweight_duty_step, [6]=3Dweight_duty_base
+			 */
+	u8 target_temp[5];
+	u8 tolerance[5][2];
+
+	u8 fan_time[3][5]; /* 0 =3D stop_time, 1 =3D step_up, 2 =3D step_down */
+
+	/* Automatic fan speed control registers */
+	int auto_pwm_num;
+	u8 auto_pwm[5][7];
+	u8 auto_temp[5][7];
+
+	u8 pwm_temp_sel[2][5];
+
+	bool pwm_sel_enable[3][5];/* 0->stop_val, 1->weight, 2->step;
+				   * false->off, true->on
+				   */
+	u8 weight_temp[3][5];	/* 0->temp_step, 1->temp_step_tol,
+				 * 2->temp_base
+				 */
+
+	u8 vid;
+	u8 vrm;
+
+	u16 have_temp;
+	u16 have_temp_fixed;
+	u16 have_in;
+};
+
+struct nct6775_sio_data {
+	int sioreg;
+	enum kinds kind;
+};
+
+static bool is_word_sized(struct nct6775_data *data, u16 reg)
+{
+	switch (data->kind) {
+	case nct6775:
+		return (((reg & 0xff00) =3D 0x100 ||
+		    (reg & 0xff00) =3D 0x200) &&
+		   ((reg & 0x00ff) =3D 0x50 ||
+		    (reg & 0x00ff) =3D 0x53 ||
+		    (reg & 0x00ff) =3D 0x55)) ||
+		  (reg & 0xfff0) =3D 0x630 ||
+		  reg =3D 0x640 || reg =3D 0x642 ||
+		  reg =3D 0x662 ||
+		  ((reg & 0xfff0) =3D 0x650 && (reg & 0x000f) >=3D 0x06) ||
+		  reg =3D 0x73 || reg =3D 0x75 || reg =3D 0x77;
+	case nct6776:
+		return (((reg & 0xff00) =3D 0x100 ||
+		    (reg & 0xff00) =3D 0x200) &&
+		   ((reg & 0x00ff) =3D 0x50 ||
+		    (reg & 0x00ff) =3D 0x53 ||
+		    (reg & 0x00ff) =3D 0x55)) ||
+		  (reg & 0xfff0) =3D 0x630 ||
+		  reg =3D 0x402 ||
+		  reg =3D 0x640 || reg =3D 0x642 ||
+		  ((reg & 0xfff0) =3D 0x650 && (reg & 0x000f) >=3D 0x06) ||
+		  reg =3D 0x73 || reg =3D 0x75 || reg =3D 0x77;
+	case nct6779:
+		return reg =3D 0x150 || reg =3D 0x153 || reg =3D 0x155 ||
+		  ((reg & 0xfff0) =3D 0x4b0 && (reg & 0x000f) < 0x09) ||
+		  reg =3D 0x402 ||
+		  reg =3D 0x63a || reg =3D 0x63c || reg =3D 0x63e ||
+		  reg =3D 0x640 || reg =3D 0x642 ||
+		  reg =3D 0x73 || reg =3D 0x75 || reg =3D 0x77 || reg =3D 0x79 ||
+		  reg =3D 0x7b;
+	}
+	return false;
+}
+
+/*
+ * On older chips, only registers 0x50-0x5f are banked.
+ * On more recent chips, all registers are banked.
+ * Assume that is the case and set the bank number for each access.
+ * Cache the bank number so it only needs to be set if it changes.
+ */
+static inline void nct6775_set_bank(struct nct6775_data *data, u16 reg)
+{
+	u8 bank =3D reg >> 8;
+	if (data->bank !=3D bank) {
+		outb_p(NCT6775_REG_BANK, data->addr + ADDR_REG_OFFSET);
+		outb_p(bank, data->addr + DATA_REG_OFFSET);
+		data->bank =3D bank;
+	}
+}
+
+static u16 nct6775_read_value(struct nct6775_data *data, u16 reg)
+{
+	int res, word_sized =3D is_word_sized(data, reg);
+
+	mutex_lock(&data->lock);
+
+	nct6775_set_bank(data, reg);
+	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
+	res =3D inb_p(data->addr + DATA_REG_OFFSET);
+	if (word_sized) {
+		outb_p((reg & 0xff) + 1,
+		       data->addr + ADDR_REG_OFFSET);
+		res =3D (res << 8) + inb_p(data->addr + DATA_REG_OFFSET);
+	}
+
+	mutex_unlock(&data->lock);
+	return res;
+}
+
+static int nct6775_write_value(struct nct6775_data *data, u16 reg, u16 val=
ue)
+{
+	int word_sized =3D is_word_sized(data, reg);
+
+	mutex_lock(&data->lock);
+
+	nct6775_set_bank(data, reg);
+	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
+	if (word_sized) {
+		outb_p(value >> 8, data->addr + DATA_REG_OFFSET);
+		outb_p((reg & 0xff) + 1,
+		       data->addr + ADDR_REG_OFFSET);
+	}
+	outb_p(value & 0xff, data->addr + DATA_REG_OFFSET);
+
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+/* We left-align 8-bit temperature values to make the code simpler */
+static u16 nct6775_read_temp(struct nct6775_data *data, u16 reg)
+{
+	u16 res;
+
+	res =3D nct6775_read_value(data, reg);
+	if (!is_word_sized(data, reg))
+		res <<=3D 8;
+
+	return res;
+}
+
+static int nct6775_write_temp(struct nct6775_data *data, u16 reg, u16 valu=
e)
+{
+	if (!is_word_sized(data, reg))
+		value >>=3D 8;
+	return nct6775_write_value(data, reg, value);
+}
+
+/* This function assumes that the caller holds data->update_lock */
+static void nct6775_write_fan_div(struct nct6775_data *data, int nr)
+{
+	u8 reg;
+
+	switch (nr) {
+	case 0:
+		reg =3D (nct6775_read_value(data, NCT6775_REG_FANDIV1) & 0x70)
+		    | (data->fan_div[0] & 0x7);
+		nct6775_write_value(data, NCT6775_REG_FANDIV1, reg);
+		break;
+	case 1:
+		reg =3D (nct6775_read_value(data, NCT6775_REG_FANDIV1) & 0x7)
+		    | ((data->fan_div[1] << 4) & 0x70);
+		nct6775_write_value(data, NCT6775_REG_FANDIV1, reg);
+		break;
+	case 2:
+		reg =3D (nct6775_read_value(data, NCT6775_REG_FANDIV2) & 0x70)
+		    | (data->fan_div[2] & 0x7);
+		nct6775_write_value(data, NCT6775_REG_FANDIV2, reg);
+		break;
+	case 3:
+		reg =3D (nct6775_read_value(data, NCT6775_REG_FANDIV2) & 0x7)
+		    | ((data->fan_div[3] << 4) & 0x70);
+		nct6775_write_value(data, NCT6775_REG_FANDIV2, reg);
+		break;
+	}
+}
+
+static void nct6775_write_fan_div_common(struct device *dev,
+					 struct nct6775_data *data, int nr)
+{
+	if (data->kind =3D nct6775)
+		nct6775_write_fan_div(data, nr);
+}
+
+static void nct6775_update_fan_div(struct nct6775_data *data)
+{
+	u8 i;
+
+	i =3D nct6775_read_value(data, NCT6775_REG_FANDIV1);
+	data->fan_div[0] =3D i & 0x7;
+	data->fan_div[1] =3D (i & 0x70) >> 4;
+	i =3D nct6775_read_value(data, NCT6775_REG_FANDIV2);
+	data->fan_div[2] =3D i & 0x7;
+	if (data->has_fan & (1<<3))
+		data->fan_div[3] =3D (i & 0x70) >> 4;
+}
+
+static void nct6775_update_fan_div_common(struct device *dev,
+					  struct nct6775_data *data)
+{
+	if (data->kind =3D nct6775)
+		nct6775_update_fan_div(data);
+}
+
+static void nct6775_update_pwm(struct device *dev)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	int i, j;
+	int fanmodecfg, reg;
+	bool duty_is_dc;
+
+	for (i =3D 0; i < data->pwm_num; i++) {
+		if (!(data->has_pwm & (1 << i)))
+			continue;
+
+		duty_is_dc =3D data->REG_PWM_MODE[i] &&
+		  (nct6775_read_value(data, data->REG_PWM_MODE[i])
+		   & data->PWM_MODE_MASK[i]);
+		data->pwm_mode[i] =3D duty_is_dc;
+
+		fanmodecfg =3D nct6775_read_value(data, data->REG_FAN_MODE[i]);
+		for (j =3D 0; j < ARRAY_SIZE(data->REG_PWM); j++) {
+			if (data->REG_PWM[j] && data->REG_PWM[j][i]) {
+				data->pwm[j][i]
+				  =3D nct6775_read_value(data,
+						       data->REG_PWM[j][i]);
+			}
+		}
+
+		data->pwm_enable[i] =3D reg_to_pwm_enable(data->pwm[0][i],
+							(fanmodecfg >> 4) & 7);
+
+		data->tolerance[i][0] =3D fanmodecfg & 0x0f;
+		if (data->kind =3D nct6779) {
+			reg =3D nct6775_read_value(data,
+						 NCT6779_REG_TOLERANCE_H[i]);
+			data->tolerance[i][0] |=3D (reg & 0x70) >> 1;
+		}
+		data->tolerance[i][1] +			nct6775_read_value(data,
+					data->REG_CRITICAL_TEMP_TOLERANCE[i]);
+
+		data->pwm_sel_enable[0][i] +			nct6775_read_value(data, data->REG_TEMP_S=
EL[0][i])
+				& 0x80;
+		data->pwm_sel_enable[1][i] +			nct6775_read_value(data, data->REG_TEMP_S=
EL[1][i])
+				& 0x80;
+		data->pwm_sel_enable[2][i] +			nct6775_read_value(data, data->REG_TEMP_S=
EL[2][i])
+				& 0x01;
+
+		/* Weight data */
+		for (j =3D 0; j < 2; j++) {
+			reg =3D nct6775_read_value(data,
+						 data->REG_TEMP_SEL[j][i]);
+			data->pwm_temp_sel[j][i] =3D reg & 0x1f;
+		}
+		/* Weight temp data */
+		for (j =3D 0; j < 3; j++) {
+			data->weight_temp[j][i]
+			  =3D nct6775_read_value(data,
+					       data->REG_WEIGHT_TEMP[j][i]);
+		}
+	}
+}
+
+static void nct6775_update_pwm_limits(struct device *dev)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	int i, j;
+	u8 reg;
+
+	for (i =3D 0; i < data->pwm_num; i++) {
+		if (!(data->has_pwm & (1 << i)))
+			continue;
+
+		for (j =3D 0; j < 3; j++) {
+			data->fan_time[j][i] +			  nct6775_read_value(data, data->REG_FAN_TIME[=
j][i]);
+		}
+
+		data->target_temp[i] +			nct6775_read_value(data, data->REG_TARGET[i]) &
+					(data->pwm_mode[i] ? 0xff : 0x7f);
+
+		for (j =3D 0; j < data->auto_pwm_num; j++) {
+			data->auto_pwm[i][j] +			  nct6775_read_value(data,
+					     NCT6775_AUTO_PWM(data, i, j));
+			data->auto_temp[i][j] +			  nct6775_read_value(data,
+					     NCT6775_AUTO_TEMP(data, i, j));
+		}
+
+		/* critical auto_pwm temperature data */
+		data->auto_temp[i][data->auto_pwm_num] +			nct6775_read_value(data, data=
->REG_CRITICAL_TEMP[i]);
+
+		switch (data->kind) {
+		case nct6775:
+			reg =3D nct6775_read_value(data,
+						 NCT6775_REG_CRITICAL_ENAB[i]);
+			data->auto_pwm[i][data->auto_pwm_num] +						(reg & 0x02) ? 0xff : 0x00;
+			break;
+		case nct6776:
+			data->auto_pwm[i][data->auto_pwm_num] =3D 0xff;
+			break;
+		case nct6779:
+			reg =3D nct6775_read_value(data,
+					NCT6779_REG_CRITICAL_PWM_ENABLE[i]);
+			if (reg & 1)
+				data->auto_pwm[i][data->auto_pwm_num] +				  nct6775_read_value(data,
+					NCT6779_REG_CRITICAL_PWM[i]);
+			else
+				data->auto_pwm[i][data->auto_pwm_num] =3D 0xff;
+			break;
+		}
+	}
+}
+
+static struct nct6775_data *nct6775_update_device(struct device *dev)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	int i, j;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ/2)
+	    || !data->valid) {
+		/* Fan clock dividers */
+		nct6775_update_fan_div_common(dev, data);
+
+		/* Measured voltages and limits */
+		for (i =3D 0; i < data->in_num; i++) {
+			if (!(data->have_in & (1 << i)))
+				continue;
+
+			data->in[i][0] =3D nct6775_read_value(data,
+							    data->REG_VIN[i]);
+			data->in[i][1] =3D nct6775_read_value(data,
+					  data->REG_IN_MINMAX[0][i]);
+			data->in[i][2] =3D nct6775_read_value(data,
+					  data->REG_IN_MINMAX[1][i]);
+		}
+
+		/* Measured fan speeds and limits */
+		for (i =3D 0; i < 5; i++) {
+			u16 reg;
+
+			if (!(data->has_fan & (1 << i)))
+				continue;
+
+			reg =3D nct6775_read_value(data, data->REG_FAN[i]);
+			data->rpm[i] =3D data->fan_from_reg(reg,
+							  data->fan_div[i]);
+
+			if (data->has_fan_min & (1 << i))
+				data->fan_min[i] =3D nct6775_read_value(data,
+					   data->REG_FAN_MIN[i]);
+
+			/*
+			 * If we failed to measure the fan speed and clock
+			 * divider can be increased, let's try that for next
+			 * time
+			 */
+			if (data->has_fan_div && (reg >=3D 0xff || reg =3D 0x00)
+			    && data->fan_div[i] < 0x07) {
+				dev_dbg(dev,
+					"Increasing fan%d clock divider from %u to %u\n",
+					i + 1, div_from_reg(data->fan_div[i]),
+					div_from_reg(data->fan_div[i] + 1));
+				data->fan_div[i]++;
+				nct6775_write_fan_div_common(dev, data, i);
+				/* Preserve min limit if possible */
+				if ((data->has_fan_min & (1 << i))
+				    && data->fan_min[i] >=3D 2
+				    && data->fan_min[i] !=3D 255)
+					nct6775_write_value(data,
+						data->REG_FAN_MIN[i],
+						(data->fan_min[i] /=3D 2));
+			}
+		}
+
+		nct6775_update_pwm(dev);
+		nct6775_update_pwm_limits(dev);
+
+		/* Measured temperatures and limits */
+		for (i =3D 0; i < NUM_TEMP; i++) {
+			if (!(data->have_temp & (1 << i)))
+				continue;
+			for (j =3D 0; j < 4; j++) {
+				if (data->reg_temp[j][i])
+					data->temp[j][i]
+					  =3D nct6775_read_temp(data,
+						data->reg_temp[j][i]);
+			}
+			if (!(data->have_temp_fixed & (1 << i)))
+				continue;
+			data->temp_offset[i]
+			  =3D nct6775_read_value(data, data->REG_TEMP_OFFSET[i]);
+		}
+
+		data->alarms =3D 0;
+		for (i =3D 0; i < NUM_REG_ALARM; i++) {
+			u8 alarm;
+			if (!data->REG_ALARM[i])
+				continue;
+			alarm =3D nct6775_read_value(data, data->REG_ALARM[i]);
+			data->alarms |=3D ((u64)alarm) << (i << 3);
+		}
+
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+/*
+ * Sysfs callback functions
+ */
+static ssize_t
+show_in_reg(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr][index], nr));
+}
+
+static ssize_t
+store_in_reg(struct device *dev, struct device_attribute *attr, const char=
 *buf,
+	     size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	mutex_lock(&data->update_lock);
+	data->in[nr][index] =3D in_to_reg(val, nr);
+	nct6775_write_value(data, data->REG_IN_MINMAX[index-1][nr],
+			    data->in[nr][index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D data->ALARM_BITS[sattr->index];
+	return sprintf(buf, "%u\n",
+		       (unsigned int)((data->alarms >> nr) & 0x01));
+}
+
+static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in_reg, NULL, 0, 0);
+static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in_reg, NULL, 1, 0);
+static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in_reg, NULL, 2, 0);
+static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in_reg, NULL, 3, 0);
+static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in_reg, NULL, 4, 0);
+static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in_reg, NULL, 5, 0);
+static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in_reg, NULL, 6, 0);
+static SENSOR_DEVICE_ATTR_2(in7_input, S_IRUGO, show_in_reg, NULL, 7, 0);
+static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in_reg, NULL, 8, 0);
+static SENSOR_DEVICE_ATTR_2(in9_input, S_IRUGO, show_in_reg, NULL, 9, 0);
+static SENSOR_DEVICE_ATTR_2(in10_input, S_IRUGO, show_in_reg, NULL, 10, 0);
+static SENSOR_DEVICE_ATTR_2(in11_input, S_IRUGO, show_in_reg, NULL, 11, 0);
+static SENSOR_DEVICE_ATTR_2(in12_input, S_IRUGO, show_in_reg, NULL, 12, 0);
+static SENSOR_DEVICE_ATTR_2(in13_input, S_IRUGO, show_in_reg, NULL, 13, 0);
+static SENSOR_DEVICE_ATTR_2(in14_input, S_IRUGO, show_in_reg, NULL, 14, 0);
+
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(in11_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(in12_alarm, S_IRUGO, show_alarm, NULL, 12);
+static SENSOR_DEVICE_ATTR(in13_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR(in14_alarm, S_IRUGO, show_alarm, NULL, 14);
+
+static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 0, 1);
+static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 1, 1);
+static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 2, 1);
+static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 3, 1);
+static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 4, 1);
+static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 5, 1);
+static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 6, 1);
+static SENSOR_DEVICE_ATTR_2(in7_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 7, 1);
+static SENSOR_DEVICE_ATTR_2(in8_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 8, 1);
+static SENSOR_DEVICE_ATTR_2(in9_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 9, 1);
+static SENSOR_DEVICE_ATTR_2(in10_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 10, 1);
+static SENSOR_DEVICE_ATTR_2(in11_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 11, 1);
+static SENSOR_DEVICE_ATTR_2(in12_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 12, 1);
+static SENSOR_DEVICE_ATTR_2(in13_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 13, 1);
+static SENSOR_DEVICE_ATTR_2(in14_min, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 14, 1);
+
+static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 0, 2);
+static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 1, 2);
+static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 2, 2);
+static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 3, 2);
+static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 4, 2);
+static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 5, 2);
+static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 6, 2);
+static SENSOR_DEVICE_ATTR_2(in7_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 7, 2);
+static SENSOR_DEVICE_ATTR_2(in8_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 8, 2);
+static SENSOR_DEVICE_ATTR_2(in9_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 9, 2);
+static SENSOR_DEVICE_ATTR_2(in10_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 10, 2);
+static SENSOR_DEVICE_ATTR_2(in11_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 11, 2);
+static SENSOR_DEVICE_ATTR_2(in12_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 12, 2);
+static SENSOR_DEVICE_ATTR_2(in13_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 13, 2);
+static SENSOR_DEVICE_ATTR_2(in14_max, S_IWUSR | S_IRUGO, show_in_reg,
+			    store_in_reg, 14, 2);
+
+static struct attribute *nct6775_attributes_in[15][5] =3D {
+	{
+		&sensor_dev_attr_in0_input.dev_attr.attr,
+		&sensor_dev_attr_in0_min.dev_attr.attr,
+		&sensor_dev_attr_in0_max.dev_attr.attr,
+		&sensor_dev_attr_in0_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in1_input.dev_attr.attr,
+		&sensor_dev_attr_in1_min.dev_attr.attr,
+		&sensor_dev_attr_in1_max.dev_attr.attr,
+		&sensor_dev_attr_in1_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in2_input.dev_attr.attr,
+		&sensor_dev_attr_in2_min.dev_attr.attr,
+		&sensor_dev_attr_in2_max.dev_attr.attr,
+		&sensor_dev_attr_in2_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in3_input.dev_attr.attr,
+		&sensor_dev_attr_in3_min.dev_attr.attr,
+		&sensor_dev_attr_in3_max.dev_attr.attr,
+		&sensor_dev_attr_in3_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in4_input.dev_attr.attr,
+		&sensor_dev_attr_in4_min.dev_attr.attr,
+		&sensor_dev_attr_in4_max.dev_attr.attr,
+		&sensor_dev_attr_in4_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in5_input.dev_attr.attr,
+		&sensor_dev_attr_in5_min.dev_attr.attr,
+		&sensor_dev_attr_in5_max.dev_attr.attr,
+		&sensor_dev_attr_in5_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in6_input.dev_attr.attr,
+		&sensor_dev_attr_in6_min.dev_attr.attr,
+		&sensor_dev_attr_in6_max.dev_attr.attr,
+		&sensor_dev_attr_in6_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in7_input.dev_attr.attr,
+		&sensor_dev_attr_in7_min.dev_attr.attr,
+		&sensor_dev_attr_in7_max.dev_attr.attr,
+		&sensor_dev_attr_in7_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in8_input.dev_attr.attr,
+		&sensor_dev_attr_in8_min.dev_attr.attr,
+		&sensor_dev_attr_in8_max.dev_attr.attr,
+		&sensor_dev_attr_in8_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in9_input.dev_attr.attr,
+		&sensor_dev_attr_in9_min.dev_attr.attr,
+		&sensor_dev_attr_in9_max.dev_attr.attr,
+		&sensor_dev_attr_in9_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in10_input.dev_attr.attr,
+		&sensor_dev_attr_in10_min.dev_attr.attr,
+		&sensor_dev_attr_in10_max.dev_attr.attr,
+		&sensor_dev_attr_in10_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in11_input.dev_attr.attr,
+		&sensor_dev_attr_in11_min.dev_attr.attr,
+		&sensor_dev_attr_in11_max.dev_attr.attr,
+		&sensor_dev_attr_in11_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in12_input.dev_attr.attr,
+		&sensor_dev_attr_in12_min.dev_attr.attr,
+		&sensor_dev_attr_in12_max.dev_attr.attr,
+		&sensor_dev_attr_in12_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in13_input.dev_attr.attr,
+		&sensor_dev_attr_in13_min.dev_attr.attr,
+		&sensor_dev_attr_in13_max.dev_attr.attr,
+		&sensor_dev_attr_in13_alarm.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_in14_input.dev_attr.attr,
+		&sensor_dev_attr_in14_min.dev_attr.attr,
+		&sensor_dev_attr_in14_max.dev_attr.attr,
+		&sensor_dev_attr_in14_alarm.dev_attr.attr,
+		NULL
+	},
+};
+
+static const struct attribute_group nct6775_group_in[15] =3D {
+	{ .attrs =3D nct6775_attributes_in[0] },
+	{ .attrs =3D nct6775_attributes_in[1] },
+	{ .attrs =3D nct6775_attributes_in[2] },
+	{ .attrs =3D nct6775_attributes_in[3] },
+	{ .attrs =3D nct6775_attributes_in[4] },
+	{ .attrs =3D nct6775_attributes_in[5] },
+	{ .attrs =3D nct6775_attributes_in[6] },
+	{ .attrs =3D nct6775_attributes_in[7] },
+	{ .attrs =3D nct6775_attributes_in[8] },
+	{ .attrs =3D nct6775_attributes_in[9] },
+	{ .attrs =3D nct6775_attributes_in[10] },
+	{ .attrs =3D nct6775_attributes_in[11] },
+	{ .attrs =3D nct6775_attributes_in[12] },
+	{ .attrs =3D nct6775_attributes_in[13] },
+	{ .attrs =3D nct6775_attributes_in[14] },
+};
+
+static ssize_t
+show_fan(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	return sprintf(buf, "%d\n", data->rpm[nr]);
+}
+
+static ssize_t
+show_fan_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	return sprintf(buf, "%d\n",
+		       data->fan_from_reg_min(data->fan_min[nr],
+					      data->fan_div[nr]));
+}
+
+static ssize_t
+show_fan_div(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	return sprintf(buf, "%u\n", div_from_reg(data->fan_div[nr]));
+}
+
+static ssize_t
+store_fan_min(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	unsigned long val;
+	int err;
+	unsigned int reg;
+	u8 new_div;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&data->update_lock);
+	if (!data->has_fan_div) {
+		/* NCT6776F or NCT6779D; we know this is a 13 bit register */
+		if (!val) {
+			val =3D 0xff1f;
+		} else {
+			if (val > 1350000U)
+				val =3D 135000U;
+			val =3D 1350000U / val;
+			val =3D (val & 0x1f) | ((val << 3) & 0xff00);
+		}
+		data->fan_min[nr] =3D val;
+		goto write_min;	/* Leave fan divider alone */
+	}
+	if (!val) {
+		/* No min limit, alarm disabled */
+		data->fan_min[nr] =3D 255;
+		new_div =3D data->fan_div[nr]; /* No change */
+		dev_info(dev, "fan%u low limit and alarm disabled\n", nr + 1);
+		goto write_div;
+	}
+	reg =3D 1350000U / val;
+	if (reg >=3D 128 * 255) {
+		/*
+		 * Speed below this value cannot possibly be represented,
+		 * even with the highest divider (128)
+		 */
+		data->fan_min[nr] =3D 254;
+		new_div =3D 7; /* 128 =3D (1 << 7) */
+		dev_warn(dev,
+			 "fan%u low limit %lu below minimum %u, set to minimum\n",
+			 nr + 1, val, data->fan_from_reg_min(254, 7));
+	} else if (!reg) {
+		/*
+		 * Speed above this value cannot possibly be represented,
+		 * even with the lowest divider (1)
+		 */
+		data->fan_min[nr] =3D 1;
+		new_div =3D 0; /* 1 =3D (1 << 0) */
+		dev_warn(dev,
+			 "fan%u low limit %lu above maximum %u, set to maximum\n",
+			 nr + 1, val, data->fan_from_reg_min(1, 0));
+	} else {
+		/*
+		 * Automatically pick the best divider, i.e. the one such
+		 * that the min limit will correspond to a register value
+		 * in the 96..192 range
+		 */
+		new_div =3D 0;
+		while (reg > 192 && new_div < 7) {
+			reg >>=3D 1;
+			new_div++;
+		}
+		data->fan_min[nr] =3D reg;
+	}
+
+write_div:
+	/*
+	 * Write both the fan clock divider (if it changed) and the new
+	 * fan min (unconditionally)
+	 */
+	if (new_div !=3D data->fan_div[nr]) {
+		dev_dbg(dev, "fan%u clock divider changed from %u to %u\n",
+			nr + 1, div_from_reg(data->fan_div[nr]),
+			div_from_reg(new_div));
+		data->fan_div[nr] =3D new_div;
+		nct6775_write_fan_div_common(dev, data, nr);
+		/* Give the chip time to sample a new speed value */
+		data->last_updated =3D jiffies;
+	}
+
+write_min:
+	nct6775_write_value(data, data->REG_FAN_MIN[nr], data->fan_min[nr]);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static struct sensor_device_attribute sda_fan_input[] =3D {
+	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
+	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
+	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
+	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
+	SENSOR_ATTR(fan5_input, S_IRUGO, show_fan, NULL, 4),
+};
+
+static struct sensor_device_attribute sda_fan_alarm[] =3D {
+	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE),
+	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 1),
+	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 2),
+	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 3),
+	SENSOR_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 4),
+};
+
+static struct sensor_device_attribute sda_fan_min[] =3D {
+	SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    store_fan_min, 0),
+	SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    store_fan_min, 1),
+	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    store_fan_min, 2),
+	SENSOR_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    store_fan_min, 3),
+	SENSOR_ATTR(fan5_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    store_fan_min, 4),
+};
+
+static struct sensor_device_attribute sda_fan_div[] =3D {
+	SENSOR_ATTR(fan1_div, S_IRUGO, show_fan_div, NULL, 0),
+	SENSOR_ATTR(fan2_div, S_IRUGO, show_fan_div, NULL, 1),
+	SENSOR_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2),
+	SENSOR_ATTR(fan4_div, S_IRUGO, show_fan_div, NULL, 3),
+	SENSOR_ATTR(fan5_div, S_IRUGO, show_fan_div, NULL, 4),
+};
+
+static ssize_t
+show_temp_label(struct device *dev, struct device_attribute *attr, char *b=
uf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	return sprintf(buf, "%s\n", data->temp_label[data->temp_src[nr]]);
+}
+
+static ssize_t
+show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+
+	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->temp[index][nr]));
+}
+
+static ssize_t
+store_temp(struct device *dev, struct device_attribute *attr, const char *=
buf,
+	   size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	int err;
+	long val;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&data->update_lock);
+	data->temp[index][nr] =3D LM75_TEMP_TO_REG(val);
+	nct6775_write_temp(data, data->reg_temp[index][nr],
+			   data->temp[index][nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_temp_offset(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n", data->temp_offset[sattr->index] * 1000);
+}
+
+static ssize_t
+store_temp_offset(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val =3D SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+
+	mutex_lock(&data->update_lock);
+	data->temp_offset[nr] =3D val;
+	nct6775_write_value(data, data->REG_TEMP_OFFSET[nr], val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t
+show_temp_type(struct device *dev, struct device_attribute *attr, char *bu=
f)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	return sprintf(buf, "%d\n", (int)data->temp_type[nr]);
+}
+
+static ssize_t
+store_temp_type(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	unsigned long val;
+	int err;
+	u8 vbat, diode, bit;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	if (val !=3D 1 && val !=3D 3 && val !=3D 4)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	data->temp_type[nr] =3D val;
+	vbat =3D nct6775_read_value(data, data->REG_VBAT) & ~(0x02 << nr);
+	diode =3D nct6775_read_value(data, data->REG_DIODE) & ~(0x02 << nr);
+	bit =3D 0x02 << nr;
+	switch (val) {
+	case 1:	/* CPU diode (diode, current mode) */
+		vbat |=3D bit;
+		diode |=3D bit;
+		break;
+	case 3: /* diode, voltage mode */
+		vbat |=3D bit;
+		break;
+	case 4:	/* thermistor */
+		break;
+	};
+	nct6775_write_value(data, data->REG_VBAT, vbat);
+	nct6775_write_value(data, data->REG_DIODE, diode);
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static struct sensor_device_attribute_2 sda_temp_input[] =3D {
+	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0),
+	SENSOR_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 3, 0),
+	SENSOR_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 4, 0),
+	SENSOR_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 5, 0),
+	SENSOR_ATTR_2(temp7_input, S_IRUGO, show_temp, NULL, 6, 0),
+	SENSOR_ATTR_2(temp8_input, S_IRUGO, show_temp, NULL, 7, 0),
+	SENSOR_ATTR_2(temp9_input, S_IRUGO, show_temp, NULL, 8, 0),
+	SENSOR_ATTR_2(temp10_input, S_IRUGO, show_temp, NULL, 9, 0),
+};
+
+static struct sensor_device_attribute sda_temp_label[] =3D {
+	SENSOR_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL, 0),
+	SENSOR_ATTR(temp2_label, S_IRUGO, show_temp_label, NULL, 1),
+	SENSOR_ATTR(temp3_label, S_IRUGO, show_temp_label, NULL, 2),
+	SENSOR_ATTR(temp4_label, S_IRUGO, show_temp_label, NULL, 3),
+	SENSOR_ATTR(temp5_label, S_IRUGO, show_temp_label, NULL, 4),
+	SENSOR_ATTR(temp6_label, S_IRUGO, show_temp_label, NULL, 5),
+	SENSOR_ATTR(temp7_label, S_IRUGO, show_temp_label, NULL, 6),
+	SENSOR_ATTR(temp8_label, S_IRUGO, show_temp_label, NULL, 7),
+	SENSOR_ATTR(temp9_label, S_IRUGO, show_temp_label, NULL, 8),
+	SENSOR_ATTR(temp10_label, S_IRUGO, show_temp_label, NULL, 9),
+};
+
+static struct sensor_device_attribute_2 sda_temp_max[] =3D {
+	SENSOR_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      0, 1),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      1, 1),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      2, 1),
+	SENSOR_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      3, 1),
+	SENSOR_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      4, 1),
+	SENSOR_ATTR_2(temp6_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      5, 1),
+	SENSOR_ATTR_2(temp7_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      6, 1),
+	SENSOR_ATTR_2(temp8_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      7, 1),
+	SENSOR_ATTR_2(temp9_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      8, 1),
+	SENSOR_ATTR_2(temp10_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      9, 1),
+};
+
+static struct sensor_device_attribute_2 sda_temp_max_hyst[] =3D {
+	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      0, 2),
+	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      1, 2),
+	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      2, 2),
+	SENSOR_ATTR_2(temp4_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      3, 2),
+	SENSOR_ATTR_2(temp5_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      4, 2),
+	SENSOR_ATTR_2(temp6_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      5, 2),
+	SENSOR_ATTR_2(temp7_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      6, 2),
+	SENSOR_ATTR_2(temp8_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      7, 2),
+	SENSOR_ATTR_2(temp9_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      8, 2),
+	SENSOR_ATTR_2(temp10_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      9, 2),
+};
+
+static struct sensor_device_attribute_2 sda_temp_crit[] =3D {
+	SENSOR_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      0, 3),
+	SENSOR_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      1, 3),
+	SENSOR_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      2, 3),
+	SENSOR_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      3, 3),
+	SENSOR_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      4, 3),
+	SENSOR_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      5, 3),
+	SENSOR_ATTR_2(temp7_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      6, 3),
+	SENSOR_ATTR_2(temp8_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      7, 3),
+	SENSOR_ATTR_2(temp9_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      8, 3),
+	SENSOR_ATTR_2(temp10_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
+		      9, 3),
+};
+
+static struct sensor_device_attribute sda_temp_offset[] =3D {
+	SENSOR_ATTR(temp1_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 0),
+	SENSOR_ATTR(temp2_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 1),
+	SENSOR_ATTR(temp3_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 2),
+	SENSOR_ATTR(temp4_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 3),
+	SENSOR_ATTR(temp5_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 4),
+	SENSOR_ATTR(temp6_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 5),
+};
+
+static struct sensor_device_attribute sda_temp_type[] =3D {
+	SENSOR_ATTR(temp1_type, S_IRUGO | S_IWUSR, show_temp_type,
+		    store_temp_type, 0),
+	SENSOR_ATTR(temp2_type, S_IRUGO | S_IWUSR, show_temp_type,
+		    store_temp_type, 1),
+	SENSOR_ATTR(temp3_type, S_IRUGO | S_IWUSR, show_temp_type,
+		    store_temp_type, 2),
+	SENSOR_ATTR(temp4_type, S_IRUGO | S_IWUSR, show_temp_type,
+		    store_temp_type, 3),
+	SENSOR_ATTR(temp5_type, S_IRUGO | S_IWUSR, show_temp_type,
+		    store_temp_type, 4),
+	SENSOR_ATTR(temp6_type, S_IRUGO | S_IWUSR, show_temp_type,
+		    store_temp_type, 5),
+};
+
+static struct sensor_device_attribute sda_temp_alarm[] =3D {
+	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL,
+		    TEMP_ALARM_BASE),
+	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL,
+		    TEMP_ALARM_BASE + 1),
+	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL,
+		    TEMP_ALARM_BASE + 2),
+	SENSOR_ATTR(temp4_alarm, S_IRUGO, show_alarm, NULL,
+		    TEMP_ALARM_BASE + 3),
+	SENSOR_ATTR(temp5_alarm, S_IRUGO, show_alarm, NULL,
+		    TEMP_ALARM_BASE + 4),
+	SENSOR_ATTR(temp6_alarm, S_IRUGO, show_alarm, NULL,
+		    TEMP_ALARM_BASE + 5),
+};
+
+#define NUM_TEMP_ALARM	ARRAY_SIZE(sda_temp_alarm)
+
+static ssize_t
+show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n", !data->pwm_mode[sattr->index]);
+}
+
+static ssize_t
+store_pwm_mode(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	unsigned long val;
+	int err;
+	u8 reg;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	if (val > 1)
+		return -EINVAL;
+
+	/* Setting DC mode is not supported for all chips/channels */
+	if (data->REG_PWM_MODE[nr] =3D 0) {
+		if (val)
+			return -EINVAL;
+		return count;
+	}
+
+	mutex_lock(&data->update_lock);
+	data->pwm_mode[nr] =3D val;
+	reg =3D nct6775_read_value(data, data->REG_PWM_MODE[nr]);
+	reg &=3D ~data->PWM_MODE_MASK[nr];
+	if (val)
+		reg |=3D data->PWM_MODE_MASK[nr];
+	nct6775_write_value(data, data->REG_PWM_MODE[nr], reg);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_pwm_enable(struct device *dev, struct device_attribute *attr, char *b=
uf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n", data->pwm_enable[sattr->index]);
+}
+
+static ssize_t
+show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	int pwm;
+
+	/*
+	 * For automatic fan control modes, show current pwm readings.
+	 * Otherwise, show the configured value.
+	 */
+	if (index =3D 0 && data->pwm_enable[nr] > 1)
+		pwm =3D nct6775_read_value(data, data->REG_PWM_READ[nr]);
+	else
+		pwm =3D data->pwm[index][nr];
+
+	return sprintf(buf, "%d\n", pwm);
+}
+
+static ssize_t
+store_pwm(struct device *dev, struct device_attribute *attr, const char *b=
uf,
+	  size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int minval[7] =3D { 0, 1, 1, data->pwm[2][nr], 0, 0, 0 };
+	int maxval[7]
+	  =3D { 255, 255, data->pwm[3][nr] ? : 255, 255, 255, 255, 255 };
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	val =3D SENSORS_LIMIT(val, minval[index], maxval[index]);
+
+	mutex_lock(&data->update_lock);
+	data->pwm[index][nr] =3D val;
+	nct6775_write_value(data, data->REG_PWM[index][nr], val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+/* Returns 0 if OK, -EINVAL otherwise */
+static int check_trip_points(struct nct6775_data *data, int nr)
+{
+	int i;
+
+	for (i =3D 0; i < data->auto_pwm_num - 1; i++) {
+		if (data->auto_temp[nr][i] > data->auto_temp[nr][i + 1])
+			return -EINVAL;
+	}
+	for (i =3D 0; i < data->auto_pwm_num - 1; i++) {
+		if (data->auto_pwm[nr][i] > data->auto_pwm[nr][i + 1])
+			return -EINVAL;
+	}
+	/* validate critical temperature and pwm if enabled (pwm > 0) */
+	if (data->auto_pwm[nr][data->auto_pwm_num]) {
+		if (data->auto_temp[nr][data->auto_pwm_num - 1] >
+				data->auto_temp[nr][data->auto_pwm_num] ||
+		    data->auto_pwm[nr][data->auto_pwm_num - 1] >
+				data->auto_pwm[nr][data->auto_pwm_num])
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static ssize_t
+store_pwm_enable(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	unsigned long val;
+	int err;
+	u16 reg;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	if (val > 5)
+		return -EINVAL;
+
+	if (val =3D 4 && data->kind !=3D nct6775)
+		return -EINVAL;
+
+	if (val =3D 5 && check_trip_points(data, nr)) {
+		dev_err(dev, "Inconsistent trip points, not switching to SmartFan IV mod=
e\n");
+		dev_err(dev, "Adjust trip points and try again\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->update_lock);
+	data->pwm_enable[nr] =3D val;
+	if (!val) {
+		/*
+		 * turn off pwm control: select manual mode, set pwm to maximum
+		 */
+		data->pwm[0][nr] =3D 255;
+		nct6775_write_value(data, data->REG_PWM[0][nr], 255);
+	}
+	reg =3D nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+	reg &=3D 0x0f;
+	reg |=3D pwm_enable_to_reg(val) << 4;
+	nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_pwm_temp_sel(struct device *dev, struct device_attribute *attr, char =
*buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int i, src, sel =3D 0;
+
+	src =3D data->pwm_temp_sel[sattr->index][sattr->nr];
+
+	for (i =3D 0; i < NUM_TEMP; i++) {
+		if (!(data->have_temp & (1 << i)))
+			continue;
+		if (src =3D data->temp_src[i]) {
+			sel =3D i + 1;
+			break;
+		}
+	}
+
+	return sprintf(buf, "%d\n", sel);
+}
+
+static ssize_t
+store_pwm_temp_sel(struct device *dev, struct device_attribute *attr,
+		   const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int err, reg, src;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	if (val =3D 0 || val > NUM_TEMP)
+		return -EINVAL;
+	if (!(data->have_temp & (1 << (val - 1))) || !data->temp_src[val - 1])
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	src =3D data->temp_src[val - 1];
+	data->pwm_temp_sel[index][nr] =3D src;
+	reg =3D nct6775_read_value(data, data->REG_TEMP_SEL[index][nr]);
+	reg &=3D 0xe0;
+	reg |=3D src;
+	nct6775_write_value(data, data->REG_TEMP_SEL[index][nr], reg);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t
+show_target_temp(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n",
+		       data->target_temp[sattr->index] * 1000);
+}
+
+static ssize_t
+store_target_temp(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val =3D SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+
+	mutex_lock(&data->update_lock);
+	data->target_temp[nr] =3D val;
+	nct6775_write_value(data, data->REG_TARGET[nr], val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_auto_temp_hyst(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int point =3D sattr->index >=3D data->auto_pwm_num ? 1 : 0;
+	int tolerance =3D data->tolerance[nr][point];
+	int temp =3D data->auto_temp[nr][sattr->index];
+
+	return sprintf(buf, "%d\n", (temp - tolerance) * 1000);
+}
+
+static ssize_t
+store_auto_temp_hyst(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int point =3D sattr->index >=3D data->auto_pwm_num ? 1 : 0;
+	u16 reg;
+	long val;
+	int err;
+	int maxlimit[2][3] =3D { { 15, 7, 63 }, { 15, 7, 7 } };
+	int mask[] =3D { 0x0f, 0x07, 0x07 };
+	int temp;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	temp =3D data->auto_temp[nr][sattr->index];
+	val =3D temp - DIV_ROUND_CLOSEST(val, 1000);
+
+	/* Limit tolerance as needed */
+	val =3D SENSORS_LIMIT(val, 0, maxlimit[point][data->kind]);
+
+	mutex_lock(&data->update_lock);
+	if (point) {
+		nct6775_write_value(data,
+				    data->REG_CRITICAL_TEMP_TOLERANCE[nr],
+				    val);
+	} else {
+		reg =3D nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+		reg =3D (reg & ~mask[nr]) | (val & mask[nr]);
+		nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
+		if (data->kind =3D nct6779) {
+			reg =3D nct6775_read_value(data,
+						 NCT6779_REG_TOLERANCE_H[nr]);
+			reg =3D (reg & 0x70) | ((val & 0x38) << 1);
+			nct6775_write_value(data,
+					    NCT6779_REG_TOLERANCE_H[nr], reg);
+		}
+	}
+
+	data->tolerance[nr][point] =3D val;
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_2(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, =
0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, =
1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, =
2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, =
3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm5, S_IWUSR | S_IRUGO, show_pwm, store_pwm, =
4, 0);
+
+static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 0);
+static SENSOR_DEVICE_ATTR(pwm2_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 1);
+static SENSOR_DEVICE_ATTR(pwm3_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 2);
+static SENSOR_DEVICE_ATTR(pwm4_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 3);
+static SENSOR_DEVICE_ATTR(pwm5_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 4);
+
+static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 0);
+static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 1);
+static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 2);
+static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 3);
+static SENSOR_DEVICE_ATTR(pwm5_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 4);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm4_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm5_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 4, 0);
+
+static SENSOR_DEVICE_ATTR(pwm1_target, S_IWUSR | S_IRUGO, show_target_temp,
+			  store_target_temp, 0);
+static SENSOR_DEVICE_ATTR(pwm2_target, S_IWUSR | S_IRUGO, show_target_temp,
+			  store_target_temp, 1);
+static SENSOR_DEVICE_ATTR(pwm3_target, S_IWUSR | S_IRUGO, show_target_temp,
+			  store_target_temp, 2);
+static SENSOR_DEVICE_ATTR(pwm4_target, S_IWUSR | S_IRUGO, show_target_temp,
+			  store_target_temp, 3);
+static SENSOR_DEVICE_ATTR(pwm5_target, S_IWUSR | S_IRUGO, show_target_temp,
+			  store_target_temp, 4);
+
+/* Smart Fan registers */
+
+static ssize_t
+show_pwm_sel_enable(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+
+	return sprintf(buf, "%d\n",
+		       data->pwm_sel_enable[sattr->index][sattr->nr]);
+}
+
+static ssize_t
+store_pwm_sel_enable(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int err;
+	u8 reg;
+	static const u8 bit[] =3D { 0x80, 0x80, 0x01 };
+
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm_sel_enable[index][nr] =3D val;
+	reg =3D nct6775_read_value(data, data->REG_TEMP_SEL[index][nr]);
+	reg &=3D ~bit[index];
+	if (val)
+		reg |=3D bit[index];
+	nct6775_write_value(data, data->REG_TEMP_SEL[index][nr], reg);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_weight_temp(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+
+	return sprintf(buf, "%d\n", data->weight_temp[index][nr] * 1000);
+}
+
+static ssize_t
+store_weight_temp(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val =3D SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+
+	mutex_lock(&data->update_lock);
+	data->weight_temp[index][nr] =3D val;
+	nct6775_write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_2(pwm1_stop_output_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_stop_output_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_stop_output_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm4_stop_output_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm5_stop_output_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 4, 0);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 3, 1);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_step_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 0, 2);
+static SENSOR_DEVICE_ATTR_2(pwm2_step_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 1, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_step_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 2, 2);
+static SENSOR_DEVICE_ATTR_2(pwm4_step_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 3, 2);
+static SENSOR_DEVICE_ATTR_2(pwm5_step_enable, S_IWUSR | S_IRUGO,
+			    show_pwm_sel_enable, store_pwm_sel_enable, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 3, 1);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_temp_sel, store_pwm_temp_sel, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 4, 0);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 3, 1);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 3, 2);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 0, 5);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 1, 5);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 2, 5);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 3, 5);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 4, 5);
+
+/* duty_base is not supported on all chips */
+static struct sensor_device_attribute_2 sda_weight_duty_base[] =3D {
+	SENSOR_ATTR_2(pwm1_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 0, 6),
+	SENSOR_ATTR_2(pwm2_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 1, 6),
+	SENSOR_ATTR_2(pwm3_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 2, 6),
+	SENSOR_ATTR_2(pwm4_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 3, 6),
+	SENSOR_ATTR_2(pwm5_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 4, 6),
+};
+
+static ssize_t
+show_fan_time(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+
+	return sprintf(buf, "%d\n",
+		       step_time_from_reg(data->fan_time[index][nr],
+					  data->pwm_mode[nr]));
+}
+
+static ssize_t
+store_fan_time(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val =3D step_time_to_reg(val, data->pwm_mode[nr]);
+	mutex_lock(&data->update_lock);
+	data->fan_time[index][nr] =3D val;
+	nct6775_write_value(data, data->REG_FAN_TIME[index][nr], val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_stop_time, S_IWUSR | S_IRUGO, show_fan_ti=
me,
+			    store_fan_time, 0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_stop_time, S_IWUSR | S_IRUGO, show_fan_ti=
me,
+			    store_fan_time, 1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_stop_time, S_IWUSR | S_IRUGO, show_fan_ti=
me,
+			    store_fan_time, 2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm4_stop_time, S_IWUSR | S_IRUGO, show_fan_ti=
me,
+			    store_fan_time, 3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm5_stop_time, S_IWUSR | S_IRUGO, show_fan_ti=
me,
+			    store_fan_time, 4, 0);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_step_up_time, S_IWUSR | S_IRUGO, show_fan=
_time,
+			    store_fan_time, 0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_step_up_time, S_IWUSR | S_IRUGO, show_fan=
_time,
+			    store_fan_time, 1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_step_up_time, S_IWUSR | S_IRUGO, show_fan=
_time,
+			    store_fan_time, 2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm4_step_up_time, S_IWUSR | S_IRUGO, show_fan=
_time,
+			    store_fan_time, 3, 1);
+static SENSOR_DEVICE_ATTR_2(pwm5_step_up_time, S_IWUSR | S_IRUGO, show_fan=
_time,
+			    store_fan_time, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_step_down_time, S_IWUSR | S_IRUGO,
+			    show_fan_time, store_fan_time, 0, 2);
+static SENSOR_DEVICE_ATTR_2(pwm2_step_down_time, S_IWUSR | S_IRUGO,
+			    show_fan_time, store_fan_time, 1, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_step_down_time, S_IWUSR | S_IRUGO,
+			    show_fan_time, store_fan_time, 2, 2);
+static SENSOR_DEVICE_ATTR_2(pwm4_step_down_time, S_IWUSR | S_IRUGO,
+			    show_fan_time, store_fan_time, 3, 2);
+static SENSOR_DEVICE_ATTR_2(pwm5_step_down_time, S_IWUSR | S_IRUGO,
+			    show_fan_time, store_fan_time, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_start_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_start_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_start_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm4_start_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 3, 1);
+static SENSOR_DEVICE_ATTR_2(pwm5_start_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_stop_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 0, 2);
+static SENSOR_DEVICE_ATTR_2(pwm2_stop_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 1, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_stop_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 2, 2);
+static SENSOR_DEVICE_ATTR_2(pwm4_stop_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 3, 2);
+static SENSOR_DEVICE_ATTR_2(pwm5_stop_output, S_IWUSR | S_IRUGO, show_pwm,
+			    store_pwm, 4, 2);
+
+/* max_output is not supported on all chips */
+static struct sensor_device_attribute_2 sda_max_output[] =3D {
+	SENSOR_ATTR_2(pwm1_max_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      0, 3),
+	SENSOR_ATTR_2(pwm2_max_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      1, 3),
+	SENSOR_ATTR_2(pwm3_max_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      2, 3),
+	SENSOR_ATTR_2(pwm4_max_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      3, 3),
+	SENSOR_ATTR_2(pwm5_max_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      4, 3),
+};
+
+/* step_output is not supported on all chips */
+static struct sensor_device_attribute_2 sda_step_output[] =3D {
+	SENSOR_ATTR_2(pwm1_step_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      0, 4),
+	SENSOR_ATTR_2(pwm2_step_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      1, 4),
+	SENSOR_ATTR_2(pwm3_step_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      2, 4),
+	SENSOR_ATTR_2(pwm4_step_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      3, 4),
+	SENSOR_ATTR_2(pwm5_step_output, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		      4, 4),
+};
+
+static struct attribute *nct6775_attributes_pwm[5][20] =3D {
+	{
+		&sensor_dev_attr_pwm1.dev_attr.attr,
+		&sensor_dev_attr_pwm1_mode.dev_attr.attr,
+		&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm1_stop_output_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm1_step_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm1_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm1_target.dev_attr.attr,
+		&sensor_dev_attr_pwm1_stop_time.dev_attr.attr,
+		&sensor_dev_attr_pwm1_step_up_time.dev_attr.attr,
+		&sensor_dev_attr_pwm1_step_down_time.dev_attr.attr,
+		&sensor_dev_attr_pwm1_start_output.dev_attr.attr,
+		&sensor_dev_attr_pwm1_stop_output.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_duty_step.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm2.dev_attr.attr,
+		&sensor_dev_attr_pwm2_mode.dev_attr.attr,
+		&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm2_stop_output_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm2_step_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm2_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm2_target.dev_attr.attr,
+		&sensor_dev_attr_pwm2_stop_time.dev_attr.attr,
+		&sensor_dev_attr_pwm2_step_up_time.dev_attr.attr,
+		&sensor_dev_attr_pwm2_step_down_time.dev_attr.attr,
+		&sensor_dev_attr_pwm2_start_output.dev_attr.attr,
+		&sensor_dev_attr_pwm2_stop_output.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_duty_step.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm3.dev_attr.attr,
+		&sensor_dev_attr_pwm3_mode.dev_attr.attr,
+		&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm3_stop_output_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm3_step_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm3_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm3_target.dev_attr.attr,
+		&sensor_dev_attr_pwm3_stop_time.dev_attr.attr,
+		&sensor_dev_attr_pwm3_step_up_time.dev_attr.attr,
+		&sensor_dev_attr_pwm3_step_down_time.dev_attr.attr,
+		&sensor_dev_attr_pwm3_start_output.dev_attr.attr,
+		&sensor_dev_attr_pwm3_stop_output.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_duty_step.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm4.dev_attr.attr,
+		&sensor_dev_attr_pwm4_mode.dev_attr.attr,
+		&sensor_dev_attr_pwm4_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm4_stop_output_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm4_step_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm4_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm4_target.dev_attr.attr,
+		&sensor_dev_attr_pwm4_stop_time.dev_attr.attr,
+		&sensor_dev_attr_pwm4_step_up_time.dev_attr.attr,
+		&sensor_dev_attr_pwm4_step_down_time.dev_attr.attr,
+		&sensor_dev_attr_pwm4_start_output.dev_attr.attr,
+		&sensor_dev_attr_pwm4_stop_output.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_duty_step.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm5.dev_attr.attr,
+		&sensor_dev_attr_pwm5_mode.dev_attr.attr,
+		&sensor_dev_attr_pwm5_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm5_stop_output_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm5_step_enable.dev_attr.attr,
+		&sensor_dev_attr_pwm5_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm5_target.dev_attr.attr,
+		&sensor_dev_attr_pwm5_stop_time.dev_attr.attr,
+		&sensor_dev_attr_pwm5_step_up_time.dev_attr.attr,
+		&sensor_dev_attr_pwm5_step_down_time.dev_attr.attr,
+		&sensor_dev_attr_pwm5_start_output.dev_attr.attr,
+		&sensor_dev_attr_pwm5_stop_output.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_duty_step.dev_attr.attr,
+		NULL
+	},
+};
+
+static const struct attribute_group nct6775_group_pwm[5] =3D {
+	{ .attrs =3D nct6775_attributes_pwm[0] },
+	{ .attrs =3D nct6775_attributes_pwm[1] },
+	{ .attrs =3D nct6775_attributes_pwm[2] },
+	{ .attrs =3D nct6775_attributes_pwm[3] },
+	{ .attrs =3D nct6775_attributes_pwm[4] },
+};
+
+static ssize_t
+show_auto_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+
+	return sprintf(buf, "%d\n", data->auto_pwm[sattr->nr][sattr->index]);
+}
+
+static ssize_t
+store_auto_pwm(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int point =3D sattr->index;
+	unsigned long val;
+	int err;
+	u8 reg;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	if (val > 255)
+		return -EINVAL;
+
+	if (point =3D data->auto_pwm_num) {
+		if (data->kind !=3D nct6775 && !val)
+			return -EINVAL;
+		if (data->kind !=3D nct6779 && val)
+			val =3D 0xff;
+	}
+
+	mutex_lock(&data->update_lock);
+	data->auto_pwm[nr][point] =3D val;
+	if (point < data->auto_pwm_num) {
+		nct6775_write_value(data,
+				    NCT6775_AUTO_PWM(data, nr, point),
+				    data->auto_pwm[nr][point]);
+	} else {
+		switch (data->kind) {
+		case nct6775:
+			/* disable if needed (pwm =3D 0) */
+			reg =3D nct6775_read_value(data,
+						 NCT6775_REG_CRITICAL_ENAB[nr]);
+			if (val)
+				reg |=3D 0x02;
+			else
+				reg &=3D ~0x02;
+			nct6775_write_value(data, NCT6775_REG_CRITICAL_ENAB[nr],
+					    reg);
+			break;
+		case nct6776:
+			break; /* always enabled, nothing to do */
+		case nct6779:
+			nct6775_write_value(data, NCT6779_REG_CRITICAL_PWM[nr],
+					    val);
+			reg =3D nct6775_read_value(data,
+					NCT6779_REG_CRITICAL_PWM_ENABLE[nr]);
+			if (val =3D 255)
+				reg &=3D ~0x01;
+			else
+				reg |=3D 0x01;
+			nct6775_write_value(data,
+					    NCT6779_REG_CRITICAL_PWM_ENABLE[nr],
+					    reg);
+			break;
+		}
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_auto_temp(struct device *dev, struct device_attribute *attr, char *bu=
f)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int point =3D sattr->index;
+
+	/*
+	 * We don't know for sure if the temperature is signed or unsigned.
+	 * Assume it is unsigned.
+	 */
+	return sprintf(buf, "%d\n", data->auto_temp[nr][point] * 1000);
+}
+
+static ssize_t
+store_auto_temp(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int point =3D sattr->index;
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val > 255000)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->auto_temp[nr][point] =3D DIV_ROUND_CLOSEST(val, 1000);
+	if (point < data->auto_pwm_num) {
+		nct6775_write_value(data,
+				    NCT6775_AUTO_TEMP(data, nr, point),
+				    data->auto_temp[nr][point]);
+	} else {
+		nct6775_write_value(data, data->REG_CRITICAL_TEMP[nr],
+				    data->auto_temp[nr][point]);
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+/*
+ * The number of auto-point trip points is chip dependent.
+ * Need to check support while generating/removing attribute files.
+ */
+static struct sensor_device_attribute_2 sda_auto_pwm_arrays[] =3D {
+	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 1),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 1),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 1),
+	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 2),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 2),
+	SENSOR_ATTR_2(pwm1_auto_point4_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 3),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 3),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 3),
+	SENSOR_ATTR_2(pwm1_auto_point5_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 4),
+	SENSOR_ATTR_2(pwm1_auto_point5_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 4),
+	SENSOR_ATTR_2(pwm1_auto_point5_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 4),
+	SENSOR_ATTR_2(pwm1_auto_point6_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 5),
+	SENSOR_ATTR_2(pwm1_auto_point6_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 5),
+	SENSOR_ATTR_2(pwm1_auto_point6_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 5),
+	SENSOR_ATTR_2(pwm1_auto_point7_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 0, 6),
+	SENSOR_ATTR_2(pwm1_auto_point7_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 0, 6),
+	SENSOR_ATTR_2(pwm1_auto_point7_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 0, 6),
+
+	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 0),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 0),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 0),
+	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 2),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 2),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 2),
+	SENSOR_ATTR_2(pwm2_auto_point4_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 3),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 3),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 3),
+	SENSOR_ATTR_2(pwm2_auto_point5_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 4),
+	SENSOR_ATTR_2(pwm2_auto_point5_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 4),
+	SENSOR_ATTR_2(pwm2_auto_point5_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 4),
+	SENSOR_ATTR_2(pwm2_auto_point6_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 5),
+	SENSOR_ATTR_2(pwm2_auto_point6_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 5),
+	SENSOR_ATTR_2(pwm2_auto_point6_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 5),
+	SENSOR_ATTR_2(pwm2_auto_point7_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 1, 6),
+	SENSOR_ATTR_2(pwm2_auto_point7_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 1, 6),
+	SENSOR_ATTR_2(pwm2_auto_point7_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 1, 6),
+
+	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 0),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 0),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 0),
+	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 1),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 1),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 1),
+	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 3),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 3),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 3),
+	SENSOR_ATTR_2(pwm3_auto_point5_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 4),
+	SENSOR_ATTR_2(pwm3_auto_point5_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 4),
+	SENSOR_ATTR_2(pwm3_auto_point5_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 4),
+	SENSOR_ATTR_2(pwm3_auto_point6_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 5),
+	SENSOR_ATTR_2(pwm3_auto_point6_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 5),
+	SENSOR_ATTR_2(pwm3_auto_point6_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 5),
+	SENSOR_ATTR_2(pwm3_auto_point7_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 2, 6),
+	SENSOR_ATTR_2(pwm3_auto_point7_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 2, 6),
+	SENSOR_ATTR_2(pwm3_auto_point7_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 2, 6),
+
+	SENSOR_ATTR_2(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 0),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 0),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 0),
+	SENSOR_ATTR_2(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 1),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 1),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 1),
+	SENSOR_ATTR_2(pwm4_auto_point3_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 2),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 2),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 2),
+	SENSOR_ATTR_2(pwm4_auto_point4_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point5_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 4),
+	SENSOR_ATTR_2(pwm4_auto_point5_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 4),
+	SENSOR_ATTR_2(pwm4_auto_point5_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 4),
+	SENSOR_ATTR_2(pwm4_auto_point6_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 5),
+	SENSOR_ATTR_2(pwm4_auto_point6_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 5),
+	SENSOR_ATTR_2(pwm4_auto_point6_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 5),
+	SENSOR_ATTR_2(pwm4_auto_point7_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 3, 6),
+	SENSOR_ATTR_2(pwm4_auto_point7_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 3, 6),
+	SENSOR_ATTR_2(pwm4_auto_point7_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 3, 6),
+
+	SENSOR_ATTR_2(pwm5_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 0),
+	SENSOR_ATTR_2(pwm5_auto_point1_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 0),
+	SENSOR_ATTR_2(pwm5_auto_point1_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 0),
+	SENSOR_ATTR_2(pwm5_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 1),
+	SENSOR_ATTR_2(pwm5_auto_point2_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 1),
+	SENSOR_ATTR_2(pwm5_auto_point2_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 1),
+	SENSOR_ATTR_2(pwm5_auto_point3_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 2),
+	SENSOR_ATTR_2(pwm5_auto_point3_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 2),
+	SENSOR_ATTR_2(pwm5_auto_point3_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 2),
+	SENSOR_ATTR_2(pwm5_auto_point4_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 3),
+	SENSOR_ATTR_2(pwm5_auto_point4_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 3),
+	SENSOR_ATTR_2(pwm5_auto_point4_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 3),
+	SENSOR_ATTR_2(pwm5_auto_point5_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 4),
+	SENSOR_ATTR_2(pwm5_auto_point5_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 4),
+	SENSOR_ATTR_2(pwm5_auto_point5_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 4),
+	SENSOR_ATTR_2(pwm5_auto_point6_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 5),
+	SENSOR_ATTR_2(pwm5_auto_point6_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 5),
+	SENSOR_ATTR_2(pwm5_auto_point6_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 5),
+	SENSOR_ATTR_2(pwm5_auto_point7_pwm, S_IWUSR | S_IRUGO,
+		      show_auto_pwm, store_auto_pwm, 4, 6),
+	SENSOR_ATTR_2(pwm5_auto_point7_temp, S_IWUSR | S_IRUGO,
+		      show_auto_temp, store_auto_temp, 4, 6),
+	SENSOR_ATTR_2(pwm5_auto_point7_temp_hyst, S_IWUSR | S_IRUGO,
+		      show_auto_temp_hyst, store_auto_temp_hyst, 4, 6),
+};
+
+static ssize_t
+show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+}
+
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+/* Case open detection */
+
+static ssize_t
+clear_caseopen(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct nct6775_sio_data *sio_data =3D dev->platform_data;
+	int nr =3D to_sensor_dev_attr(attr)->index - INTRUSION_ALARM_BASE;
+	unsigned long val;
+	u8 reg;
+	int ret;
+
+	if (kstrtoul(buf, 10, &val) || val !=3D 0)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	/*
+	 * Use CR registers to clear caseopen status.
+	 * The CR registers are the same for all chips, and not all chips
+	 * support clearing the caseopen status through "regular" registers.
+	 */
+	ret =3D superio_enter(sio_data->sioreg);
+	if (ret) {
+		count =3D ret;
+		goto error;
+	}
+
+	superio_select(sio_data->sioreg, NCT6775_LD_ACPI);
+	reg =3D superio_inb(sio_data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
+	reg |=3D NCT6775_CR_CASEOPEN_CLR_MASK[nr];
+	superio_outb(sio_data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	reg &=3D ~NCT6775_CR_CASEOPEN_CLR_MASK[nr];
+	superio_outb(sio_data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	superio_exit(sio_data->sioreg);
+
+	data->valid =3D 0;	/* Force cache refresh */
+error:
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static struct sensor_device_attribute sda_caseopen[] =3D {
+	SENSOR_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm,
+		    clear_caseopen, INTRUSION_ALARM_BASE),
+	SENSOR_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_alarm,
+		    clear_caseopen, INTRUSION_ALARM_BASE + 1),
+};
+
+/*
+ * Driver and device management
+ */
+
+static void nct6775_device_remove_files(struct device *dev)
+{
+	/*
+	 * some entries in the following arrays may not have been used in
+	 * device_create_file(), but device_remove_file() will ignore them
+	 */
+	int i;
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+
+	for (i =3D 0; i < data->pwm_num; i++)
+		sysfs_remove_group(&dev->kobj, &nct6775_group_pwm[i]);
+
+	for (i =3D 0; i < ARRAY_SIZE(sda_max_output); i++)
+		device_remove_file(dev, &sda_max_output[i].dev_attr);
+
+	for (i =3D 0; i < ARRAY_SIZE(sda_step_output); i++)
+		device_remove_file(dev, &sda_max_output[i].dev_attr);
+
+	for (i =3D 0; i < ARRAY_SIZE(sda_weight_duty_base); i++)
+		device_remove_file(dev, &sda_weight_duty_base[i].dev_attr);
+
+	for (i =3D 0; i < ARRAY_SIZE(sda_auto_pwm_arrays); i++)
+		device_remove_file(dev, &sda_auto_pwm_arrays[i].dev_attr);
+
+	for (i =3D 0; i < data->in_num; i++)
+		sysfs_remove_group(&dev->kobj, &nct6775_group_in[i]);
+
+	for (i =3D 0; i < 5; i++) {
+		device_remove_file(dev, &sda_fan_input[i].dev_attr);
+		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
+		device_remove_file(dev, &sda_fan_div[i].dev_attr);
+		device_remove_file(dev, &sda_fan_min[i].dev_attr);
+	}
+	for (i =3D 0; i < NUM_TEMP; i++) {
+		if (!(data->have_temp & (1 << i)))
+			continue;
+		device_remove_file(dev, &sda_temp_input[i].dev_attr);
+		device_remove_file(dev, &sda_temp_label[i].dev_attr);
+		device_remove_file(dev, &sda_temp_max[i].dev_attr);
+		device_remove_file(dev, &sda_temp_max_hyst[i].dev_attr);
+		device_remove_file(dev, &sda_temp_crit[i].dev_attr);
+		if (!(data->have_temp_fixed & (1 << i)))
+			continue;
+		device_remove_file(dev, &sda_temp_type[i].dev_attr);
+		device_remove_file(dev, &sda_temp_offset[i].dev_attr);
+		if (i >=3D NUM_TEMP_ALARM)
+			continue;
+		device_remove_file(dev, &sda_temp_alarm[i].dev_attr);
+	}
+
+	device_remove_file(dev, &sda_caseopen[0].dev_attr);
+	device_remove_file(dev, &sda_caseopen[1].dev_attr);
+
+	device_remove_file(dev, &dev_attr_name);
+	device_remove_file(dev, &dev_attr_cpu0_vid);
+}
+
+/* Get the monitoring functions started */
+static inline void __devinit nct6775_init_device(struct nct6775_data *data)
+{
+	int i;
+	u8 tmp, diode;
+
+	/* Start monitoring if needed */
+	if (data->REG_CONFIG) {
+		tmp =3D nct6775_read_value(data, data->REG_CONFIG);
+		if (!(tmp & 0x01))
+			nct6775_write_value(data, data->REG_CONFIG, tmp | 0x01);
+	}
+
+	/* Enable temperature sensors if needed */
+	for (i =3D 0; i < NUM_TEMP; i++) {
+		if (!(data->have_temp & (1 << i)))
+			continue;
+		if (!data->reg_temp_config[i])
+			continue;
+		tmp =3D nct6775_read_value(data, data->reg_temp_config[i]);
+		if (tmp & 0x01)
+			nct6775_write_value(data, data->reg_temp_config[i],
+					    tmp & 0xfe);
+	}
+
+	/* Enable VBAT monitoring if needed */
+	tmp =3D nct6775_read_value(data, data->REG_VBAT);
+	if (!(tmp & 0x01))
+		nct6775_write_value(data, data->REG_VBAT, tmp | 0x01);
+
+	diode =3D nct6775_read_value(data, data->REG_DIODE);
+
+	for (i =3D 0; i < data->temp_fixed_num; i++) {
+		if (!(data->have_temp_fixed & (1 << i)))
+			continue;
+		if ((tmp & (0x02 << i)))	/* diode */
+			data->temp_type[i] =3D 3 - ((diode >> i) & 0x02);
+		else				/* thermistor */
+			data->temp_type[i] =3D 4;
+	}
+}
+
+static int __devinit
+nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
+			 struct nct6775_data *data)
+{
+	int regval;
+	bool fan3pin, fan3min, fan4pin, fan4min, fan5pin;
+	bool pwm3pin, pwm4pin, pwm5pin;
+	int ret;
+
+	ret =3D superio_enter(sio_data->sioreg);
+	if (ret)
+		return ret;
+
+	/* fan4 and fan5 share some pins with the GPIO and serial flash */
+	if (data->kind =3D nct6775) {
+		regval =3D superio_inb(sio_data->sioreg, 0x2c);
+
+		fan3pin =3D regval & (1 << 6);
+		fan3min =3D fan3pin;
+		pwm3pin =3D regval & (1 << 7);
+
+		/* On NCT6775, fan4 shares pins with the fdc interface */
+		fan4pin =3D !(superio_inb(sio_data->sioreg, 0x2A) & 0x80);
+		fan4min =3D 0;
+		fan5pin =3D 0;
+		pwm4pin =3D 0;
+		pwm5pin =3D 0;
+	} else if (data->kind =3D nct6776) {
+		bool gpok =3D superio_inb(sio_data->sioreg, 0x27) & 0x80;
+
+		superio_select(sio_data->sioreg, NCT6775_LD_HWM);
+		regval =3D superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
+
+		if (regval & 0x80)
+			fan3pin =3D gpok;
+		else
+			fan3pin =3D !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
+
+		if (regval & 0x40)
+			fan4pin =3D gpok;
+		else
+			fan4pin =3D superio_inb(sio_data->sioreg, 0x1C) & 0x01;
+
+		if (regval & 0x20)
+			fan5pin =3D gpok;
+		else
+			fan5pin =3D superio_inb(sio_data->sioreg, 0x1C) & 0x02;
+
+		fan4min =3D fan4pin;
+		fan3min =3D fan3pin;
+		pwm3pin =3D fan3pin;
+		pwm4pin =3D 0;
+		pwm5pin =3D 0;
+	} else {	/* NCT6779D */
+		regval =3D superio_inb(sio_data->sioreg, 0x1c);
+
+		fan3pin =3D !(regval & (1 << 5));
+		fan4pin =3D !(regval & (1 << 6));
+		fan5pin =3D !(regval & (1 << 7));
+
+		pwm3pin =3D !(regval & (1 << 0));
+		pwm4pin =3D !(regval & (1 << 1));
+		pwm5pin =3D !(regval & (1 << 2));
+
+		fan3min =3D fan3pin;
+		fan4min =3D fan4pin;
+	}
+
+	superio_exit(sio_data->sioreg);
+
+	data->has_fan =3D data->has_fan_min =3D 0x03; /* fan1 and fan2 */
+	data->has_fan |=3D fan3pin << 2;
+	data->has_fan_min |=3D fan3min << 2;
+
+	data->has_fan |=3D (fan4pin << 3) | (fan5pin << 4);
+	data->has_fan_min |=3D (fan4min << 3) | (fan5pin << 4);
+
+	data->has_pwm =3D 0x03 | (pwm3pin << 2) | (pwm4pin << 3) | (pwm5pin << 4);
+
+	return 0;
+}
+
+static int __devinit nct6775_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct nct6775_sio_data *sio_data =3D dev->platform_data;
+	struct nct6775_data *data;
+	struct resource *res;
+	int i, s, err =3D 0;
+	int src, mask, available;
+	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
+	const u16 *reg_temp_alternate, *reg_temp_crit;
+	int num_reg_temp;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
+				 DRVNAME))
+		return -EBUSY;
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(struct nct6775_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->kind =3D sio_data->kind;
+	data->addr =3D res->start;
+	mutex_init(&data->lock);
+	mutex_init(&data->update_lock);
+	data->name =3D nct6775_device_names[data->kind];
+	platform_set_drvdata(pdev, data);
+
+	switch (data->kind) {
+	case nct6775:
+		data->in_num =3D 9;
+		data->pwm_num =3D 3;
+		data->auto_pwm_num =3D 6;
+		data->has_fan_div =3D true;
+		data->temp_fixed_num =3D 3;
+
+		data->ALARM_BITS =3D NCT6775_ALARM_BITS;
+
+		data->fan_from_reg =3D fan_from_reg16;
+		data->fan_from_reg_min =3D fan_from_reg8;
+
+		data->temp_label =3D nct6775_temp_label;
+		data->temp_label_num =3D ARRAY_SIZE(nct6775_temp_label);
+
+		data->REG_CONFIG =3D NCT6775_REG_CONFIG;
+		data->REG_VBAT =3D NCT6775_REG_VBAT;
+		data->REG_DIODE =3D NCT6775_REG_DIODE;
+		data->REG_VIN =3D NCT6775_REG_IN;
+		data->REG_IN_MINMAX[0] =3D NCT6775_REG_IN_MIN;
+		data->REG_IN_MINMAX[1] =3D NCT6775_REG_IN_MAX;
+		data->REG_TARGET =3D NCT6775_REG_TARGET;
+		data->REG_FAN =3D NCT6775_REG_FAN;
+		data->REG_FAN_MODE =3D NCT6775_REG_FAN_MODE;
+		data->REG_FAN_MIN =3D NCT6775_REG_FAN_MIN;
+		data->REG_FAN_TIME[0] =3D NCT6775_REG_FAN_STOP_TIME;
+		data->REG_FAN_TIME[1] =3D NCT6775_REG_FAN_STEP_UP_TIME;
+		data->REG_FAN_TIME[2] =3D NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_PWM[0] =3D NCT6775_REG_PWM;
+		data->REG_PWM[1] =3D NCT6775_REG_FAN_START_OUTPUT;
+		data->REG_PWM[2] =3D NCT6775_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[3] =3D NCT6775_REG_FAN_MAX_OUTPUT;
+		data->REG_PWM[4] =3D NCT6775_REG_FAN_STEP_OUTPUT;
+		data->REG_PWM[5] =3D NCT6775_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM_READ =3D NCT6775_REG_PWM_READ;
+		data->REG_PWM_MODE =3D NCT6775_REG_PWM_MODE;
+		data->PWM_MODE_MASK =3D NCT6775_PWM_MODE_MASK;
+		data->REG_AUTO_TEMP =3D NCT6775_REG_AUTO_TEMP;
+		data->REG_AUTO_PWM =3D NCT6775_REG_AUTO_PWM;
+		data->REG_CRITICAL_TEMP =3D NCT6775_REG_CRITICAL_TEMP;
+		data->REG_CRITICAL_TEMP_TOLERANCE
+		  =3D NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
+		data->REG_TEMP_OFFSET =3D NCT6775_REG_TEMP_OFFSET;
+		data->REG_TEMP_SOURCE =3D NCT6775_REG_TEMP_SOURCE;
+		data->REG_TEMP_SEL[0] =3D NCT6775_REG_TEMP_SEL;
+		data->REG_TEMP_SEL[1] =3D NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_TEMP_SEL[2] =3D NCT6775_REG_FAN_STEP_ENABLE;
+		data->REG_WEIGHT_TEMP[0] =3D NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] =3D NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
+		data->REG_ALARM =3D NCT6775_REG_ALARM;
+
+		reg_temp =3D NCT6775_REG_TEMP;
+		num_reg_temp =3D ARRAY_SIZE(NCT6775_REG_TEMP);
+		reg_temp_over =3D NCT6775_REG_TEMP_OVER;
+		reg_temp_hyst =3D NCT6775_REG_TEMP_HYST;
+		reg_temp_config =3D NCT6775_REG_TEMP_CONFIG;
+		reg_temp_alternate =3D NCT6775_REG_TEMP_ALTERNATE;
+		reg_temp_crit =3D NCT6775_REG_TEMP_CRIT;
+
+		break;
+	case nct6776:
+		data->in_num =3D 9;
+		data->pwm_num =3D 3;
+		data->auto_pwm_num =3D 4;
+		data->has_fan_div =3D false;
+		data->temp_fixed_num =3D 3;
+
+		data->ALARM_BITS =3D NCT6776_ALARM_BITS;
+
+		data->fan_from_reg =3D fan_from_reg13;
+		data->fan_from_reg_min =3D fan_from_reg13;
+
+		data->temp_label =3D nct6776_temp_label;
+		data->temp_label_num =3D ARRAY_SIZE(nct6776_temp_label);
+
+		data->REG_CONFIG =3D NCT6775_REG_CONFIG;
+		data->REG_VBAT =3D NCT6775_REG_VBAT;
+		data->REG_DIODE =3D NCT6775_REG_DIODE;
+		data->REG_VIN =3D NCT6775_REG_IN;
+		data->REG_IN_MINMAX[0] =3D NCT6775_REG_IN_MIN;
+		data->REG_IN_MINMAX[1] =3D NCT6775_REG_IN_MAX;
+		data->REG_TARGET =3D NCT6775_REG_TARGET;
+		data->REG_FAN =3D NCT6775_REG_FAN;
+		data->REG_FAN_MODE =3D NCT6775_REG_FAN_MODE;
+		data->REG_FAN_MIN =3D NCT6776_REG_FAN_MIN;
+		data->REG_FAN_TIME[0] =3D NCT6775_REG_FAN_STOP_TIME;
+		data->REG_FAN_TIME[1] =3D NCT6775_REG_FAN_STEP_UP_TIME;
+		data->REG_FAN_TIME[2] =3D NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_PWM[0] =3D NCT6775_REG_PWM;
+		data->REG_PWM[1] =3D NCT6775_REG_FAN_START_OUTPUT;
+		data->REG_PWM[2] =3D NCT6775_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[5] =3D NCT6775_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] =3D NCT6776_REG_WEIGHT_DUTY_BASE;
+		data->REG_PWM_READ =3D NCT6775_REG_PWM_READ;
+		data->REG_PWM_MODE =3D NCT6776_REG_PWM_MODE;
+		data->PWM_MODE_MASK =3D NCT6776_PWM_MODE_MASK;
+		data->REG_AUTO_TEMP =3D NCT6775_REG_AUTO_TEMP;
+		data->REG_AUTO_PWM =3D NCT6775_REG_AUTO_PWM;
+		data->REG_CRITICAL_TEMP =3D NCT6775_REG_CRITICAL_TEMP;
+		data->REG_CRITICAL_TEMP_TOLERANCE
+		  =3D NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
+		data->REG_TEMP_OFFSET =3D NCT6775_REG_TEMP_OFFSET;
+		data->REG_TEMP_SOURCE =3D NCT6775_REG_TEMP_SOURCE;
+		data->REG_TEMP_SEL[0] =3D NCT6775_REG_TEMP_SEL;
+		data->REG_TEMP_SEL[1] =3D NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_TEMP_SEL[2] =3D NCT6775_REG_FAN_STEP_ENABLE;
+		data->REG_WEIGHT_TEMP[0] =3D NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] =3D NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
+		data->REG_ALARM =3D NCT6775_REG_ALARM;
+
+		reg_temp =3D NCT6775_REG_TEMP;
+		num_reg_temp =3D ARRAY_SIZE(NCT6775_REG_TEMP);
+		reg_temp_over =3D NCT6775_REG_TEMP_OVER;
+		reg_temp_hyst =3D NCT6775_REG_TEMP_HYST;
+		reg_temp_config =3D NCT6776_REG_TEMP_CONFIG;
+		reg_temp_alternate =3D NCT6776_REG_TEMP_ALTERNATE;
+		reg_temp_crit =3D NCT6776_REG_TEMP_CRIT;
+
+		break;
+	case nct6779:
+		data->in_num =3D 15;
+		data->pwm_num =3D 5;
+		data->auto_pwm_num =3D 4;
+		data->has_fan_div =3D false;
+		data->temp_fixed_num =3D 6;
+
+		data->ALARM_BITS =3D NCT6779_ALARM_BITS;
+
+		data->fan_from_reg =3D fan_from_reg13;
+		data->fan_from_reg_min =3D fan_from_reg13;
+
+		data->temp_label =3D nct6779_temp_label;
+		data->temp_label_num =3D ARRAY_SIZE(nct6779_temp_label);
+
+		data->REG_CONFIG =3D NCT6775_REG_CONFIG;
+		data->REG_VBAT =3D NCT6775_REG_VBAT;
+		data->REG_DIODE =3D NCT6775_REG_DIODE;
+		data->REG_VIN =3D NCT6779_REG_IN;
+		data->REG_IN_MINMAX[0] =3D NCT6775_REG_IN_MIN;
+		data->REG_IN_MINMAX[1] =3D NCT6775_REG_IN_MAX;
+		data->REG_TARGET =3D NCT6775_REG_TARGET;
+		data->REG_FAN =3D NCT6779_REG_FAN;
+		data->REG_FAN_MODE =3D NCT6775_REG_FAN_MODE;
+		data->REG_FAN_MIN =3D NCT6776_REG_FAN_MIN;
+		data->REG_FAN_TIME[0] =3D NCT6775_REG_FAN_STOP_TIME;
+		data->REG_FAN_TIME[1] =3D NCT6775_REG_FAN_STEP_UP_TIME;
+		data->REG_FAN_TIME[2] =3D NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_PWM[0] =3D NCT6775_REG_PWM;
+		data->REG_PWM[1] =3D NCT6775_REG_FAN_START_OUTPUT;
+		data->REG_PWM[2] =3D NCT6775_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[5] =3D NCT6775_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] =3D NCT6776_REG_WEIGHT_DUTY_BASE;
+		data->REG_PWM_READ =3D NCT6775_REG_PWM_READ;
+		data->REG_PWM_MODE =3D NCT6776_REG_PWM_MODE;
+		data->PWM_MODE_MASK =3D NCT6776_PWM_MODE_MASK;
+		data->REG_AUTO_TEMP =3D NCT6775_REG_AUTO_TEMP;
+		data->REG_AUTO_PWM =3D NCT6775_REG_AUTO_PWM;
+		data->REG_CRITICAL_TEMP =3D NCT6775_REG_CRITICAL_TEMP;
+		data->REG_CRITICAL_TEMP_TOLERANCE
+		  =3D NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
+		data->REG_TEMP_OFFSET =3D NCT6779_REG_TEMP_OFFSET;
+		data->REG_TEMP_SOURCE =3D NCT6775_REG_TEMP_SOURCE;
+		data->REG_TEMP_SEL[0] =3D NCT6775_REG_TEMP_SEL;
+		data->REG_TEMP_SEL[1] =3D NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_TEMP_SEL[2] =3D NCT6775_REG_FAN_STEP_ENABLE;
+		data->REG_WEIGHT_TEMP[0] =3D NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] =3D NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
+		data->REG_ALARM =3D NCT6779_REG_ALARM;
+
+		reg_temp =3D NCT6779_REG_TEMP;
+		num_reg_temp =3D ARRAY_SIZE(NCT6779_REG_TEMP);
+		reg_temp_over =3D NCT6779_REG_TEMP_OVER;
+		reg_temp_hyst =3D NCT6779_REG_TEMP_HYST;
+		reg_temp_config =3D NCT6779_REG_TEMP_CONFIG;
+		reg_temp_alternate =3D NCT6779_REG_TEMP_ALTERNATE;
+		reg_temp_crit =3D NCT6779_REG_TEMP_CRIT;
+
+		break;
+	default:
+		return -ENODEV;
+	}
+	data->have_in =3D (1 << data->in_num) - 1;
+	data->have_temp =3D 0;
+
+	/*
+	 * On some boards, not all available temperature sources are monitored,
+	 * even though some of the monitoring registers are unused.
+	 * Get list of unused monitoring registers, then detect if any fan
+	 * controls are configured to use unmonitored temperature sources.
+	 * If so, assign the unmonitored temperature sources to available
+	 * monitoring registers.
+	 */
+	mask =3D 0;
+	available =3D 0;
+	for (i =3D 0; i < num_reg_temp; i++) {
+		if (reg_temp[i] =3D 0)
+			continue;
+
+		src =3D nct6775_read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
+		if (!src || (mask & (1 << src)))
+			available |=3D 1 << i;
+
+		mask |=3D 1 << src;
+	}
+
+	/*
+	 * Now find unmonitored temperature registers and enable monitoring
+	 * if additional monitoring registers are available.
+	 */
+	for (i =3D 0; i < ARRAY_SIZE(data->REG_TEMP_SEL) && available; i++) {
+		int j;
+
+		if (!data->REG_TEMP_SEL[i])
+			continue;
+		for (j =3D 0; j < data->pwm_num && available; j++) {
+			int index;
+
+			if (!data->REG_TEMP_SEL[i][j])
+				continue;
+			src =3D nct6775_read_value(data,
+						 data->REG_TEMP_SEL[i][j]);
+			src &=3D 0x1f;
+			if (!src || (mask & (1 << src)))
+				continue;
+			if (src >=3D data->temp_label_num ||
+			    !strlen(data->temp_label[src])) {
+				dev_info(dev,
+					 "Select source %d:%d reg 0x%x invalid (%d)\n",
+					 i, j, data->REG_TEMP_SEL[i][j], src);
+				continue;
+			}
+
+			index =3D __ffs(available);
+			nct6775_write_value(data,
+					    data->REG_TEMP_SOURCE[index],
+					    src);
+			available &=3D ~(1 << index);
+			mask |=3D 1 << src;
+		}
+	}
+
+	mask =3D 0;
+	s =3D NUM_TEMP_FIXED;	/* First dynamic temperature attribute */
+	for (i =3D 0; i < num_reg_temp; i++) {
+		if (reg_temp[i] =3D 0)
+			continue;
+
+		src =3D nct6775_read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
+		if (!src || (mask & (1 << src)))
+			continue;
+
+		if (src >=3D data->temp_label_num ||
+		    !strlen(data->temp_label[src])) {
+			dev_info(dev,
+				 "Invalid temperature source %d at index %d, source register 0x%x, tem=
p register 0x%x\n",
+				 src, i, data->REG_TEMP_SOURCE[i], reg_temp[i]);
+			continue;
+		}
+
+		mask |=3D 1 << src;
+
+		/* Use fixed index for SYSTIN(1), CPUTIN(2), AUXTIN(3) */
+		if (src <=3D data->temp_fixed_num) {
+			data->have_temp |=3D 1 << (src - 1);
+			data->have_temp_fixed |=3D 1 << (src - 1);
+			data->reg_temp[0][src - 1] =3D reg_temp[i];
+			data->reg_temp[1][src - 1] =3D reg_temp_over[i];
+			data->reg_temp[2][src - 1] =3D reg_temp_hyst[i];
+			data->reg_temp_config[src - 1] =3D reg_temp_config[i];
+			data->temp_src[src - 1] =3D src;
+			continue;
+		}
+
+		if (s >=3D NUM_TEMP)
+			continue;
+
+		/* Use dynamic index for other sources */
+		data->have_temp |=3D 1 << s;
+		data->reg_temp[0][s] =3D reg_temp[i];
+		data->reg_temp[1][s] =3D reg_temp_over[i];
+		data->reg_temp[2][s] =3D reg_temp_hyst[i];
+		data->reg_temp_config[s] =3D reg_temp_config[i];
+		if (reg_temp_crit[src - 1])
+			data->reg_temp[3][s] =3D reg_temp_crit[src - 1];
+
+		data->temp_src[s] =3D src;
+		s++;
+	}
+
+#ifdef TESTING
+	/*
+	 * Go through the list of alternate temp registers and enable
+	 * if possible.
+	 * The temperature is already monitored if the respective bit in <mask>
+	 * is set.
+	 */
+	for (i =3D 0; i < data->temp_label_num - 1; i++) {
+		if (!reg_temp_alternate[i])
+			continue;
+		if (mask & (1 << (i + 1)))
+			continue;
+		if (i < data->temp_fixed_num) {
+			if (data->have_temp & (1 << i))
+				continue;
+			data->have_temp |=3D 1 << i;
+			data->have_temp_fixed |=3D 1 << i;
+			data->reg_temp[0][i] =3D reg_temp_alternate[i];
+			data->reg_temp[1][i] =3D reg_temp_over[i];
+			data->reg_temp[2][i] =3D reg_temp_hyst[i];
+			data->temp_src[i] =3D i + 1;
+			continue;
+		}
+
+		if (s >=3D NUM_TEMP)	/* Abort if no more space */
+			break;
+
+		data->have_temp |=3D 1 << s;
+		data->reg_temp[0][s] =3D reg_temp_alternate[i];
+		data->temp_src[s] =3D i + 1;
+		s++;
+	}
+#endif /* TESTING */
+
+	switch (data->kind) {
+	case nct6775:
+		break;
+	case nct6776:
+		/*
+		 * On NCT6776, AUXTIN and VIN3 pins are shared.
+		 * Only way to detect it is to check if AUXTIN is used
+		 * as a temperature source, and if that source is
+		 * enabled.
+		 *
+		 * If that is the case, disable in6, which reports VIN3.
+		 * Otherwise disable temp3.
+		 */
+		if (data->have_temp & (1 << 2)) {
+			u8 reg =3D nct6775_read_value(data,
+						    data->reg_temp_config[2]);
+			if (reg & 0x01)
+				data->have_temp &=3D ~(1 << 2);
+			else
+				data->have_in &=3D ~(1 << 6);
+		}
+		break;
+	case nct6779:
+		/*
+		 * Shared pins:
+		 *	VIN4 / AUXTIN0
+		 *	VIN5 / AUXTIN1
+		 *	VIN6 / AUXTIN2
+		 *	VIN7 / AUXTIN3
+		 *
+		 * There does not seem to be a clean way to detect if VINx or
+		 * AUXTINx is active, so for keep both sensor types enabled
+		 * for now.
+		 */
+		break;
+	}
+
+	/* Initialize the chip */
+	nct6775_init_device(data);
+
+	data->vrm =3D vid_which_vrm();
+	err =3D superio_enter(sio_data->sioreg);
+	if (err)
+		return err;
+
+	/*
+	 * Read VID value
+	 * We can get the VID input values directly at logical device D 0xe3.
+	 */
+	superio_select(sio_data->sioreg, NCT6775_LD_VID);
+	data->vid =3D superio_inb(sio_data->sioreg, 0xe3);
+
+	if (fan_debounce) {
+		u8 tmp;
+
+		superio_select(sio_data->sioreg, NCT6775_LD_HWM);
+		tmp =3D superio_inb(sio_data->sioreg,
+				  NCT6775_REG_CR_FAN_DEBOUNCE);
+		switch (data->kind) {
+		case nct6775:
+			tmp |=3D 0x1e;
+			break;
+		case nct6776:
+		case nct6779:
+			tmp |=3D 0x3e;
+			break;
+		}
+		superio_outb(sio_data->sioreg, NCT6775_REG_CR_FAN_DEBOUNCE,
+			     tmp);
+		dev_info(&pdev->dev, "Enabled fan debounce for chip %s\n",
+			 data->name);
+	}
+
+	superio_exit(sio_data->sioreg);
+
+	err =3D device_create_file(dev, &dev_attr_cpu0_vid);
+	if (err)
+		return err;
+
+	err =3D nct6775_check_fan_inputs(sio_data, data);
+	if (err)
+		goto exit_remove;
+
+	/* Read fan clock dividers immediately */
+	nct6775_update_fan_div_common(dev, data);
+
+	/* Register sysfs hooks */
+	for (i =3D 0; i < data->pwm_num; i++) {
+		if (!(data->has_pwm & (1 << i)))
+			continue;
+
+		err =3D sysfs_create_group(&dev->kobj, &nct6775_group_pwm[i]);
+		if (err)
+			goto exit_remove;
+
+		if (data->REG_PWM[3]) {
+			err =3D device_create_file(dev,
+					&sda_max_output[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+		if (data->REG_PWM[4]) {
+			err =3D device_create_file(dev,
+					&sda_step_output[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+		if (data->REG_PWM[6]) {
+			err =3D device_create_file(dev,
+					&sda_weight_duty_base[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+	}
+	for (i =3D 0; i < ARRAY_SIZE(sda_auto_pwm_arrays); i++) {
+		struct sensor_device_attribute_2 *attr +			&sda_auto_pwm_arrays[i];
+
+		if (!(data->has_pwm & (1 << attr->nr)))
+			continue;
+		if (attr->index > data->auto_pwm_num)
+			continue;
+		err =3D device_create_file(dev, &attr->dev_attr);
+		if (err)
+			goto exit_remove;
+	}
+
+	for (i =3D 0; i < data->in_num; i++) {
+		if (!(data->have_in & (1 << i)))
+			continue;
+		err =3D sysfs_create_group(&dev->kobj, &nct6775_group_in[i]);
+		if (err)
+			goto exit_remove;
+	}
+
+	for (i =3D 0; i < 5; i++) {
+		if (data->has_fan & (1 << i)) {
+			err =3D device_create_file(dev,
+						 &sda_fan_input[i].dev_attr);
+			if (err)
+				goto exit_remove;
+			err =3D device_create_file(dev,
+						 &sda_fan_alarm[i].dev_attr);
+			if (err)
+				goto exit_remove;
+			if (data->kind !=3D nct6776 &&
+			    data->kind !=3D nct6779) {
+				err =3D device_create_file(dev,
+						&sda_fan_div[i].dev_attr);
+				if (err)
+					goto exit_remove;
+			}
+			if (data->has_fan_min & (1 << i)) {
+				err =3D device_create_file(dev,
+						&sda_fan_min[i].dev_attr);
+				if (err)
+					goto exit_remove;
+			}
+		}
+	}
+
+	for (i =3D 0; i < NUM_TEMP; i++) {
+		if (!(data->have_temp & (1 << i)))
+			continue;
+		err =3D device_create_file(dev, &sda_temp_input[i].dev_attr);
+		if (err)
+			goto exit_remove;
+		if (data->temp_label) {
+			err =3D device_create_file(dev,
+						 &sda_temp_label[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+		if (data->reg_temp[1][i]) {
+			err =3D device_create_file(dev,
+						 &sda_temp_max[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+		if (data->reg_temp[2][i]) {
+			err =3D device_create_file(dev,
+					&sda_temp_max_hyst[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+		if (data->reg_temp[3][i]) {
+			err =3D device_create_file(dev,
+						 &sda_temp_crit[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+		if (!(data->have_temp_fixed & (1 << i)))
+			continue;
+		err =3D device_create_file(dev, &sda_temp_type[i].dev_attr);
+		if (err)
+			goto exit_remove;
+		err =3D device_create_file(dev, &sda_temp_offset[i].dev_attr);
+		if (err)
+			goto exit_remove;
+		if (i >=3D NUM_TEMP_ALARM ||
+		    data->ALARM_BITS[TEMP_ALARM_BASE + i] < 0)
+			continue;
+		err =3D device_create_file(dev, &sda_temp_alarm[i].dev_attr);
+		if (err)
+			goto exit_remove;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(sda_caseopen); i++) {
+		if (data->ALARM_BITS[INTRUSION_ALARM_BASE + i] < 0)
+			continue;
+		err =3D device_create_file(dev, &sda_caseopen[i].dev_attr);
+		if (err)
+			goto exit_remove;
+	}
+
+	err =3D device_create_file(dev, &dev_attr_name);
+	if (err)
+		goto exit_remove;
+
+	data->hwmon_dev =3D hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err =3D PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	return 0;
+
+exit_remove:
+	nct6775_device_remove_files(dev);
+	return err;
+}
+
+static int __devexit nct6775_remove(struct platform_device *pdev)
+{
+	struct nct6775_data *data =3D platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	nct6775_device_remove_files(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver nct6775_driver =3D {
+	.driver =3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D DRVNAME,
+	},
+	.probe		=3D nct6775_probe,
+	.remove		=3D __devexit_p(nct6775_remove),
+};
+
+/* nct6775_find() looks for a '627 in the Super-I/O config space */
+static int __init nct6775_find(int sioaddr, unsigned short *addr,
+			       struct nct6775_sio_data *sio_data)
+{
+	static const char sio_name_NCT6775[] __initconst =3D "NCT6775F";
+	static const char sio_name_NCT6776[] __initconst =3D "NCT6776F";
+	static const char sio_name_NCT6779[] __initconst =3D "NCT6779D";
+
+	u16 val;
+	const char *sio_name;
+	int err;
+
+	err =3D superio_enter(sioaddr);
+	if (err)
+		return err;
+
+	if (force_id)
+		val =3D force_id;
+	else
+		val =3D (superio_inb(sioaddr, SIO_REG_DEVID) << 8)
+		    | superio_inb(sioaddr, SIO_REG_DEVID + 1);
+	switch (val & SIO_ID_MASK) {
+	case SIO_NCT6775_ID:
+		sio_data->kind =3D nct6775;
+		sio_name =3D sio_name_NCT6775;
+		break;
+	case SIO_NCT6776_ID:
+		sio_data->kind =3D nct6776;
+		sio_name =3D sio_name_NCT6776;
+		break;
+	case SIO_NCT6779_ID:
+		sio_data->kind =3D nct6779;
+		sio_name =3D sio_name_NCT6779;
+		break;
+	default:
+		if (val !=3D 0xffff)
+			pr_debug("unsupported chip ID: 0x%04x\n", val);
+		superio_exit(sioaddr);
+		return -ENODEV;
+	}
+
+	/* We have a known chip, find the HWM I/O address */
+	superio_select(sioaddr, NCT6775_LD_HWM);
+	val =3D (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
+	    | superio_inb(sioaddr, SIO_REG_ADDR + 1);
+	*addr =3D val & IOREGION_ALIGNMENT;
+	if (*addr =3D 0) {
+		pr_err("Refusing to enable a Super-I/O device with a base I/O port 0\n");
+		superio_exit(sioaddr);
+		return -ENODEV;
+	}
+
+	/* Activate logical device if needed */
+	val =3D superio_inb(sioaddr, SIO_REG_ENABLE);
+	if (!(val & 0x01)) {
+		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
+		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
+	}
+
+	superio_exit(sioaddr);
+	pr_info("Found %s chip at %#x\n", sio_name, *addr);
+	sio_data->sioreg =3D sioaddr;
+
+	return 0;
+}
+
+/*
+ * when Super-I/O functions move to a separate file, the Super-I/O
+ * bus will manage the lifetime of the device and this module will only ke=
ep
+ * track of the nct6775 driver. But since we platform_device_alloc(), we
+ * must keep track of the device
+ */
+static struct platform_device *pdev;
+
+static int __init sensors_nct6775_init(void)
+{
+	int err;
+	unsigned short address;
+	struct resource res;
+	struct nct6775_sio_data sio_data;
+
+	/*
+	 * initialize sio_data->kind and sio_data->sioreg.
+	 *
+	 * when Super-I/O functions move to a separate file, the Super-I/O
+	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
+	 * nct6775 hardware monitor, and call probe()
+	 */
+	if (nct6775_find(0x2e, &address, &sio_data) &&
+	    nct6775_find(0x4e, &address, &sio_data))
+		return -ENODEV;
+
+	err =3D platform_driver_register(&nct6775_driver);
+	if (err)
+		goto exit;
+
+	pdev =3D platform_device_alloc(DRVNAME, address);
+	if (!pdev) {
+		err =3D -ENOMEM;
+		pr_err("Device allocation failed\n");
+		goto exit_unregister;
+	}
+
+	err =3D platform_device_add_data(pdev, &sio_data,
+				       sizeof(struct nct6775_sio_data));
+	if (err) {
+		pr_err("Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+
+	memset(&res, 0, sizeof(res));
+	res.name =3D DRVNAME;
+	res.start =3D address + IOREGION_OFFSET;
+	res.end =3D address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
+	res.flags =3D IORESOURCE_IO;
+
+	err =3D acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit_device_put;
+
+	err =3D platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		pr_err("Device resource addition failed (%d)\n", err);
+		goto exit_device_put;
+	}
+
+	/* platform_device_add calls probe() */
+	err =3D platform_device_add(pdev);
+	if (err) {
+		pr_err("Device addition failed (%d)\n", err);
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(pdev);
+exit_unregister:
+	platform_driver_unregister(&nct6775_driver);
+exit:
+	return err;
+}
+
+static void __exit sensors_nct6775_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&nct6775_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
+MODULE_DESCRIPTION("NCT6775F/NCT6776F/NCT6779D driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_nct6775_init);
+module_exit(sensors_nct6775_exit);
--=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
