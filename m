From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 09 Feb 2006 21:34:42 +0000
Subject: [lm-sensors] A patch for w83791d for 2.6 kernel
Message-Id: <5bfe43f80602091334m2319cb42j5e2710bdc1d8f1ff@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All --

Below is a patch to add w83791d support into the 2.6 kernel. This
patch was created off of the 2.6.15.3 base, but it should apply
cleanly on many earlier kernels (been tried on 2.6.14.3 and 2.6.15.1).

I've tried this on the system I have available here and it appears to work.

Thanks!

-- charles


diff -urpN linux-2.6.15.3/Documentation/hwmon/w83791d
linux-2.6.15.3-w83791d/Documentation/hwmon/w83791d
--- linux-2.6.15.3/Documentation/hwmon/w83791d  1969-12-31
16:00:00.000000000 -0800
+++ linux-2.6.15.3-w83791d/Documentation/hwmon/w83791d  2006-02-09
11:13:01.000000000 -0800
@@ -0,0 +1,117 @@
+Kernel driver w83791d
+==========+
+Supported chips:
+  * Winbond W83791D
+    Prefix: 'w83791d'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet:
http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83791Da.pdf
+
+Author: Charles Spirakis
+Contact: bezaur at gmail.com
+
+This driver was derived from the w83781d.c and w83792d.c source files.
+
+Credits:
+  w83781d.c:
+    Frodo Looijaard <frodol at dds.nl>,
+    Philip Edelbrock <phil at netroedge.com>,
+    and Mark Studebaker <mdsxyz123 at yahoo.com>
+  w83792d.c:
+    Chunhao Huang <DZShen at Winbond.com.tw>,
+    Rudolf Marek <r.marek at sh.cvut.cz>
+
+Module Parameters
+-----------------
+
+* init int
+  (default 0)
+  Use 'init=1' to force initializing the chip. Done this way to so that
+  the default behavior is to preserve BIOS settings.
+
+* force_subclients=bus,caddr,saddr,saddr
+  This is used to force the i2c addresses for subclients of
+  a certain chip. Example usage is `force_subclients=0,0x2f,0x4a,0x4b'
+  to force the subclients of chip 0x2f on bus 0 to i2c addresses
+  0x4a and 0x4b.
+
+
+Description
+-----------
+
+This driver implements support for the Winbond W83791D chip
+
+Detection of the chip can sometimes be foiled because it can be in an
+internal state that allows no clean access (Bank with ID register is not
+currently selected). If you know the address of the chip, use a 'force'
+parameter; this will put it into a more well-behaved state first.
+
+The driver implements three temperature sensors, five fan rotation speed
+sensors, and ten voltage sensors. In addition, there is experimental code
+to handle two automatic fan regulation strategies called: Smart Fan I
+(Thermal Cruise mode) and Smart Fan II. The experimental code is
+surrounded by "#if defined(TRY_FAN_CRUISE)" and is, by default,
+*not* compiled into the w83791d driver. Automatic fan control mode is
+possible only for fan1-fan3 and correspond to temperature sensors
+temp1-temp3. Further, your motherboard must connect the pwm outputs of
+the chip to the fans in some way so that the pwm outputs can control
+the fan speed.
+
+Temperatures are measured in degrees Celsius and measurement resolution is 1
+degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
+the temperature gets higher than the Overtemperature Shutdown value; it stays
+on until the temperature falls below the Hysteresis value.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4, 8 for fan 1/2/3
+and 1, 2, 4, 8, 16, 32, 64 or 128 for fan 4/5) to give the readings more
+range or accuracy.
+
+Voltage sensors (also known as IN sensors) report their values in millivolts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit.
+
+Alarms are provided as output from "realtime status register". Following bits
+are defined:
+
+bit - alarm on:
+0  - Vcore
+1  - VINR0
+2  - +3.3VIN
+3  - 5VDD
+4  - temp1
+5  - temp2
+6  - fan1
+7  - fan2
+8  - +12VIN
+9  - -12VIN
+10 - -5VIN
+11 - fan3
+12 - chassis
+13 - temp3
+14 - VINR1
+15 - reserved
+16 - tart1
+17 - tart2
+18 - tart3
+19 - VSB
+20 - VBAT
+21 - fan4
+22 - fan5
+23 - reserved
+
+When an alarm goes off, you can be warned by a beeping signal through your
+computer speaker. It is possible to enable all beeping globally, or only
+the beeping for some alarms.
+
+The driver only reads the chip values each 3 seconds; reading them more
+often will do no harm, but will return 'old' values.
+
+
+W83791D PROBLEMS
+----------------
+Known problems:
+       - The fan control (aka smart fan) code is untested. The code
+       can be enabled by define'ing TRY_FAN_CRUISE and recompiling.
+
diff -urpN linux-2.6.15.3/drivers/hwmon/Kconfig
linux-2.6.15.3-w83791d/drivers/hwmon/Kconfig
--- linux-2.6.15.3/drivers/hwmon/Kconfig        2006-02-06
15:36:47.000000000 -0800
+++ linux-2.6.15.3-w83791d/drivers/hwmon/Kconfig        2006-02-09
11:13:01.000000000 -0800
@@ -363,6 +363,16 @@ config SENSORS_W83781D
          This driver can also be built as a module.  If so, the module
          will be called w83781d.

+config SENSORS_W83791D
+       tristate "Winbond W83791D"
+       depends on HWMON && I2C && EXPERIMENTAL
+       select HWMON_VID
+       help
+         If you say yes here you get support for the Winbond W83791D chip.
+
+         This driver can also be built as a module.  If so, the module
+         will be called w83791d.
+
 config SENSORS_W83792D
        tristate "Winbond W83792D"
        depends on HWMON && I2C && EXPERIMENTAL
diff -urpN linux-2.6.15.3/drivers/hwmon/Makefile
linux-2.6.15.3-w83791d/drivers/hwmon/Makefile
--- linux-2.6.15.3/drivers/hwmon/Makefile       2006-02-06
15:36:47.000000000 -0800
+++ linux-2.6.15.3-w83791d/drivers/hwmon/Makefile       2006-02-09
11:13:01.000000000 -0800
@@ -10,6 +10,7 @@ obj-$(CONFIG_SENSORS_ASB100)  += asb100.o
 obj-$(CONFIG_SENSORS_W83627HF) += w83627hf.o
 obj-$(CONFIG_SENSORS_W83792D)  += w83792d.o
 obj-$(CONFIG_SENSORS_W83781D)  += w83781d.o
+obj-$(CONFIG_SENSORS_W83791D)  += w83791d.o

 obj-$(CONFIG_SENSORS_ADM1021)  += adm1021.o
 obj-$(CONFIG_SENSORS_ADM1025)  += adm1025.o
diff -urpN linux-2.6.15.3/drivers/hwmon/w83791d.c
linux-2.6.15.3-w83791d/drivers/hwmon/w83791d.c
--- linux-2.6.15.3/drivers/hwmon/w83791d.c      1969-12-31
16:00:00.000000000 -0800
+++ linux-2.6.15.3-w83791d/drivers/hwmon/w83791d.c      2006-02-09
11:13:01.000000000 -0800
@@ -0,0 +1,1649 @@
+/*
+    w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+
+    Copyright (c) 2006 Charles Spirakis <bezaur at gmail.com>
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
+    Note:
+    1. This driver is only for 2.6 kernel, 2.4 kernel need a different driver.
+    2. This driver has not been heavily tested
+*/
+
+/*
+    Supports following chips:
+
+    Chip       #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA
+    w83791d    10      5       3       3       0x71    0x5ca3  yes     no
+
+    The w83791d chip appears to be part way between the 83781d and the
+    83792d. Thus, this file is derived from both the w83792d.c and
+    w83781d.c files, but its output is more along the lines of the
+    83781d (which means there are no changes to the user-mode sensors
+    program which treats the 83791d as an 83781d).
+
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+
+/*
+    The "thermal cruise" and "fan speed cruise" ability of the chip
+    (sometimes known as "SmartFan1/2" has not been tested. If you are
+    interested in trying the code, just define "TRY_FAN_CRUISE" and
+    recompile. I have valididated that the code compiles and if
+    you wiggle the values from user-mode code the sysfs values change
+    as appropriate, but the board I tested on doesn't have the pwm
+    output connected to the fans, so the fan speeds don't actually
+    change.  Thus, the default is to have that code compiled out
+    until it can be better tested.
+
+#define TRY_FAN_CRUISE  1
+*/
+
+
+#define NUMBER_OF_VIN          10
+#define NUMBER_OF_FANIN                5
+#define NUMBER_OF_TEMPIN       3
+
+#if defined(TRY_FAN_CRUISE)
+#define NUMBER_OF_PWM          3
+#endif
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] +    { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(w83791d);
+I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+                      "{bus, clientaddr, subclientaddr1, subclientaddr2}");
+
+static int init;
+module_param(init, bool, 0);
+MODULE_PARM_DESC(init, "Set to one to force chip initialization");
+
+/* The W83791D registers */
+static const u8 W83791D_REG_IN[NUMBER_OF_VIN] = {
+       0x20,                   /* VCOREA in DataSheet */
+       0x21,                   /* VINR0 in DataSheet */
+       0x22,                   /* +3.3VIN in DataSheet */
+       0x23,                   /* VDD5V in DataSheet */
+       0x24,                   /* +12VIN in DataSheet */
+       0x25,                   /* -12VIN in DataSheet */
+       0x26,                   /* -5VIN in DataSheet */
+       0xB0,                   /* 5VSB in DataSheet */
+       0xB1,                   /* VBAT in DataSheet */
+       0xB2                    /* VINR1 in DataSheet */
+};
+
+static const u8 W83791D_REG_IN_MAX[NUMBER_OF_VIN] = {
+       0x2B,                   /* VCOREA High Limit in DataSheet */
+       0x2D,                   /* VINR0 High Limit in DataSheet */
+       0x2F,                   /* +3.3VIN High Limit in DataSheet */
+       0x31,                   /* VDD5V High Limit in DataSheet */
+       0x33,                   /* +12VIN High Limit in DataSheet */
+       0x35,                   /* -12VIN High Limit in DataSheet */
+       0x37,                   /* -5VIN High Limit in DataSheet */
+       0xB4,                   /* 5VSB High Limit in DataSheet */
+       0xB6,                   /* VBAT High Limit in DataSheet */
+       0xB8                    /* VINR1 High Limit in DataSheet */
+};
+static const u8 W83791D_REG_IN_MIN[NUMBER_OF_VIN] = {
+       0x2C,                   /* VCOREA Low Limit in DataSheet */
+       0x2E,                   /* VINR0 Low Limit in DataSheet */
+       0x30,                   /* +3.3VIN Low Limit in DataSheet */
+       0x32,                   /* VDD5V Low Limit in DataSheet */
+       0x34,                   /* +12VIN Low Limit in DataSheet */
+       0x36,                   /* -12VIN Low Limit in DataSheet */
+       0x38,                   /* -5VIN Low Limit in DataSheet */
+       0xB5,                   /* 5VSB Low Limit in DataSheet */
+       0xB7,                   /* VBAT Low Limit in DataSheet */
+       0xB9                    /* VINR1 Low Limit in DataSheet */
+};
+static const u8 W83791D_REG_FAN[NUMBER_OF_FANIN] = {
+       0x28,                   /* FAN 1 Count in DataSheet */
+       0x29,                   /* FAN 2 Count in DataSheet */
+       0x2A,                   /* FAN 3 Count in DataSheet */
+       0xBA,                   /* FAN 4 Count in DataSheet */
+       0xBB,                   /* FAN 5 Count in DataSheet */
+};
+static const u8 W83791D_REG_FAN_MIN[NUMBER_OF_FANIN] = {
+       0x3B,                   /* FAN 1 Count Low Limit in DataSheet */
+       0x3C,                   /* FAN 2 Count Low Limit in DataSheet */
+       0x3D,                   /* FAN 3 Count Low Limit in DataSheet */
+       0xBC,                   /* FAN 4 Count Low Limit in DataSheet */
+       0xBD,                   /* FAN 5 Count Low Limit in DataSheet */
+};
+
+static const u8 W83791D_REG_FAN_CFG[2] = {
+       0x84,                   /* FAN 1/2 configuration */
+       0x95,                   /* FAN 3 configuration */
+};
+
+static const u8 W83791D_REG_FAN_DIV[3] = {
+       0x47,                   /* contains FAN1 and FAN2 Divisor */
+       0x4b,                   /* contains FAN3 Divisor */
+       0x5C,                   /* contains FAN4 and FAN5 Divisor */
+};
+
+#define W83791D_REG_BANK               0x4E
+#define W83791D_REG_TEMP2_CONFIG       0xC2
+#define W83791D_REG_TEMP3_CONFIG       0xCA
+
+static const u8 W83791D_REG_TEMP1[3] = {
+       0x27,                   /* TEMP 1 in DataSheet */
+       0x39,                   /* TEMP 1 Over in DataSheet */
+       0x3A,                   /* TEMP 1 Hyst in DataSheet */
+};
+
+static const u8 W83791D_REG_TEMP_ADD[2][6] = {
+       {0xC0,                  /* TEMP 2 in DataSheet */
+        0xC1,                  /* TEMP 2(0.5 deg) in DataSheet */
+        0xC5,                  /* TEMP 2 Over High part in DataSheet */
+        0xC6,                  /* TEMP 2 Over Low part in DataSheet */
+        0xC3,                  /* TEMP 2 Thyst High part in DataSheet */
+        0xC4},                 /* TEMP 2 Thyst Low part in DataSheet */
+       {0xC8,                  /* TEMP 3 in DataSheet */
+        0xC9,                  /* TEMP 3(0.5 deg) in DataSheet */
+        0xCD,                  /* TEMP 3 Over High part in DataSheet */
+        0xCE,                  /* TEMP 3 Over Low part in DataSheet */
+        0xCB,                  /* TEMP 3 Thyst High part in DataSheet */
+        0xCC}                  /* TEMP 3 Thyst Low part in DataSheet */
+};
+
+#define W83791D_REG_BEEP_CONFIG                0x4D
+
+static const u8 W83791D_REG_BEEP_CTRL[3] = {
+       0x56,                   /* BEEP Control Register 1 */
+       0x57,                   /* BEEP Control Register 2 */
+       0xA3,                   /* BEEP Control Register 3 */
+};
+
+#if defined(TRY_FAN_CRUISE)
+static const u8 W83791D_REG_PWM[NUMBER_OF_PWM] = {
+       0x81,                   /* FAN 1 Duty Cycle, be used to control */
+       0x83,                   /* FAN 2 Duty Cycle, be used to control */
+       0x94,                   /* FAN 3 Duty Cycle, be used to control */
+};
+
+static const u8 W83791D_REG_TTARG[NUMBER_OF_PWM] = {
+       0x85,                   /* Fan1 target value */
+       0x86,                   /* Fan2 target value */
+       0x96                    /* Fan3 target value */
+};
+
+static const u8 W83791D_REG_TOLERANCE[2] = {
+       0x87,                   /* Fan1/Fan2 tolerance */
+       0x97                    /* Fan3 tolerance */
+};
+
+/* user-mode sees 1,2, 3 */
+#define USERMODE_FAN_MANUAL            1
+#define USERMODE_FAN_SPEED_CRUISE      2
+#define USERMODE_FAN_THERMAL_CRUISE    3
+
+/* Chip defined mode 0, 1, 2 */
+#define W83791D_FAN_MANUAL             0
+#define W83791D_FAN_THERMAL_CRUISE     1
+#define W83791D_FAN_SPEED_CRUISE       2
+#define W83791D_FAN_RESERVED           3
+
+static const u8 W83791D_FAN_MODE_MAP[4] = {
+       USERMODE_FAN_MANUAL,
+       USERMODE_FAN_THERMAL_CRUISE,
+       USERMODE_FAN_SPEED_CRUISE,
+       -1
+};
+#endif
+
+#define W83791D_REG_CONFIG             0x40
+#define W83791D_REG_VID_FANDIV         0x47
+#define W83791D_REG_CHIPID             0x49
+#define W83791D_REG_WCHIPID            0x58
+#define W83791D_REG_CHIPMAN            0x4F
+#define W83791D_REG_PIN                        0x4B
+#define W83791D_REG_I2C_SUBADDR                0x4A
+
+#define W83791D_REG_ALARM1 0xA9        /* realtime status register1 */
+#define W83791D_REG_ALARM2 0xAA        /* realtime status register2 */
+#define W83791D_REG_ALARM3 0xAB        /* realtime status register3 */
+
+#define W83791D_REG_VBAT               0x5D
+#define W83791D_REG_I2C_ADDR           0x48
+
+/* For legacy reasons, try to turn the value from the voltage ADC
+   registers into some psuedo voltage value. Given there is a
+   sensors.conf which can do computation, why do we still bother
+   with this (as opposed to just providing the actual chip
+   values directly)? */
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define IN_TO_REG(nr,val)      (SENSORS_LIMIT((((val) * 10 + 8) /
16), 0, 255))+#define IN_FROM_REG(nr,val)    (((val) * 16) / 10)
+
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+       if (rpm = 0)
+               return 255;
+       rpm = SENSORS_LIMIT(rpm, 1, 1000000);
+       return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+}
+
+#define FAN_FROM_REG(val,div)  ((val) = 0   ? -1 : \
+                               ((val) = 255 ? 0 : \
+                                               1350000 / ((val) * (div))))
+
+/* for temp1 */
+#define TEMP1_TO_REG(val)      (SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
+                                       : (val)) / 1000, 0, 0xff))
+#define TEMP1_FROM_REG(val)    (((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
+
+/* for temp2 and temp3, because they need addtional resolution */
+#define TEMP_ADD_FROM_REG(val1, val2) \
+       ((((val1) & 0x80 ? (val1)-0x100 \
+               : (val1)) * 1000) + ((val2 & 0x80) ? 500 : 0))
+#define TEMP_ADD_TO_REG_HIGH(val) \
+       (SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
+                       : (val)) / 1000, 0, 0xff))
+#define TEMP_ADD_TO_REG_LOW(val)       ((val%1000) ? 0x80 : 0x00)
+
+#define PWM_FROM_REG(val)              (val)
+#define PWM_TO_REG(val)                        (SENSORS_LIMIT((val),0,255))
+
+#define BEEP_ENABLE_TO_REG(val)                ((val) ? 1 : 0)
+#define BEEP_ENABLE_FROM_REG(val)      ((val) ? 1 : 0)
+
+#define BEEP_MASK_TO_REG(val)          ((val) & 0xffffff)
+#define BEEP_MASK_FROM_REG(val)                ((val) & 0xffffff)
+
+#define DIV_FROM_REG(val)              (1 << (val))
+
+static inline u8 DIV_TO_REG(long val)
+{
+       int i;
+       val = SENSORS_LIMIT(val, 1, 128) >> 1;
+       for (i = 0; i < 6; i++) {
+               if (val = 0)
+                       break;
+               val >>= 1;
+       }
+       return ((u8) i);
+}
+
+struct w83791d_data {
+       struct i2c_client client;
+       struct class_device *class_dev;
+       struct semaphore lock;
+       enum chips type;
+
+       struct semaphore update_lock;
+       char valid;                     /* !=0 if following fields are valid */
+       unsigned long last_updated;     /* In jiffies */
+
+       /* array of 2 pointers to subclients */
+       struct i2c_client *lm75[2];
+
+       /* volts */
+       u8 in[NUMBER_OF_VIN];   /* Register value */
+       u8 in_max[NUMBER_OF_VIN];       /* Register value */
+       u8 in_min[NUMBER_OF_VIN];       /* Register value */
+
+       /* fans */
+       u8 fan[NUMBER_OF_FANIN];        /* Register value */
+       u8 fan_min[NUMBER_OF_FANIN];    /* Register value */
+       u8 fan_div[NUMBER_OF_FANIN];    /* Register encoding, shifted right */
+
+#if defined(TRY_FAN_CRUISE)
+       u8 pwm[NUMBER_OF_PWM];          /* We only use the first 3 set
of pwm */+       u8 pwmenable[NUMBER_OF_PWM];
+
+       u8 fan_cruise[NUMBER_OF_PWM];   /* Fan1,2,3 target value */
+       u8 fan_tolerance[NUMBER_OF_PWM];        /* Fan1,2,3 tolerance */
+#endif
+
+       /* Temperature sensors */
+
+       u8 temp1[3];            /* current, over, thyst */
+       u8 temp_add[2][6];      /* 2 sets (current[h/l], over[h/l],
thyst[h/l])  */
+
+       /* Misc */
+       u32 alarms;             /* realtime status register
encoding,combined */+       u8 beep_enable;         /* Global beep
enable */
+       u32 beep_mask;          /* Mask off specific beeps */
+       u8 vid;                 /* Register encoding, combined */
+       u8 vrm;                 /* hwmon-vid */
+};
+
+static int w83791d_attach_adapter(struct i2c_adapter *adapter);
+static int w83791d_detect(struct i2c_adapter *adapter, int address,
+                         int kind);
+static int w83791d_detach_client(struct i2c_client *client);
+
+static int w83791d_read_value(struct i2c_client *client, u8 register);
+static int w83791d_write_value(struct i2c_client *client, u8 register,
+                              u8 value);
+static struct w83791d_data *w83791d_update_device(struct device *dev);
+
+#ifdef DEBUG
+static void w83791d_print_debug(struct w83791d_data *data,
+                               struct device *dev);
+#endif
+
+static void w83791d_init_client(struct i2c_client *client);
+
+static struct i2c_driver w83791d_driver = {
+       .owner = THIS_MODULE,
+       .name = "w83791d",
+       .flags = I2C_DF_NOTIFY,
+       .attach_adapter = w83791d_attach_adapter,
+       .detach_client = w83791d_detach_client,
+};
+
+/* following are the sysfs callback functions */
+#define show_in_reg(reg) \
+static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
+                       char *buf) \
+{ \
+       struct sensor_device_attribute *sensor_attr to_sensor_dev_attr(attr); \
+       int nr = sensor_attr->index; \
+       struct w83791d_data *data = w83791d_update_device(dev); \
+       return sprintf(buf,"%ld\n", (long)(IN_FROM_REG(nr,
(data->reg[nr] * 10)))); \
+}
+
+show_in_reg(in);
+show_in_reg(in_min);
+show_in_reg(in_max);
+
+#define store_in_reg(REG, reg) \
+static ssize_t store_in_##reg (struct device *dev, \
+                               struct device_attribute *attr, \
+                               const char *buf, size_t count) \
+{ \
+       struct sensor_device_attribute *sensor_attr to_sensor_dev_attr(attr); \
+       int nr = sensor_attr->index; \
+       struct i2c_client *client = to_i2c_client(dev); \
+       struct w83791d_data *data = i2c_get_clientdata(client); \
+       u32 val; \
+        \
+       val = simple_strtoul(buf, NULL, 10) / 10; \
+        \
+       down(&data->update_lock); \
+       data->in_##reg[nr] = SENSORS_LIMIT(IN_TO_REG(nr, val), 0, 255); \
+       w83791d_write_value(client, W83791D_REG_IN_##REG[nr],
data->in_##reg[nr]); \
+       up(&data->update_lock); \
+        \
+       return count; \
+}
+store_in_reg(MIN, min);
+store_in_reg(MAX, max);
+
+#define sysfs_in_reg(offset) \
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in, \
+                               NULL, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
+                               show_in_min, store_in_min, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
+                               show_in_max, store_in_max, offset);
+
+sysfs_in_reg(0);
+sysfs_in_reg(1);
+sysfs_in_reg(2);
+sysfs_in_reg(3);
+sysfs_in_reg(4);
+sysfs_in_reg(5);
+sysfs_in_reg(6);
+sysfs_in_reg(7);
+sysfs_in_reg(8);
+sysfs_in_reg(9);
+
+#define device_create_file_in(client, offset) \
+do { \
+device_create_file(&client->dev,
&sensor_dev_attr_in##offset##_input.dev_attr); \
+device_create_file(&client->dev,
&sensor_dev_attr_in##offset##_max.dev_attr);
\+device_create_file(&client->dev,
&sensor_dev_attr_in##offset##_min.dev_attr); \+} while (0)
+
+#define show_fan_reg(reg) \
+static ssize_t show_##reg (struct device *dev, struct
device_attribute *attr, \+                       char *buf) \
+{ \
+       struct sensor_device_attribute *sensor_attr to_sensor_dev_attr(attr); \
+       int nr = sensor_attr->index - 1; \
+       struct w83791d_data *data = w83791d_update_device(dev); \
+       return sprintf(buf,"%d\n", \
+               FAN_FROM_REG(data->reg[nr],
DIV_FROM_REG(data->fan_div[nr]))); \+}
+
+show_fan_reg(fan);
+show_fan_reg(fan_min);
+
+static ssize_t
+store_fan_min(struct device *dev, struct device_attribute *attr,
+             const char *buf, size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       u32 val;
+
+       val = simple_strtoul(buf, NULL, 10);
+
+       down(&data->update_lock);
+       data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+       w83791d_write_value(client, W83791D_REG_FAN_MIN[nr],
data->fan_min[nr]);+       up(&data->update_lock);
+
+       return count;
+}
+
+static ssize_t
+show_fan_div(struct device *dev, struct device_attribute *attr, char *buf)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%u\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
+static ssize_t
+store_fan_div(struct device *dev, struct device_attribute *attr,
+             const char *buf, size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       int indx;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       unsigned long min;
+       /*u8 reg; */
+       u8 fan_div_reg = 0;
+       u8 tmp_fan_div;
+       u8 keep_mask;
+       u8 new_shift;
+
+       /* Save fan_min */
+       min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
+
+       down(&data->update_lock);
+       data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+
+       switch (nr) {
+       case 0:
+               indx = 0;
+               keep_mask = 0xcf;
+               new_shift = 4;
+               break;
+       case 1:
+               indx = 0;
+               keep_mask = 0x3f;
+               new_shift = 6;
+               break;
+       case 2:
+               indx = 1;
+               keep_mask = 0x3f;
+               new_shift = 6;
+               break;
+       case 3:
+               indx = 2;
+               keep_mask = 0xf8;
+               new_shift = 0;
+               break;
+       case 4:
+               indx = 2;
+               keep_mask = 0x8f;
+               new_shift = 4;
+               break;
+       default:
+               dev_warn(dev, "store_fan_div: Unexpected nr seen: %d\n", nr);
+               count = -EINVAL;
+               goto err_exit;
+       }
+
+       fan_div_reg = w83791d_read_value(client,
+                              W83791D_REG_FAN_DIV[indx]) & keep_mask;
+       tmp_fan_div = ((data->fan_div[nr] << new_shift) & (~keep_mask));
+
+       w83791d_write_value(client, W83791D_REG_FAN_DIV[indx],
+                           ((fan_div_reg | tmp_fan_div) & 0xff));
+
+       /* Restore fan_min */
+       data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+       w83791d_write_value(client, W83791D_REG_FAN_MIN[nr],
data->fan_min[nr]);+
+err_exit:
+       up(&data->update_lock);
+
+       return count;
+}
+
+#define sysfs_fan(offset) \
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan, NULL, \
+                               offset); \
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+                               show_fan_div, store_fan_div, offset); \
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
+                               show_fan_min, store_fan_min, offset);
+
+sysfs_fan(1);
+sysfs_fan(2);
+sysfs_fan(3);
+sysfs_fan(4);
+sysfs_fan(5);
+
+#define device_create_file_fan(client, offset) \
+do { \
+device_create_file(&client->dev,
&sensor_dev_attr_fan##offset##_input.dev_attr); \
+device_create_file(&client->dev,
&sensor_dev_attr_fan##offset##_div.dev_attr); \
+device_create_file(&client->dev,
&sensor_dev_attr_fan##offset##_min.dev_attr); \
+} while (0)
+
+/* read/write the temperature1, includes measured value and limits */
+
+static ssize_t show_temp1(struct device *dev,
+                         struct device_attribute *attr, char *buf)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp1[nr]));
+}
+
+static ssize_t store_temp1(struct device *dev,
+                          struct device_attribute *attr, const char *buf,
+                          size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       s32 val;
+
+       val = simple_strtol(buf, NULL, 10);
+
+       down(&data->update_lock);
+       data->temp1[nr] = TEMP1_TO_REG(val);
+       w83791d_write_value(client, W83791D_REG_TEMP1[nr],
+                           data->temp1[nr]);
+       up(&data->update_lock);
+
+       return count;
+}
+
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp1,
+                         store_temp1, 1);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp1,
+                         store_temp1, 2);
+
+#define device_create_file_temp1(client) \
+do { \
+device_create_file(&client->dev, &sensor_dev_attr_temp1_input.dev_attr); \
+device_create_file(&client->dev, &sensor_dev_attr_temp1_max.dev_attr); \
+device_create_file(&client->dev, &sensor_dev_attr_temp1_max_hyst.dev_attr); \
+} while (0)
+
+
+/* read/write the temperature2-3, includes measured value and limits */
+
+static ssize_t show_temp23(struct device *dev,
+                          struct device_attribute *attr, char *buf)
+{
+       struct sensor_device_attribute_2 *sensor_attr +           to_sensor_dev_attr_2(attr);
+       int nr = sensor_attr->nr;
+       int index = sensor_attr->index;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%ld\n",
+                      (long) TEMP_ADD_FROM_REG(data->temp_add[nr][index],
+                                               data->temp_add[nr][index +
+                                                                  1]));
+}
+
+static ssize_t store_temp23(struct device *dev,
+                           struct device_attribute *attr, const char *buf,
+                           size_t count)
+{
+       struct sensor_device_attribute_2 *sensor_attr +           to_sensor_dev_attr_2(attr);
+       int nr = sensor_attr->nr;
+       int index = sensor_attr->index;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       s32 val;
+
+       val = simple_strtol(buf, NULL, 10);
+
+       down(&data->update_lock);
+       data->temp_add[nr][index] = TEMP_ADD_TO_REG_HIGH(val);
+       data->temp_add[nr][index + 1] = TEMP_ADD_TO_REG_LOW(val);
+       w83791d_write_value(client, W83791D_REG_TEMP_ADD[nr][index],
+                           data->temp_add[nr][index]);
+       w83791d_write_value(client, W83791D_REG_TEMP_ADD[nr][index + 1],
+                           data->temp_add[nr][index + 1]);
+       up(&data->update_lock);
+
+       return count;
+}
+
+#define sysfs_temp23(name,idx) \
+static SENSOR_DEVICE_ATTR_2(name##_input, S_IRUGO, show_temp23, NULL, \
+                               idx, 0); \
+static SENSOR_DEVICE_ATTR_2(name##_max, S_IRUGO | S_IWUSR, \
+                               show_temp23, store_temp23, idx, 2); \
+static SENSOR_DEVICE_ATTR_2(name##_max_hyst, S_IRUGO | S_IWUSR, \
+                               show_temp23, store_temp23, idx, 4);
+
+sysfs_temp23(temp2, 0)
+    sysfs_temp23(temp3, 1)
+#define device_create_file_temp_add(client, offset) \
+do { \
+device_create_file(&client->dev,
&sensor_dev_attr_temp##offset##_input.dev_attr); \
+device_create_file(&client->dev,
&sensor_dev_attr_temp##offset##_max.dev_attr); \
+device_create_file(&client->dev, \
+&sensor_dev_attr_temp##offset##_max_hyst.dev_attr); \
+} while (0)
+
+/* get reatime status of all sensors items: voltage, temp, fan */
+static ssize_t
+show_alarms_reg(struct device *dev, struct device_attribute *attr,
+               char *buf)
+{
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%u\n", data->alarms);
+}
+
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+#define device_create_file_alarms(client) \
+device_create_file(&client->dev, &dev_attr_alarms);
+
+
+/* Beep control */
+
+#define GLOBAL_BEEP_ENABLE_SHIFT       15
+#define GLOBAL_BEEP_ENABLE_MASK                (1 << GLOBAL_BEEP_ENABLE_SHIFT)
+
+static ssize_t
+show_beep_enable(struct device *dev, struct device_attribute *attr,
+                char *buf)
+{
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%d\n",
+                      BEEP_ENABLE_FROM_REG(data->beep_enable));
+}
+
+static ssize_t
+show_beep_mask(struct device *dev, struct device_attribute *attr,
+              char *buf)
+{
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%d\n", BEEP_MASK_FROM_REG(data->beep_mask));
+}
+
+
+static ssize_t store_beep_mask(struct device *dev,
+                              struct device_attribute *attr,
+                              const char *buf, size_t count)
+{
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       s32 val;
+       int i;
+
+       val = simple_strtol(buf, NULL, 10);
+
+       down(&data->update_lock);
+
+       /* The beep_enable state overrides any enabling request from
+          via changing the masks */
+       data->beep_mask = BEEP_MASK_TO_REG(val) & ~GLOBAL_BEEP_ENABLE_MASK;
+       data->beep_mask |= (data->beep_enable << GLOBAL_BEEP_ENABLE_SHIFT);
+
+       val = data->beep_mask;
+
+       for (i = 0; i < 3; i++) {
+               w83791d_write_value(client, W83791D_REG_BEEP_CTRL[i],
+                                   (val & 0xff));
+               val >>= 8;
+       }
+
+       up(&data->update_lock);
+
+       return count;
+}
+
+static ssize_t store_beep_enable(struct device *dev,
+                                struct device_attribute *attr,
+                                const char *buf, size_t count)
+{
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       s32 val;
+
+       val = simple_strtol(buf, NULL, 10);
+
+       down(&data->update_lock);
+
+       data->beep_enable = BEEP_ENABLE_TO_REG(val);
+
+       /* Keep the full mask value in sync with the current enable */
+       data->beep_mask &= ~GLOBAL_BEEP_ENABLE_MASK;
+       data->beep_mask |= (data->beep_enable << GLOBAL_BEEP_ENABLE_SHIFT);
+
+       /* The global control is in the second beep control register
+          so only need to update that register */
+       val = (data->beep_mask >> 8) & 0xff;
+
+       w83791d_write_value(client, W83791D_REG_BEEP_CTRL[1],
+                           (val & 0xff));
+
+       up(&data->update_lock);
+
+       return count;
+}
+
+#define sysfs_beep(reg) \
+static ssize_t show_regs_beep_##reg (struct device *dev, struct
device_attribute *attr, char *buf) \
+{ \
+       return show_beep_##reg(dev, attr, buf); \
+} \
+static ssize_t store_regs_beep_##reg (struct device *dev, struct
device_attribute *attr, const char *buf, size_t count) \
+{ \
+       return store_beep_##reg(dev, attr, buf, count); \
+} \
+static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR,
show_regs_beep_##reg, store_regs_beep_##reg);
+
+sysfs_beep(enable);
+sysfs_beep(mask);
+
+#define device_create_file_beep(client) \
+do { \
+device_create_file(&client->dev, &dev_attr_beep_enable); \
+device_create_file(&client->dev, &dev_attr_beep_mask); \
+} while (0)
+
+
+
+#if defined(TRY_FAN_CRUISE)
+
+static ssize_t
+show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr]));
+}
+
+static ssize_t
+show_pwmenable(struct device *dev, struct device_attribute *attr,
+              char *buf)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       long pwm_enable_tmp;
+
+       pwm_enable_tmp = W83791D_FAN_MODE_MAP[data->pwmenable[nr]];
+
+       return sprintf(buf, "%ld\n", pwm_enable_tmp);
+}
+
+static ssize_t
+store_pwm(struct device *dev, struct device_attribute *attr,
+         const char *buf, size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       u32 val;
+
+       val = simple_strtoul(buf, NULL, 10);
+       down(&data->update_lock);
+       data->pwm[nr] = PWM_TO_REG(val);
+       w83791d_write_value(client, W83791D_REG_PWM[nr], data->pwm[nr]);
+       up(&data->update_lock);
+
+       return count;
+}
+
+static ssize_t
+store_pwmenable(struct device *dev, struct device_attribute *attr,
+               const char *buf, size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       int indx;
+       u8 keep_mask;
+       u8 new_shift;
+       u32 val;
+       u8 reg_tmp;
+       u8 cfg_tmp = W83791D_FAN_MANUAL;
+
+       val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 1, 3);
+
+       switch (val) {
+       case USERMODE_FAN_MANUAL:
+               cfg_tmp = W83791D_FAN_MANUAL;
+               break;
+       case USERMODE_FAN_SPEED_CRUISE:
+               cfg_tmp = W83791D_FAN_SPEED_CRUISE;
+               break;
+       case USERMODE_FAN_THERMAL_CRUISE:
+               cfg_tmp = W83791D_FAN_THERMAL_CRUISE;
+               break;
+       }
+
+       switch (nr) {
+       case 0:
+               indx = 0;
+               keep_mask = 0xf3;
+               new_shift = 2;
+               break;
+       case 1:
+               indx = 0;
+               keep_mask = 0xcf;
+               new_shift = 4;
+               break;
+       case 2:
+               indx = 1;
+               keep_mask = 0xf3;
+               new_shift = 2;
+               break;
+       default:
+               dev_warn(dev, "store_pwmenable: Unexpected nr seen: %d\n", nr);
+               count = -EINVAL;
+               goto err_exit;
+       }
+
+       /* Update only after we know all the values are legal */
+       down(&data->update_lock);
+       data->pwmenable[nr] = cfg_tmp;
+       reg_tmp = w83791d_read_value(client,
W83791D_REG_FAN_CFG[indx]) & keep_mask;
+       cfg_tmp = (data->pwmenable[nr] << new_shift) & (~keep_mask);
+       w83791d_write_value(client, W83791D_REG_FAN_CFG[indx],
+                           (reg_tmp | cfg_tmp) & 0xff);
+       up(&data->update_lock);
+
+err_exit:
+       return count;
+}
+
+#define sysfs_pwm(offset) \
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
+                               show_pwm, store_pwm, offset); \
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, \
+                               show_pwmenable, store_pwmenable, offset); \
+
+sysfs_pwm(1);
+sysfs_pwm(2);
+sysfs_pwm(3);
+
+
+#define device_create_file_pwm(client, offset) \
+do { \
+device_create_file(&client->dev, &sensor_dev_attr_pwm##offset.dev_attr); \
+} while (0)
+
+#define device_create_file_pwmenable(client, offset) \
+do { \
+device_create_file(&client->dev,
&sensor_dev_attr_pwm##offset##_enable.dev_attr); \
+} while (0)
+
+static ssize_t
+show_fan_cruise(struct device *dev, struct device_attribute *attr,
+                   char *buf)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%ld\n", (long) data->fan_cruise[nr]);
+}
+
+static ssize_t
+store_fan_cruise(struct device *dev, struct device_attribute *attr,
+                    const char *buf, size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       u32 val;
+       u8 target_mask;
+
+       val = simple_strtoul(buf, NULL, 10);
+       down(&data->update_lock);
+       if (W83791D_FAN_SPEED_CRUISE = data->pwmenable[nr]) {
+               data->fan_cruise[nr] = SENSORS_LIMIT(val, 0, 255);
+               w83791d_write_value(client, W83791D_REG_TTARG[nr],
+                                   data->fan_cruise[nr]);
+       }
+       else {
+               target_mask = w83791d_read_value(client,
+                                                W83791D_REG_TTARG[nr]) & 0x80;
+               data->fan_cruise[nr] = SENSORS_LIMIT(val, 0, 127);
+               w83791d_write_value(client, W83791D_REG_TTARG[nr],
+                           (data->fan_cruise[nr]) | target_mask);
+       }
+       up(&data->update_lock);
+
+       return count;
+}
+
+#define sysfs_fan_cruise(offset) \
+static SENSOR_DEVICE_ATTR(fan##offset##_cruise, S_IRUGO | S_IWUSR, \
+                       show_fan_cruise, store_fan_cruise, offset);
+
+sysfs_fan_cruise(1);
+sysfs_fan_cruise(2);
+sysfs_fan_cruise(3);
+
+#define device_create_file_fan_cruise(client, offset) \
+do { \
+device_create_file(&client->dev, \
+&sensor_dev_attr_fan##offset##_cruise.dev_attr); \
+} while (0)
+
+
+static ssize_t
+show_fan_tolerance(struct device *dev, struct device_attribute *attr,
+              char *buf)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%ld\n", (long) data->fan_tolerance[nr]);
+}
+
+static ssize_t
+store_fan_tolerance(struct device *dev, struct device_attribute *attr,
+               const char *buf, size_t count)
+{
+       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+       int nr = sensor_attr->index - 1;
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       u32 val;
+       int indx;
+       u8 tol_tmp, tol_keep_mask, tol_shift;
+
+       val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 15);
+
+       tol_keep_mask = (nr & 0x01) ? 0x0f : 0xf0;
+       tol_shift =     (nr & 0x01) ? 4: 0;
+
+       indx = nr >> 1;
+
+       down(&data->update_lock);
+       data->fan_tolerance[nr] = val;
+       tol_tmp = w83791d_read_value(client, W83791D_REG_TOLERANCE[indx]);
+       w83791d_write_value(client, W83791D_REG_TOLERANCE[indx],
+                           (tol_tmp & tol_keep_mask) |
+                           ((val << tol_shift) & ~tol_keep_mask));
+       up(&data->update_lock);
+
+       return count;
+}
+
+#define sysfs_fan_tolerance(offset) \
+static SENSOR_DEVICE_ATTR(fan##offset##_tolerance, S_IRUGO | S_IWUSR, \
+                               show_fan_tolerance,
store_fan_tolerance, offset);
+
+sysfs_fan_tolerance(1);
+sysfs_fan_tolerance(2);
+sysfs_fan_tolerance(3);
+
+#define device_create_file_fan_tolerance(client, offset) \
+do { \
+device_create_file(&client->dev,
&sensor_dev_attr_fan##offset##_tolerance.dev_attr); \
+} while (0)
+
+#endif
+
+/* cpu voltage regulation information */
+static ssize_t
+show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
+{
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid,
data->vrm));+}
+
+static
+DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+#define device_create_file_vid(client) \
+device_create_file(&client->dev, &dev_attr_cpu0_vid);
+
+static ssize_t
+show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
+{
+       struct w83791d_data *data = w83791d_update_device(dev);
+       return sprintf(buf, "%ld\n", (long) data->vrm);
+}
+
+static ssize_t
+store_vrm_reg(struct device *dev, struct device_attribute *attr,
const char *buf, size_t count)
+{
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       u32 val;
+
+       val = simple_strtoul(buf, NULL, 10);
+       down(&data->update_lock);
+       data->vrm = val;
+       up(&data->update_lock);
+
+       return count;
+}
+
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+#define device_create_file_vrm(client) \
+device_create_file(&client->dev, &dev_attr_vrm);
+
+/* This function is called when:
+     * w83791d_driver is inserted (when this module is loaded), for each
+       available adapter
+     * when a new adapter is inserted (and w83791d_driver is still present) */
+static int w83791d_attach_adapter(struct i2c_adapter *adapter)
+{
+       if (!(adapter->class & I2C_CLASS_HWMON))
+               return 0;
+       return i2c_probe(adapter, &addr_data, w83791d_detect);
+}
+
+
+static int
+w83791d_create_subclient(struct i2c_adapter *adapter,
+                        struct i2c_client *new_client, int addr,
+                        struct i2c_client **sub_cli)
+{
+       int err;
+       struct i2c_client *sub_client;
+
+       (*sub_cli) = sub_client +           kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+       if (!(sub_client)) {
+               return -ENOMEM;
+       }
+       sub_client->addr = 0x48 + addr;
+       i2c_set_clientdata(sub_client, NULL);
+       sub_client->adapter = adapter;
+       sub_client->driver = &w83791d_driver;
+       sub_client->flags = 0;
+       strlcpy(sub_client->name, "w83791d subclient", I2C_NAME_SIZE);
+       if ((err = i2c_attach_client(sub_client))) {
+               dev_err(&new_client->dev, "subclient registration "
+                       "at address 0x%x failed\n", sub_client->addr);
+               kfree(sub_client);
+               return err;
+       }
+       return 0;
+}
+
+
+static int
+w83791d_detect_subclients(struct i2c_adapter *adapter, int address,
+                         int kind, struct i2c_client *new_client)
+{
+       int i, id, err;
+       u8 val;
+       struct w83791d_data *data = i2c_get_clientdata(new_client);
+
+       id = i2c_adapter_id(adapter);
+       if (force_subclients[0] = id && force_subclients[1] = address) {
+               for (i = 2; i <= 3; i++) {
+                       if (force_subclients[i] < 0x48 ||
+                           force_subclients[i] > 0x4f) {
+                               dev_err(&new_client->dev,
+                                       "invalid subclient "
+                                       "address %d; must be 0x48-0x4f\n",
+                                       force_subclients[i]);
+                               err = -ENODEV;
+                               goto ERROR_SC_0;
+                       }
+               }
+               w83791d_write_value(new_client, W83791D_REG_I2C_SUBADDR,
+                                   (force_subclients[2] & 0x07) |
+                                   ((force_subclients[3] & 0x07) << 4));
+       }
+
+       val = w83791d_read_value(new_client, W83791D_REG_I2C_SUBADDR);
+       if (!(val & 0x08)) {
+               err +                   w83791d_create_subclient(adapter, new_client,
+                                            val & 0x7, &data->lm75[0]);
+               if (err < 0)
+                       goto ERROR_SC_0;
+       }
+       if (!(val & 0x80)) {
+               if ((data->lm75[0] != NULL) &&
+                   ((val & 0x7) = ((val >> 4) & 0x7))) {
+                       dev_err(&new_client->dev,
+                               "duplicate addresses 0x%x, "
+                               "use force_subclient\n",
+                               data->lm75[0]->addr);
+                       err = -ENODEV;
+                       goto ERROR_SC_1;
+               }
+               err = w83791d_create_subclient(adapter, new_client,
+                                              (val >> 4) & 0x7,
+                                              &data->lm75[1]);
+               if (err < 0)
+                       goto ERROR_SC_1;
+       }
+
+       return 0;
+
+/* Undo inits in case of errors */
+
+      ERROR_SC_1:
+       if (data->lm75[0] != NULL) {
+               i2c_detach_client(data->lm75[0]);
+               kfree(data->lm75[0]);
+       }
+      ERROR_SC_0:
+       return err;
+}
+
+
+static int
+w83791d_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+       int i = 0, val1 = 0, val2;
+       struct i2c_client *new_client;
+       struct w83791d_data *data;
+       int err = 0;
+       const char *client_name = "";
+
+       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+               goto ERROR0;
+       }
+
+       /* OK. For now, we presume we have a valid client. We now create the
+          client structure, even though we cannot fill it completely yet.
+          But it allows us to access w83791d_{read,write}_value. */
+
+       if (!(data = kzalloc(sizeof(struct w83791d_data), GFP_KERNEL))) {
+               err = -ENOMEM;
+               goto ERROR0;
+       }
+
+       new_client = &data->client;
+       i2c_set_clientdata(new_client, data);
+       new_client->addr = address;
+       init_MUTEX(&data->lock);
+       new_client->adapter = adapter;
+       new_client->driver = &w83791d_driver;
+       new_client->flags = 0;
+
+       /* Now, we do the remaining detection. */
+
+       /* The w83791d may be stuck in some other bank than bank 0. This may
+          make reading other information impossible. Specify a force=... or
+          force_*=... parameter, and the Winbond will be reset to the right
+          bank. */
+       if (kind < 0) {
+               if (w83791d_read_value(new_client, W83791D_REG_CONFIG) &
+                   0x80) {
+                       dev_warn(&new_client->dev,
+                                "Detection failed at step 3\n");
+                       goto ERROR1;
+               }
+               val1 = w83791d_read_value(new_client, W83791D_REG_BANK);
+               val2 = w83791d_read_value(new_client, W83791D_REG_CHIPMAN);
+               /* Check for Winbond ID if in bank 0 */
+               if (!(val1 & 0x07)) {   /* is Bank0 */
+                       if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
+                           ((val1 & 0x80) && (val2 != 0x5c))) {
+                               goto ERROR1;
+                       }
+               }
+               /* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
+                  should match */
+               if (w83791d_read_value(new_client,
+                                      W83791D_REG_I2C_ADDR) != address) {
+                       dev_warn(&new_client->dev, "Detection failed "
+                                "at step 5\n");
+                       goto ERROR1;
+               }
+       }
+
+       /* We have either had a force parameter, or we have already
detected the+          Winbond. Put it now into bank 0 and Vendor ID
High Byte */
+       w83791d_write_value(new_client, W83791D_REG_BANK,
+                       (w83791d_read_value(new_client, W83791D_REG_BANK) &
+                        0x78) | 0x80);
+
+       /* Determine the chip type. */
+       if (kind <= 0) {
+               /* get vendor ID */
+               val2 = w83791d_read_value(new_client, W83791D_REG_CHIPMAN);
+               if (val2 != 0x5c) {     /* the vendor is NOT Winbond */
+                       goto ERROR1;
+               }
+               val1 = w83791d_read_value(new_client, W83791D_REG_WCHIPID);
+               if (val1 = 0x71 && address >= 0x2c) {
+                       kind = w83791d;
+               } else {
+                       if (kind = 0)
+                               dev_warn(&new_client->dev,
+                                       "w83791d: Ignoring 'force' parameter "
+                                       "for unknown chip at adapter %d, "
+                                       "address 0x%02x\n",
+                                       i2c_adapter_id(adapter), address);
+                       goto ERROR1;
+               }
+       }
+
+       if (kind = w83791d) {
+               client_name = "w83791d";
+       } else {
+               dev_err(&new_client->dev,
+                       "w83791d: Internal error: unknown kind (%d)?!?",
+                       kind);
+               goto ERROR1;
+       }
+
+       /* Fill in the remaining client fields and put into the global list */
+       strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+       data->type = kind;
+
+       data->valid = 0;
+       init_MUTEX(&data->update_lock);
+
+       /* Tell the I2C layer a new client has arrived */
+       if ((err = i2c_attach_client(new_client)))
+               goto ERROR1;
+
+       if ((err = w83791d_detect_subclients(adapter, address,
+                                            kind, new_client)))
+               goto ERROR2;
+
+       /* Initialize the chip */
+       w83791d_init_client(new_client);
+
+       /* A few vars need to be filled upon startup */
+       for (i = 1; i <= NUMBER_OF_FANIN; i++) {
+               data->fan_min[i - 1] = w83791d_read_value(new_client,
+                                                         W83791D_REG_FAN_MIN
+                                                         [i]);
+       }
+
+       /* Register sysfs hooks */
+       data->class_dev = hwmon_device_register(&new_client->dev);
+       if (IS_ERR(data->class_dev)) {
+               err = PTR_ERR(data->class_dev);
+               goto ERROR3;
+       }
+       device_create_file_in(new_client, 0);
+       device_create_file_in(new_client, 1);
+       device_create_file_in(new_client, 2);
+       device_create_file_in(new_client, 3);
+       device_create_file_in(new_client, 4);
+       device_create_file_in(new_client, 5);
+       device_create_file_in(new_client, 6);
+       device_create_file_in(new_client, 7);
+       device_create_file_in(new_client, 8);
+       device_create_file_in(new_client, 9);
+
+       device_create_file_fan(new_client, 1);
+       device_create_file_fan(new_client, 2);
+       device_create_file_fan(new_client, 3);
+       device_create_file_fan(new_client, 4);
+       device_create_file_fan(new_client, 5);
+
+       device_create_file_temp1(new_client);   /* Temp1 */
+       device_create_file_temp_add(new_client, 2);     /* Temp2 */
+       device_create_file_temp_add(new_client, 3);     /* Temp3 */
+
+       device_create_file_alarms(new_client);
+       device_create_file_beep(new_client);
+
+       device_create_file_vid(new_client);
+       device_create_file_vrm(new_client);
+
+#if defined(TRY_FAN_CRUISE)
+       device_create_file_pwm(new_client, 1);
+       device_create_file_pwm(new_client, 2);
+       device_create_file_pwm(new_client, 3);
+
+       device_create_file_pwmenable(new_client, 1);
+       device_create_file_pwmenable(new_client, 2);
+       device_create_file_pwmenable(new_client, 3);
+
+       device_create_file_fan_cruise(new_client, 1);
+       device_create_file_fan_cruise(new_client, 2);
+       device_create_file_fan_cruise(new_client, 3);
+
+       device_create_file_fan_tolerance(new_client, 1);
+       device_create_file_fan_tolerance(new_client, 2);
+       device_create_file_fan_tolerance(new_client, 3);
+#endif
+
+       return 0;
+
+      ERROR3:
+       if (data->lm75[0] != NULL) {
+               i2c_detach_client(data->lm75[0]);
+               kfree(data->lm75[0]);
+       }
+       if (data->lm75[1] != NULL) {
+               i2c_detach_client(data->lm75[1]);
+               kfree(data->lm75[1]);
+       }
+      ERROR2:
+       i2c_detach_client(new_client);
+      ERROR1:
+       kfree(data);
+      ERROR0:
+       return err;
+}
+
+static int w83791d_detach_client(struct i2c_client *client)
+{
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       int err;
+
+       /* main client */
+       if (data)
+               hwmon_device_unregister(data->class_dev);
+
+       if ((err = i2c_detach_client(client)))
+               return err;
+
+       /* main client */
+       if (data)
+               kfree(data);
+       /* subclient */
+       else
+               kfree(client);
+
+       return 0;
+}
+
+/* The SMBus locks itself, usually, but nothing may access the Winbond between
+   bank switches. ISA access must always be locked explicitly!
+   We ignore the W83791D BUSY flag at this moment - it could lead to
deadlocks,+   would slow down the W83791D access and should not be
necessary.
+   There are some ugly typecasts here, but the good news is - they should
+   nowhere else be necessary! */
+static int w83791d_read_value(struct i2c_client *client, u8 reg)
+{
+       int res = 0;
+       res = i2c_smbus_read_byte_data(client, reg);
+
+       return res;
+}
+
+static int w83791d_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+       i2c_smbus_write_byte_data(client, reg, value);
+       return 0;
+}
+
+/* Called when we have found a new W83791D. It should set limits, etc. */
+static void w83791d_init_client(struct i2c_client *client)
+{
+       struct w83791d_data *data = i2c_get_clientdata(client);
+
+       u8 temp2_cfg, temp3_cfg;
+       u8 old_beep;
+
+       if (init) {
+               /* keep some BIOS settings when we... */
+               old_beep = w83791d_read_value(client, W83791D_REG_BEEP_CONFIG);
+
+               /* ... reset the chip and ... */
+               w83791d_write_value(client, W83791D_REG_CONFIG, 0x80);
+
+               /* ... disable power-on abnormal beep */
+               w83791d_write_value(client, W83791D_REG_BEEP_CONFIG,
+                               old_beep | 0x80);
+
+               /* And diable the global beep */
+               w83791d_write_value(client, W83791D_REG_BEEP_CTRL[1], 0x00);
+       }
+
+       data->vrm = vid_which_vrm();
+
+       temp2_cfg = w83791d_read_value(client, W83791D_REG_TEMP2_CONFIG);
+       temp3_cfg = w83791d_read_value(client, W83791D_REG_TEMP3_CONFIG);
+       w83791d_write_value(client, W83791D_REG_TEMP2_CONFIG,
+                           temp2_cfg & 0xe6);
+       w83791d_write_value(client, W83791D_REG_TEMP3_CONFIG,
+                           temp3_cfg & 0xe6);
+
+       /* Start monitoring */
+       w83791d_write_value(client, W83791D_REG_CONFIG,
+               (w83791d_read_value(client, W83791D_REG_CONFIG) &
0xf7) | 0x01);+}
+
+static struct w83791d_data *w83791d_update_device(struct device *dev)
+{
+       struct i2c_client *client = to_i2c_client(dev);
+       struct w83791d_data *data = i2c_get_clientdata(client);
+       int i, j;
+       u8 reg_array_tmp[3];
+
+#if defined(TRY_FAN_CRUISE)
+        u8 reg_tmp;
+#endif
+
+       down(&data->update_lock);
+
+       if (time_after(jiffies, data->last_updated + (HZ * 3))
+           || time_before(jiffies, data->last_updated) || !data->valid) {
+
+               dev_dbg(dev, "Starting device update\n");
+
+               /* Update the voltages measured value and limits */
+               for (i = 0; i < NUMBER_OF_VIN; i++) {
+                       data->in[i] = w83791d_read_value(client,
+                                               W83791D_REG_IN[i]);
+                       data->in_max[i] = w83791d_read_value(client,
+                                               W83791D_REG_IN_MAX[i]);
+                       data->in_min[i] = w83791d_read_value(client,
+                                               W83791D_REG_IN_MIN[i]);
+               }
+
+               /* Update the fan counts and limits */
+               for (i = 0; i < NUMBER_OF_FANIN; i++) {
+                       /* Update the Fan measured value and limits */
+                       data->fan[i] = w83791d_read_value(client,
+                                               W83791D_REG_FAN[i]);
+                       data->fan_min[i] = w83791d_read_value(client,
+                                               W83791D_REG_FAN_MIN[i]);
+               }
+
+               /* Update the fan divisor */
+               for (i = 0; i < 3; i++) {
+                       reg_array_tmp[i] = w83791d_read_value(client,
+                                               W83791D_REG_FAN_DIV[i]);
+               }
+               data->fan_div[0] = (reg_array_tmp[0] >> 4) & 0x03;
+               data->fan_div[1] = (reg_array_tmp[0] >> 6) & 0x03;
+               data->fan_div[2] = (reg_array_tmp[1] >> 6) & 0x03;
+               data->fan_div[3] = reg_array_tmp[2] & 0x07;
+               data->fan_div[4] = (reg_array_tmp[2] >> 4) & 0x07;
+
+
+               /* Update the first temperature sensor */
+               for (i = 0; i < 3; i++) {
+                       data->temp1[i] = w83791d_read_value(client,
+                                                       W83791D_REG_TEMP1[i]);
+               }
+
+               /* Update the rest of the temperature sensors */
+               for (i = 0; i < 2; i++) {
+                       for (j = 0; j < 6; j++) {
+                               data->temp_add[i][j] +                                       w83791d_read_value(client,
+                                       W83791D_REG_TEMP_ADD[i][j]);
+                       }
+               }
+
+               /* Update the realtime status */
+               data->alarms +                   w83791d_read_value(client, W83791D_REG_ALARM1) +
+                   (w83791d_read_value(client, W83791D_REG_ALARM2) << 8) +
+                   (w83791d_read_value(client, W83791D_REG_ALARM3) << 16);
+
+               /* Update the beep configuration information */
+               data->beep_mask +                  w83791d_read_value(client, W83791D_REG_BEEP_CTRL[0]) +
+                  (w83791d_read_value(client,
W83791D_REG_BEEP_CTRL[1]) << 8) ++                 
(w83791d_read_value(client, W83791D_REG_BEEP_CTRL[2]) << 16);+
+               data->beep_enable +                  (data->beep_mask >> GLOBAL_BEEP_ENABLE_SHIFT) & 0x01;
+
+               /* Update the cpu voltage information */
+               i = w83791d_read_value(client, W83791D_REG_VID_FANDIV);
+               data->vid = i & 0x0f;
+               data->vid |= (w83791d_read_value(client,
+                                       W83791D_REG_CHIPID) & 0x01) << 4;
+
+#if defined(TRY_FAN_CRUISE)
+               /* Update the PWM Value flag */
+               for (i = 0; i < NUMBER_OF_PWM; i++) {
+                       data->pwm[i] = w83791d_read_value(client,
+                                                       W83791D_REG_PWM[i]);
+               }
+
+               reg_tmp = w83791d_read_value(client, W83791D_REG_FAN_CFG[0]);
+               data->pwmenable[0] = (reg_tmp >> 2) & 0x03;
+               data->pwmenable[1] = (reg_tmp >> 4) & 0x03;
+
+               reg_tmp = w83791d_read_value(client, W83791D_REG_FAN_CFG[1]);
+               data->pwmenable[2] = (reg_tmp >> 2) & 0x03;
+
+               for (i = 0; i < NUMBER_OF_PWM; i++) {
+                       data->fan_cruise[i] +                           w83791d_read_value(client,
W83791D_REG_TTARG[i]) & 0x7f;
+               }
+
+               reg_tmp = w83791d_read_value(client, W83791D_REG_TOLERANCE[0]);
+               data->fan_tolerance[0] = reg_tmp & 0x0f;
+               data->fan_tolerance[1] = (reg_tmp >> 4) & 0x0f;
+               data->fan_tolerance[2] = w83791d_read_value(client,
+                                       W83791D_REG_TOLERANCE[1]) & 0x0f;
+#endif
+               data->last_updated = jiffies;
+               data->valid = 1;
+       }
+
+       up(&data->update_lock);
+
+#ifdef DEBUG
+       w83791d_print_debug(data, dev);
+#endif
+
+       return data;
+}
+
+#ifdef DEBUG
+static void w83791d_print_debug(struct w83791d_data *data,
+                               struct device *dev)
+{
+       int i = 0, j = 0;
+       dev_dbg(dev, "===The following is the debug message...===\n");
+       dev_dbg(dev, "%d set of Voltages: ==>\n", NUMBER_OF_VIN);
+       for (i = 0; i < NUMBER_OF_VIN; i++) {
+               dev_dbg(dev, "vin[%d] is: 0x%x\n", i, data->in[i]);
+               dev_dbg(dev, "vin[%d] max is: 0x%x\n", i, data->in_max[i]);
+               dev_dbg(dev, "vin[%d] min is: 0x%x\n", i, data->in_min[i]);
+       }
+
+       dev_dbg(dev, "%d set of Fan Counts/Divisors: ==>\n", NUMBER_OF_FANIN);
+       for (i = 0; i < NUMBER_OF_FANIN; i++) {
+               dev_dbg(dev, "fan[%d] is: 0x%x\n", i, data->fan[i]);
+               dev_dbg(dev, "fan[%d] min is: 0x%x\n", i, data->fan_min[i]);
+               dev_dbg(dev, "fan_div[%d] is: 0x%x\n", i, data->fan_div[i]);
+       }
+
+#if defined(TRY_FAN_CRUISE)
+       dev_dbg(dev, "%d set of Pwm: ==>\n", NUMBER_OF_PWM);
+       for (i = 0; i < NUMBER_OF_PWM; i++) {
+               dev_dbg(dev, "pwm[%d] is: 0x%x\n", i, data->pwm[i]);
+               dev_dbg(dev, "pwmenable[%d] is: 0x%x\n", i,
data->pwmenable[i]);+       }
+
+       dev_dbg(dev, "%d set of Fan Cruise registers: ==>\n", NUMBER_OF_PWM);
+       for (i = 0; i < NUMBER_OF_PWM; i++) {
+               dev_dbg(dev, "fan_cruise[%d] is: 0x%x\n",
+                       i, data->fan_cruise[i]);
+               dev_dbg(dev, "fan_tolerance[%d] is: 0x%x\n",
+                       i, data->fan_tolerance[i]);
+       }
+#endif
+
+       dev_dbg(dev, "%d set of Temperatures: ==>\n", NUMBER_OF_TEMPIN);
+       for (i = 0; i < 3; i++) {
+               dev_dbg(dev, "temp1[%d] is: 0x%x\n", i, data->temp1[i]);
+       }
+       for (i = 0; i < 2; i++) {
+               for (j = 0; j < 6; j++) {
+                       dev_dbg(dev, "temp_add[%d][%d] is: 0x%x\n", i, j,
+                               data->temp_add[i][j]);
+               }
+       }
+
+       dev_dbg(dev, "Misc Information: ==>\n");
+       dev_dbg(dev, "alarm is: 0x%08x\n", data->alarms);
+       dev_dbg(dev, "beep_mask is: 0x%08x\n", data->beep_mask);
+       dev_dbg(dev, "beep_enable is: 0x%08x\n", data->beep_enable);
+       dev_dbg(dev, "vid is: 0x%04x\n", data->vid);
+       dev_dbg(dev, "vrm is: 0x%04x\n", data->vrm);
+       dev_dbg(dev, "====End of the debug message...====\n");
+       dev_dbg(dev, "\n");
+}
+
+#endif
+
+static int __init sensors_w83791d_init(void)
+{
+       return i2c_add_driver(&w83791d_driver);
+}
+
+static void __exit sensors_w83791d_exit(void)
+{
+       i2c_del_driver(&w83791d_driver);
+}
+
+MODULE_AUTHOR("Charles Spirakis<bezaur at gmail.com>");
+MODULE_DESCRIPTION("W83791D driver for linux-2.6");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_w83791d_init);
+module_exit(sensors_w83791d_exit);

