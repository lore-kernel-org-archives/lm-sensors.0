From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: adm1026 driver for 2.7.0
Message-Id: <3EAEB038.3080904@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304291729.05179.ebenard@free.fr>
In-Reply-To: <200304291729.05179.ebenard@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks,

Unfortunately, we've duplicated our efforts here.  I've already written an 
ADM1026 driver and was about to release it.  Did you check the new-drivers 
page before you started?

Also, your patch does not include the actual chip driver 
(kernel/chips/adm1026.c).  Did you write any documentation or other files that 
were not included with your patch?

I've attached my patch to 2.7.0.   It's also available at:

ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-adm1026-6.patch

Please send me your other driver files and I'll see if you've got something 
better than my code.

Thanks,
:v)

Eric BENARD / Free wrote:

> Hi, 
> 
> both these patches add adm1026 support to lm_sensors & i2c release 2.7.0.
> 
> TODO :
> - Alarms are not yet handled but this is planned for next release ;-)
> - sensord not yet changed.
> - computation in /etc/sensors.conf not all validated.
> 
> sample output :
> adm1026-i2c-0-2c
> Adapter: SMBus Via Pro adapter at 0500
> Algorithm: Non-I2C SMBus adapter
> +3.3V SB:  +3.34 V  (min =  +0.00 V, max =  +4.39 V)
> +3.3V MN:  +3.37 V  (min =  +0.00 V, max =  +4.39 V)
> +5V:       +5.10 V  (min =  +0.00 V, max =  +6.63 V)
> Vccp:      +1.46 V  (min =  +0.00 V, max =  +3.06 V)
> +12V:     +11.69 V  (min =  +0.00 V, max = +15.94 V)
> -12V:     -11.04 V  (min = -15.93 V, max =  +2.69 V)
> ain0:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
> ain1:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
> ain2:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
> ain3:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
> ain4:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
> ain5:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
> ain6:      +2.54 V  (min =  +0.00 V, max =  +2.55 V)
> ain7:      +0.02 V  (min =  +0.00 V, max =  +2.55 V)
> auxin0:    +1.86 V  (min =  +1.94 V, max =  +2.20 V)
> auxin1:    +0.00 V  (min =  +1.96 V, max =  +1.28 V)
> temp:      +31.0?C  (min =   +0?C, max =   +0?C) 0
> rtemp1:    +22.0?C  (min =  +10?C, max =  +13?C) 0
> rtemp2:    +12.8?C  (min =  +10?C, max =  +13?C) -1717986918
> fan0:     13200 RPM  (min = 16500 RPM)
> fan1:     9078 RPM  (min = 14318 RPM)
> fan2:     8551 RPM  (min = 14318 RPM)
> fan3:     9078 RPM  (min = 14318 RPM)
> fan4:     8551 RPM  (min = 14318 RPM)
> fan5:     8066 RPM  (min = 14318 RPM)
> fan6:     8385 RPM  (min = 14318 RPM)
> fan7:        0 RPM  (min =    0 RPM)
> 
> Regards
> Eric


-------------- next part --------------
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/CONTRIBUTORS lm_sensors-2.7.0.adm1026/CONTRIBUTORS
--- ../_relion1x/lm_sensors-2.7.0/CONTRIBUTORS	Sun Nov 17 11:44:46 2002
+++ lm_sensors-2.7.0.adm1026/CONTRIBUTORS	Mon Apr 14 21:58:40 2003
@@ -83,4 +83,6 @@
 * Vojtech Pavlik <vojtech@suse.cz>	
   Author of the i2c-amd8111 bus driver.
   Added support for amd8111 SMBus 1.0 controller to i2c-amd756.
+* Philip Pokorny <ppokorny@penguincomputing.com>
+  Author of the ADM1026 driver
 
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/README lm_sensors-2.7.0.adm1026/README
--- ../_relion1x/lm_sensors-2.7.0/README	Wed Nov 20 18:18:41 2002
+++ lm_sensors-2.7.0.adm1026/README	Mon Apr 14 21:57:01 2003
@@ -60,8 +60,8 @@
 
 
 At least the following hardware sensor chips are supported:
-  Analog Devices ADM1021, ADM1021A, ADM1022,
-                 ADM1023, ADM1024, ADM1025, and ADM9240
+  Analog Devices ADM1021, ADM1021A, ADM1022, ADM1023,
+                 ADM1024, ADM1025, ADM1026 and ADM9240
   Asus AS99127F, ASB100 Bach
   Dallas Semiconductor DS75, DS1621, DS1625, DS1775, and DS1780
   Hewlett Packard Maxilife (several revisions including '99 NBA)
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/doc/chips/SUMMARY lm_sensors-2.7.0.adm1026/doc/chips/SUMMARY
--- ../_relion1x/lm_sensors-2.7.0/doc/chips/SUMMARY	Mon Nov 25 16:58:19 2002
+++ lm_sensors-2.7.0.adm1026/doc/chips/SUMMARY	Thu Mar 20 23:16:04 2003
@@ -63,6 +63,9 @@
 adm1025
 	adm1025		2	6	-	-	yes	no
 
+adm1026
+	adm1026		3	17	8	2 pwm+dac yes	no
+
 adm9240
 	adm9240		1	6	2	1 dac	yes	no
 	ds1780		1	6	2	1 dac	yes	no
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/doc/chips/adm1026 lm_sensors-2.7.0.adm1026/doc/chips/adm1026
--- ../_relion1x/lm_sensors-2.7.0/doc/chips/adm1026	Wed Dec 31 16:00:00 1969
+++ lm_sensors-2.7.0.adm1026/doc/chips/adm1026	Tue Apr 22 22:00:56 2003
@@ -0,0 +1,217 @@
+Kernel driver `adm1026.o'
+===========
+
+Status: In development
+
+Supported chips:
+  * Analog Devices ADM1026
+    Prefix `adm1026'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
+Author: Philip Pokorny <ppokorny@penguincomputing.com>
+	for Penguin Computing
+
+
+Module Parameters
+-----------------
+
+* force: short array (min = 1, max = 48)
+  List of adapter,address pairs to boldly assume to be present
+* force_adm1026: short array (min = 1, max = 48)
+  List of adapter,address pairs which are unquestionably assumed to contain
+  an `adm1026' chip
+* ignore: short array (min = 1, max = 48)
+  List of adapter,address pairs not to scan
+* ignore_range: short array (min = 1, max = 48)
+  List of adapter,start-addr,end-addr triples not to scan
+* probe: short array (min = 1, max = 48)
+  List of adapter,address pairs to scan additionally
+* probe_range: short array (min = 1, max = 48)
+  List of adapter,start-addr,end-addr triples to scan additionally
+
+The following only apply to the first ADM1026 detected.  These are a
+workaround for if your BIOS hasn't setup your chip.
+
+* gpio_input: int array (min = 1, max = 17)
+  List of GPIO pins (0-16) to program as inputs
+* gpio_output: int array (min = 1, max = 17)
+  List of GPIO pins (0-16) to program as outputs
+* gpio_inverted: int array (min = 1, max = 17)
+  List of GPIO pins (0-16) to program as inverted
+* gpio_normal: int array (min = 1, max = 17)
+  List of GPIO pins (0-16) to program as normal/non-inverted
+* gpio_fan: int array (min = 1, max = 8)
+  List of GPIO pins (0-7) to program as fan tachs
+
+
+Description
+-----------
+
+This driver implements support for the Analog Devices ADM1026.  Analog
+Devices calls it a "complete thermal system management controller."  
+
+The ADM1026 implements three (3) temperature sensors, 17 voltage
+sensors, 16 general purpose digital I/O lines, eight (8) fan speed
+sensors (8-bit), an analog output and a PWM output along with limit,
+alarm and mask bits for all of the above.  There is even 8k bytes of
+EEPROM memory on chip.
+
+Temperatures are measured in degrees Celcius.  There are two external
+sensor inputs and one internal sensor.  Each sensor has a high and low
+limit.  If the limit is exceeded, an interrupt (#SMBALERT) can be
+generated.  The interrupts can be masked.  In addition, there are
+over-temp limits for each sensor.  If this limit is exceeded, the
+#THERM output will be asserted.  The current temperature and limits
+have a resolution of 1 degree.
+
+FAN rotation speeds are reported in RPM (rotations per minute) but
+measured in counts of a 22.5kHz internal clock.  Each fan has a high
+limit which corresponds to a minimum fan speed.  If the limit is
+exceeded, an interrupt can be generated.  Each fan can be programmed
+to divide the reference clock by 1, 2, 4 or 8.  Not all RPM values can
+accurately be represented, so some rounding is done. With a divider of
+8, the slowest measureable speed of a one pulse per rev fan is 1323
+RPM.  Two pulse per rev fans can be measured as slow as 661 RPM.
+
+Voltage sensors (in0 to in16) report their values in volts.  An alarm
+is triggered if the voltage has crossed a programmable minimum or
+maximum limit.  Note that minimum in this case always means 'closest
+to zero'; this is important for negative voltage measurements.
+Several inputs have integrated attenuators so they can measure higher
+voltages directly.  3.3V, 5V, 12V, -12V and battery voltage all have
+dedicated inputs.  There are several inputs scaled to 0-3V full-scale
+range for SCSI terminator power.  The remaining inputs are not scaled
+and have a 0-2.5V full-scale range.  A 2.5V or 1.82V reference voltage
+is provided for negative voltage measurements.
+
+If an alarm triggers, it will remain triggered until the hardware
+register is read at least once. This means that the cause for the
+alarm may already have disappeared!  Note that in the current
+implementation, all hardware registers are read whenever any data is
+read (unless it is less than 2.0 seconds since the last update). This
+means that you can easily miss once-only alarms.
+
+The ADM1026 measures continuously.  Analog inputs are measured about 4
+times a second.  Fan speed measurement time depends on fan speed and
+divisor.  It can take as long as 1.5 seconds to measure all fan
+speeds.
+
+The ADM1026 has the ability to automaticaly control fan speed based on
+the temperature sensor inputs.  Both the PWM output and the DAC output
+can be used to control fan speed.  Usually only one of these two
+outputs will be used.  Write the minimum PWM or DAC value to the
+appropriate control register.  Then set the low temperature limit in
+the tmin values for each temperature sensor.  The range of control is
+fixed at 20 degC, and the largest difference between current and tmin
+of the temperature sensors sets the control output.  See the datasheet
+for several example circuits for controlling fan speed with the PWM
+and DAC outputs.  The fan speed sensors do not have PWM compensation,
+so it is probably best to control the fan voltage from the power
+lead rather than on the ground lead.
+
+The datasheet shows an example application with VID signals attached
+to GPIO lines.  Unfortunately, the chip may not be connected to the
+VID lines in this way.  The driver assumes that the chips *is*
+connected this way to get a vid voltage.  If the VID value is wrong or
+not wired as shown in the example, then you will need to write the
+correct VID value to the driver either based on the GPIO values or
+setting it directly.  The value written to VID should be the *raw* VID
+value (0 to 0x3f) or -1 (to restore the default value).  When read,
+the vid interface returns the scaled voltage according to the VRM spec
+selected.
+
+Example sensors.conf
+--------------------
+
+Here is an example sensors.conf configuration section for the ADM1026.
+
+--------- cut here ---------
+chip "adm1026-*"
+
+# Voltage inputs
+   label in0   "V2.25_0"    # Scaled for "SCSI terminator"?
+   label in1   "V2.25_1"    #   supply voltage?
+   label in2   "V2.25_2"
+   label in3   "V2.25_3"
+   label in4   "V2.25_4"
+   label in5   "V2.25_5"
+
+   label in6   "V1.875_0"   # Unscaled inputs
+   label in7   "V1.875_1"
+
+# If temp3 is enabled, in8 and in9 are disabled.
+#   label in8   "V1.875_2"
+#   label in9   "V1.875_3"
+   ignore in8
+   ignore in9
+
+# Dedicated voltage inputs
+   label in10   "Vbat"
+   label in11   "V3.3STBY"
+   label in12   "V3.3MAIN"
+   label in13   "V5"
+   label in14   "Vccp"
+   label in15   "V12"
+   label in16   "V-12"
+
+# Temperature inputs
+   label temp1  "Board"
+   label temp2  "CPU0"
+   label temp3  "CPU1"
+
+# Fan inputs
+   label fan0   "CPU_Fan"
+   label fan1   "Fan1"
+   label fan2   "Fan2"
+   label fan3   "Fan3"
+   label fan4   "Fan4"
+   label fan5   "Fan5"
+   label fan6   "Fan6"
+   label fan7   "Fan7"
+
+# PWM Outputs
+   label pwm   "PWM"
+
+# Voltage scaling is done on-chip.  No 'compute' directive
+#    should be necessary.  If in0-in9 have external scaling,
+#    set it here.
+
+#   compute in0  @ * 2.5,   @ / 2.5
+
+# Adjust fans speeds for actual pulses per rev
+#   compute fan0  @ / 2,  @ * 2    # 2 pulse per rev
+#   compute fan1  @ / 3,  @ * 3    # 3 pulse per rev
+#   compute fan2  @ / 4,  @ * 4    # 4 pulse per rev
+#   compute fan3  @ / 8,  @ * 8    # 8 pulse per rev
+
+# Set VRM version
+   set vrm  9.1
+#   set vid  1.580
+
+# Set voltage limits
+   set in10_min  3.0 * 0.95
+   set in10_max  3.0 * 1.05
+   set in11_min  3.3 * 0.95
+   set in11_max  3.3 * 1.05
+   set in12_min  3.3 * 0.95
+   set in12_max  3.3 * 1.05
+   set in13_min  5.0 * 0.95
+   set in13_max  5.0 * 1.05
+# Uncomment if VID is wired or set above
+#   set in14_min  vid * 0.95
+#   set in14_max  vid * 1.05
+   set in15_min   12 * 0.95
+   set in15_max   12 * 1.05
+   set in16_min  -12 * 0.95
+   set in16_max  -12 * 1.05
+
+# Set Fan limits
+   set fan0_min  7000
+   set fan1_min  7000
+   set fan2_min  7000
+   set fan3_min  7000
+   set fan4_min  3000
+   set fan5_min  3000
+   set fan6_min  3000
+   set fan7_min  3000
+
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/kernel/chips/Module.mk lm_sensors-2.7.0.adm1026/kernel/chips/Module.mk
--- ../_relion1x/lm_sensors-2.7.0/kernel/chips/Module.mk	Sun Nov 10 11:52:44 2002
+++ lm_sensors-2.7.0.adm1026/kernel/chips/Module.mk	Fri Mar 21 08:26:28 2003
@@ -44,6 +44,9 @@
 ifneq ($(shell if grep -q '^CONFIG_SENSORS_ADM1025=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELCHIPSTARGETS += $(MODULE_DIR)/adm1025.o
 endif
+ifneq ($(shell if grep -q '^CONFIG_SENSORS_ADM1026=y' $(LINUX)/.config; then echo 1; fi),1)
+KERNELCHIPSTARGETS += $(MODULE_DIR)/adm1026.o
+endif
 ifneq ($(shell if grep -q '^CONFIG_SENSORS_ADM9240=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELCHIPSTARGETS += $(MODULE_DIR)/adm9240.o
 endif
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/kernel/chips/adm1026.c lm_sensors-2.7.0.adm1026/kernel/chips/adm1026.c
--- ../_relion1x/lm_sensors-2.7.0/kernel/chips/adm1026.c	Wed Dec 31 16:00:00 1969
+++ lm_sensors-2.7.0.adm1026/kernel/chips/adm1026.c	Wed Apr  9 16:25:28 2003
@@ -0,0 +1,1690 @@
+#define DEBUG 1
+/*
+    adm1026.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    CHANGELOG
+
+    2002-03-13   Initial development
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <linux/ioport.h>
+#include <linux/sysctl.h>
+#include <asm/errno.h>
+#include <asm/io.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include "version.h"
+#include "sensors.h"
+#include "sensors_vid.h"
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)) || \
+    (LINUX_VERSION_CODE = KERNEL_VERSION(2,3,0))
+#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
+#endif
+
+#ifndef THIS_MODULE
+#define THIS_MODULE NULL
+#endif
+
+#ifndef I2C_DRIVERID_ADM1026
+/* i2c-id.h hasn't been updated to assign us an ID.
+ * So...  Use a local ID from 0xf000 to 0xffff as
+ *    documented in i2c-id.h
+ */
+#define I2C_DRIVERID_ADM1026  (0xf126)
+#endif
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
+static unsigned int normal_isa[] = { SENSORS_ISA_END };
+static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(adm1026);
+
+static int gpio_input[17]  = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
+				-1. -1. -1. -1. -1. -1, -1, -1 };
+static int gpio_output[17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
+				-1. -1. -1. -1. -1. -1, -1, -1 };
+static int gpio_inverted[17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
+				-1. -1. -1. -1. -1. -1, -1, -1 };
+static int gpio_normal[17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
+				-1. -1. -1. -1. -1. -1, -1, -1 };
+static int gpio_fan[8] = { -1, -1, -1, -1, -1, -1, -1, -1 };
+MODULE_PARM(gpio_input,"1-17i");
+MODULE_PARM_DESC(gpio_input,"List of GPIO pins (0-16) to program as inputs");
+MODULE_PARM(gpio_output,"1-17i");
+MODULE_PARM_DESC(gpio_output,"List of GPIO pins (0-16) to program as outputs");
+MODULE_PARM(gpio_inverted,"1-17i");
+MODULE_PARM_DESC(gpio_inverted,"List of GPIO pins (0-16) to program as inverted");
+MODULE_PARM(gpio_normal,"1-17i");
+MODULE_PARM_DESC(gpio_normal,"List of GPIO pins (0-16) to program as normal/non-inverted");
+MODULE_PARM(gpio_fan,"1-8i");
+MODULE_PARM_DESC(gpio_fan,"List of GPIO pins (0-7) to program as fan tachs");
+
+/* Many ADM1026 constants specified below */
+
+/* The ADM1026 registers */
+#define ADM1026_REG_CONFIG1  (0x00)
+#define CFG1_MONITOR     (0x01)
+#define CFG1_INT_ENABLE  (0x02)
+#define CFG1_INT_CLEAR   (0x04)
+#define CFG1_AIN8_9      (0x08)
+#define CFG1_THERM_HOT   (0x10)
+#define CFG1_DAC_AFC     (0x20)
+#define CFG1_PWM_AFC     (0x40)
+#define CFG1_RESET       (0x80)
+#define ADM1026_REG_CONFIG2  (0x01)
+/* CONFIG2 controls FAN0/GPIO0 through FAN7/GPIO7 */
+#define ADM1026_REG_CONFIG3  (0x07)
+#define CFG3_GPIO16_ENABLE  (0x01)
+#define CFG3_CI_CLEAR  (0x02)
+#define CFG3_VREF_250  (0x04)
+#define CFG3_GPIO16_DIR  (0x40)
+#define CFG3_GPIO16_POL  (0x80)
+#define ADM1026_REG_E2CONFIG  (0x13)
+#define E2CFG_READ  (0x01)
+#define E2CFG_WRITE  (0x02)
+#define E2CFG_ERASE  (0x04)
+#define E2CFG_ROM  (0x08)
+#define E2CFG_CLK_EXT  (0x80)
+
+/* There are 10 general analog inputs and 7 dedicated inputs
+ * They are:
+ *    0 - 9  =  AIN0 - AIN9
+ *       10  =  Vbat
+ *       11  =  3.3V Standby
+ *       12  =  3.3V Main
+ *       13  =  +5V
+ *       14  =  Vccp (CPU core voltage)
+ *       15  =  +12V
+ *       16  =  -12V
+ */
+static u16 REG_IN[] = {
+		0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
+		0x36, 0x37, 0x27, 0x29, 0x26, 0x2a,
+		0x2b, 0x2c, 0x2d, 0x2e, 0x2f
+	};
+static u16 REG_IN_MIN[] = {
+		0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d,
+		0x5e, 0x5f, 0x6d, 0x49, 0x6b, 0x4a,
+		0x4b, 0x4c, 0x4d, 0x4e, 0x4f
+	};
+static u16 REG_IN_MAX[] = {
+		0x50, 0x51, 0x52, 0x53, 0x54, 0x55,
+		0x56, 0x57, 0x6c, 0x41, 0x6a, 0x42,
+		0x43, 0x44, 0x45, 0x46, 0x47
+	};
+#define ADM1026_REG_IN(nr) (REG_IN[(nr)])
+#define ADM1026_REG_IN_MIN(nr) (REG_IN_MIN[(nr)])
+#define ADM1026_REG_IN_MAX(nr) (REG_IN_MAX[(nr)])
+
+/* Temperatures are:
+ *    0 - Internal
+ *    1 - External 1
+ *    2 - External 2
+ */
+static u16 REG_TEMP[] = { 0x1f, 0x28, 0x29 };
+static u16 REG_TEMP_MIN[] = { 0x69, 0x48, 0x49 };
+static u16 REG_TEMP_MAX[] = { 0x68, 0x40, 0x41 };
+static u16 REG_TEMP_TMIN[] = { 0x10, 0x11, 0x12 };
+static u16 REG_TEMP_THERM[] = { 0x0d, 0x0e, 0x0f };
+static u16 REG_TEMP_OFFSET[] = { 0x1e, 0x6e, 0x6f };
+#define ADM1026_REG_TEMP(nr) (REG_TEMP[(nr)])
+#define ADM1026_REG_TEMP_MIN(nr) (REG_TEMP_MIN[(nr)])
+#define ADM1026_REG_TEMP_MAX(nr) (REG_TEMP_MAX[(nr)])
+#define ADM1026_REG_TEMP_TMIN(nr) (REG_TEMP_TMIN[(nr)])
+#define ADM1026_REG_TEMP_THERM(nr) (REG_TEMP_THERM[(nr)])
+#define ADM1026_REG_TEMP_OFFSET(nr) (REG_TEMP_OFFSET[(nr)])
+
+#define ADM1026_REG_FAN(nr) (0x38 + (nr))
+#define ADM1026_REG_FAN_MIN(nr) (0x60 + (nr))
+#define ADM1026_REG_FAN_DIV_0_3 (0x02)
+#define ADM1026_REG_FAN_DIV_4_7 (0x03)
+
+#define ADM1026_REG_DAC  (0x04)
+#define ADM1026_REG_PWM  (0x05)
+
+#define ADM1026_REG_GPIO_CFG_0_3 (0x08)
+#define ADM1026_REG_GPIO_CFG_4_7 (0x09)
+#define ADM1026_REG_GPIO_CFG_8_11 (0x0a)
+#define ADM1026_REG_GPIO_CFG_12_15 (0x0b)
+/* CFG_16 in REG_CFG3 */
+#define ADM1026_REG_GPIO_STATUS_0_7 (0x24)
+#define ADM1026_REG_GPIO_STATUS_8_15 (0x25)
+/* STATUS_16 in REG_STATUS4 */
+#define ADM1026_REG_GPIO_MASK_0_7 (0x1c)
+#define ADM1026_REG_GPIO_MASK_8_15 (0x1d)
+/* MASK_16 in REG_MASK4 */
+
+#define ADM1026_REG_COMPANY 0x16
+#define ADM1026_REG_VERSTEP 0x17
+/* These are the recognized values for the above regs */
+#define ADM1026_COMPANY_ANALOG_DEV 0x41
+#define ADM1026_VERSTEP_GENERIC 0x40
+#define ADM1026_VERSTEP_ADM1026 0x44
+
+#define ADM1026_REG_MASK1 0x18
+#define ADM1026_REG_MASK2 0x19
+#define ADM1026_REG_MASK3 0x1a
+#define ADM1026_REG_MASK4 0x1b
+
+#define ADM1026_REG_STATUS1 0x20
+#define ADM1026_REG_STATUS2 0x21
+#define ADM1026_REG_STATUS3 0x22
+#define ADM1026_REG_STATUS4 0x23
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG 
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+ */
+
+/* IN are scaled acording to built-in resistors.  These are the
+ *   voltages corresponding to 3/4 of full scale (192 or 0xc0)
+ *   NOTE: The -12V input will need an additional factor to
+ *      account for the Vref pullup resistor.
+ */
+#if 1
+/* The values in this table are based on Table II, page 15 of the
+ *    datasheet.
+ */
+static int adm1026_scaling[] = {  /* .001 Volts */
+		2250, 2250, 2250, 2250, 2250, 2250, 
+		1875, 1875, 1875, 1875, 3000, 3330, 
+		3330, 4995, 2250, 12000, 13875
+	};
+#define NEG12_OFFSET  16000
+#else
+/* The values in this table are based on the resistors in 
+ *    Figure 5 on page 16.  But the 3.3V inputs are not in
+ *    the figure and the values for the 5V input are wrong.
+ *    For 5V, I'm guessing that R2 at 55.2k is right, but
+ *    the total resistance should be 1400 or 1449 like the
+ *    other inputs.  Using 1449, gives 4.922V at 192.
+ */
+static int adm1026_scaling[] = {  /* .001 Volts */
+		2249, 2249, 2249, 2249, 2249, 2249, 
+		1875, 1875, 1875, 1875, 3329, 3329, 
+		3329, 4922, 2249, 11969, 13889
+	};
+#define NEG12_OFFSET  16019
+#endif
+
+#define SCALE(val,from,to) (((val)*(to) + ((from)/2))/(from))
+#define INS_TO_REG(n,val)  (SENSORS_LIMIT(SCALE(val,adm1026_scaling[n],192),0,255))
+#if 0   /* If we have extended A/D bits */
+#define INSEXT_FROM_REG(n,val,ext) (SCALE((val)*4 + (ext),192*4,adm1026_scaling[n]))
+#define INS_FROM_REG(n,val) (INSEXT_FROM_REG(n,val,0))
+#else
+#define INS_FROM_REG(n,val) (SCALE(val,192,adm1026_scaling[n]))
+#endif
+
+/* FAN speed is measured using 22.5kHz clock and counts for 2 pulses
+ *      22500 * 60 * 2 = 2700000
+ */
+#define FAN_TO_REG(val,div)  (SENSORS_LIMIT((val)<=0 ? 0 : 2700000/((val)*(div)),0,255))
+#define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=0xff ? 0 : 2700000/((val)*(div)))
+#define DIV_FROM_REG(val) (1<<(val))
+#define DIV_TO_REG(val) ((val)>7 ? 3 : (val)>3 ? 2 : (val)>1 ? 1 : 0)
+
+/* Temperature is reported in 1 degC increments */
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(val,-127,127))
+#define TEMP_FROM_REG(val) (val)
+#define OFFSET_TO_REG(val) (SENSORS_LIMIT(val,-127,127))
+#define OFFSET_FROM_REG(val) (val)
+
+#define PWM_TO_REG(val) (SENSORS_LIMIT(val,0,255))
+#define PWM_FROM_REG(val) (val)
+
+/* Analog output is a voltage, but it's used like a PWM
+ *   Seems like this should be scaled, but to be consistent
+ *   with other drivers, we do it this way.
+ */
+#define DAC_TO_REG(val) (SENSORS_LIMIT(val,0,255))
+#define DAC_FROM_REG(val) (val)
+
+/* sensors_vid.h defines vid_from_reg() */
+#define VID_FROM_REG(val,vrm) (vid_from_reg(val,vrm))
+
+#define ALARMS_FROM_REG(val) (val)
+
+/* Unlike some other drivers we DO NOT set initial limits.  Use
+ * the config file to set limits.
+ */
+
+/* Typically used with systems using a v9.1 VRM spec ? */
+#define ADM1026_INIT_VRM  91
+#define ADM1026_INIT_VID  -1
+
+/* Chip sampling rates
+ *
+ * Some sensors are not updated more frequently than once per second
+ *    so it doesn't make sense to read them more often than that.
+ *    We cache the results and return the saved data if the driver
+ *    is called again before a second has elapsed.
+ *
+ * Also, there is significant configuration data for this chip
+ *    So, we keep the config data up to date in the cache
+ *    when it is written and only sample it once every 5 *minutes*
+ */
+#define ADM1026_DATA_INTERVAL  (1 * HZ)
+#define ADM1026_CONFIG_INTERVAL  (5 * 60 * HZ)
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+/* We allow for multiple chips in a single system.
+ *
+ * For each registered ADM1026, we need to keep state information
+ * at adm1026_list[NR]->data. The structure itself is dynamically
+ * allocated, when a new client structure is allocated. */
+
+struct adm1026_data {
+	struct semaphore lock;
+	int sysctl_id;
+	enum chips type;
+
+	struct semaphore update_lock;
+	int valid;		/* !=0 if following fields are valid */
+	unsigned long last_reading;	/* In jiffies */
+	unsigned long last_config;	/* In jiffies */
+
+	u8 in[17];		/* Register value */
+	u8 in_max[17];		/* Register value */
+	u8 in_min[17];		/* Register value */
+	s8 temp[3];		/* Register value */
+	s8 temp_min[3];		/* Register value */
+	s8 temp_max[3];		/* Register value */
+	s8 temp_tmin[3];	/* Register value */
+	s8 temp_therm[3];	/* Register value */
+	s8 temp_offset[3];	/* Register value */
+	u8 fan[8];		/* Register value */
+	u8 fan_min[8];		/* Register value */
+	u8 fan_div[8];		/* Decoded value */
+	u8 pwm;			/* Register value */
+	u8 analog_out;		/* Register value */
+	int vid;		/* Decoded value */
+	u8 vrm;			/* VRM version */
+	long alarms;		/* Register encoding, combined */
+	long alarm_mask;	/* Register encoding, combined */
+	long gpio;		/* Register encoding, combined */
+	long gpio_mask;		/* Register encoding, combined */
+	u8 gpio_config[17];	/* Decoded value */
+	u8 config1;		/* Register value */
+	u8 config2;		/* Register value */
+	u8 config3;		/* Register value */
+};
+
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init sensors_adm1026_init(void);
+static int __init adm1026_cleanup(void);
+
+static int adm1026_attach_adapter(struct i2c_adapter *adapter);
+static int adm1026_detect(struct i2c_adapter *adapter, int address,
+			unsigned short flags, int kind);
+static int adm1026_detach_client(struct i2c_client *client);
+static int adm1026_command(struct i2c_client *client, unsigned int cmd,
+			void *arg);
+static void adm1026_inc_use(struct i2c_client *client);
+static void adm1026_dec_use(struct i2c_client *client);
+
+static int adm1026_read_value(struct i2c_client *client, u8 register);
+static int adm1026_write_value(struct i2c_client *client, u8 register, int value);
+static void adm1026_fixup_gpio(struct i2c_client *client);
+static void adm1026_update_client(struct i2c_client *client);
+static void adm1026_init_client(struct i2c_client *client);
+
+
+static void adm1026_in(struct i2c_client *client, int operation, int ctl_name,
+			int *nrels_mag, long *results);
+static void adm1026_in16(struct i2c_client *client, int operation, int ctl_name,
+			int *nrels_mag, long *results);
+static void adm1026_fan(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_fan_div(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_temp(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_temp_offset(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_temp_tmin(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_temp_therm(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_vid(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_vrm(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_alarms(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_alarm_mask(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_gpio(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_gpio_mask(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_pwm(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_analog_out(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void adm1026_afc(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+
+static struct i2c_driver adm1026_driver = {
+	/* name */ "ADM1026 compatible sensor driver",
+	/* id */ I2C_DRIVERID_ADM1026,
+	/* flags */ I2C_DF_NOTIFY,
+	/* attach_adapter */ &adm1026_attach_adapter,
+	/* detach_client */ &adm1026_detach_client,
+	/* command */ &adm1026_command,
+	/* inc_use */ &adm1026_inc_use,
+	/* dec_use */ &adm1026_dec_use
+};
+
+/* Unique ID assigned to each ADM1026 detected */
+static int adm1026_id = 0;
+
+/* The /proc/sys entries */
+/* These files are created for each detected ADM1026. This is just a template;
+ *    The actual list is built from this and additional per-chip
+ *    custom lists below.  Note the XXX_LEN macros.  These must be
+ *    compile time constants because they will be used to allocate
+ *    space for the final template passed to i2c_register_entry.
+ *    We depend on the ability of GCC to evaluate expressions at
+ *    compile time to turn these expressions into compile time
+ *    constants, but this can generate a warning.
+ */
+static ctl_table adm1026_common[] = {
+	{ADM1026_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN9, "in9", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN10, "in10", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN11, "in11", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN12, "in12", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN13, "in13", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN14, "in14", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN15, "in15", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in},
+	{ADM1026_SYSCTL_IN16, "in16", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_in16},
+
+	{ADM1026_SYSCTL_FAN0, "fan0", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN4, "fan4", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN5, "fan5", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN6, "fan6", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN7, "fan7", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_fan},
+	{ADM1026_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_fan_div},
+
+	{ADM1026_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_temp},
+	{ADM1026_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_temp},
+	{ADM1026_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_temp},
+	{ADM1026_SYSCTL_TEMP_OFFSET1, "temp1_offset", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_offset},
+	{ADM1026_SYSCTL_TEMP_OFFSET2, "temp2_offset", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_offset},
+	{ADM1026_SYSCTL_TEMP_OFFSET3, "temp3_offset", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_offset},
+	{ADM1026_SYSCTL_TEMP_TMIN1, "temp1_tmin", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_tmin},
+	{ADM1026_SYSCTL_TEMP_TMIN2, "temp2_tmin", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_tmin},
+	{ADM1026_SYSCTL_TEMP_TMIN3, "temp3_tmin", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_tmin},
+	{ADM1026_SYSCTL_TEMP_THERM1, "temp1_therm", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_therm},
+	{ADM1026_SYSCTL_TEMP_THERM2, "temp2_therm", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_therm},
+	{ADM1026_SYSCTL_TEMP_THERM3, "temp3_therm", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_temp_therm},
+
+	{ADM1026_SYSCTL_VID, "vid", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_vid},
+	{ADM1026_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_vrm},
+
+	{ADM1026_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_alarms},
+	{ADM1026_SYSCTL_ALARM_MASK, "alarm_mask", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_alarm_mask},
+
+	{ADM1026_SYSCTL_GPIO, "gpio", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_gpio},
+	{ADM1026_SYSCTL_GPIO_MASK, "gpio_mask", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_gpio_mask},
+
+	{ADM1026_SYSCTL_PWM, "pwm", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_pwm},
+	{ADM1026_SYSCTL_ANALOG_OUT, "analog_out", NULL, 0, 0644, NULL,
+		&i2c_proc_real, &i2c_sysctl_real, NULL, &adm1026_analog_out},
+	{ADM1026_SYSCTL_AFC, "afc", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &adm1026_afc},
+
+	{0}
+};
+#define CTLTBL_COMMON (sizeof(adm1026_common)/sizeof(adm1026_common[0]))
+
+#define MAX2(a,b) ((a)>(b)?(a):(b))
+#define MAX3(a,b,c) ((a)>(b)?MAX2((a),(c)):MAX2((b),(c)))
+#define MAX4(a,b,c,d) ((a)>(b)?MAX3((a),(c),(d)):MAX3((b),(c),(d)))
+
+#define CTLTBL_MAX (CTLTBL_COMMON)
+
+/* This function is called when:
+     * the module is loaded
+     * a new adapter is loaded
+ */
+int adm1026_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, adm1026_detect);
+}
+
+/* This function is called by i2c_detect */
+int adm1026_detect(struct i2c_adapter *adapter, int address,
+		unsigned short flags, int kind)
+{
+	int i;
+	int company, verstep ;
+	struct i2c_client *new_client;
+	struct adm1026_data *data;
+	int err = 0;
+	const char *type_name = "";
+	struct ctl_table template[CTLTBL_MAX] ;
+	struct ctl_table * template_next = template ;
+
+	if (i2c_is_isa_adapter(adapter)) {
+		/* This chip has no ISA interface */
+		goto ERROR0 ;
+	}
+
+	if (!i2c_check_functionality(adapter,
+					I2C_FUNC_SMBUS_BYTE_DATA)) {
+		/* We need to be able to do byte I/O */
+		goto ERROR0 ;
+	}
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access adm1026_{read,write}_value. */
+
+	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
+				   sizeof(struct adm1026_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+
+	data = (struct adm1026_data *) (new_client + 1);
+	new_client->addr = address;
+	new_client->data = data;
+	new_client->adapter = adapter;
+	new_client->driver = &adm1026_driver;
+	new_client->flags = 0;
+
+	/* Now, we do the remaining detection. */
+
+	company = adm1026_read_value(new_client, ADM1026_REG_COMPANY) & 0xff;
+	verstep = adm1026_read_value(new_client, ADM1026_REG_VERSTEP) & 0xff;
+
+#ifdef DEBUG
+	printk("adm1026: Detecting device at %d,0x%02x with"
+		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+		i2c_adapter_id(new_client->adapter), new_client->addr,
+		company, verstep
+	    );
+#endif
+
+	/* If auto-detecting, Determine the chip type. */
+	if (kind <= 0) {
+#ifdef DEBUG
+		printk("adm1026: Autodetecting device at %d,0x%02x ...\n",
+			i2c_adapter_id(adapter), address );
+#endif
+		if( company = ADM1026_COMPANY_ANALOG_DEV
+		    && verstep = ADM1026_VERSTEP_ADM1026 ) {
+			kind = adm1026 ;
+		} else if( company = ADM1026_COMPANY_ANALOG_DEV
+		    && (verstep & 0xf0) = ADM1026_VERSTEP_GENERIC ) {
+			printk("adm1026: Unrecgonized stepping 0x%02x"
+			    " Defaulting to ADM1026.\n", verstep );
+			kind = adm1026 ;
+		} else if( (verstep & 0xf0) = ADM1026_VERSTEP_GENERIC ) {
+			printk("adm1026: Found version/stepping 0x%02x"
+			    " Assuming generic ADM1026.\n", verstep );
+			kind = any_chip ;
+		} else {
+#ifdef DEBUG
+			printk("adm1026: Autodetection failed\n");
+#endif
+			/* Not an ADM1026 ... */
+			if( kind = 0 ) {  /* User used force=x,y */
+			    printk("adm1026: Generic ADM1026 Version 6 not"
+				" found at %d,0x%02x. Try force_adm1026.\n",
+				i2c_adapter_id(adapter), address );
+			}
+			err = 0 ;
+			goto ERROR1;
+		}
+	}
+
+	/* Fill in the chip specific driver values */
+	switch (kind) {
+	case any_chip :
+		type_name = "adm1026";
+		strcpy(new_client->name, "Generic ADM1026");
+		template_next = template ;  /* None used */
+		break ;
+	case adm1026 :
+		type_name = "adm1026";
+		strcpy(new_client->name, "Analog Devices ADM1026");
+		template_next = template ;
+		break ;
+#if 0
+	case adx1000 :
+		type_name = "adx1000";
+		strcpy(new_client->name, "Compatible ADX1000");
+		memcpy( template, adx_specific, sizeof(adx_specific) );
+		template_next = template + CTLTBL_ADX1000 ;
+		break ;
+#endif
+	default :
+		printk("adm1026: Internal error, invalid kind (%d)!", kind);
+		err = -EFAULT ;
+		goto ERROR1;
+	}
+
+	/* Fill in the remaining client fields */
+	new_client->id = adm1026_id++;
+	printk("adm1026(%d): Assigning ID %d to %s at %d,0x%02x\n",
+		new_client->id, new_client->id, new_client->name,
+		i2c_adapter_id(new_client->adapter),
+		new_client->addr
+	    );
+
+	/* Housekeeping values */
+	data->type = kind;
+	data->valid = 0;
+
+	/* Set the VRM version */
+	data->vrm = ADM1026_INIT_VRM ;
+	data->vid = ADM1026_INIT_VID ;
+
+	init_MUTEX(&data->update_lock);
+
+	/* Initialize the ADM1026 chip */
+	adm1026_init_client(new_client);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR1;
+
+	/* Finish out the template */
+	memcpy(template_next, adm1026_common, sizeof(adm1026_common));
+
+	/* Register a new directory entry with module sensors */
+	if ((i = i2c_register_entry(new_client,
+					type_name,
+					template,
+					THIS_MODULE)) < 0) {
+		err = i;
+		goto ERROR2;
+	}
+	data->sysctl_id = i;
+
+	return 0;
+
+	/* Error out and cleanup code */
+    ERROR2:
+	i2c_detach_client(new_client);
+    ERROR1:
+	kfree(new_client);
+    ERROR0:
+	return err;
+}
+
+int adm1026_detach_client(struct i2c_client *client)
+{
+	int err;
+	int id ;
+
+	id = client->id;
+	i2c_deregister_entry(((struct adm1026_data *)(client->data))->sysctl_id);
+
+	if ((err = i2c_detach_client(client))) {
+		printk("adm1026(%d): Client deregistration failed,"
+			" client not detached.\n", id );
+		return err;
+	}
+
+	kfree(client);
+
+	return 0;
+}
+
+/* No commands defined yet */
+int adm1026_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	return 0;
+}
+
+/* Nothing here yet */
+void adm1026_inc_use(struct i2c_client *client)
+{
+	MOD_INC_USE_COUNT;
+}
+
+/* Nothing here yet */
+void adm1026_dec_use(struct i2c_client *client)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+
+int adm1026_read_value(struct i2c_client *client, u8 reg)
+{
+	int res;
+
+	if( reg < 0x80 ) {
+		/* "RAM" locations */
+		res = i2c_smbus_read_byte_data(client, reg);
+	} else {
+		/* EEPROM, do nothing */
+		res = 0 ;
+	}
+
+	return res ;
+}
+
+int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
+{
+	int res ;
+
+	if( reg < 0x80 ) {
+		/* "RAM" locations */
+		res = i2c_smbus_write_byte_data(client, reg, value);
+	} else {
+		/* EEPROM, do nothing */
+		res = 0 ;
+	}
+
+	return res ;
+}
+
+/* Called when we have found a new ADM1026. */
+void adm1026_init_client(struct i2c_client *client)
+{
+	int value ;
+	int i;
+	struct adm1026_data *data = client->data;
+
+#ifdef DEBUG
+	printk("adm1026(%d): Initializing device\n", client->id);
+#endif
+
+	/* Read chip config */
+	data->config1 = adm1026_read_value(client, ADM1026_REG_CONFIG1);
+	data->config2 = adm1026_read_value(client, ADM1026_REG_CONFIG2);
+	data->config3 = adm1026_read_value(client, ADM1026_REG_CONFIG3);
+
+	/* Inform user of chip config */
+#ifdef DEBUG
+	printk("adm1026(%d): ADM1026_REG_CONFIG1 is: 0x%02x\n",
+		client->id, data->config1 );
+#endif
+	if( (data->config1 & CFG1_MONITOR) = 0 ) {
+		printk("adm1026(%d): Monitoring not currently enabled.\n",
+			    client->id );
+	}
+	if( data->config1 & CFG1_INT_ENABLE ) {
+		printk("adm1026(%d): SMBALERT interrupts are enabled.\n",
+			    client->id );
+	}
+	if( data->config1 & CFG1_AIN8_9 ) {
+		printk("adm1026(%d): in8 and in9 enabled.  temp2 disabled.\n",
+			    client->id );
+	} else {
+		printk("adm1026(%d): temp2 enabled.  in8 and in9 disabled.\n",
+			    client->id );
+	}
+	if( data->config1 & CFG1_THERM_HOT ) {
+		printk("adm1026(%d): Automatic THERM, PWM, and temp limits enabled.\n",
+			    client->id );
+	}
+
+	/* Read/parse the existing GPIO configuration */
+	printk("adm1026(%d): GPIO config is:\nadm1026(%d):",
+			    client->id, client->id );
+	for( i = 0, value = 0 ; i <= 15 ; ++i ) {
+		if( (i & 0x03) = 0 ) {
+			value = adm1026_read_value(client,
+					ADM1026_REG_GPIO_CFG_0_3 + i/4 );
+		}
+		data->gpio_config[i] = value & 0x03 ;
+		printk( " %s%s%d",
+			data->gpio_config[i] & 0x02 ? "" : "!",
+			data->gpio_config[i] & 0x01 ? "OUT" : "IN",
+			i );
+		if( i = 8 ) {
+			printk( "\nadm1026(%d):", client->id );
+		}
+		value >>= 2 ;
+	}
+	data->gpio_config[16] = (data->config3 >> 6) & 0x03 ;
+	printk( " %s%s16\n",
+		data->gpio_config[16] & 0x02 ? "" : "!",
+		data->gpio_config[16] & 0x01 ? "OUT" : "IN" );
+
+	printk("adm1026(%d): GPIO/Fan config is:\nadm1026(%d):",
+			    client->id, client->id );
+	for( i = 0, value = data->config2 ; i <= 7 ; ++i, value >>= 1 ) {
+		if( value & 0x01 ) {
+			printk(" GPIO%d", i);
+		} else {
+			printk(" FAN%d", i);
+		}
+	}
+	printk("\n");
+
+	value = data->config3 ;
+	if( data->config3 & CFG3_GPIO16_ENABLE ) {
+		printk("adm1026(%d): GPIO16 enabled.  THERM pin disabled.\n",
+			    client->id );
+	} else {
+		printk("adm1026(%d): THERM pin enabled.  GPIO16 disabled.\n",
+			    client->id );
+	}
+	if( data->config3 & CFG3_VREF_250 ) {
+		printk("adm1026(%d): Vref is 2.50 Volts.\n", client->id );
+	} else {
+		printk("adm1026(%d): Vref is 1.82 Volts.\n", client->id );
+	}
+
+	/* If the user asks us to reprogram the GPIO config, then
+	 *   do it now.  But only if this is the first ADM1026.
+	 */
+	if( client->id = 0
+	    && (gpio_input[0] != -1 || gpio_output[0] != -1
+		|| gpio_inverted[0] != -1 || gpio_normal[0] != -1
+		|| gpio_fan[0] != -1 ) ) {
+		adm1026_fixup_gpio(client);
+	}
+
+	/* WE INTENTIONALLY make no changes to the limits,
+	 *   offsets, pwms, fans and zones.  If they were
+	 *   configured, we don't want to mess with them.
+	 *   If they weren't, the default is generally safe
+	 *   and will suffice until 'sensors -s' can be run.
+	 */
+
+	/* Start monitoring */
+	value = adm1026_read_value(client, ADM1026_REG_CONFIG1);
+
+	/* Set MONITOR, clear interrupt acknowledge and s/w reset */
+	value = (value | CFG1_MONITOR) & (~CFG1_INT_CLEAR & ~CFG1_RESET) ;
+#ifdef DEBUG
+	printk("adm1026(%d): Setting CONFIG to: 0x%02x\n", client->id, value );
+#endif
+	data->config1 = value ;
+	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+}
+
+void adm1026_fixup_gpio(struct i2c_client *client)
+{
+	struct adm1026_data *data = client->data;
+	int  i ;
+	int  value ;
+
+	/* Make the changes requested. */
+	/* We may need to unlock/stop monitoring or soft-reset the
+	 *    chip before we can make changes.  This hasn't been
+	 *    tested much.  FIXME
+	 */
+
+	/* Make outputs */
+	for( i = 0 ; i <= 16 ; ++i ) {
+		if( gpio_output[i] >= 0 && gpio_output[i] <= 16 ) {
+			data->gpio_config[gpio_output[i]] |= 0x01 ;
+		}
+		/* if GPIO0-7 is output, it isn't a FAN tach */
+		if( gpio_output[i] >= 0 && gpio_output[i] <= 7 ) {
+			data->config2 |= 1 << gpio_output[i] ;
+		}
+	}
+
+	/* Input overrides output */
+	for( i = 0 ; i <= 16 ; ++i ) {
+		if( gpio_input[i] >= 0 && gpio_input[i] <= 16 ) {
+			data->gpio_config[gpio_input[i]] &= ~ 0x01 ;
+		}
+		/* if GPIO0-7 is input, it isn't a FAN tach */
+		if( gpio_input[i] >= 0 && gpio_input[i] <= 7 ) {
+			data->config2 |= 1 << gpio_input[i] ;
+		}
+	}
+
+	/* Inverted  */
+	for( i = 0 ; i <= 16 ; ++i ) {
+		if( gpio_inverted[i] >= 0 && gpio_inverted[i] <= 16 ) {
+			data->gpio_config[gpio_inverted[i]] |=  0x02 ;
+		}
+	}
+
+	/* Normal overrides inverted  */
+	for( i = 0 ; i <= 16 ; ++i ) {
+		if( gpio_normal[i] >= 0 && gpio_normal[i] <= 16 ) {
+			data->gpio_config[gpio_normal[i]] &= ~ 0x02 ;
+		}
+	}
+
+	/* Fan overrides input and output */
+	for( i = 0 ; i <= 7 ; ++i ) {
+		if( gpio_fan[i] >= 0 && gpio_fan[i] <= 7 ) {
+			data->config2 &= ~( 1 << gpio_fan[i] );
+		}
+	}
+
+	/* Write new configs to registers */
+	adm1026_write_value(client, ADM1026_REG_CONFIG2, data->config2);
+	data->config3 = (data->config3 & 0x3f)
+			| ((data->gpio_config[16] & 0x03) << 6) ;
+	adm1026_write_value(client, ADM1026_REG_CONFIG3, data->config3);
+	for( i = 15, value = 0 ; i >= 0 ; --i ) {
+		value <<= 2 ;
+		value |= data->gpio_config[i] & 0x03 ;
+		if( (i & 0x03) = 0 ) {
+			adm1026_write_value(client,
+					ADM1026_REG_GPIO_CFG_0_3 + i/4,
+					value );
+			value = 0 ;
+		}
+	}
+
+	/* We should probably print the new config here.  FIXME */
+}
+
+void adm1026_update_client(struct i2c_client *client)
+{
+	struct adm1026_data *data = client->data;
+	int i;
+	long value, alarms, gpio ;
+
+	down(&data->update_lock);
+
+	if (!data->valid
+	    || (jiffies - data->last_reading > ADM1026_DATA_INTERVAL )) {
+		/* Things that change quickly */
+
+#ifdef DEBUG
+		printk("adm1026(%d): Reading sensor values\n", client->id);
+#endif
+		for (i = 0 ; i <= 16 ; ++i) {
+			data->in[i] +			    adm1026_read_value(client, ADM1026_REG_IN(i));
+		}
+
+		for (i = 0 ; i <= 7 ; ++i) {
+			data->fan[i] +			    adm1026_read_value(client, ADM1026_REG_FAN(i));
+		}
+
+		for (i = 0 ; i <= 2 ; ++i) {
+			data->temp[i] +			    adm1026_read_value(client, ADM1026_REG_TEMP(i));
+		}
+
+		data->pwm = adm1026_read_value(client, ADM1026_REG_PWM);
+		data->analog_out = adm1026_read_value(client, ADM1026_REG_DAC);
+
+		/* GPIO16 is MSbit of alarms, move it to gpio */
+		alarms  = adm1026_read_value(client, ADM1026_REG_STATUS4);
+		gpio = alarms & 0x80 ? 0x0100 : 0 ;  /* GPIO16 */
+		alarms &= 0x7f ;
+		alarms <<= 8 ;
+		alarms |= adm1026_read_value(client, ADM1026_REG_STATUS3) & 0xff;
+		alarms <<= 8 ;
+		alarms |= adm1026_read_value(client, ADM1026_REG_STATUS2) & 0xff;
+		alarms <<= 8 ;
+		alarms |= adm1026_read_value(client, ADM1026_REG_STATUS1) & 0xff;
+		data->alarms = alarms ;
+
+		/* Read the GPIO values */
+		gpio |= adm1026_read_value(client, ADM1026_REG_GPIO_STATUS_8_15) & 0xff;
+		gpio <<= 8 ;
+		gpio |= adm1026_read_value(client, ADM1026_REG_GPIO_STATUS_0_7) & 0xff;
+		data->gpio = gpio ;
+
+		data->last_reading = jiffies ;
+	};  /* last_reading */
+
+	if (!data->valid
+	    || (jiffies - data->last_config > ADM1026_CONFIG_INTERVAL) ) {
+		/* Things that don't change often */
+
+#ifdef DEBUG
+		printk("adm1026(%d): Reading config values\n", client->id);
+#endif
+		for (i = 0 ; i <= 16 ; ++i) {
+			data->in_min[i] +			    adm1026_read_value(client, ADM1026_REG_IN_MIN(i));
+			data->in_max[i] +			    adm1026_read_value(client, ADM1026_REG_IN_MAX(i));
+		}
+
+		value = (adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) & 0xff)
+			| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
+		for (i = 0 ; i <= 7 ; ++i) {
+			data->fan_min[i] +			    adm1026_read_value(client, ADM1026_REG_FAN_MIN(i));
+			data->fan_div[i] = 1 << (value & 0x03);
+			value >>= 2 ;
+		}
+
+		for (i = 0; i <= 2; ++i) {
+			data->temp_min[i] +			    adm1026_read_value(client, ADM1026_REG_TEMP_MIN(i));
+			data->temp_max[i] +			    adm1026_read_value(client, ADM1026_REG_TEMP_MAX(i));
+			data->temp_tmin[i] +			    adm1026_read_value(client, ADM1026_REG_TEMP_TMIN(i));
+			data->temp_therm[i] +			    adm1026_read_value(client, ADM1026_REG_TEMP_THERM(i));
+			data->temp_offset[i] +			    adm1026_read_value(client, ADM1026_REG_TEMP_OFFSET(i));
+		}
+
+		/* Read the STATUS/alarm masks */
+		alarms  = adm1026_read_value(client, ADM1026_REG_MASK4);
+		gpio    = alarms & 0x80 ? 0x0100 : 0 ;  /* GPIO16 */
+		alarms  = (alarms & 0x7f) << 8 ;
+		alarms |= adm1026_read_value(client, ADM1026_REG_MASK3) & 0xff;
+		alarms <<= 8 ;
+		alarms |= adm1026_read_value(client, ADM1026_REG_MASK2) & 0xff;
+		alarms <<= 8 ;
+		alarms |= adm1026_read_value(client, ADM1026_REG_MASK1) & 0xff;
+		data->alarm_mask = alarms ;
+
+		/* Read the GPIO values */
+		gpio |= adm1026_read_value(client, ADM1026_REG_GPIO_MASK_8_15) & 0xff;
+		gpio <<= 8 ;
+		gpio |= adm1026_read_value(client, ADM1026_REG_GPIO_MASK_0_7) & 0xff;
+		data->gpio_mask = gpio ;
+
+		/* Read the GPIO config */
+		data->config2 = adm1026_read_value(client, ADM1026_REG_CONFIG2);
+		data->config3 = adm1026_read_value(client, ADM1026_REG_CONFIG3);
+		data->gpio_config[16] = (data->config3 >> 6) & 0x03 ;
+
+		for( i = 0 ; i <= 15 ; ++i ) {
+			if( (i & 0x03) = 0 ) {
+				value = adm1026_read_value(client,
+					    ADM1026_REG_GPIO_CFG_0_3 + i/4 );
+			}
+			data->gpio_config[i] = value & 0x03 ;
+			value >>= 2 ;
+		}
+
+		data->last_config = jiffies;
+	};  /* last_config */
+
+	/* We don't know where or even _if_ the VID might be on the GPIO
+	 *    pins.  But the datasheet gives an example config showing
+	 *    GPIO11-15 being used to monitor VID0-4, so we go with that
+	 *    but make the vid WRITEABLE so if it's wrong, the user can
+	 *    set it in /etc/sensors.conf perhaps using an expression or
+	 *    0 to trigger a re-read from the GPIO pins.
+	 */
+	if( data->vid = ADM1026_INIT_VID ) {
+		/* Hasn't been set yet, make a bold assumption */
+		printk("adm1026(%d): Setting VID from GPIO11-15.\n",
+			    client->id );
+		data->vid = (data->gpio >> 11) & 0x1f ;
+	}
+	
+	data->valid = 1;
+
+	up(&data->update_lock);
+}
+
+
+/* The following functions are the call-back functions of the /proc/sys and
+   sysctl files.  Which function is used is defined in the ctl_table in
+   the extra1 field.
+   Each function must return the magnitude (power of 10 to divide the data
+   with) if it is called with operation=SENSORS_PROC_REAL_INFO.  It must
+   put a maximum of *nrels elements in results reflecting the data of this
+   file, and set *nrels to the number it actually put in it, if operation=
+   SENSORS_PROC_REAL_READ.  Finally, it must get upto *nrels elements from
+   results and write them to the chip, if operations=SENSORS_PROC_REAL_WRITE.
+ */
+void adm1026_in(struct i2c_client *client, int operation, int ctl_name,
+	     int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_IN0;
+
+	/* We handle in0 - in15 here.  in16 (-12V) is handled below */
+	if (nr < 0 || nr > 15)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 3;  /* 1.000 */
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = INS_FROM_REG(nr,data->in_min[nr]);
+		results[1] = INS_FROM_REG(nr,data->in_max[nr]);
+		results[2] = INS_FROM_REG(nr,data->in[nr]);
+		*nrels_mag = 3;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 1) {
+			data->in_max[nr] = INS_TO_REG(nr,results[1]);
+			adm1026_write_value(client, ADM1026_REG_IN_MAX(nr),
+					 data->in_max[nr]);
+		}
+		if (*nrels_mag > 0) {
+			data->in_min[nr] = INS_TO_REG(nr,results[0]);
+			adm1026_write_value(client, ADM1026_REG_IN_MIN(nr),
+					 data->in_min[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_in16(struct i2c_client *client, int operation, int ctl_name,
+	     int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_IN0;
+
+	/* We handle in16 (-12V) here */
+	if (nr != 16)
+		return ;  /* ERROR */
+
+	/* Apply offset and swap min/max so that min is 90% of
+	 *    target and max is 110% of target.
+	 */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 3;  /* 1.000 */
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = INS_FROM_REG(nr,data->in_max[nr])-NEG12_OFFSET ;
+		results[1] = INS_FROM_REG(nr,data->in_min[nr])-NEG12_OFFSET ;
+		results[2] = INS_FROM_REG(nr,data->in[nr])-NEG12_OFFSET ;
+		*nrels_mag = 3;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 1) {
+			data->in_min[nr] = INS_TO_REG(nr,results[1]+NEG12_OFFSET);
+			adm1026_write_value(client, ADM1026_REG_IN_MIN(nr),
+					 data->in_min[nr]);
+		}
+		if (*nrels_mag > 0) {
+			data->in_max[nr] = INS_TO_REG(nr,results[0]+NEG12_OFFSET);
+			adm1026_write_value(client, ADM1026_REG_IN_MAX(nr),
+					 data->in_max[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_fan(struct i2c_client *client, int operation, int ctl_name,
+	      int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_FAN0 ;
+
+	if (nr < 0 || nr > 7)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = FAN_FROM_REG(data->fan_min[nr], data->fan_div[nr]);
+		results[1] = FAN_FROM_REG(data->fan[nr], data->fan_div[nr]);
+		*nrels_mag = 2;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->fan_min[nr] = FAN_TO_REG(results[0],
+							data->fan_div[nr]);
+			adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
+					 data->fan_min[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_fan_div(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int i ;
+	long value, div ;
+
+	if (ctl_name != ADM1026_SYSCTL_FAN_DIV)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		for( i = 0 ; i <= 7 ; ++i ) {
+			results[i] = data->fan_div[i] ;
+		}
+		*nrels_mag = 8;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		value = 0 ;
+		for( i = 7 ; i >= 0 ; --i ) {
+			value <<= 2 ;
+			if (*nrels_mag > i) {
+				div = DIV_TO_REG(results[i]) ;
+				data->fan_div[i] = DIV_FROM_REG(div) ;
+			} else {
+				div = DIV_TO_REG(data->fan_div[i]) ;
+			}
+			value |= div ;
+		}
+		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
+			value & 0xff);
+		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
+			(value >> 8) & 0xff);
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_temp(struct i2c_client *client, int operation, int ctl_name,
+	       int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_TEMP1 ;
+
+	if (nr < 0 || nr > 2)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = TEMP_FROM_REG(data->temp_min[nr]);
+		results[1] = TEMP_FROM_REG(data->temp_max[nr]);
+		results[2] = TEMP_FROM_REG(data->temp[nr]);
+		*nrels_mag = 3;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 1) {
+			data->temp_max[nr] = TEMP_TO_REG(results[1]);
+			adm1026_write_value(client, ADM1026_REG_TEMP_MAX(nr),
+					 data->temp_max[nr]);
+		}
+		if (*nrels_mag > 0) {
+			data->temp_min[nr] = TEMP_TO_REG(results[0]);
+			adm1026_write_value(client, ADM1026_REG_TEMP_MIN(nr),
+					 data->temp_min[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_temp_offset(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_TEMP_OFFSET1 ;
+
+	if (nr < 0 || nr > 2)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = TEMP_FROM_REG(data->temp_offset[nr]);
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->temp_offset[nr] = TEMP_TO_REG(results[0]);
+			adm1026_write_value(client, ADM1026_REG_TEMP_OFFSET(nr),
+			    data->temp_offset[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_temp_tmin(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_TEMP_TMIN1 ;
+
+	if (nr < 0 || nr > 2)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = TEMP_FROM_REG(data->temp_tmin[nr]);
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->temp_tmin[nr] = TEMP_TO_REG(results[0]);
+			adm1026_write_value(client, ADM1026_REG_TEMP_TMIN(nr),
+			    data->temp_tmin[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_temp_therm(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	int nr = ctl_name - ADM1026_SYSCTL_TEMP_THERM1 ;
+
+	if (nr < 0 || nr > 2)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = TEMP_FROM_REG(data->temp_therm[nr]);
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->temp_therm[nr] = TEMP_TO_REG(results[0]);
+			adm1026_write_value(client, ADM1026_REG_TEMP_THERM(nr),
+			    data->temp_therm[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_pwm(struct i2c_client *client, int operation, int ctl_name,
+	      int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+
+	if (ctl_name != ADM1026_SYSCTL_PWM)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = PWM_FROM_REG(data->pwm);
+		results[1] = 1 ;  /* Always enabled */
+		*nrels_mag = 2;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		/* PWM enable is read-only */
+		if (*nrels_mag > 0) {
+			data->pwm = PWM_TO_REG(results[0]);
+			adm1026_write_value(client, ADM1026_REG_PWM,
+					 data->pwm);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_analog_out(struct i2c_client *client, int operation, int ctl_name,
+	      int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+
+	if (ctl_name != ADM1026_SYSCTL_ANALOG_OUT)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;  /* 0 - 255 */
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = DAC_FROM_REG(data->analog_out);
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->analog_out = DAC_TO_REG(results[0]);
+			adm1026_write_value(client, ADM1026_REG_DAC,
+					 data->analog_out);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_afc(struct i2c_client *client, int operation, int ctl_name,
+	      int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+
+	if (ctl_name != ADM1026_SYSCTL_AFC)
+		return ;  /* ERROR */
+
+	/* PWM auto fan control, DAC auto fan control */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = (data->config1 & CFG1_PWM_AFC) != 0 ;
+		results[1] = (data->config1 & CFG1_DAC_AFC) != 0 ;
+		*nrels_mag = 2;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 1) {
+			data->config1 = (data->config1 & ~CFG1_DAC_AFC)
+				| (results[1] ? CFG1_DAC_AFC : 0) ;
+		}
+		if (*nrels_mag > 0) {
+			data->config1 = (data->config1 & ~CFG1_PWM_AFC)
+				| (results[0] ? CFG1_PWM_AFC : 0) ;
+			adm1026_write_value(client, ADM1026_REG_CONFIG1,
+					 data->config1);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_vid(struct i2c_client *client, int operation, int ctl_name,
+	      int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+
+	if( ctl_name != ADM1026_SYSCTL_VID )
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 3;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = VID_FROM_REG((data->vid)&0x3f,data->vrm);
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		/* Hmmm... There isn't a VID_TO_REG mapping */
+		if (*nrels_mag > 0) {
+			if( results[0] >= 0 ) {
+				data->vid = results[0] & 0x3f ;
+			} else {
+				data->vid = ADM1026_INIT_VID ;
+			}
+		}
+		up(&data->update_lock);
+	}
+
+}
+
+void adm1026_vrm(struct i2c_client *client, int operation, int ctl_name,
+	      int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+
+	if( ctl_name != ADM1026_SYSCTL_VRM )
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 1;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		results[0] = data->vrm ;
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag > 0) {
+			data->vrm = results[0] ;
+		}
+	}
+}
+
+void adm1026_alarms(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+
+	if( ctl_name != ADM1026_SYSCTL_ALARMS )
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = data->alarms ;
+		*nrels_mag = 1;
+	}
+	/* FIXME: Perhaps we should implement a write function
+	 *   to clear an alarm?
+	 */
+}
+
+void adm1026_alarm_mask(struct i2c_client *client, int operation,
+		int ctl_name, int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	unsigned long mask ;
+
+	if( ctl_name != ADM1026_SYSCTL_ALARM_MASK )
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = data->alarm_mask ;
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->alarm_mask = results[0] & 0x7fffffff ;
+			mask = data->alarm_mask
+				| (data->gpio_mask & 0x10000 ? 0x80000000 : 0) ;
+			adm1026_write_value(client, ADM1026_REG_MASK1,
+					mask & 0xff);
+			mask >>= 8 ;
+			adm1026_write_value(client, ADM1026_REG_MASK2,
+					mask & 0xff);
+			mask >>= 8 ;
+			adm1026_write_value(client, ADM1026_REG_MASK3,
+					mask & 0xff);
+			mask >>= 8 ;
+			adm1026_write_value(client, ADM1026_REG_MASK4,
+					mask & 0xff);
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_gpio(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	long gpio ;
+
+	if( ctl_name != ADM1026_SYSCTL_GPIO )
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = data->gpio ;
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->gpio = results[0] & 0x1ffff ;
+			gpio = data->gpio ;
+			adm1026_write_value(client,
+				ADM1026_REG_GPIO_STATUS_0_7,
+				gpio & 0xff );
+			gpio >>= 8 ;
+			adm1026_write_value(client,
+				ADM1026_REG_GPIO_STATUS_8_15,
+				gpio & 0xff );
+			gpio = ((gpio >> 1) & 0x80)
+				| (data->alarms >> 24 & 0x7f);
+			adm1026_write_value(client,
+				ADM1026_REG_STATUS4,
+				gpio & 0xff );
+		}
+		up(&data->update_lock);
+	}
+}
+
+void adm1026_gpio_mask(struct i2c_client *client, int operation,
+		int ctl_name, int *nrels_mag, long *results)
+{
+	struct adm1026_data *data = client->data;
+	long mask ;
+
+	if( ctl_name != ADM1026_SYSCTL_GPIO_MASK )
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		adm1026_update_client(client);
+		results[0] = data->gpio_mask ;
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 0) {
+			data->gpio_mask = results[0] & 0x1ffff ;
+			mask = data->gpio_mask ;
+			adm1026_write_value(client, ADM1026_REG_GPIO_MASK_0_7,
+					mask & 0xff);
+			mask >>= 8 ;
+			adm1026_write_value(client, ADM1026_REG_GPIO_MASK_8_15,
+					mask & 0xff);
+			mask = ((mask >> 1) & 0x80)
+				| (data->alarm_mask >> 24 & 0x7f);
+			adm1026_write_value(client, ADM1026_REG_MASK1,
+					mask & 0xff);
+		}
+		up(&data->update_lock);
+	}
+}
+
+static int __initdata adm1026_initialized = 0;
+
+int __init sensors_adm1026_init(void)
+{
+	int res;
+
+	printk("adm1026: Version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk("adm1026: See http://www.penguincomputing.com/lm_sensors for more info.\n" );
+	adm1026_initialized = 0;
+
+	if ((res = i2c_add_driver(&adm1026_driver))) {
+		printk("adm1026: Driver registration failed, module not inserted.\n");
+		adm1026_cleanup();
+		return res;
+	}
+	adm1026_initialized++;
+	return 0;
+}
+
+int __init adm1026_cleanup(void)
+{
+	int res;
+
+	if (adm1026_initialized >= 1) {
+		if ((res = i2c_del_driver(&adm1026_driver))) {
+			printk("adm1026: Driver deregistration failed, module not removed.\n");
+			return res;
+		}
+		adm1026_initialized--;
+	}
+	return 0;
+}
+
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com");
+MODULE_DESCRIPTION("ADM1026 driver");
+
+int init_module(void)
+{
+	return sensors_adm1026_init();
+}
+
+int cleanup_module(void)
+{
+	return adm1026_cleanup();
+}
+
+#endif				/* MODULE */
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/kernel/include/sensors.h lm_sensors-2.7.0.adm1026/kernel/include/sensors.h
--- ../_relion1x/lm_sensors-2.7.0/kernel/include/sensors.h	Fri Nov 15 18:02:44 2002
+++ lm_sensors-2.7.0.adm1026/kernel/include/sensors.h	Tue Apr  1 08:24:03 2003
@@ -269,6 +269,87 @@
 #define ADM1025_ALARM_RTEMP 0x0020
 #define ADM1025_ALARM_TEMP 0x0010
 
+#define ADM1026_SYSCTL_FAN0                 1000
+#define ADM1026_SYSCTL_FAN1                 1001
+#define ADM1026_SYSCTL_FAN2                 1002
+#define ADM1026_SYSCTL_FAN3                 1003
+#define ADM1026_SYSCTL_FAN4                 1004
+#define ADM1026_SYSCTL_FAN5                 1005
+#define ADM1026_SYSCTL_FAN6                 1006
+#define ADM1026_SYSCTL_FAN7                 1007
+#define ADM1026_SYSCTL_FAN_DIV              1008
+#define ADM1026_SYSCTL_GPIO                 1009
+#define ADM1026_SYSCTL_GPIO_MASK            1010
+#define ADM1026_SYSCTL_ALARMS               1011
+#define ADM1026_SYSCTL_ALARM_MASK           1012
+#define ADM1026_SYSCTL_IN0                  1013
+#define ADM1026_SYSCTL_IN1                  1014
+#define ADM1026_SYSCTL_IN2                  1015
+#define ADM1026_SYSCTL_IN3                  1016
+#define ADM1026_SYSCTL_IN4                  1017
+#define ADM1026_SYSCTL_IN5                  1018
+#define ADM1026_SYSCTL_IN6                  1019
+#define ADM1026_SYSCTL_IN7                  1020
+#define ADM1026_SYSCTL_IN8                  1021
+#define ADM1026_SYSCTL_IN9                  1022
+#define ADM1026_SYSCTL_IN10                 1023
+#define ADM1026_SYSCTL_IN11                 1024
+#define ADM1026_SYSCTL_IN12                 1025
+#define ADM1026_SYSCTL_IN13                 1026
+#define ADM1026_SYSCTL_IN14                 1027
+#define ADM1026_SYSCTL_IN15                 1028
+#define ADM1026_SYSCTL_IN16                 1029
+#define ADM1026_SYSCTL_PWM                  1030
+#define ADM1026_SYSCTL_ANALOG_OUT           1031
+#define ADM1026_SYSCTL_AFC                  1032
+#define ADM1026_SYSCTL_TEMP1                1033
+#define ADM1026_SYSCTL_TEMP2                1034
+#define ADM1026_SYSCTL_TEMP3                1035
+#define ADM1026_SYSCTL_TEMP_OFFSET1         1036
+#define ADM1026_SYSCTL_TEMP_OFFSET2         1037
+#define ADM1026_SYSCTL_TEMP_OFFSET3         1038
+#define ADM1026_SYSCTL_TEMP_THERM1          1039
+#define ADM1026_SYSCTL_TEMP_THERM2          1040
+#define ADM1026_SYSCTL_TEMP_THERM3          1041
+#define ADM1026_SYSCTL_TEMP_TMIN1           1042
+#define ADM1026_SYSCTL_TEMP_TMIN2           1043
+#define ADM1026_SYSCTL_TEMP_TMIN3           1044
+#define ADM1026_SYSCTL_VID                  1045
+#define ADM1026_SYSCTL_VRM                  1046
+
+#define ADM1026_ALARM_TEMP2   (1L <<  0)
+#define ADM1026_ALARM_TEMP3   (1L <<  1)
+#define ADM1026_ALARM_IN9     (1L <<  1)
+#define ADM1026_ALARM_IN11    (1L <<  2)
+#define ADM1026_ALARM_IN12    (1L <<  3)
+#define ADM1026_ALARM_IN13    (1L <<  4)
+#define ADM1026_ALARM_IN14    (1L <<  5)
+#define ADM1026_ALARM_IN15    (1L <<  6)
+#define ADM1026_ALARM_IN16    (1L <<  7)
+#define ADM1026_ALARM_IN0     (1L <<  8)
+#define ADM1026_ALARM_IN1     (1L <<  9)
+#define ADM1026_ALARM_IN2     (1L << 10)
+#define ADM1026_ALARM_IN3     (1L << 11)
+#define ADM1026_ALARM_IN4     (1L << 12)
+#define ADM1026_ALARM_IN5     (1L << 13)
+#define ADM1026_ALARM_IN6     (1L << 14)
+#define ADM1026_ALARM_IN7     (1L << 15)
+#define ADM1026_ALARM_FAN0    (1L << 16)
+#define ADM1026_ALARM_FAN1    (1L << 17)
+#define ADM1026_ALARM_FAN2    (1L << 18)
+#define ADM1026_ALARM_FAN3    (1L << 19)
+#define ADM1026_ALARM_FAN4    (1L << 20)
+#define ADM1026_ALARM_FAN5    (1L << 21)
+#define ADM1026_ALARM_FAN6    (1L << 22)
+#define ADM1026_ALARM_FAN7    (1L << 23)
+#define ADM1026_ALARM_TEMP1   (1L << 24)
+#define ADM1026_ALARM_IN10    (1L << 25)
+#define ADM1026_ALARM_IN8     (1L << 26)
+#define ADM1026_ALARM_THERM   (1L << 27)
+#define ADM1026_ALARM_AFC_FAN (1L << 28)
+#define ADM1026_ALARM_UNUSED  (1L << 29)
+#define ADM1026_ALARM_CI      (1L << 30)
+
 #define LTC1710_SYSCTL_SWITCH_1 1000
 #define LTC1710_SYSCTL_SWITCH_2 1001
 
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/lib/chips.c lm_sensors-2.7.0.adm1026/lib/chips.c
--- ../_relion1x/lm_sensors-2.7.0/lib/chips.c	Sat Nov 16 11:08:55 2002
+++ lm_sensors-2.7.0.adm1026/lib/chips.c	Wed Apr  2 23:19:44 2003
@@ -1920,7 +1920,323 @@
                          SENSORS_MODE_R, ADM1025_SYSCTL_ALARMS, VALUE(1), 0 },
     { 0 }
   };
-  
+
+
+static sensors_chip_feature adm1026_features[] = {
+    { SENSORS_ADM1026_ALARMS, "alarms",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_ALARMS, VALUE(1), 0 },
+    { SENSORS_ADM1026_ALARM_MASK, "alarm_mask",
+		SENSORS_ADM1026_ALARMS, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_ALARM_MASK, VALUE(1), 0 },
+    { SENSORS_ADM1026_GPIO, "gpio",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_GPIO, VALUE(1), 0 },
+    { SENSORS_ADM1026_GPIO_MASK, "gpio_mask",
+		SENSORS_ADM1026_GPIO, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_GPIO_MASK, VALUE(1), 0 },
+    { SENSORS_ADM1026_VID, "vid",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_VID, VALUE(1), 3 },
+    { SENSORS_ADM1026_VRM, "vrm",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_VRM, VALUE(1), 1 },
+    { SENSORS_ADM1026_PWM, "pwm",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_PWM, VALUE(1), 0 },
+    { SENSORS_ADM1026_AFC_PWM, "afc_pwm",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_PWM, VALUE(1), 0 },
+    { SENSORS_ADM1026_DAC, "analog_out",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_ANALOG_OUT, VALUE(1), 0 },
+    { SENSORS_ADM1026_AFC_DAC, "afc_analog_out",
+		SENSORS_ADM1026_DAC, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_AFC, VALUE(2), 0 },
+
+    { SENSORS_ADM1026_IN0, "in0",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN0, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN0_MIN, "in0_min",
+		SENSORS_ADM1026_IN0, SENSORS_ADM1026_IN0, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN0, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN0_MAX, "in0_max",
+		SENSORS_ADM1026_IN0, SENSORS_ADM1026_IN0, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN0, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN1, "in1",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN1, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN1_MIN, "in1_min",
+		SENSORS_ADM1026_IN1, SENSORS_ADM1026_IN1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN1, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN1_MAX, "in1_max",
+		SENSORS_ADM1026_IN1, SENSORS_ADM1026_IN1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN1, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN2, "in2",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN2, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN2_MIN, "in2_min",
+		SENSORS_ADM1026_IN2, SENSORS_ADM1026_IN2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN2, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN2_MAX, "in2_max",
+		SENSORS_ADM1026_IN2, SENSORS_ADM1026_IN2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN2, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN3, "in3",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN3, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN3_MIN, "in3_min",
+		SENSORS_ADM1026_IN3, SENSORS_ADM1026_IN3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN3, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN3_MAX, "in3_max",
+		SENSORS_ADM1026_IN3, SENSORS_ADM1026_IN3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN3, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN4, "in4",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN4, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN4_MIN, "in4_min",
+		SENSORS_ADM1026_IN4, SENSORS_ADM1026_IN4, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN4, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN4_MAX, "in4_max",
+		SENSORS_ADM1026_IN4, SENSORS_ADM1026_IN4, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN4, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN5, "in5",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN5, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN5_MIN, "in5_min",
+		SENSORS_ADM1026_IN5, SENSORS_ADM1026_IN5, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN5, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN5_MAX, "in5_max",
+		SENSORS_ADM1026_IN5, SENSORS_ADM1026_IN5, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN5, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN6, "in6",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN6, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN6_MIN, "in6_min",
+		SENSORS_ADM1026_IN6, SENSORS_ADM1026_IN6, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN6, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN6_MAX, "in6_max",
+		SENSORS_ADM1026_IN6, SENSORS_ADM1026_IN6, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN6, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN7, "in7",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN7, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN7_MIN, "in7_min",
+		SENSORS_ADM1026_IN7, SENSORS_ADM1026_IN7, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN7, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN7_MAX, "in7_max",
+		SENSORS_ADM1026_IN7, SENSORS_ADM1026_IN7, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN7, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN8, "in8",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN8, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN8_MIN, "in8_min",
+		SENSORS_ADM1026_IN8, SENSORS_ADM1026_IN8, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN8, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN8_MAX, "in8_max",
+		SENSORS_ADM1026_IN8, SENSORS_ADM1026_IN8, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN8, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN9, "in9",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN9, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN9_MIN, "in9_min",
+		SENSORS_ADM1026_IN9, SENSORS_ADM1026_IN9, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN9, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN9_MAX, "in9_max",
+		SENSORS_ADM1026_IN9, SENSORS_ADM1026_IN9, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN9, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN10, "in10",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN10, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN10_MIN, "in10_min",
+		SENSORS_ADM1026_IN10, SENSORS_ADM1026_IN10, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN10, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN10_MAX, "in10_max",
+		SENSORS_ADM1026_IN10, SENSORS_ADM1026_IN10, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN10, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN11, "in11",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN11, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN11_MIN, "in11_min",
+		SENSORS_ADM1026_IN11, SENSORS_ADM1026_IN11, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN11, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN11_MAX, "in11_max",
+		SENSORS_ADM1026_IN11, SENSORS_ADM1026_IN11, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN11, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN12, "in12",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN12, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN12_MIN, "in12_min",
+		SENSORS_ADM1026_IN12, SENSORS_ADM1026_IN12, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN12, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN12_MAX, "in12_max",
+		SENSORS_ADM1026_IN12, SENSORS_ADM1026_IN12, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN12, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN13, "in13",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN13, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN13_MIN, "in13_min",
+		SENSORS_ADM1026_IN13, SENSORS_ADM1026_IN13, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN13, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN13_MAX, "in13_max",
+		SENSORS_ADM1026_IN13, SENSORS_ADM1026_IN13, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN13, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN14, "in14",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN14, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN14_MIN, "in14_min",
+		SENSORS_ADM1026_IN14, SENSORS_ADM1026_IN14, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN14, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN14_MAX, "in14_max",
+		SENSORS_ADM1026_IN14, SENSORS_ADM1026_IN14, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN14, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN15, "in15",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN15, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN15_MIN, "in15_min",
+		SENSORS_ADM1026_IN15, SENSORS_ADM1026_IN15, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN15, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN15_MAX, "in15_max",
+		SENSORS_ADM1026_IN15, SENSORS_ADM1026_IN15, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN15, VALUE(2), 3 },
+    { SENSORS_ADM1026_IN16, "in16",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_IN16, VALUE(3), 3 },
+    { SENSORS_ADM1026_IN16_MIN, "in16_min",
+		SENSORS_ADM1026_IN16, SENSORS_ADM1026_IN16, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN16, VALUE(1), 3 },
+    { SENSORS_ADM1026_IN16_MAX, "in16_max",
+		SENSORS_ADM1026_IN16, SENSORS_ADM1026_IN16, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_IN16, VALUE(2), 3 },
+    { SENSORS_ADM1026_FAN0, "fan0",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN0, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN0_MIN, "fan0_min",
+		SENSORS_ADM1026_FAN0, SENSORS_ADM1026_FAN0, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN0, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN0_DIV, "fan0_div",
+		SENSORS_ADM1026_FAN0, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN1, "fan1",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN1, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN1_MIN, "fan1_min",
+		SENSORS_ADM1026_FAN1, SENSORS_ADM1026_FAN1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN1, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN1_DIV, "fan1_div",
+		SENSORS_ADM1026_FAN1, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN2, "fan2",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN2, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN2_MIN, "fan2_min",
+		SENSORS_ADM1026_FAN2, SENSORS_ADM1026_FAN2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN2, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN2_DIV, "fan2_div",
+		SENSORS_ADM1026_FAN2, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(3), 0 },
+    { SENSORS_ADM1026_FAN3, "fan3",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN3, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN3_MIN, "fan3_min",
+		SENSORS_ADM1026_FAN3, SENSORS_ADM1026_FAN3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN3, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN3_DIV, "fan3_div",
+		SENSORS_ADM1026_FAN3, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(4), 0 },
+    { SENSORS_ADM1026_FAN4, "fan4",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN4, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN4_MIN, "fan4_min",
+		SENSORS_ADM1026_FAN4, SENSORS_ADM1026_FAN4, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN4, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN4_DIV, "fan4_div",
+		SENSORS_ADM1026_FAN4, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(5), 0 },
+    { SENSORS_ADM1026_FAN5, "fan5",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN5, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN5_MIN, "fan5_min",
+		SENSORS_ADM1026_FAN5, SENSORS_ADM1026_FAN5, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN5, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN5_DIV, "fan5_div",
+		SENSORS_ADM1026_FAN5, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(6), 0 },
+    { SENSORS_ADM1026_FAN6, "fan6",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN6, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN6_MIN, "fan6_min",
+		SENSORS_ADM1026_FAN6, SENSORS_ADM1026_FAN6, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN6, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN6_DIV, "fan6_div",
+		SENSORS_ADM1026_FAN6, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(7), 0 },
+    { SENSORS_ADM1026_FAN7, "fan7",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_FAN7, VALUE(2), 0 },
+    { SENSORS_ADM1026_FAN7_MIN, "fan7_min",
+		SENSORS_ADM1026_FAN7, SENSORS_ADM1026_FAN7, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN7, VALUE(1), 0 },
+    { SENSORS_ADM1026_FAN7_DIV, "fan7_div",
+		SENSORS_ADM1026_FAN7, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_FAN_DIV, VALUE(8), 0 },
+    { SENSORS_ADM1026_TEMP1, "temp1",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_TEMP1, VALUE(3), 0 },
+    { SENSORS_ADM1026_TEMP1_MIN, "temp1_min",
+		SENSORS_ADM1026_TEMP1, SENSORS_ADM1026_TEMP1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP1, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP1_MAX, "temp1_max",
+		SENSORS_ADM1026_TEMP1, SENSORS_ADM1026_TEMP1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP1, VALUE(2), 0 },
+    { SENSORS_ADM1026_TEMP1_OFFSET, "temp1_offset",
+		SENSORS_ADM1026_TEMP1, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_OFFSET1, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP1_TMIN, "temp1_tmin",
+		SENSORS_ADM1026_TEMP1, SENSORS_ADM1026_TEMP1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_TMIN1, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP1_THERM, "temp1_therm",
+		SENSORS_ADM1026_TEMP1, SENSORS_ADM1026_TEMP1, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_THERM1, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP2, "temp2",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_TEMP2, VALUE(3), 0 },
+    { SENSORS_ADM1026_TEMP2_MIN, "temp2_min",
+		SENSORS_ADM1026_TEMP2, SENSORS_ADM1026_TEMP2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP2, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP2_MAX, "temp2_max",
+		SENSORS_ADM1026_TEMP2, SENSORS_ADM1026_TEMP2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP2, VALUE(2), 0 },
+    { SENSORS_ADM1026_TEMP2_OFFSET, "temp2_offset",
+		SENSORS_ADM1026_TEMP2, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_OFFSET2, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP2_TMIN, "temp2_tmin",
+		SENSORS_ADM1026_TEMP2, SENSORS_ADM1026_TEMP2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_TMIN2, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP2_THERM, "temp2_therm",
+		SENSORS_ADM1026_TEMP2, SENSORS_ADM1026_TEMP2, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_THERM2, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP3, "temp3",
+		SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, SENSORS_MODE_R,
+		ADM1026_SYSCTL_TEMP3, VALUE(3), 0 },
+    { SENSORS_ADM1026_TEMP3_MIN, "temp3_min",
+		SENSORS_ADM1026_TEMP3, SENSORS_ADM1026_TEMP3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP3, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP3_MAX, "temp3_max",
+		SENSORS_ADM1026_TEMP3, SENSORS_ADM1026_TEMP3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP3, VALUE(2), 0 },
+    { SENSORS_ADM1026_TEMP3_OFFSET, "temp3_offset",
+		SENSORS_ADM1026_TEMP3, SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_OFFSET3, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP3_TMIN, "temp3_tmin",
+		SENSORS_ADM1026_TEMP3, SENSORS_ADM1026_TEMP3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_TMIN3, VALUE(1), 0 },
+    { SENSORS_ADM1026_TEMP3_THERM, "temp3_therm",
+		SENSORS_ADM1026_TEMP3, SENSORS_ADM1026_TEMP3, SENSORS_MODE_RW,
+		ADM1026_SYSCTL_TEMP_THERM3, VALUE(1), 0 },
+    { 0 }
+  };
+
+
 static sensors_chip_feature via686a_features[]    { 
     { SENSORS_VIA686A_IN0, "2.0V", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, 
@@ -3374,6 +3690,7 @@
 		/* Cheat on ADM1022 for now - no separate #defines */
  { SENSORS_ADM1022_PREFIX, thmc50_features },
  { SENSORS_ADM1025_PREFIX, adm1025_features },
+ { SENSORS_ADM1026_PREFIX, adm1026_features },
  { SENSORS_VIA686A_PREFIX, via686a_features },
  { SENSORS_DDCMON_PREFIX, ddcmon_features },
  { SENSORS_EEPROM_PREFIX, eeprom_features },
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/lib/chips.h lm_sensors-2.7.0.adm1026/lib/chips.h
--- ../_relion1x/lm_sensors-2.7.0/lib/chips.h	Sat Nov 16 10:23:54 2002
+++ lm_sensors-2.7.0.adm1026/lib/chips.h	Wed Apr  2 23:22:39 2003
@@ -768,6 +768,118 @@
 #define SENSORS_ADM1025_ALARMS 81 /* R */
 
 
+#define SENSORS_ADM1026_PREFIX "adm1026"
+/* NOTE: print_adm1026 (sensors) depends on the ordering
+ *    of these entries in each group.  For example
+ *         fan#, fan#_div, fan#_min
+ *         temp#, temp#_max, temp#_min, temp#_offset
+ *    and the ordering of the groups
+ *         in0, in1, ... in9, in10, in11
+ */
+#define SENSORS_ADM1026_AFC_DAC            1  /* RW -- afc_analog_out  */
+#define SENSORS_ADM1026_AFC_PWM            2  /* RW -- afc_pwm  */
+#define SENSORS_ADM1026_ALARMS             3  /* R  -- alarms  */
+#define SENSORS_ADM1026_ALARM_MASK         4  /* R  -- alarm_mask  */
+#define SENSORS_ADM1026_DAC                5  /* RW -- analog_out  */
+#define SENSORS_ADM1026_GPIO               6  /* R  -- gpio  */
+#define SENSORS_ADM1026_GPIO_MASK          7  /* R  -- gpio_mask  */
+#define SENSORS_ADM1026_PWM                8  /* RW -- pwm  */
+#define SENSORS_ADM1026_VID                9  /* RW -- vid  */
+#define SENSORS_ADM1026_VRM               10  /* RW -- vrm  */
+#define SENSORS_ADM1026_FAN0              11  /* R  -- fan0  */
+#define SENSORS_ADM1026_FAN0_DIV          12  /* RW -- fan0_div  */
+#define SENSORS_ADM1026_FAN0_MIN          13  /* RW -- fan0_min  */
+#define SENSORS_ADM1026_FAN1              14  /* R  -- fan1  */
+#define SENSORS_ADM1026_FAN1_DIV          15  /* RW -- fan1_div  */
+#define SENSORS_ADM1026_FAN1_MIN          16  /* RW -- fan1_min  */
+#define SENSORS_ADM1026_FAN2              17  /* R  -- fan2  */
+#define SENSORS_ADM1026_FAN2_DIV          18  /* RW -- fan2_div  */
+#define SENSORS_ADM1026_FAN2_MIN          19  /* RW -- fan2_min  */
+#define SENSORS_ADM1026_FAN3              20  /* R  -- fan3  */
+#define SENSORS_ADM1026_FAN3_DIV          21  /* RW -- fan3_div  */
+#define SENSORS_ADM1026_FAN3_MIN          22  /* RW -- fan3_min  */
+#define SENSORS_ADM1026_FAN4              23  /* R  -- fan4  */
+#define SENSORS_ADM1026_FAN4_DIV          24  /* RW -- fan4_div  */
+#define SENSORS_ADM1026_FAN4_MIN          25  /* RW -- fan4_min  */
+#define SENSORS_ADM1026_FAN5              26  /* R  -- fan5  */
+#define SENSORS_ADM1026_FAN5_DIV          27  /* RW -- fan5_div  */
+#define SENSORS_ADM1026_FAN5_MIN          28  /* RW -- fan5_min  */
+#define SENSORS_ADM1026_FAN6              29  /* R  -- fan6  */
+#define SENSORS_ADM1026_FAN6_DIV          30  /* RW -- fan6_div  */
+#define SENSORS_ADM1026_FAN6_MIN          31  /* RW -- fan6_min  */
+#define SENSORS_ADM1026_FAN7              32  /* R  -- fan7  */
+#define SENSORS_ADM1026_FAN7_DIV          33  /* RW -- fan7_div  */
+#define SENSORS_ADM1026_FAN7_MIN          34  /* RW -- fan7_min  */
+#define SENSORS_ADM1026_IN0               35  /* R  -- in0  */
+#define SENSORS_ADM1026_IN0_MAX           36  /* RW -- in0_max  */
+#define SENSORS_ADM1026_IN0_MIN           37  /* RW -- in0_min  */
+#define SENSORS_ADM1026_IN1               38  /* R  -- in1  */
+#define SENSORS_ADM1026_IN1_MAX           39  /* RW -- in1_max  */
+#define SENSORS_ADM1026_IN1_MIN           40  /* RW -- in1_min  */
+#define SENSORS_ADM1026_IN2               41  /* R  -- in2  */
+#define SENSORS_ADM1026_IN2_MAX           42  /* RW -- in2_max  */
+#define SENSORS_ADM1026_IN2_MIN           43  /* RW -- in2_min  */
+#define SENSORS_ADM1026_IN3               44  /* R  -- in3  */
+#define SENSORS_ADM1026_IN3_MAX           45  /* RW -- in3_max  */
+#define SENSORS_ADM1026_IN3_MIN           46  /* RW -- in3_min  */
+#define SENSORS_ADM1026_IN4               47  /* R  -- in4  */
+#define SENSORS_ADM1026_IN4_MAX           48  /* RW -- in4_max  */
+#define SENSORS_ADM1026_IN4_MIN           49  /* RW -- in4_min  */
+#define SENSORS_ADM1026_IN5               50  /* R  -- in5  */
+#define SENSORS_ADM1026_IN5_MAX           51  /* RW -- in5_max  */
+#define SENSORS_ADM1026_IN5_MIN           52  /* RW -- in5_min  */
+#define SENSORS_ADM1026_IN6               53  /* R  -- in6  */
+#define SENSORS_ADM1026_IN6_MAX           54  /* RW -- in6_max  */
+#define SENSORS_ADM1026_IN6_MIN           55  /* RW -- in6_min  */
+#define SENSORS_ADM1026_IN7               56  /* R  -- in7  */
+#define SENSORS_ADM1026_IN7_MAX           57  /* RW -- in7_max  */
+#define SENSORS_ADM1026_IN7_MIN           58  /* RW -- in7_min  */
+#define SENSORS_ADM1026_IN8               59  /* R  -- in8  */
+#define SENSORS_ADM1026_IN8_MAX           60  /* RW -- in8_max  */
+#define SENSORS_ADM1026_IN8_MIN           61  /* RW -- in8_min  */
+#define SENSORS_ADM1026_IN9               62  /* R  -- in9  */
+#define SENSORS_ADM1026_IN9_MAX           63  /* RW -- in9_max  */
+#define SENSORS_ADM1026_IN9_MIN           64  /* RW -- in9_min  */
+#define SENSORS_ADM1026_IN10              65  /* R  -- in10  */
+#define SENSORS_ADM1026_IN10_MAX          66  /* RW -- in10_max  */
+#define SENSORS_ADM1026_IN10_MIN          67  /* RW -- in10_min  */
+#define SENSORS_ADM1026_IN11              68  /* R  -- in11  */
+#define SENSORS_ADM1026_IN11_MAX          69  /* RW -- in11_max  */
+#define SENSORS_ADM1026_IN11_MIN          70  /* RW -- in11_min  */
+#define SENSORS_ADM1026_IN12              71  /* R  -- in12  */
+#define SENSORS_ADM1026_IN12_MAX          72  /* RW -- in12_max  */
+#define SENSORS_ADM1026_IN12_MIN          73  /* RW -- in12_min  */
+#define SENSORS_ADM1026_IN13              74  /* R  -- in13  */
+#define SENSORS_ADM1026_IN13_MAX          75  /* RW -- in13_max  */
+#define SENSORS_ADM1026_IN13_MIN          76  /* RW -- in13_min  */
+#define SENSORS_ADM1026_IN14              77  /* R  -- in14  */
+#define SENSORS_ADM1026_IN14_MAX          78  /* RW -- in14_max  */
+#define SENSORS_ADM1026_IN14_MIN          79  /* RW -- in14_min  */
+#define SENSORS_ADM1026_IN15              80  /* R  -- in15  */
+#define SENSORS_ADM1026_IN15_MAX          81  /* RW -- in15_max  */
+#define SENSORS_ADM1026_IN15_MIN          82  /* RW -- in15_min  */
+#define SENSORS_ADM1026_IN16              83  /* R  -- in16  */
+#define SENSORS_ADM1026_IN16_MAX          84  /* RW -- in16_max  */
+#define SENSORS_ADM1026_IN16_MIN          85  /* RW -- in16_min  */
+#define SENSORS_ADM1026_TEMP1             86  /* R  -- temp1  */
+#define SENSORS_ADM1026_TEMP1_MAX         87  /* RW -- temp1_max  */
+#define SENSORS_ADM1026_TEMP1_MIN         88  /* RW -- temp1_min  */
+#define SENSORS_ADM1026_TEMP1_OFFSET      89  /* RW -- temp1_offset  */
+#define SENSORS_ADM1026_TEMP1_THERM       90  /* RW -- temp1_therm  */
+#define SENSORS_ADM1026_TEMP1_TMIN        91  /* RW -- temp1_tmin  */
+#define SENSORS_ADM1026_TEMP2             92  /* R  -- temp2  */
+#define SENSORS_ADM1026_TEMP2_MAX         93  /* RW -- temp2_max  */
+#define SENSORS_ADM1026_TEMP2_MIN         94  /* RW -- temp2_min  */
+#define SENSORS_ADM1026_TEMP2_OFFSET      95  /* RW -- temp2_offset  */
+#define SENSORS_ADM1026_TEMP2_THERM       96  /* RW -- temp2_therm  */
+#define SENSORS_ADM1026_TEMP2_TMIN        97  /* RW -- temp2_tmin  */
+#define SENSORS_ADM1026_TEMP3             98  /* R  -- temp3  */
+#define SENSORS_ADM1026_TEMP3_MAX         99  /* RW -- temp3_max  */
+#define SENSORS_ADM1026_TEMP3_MIN        100  /* RW -- temp3_min  */
+#define SENSORS_ADM1026_TEMP3_OFFSET     101  /* RW -- temp3_offset  */
+#define SENSORS_ADM1026_TEMP3_THERM      102  /* RW -- temp3_therm  */
+#define SENSORS_ADM1026_TEMP3_TMIN       103  /* RW -- temp3_tmin  */
+
 
 #define SENSORS_VIA686A_PREFIX "via686a"
 
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/prog/detect/sensors-detect lm_sensors-2.7.0.adm1026/prog/detect/sensors-detect
--- ../_relion1x/lm_sensors-2.7.0/prog/detect/sensors-detect	Tue Nov 26 09:03:02 2002
+++ lm_sensors-2.7.0.adm1026/prog/detect/sensors-detect	Fri Mar 21 08:32:52 2003
@@ -713,7 +713,8 @@
             lm87_detect ite_detect ite_isa_detect ite_alias_detect
             ddcmonitor_detect ds1621_detect adm1024_detect fscpos_detect
             fscscy_detect pcf8591_detect arp_detect ipmi_kcs_detect
-            ipmi_smic_detect via8231_isa_detect lm85_detect smartbatt_detect);
+            ipmi_smic_detect via8231_isa_detect lm85_detect smartbatt_detect
+            adm1026_detect);
 
 # This is a list of all recognized chips. 
 # Each entry must have the following fields:
@@ -896,6 +897,12 @@
        i2c_detect => sub { adm9240_detect 2, @_ }
      },
      {
+       name => "Analog Devices ADM1026",
+       driver => "adm1026",
+       i2c_addrs => [0x2c,0x2d,0x2e],
+       i2c_detect => sub { adm1026_detect 0, @_ }
+     },
+     {
        name => "Analog Devices ADM1025",
        driver => "adm1025",
        i2c_addrs => [0x2c..0x2e],
@@ -2287,6 +2294,24 @@
   return (8);
 }
 
+# $_[0]: Chip to detect (0 = ADM1026)
+# $_[1]: A reference to the file descriptor to access this chip.
+#        We may assume an i2c_set_slave_addr was already done.
+# $_[2]: Address
+# Returns: undef if not detected, (8) if detected.
+# Registers used:
+#   0x16: Company ID
+#   0x17: Revision
+sub adm1026_detect
+{
+  my $reg;
+  my ($chip, $file,$addr) = @_;
+  $reg = i2c_smbus_read_byte_data($file,0x16);
+  return unless ($reg = 0x41);
+  return unless (i2c_smbus_read_byte_data($file,0x17) & 0xf0) = 0x40;
+  return (8);
+}
+
 # $_[0]: Chip to detect (0 = ADM1024)
 # $_[1]: A reference to the file descriptor to access this chip.
 #        We may assume an i2c_set_slave_addr was already done.
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/prog/sensors/chips.c lm_sensors-2.7.0.adm1026/prog/sensors/chips.c
--- ../_relion1x/lm_sensors-2.7.0/prog/sensors/chips.c	Thu Nov 28 09:05:47 2002
+++ lm_sensors-2.7.0.adm1026/prog/sensors/chips.c	Thu Apr  3 07:16:16 2003
@@ -3725,6 +3725,112 @@
   }	
 }
 
+static long adm1026_alarms_in[] = {
+  ADM1026_ALARM_IN0,  ADM1026_ALARM_IN1,  ADM1026_ALARM_IN2,
+  ADM1026_ALARM_IN3,  ADM1026_ALARM_IN4,  ADM1026_ALARM_IN5,
+  ADM1026_ALARM_IN6,  ADM1026_ALARM_IN7,  ADM1026_ALARM_IN8,
+  ADM1026_ALARM_IN9,  ADM1026_ALARM_IN10, ADM1026_ALARM_IN11,
+  ADM1026_ALARM_IN12, ADM1026_ALARM_IN13, ADM1026_ALARM_IN14,
+  ADM1026_ALARM_IN15, ADM1026_ALARM_IN16
+};
+static long adm1026_alarms_temp[] = {
+  ADM1026_ALARM_TEMP1,  ADM1026_ALARM_TEMP2,  ADM1026_ALARM_TEMP3
+};
+
+void print_adm1026(const sensors_chip_name *name)
+{
+  char *label = NULL;
+  double cur,min,max;
+  long alarms, gpio;
+  int valid, i;
+
+  if (!sensors_get_feature(*name,SENSORS_ADM1026_ALARMS,&cur)) {
+    alarms = cur + 0.5;
+  } else {
+    printf("ERROR: Can't get alarm data!\n");
+    alarms = 0;
+  }
+
+  /* Seventeen voltage sensors */
+  for (i = 0; i <= 16 ; ++i) {
+    int  feat_base = SENSORS_ADM1026_IN0 + (3 * i);
+    int  feat_max = feat_base +1, feat_min = feat_base +2;
+    if (!sensors_get_label_and_valid(*name,feat_base,&label,&valid) &&
+        !sensors_get_feature(*name,feat_base,&cur) &&
+        !sensors_get_feature(*name,feat_min,&min) &&
+        !sensors_get_feature(*name,feat_max,&max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
+               cur,min,max,(alarms&adm1026_alarms_in[i])?"ALARM":"");
+      }
+    } else {
+      printf("ERROR: Can't get IN%d data!\n",i);
+    }
+    free_the_label(&label);
+  };
+
+  /* Eight fan sensors */
+  for (i = 0; i <= 7 ; ++i) {
+    int  feat_base = SENSORS_ADM1026_FAN0 + (3 * i);
+    int  feat_div = feat_base +1, feat_min = feat_base +2;
+    if (!sensors_get_label_and_valid(*name,feat_base,&label,&valid) &&
+        !sensors_get_feature(*name,feat_base,&cur) &&
+        !sensors_get_feature(*name,feat_min,&min) &&
+        !sensors_get_feature(*name,feat_div,&max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)   %s\n",
+               cur,min,max,(alarms&(ADM1026_ALARM_FAN0<<i))?"ALARM":"");
+      }
+    } else {
+      printf("ERROR: Can't get FAN%d data!\n",i);
+    }
+    free_the_label(&label);
+  };
+
+  /* Three temperature sensors
+   * NOTE:  6 config values per temperature
+   *      0  current
+   *      1  max
+   *      2  min
+   *      3  offset   (to current)
+   *      4  therm    (SMBAlert)
+   *      5  tmin     (AFC)
+   */
+  for (i = 0; i <= 2 ; ++i) {
+    int  feat_base = SENSORS_ADM1026_TEMP1 + (6 * i);
+    int  feat_max = feat_base +1;
+    int  feat_min = feat_base +2;
+
+    if (!sensors_get_label_and_valid(*name,feat_base,&label,&valid) &&
+        !sensors_get_feature(*name,feat_base,&cur) &&
+        !sensors_get_feature(*name,feat_min,&min) &&
+        !sensors_get_feature(*name,feat_max,&max)) {
+      if (valid) {
+        print_label(label,10);
+        print_temp_info( cur, max, min, MINMAX, 0, 0);
+	puts( (alarms&adm1026_alarms_temp[i])?"   ALARM":"" );
+      }
+    } else {
+      printf("ERROR: Can't get TEMP%d data!\n",i+1);
+    }
+    free_the_label(&label);
+  };
+
+  /* VID/VRM */
+  if (!sensors_get_label_and_valid(*name,SENSORS_ADM1026_VID,&label,&valid)
+      && !sensors_get_feature(*name,SENSORS_ADM1026_VID,&cur)
+      && !sensors_get_feature(*name,SENSORS_ADM1026_VRM,&min) ) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.3f V    (VRM Version %4.1f)\n",cur,min);
+    }
+  }
+  free_the_label(&label);
+
+}
+
 void print_unknown_chip(const sensors_chip_name *name)
 {
   int a,b,valid;
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/prog/sensors/chips.h lm_sensors-2.7.0.adm1026/prog/sensors/chips.h
--- ../_relion1x/lm_sensors-2.7.0/prog/sensors/chips.h	Mon Nov 25 17:00:27 2002
+++ lm_sensors-2.7.0.adm1026/prog/sensors/chips.h	Fri Mar 28 22:20:07 2003
@@ -28,8 +28,9 @@
 extern void print_mtp008(const sensors_chip_name *name);
 extern void print_lm75(const sensors_chip_name *name);
 extern void print_adm1021(const sensors_chip_name *name);
-extern void print_adm1025(const sensors_chip_name *name);
 extern void print_adm1024(const sensors_chip_name *name);
+extern void print_adm1025(const sensors_chip_name *name);
+extern void print_adm1026(const sensors_chip_name *name);
 extern void print_adm9240(const sensors_chip_name *name);
 extern void print_lm78(const sensors_chip_name *name);
 extern void print_sis5595(const sensors_chip_name *name);
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/prog/sensors/main.c lm_sensors-2.7.0.adm1026/prog/sensors/main.c
--- ../_relion1x/lm_sensors-2.7.0/prog/sensors/main.c	Fri Nov 15 19:12:18 2002
+++ lm_sensors-2.7.0.adm1026/prog/sensors/main.c	Thu Apr  3 07:01:47 2003
@@ -359,6 +359,8 @@
     print_vt8231(&name);
   else if (!strcmp(name.prefix,"bmc"))
     print_bmc(&name);
+  else if (!strcmp(name.prefix,"adm1026"))
+    print_adm1026(&name);
   else
     print_unknown_chip(&name);
   printf("\n");
