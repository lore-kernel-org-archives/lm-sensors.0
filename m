From: George Joseph <George.Joseph@fairview5.com>
Date: Thu, 29 May 2008 05:04:10 +0000
Subject: [lm-sensors] [PATCH] add asc7621 hardware monitoring chip
Message-Id: <F087D2902E92CF4FAB25626A04CD5DA80257BD7893@s0.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

OK, finally getting around to submitting this and I've got plenty
of time to incorporate feedback.


Signed-off-by: George Joseph <George.joseph@fairview5.com>

diff -urpN linux-2.6.25.4/Documentation/hwmon/asc7621 linux-2.6.25.4-gtj/Do=
cumentation/hwmon/asc7621
--- linux-2.6.25.4/Documentation/hwmon/asc7621  1969-12-31 17:00:00.0000000=
00 -0700
+++ linux-2.6.25.4-gtj/Documentation/hwmon/asc7621      2008-05-28 21:35:42=
.114418040 -0600
@@ -0,0 +1,297 @@
+Kernel driver asc7621
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Andigilog aSC7621, aSC7621a
+    Prefix: 'asc7621'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.andigilog.com/downloads/aSC7621_70A06010.pdf
+
+Author:
+               George Joseph
+
+
+Description provided by Dave Pivin @ Andigilog:
+
+Andigilog has both the PECI and pre-PECI versions of the Heceta-6, as
+Intel calls them. Heceta-6e has high frequency PWM and Heceta-6p has
+added PECI and a 4th thermal zone. The Andigilog aSC7611 is the
+Heceta-6e part and aSC7621 is the Heceta-6p part. They are both in
+volume production, shipping to Intel and their subs.
+
+We have enhanced both parts relative to the governing Intel
+specification. First enhancement is temperature reading resolution. We
+have used registers below 20h for vendor-specific functions in addition
+to those in the Intel-specified vendor range.
+
+Our conversion process produces a result that is reported as two bytes.
+The fan speed control uses this finer value to produce a "step-less" fan
+PWM output. These two bytes are "read-locked" to guarantee that once a
+high or low byte is read, the other byte is locked-in until after the
+next read of any register. So to get an atomic reading, read high or low
+byte, then the very next read should be the opposite byte. Our data
+sheet says 10-bits of resolution, although you may find the lower bits
+are active, they are not necessarily reliable or useful externally. We
+chose not to mask them.
+
+We employ significant filtering that is user tunable as described in the
+data sheet. Our temperature reports and fan PWM outputs are very smooth
+when compared to the competition, in addition to the higher resolution
+temperature reports. The smoother PWM output does not require user
+intervention.
+
+We offer GPIO features on the former VID pins. These are open-drain
+outputs or inputs and may be used as general purpose I/O or as alarm
+outputs that are based on temperature limits. These are in 19h and 1Ah.
+
+We offer flexible mapping of temperature readings to thermal zones. Any
+temperature may be mapped to any zone, which has a default assignment
+that follows Intel's specs.
+
+Since there is a fan to zone assignment that allows for the "hotter" of
+a set of zones to control the PWM of an individual fan, but there is no
+indication to the user, we have added an indicator that shows which zone
+is currently controlling the PWM for a given fan. This is in register
+00h.
+
+Both remote diode temperature readings may be given an offset value such
+that the reported reading as well as the temperature used to determine
+PWM may be offset for system calibration purposes.
+
+PECI Extended configuration allows for having more than two domains per
+PECI address and also provides an enabling function for each PECI
+address. One could use our flexible zone assignment to have a zone
+assigned to up to 4 PECI addresses. This is not possible in the default
+Intel configuration. This would be useful in multi-CPU systems with
+individual fans on each that would benefit from individual fan control.
+This is in register 0Eh.
+
+The tachometer measurement system is flexible and able to adapt to many
+fan types. We can also support pulse-stretched PWM so that 3-wire fans
+may be used. These characteristics are in registers 04h to 07h.
+
+Finally, we have added a tach disable function that turns off the tach
+measurement system for individual tachs in order to save power. That is
+in register 75h.
+
+--
+aSC7621 Product Description
+
+The aSC7621 has a two wire digital interface compatible with SMBus 2.0.
+Using a 10-bit ADC, the aSC7621 measures the temperature of two remote dio=
de
+connected transistors as well as its own die. Support for Platform
+Environmental Control Interface (PECI) is included.
+
+Using temperature information from these four zones, an automatic fan speed
+control algorithm is employed to minimize acoustic impact while achieving
+recommended CPU temperature under varying operational loads.
+
+To set fan speed, the aSC7621 has three independent pulse width modulation
+(PWM) outputs that are controlled by one, or a combination of three,
+temperature zones. Both high- and low-frequency PWM ranges are supported.
+
+The aSC7621 also includes a digital filter that can be invoked to smooth
+temperature readings for better control of fan speed and minimum acoustic
+impact.
+
+The aSC7621 has tachometer inputs to measure fan speed on up to four fans.
+Limit and status registers for all measured values are included to alert
+the system host that any measurements are outside of programmed limits
+via status registers.
+
+System voltages of VCCP, 2.5V, 3.3V, 5.0V, and 12V motherboard power are
+monitored efficiently with internal scaling resistors.
+
+Features
+- Supports PECI interface and monitors internal and remote thermal diodes
+- 2-wire, SMBus 2.0 compliant, serial interface
+- 10-bit ADC
+- Monitors VCCP, 2.5V, 3.3V, 5.0V, and 12V motherboard/processor supplies
+- Programmable autonomous fan control based on temperature readings
+- Noise filtering of temperature reading for fan speed control
+- 0.25=EF=BF=BDC digital temperature sensor resolution
+- 3 PWM fan speed control outputs for 2-, 3- or 4-wire fans and up to 4 fan
+       tachometer inputs
+- Enhanced measured temperature to Temperature Zone assignment.
+- Provides high and low PWM frequency ranges
+- 3 GPIO pins for custom use
+- 24-Lead QSOP package
+
+Configuration Notes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Except where noted below, the sysfs entries created by this driver follow
+the standards defined in "sysfs-interface".
+
+temp1_source
+       0       (default) peci_legacy =3D 0, Remote 1 Temperature
+                       peci_legacy =3D 1, PECI Processor Temperature 0
+       1       Remote 1 Temperature
+       2       Remote 2 Temperature
+       3       Internal Temperature
+       4       PECI Processor Temperature 0
+       5       PECI Processor Temperature 1
+       6       PECI Processor Temperature 2
+       7   PECI Processor Temperature 3
+
+temp2_source
+       0       (default) Internal Temperature
+       1       Remote 1 Temperature
+       2       Remote 2 Temperature
+       3       Internal Temperature
+       4       PECI Processor Temperature 0
+       5       PECI Processor Temperature 1
+       6       PECI Processor Temperature 2
+       7       PECI Processor Temperature 3
+
+temp3_source
+       0       (default) Remote 2 Temperature
+       1       Remote 1 Temperature
+       2       Remote 2 Temperature
+       3       Internal Temperature
+       4       PECI Processor Temperature 0
+       5       PECI Processor Temperature 1
+       6       PECI Processor Temperature 2
+       7       PECI Processor Temperature 3
+
+temp4_source
+       0       (default) peci_legacy =3D 0, PECI Processor Temperature 0
+                       peci_legacy =3D 1, Remote 1 Temperature
+       1       Remote 1 Temperature
+       2       Remote 2 Temperature
+       3       Internal Temperature
+       4       PECI Processor Temperature 0
+       5       PECI Processor Temperature 1
+       6       PECI Processor Temperature 2
+       7       PECI Processor Temperature 3
+
+temp[1-4]_smoothing_enable
+temp[1-4]_smoothing_time
+       Smooths spikes in temp readings caused by noise.
+       0       35 sec
+       1       17.6 sec
+       2       11.8 sec
+       3       7.0 sec
+       4       4.4 sec
+       5       3.0 sec
+       6       1.6 sec
+       7       0.8 sec
+
+temp[1-4]_crit
+       When the corresponding zone temperature reaches this value,
+       ALL pwm outputs will got to 100%.
+
+temp[5-8]_input
+temp[5-8]_enable
+       The aSC7621 can also read temperatures provided by the processor
+       via the PECI bus.  Usually these are "core" temps and are relative
+       to the point where the automatical thermal control circuit starts
+       throttling.  This means that these are usually negative numbers.
+
+pwm[1-3]_enable
+       0               Fan off.
+       1               Fan on manual control.
+       2               Fan on automatic control and will run at the minimu=
m pwm
+                               if the temperature for the zone is below th=
e minimum.
+       3               Fan on automatic control but will be off if the tem=
perature
+                               for the zone is below the minimum.
+       4-254   Ignored.
+       255             Fan on full.
+
+pwm[1-3]_auto_channels
+       Bitmap as described in sysctl-interface with the following
+       exceptions...
+       Only the following combinations of zones (and their corresponding m=
asks)
+       are valid:
+       1
+       2
+       3
+       2,3
+       1,2,3
+       4
+       1,2,3,4
+
+       Special values:
+       0               Disabled.
+       16              Fan on manual control.
+       31              Fan on full.
+
+
+pwm[1-3]_invert
+       When set, inverts the meaning of pwm[1-3].
+       I.E.  when pwm =3D 0, the fan will be on full and
+       when pwm =3D 255 the fan will be off.
+
+pwm[1-3]_freq
+       PWM frequency in Hz
+       Valid values in Hz are:
+
+       10
+       15
+       23
+       30  (default)
+       38
+       47
+       62
+       94
+       23000
+       24000
+       25000
+       26000
+       27000
+       28000
+       29000
+       30000
+
+       Setting any other value will be ignored.
+
+peci_enable
+       Enables or disables PECI
+
+peci_avg
+       Input filter averate time.
+
+       0       0 Sec. (no Smoothing) (default)
+       1       0.25 Sec.
+       2       0.5 Sec.
+       3       1.0 Sec.
+       4       2.0 Sec.
+       5       4.0 Sec.
+       6       8.0 Sec.
+       7       0.0 Sec
+
+peci_legacy
+
+       0       Standard Mode (default)
+               Remote Diode 1 reading is associated with
+               Temperature Zone 1, PECI is associated with
+               Zone 4
+
+       1       Legacy Mode
+               PECI is associated with Temperature Zone 1,
+               Remote Diode 1 is associated with Zone 4
+
+peci_diode
+       Diode filter
+
+       0       0.25 Sec.
+       1       1.1 Sec.
+       2       2.4 Sec.  (default)
+       3       3.4 Sec.
+       4       5.0 Sec.
+       5       6.8 Sec.
+       6       10.2 Sec.
+       7       16.4 Sec.
+
+peci_4domain
+       Four domain enable
+
+       0       1 or 2 Domains for enabled processors (default)
+       1       3 or 4 Domains for enabled processors
+
+peci_domain
+       Domain
+
+       0       Processor contains a single domain (0)   (default)
+       1       Processor contains two domains (0,1)
+
diff -urpN linux-2.6.25.4/drivers/hwmon/asc7621.c linux-2.6.25.4-gtj/driver=
s/hwmon/asc7621.c
--- linux-2.6.25.4/drivers/hwmon/asc7621.c      1969-12-31 17:00:00.0000000=
00 -0700
+++ linux-2.6.25.4-gtj/drivers/hwmon/asc7621.c  2008-05-28 21:36:24.6715471=
95 -0600
@@ -0,0 +1,1322 @@
+/*
+    asc7621.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2007 George Joseph  <george.joseph@fairview5.com>
+
+    Chip details at <http://www.andigilog.com>
+
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] =3D {
+       0x2c, 0x2d, 0x2e, I2C_CLIENT_END
+};
+
+/*
+ * Insmod parameters
+ * This macro also creates the "chips" enum referenced later.
+ */
+I2C_CLIENT_INSMOD_2(asc7621, asc7621a);
+
+#define INTERVAL_HIGH  (HZ + HZ / 2)
+#define INTERVAL_LOW  (1 * 60 * HZ)
+#define PRI_NONE 0
+#define PRI_LOW 1
+#define PRI_HIGH 2
+#define FIRST_CHIP asc7621
+#define LAST_CHIP asc7621a
+
+struct asc7621_chip {
+       char *name;
+       enum chips chip_type;
+       u8 company_reg;
+       u8 company_id;
+       u8 verstep_reg;
+       u8 verstep_id;
+       unsigned short *addresses;
+};
+/*
+ * The "chips" enum created by I2C_CLIENT_INSMOD_2 has "any_chip" as
+ * the first element in the enum, so it must also be first in our array.
+ */
+static struct asc7621_chip asc7621_chips[] =3D {
+       {
+        .name =3D "any",.chip_type =3D any_chip,
+        },
+       {
+        .name =3D "asc7621",.chip_type =3D asc7621,
+        .company_reg =3D 0x3e,.company_id =3D 0x61,
+        .verstep_reg =3D 0x3f,.verstep_id =3D 0x6c,
+        .addresses =3D normal_i2c,
+        },
+       {
+        .name =3D "asc7621a",.chip_type =3D asc7621a,
+        .company_reg =3D 0x3e,.company_id =3D 0x61,
+        .verstep_reg =3D 0x3f,.verstep_id =3D 0x6d,
+        .addresses =3D normal_i2c,
+        },
+};
+
+/*
+ * Defines the highest register to be used, not the count.
+ * The actual count will probably be smaller because of gaps
+ * in the implementation (unused register locations).
+ * This define will safely set the array size of both the parameter
+ * and data arrays.
+ * This comes from the data sheet register description table.
+ */
+#define LAST_REGISTER 0xff
+
+struct asc7621_data {
+       struct i2c_client client;
+       struct device *class_dev;
+       struct mutex update_lock;
+       int valid;              /* !=3D0 if following fields are valid */
+       unsigned long last_high_reading;        /* In jiffies */
+       unsigned long last_low_reading; /* In jiffies */
+
+       /*
+        * Registers we care about occupy the corresponding index
+        * in the array.  Registers we don't care about are left
+        * at 0.
+        */
+       u8 reg[LAST_REGISTER + 1];
+};
+
+/*
+ * Macro to get the parent asc7621_param structure
+ * from a sensor_device_attribute passed into the
+ * show/store functions.
+ */
+#define to_asc7621_param(_sda) \
+       container_of(_sda, struct asc7621_param, sda)
+
+/*
+ * Each parameter to be retrieved needs an asc7621_param structure
+ * allocated.  It contains the sensor_device_attribute structure
+ * and the control info needed to retrieve the value from the register map.
+*/
+struct asc7621_param {
+       struct sensor_device_attribute sda;
+       u8 priority;
+       u8 msb[3];
+       u8 lsb[3];
+       u8 mask[3];
+       u8 shift[3];
+       u8 value;
+       char *label;
+};
+
+/*
+ * This is the map that ultimately indicates whether we'll be
+ * retrieving a register value or not, and at what frequency.
+ */
+static u8 asc7621_register_priorities[255];
+
+static struct asc7621_data *asc7621_update_device(struct device *dev);
+
+#define read_byte(reg) (i2c_smbus_read_byte_data(client, reg) & 0xff)
+#define write_byte(reg, data) i2c_smbus_write_byte_data(client, reg, data)
+
+/*******************************************************
+ *         Data Handlers
+ * Each function handles the formatting, storage
+ * and retrieval of like parameters.
+ *
+ *******************************************************/
+
+#define SETUP_SHOW_data_param(d, a) \
+       struct sensor_device_attribute *sda =3D to_sensor_dev_attr(a); \
+       struct asc7621_data *data =3D asc7621_update_device(d); \
+       struct asc7621_param *param =3D to_asc7621_param(sda)
+
+#define SETUP_STORE_data_param(d, a) \
+       struct sensor_device_attribute *sda =3D to_sensor_dev_attr(a); \
+       struct i2c_client *client =3D to_i2c_client(d); \
+       struct asc7621_data *data =3D i2c_get_clientdata(client); \
+       struct asc7621_param *param =3D to_asc7621_param(sda)
+
+/*
+ * u8 is just what it sounds like...an unsigned byte with no
+ * special formatting.
+ */
+static ssize_t show_u8(struct device *dev, struct device_attribute *attr,
+                      char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       return sprintf(buf, "%u\n", data->reg[param->msb[0]]);
+}
+
+static ssize_t store_u8(struct device *dev, struct device_attribute *attr,
+                       const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u8 reqval =3D simple_strtoul(buf, NULL, 10);
+
+       mutex_lock(&data->update_lock);
+       data->reg[param->msb[0]] =3D reqval;
+       write_byte(param->msb[0], reqval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+/*
+ * Many of the config values occupy only a few bits of a register.
+ */
+static ssize_t show_bitmask(struct device *dev,
+                           struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       return sprintf(buf, "%u\n",
+                      (data->reg[param->msb[0]] >> param->shift[0]) & para=
m->
+                      mask[0]);
+}
+
+static ssize_t store_bitmask(struct device *dev,
+                            struct device_attribute *attr,
+                            const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u8 reqval =3D simple_strtoul(buf, NULL, 10);
+       u8 currval;
+
+       reqval =3D (reqval & param->mask[0]) << param->shift[0];
+
+       mutex_lock(&data->update_lock);
+       currval =3D read_byte(param->msb[0]);
+       reqval |=3D (currval & ~(param->mask[0] << param->shift[0]));
+       data->reg[param->msb[0]] =3D reqval;
+       write_byte(param->msb[0], reqval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+/* 16 bit fan rpm values
+ *
+ * reported by the device as the number of 11.111us periods (90khz)
+ * between full fan rotations.  Therefore...
+ *
+ * RPM =3D (90000 * 60) / register value
+ *
+ */
+static ssize_t show_fan16(struct device *dev,
+                         struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u16 regval =3D (data->reg[param->msb[0]] << 8) | data->reg[param->l=
sb[0]];
+
+       return sprintf(buf, "%u\n",
+                      (regval =3D 0 ? -1 : (regval) =3D
+                       0xffff ? 0 : 5400000 / regval));
+}
+
+static ssize_t store_fan16(struct device *dev,
+                          struct device_attribute *attr, const char *buf,
+                          size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u16 reqval =3D simple_strtoul(buf, NULL, 10);
+
+       reqval +           (SENSORS_LIMIT((reqval) <=3D 0 ? 0 : 5400000 / (=
reqval), 0, 65534));
+
+       mutex_lock(&data->update_lock);
+       data->reg[param->msb[0]] =3D (reqval >> 8) & 0xff;
+       data->reg[param->lsb[0]] =3D reqval & 0xff;
+       write_byte(param->msb[0], data->reg[param->msb[0]]);
+       write_byte(param->lsb[0], data->reg[param->lsb[0]]);
+       mutex_unlock(&data->update_lock);
+
+       return count;
+}
+
+/* Voltages are scaled in the device so that the nominal voltage
+ * is 3/4ths of the 0-255 range (I.E 192).
+ * If all voltages are 'normal' then all voltage registers will
+ * read 0xC0.  This doesn't help us if we don't have a point of refernce.
+ * The data sheet however provides us with the full scale value for each
+ * which is stored in in_scaling.  The sda->index parameter value provides
+ * the index into in_scaling.
+ *
+ * NOTE: The chip expects the first 2 inputs be 2.5 and 2.25 volts
+ * respectively. That doesn't mean that's what the motherboard provides. :)
+ */
+
+static int asc7621_in_scaling[] =3D {
+       3320, 3000, 4380, 6640, 16000
+};
+
+static ssize_t show_in10(struct device *dev, struct device_attribute *attr,
+                        char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 nr =3D sda->index;
+       u16 regval =3D (data->reg[param->msb[0]] * asc7621_in_scaling[nr]) =
/ 256;
+
+       /* The LSB value is a 2-bit scaling of the MSB's LSbit value.
+        * I.E.  If the maximim voltage for this input is 6640 millivolts t=
hen
+        * a MSB register value of 0 =3D 0mv and 255 =3D 6640mv.
+        * A 1 step change therefore represents 25.9mv (6640 / 256).
+        * The extra 2-bits therefore represent increments of 6.48mv.
+        */
+       regval +=3D ((asc7621_in_scaling[nr] / 256) / 4) *
+           (data->reg[param->lsb[0]] >> 6);
+
+       return sprintf(buf, "%u\n", regval);
+}
+
+/* 8 bit voltage values (the mins and maxs) */
+static ssize_t show_in8(struct device *dev, struct device_attribute *attr,
+                       char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 nr =3D sda->index;
+
+       return sprintf(buf, "%u\n",
+                      ((data->reg[param->msb[0]] *
+                        asc7621_in_scaling[nr]) / 256));
+}
+
+static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
+                        const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u8 nr =3D sda->index;
+       u8 reqval =3D simple_strtoul(buf, NULL, 10);
+       reqval +           SENSORS_LIMIT(((reqval * 256) / asc7621_in_scali=
ng[nr]), 0, 255);
+
+       mutex_lock(&data->update_lock);
+       data->reg[param->msb[0]] =3D reqval;
+       write_byte(param->msb[0], reqval);
+       mutex_unlock(&data->update_lock);
+
+       return count;
+}
+
+static ssize_t show_temp8(struct device *dev,
+                         struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       return sprintf(buf, "%d\n", ((s8) data->reg[param->msb[0]]) * 1000);
+}
+
+static ssize_t store_temp8(struct device *dev,
+                          struct device_attribute *attr, const char *buf,
+                          size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       s32 reqval =3D simple_strtol(buf, NULL, 10);
+       s8 temp =3D SENSORS_LIMIT((reqval / 1000), -127, 127);
+
+       mutex_lock(&data->update_lock);
+       data->reg[param->msb[0]] =3D temp;
+       write_byte(param->msb[0], temp);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+/*
+ * Temperatures that occupy 2 bytes always have the whole
+ * number of degrees in the MSB with some part of the LSB
+ * indicating fractional degrees.
+ */
+
+/*   mmmmmmmm.llxxxxxx */
+static ssize_t show_temp10(struct device *dev,
+                          struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 msb =3D data->reg[param->msb[0]];
+       u8 lsb =3D (data->reg[param->lsb[0]] >> 6) & 0x03;
+       int temp =3D (((s8) msb) * 1000) + (lsb * 250);
+
+       return sprintf(buf, "%d\n", temp);
+}
+
+/*   mmmmmm.ll */
+static ssize_t show_temp62(struct device *dev,
+                          struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 regval =3D data->reg[param->msb[0]];
+       u32 temp =3D ((s8) (regval & 0xfc) * 1000) + ((regval & 0x03) * 250=
);
+
+       return sprintf(buf, "%d\n", temp);
+}
+
+static ssize_t store_temp62(struct device *dev,
+                           struct device_attribute *attr, const char *buf,
+                           size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       s32 reqval =3D simple_strtol(buf, NULL, 10);
+       reqval =3D SENSORS_LIMIT(reqval, -32000, 31750);
+       s32 i, f;
+       s8 temp;
+       i =3D reqval / 1000;
+       f =3D reqval - (i * 1000);
+       temp =3D i << 2;
+       temp |=3D f / 250;
+
+       mutex_lock(&data->update_lock);
+       data->reg[param->msb[0]] =3D temp;
+       write_byte(param->msb[0], temp);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+/*
+ * The aSC7621 doesn't provide an "auto_point2".  Instead, you
+ * specify the auto_point1 and a range.  To keep with the sysfs
+ * hwmon specs, we synthesize the auto_point_2 from them.
+ */
+
+static u32 asc7621_range_map[] =3D {
+       2000, 2500, 3330, 4000, 5000, 6670, 8000, 10000,
+       13330, 16000, 20000, 26670, 32000, 40000, 53330, 80000,
+};
+
+static ssize_t show_ap2_temp(struct device *dev,
+                            struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       s32 auto_point1 =3D ((s8) data->reg[param->msb[1]]) * 1000;
+       u8 regval +           ((data->reg[param->msb[0]] >> param->shift[0]=
) & param->mask[0]);
+       s32 temp +           auto_point1 + asc7621_range_map[SENSORS_LIMIT(=
regval, 0, 15)];
+
+       return sprintf(buf, "%d\n", temp);
+
+}
+
+static ssize_t store_ap2_temp(struct device *dev,
+                             struct device_attribute *attr,
+                             const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       s32 reqval =3D simple_strtoul(buf, NULL, 10);
+       s32 auto_point1 =3D data->reg[param->msb[1]] * 1000;
+       s8 i =3D 0;
+       u8 currval =3D 0;
+       u8 newval =3D 255;
+
+       for (i =3D ARRAY_SIZE(asc7621_range_map) - 1; i >=3D 0; i--) {
+               if (reqval >=3D auto_point1 + asc7621_range_map[i]) {
+                       newval =3D i;
+                       break;
+               }
+       }
+       if (newval =3D 255)
+               return count;
+
+       newval =3D (newval & param->mask[0]) << param->shift[0];
+
+       mutex_lock(&data->update_lock);
+       currval =3D read_byte(param->msb[0]);
+       newval |=3D (currval & ~(param->mask[0] << param->shift[0]));
+       data->reg[param->msb[0]] =3D newval;
+       write_byte(param->msb[0], newval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+static ssize_t show_pwm_ac(struct device *dev,
+                          struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 config +           (data->reg[param->msb[0]] >> param->shift[0])=
 & param->mask[0];
+       u8 altbit +           (data->reg[param->msb[1]] >> param->shift[1])=
 & param->mask[1];
+       u8 regval =3D config | (altbit << 3);
+       u8 map[] =3D {
+               0x01, 0x02, 0x04, 0x1f, 0x00, 0x06, 0x07, 0x10,
+               0x08, 0x0f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f
+       };
+
+       return sprintf(buf, "%u\n", map[SENSORS_LIMIT(regval, 0, 15)]);
+}
+
+static ssize_t store_pwm_ac(struct device *dev,
+                           struct device_attribute *attr,
+                           const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u8 reqval =3D simple_strtoul(buf, NULL, 10);
+       u8 currval =3D 0;
+       u8 config =3D 0;
+       u8 altbit =3D 0;
+       u8 newval =3D 0;
+       u16 map[] =3D {
+               0x04, 0x00, 0x01, 0xff, 0x02, 0xff, 0x05, 0x06,
+               0x08, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0f,
+               0x07, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+               0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x03,
+       };
+
+       if (reqval > 31)
+               return count;
+
+       reqval =3D map[reqval];
+
+       config =3D reqval & 0x07;
+       altbit =3D (reqval >> 3) & 0x01;
+
+       config =3D (config & param->mask[0]) << param->shift[0];
+       altbit =3D (altbit & param->mask[1]) << param->shift[1];
+
+       mutex_lock(&data->update_lock);
+       currval =3D read_byte(param->msb[0]);
+       newval =3D config | (currval & ~(param->mask[0] << param->shift[0])=
);
+       newval =3D altbit | (newval & ~(param->mask[1] << param->shift[1]));
+       data->reg[param->msb[0]] =3D newval;
+       write_byte(param->msb[0], newval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+static ssize_t show_pwm_enable(struct device *dev,
+                              struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 config +           (data->reg[param->msb[0]] >> param->shift[0])=
 & param->mask[0];
+       u8 altbit +           (data->reg[param->msb[1]] >> param->shift[1])=
 & param->mask[1];
+       u8 minoff +           (data->reg[param->msb[2]] >> param->shift[2])=
 & param->mask[2];
+       u8 val =3D config | (altbit << 3);
+       u8 newval =3D 0;
+
+       if (val =3D 3 || val >=3D 10)
+               newval =3D 255;
+       else if (val =3D 4)
+               newval =3D 0;
+       else if (val =3D 7)
+               newval =3D 1;
+       else if (minoff =3D 1)
+               newval =3D 2;
+       else
+               newval =3D 3;
+
+       return sprintf(buf, "%u\n", newval);
+}
+
+static ssize_t store_pwm_enable(struct device *dev,
+                               struct device_attribute *attr,
+                               const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u8 reqval =3D simple_strtoul(buf, NULL, 10);
+       u8 currval =3D 0;
+       u8 config =3D 0;
+       u8 altbit =3D 0;
+       u8 newval =3D 0;
+       u8 minoff =3D 255;
+
+       switch (reqval) {
+       case (0):
+               newval =3D 0x04;
+               break;
+       case (1):
+               newval =3D 0x07;
+               break;
+       case (2):
+               newval =3D 0x00;
+               minoff =3D 1;
+               break;
+       case (3):
+               newval =3D 0x00;
+               minoff =3D 0;
+               break;
+       case (255):
+               newval =3D 0x03;
+               break;
+       default:
+               return count;
+       }
+
+       config =3D newval & 0x07;
+       altbit =3D (newval >> 3) & 0x01;
+
+       mutex_lock(&data->update_lock);
+       config =3D (config & param->mask[0]) << param->shift[0];
+       altbit =3D (altbit & param->mask[1]) << param->shift[1];
+       currval =3D read_byte(param->msb[0]);
+       newval =3D config | (currval & ~(param->mask[0] << param->shift[0])=
);
+       newval =3D altbit | (newval & ~(param->mask[1] << param->shift[1]));
+       data->reg[param->msb[0]] =3D newval;
+       write_byte(param->msb[0], newval);
+       if (minoff < 255) {
+               minoff =3D (minoff & param->mask[2]) << param->shift[2];
+               currval =3D read_byte(param->msb[2]);
+               newval +                   minoff | (currval & ~(param->mas=
k[2] << param->shift[2]));
+               data->reg[param->msb[2]] =3D newval;
+               write_byte(param->msb[2], newval);
+       }
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+static u32 asc7621_pwm_freq_map[] =3D {
+       10, 15, 23, 30, 38, 47, 62, 94,
+       23000, 24000, 25000, 26000, 27000, 28000, 29000, 30000
+};
+
+static ssize_t show_pwm_freq(struct device *dev,
+                            struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 regval +           (data->reg[param->msb[0]] >> param->shift[0])=
 & param->mask[0];
+       regval =3D SENSORS_LIMIT(regval, 0, ARRAY_SIZE(asc7621_pwm_freq_map=
) - 1);
+
+       return sprintf(buf, "%u\n", asc7621_pwm_freq_map[regval]);
+}
+
+static ssize_t store_pwm_freq(struct device *dev,
+                             struct device_attribute *attr,
+                             const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u32 reqval =3D simple_strtoul(buf, NULL, 10);
+       u8 currval =3D 0;
+       u8 newval =3D 255;
+       u32 i;
+
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_pwm_freq_map); i++) {
+               if (reqval =3D asc7621_pwm_freq_map[i]) {
+                       newval =3D i;
+                       break;
+               }
+       }
+       if (newval =3D 255)
+               return count;
+
+       newval =3D (newval & param->mask[0]) << param->shift[0];
+
+       mutex_lock(&data->update_lock);
+       currval =3D read_byte(param->msb[0]);
+       newval |=3D (currval & ~(param->mask[0] << param->shift[0]));
+       data->reg[param->msb[0]] =3D newval;
+       write_byte(param->msb[0], newval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+static u32 asc7621_pwm_auto_spinup_map[] +    { 0, 100, 250, 400, 700, 100=
0, 2000, 4000 };
+
+static ssize_t show_pwm_ast(struct device *dev,
+                           struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 regval +           (data->reg[param->msb[0]] >> param->shift[0])=
 & param->mask[0];
+       regval +           SENSORS_LIMIT(regval, 0,
+                         ARRAY_SIZE(asc7621_pwm_auto_spinup_map) - 1);
+
+       return sprintf(buf, "%u\n", asc7621_pwm_auto_spinup_map[regval]);
+
+}
+
+static ssize_t store_pwm_ast(struct device *dev,
+                            struct device_attribute *attr,
+                            const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u16 reqval =3D simple_strtoul(buf, NULL, 10);
+       u8 currval =3D 0;
+       u8 newval =3D 255;
+       u32 i;
+
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_pwm_auto_spinup_map); i++) {
+               if (reqval =3D asc7621_pwm_auto_spinup_map[i]) {
+                       newval =3D i;
+                       break;
+               }
+       }
+       if (newval =3D 255)
+               return count;
+
+       newval =3D (newval & param->mask[0]) << param->shift[0];
+
+       mutex_lock(&data->update_lock);
+       currval =3D read_byte(param->msb[0]);
+       newval |=3D (currval & ~(param->mask[0] << param->shift[0]));
+       data->reg[param->msb[0]] =3D newval;
+       write_byte(param->msb[0], newval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+static u32 asc7621_temp_smoothing_time_map[] +    { 35000, 17600, 11800, 7=
000, 4400, 3000, 1600, 800 };
+
+static ssize_t show_temp_st(struct device *dev,
+                           struct device_attribute *attr, char *buf)
+{
+       SETUP_SHOW_data_param(dev, attr);
+
+       u8 regval +           (data->reg[param->msb[0]] >> param->shift[0])=
 & param->mask[0];
+       regval +           SENSORS_LIMIT(regval, 0,
+                         ARRAY_SIZE(asc7621_temp_smoothing_time_map) - 1);
+
+       return sprintf(buf, "%u\n", asc7621_temp_smoothing_time_map[regval]=
);
+}
+
+static ssize_t store_temp_st(struct device *dev,
+                            struct device_attribute *attr,
+                            const char *buf, size_t count)
+{
+       SETUP_STORE_data_param(dev, attr);
+
+       u16 reqval =3D simple_strtoul(buf, NULL, 10);
+       u8 currval;
+       u8 newval =3D 255;
+       u32 i;
+
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_pwm_auto_spinup_map); i++) {
+               if (reqval =3D asc7621_temp_smoothing_time_map[i]) {
+                       newval =3D i;
+                       break;
+               }
+       }
+
+       if (newval =3D 255)
+               return count;
+
+       newval =3D (newval & param->mask[0]) << param->shift[0];
+
+       mutex_lock(&data->update_lock);
+       currval =3D read_byte(param->msb[0]);
+       newval |=3D (currval & ~(param->mask[0] << param->shift[0]));
+       data->reg[param->msb[0]] =3D newval;
+       write_byte(param->msb[0], newval);
+       mutex_unlock(&data->update_lock);
+       return count;
+}
+
+static ssize_t show_const(struct device *dev,
+                         struct device_attribute *attr, char *buf)
+{
+       struct sensor_device_attribute *sda =3D to_sensor_dev_attr(attr);
+       struct asc7621_param *param =3D to_asc7621_param(sda);
+
+       return sprintf(buf, "%d\n", param->value);
+}
+
+static ssize_t show_label(struct device *dev,
+                         struct device_attribute *attr, char *buf)
+{
+       struct sensor_device_attribute *sda =3D to_sensor_dev_attr(attr);
+       struct asc7621_param *param =3D to_asc7621_param(sda);
+       if (param->label =3D NULL)
+               return (0);
+       return sprintf(buf, "%s\n", param->label);
+}
+
+/*   End of data handlers  */
+
+/*  These defines do nothing more than make the table easier
+ *  to read when wrapped at column 80.
+ */
+
+/*
+ * Creates a variable length array inititalizer.
+ * VAA(1,3,5,7) would produce {1,3,5,7}
+ */
+#define VAA(args...) {args}
+
+#define PREAD(name, n, pri, rm, rl, m, s, r) \
+       {.sda =3D SENSOR_ATTR(name, S_IRUGO, show_##r, NULL, n), \
+         .priority =3D pri,.msb[0] =3D rm, .lsb[0] =3D rl, .mask[0] =3D m,=
 \
+         .shift[0] =3D s,}
+
+#define PWRITE(name, n, pri, rm, rl, m, s, r) \
+       {.sda =3D SENSOR_ATTR(name, S_IRUGO | S_IWUSR, show_##r, store_##r,=
 n), \
+         .priority =3D pri,.msb[0] =3D rm, .lsb[0] =3D rl, .mask[0] =3D m,=
 \
+         .shift[0] =3D s,}
+
+/*
+ * PWRITEM assumes that the initializers for the .msb, .lsb, .mask and .sh=
ift
+ * were created using the VAA macro.
+ */
+#define PWRITEM(name, n, pri, rm, rl, m, s, r) \
+       {.sda =3D SENSOR_ATTR(name, S_IRUGO | S_IWUSR, show_##r, store_##r,=
 n), \
+         .priority =3D pri,.msb =3D rm, .lsb =3D rl, .mask =3D m, .shift =
=3D s,}
+
+#define PCONST(name, n, v) \
+       {.sda =3D SENSOR_ATTR(name, S_IRUGO, show_const, NULL, n), \
+         .priority =3D PRI_LOW, .value =3D v,}
+
+#define PLABEL(name, n, v) \
+       {.sda =3D SENSOR_ATTR(name, S_IRUGO, show_label, NULL, n), \
+         .priority =3D PRI_LOW, .label =3D v,}
+
+static struct asc7621_param asc7621_params[] =3D {
+       PREAD(in0_input, 0, PRI_HIGH, 0x20, 0x13, 0, 0, in10),
+       PREAD(in1_input, 1, PRI_HIGH, 0x21, 0x18, 0, 0, in10),
+       PREAD(in2_input, 2, PRI_HIGH, 0x22, 0x11, 0, 0, in10),
+       PREAD(in3_input, 3, PRI_HIGH, 0x23, 0x12, 0, 0, in10),
+       PREAD(in4_input, 4, PRI_HIGH, 0x24, 0x14, 0, 0, in10),
+
+       PLABEL(in0_label, 0, "in0"),
+       PLABEL(in1_label, 1, "in1"),
+       PLABEL(in2_label, 2, "in2"),
+       PLABEL(in3_label, 3, "in3"),
+       PLABEL(in4_label, 4, "in4"),
+
+       PWRITE(in0_min, 0, PRI_LOW, 0x44, 0, 0, 0, in8),
+       PWRITE(in1_min, 1, PRI_LOW, 0x46, 0, 0, 0, in8),
+       PWRITE(in2_min, 2, PRI_LOW, 0x48, 0, 0, 0, in8),
+       PWRITE(in3_min, 3, PRI_LOW, 0x4a, 0, 0, 0, in8),
+       PWRITE(in4_min, 4, PRI_LOW, 0x4c, 0, 0, 0, in8),
+
+       PWRITE(in0_max, 0, PRI_LOW, 0x45, 0, 0, 0, in8),
+       PWRITE(in1_max, 1, PRI_LOW, 0x47, 0, 0, 0, in8),
+       PWRITE(in2_max, 2, PRI_LOW, 0x49, 0, 0, 0, in8),
+       PWRITE(in3_max, 3, PRI_LOW, 0x4b, 0, 0, 0, in8),
+       PWRITE(in4_max, 4, PRI_LOW, 0x4d, 0, 0, 0, in8),
+
+       PREAD(in0_alarm, 0, PRI_LOW, 0x41, 0, 0x01, 0, bitmask),
+       PREAD(in1_alarm, 1, PRI_LOW, 0x41, 0, 0x01, 1, bitmask),
+       PREAD(in2_alarm, 2, PRI_LOW, 0x41, 0, 0x01, 2, bitmask),
+       PREAD(in3_alarm, 3, PRI_LOW, 0x41, 0, 0x01, 3, bitmask),
+       PREAD(in4_alarm, 4, PRI_LOW, 0x42, 0, 0x01, 0, bitmask),
+
+       PREAD(fan1_input, 0, PRI_HIGH, 0x29, 0x28, 0, 0, fan16),
+       PREAD(fan2_input, 1, PRI_HIGH, 0x2b, 0x2a, 0, 0, fan16),
+       PREAD(fan3_input, 2, PRI_HIGH, 0x2d, 0x2c, 0, 0, fan16),
+       PREAD(fan4_input, 3, PRI_HIGH, 0x2f, 0x2e, 0, 0, fan16),
+
+       PLABEL(fan1_label, 0, "fan1"),
+       PLABEL(fan2_label, 1, "fan2"),
+       PLABEL(fan3_label, 2, "fan3"),
+       PLABEL(fan4_label, 3, "fan4"),
+
+       PWRITE(fan1_min, 0, PRI_LOW, 0x55, 0x54, 0, 0, fan16),
+       PWRITE(fan2_min, 1, PRI_LOW, 0x57, 0x56, 0, 0, fan16),
+       PWRITE(fan3_min, 2, PRI_LOW, 0x59, 0x58, 0, 0, fan16),
+       PWRITE(fan4_min, 3, PRI_LOW, 0x5b, 0x5a, 0, 0, fan16),
+
+       PREAD(fan1_alarm, 0, PRI_LOW, 0x42, 0, 0x01, 0, bitmask),
+       PREAD(fan2_alarm, 1, PRI_LOW, 0x42, 0, 0x01, 1, bitmask),
+       PREAD(fan3_alarm, 2, PRI_LOW, 0x42, 0, 0x01, 2, bitmask),
+       PREAD(fan4_alarm, 3, PRI_LOW, 0x42, 0, 0x01, 3, bitmask),
+
+       PREAD(temp1_input, 0, PRI_HIGH, 0x25, 0x10, 0, 0, temp10),
+       PREAD(temp2_input, 1, PRI_HIGH, 0x26, 0x15, 0, 0, temp10),
+       PREAD(temp3_input, 2, PRI_HIGH, 0x27, 0x16, 0, 0, temp10),
+       PREAD(temp4_input, 3, PRI_HIGH, 0x33, 0x17, 0, 0, temp10),
+       PREAD(temp5_input, 4, PRI_HIGH, 0xf7, 0xf6, 0, 0, temp10),
+       PREAD(temp6_input, 5, PRI_HIGH, 0xf9, 0xf8, 0, 0, temp10),
+       PREAD(temp7_input, 6, PRI_HIGH, 0xfb, 0xfa, 0, 0, temp10),
+       PREAD(temp8_input, 7, PRI_HIGH, 0xfd, 0xfc, 0, 0, temp10),
+
+       PCONST(temp1_type, 0, 1),
+       PCONST(temp2_type, 1, 3),
+       PCONST(temp3_type, 2, 2),
+       PCONST(temp4_type, 3, 6),
+       PCONST(temp5_type, 4, 6),
+       PCONST(temp6_type, 5, 6),
+       PCONST(temp7_type, 6, 6),
+       PCONST(temp8_type, 7, 6),
+
+       PLABEL(temp1_label, 0, "cpu"),
+       PLABEL(temp2_label, 1, "internal"),
+       PLABEL(temp3_label, 2, "remote"),
+       PLABEL(temp4_label, 3, "peci 1"),
+       PLABEL(temp5_label, 4, "peci 1"),
+       PLABEL(temp6_label, 5, "peci 2"),
+       PLABEL(temp7_label, 6, "peci 3"),
+       PLABEL(temp8_label, 7, "peci 4"),
+
+       PWRITE(temp1_min, 0, PRI_LOW, 0x4e, 0, 0, 0, temp8),
+       PWRITE(temp2_min, 1, PRI_LOW, 0x50, 0, 0, 0, temp8),
+       PWRITE(temp3_min, 2, PRI_LOW, 0x52, 0, 0, 0, temp8),
+       PWRITE(temp4_min, 3, PRI_LOW, 0x34, 0, 0, 0, temp8),
+
+       PWRITE(temp1_max, 0, PRI_LOW, 0x4f, 0, 0, 0, temp8),
+       PWRITE(temp2_max, 1, PRI_LOW, 0x51, 0, 0, 0, temp8),
+       PWRITE(temp3_max, 2, PRI_LOW, 0x53, 0, 0, 0, temp8),
+       PWRITE(temp4_max, 3, PRI_LOW, 0x35, 0, 0, 0, temp8),
+
+       PREAD(temp1_alarm, 0, PRI_LOW, 0x41, 0, 0x01, 4, bitmask),
+       PREAD(temp2_alarm, 1, PRI_LOW, 0x41, 0, 0x01, 5, bitmask),
+       PREAD(temp3_alarm, 2, PRI_LOW, 0x41, 0, 0x01, 6, bitmask),
+       PREAD(temp4_alarm, 3, PRI_LOW, 0x43, 0, 0x01, 0, bitmask),
+
+       PWRITE(temp1_source, 0, PRI_LOW, 0x02, 0, 0x07, 4, bitmask),
+       PWRITE(temp2_source, 1, PRI_LOW, 0x02, 0, 0x07, 0, bitmask),
+       PWRITE(temp3_source, 2, PRI_LOW, 0x03, 0, 0x07, 4, bitmask),
+       PWRITE(temp4_source, 3, PRI_LOW, 0x03, 0, 0x07, 0, bitmask),
+       PCONST(temp5_source, 4, 4),
+       PCONST(temp6_source, 5, 5),
+       PCONST(temp7_source, 6, 6),
+       PCONST(temp8_source, 7, 7),
+
+       PWRITE(temp1_smoothing_enable, 0, PRI_LOW, 0x62, 0, 0x01, 3, bitmas=
k),
+       PWRITE(temp2_smoothing_enable, 1, PRI_LOW, 0x63, 0, 0x01, 7, bitmas=
k),
+       PWRITE(temp3_smoothing_enable, 2, PRI_LOW, 0x64, 0, 0x01, 3, bitmas=
k),
+       PWRITE(temp4_smoothing_enable, 3, PRI_LOW, 0x3c, 0, 0x01, 3, bitmas=
k),
+
+       PWRITE(temp1_smoothing_time, 0, PRI_LOW, 0x62, 0, 0x07, 0, temp_st),
+       PWRITE(temp2_smoothing_time, 1, PRI_LOW, 0x63, 0, 0x07, 4, temp_st),
+       PWRITE(temp3_smoothing_time, 2, PRI_LOW, 0x63, 0, 0x07, 0, temp_st),
+       PWRITE(temp4_smoothing_time, 3, PRI_LOW, 0x3c, 0, 0x07, 0, temp_st),
+
+       PWRITE(temp1_auto_point1_temp_hyst, 0, PRI_LOW, 0x6d, 0, 0x0f, 4,
+              bitmask),
+       PWRITE(temp2_auto_point1_temp_hyst, 1, PRI_LOW, 0x6d, 0, 0x0f, 0,
+              bitmask),
+       PWRITE(temp3_auto_point1_temp_hyst, 2, PRI_LOW, 0x6e, 0, 0x0f, 4,
+              bitmask),
+       PWRITE(temp4_auto_point1_temp_hyst, 3, PRI_LOW, 0x6e, 0, 0x0f, 0,
+              bitmask),
+
+       PREAD(temp1_auto_point2_temp_hyst, 0, PRI_LOW, 0x6d, 0, 0x0f, 4,
+             bitmask),
+       PREAD(temp2_auto_point2_temp_hyst, 1, PRI_LOW, 0x6d, 0, 0x0f, 0,
+             bitmask),
+       PREAD(temp3_auto_point2_temp_hyst, 2, PRI_LOW, 0x6e, 0, 0x0f, 4,
+             bitmask),
+       PREAD(temp4_auto_point2_temp_hyst, 3, PRI_LOW, 0x6e, 0, 0x0f, 0,
+             bitmask),
+
+       PWRITE(temp1_auto_point1_temp, 0, PRI_LOW, 0x67, 0, 0, 0, temp8),
+       PWRITE(temp2_auto_point1_temp, 1, PRI_LOW, 0x68, 0, 0, 0, temp8),
+       PWRITE(temp3_auto_point1_temp, 2, PRI_LOW, 0x69, 0, 0, 0, temp8),
+       PWRITE(temp4_auto_point1_temp, 3, PRI_LOW, 0x3b, 0, 0, 0, temp8),
+
+       PWRITEM(temp1_auto_point2_temp, 0, PRI_LOW, VAA(0x5f, 0x67), VAA(0),
+               VAA(0x0f), VAA(4), ap2_temp),
+       PWRITEM(temp2_auto_point2_temp, 1, PRI_LOW, VAA(0x60, 0x68), VAA(0),
+               VAA(0x0f), VAA(4), ap2_temp),
+       PWRITEM(temp3_auto_point2_temp, 2, PRI_LOW, VAA(0x61, 0x69), VAA(0),
+               VAA(0x0f), VAA(4), ap2_temp),
+       PWRITEM(temp4_auto_point2_temp, 3, PRI_LOW, VAA(0x3c, 0x3b), VAA(0),
+               VAA(0x0f), VAA(4), ap2_temp),
+
+       PWRITE(temp1_crit, 0, PRI_LOW, 0x6a, 0, 0, 0, temp8),
+       PWRITE(temp2_crit, 1, PRI_LOW, 0x6b, 0, 0, 0, temp8),
+       PWRITE(temp3_crit, 2, PRI_LOW, 0x6c, 0, 0, 0, temp8),
+       PWRITE(temp4_crit, 3, PRI_LOW, 0x3d, 0, 0, 0, temp8),
+
+       PWRITE(temp5_enable, 4, PRI_LOW, 0x0e, 0, 0x01, 0, bitmask),
+       PWRITE(temp6_enable, 5, PRI_LOW, 0x0e, 0, 0x01, 1, bitmask),
+       PWRITE(temp7_enable, 6, PRI_LOW, 0x0e, 0, 0x01, 2, bitmask),
+       PWRITE(temp8_enable, 7, PRI_LOW, 0x0e, 0, 0x01, 3, bitmask),
+
+       PWRITE(remote1_offset, 0, PRI_LOW, 0x1c, 0, 0, 0, temp62),
+       PWRITE(remote2_offset, 1, PRI_LOW, 0x1d, 0, 0, 0, temp62),
+
+       PWRITE(pwm1, 0, PRI_HIGH, 0x30, 0, 0, 0, u8),
+       PWRITE(pwm2, 1, PRI_HIGH, 0x31, 0, 0, 0, u8),
+       PWRITE(pwm3, 2, PRI_HIGH, 0x32, 0, 0, 0, u8),
+
+       PWRITE(pwm1_invert, 0, PRI_LOW, 0x5c, 0, 0x01, 4, bitmask),
+       PWRITE(pwm2_invert, 1, PRI_LOW, 0x5d, 0, 0x01, 4, bitmask),
+       PWRITE(pwm3_invert, 2, PRI_LOW, 0x5e, 0, 0x01, 4, bitmask),
+
+       PWRITEM(pwm1_enable, 0, PRI_LOW, VAA(0x5c, 0x5c, 0x62), VAA(0, 0, 0=
),
+               VAA(0x07, 0x01, 0x01), VAA(5, 3, 5), pwm_enable),
+       PWRITEM(pwm2_enable, 1, PRI_LOW, VAA(0x5d, 0x5d, 0x62), VAA(0, 0, 0=
),
+               VAA(0x07, 0x01, 0x01), VAA(5, 3, 6), pwm_enable),
+       PWRITEM(pwm3_enable, 2, PRI_LOW, VAA(0x5e, 0x5e, 0x62), VAA(0, 0, 0=
),
+               VAA(0x07, 0x01, 0x01), VAA(5, 3, 7), pwm_enable),
+
+       PWRITEM(pwm1_auto_channels, 0, PRI_LOW, VAA(0x5c, 0x5c), VAA(0, 0),
+               VAA(0x07, 0x01), VAA(5, 3), pwm_ac),
+       PWRITEM(pwm2_auto_channels, 1, PRI_LOW, VAA(0x5d, 0x5d), VAA(0, 0),
+               VAA(0x07, 0x01), VAA(5, 3), pwm_ac),
+       PWRITEM(pwm3_auto_channels, 2, PRI_LOW, VAA(0x5e, 0x5e), VAA(0, 0),
+               VAA(0x07, 0x01), VAA(5, 3), pwm_ac),
+
+       PWRITE(pwm1_auto_point1_pwm, 0, PRI_LOW, 0x64, 0, 0, 0, u8),
+       PWRITE(pwm2_auto_point1_pwm, 1, PRI_LOW, 0x65, 0, 0, 0, u8),
+       PWRITE(pwm3_auto_point1_pwm, 2, PRI_LOW, 0x66, 0, 0, 0, u8),
+
+       PWRITE(pwm1_auto_point2_pwm, 0, PRI_LOW, 0x38, 0, 0, 0, u8),
+       PWRITE(pwm2_auto_point2_pwm, 1, PRI_LOW, 0x39, 0, 0, 0, u8),
+       PWRITE(pwm3_auto_point2_pwm, 2, PRI_LOW, 0x3a, 0, 0, 0, u8),
+
+       PWRITE(pwm1_freq, 0, PRI_LOW, 0x5f, 0, 0x0f, 0, pwm_freq),
+       PWRITE(pwm2_freq, 1, PRI_LOW, 0x60, 0, 0x0f, 0, pwm_freq),
+       PWRITE(pwm3_freq, 2, PRI_LOW, 0x61, 0, 0x0f, 0, pwm_freq),
+
+       PREAD(pwm1_auto_zone_assigned, 0, PRI_LOW, 0, 0, 0x03, 2, bitmask),
+       PREAD(pwm2_auto_zone_assigned, 1, PRI_LOW, 0, 0, 0x03, 4, bitmask),
+       PREAD(pwm3_auto_zone_assigned, 2, PRI_LOW, 0, 0, 0x03, 6, bitmask),
+
+       PWRITE(pwm1_auto_spinup_time, 0, PRI_LOW, 0x5c, 0, 0x07, 0, pwm_ast=
),
+       PWRITE(pwm2_auto_spinup_time, 1, PRI_LOW, 0x5d, 0, 0x07, 0, pwm_ast=
),
+       PWRITE(pwm3_auto_spinup_time, 2, PRI_LOW, 0x5e, 0, 0x07, 0, pwm_ast=
),
+
+       PWRITE(peci_enable, 0, PRI_LOW, 0x40, 0, 0x01, 4, bitmask),
+       PWRITE(peci_avg, 0, PRI_LOW, 0x36, 0, 0x07, 0, bitmask),
+       PWRITE(peci_domain, 0, PRI_LOW, 0x36, 0, 0x01, 3, bitmask),
+       PWRITE(peci_legacy, 0, PRI_LOW, 0x36, 0, 0x01, 4, bitmask),
+       PWRITE(peci_diode, 0, PRI_LOW, 0x0e, 0, 0x07, 4, bitmask),
+       PWRITE(peci_4domain, 0, PRI_LOW, 0x0e, 0, 0x01, 4, bitmask),
+
+};
+
+static struct asc7621_data *asc7621_update_device(struct device *dev)
+{
+       struct i2c_client *client =3D to_i2c_client(dev);
+       struct asc7621_data *data =3D i2c_get_clientdata(client);
+       int i;
+
+/*
+ * The asc7621 chips guarantee consistent reads of multi-byte values
+ * regardless of the order of the reads.  No special logic is needed
+ * so we can just read the registers in whatever  order they appear
+ * in the asc7621_params array.
+ */
+
+       mutex_lock(&data->update_lock);
+
+       /* Read all the high priority registers */
+
+       if (!data->valid ||
+           time_after(jiffies, data->last_high_reading + INTERVAL_HIGH)) {
+
+               for (i =3D 0; i < ARRAY_SIZE(asc7621_register_priorities); =
i++) {
+                       if (asc7621_register_priorities[i] =3D PRI_HIGH) {
+                               data->reg[i] +                             =
      i2c_smbus_read_byte_data(client, i) & 0xff;
+                       }
+               }
+               data->last_high_reading =3D jiffies;
+       };                      /* last_reading */
+
+       /* Read all the low priority registers. */
+
+       if (!data->valid ||
+           time_after(jiffies, data->last_high_reading + INTERVAL_LOW)) {
+
+               for (i =3D 0; i < ARRAY_SIZE(asc7621_params); i++) {
+                       if (asc7621_register_priorities[i] =3D PRI_LOW) {
+                               data->reg[i] +                             =
      i2c_smbus_read_byte_data(client, i) & 0xff;
+                       }
+               }
+               data->last_low_reading =3D jiffies;
+       };                      /* last_reading */
+
+       data->valid =3D 1;
+
+       mutex_unlock(&data->update_lock);
+
+       return data;
+}
+
+/* Standard detection and initialization below */
+
+/* Helper function that checks if an address is valid
+ * for a particular chip.
+ */
+
+static inline int valid_address_for_chip(int chip_type, int address)
+{
+       int i =3D 0;
+       for (i =3D 0; asc7621_chips[chip_type].addresses[i] !=3D I2C_CLIENT=
_END;
+            i++) {
+               if (asc7621_chips[chip_type].addresses[i] =3D address) {
+                       return (1);
+               }
+       }
+       return (0);
+}
+
+static void asc7621_init_client(struct i2c_client *client)
+{
+       int value, i, j;
+
+       dev_dbg(&client->dev, "Initializing device\n");
+
+       /* Warn if part was not "READY" */
+
+       value =3D i2c_smbus_read_byte_data(client, 0x40) & 0xff;
+
+       dev_dbg(&client->dev, "asc7621_REG_READY is: 0x%02x\n", value);
+       if (value & 0x02) {
+               dev_err(&client->dev,
+                       "Client (%d,0x%02x) config is locked.\n",
+                       i2c_adapter_id(client->adapter), client->addr);
+       };
+       if (!(value & 0x04)) {
+               dev_err(&client->dev, "Client (%d,0x%02x) is not ready.\n",
+                       i2c_adapter_id(client->adapter), client->addr);
+       };
+
+       /* Start monitoring */
+
+       value =3D i2c_smbus_read_byte_data(client, 0x40) & 0xff;
+       /* Try to clear LOCK, Set START, save everything else */
+       value =3D (value & ~0x02) | 0x01;
+       dev_dbg(&client->dev, "Setting READY to: 0x%02x\n", value);
+       write_byte(0x40, value & 0xff);
+
+       dev_dbg(&client->dev, "Loading register arrays.\n");
+
+       /*
+        * Collect all the registers needed into a single array.
+        * This way, if a register isn't actually used for anything,
+        * we don't retrieve it.
+        */
+
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_params); i++) {
+               for (j =3D 0; j < ARRAY_SIZE(asc7621_params[i].msb); j++)
+                       asc7621_register_priorities[asc7621_params[i].msb[j=
]] +                           asc7621_params[i].priority;
+               for (j =3D 0; j < ARRAY_SIZE(asc7621_params[i].lsb); j++)
+                       asc7621_register_priorities[asc7621_params[i].lsb[j=
]] +                           asc7621_params[i].priority;
+       }
+}
+
+static struct i2c_driver asc7621_driver;
+
+static int asc7621_detect(struct i2c_adapter *adapter, int address, int ki=
nd)
+{
+       int company, verstep;
+       struct i2c_client *client =3D NULL;
+       struct asc7621_data *data;
+       struct device *dev;
+       int err =3D 0;
+       int chip_index =3D 0;
+       int i =3D 0;
+
+       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+               err =3D -EBUSY;
+               goto exit;
+       };
+
+       if (!(data =3D kzalloc(sizeof(struct asc7621_data), GFP_KERNEL))) {
+               err =3D -ENOMEM;
+               goto exit;
+       }
+
+       client =3D &data->client;
+       i2c_set_clientdata(client, data);
+       client->addr =3D address;
+       client->adapter =3D adapter;
+       client->driver =3D &asc7621_driver;
+       client->flags =3D 0;
+       dev =3D &client->dev;
+
+       if (kind > 0) {
+               if (kind < FIRST_CHIP || kind > LAST_CHIP) {
+                       dev_err(&adapter->dev,
+                               "Chip kind \"%d\" not handled by this drive=
r.\n",
+                               kind);
+                       err =3D -EINVAL;
+                       goto exit_free;
+               }
+               strlcpy(client->name, asc7621_chips[kind].name, I2C_NAME_SI=
ZE);
+               dev_dbg(&adapter->dev, "Forced %s device at %d,0x%02x\n",
+                       client->name, i2c_adapter_id(client->adapter),
+                       client->addr);
+
+       } else {
+               dev_dbg(&adapter->dev,
+                       "Autodetecting device at %d,0x%02x ...\n",
+                       i2c_adapter_id(adapter), address);
+               kind =3D 0;
+               for (chip_index =3D FIRST_CHIP; chip_index <=3D LAST_CHIP;
+                    chip_index++) {
+
+                       if (!valid_address_for_chip(chip_index, address)) {
+                               continue;
+                       }
+
+                       company =3D i2c_smbus_read_byte_data(client,
+                                                          asc7621_chips
+                                                          [chip_index].com=
pany_reg)
+                           & 0xff;
+                       verstep +                           i2c_smbus_read_=
byte_data(client,
+                                                    asc7621_chips
+                                                    [chip_index].verstep_r=
eg) &
+                           0xff;
+
+                       dev_dbg(&adapter->dev,
+                               "Checking 0x%02x,0x%02x,0x%02x against 0x%0=
2x,0x%02x\n",
+                               address, company, verstep,
+                               asc7621_chips[chip_index].company_id,
+                               asc7621_chips[chip_index].verstep_id);
+
+                       if (company =3D
+                           asc7621_chips[chip_index].company_id &&
+                           verstep =3D asc7621_chips[chip_index].verstep_i=
d) {
+                               strlcpy(client->name,
+                                       asc7621_chips[chip_index].name,
+                                       I2C_NAME_SIZE);
+                               kind =3D asc7621_chips[chip_index].chip_typ=
e;
+                               dev_info(&adapter->dev, "  Matched %s\n",
+                                        asc7621_chips[chip_index].name);
+                               break;
+                       }
+                       dev_dbg(&adapter->dev, "  Didn't match %s\n",
+                               asc7621_chips[chip_index].name);
+               }
+               if (kind <=3D 0) {
+                       dev_err(&adapter->dev,
+                               "asc7621 not found at %d,0x%02x.\n",
+                               i2c_adapter_id(adapter), address);
+                       err =3D -ENODEV;
+                       goto exit_free;
+               }
+               dev_dbg(&adapter->dev,
+                       "Detected %s device at %d,0x%02x with"
+                       " COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+                       client->name,
+                       i2c_adapter_id(client->adapter),
+                       client->addr, company, verstep);
+       }
+
+       data->valid =3D 0;
+       mutex_init(&data->update_lock);
+
+       /* Tell the I2C layer a new client has arrived */
+       if ((err =3D i2c_attach_client(client))) {
+               goto exit_free;
+       }
+
+       /* Initialize the asc7621 chip */
+       asc7621_init_client(client);
+
+       /* Create the sysfs entries */
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_params); i++) {
+               if ((err +                    device_create_file(dev,
+                                       &(asc7621_params[i].sda.dev_attr)))=
) {
+                       goto exit_remove;
+               }
+       }
+
+       data->class_dev =3D hwmon_device_register(&client->dev);
+       if (IS_ERR(data->class_dev)) {
+               err =3D PTR_ERR(data->class_dev);
+               goto exit_remove;
+       }
+
+       return (0);
+
+      exit_remove:
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_params); i++) {
+               device_remove_file(dev, &(asc7621_params[i].sda.dev_attr));
+       }
+       i2c_detach_client(client);
+
+      exit_free:
+       kfree(data);
+      exit:
+       return err;
+
+}
+
+static int asc7621_detach_client(struct i2c_client *client)
+{
+       struct asc7621_data *data =3D i2c_get_clientdata(client);
+       int i;
+
+       hwmon_device_unregister(data->class_dev);
+
+       for (i =3D 0; i < ARRAY_SIZE(asc7621_params); i++) {
+               device_remove_file(&client->dev,
+                                  &(asc7621_params[i].sda.dev_attr));
+       }
+
+       i2c_detach_client(client);
+       kfree(data);
+       return 0;
+}
+
+static int asc7621_attach_adapter(struct i2c_adapter *adapter)
+{
+       if (!(adapter->class & I2C_CLASS_HWMON))
+               return 0;
+
+       return i2c_probe(adapter, &addr_data, asc7621_detect);
+}
+
+static struct i2c_driver asc7621_driver =3D {
+       .driver =3D {
+                  .name =3D "asc7621",
+                  },
+       .attach_adapter =3D asc7621_attach_adapter,
+       .detach_client =3D asc7621_detach_client,
+};
+
+static int __init sm_asc7621_init(void)
+{
+       return i2c_add_driver(&asc7621_driver);
+}
+
+static void __exit sm_asc7621_exit(void)
+{
+       i2c_del_driver(&asc7621_driver);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("George Joseph");
+MODULE_DESCRIPTION("Andigilog aSC7621 and aSC7621a driver");
+
+module_init(sm_asc7621_init);
+module_exit(sm_asc7621_exit);
diff -urpN linux-2.6.25.4/drivers/hwmon/Kconfig linux-2.6.25.4-gtj/drivers/=
hwmon/Kconfig
--- linux-2.6.25.4/drivers/hwmon/Kconfig        2008-04-16 20:49:44.0000000=
00 -0600
+++ linux-2.6.25.4-gtj/drivers/hwmon/Kconfig    2008-05-28 21:38:16.9345259=
84 -0600
@@ -165,6 +165,19 @@ config SENSORS_K8TEMP
          This driver can also be built as a module.  If so, the module
          will be called k8temp.

+config SENSORS_ASC7621
+       tristate "Andigilog aSC7621"
+       depends on HWMON && I2C
+       help
+         If you say yes here you get support for the aSC7621
+         family of SMBus sensors chip found on most Intel X48, X38, 975,
+         965 and 945 desktop boards.  Currently supported chips:
+         aSC7621
+         aSC7621a
+
+         This driver can also be built as a module.  If so, the module
+         will be called asc7621.
+
 config SENSORS_AMS
        tristate "Apple Motion Sensor driver"
        depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C =3D y) |=
| (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
diff -urpN linux-2.6.25.4/drivers/hwmon/Makefile linux-2.6.25.4-gtj/drivers=
/hwmon/Makefile
--- linux-2.6.25.4/drivers/hwmon/Makefile       2008-04-16 20:49:44.0000000=
00 -0600
+++ linux-2.6.25.4-gtj/drivers/hwmon/Makefile   2008-05-28 21:36:49.1921978=
13 -0600
@@ -27,6 +27,7 @@ obj-$(CONFIG_SENSORS_ADT7470) +=3D adt7470
 obj-$(CONFIG_SENSORS_ADT7473)  +=3D adt7473.o
 obj-$(CONFIG_SENSORS_APPLESMC) +=3D applesmc.o
 obj-$(CONFIG_SENSORS_AMS)      +=3D ams/
+obj-$(CONFIG_SENSORS_ASC7621)  +=3D asc7621.o
 obj-$(CONFIG_SENSORS_ATXP1)    +=3D atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP) +=3D coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)  +=3D dme1737.o

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
