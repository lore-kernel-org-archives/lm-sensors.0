From: linux@rick.claranet.de (Hartmut Rick)
Date: Sat, 04 Mar 2006 22:38:26 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring support
Message-Id: <Pine.LNX.4.63.0603042101570.3972@Laila>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Jean and all others,

Attached is a new attempt at a kernel patch with SMSC 47M192 driver.

New features:
* patch is now relative to 2.6.16-rc5 (I had to change the driver
    definition in order to make it work - hope this is correct?)
* initialize alarm limits if monitoring is not running at the time of
    loading the driver
* don't create in4_* files in /sys if 12V input pin is used for VID4
* proper assignment of temperature offsets to temp* channels
* create individual files for all alarms (temp*_alarm, temp*_fault,
    in*_alarm). I've still kept the bit patterns alarms_temp etc for now,
    so there is redundant information.
* add definition of individual alarm files to sysfs-interface
    documentation
* add cross references into kernel configuration help texts for
    smsc47m192 and smsc47m1 drivers
* add smsc47m192 driver documentation


Best regards,
  Hartmut
-------------- next part --------------
diff -uprN1 linux-2.6.16-rc5/Documentation/hwmon/smsc47m192 linux-2.6.16-new/Documentation/hwmon/smsc47m192
--- linux-2.6.16-rc5/Documentation/hwmon/smsc47m192	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-new/Documentation/hwmon/smsc47m192	2006-03-04 22:00:17.000000000 +0100
@@ -0,0 +1,105 @@
+Kernel driver smsc47m192
+============
+
+Supported chips:
+  * SMSC LPC47M192 and LPC47M997
+    Prefix: 'smsc47m192'
+    Addresses scanned: I2C 0x2c - 0x2d
+    Datasheet:	The datasheet for LPC47M192 is publicly available from
+		http://www.smsc.com
+		The LPC47M997 is compatible for hardware monitoring
+
+Author: Hartmut Rick <linux at rick.claranet.de>
+	Special thanks to Jean Delvare for careful checking of
+	the code and many helpful comments and suggestions.
+
+
+Description
+-----------
+
+This driver implements support for the hardware sensor capabilities
+of the SMSC LPC47M192 and LPC47M997 Super-I/O chips.
+
+These chips support 3 temperature channels and 8 voltage inputs
+as well as CPU voltage VID input.
+
+They do also have fan monitoring and control capabilities, but the
+latter are accessed via ISA bus and are not supported by this driver.
+Use the 'smsc47m1' driver for fan monitoring.
+
+Voltages and temperatures are measured by an 8-bit ADC, the resolution
+of the temperatures is 1 bit per degree C.
+Voltages are scaled such that the nominal voltage corresponds to
+192 counts, i.e. 3/4 of the full range. Thus the available range for
+each voltage channel is 0V ... 255/192*(nominal voltage), the resolution
+is 1 bit per (nominal voltage)/192.
+Both voltage and temperature values are scaled by 1000, the sys files
+show voltages in mV and temperatures in units of 0.001 degC.
+
+The +12V analog voltage input channel (in4_input) is multiplexed with
+bit 4 of the encoded CPU voltage. This means that you either get
+a +12V voltage measurement or a 5 bit CPU VID, but not both.
+The default setting is to use the pin as 12V input, and use only 4 bit VID.
+This driver assumes that the information in the configuration register
+is correct, i.e. that the BIOS has updated the configuration if
+the motherboard has this input wired to VID4.
+
+
+/sys files
+----------
+
+in0_input	- +2.5V voltage input
+in1_input	- CPU voltage input (nominal 2.25V)
+in2_input	- +3.3V voltage input
+in3_input	- +5V voltage input
+in4_input	- +12V voltage input (may be missing if used as VID4)
+in5_input	- Vcc voltage input (nominal 3.3V)
+		  This is the supply voltage of the sensor chip itself.
+in6_input	- +1.5V voltage input
+in7_input	- +1.8V voltage input
+
+in[0-7]_min,	
+in[0-7]_max	- lower and upper alarm thresholds for in[0-7]_input reading
+
+		  All voltages are read and written in mV.
+
+in_[0-7]_alarm	- alarm flags for voltage inputs
+		  These files read '1' in case of alarm, '0' otherwise.
+alarms_in	- alarm flags for voltage inputs
+		  This file contains all voltage alarms, bit-packed,
+		  bit 0 for in0_input. A set bit indicates an alarm.	
+
+temp1_input	- chip temperature measured by on-chip diode
+temp[2-3]_input	- temperature measured by external diodes (one of these would
+		  typically be wired to the diode inside the CPU)
+
+temp[1-3]_min,
+temp[1-3]_max	- lower and upper alarm thresholds for temperatures
+
+temp[1-3]_offset - temperature offset registers
+		  The chip adds the offsets stored in these registers to
+		  the corresponding temperature readings.
+		  Note that temp1 and temp2 offsets share the same register,
+		  they can not both be different from zero at the same time.
+		  Writing a non-zero number to one of them will reset the other
+		  offset to zero.
+
+		  All temperatures and offsets are read and written in
+		  units of 0.001 degC.
+
+temp[1-3]_alarm - alarm flags for temperature inputs, '1' in case of alarm,
+		  '0' otherwise.
+alarms_temp	- alarm flags in one number, bits packed, bit 0 for temp1
+temp[2-3]_fault - diode fault flags for temperature inputs 2 and 3.
+		  A fault is detected if the two pins for the corresponding
+		  sensor are open or shorted, or any of the two is shortened
+		  to ground or Vcc.
+faults_temp	- diode fault flags, bits packed, bits 1 and 2 for temp2
+		  and temp3 faults, respectively.
+
+cpu0_vid	- CPU voltage as received from the CPU
+
+vrm		- CPU VID standard used for decoding CPU voltage
+
+The *_min, *_max, *_offset and vrm files can be read and written, all others
+		  are read-only
diff -uprN1 linux-2.6.16-rc5/Documentation/hwmon/sysfs-interface linux-2.6.16-new/Documentation/hwmon/sysfs-interface
--- linux-2.6.16-rc5/Documentation/hwmon/sysfs-interface	2006-03-04 20:11:31.000000000 +0100
+++ linux-2.6.16-new/Documentation/hwmon/sysfs-interface	2006-03-04 22:00:17.000000000 +0100
@@ -220,2 +220,20 @@ temp[1-2]_crit_hyst
 
+temp[1-4]_offset
+		Temperature offset which is added to the temperature reading
+		by the chip.
+		Unit: millidegree Celsius
+		Read/Write only value.
+
+temp[1-4]_alarm
+		Temperature alarm for one channel. '0' means no alarm,
+		'1' means alarm is active. If there is more than one
+		different kind of alarm, numbers larger than 1 can be used.
+		Read-only value
+
+temp[1-4]_fault
+		Temperature sensor fault. '0' means no fault, '1' or larger
+		means a fault was detected.
+		Read-only value
+
+
 		If there are multiple temperature sensors, temp1_* is
@@ -279,2 +297,7 @@ alarms_temp	Alarm bitmask relative to te
 
+faults_temp	Fault bitmask for temperature channels
+		Read only
+		A '1' bit means a temperature sensor fault is detected,
+		LSB corresponds to temp1 and so on
+
 beep_enable	Beep/interrupt enable
diff -uprN1 linux-2.6.16-rc5/drivers/hwmon/Kconfig linux-2.6.16-new/drivers/hwmon/Kconfig
--- linux-2.6.16-rc5/drivers/hwmon/Kconfig	2006-03-04 20:11:32.000000000 +0100
+++ linux-2.6.16-new/drivers/hwmon/Kconfig	2006-03-04 22:00:17.000000000 +0100
@@ -335,3 +335,8 @@ config SENSORS_SMSC47M1
 	  monitoring and control capabilities of the SMSC LPC47B27x,
-	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M192 chips.
+	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x, LPC47M192 and
+	  LPC47M997 chips.
+
+	  The temperature and voltage sensor features of the LPC47M192
+	  and LPC47M997 are supported by another driver, select also
+	  "SMSC LPC47M192 and compatibles" below for those.
 
@@ -340,2 +345,18 @@ config SENSORS_SMSC47M1
 
+config SENSORS_SMSC47M192
+	tristate "SMSC LPC47M192 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select HWMON_VID
+	help
+	  If you say yes here you get support for the temperature and
+	  voltage sensors of the SMSC LPC47M192 and LPC47M997 chips.
+
+	  The fan monitoring and control capabilities of these chips
+	  are supported by another driver, select 
+	  "SMSC LPC47M10x and compatibles" above. You need both drivers
+	  if you want fan control and voltage/temperature sensor support.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called smsc47m192.
+
 config SENSORS_SMSC47B397
diff -uprN1 linux-2.6.16-rc5/drivers/hwmon/Makefile linux-2.6.16-new/drivers/hwmon/Makefile
--- linux-2.6.16-rc5/drivers/hwmon/Makefile	2006-03-04 20:11:32.000000000 +0100
+++ linux-2.6.16-new/drivers/hwmon/Makefile	2006-03-04 22:00:17.000000000 +0100
@@ -42,2 +42,3 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc4
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
+obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
diff -uprN1 linux-2.6.16-rc5/drivers/hwmon/smsc47m192.c linux-2.6.16-new/drivers/hwmon/smsc47m192.c
--- linux-2.6.16-rc5/drivers/hwmon/smsc47m192.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-new/drivers/hwmon/smsc47m192.c	2006-03-04 22:31:30.000000000 +0100
@@ -0,0 +1,678 @@
+/*
+    smsc47m192.c - Support for hardware monitoring block of
+ 		SMSC LPC47M192 and LPC47M997 Super I/O chips.
+
+    Copyright (C) 2006  Hartmut Rick <linux at rick.claranet.de> 
+
+	derived from lm78.c and other chip drivers
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
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(smsc47m192);
+
+/* SMSC47M192 registers */
+#define SMSC47M192_REG_IN_MAX(nr)	(0x2b + (nr) * 2 + ((nr)>5 ? 0x1d : 0))
+#define SMSC47M192_REG_IN_MIN(nr)	(0x2c + (nr) * 2 + ((nr)>5 ? 0x1d : 0))
+#define SMSC47M192_REG_IN(nr)		(0x20 + (nr) + ((nr)>5 ? 0x2a : 0))
+
+#define SMSC47M192_REG_TEMP(nr)		(0x27 - (nr) + ((nr)>1 ? 0x2d : 0))
+#define SMSC47M192_REG_TEMP_MAX(nr)	(0x39 - (nr) * 2 + ((nr)>1 ? 0x23 : 0))
+#define SMSC47M192_REG_TEMP_MIN(nr)	(0x3a - (nr) * 2 + ((nr)>1 ? 0x23 : 0))
+#define SMSC47M192_REG_TEMP_OFFSET(nr)	(0x1f - ((nr)>1 ? 1 : 0))
+
+#define SMSC47M192_REG_ALARM1		0x41
+#define SMSC47M192_REG_ALARM2		0x42
+
+#define SMSC47M192_REG_VID		0x47
+#define SMSC47M192_REG_VID4		0x49
+
+#define SMSC47M192_REG_CONFIG		0x40
+#define SMSC47M192_REG_SFR		0x4f
+#define SMSC47M192_REG_COMPANY_ID	0x3e
+#define SMSC47M192_REG_VERSION		0x3f
+
+/* generalised scaling with integer rounding */
+static inline int SCALE(long val, int mul, int div)
+{
+	if (val < 0)
+		return (val * mul - div / 2) / div;
+	else
+		return (val * mul + div / 2) / div;
+}
+
+/* Conversions */
+
+/* smsc47m192 internally scales voltage measurements */
+static const u16 nom_mv[] = { 2500, 2250, 3300, 5000, 12000, 3300, 1500, 1800 };
+
+static inline unsigned int IN_FROM_REG(u8 reg, int n)
+{
+	return SCALE(reg, nom_mv[n], 192);
+}
+
+static inline u8 IN_TO_REG(unsigned long val, int n)
+{
+	return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
+}
+
+/* TEMP: 0.001 degC units (-128C to +127C)
+   REG: 1C/bit, two's complement */
+static inline s8 TEMP_TO_REG(int val)
+{
+	return SENSORS_LIMIT(SCALE(val, 1, 1000), -128000, 127000);
+}
+
+static inline int TEMP_FROM_REG(s8 val)
+{
+	return val * 1000;
+}
+
+struct smsc47m192_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 in[8];		/* Register value */
+	u8 in_max[8];		/* Register value */
+	u8 in_min[8];		/* Register value */
+	s8 temp[3];		/* Register value */
+	s8 temp_max[3];		/* Register value */
+	s8 temp_min[3];		/* Register value */
+	s8 temp_offset[3];	/* Register value */
+	u16 raw_alarms;		/* Register encoding, combined */
+	u8 alarm[3];
+	u8 vid;			/* Register encoding, combined */
+	u8 vrm;
+};
+
+static int smsc47m192_attach_adapter(struct i2c_adapter *adapter);
+static int smsc47m192_detect(struct i2c_adapter *adapter,int address,int kind);
+static int smsc47m192_detach_client(struct i2c_client *client);
+
+static struct smsc47m192_data *smsc47m192_update_device(struct device *dev);
+static void smsc47m192_init_client(struct i2c_client *client);
+
+static struct i2c_driver smsc47m192_driver = {
+	.driver = {
+		.name	= "smsc47m192",
+	},
+	.attach_adapter	= smsc47m192_attach_adapter,
+	.detach_client	= smsc47m192_detach_client,
+};
+
+/* Voltages */
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr], nr));
+}
+
+static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr], nr));
+}
+
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr], nr));
+}
+
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_min[nr] = IN_TO_REG(val,nr);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_IN_MIN(nr),
+							data->in_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_max[nr] = IN_TO_REG(val,nr);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_IN_MAX(nr),
+							data->in_max[nr]);
+	up(&data->update_lock);
+	return count;
+}
+	
+#define show_in_offset(offset)					\
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
+		show_in, NULL, offset);				\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+show_in_offset(5);
+show_in_offset(6);
+show_in_offset(7);
+
+/* Temperatures */
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
+}
+
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
+}
+
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
+}
+
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_min[nr] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MIN(nr),
+						data->temp_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_max[nr] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MAX(nr),
+						data->temp_max[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temp_offset(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_offset[nr]));
+}
+
+static ssize_t set_temp_offset(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_offset[nr] = TEMP_TO_REG(val);
+	if (nr>1)
+		i2c_smbus_write_byte_data(client,
+			SMSC47M192_REG_TEMP_OFFSET(nr), data->temp_offset[nr]);
+	else if (data->temp_offset[nr] != 0) {
+		/* offset[0] and offset[1] share the same register,
+			SFR bit 4 activates offset[0] */
+		i2c_smbus_write_byte_data(client, SMSC47M192_REG_SFR,
+					(sfr & 0xef) | (nr=0 ? 0x10 : 0));
+		data->temp_offset[1-nr] = 0;
+		i2c_smbus_write_byte_data(client,
+			SMSC47M192_REG_TEMP_OFFSET(nr), data->temp_offset[nr]);
+	} else if ((sfr & 0x10) = (nr=0 ? 0x10 : 0))
+		i2c_smbus_write_byte_data(client,
+					SMSC47M192_REG_TEMP_OFFSET(nr), 0);
+	up(&data->update_lock);
+	return count;
+}
+
+#define show_temp_index(index)						\
+static SENSOR_DEVICE_ATTR(temp##index##_input, S_IRUGO, 		\
+		show_temp, NULL, index-1);				\
+static SENSOR_DEVICE_ATTR(temp##index##_min, S_IRUGO | S_IWUSR,		\
+		show_temp_min, set_temp_min, index-1);			\
+static SENSOR_DEVICE_ATTR(temp##index##_max, S_IRUGO | S_IWUSR,		\
+		show_temp_max, set_temp_max, index-1);			\
+static SENSOR_DEVICE_ATTR(temp##index##_offset, S_IRUGO | S_IWUSR,	\
+		show_temp_offset, set_temp_offset, index-1);
+
+show_temp_index(1);
+show_temp_index(2);
+show_temp_index(3);
+
+/* VID */
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", data->vrm);
+}
+
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	data->vrm = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%u\n", data->alarm[nr]);
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%u\n", (data->raw_alarms & nr)!=0 ? 1 : 0);
+}
+
+static SENSOR_DEVICE_ATTR(alarms_in, S_IRUGO, show_alarms, NULL, 0);
+static SENSOR_DEVICE_ATTR(alarms_temp, S_IRUGO, show_alarms, NULL, 1);
+static SENSOR_DEVICE_ATTR(faults_temp, S_IRUGO, show_alarms, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 0x0010);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 0x0020);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 0x0040);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 0x4000);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 0x8000);
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0x0001);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 0x0002);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 0x0004);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 0x0008);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 0x0100);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 0x0200);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 0x0400);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 0x0800);
+
+/* This function is called when:
+    * smsc47m192_driver is inserted (when this module is loaded), for each
+      available adapter
+    * when a new adapter is inserted (and smsc47m192_driver is still present) */
+static int smsc47m192_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, smsc47m192_detect);
+}
+
+/* This function is called by i2c_probe */
+static int smsc47m192_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct smsc47m192_data *data;
+	int err = 0;
+	int version, config;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	if (!(data = kzalloc(sizeof(struct smsc47m192_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &smsc47m192_driver;
+
+	if (kind = 0)
+		kind = smsc47m192;
+
+	/* Detection criteria from sensors_detect script */
+	
+	if (kind < 0) {
+		if (	i2c_smbus_read_byte_data(client,
+					SMSC47M192_REG_COMPANY_ID) = 0x55
+			&& ((version = i2c_smbus_read_byte_data(client,
+					SMSC47M192_REG_VERSION)) & 0xf0) = 0x20
+			&& (i2c_smbus_read_byte_data(client,
+					SMSC47M192_REG_VID) & 0x70) = 0x00
+			&& (i2c_smbus_read_byte_data(client,
+					SMSC47M192_REG_VID4) & 0xfe) = 0x80) {
+			dev_info(&adapter->dev,
+					"found SMSC47M192 or SMSC47M997, "
+						"version 2, stepping A%d\n",
+						version&0x0f);
+		} else {
+			dev_dbg(&adapter->dev,
+				"SMSC47M192 detection failed at 0x%02x.\n",
+								address);
+			goto exit_free;
+		}
+	}
+
+	/* Fill in the remaining client fields and put into the global list */
+	strlcpy(client->name, "smsc47m192", I2C_NAME_SIZE);
+	data->vrm = vid_which_vrm();
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(client)))
+		goto exit_free;
+
+	/* Initialize the SMSC47M192 chip */
+	smsc47m192_init_client(client);
+
+	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
+	device_create_file(&client->dev, &sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in0_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in0_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in0_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_alarm.dev_attr);
+
+	/* Pin 110 is either in4 (+12V) or VID4 */
+	config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
+	if (!(config & 0x20)) {
+		device_create_file(&client->dev,
+					&sensor_dev_attr_in4_input.dev_attr);
+		device_create_file(&client->dev,
+					&sensor_dev_attr_in4_min.dev_attr);
+		device_create_file(&client->dev,
+					&sensor_dev_attr_in4_max.dev_attr);
+		device_create_file(&client->dev,
+					&sensor_dev_attr_in4_alarm.dev_attr);
+	}
+	device_create_file(&client->dev, &sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in5_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in5_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&client->dev,
+					&sensor_dev_attr_temp1_offset.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&client->dev,
+					&sensor_dev_attr_temp2_offset.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_fault.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+	device_create_file(&client->dev,
+					&sensor_dev_attr_temp3_offset.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_alarm.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_fault.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_alarms_in.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_alarms_temp.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_faults_temp.dev_attr);
+	device_create_file(&client->dev, &dev_attr_cpu0_vid);
+	device_create_file(&client->dev, &dev_attr_vrm);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int smsc47m192_detach_client(struct i2c_client *client)
+{
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(data);
+
+	return 0;
+}
+
+static void smsc47m192_init_client(struct i2c_client *client)
+{
+	int i;
+	u8 config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
+
+	if (!(config & 0x01)) {
+		u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
+
+		/* initialize alarm limits */
+		for (i=0; i<8; i++) {
+			i2c_smbus_write_byte_data(client,
+				SMSC47M192_REG_IN_MIN(i), 0);
+			i2c_smbus_write_byte_data(client,
+				SMSC47M192_REG_IN_MAX(i), 0xff);
+		}
+		for (i=0; i<3; i++) {
+			i2c_smbus_write_byte_data(client,
+				SMSC47M192_REG_TEMP_MIN(i), 0x80);
+			i2c_smbus_write_byte_data(client,
+				SMSC47M192_REG_TEMP_MAX(i), 0x7f);
+		}
+
+		/* select cycle mode (pause 1 sec between updates) */
+		i2c_smbus_write_byte_data(client, SMSC47M192_REG_SFR,
+						(sfr & 0xfd) | 0x02);
+		
+		/* start monitoring */
+		i2c_smbus_write_byte_data(client, SMSC47M192_REG_CONFIG,
+						(config & 0xf7) | 0x01);
+
+	}
+
+}
+
+static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	int i, config;
+	u16 alarms;
+
+	down(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+						|| !data->valid) {
+		u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
+
+		dev_dbg(&client->dev, "Starting smsc47m192 update\n");
+
+		for (i = 0; i <= 7; i++) {
+			data->in[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_IN(i));
+			data->in_min[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_IN_MIN(i));
+			data->in_max[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_IN_MAX(i));
+		}
+		for (i = 0; i < 3; i++) {
+			data->temp[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP(i));
+			data->temp_max[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_MAX(i));
+			data->temp_min[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_MIN(i));
+		}
+		data->temp_offset[2] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_OFFSET(3));
+		for (i = 1; i < 3; i++)
+			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_OFFSET(i));
+		/* first offset is temp_offset[0] if SFR bit 4 is set,
+					temp_offset[1] otherwise */
+		if (sfr & 0x10) {
+			data->temp_offset[0] = data->temp_offset[1];
+			data->temp_offset[1] = 0;
+		} else
+			data->temp_offset[0] = 0;
+
+		data->vid = i2c_smbus_read_byte_data(client, SMSC47M192_REG_VID)
+									& 0x0f;
+		config = i2c_smbus_read_byte_data(client,SMSC47M192_REG_CONFIG);
+		if (config & 0x20)
+			data->vid |= (i2c_smbus_read_byte_data(client,
+					SMSC47M192_REG_VID4) & 0x01) << 4;
+		alarms = i2c_smbus_read_byte_data(client, SMSC47M192_REG_ALARM1)
+				+ (i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_ALARM2) << 8);
+		data->raw_alarms = alarms;
+		data->alarm[0] = (alarms & 0x000f) + ((alarms & 0x0f00) >> 4);
+		data->alarm[1] = (alarms & 0x0070) >> 4;
+		data->alarm[2] = (alarms >> 13) & 6;
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+
+	return data;
+}
+
+static int __init smsc47m192_init(void)
+{
+	return i2c_add_driver(&smsc47m192_driver);
+}
+
+static void __exit smsc47m192_exit(void)
+{
+	i2c_del_driver(&smsc47m192_driver);
+}
+
+MODULE_AUTHOR("Hartmut Rick <linux at rick.claranet.de>");
+MODULE_DESCRIPTION("SMSC47M192 driver");
+MODULE_LICENSE("GPL");
+
+module_init(smsc47m192_init);
+module_exit(smsc47m192_exit);
