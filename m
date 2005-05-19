From: maartendeprez@scarlet.be (maartendeprez@scarlet.be)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: GL520SM driver
Message-Id: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I ported the driver for the GL520SM chip to linux 2.6 . It is only tested on my hardware; maybe some others could also test it? For me, it seems to work fine. Also, some changes to the lm_sensors library chips.c were needed for makeing it find its way through the sysfs interface (included in the patch).
Note that i also had to apply another patch (see m7101.patch) to un-hide the Ali M7101 PMU to which the GL520SM is connected. In the lm_sensors package is included a module for linux 2.4 to "hotplug" this device if it is hidden. This patch patches drivers/pci/quirks.c, as it is really a bug in the BIOS. Maybe it should be integrated into the kernel or at least be included in the lm_sensors package? I found it on the linux kernel mailing list.
This chip can be configured to read either a second temperature sensor or a fourth voltage sensor. The user can configure this through the two_temps file. If it contains "1" the temp2_* files are valid and if it contains "0" the in4_* files are valid. I think it would make sense to remove the irrelevant files from the directory instead of leaving dummy files, but i think the library needs some changes therefor.

Maarten Deprez
-------------- next part --------------
--- linux-2.6.10/drivers/i2c/chips/Kconfig.orig	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/Kconfig	2005-01-25 12:00:17.000000000 +0100
@@ -95,6 +95,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl518sm.
 
+config SENSORS_GL520SM
+	tristate "Genesys Logic GL520SM"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Genesys Logic GL520SM
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called gl520sm.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on I2C && EXPERIMENTAL
--- linux-2.6.10/drivers/i2c/chips/Makefile.orig	2005-01-25 12:03:44.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/Makefile	2005-01-25 12:03:51.000000000 +0100
@@ -15,6 +15,7 @@
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
+obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
--- /dev/null	2005-01-27 11:18:25.420156848 +0100
+++ linux-2.6.10/drivers/i2c/chips/gl520sm.c	2005-01-27 11:30:53.244470272 +0100
@@ -0,1 +1,602 @@
+/*
+    gl520sm.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>,
+                              Ky?sti M?lkki <kmalkki@cc.hut.fi>
+    Copyright (c) 2005        Maarten Deprez <maartendeprez@users.sourceforge.net>
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
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(gl520sm);
+
+/* Many GL520 constants specified below 
+One of the inputs can be configured as either temp or voltage.
+That's why _TEMP2 and _VIN4 access the same register 
+*/
+
+/* The GL520 registers */
+#define GL520_REG_CHIP_ID 0x00
+#define GL520_REG_REVISION 0x01
+#define GL520_REG_VID 0x02
+#define GL520_REG_CONF 0x03
+#define GL520_REG_TEMP1 0x04
+#define GL520_REG_TEMP1_MAX 0x05
+#define GL520_REG_TEMP1_MAX_HYST 0x06
+#define GL520_REG_FAN 0x07
+#define GL520_REG_FAN_LIMIT 0x08
+#define GL520_REG_IN1_LIMIT 0x09
+#define GL520_REG_IN2_LIMIT 0x0a
+#define GL520_REG_IN3_LIMIT 0x0b
+#define GL520_REG_VDD_LIMIT 0x0c
+#define GL520_REG_IN3 0x0d
+#define GL520_REG_IN4 0x0e
+#define GL520_REG_TEMP2 0x0e
+#define GL520_REG_MISC 0x0f
+#define GL520_REG_BEEP_MASK 0x10
+#define GL520_REG_MASK 0x11
+#define GL520_REG_ALARMS 0x12
+#define GL520_REG_IN2 0x13
+#define GL520_REG_IN1 0x14
+#define GL520_REG_VDD 0x15
+#define GL520_REG_TEMP2_MAX 0x17
+#define GL520_REG_IN4_MAX 0x17
+#define GL520_REG_TEMP2_MAX_HYST 0x18
+#define GL520_REG_IN4_MIN 0x18
+
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((((val)<0?(val)-500:(val)+500) / 1000)+130),0,255))
+#define TEMP_FROM_REG(val) (((val) - 130) * 1000)
+
+#define DIV_TO_REG(val) ((val)=4?2:(val)=2?1:(val)=1?0:3)
+#define DIV_FROM_REG(val) (1 << (val))
+
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm = 0)
+		return 0;
+	div = DIV_FROM_REG(div);
+	rpm = SENSORS_LIMIT(rpm, 1, 1920000) * div;
+	return SENSORS_LIMIT((960000 + rpm / 2) / rpm, 1, 255);
+}
+#define FAN_FROM_REG(val,div) ((val)=0 ? 0 : (960000/((val)*DIV_FROM_REG(div))))
+
+#define VID_FROM_REG(val) ((val)=0x1f?0:(val)>=0x10?5100-(val)*100:2050-(val)*50)
+
+#define IN_TO_REG(val) (SENSORS_LIMIT((((val)+9)/19),0,255))
+#define IN_FROM_REG(val) ((val)*19)
+
+#define VDD_TO_REG(val) (SENSORS_LIMIT((((val)*4+47)/95),0,255))
+#define VDD_FROM_REG(val) (((val)*95+2)/4)
+
+#define ALARMS_FROM_REG(val) val
+
+#define BEEP_MASK_TO_REG(val) (val & data->alarm_mask)
+#define BEEP_MASK_FROM_REG(val) (val)
+
+#define BOOL_TO_REG(val) ((val)?1:0)
+#define BOOL_FROM_REG(val) ((val)?1:0)
+
+#define NBOOL_TO_REG(val) ((val)?0:1)
+#define NBOOL_FROM_REG(val) ((val)?0:1)
+
+/* Each client has this additional data */
+struct gl520_data {
+	struct i2c_client client;
+	enum chips type;
+
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 vid;			/* Register value */
+	u8 in_input[5];		/* Register values; [0] = VDD */
+	u8 in_min[5];		/* Register values; [0] = VDD */
+	u8 in_max[5];		/* Register values; [0] = VDD */
+	u8 fan_input[2];
+	u8 fan_min[2];
+	u8 fan_div[2];		/* Register encoding, shifted right */
+	u8 fan_off;		/* Boolean */
+	u8 temp_input[2];	/* Register values */
+	u8 temp_max[2];		/* Register values */
+	u8 temp_max_hyst[2];	/* Register values */
+	u8 alarms;		/* Register value */
+	u8 beep_enable;		/* Boolean */
+	u8 beep_mask;		/* Register value */
+	u8 alarm_mask;
+	u8 one_temp;		/* Boolean */
+};
+
+static int gl520_attach_adapter(struct i2c_adapter *adapter);
+static int gl520_detect(struct i2c_adapter *adapter, int address, int kind);
+static void gl520_init_client(struct i2c_client *client);
+static int gl520_detach_client(struct i2c_client *client);
+static int gl520_read_value(struct i2c_client *client, u8 reg);
+static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value);
+static struct gl520_data *gl520_update_device(struct device *dev);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver gl520_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "gl520sm",
+	.id		= I2C_DRIVERID_GL520,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= gl520_attach_adapter,
+	.detach_client	= gl520_detach_client,
+};
+
+/*
+ * Internal variables
+ */
+
+static int gl520_id = 0;
+
+/*
+ * Sysfs stuff
+ */
+
+#define get(name, value)						\
+static ssize_t get_##name(struct device *dev, char *buf)		\
+{									\
+	struct gl520_data *data = gl520_update_device(dev);		\
+	return sprintf(buf, "%d\n", value);				\
+}
+
+#define get_if(name, value, cond)					\
+static ssize_t get_##name(struct device *dev, char *buf)		\
+{									\
+	struct gl520_data *data = gl520_update_device(dev);		\
+	return sprintf(buf, "%d\n", (cond) ? value : 0);		\
+}
+
+#define set(name, var, value, reg)					\
+static ssize_t set_##name(struct device *dev, const char *buf, size_t count)	\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct gl520_data *data = i2c_get_clientdata(client);		\
+	long val = simple_strtol(buf, NULL, 10);			\
+	var = value;							\
+	gl520_write_value(client, reg, var);				\
+	return count;							\
+}
+
+#define set_if(name, var, value, reg, cond)				\
+static ssize_t set_##name(struct device *dev, const char *buf, size_t count)	\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct gl520_data *data = i2c_get_clientdata(client);		\
+	if (cond) {							\
+		long val = simple_strtol(buf, NULL, 10);		\
+		var = value;						\
+		gl520_write_value(client, reg, var);			\
+	}								\
+	return count;							\
+}
+
+#define setb(name, var, value, reg, mask, shift)			\
+static ssize_t set_##name(struct device *dev, const char *buf, size_t count)	\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct gl520_data *data = i2c_get_clientdata(client);		\
+	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+	int regval = gl520_read_value(client, reg);			\
+	var = value;							\
+	regval = (regval & ~mask) | (var << shift);			\
+	gl520_write_value(client, reg, regval);				\
+	return count;							\
+}
+
+#define setl(name, var, value, reg) setb(name, var, value, reg, 0x00ff, 0)
+#define seth(name, var, value, reg) setb(name, var, value, reg, 0xff00, 8)
+
+#define set_fan_min(name, var, value, mask, shift, beep)		\
+static ssize_t set_##name(struct device *dev, const char *buf, size_t count)	\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct gl520_data *data = i2c_get_clientdata(client);		\
+	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+	int regval = gl520_read_value(client, GL520_REG_FAN_LIMIT);	\
+									\
+	var = value;							\
+	regval = (regval & ~mask) | (var << shift);			\
+	gl520_write_value(client, GL520_REG_FAN_LIMIT, regval);		\
+									\
+	data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);\
+	if (data->fan_min[0] = 0)					\
+		data->alarm_mask &= ~beep;				\
+	else								\
+		data->alarm_mask |= beep;				\
+	data->beep_mask &= data->alarm_mask;				\
+	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);\
+									\
+	return count;							\
+}
+
+#define setl_fan_min(name, var, value, beep) set_fan_min(name, var, value, 0x00ff, 0, beep)
+#define seth_fan_min(name, var, value, beep) set_fan_min(name, var, value, 0xff00, 8, beep)
+
+get(cpu0_vid, VID_FROM_REG(data->vid));
+get(in0_input, VDD_FROM_REG(data->in_input[0]));
+get(in0_min, VDD_FROM_REG(data->in_min[0]));
+get(in0_max, VDD_FROM_REG(data->in_max[0]));
+get(in1_input, IN_FROM_REG(data->in_input[1]));
+get(in1_min, IN_FROM_REG(data->in_min[1]));
+get(in1_max, IN_FROM_REG(data->in_max[1]));
+get(in2_input, IN_FROM_REG(data->in_input[2]));
+get(in2_min, IN_FROM_REG(data->in_min[2]));
+get(in2_max, IN_FROM_REG(data->in_max[2]));
+get(in3_input, IN_FROM_REG(data->in_input[3]));
+get(in3_min, IN_FROM_REG(data->in_min[3]));
+get(in3_max, IN_FROM_REG(data->in_max[2]));
+get_if(in4_input, IN_FROM_REG(data->in_input[4]), data->one_temp);
+get_if(in4_min, IN_FROM_REG(data->in_min[4]), data->one_temp);
+get_if(in4_max, IN_FROM_REG(data->in_max[4]), data->one_temp);
+get(fan1_input, FAN_FROM_REG(data->fan_input[0], data->fan_div[0]));
+get(fan1_min, FAN_FROM_REG(data->fan_min[0], data->fan_div[0]));
+get(fan1_div, DIV_FROM_REG(data->fan_div[0]));
+get(fan1_off, BOOL_FROM_REG(data->fan_off));
+get(fan2_input, FAN_FROM_REG(data->fan_input[1], data->fan_div[1]));
+get(fan2_min, FAN_FROM_REG(data->fan_min[1], data->fan_div[1]));
+get(fan2_div, DIV_FROM_REG(data->fan_div[1]));
+get(temp1_input, TEMP_FROM_REG(data->temp_input[0]));
+get(temp1_max, TEMP_FROM_REG(data->temp_max[0]));
+get(temp1_max_hyst, TEMP_FROM_REG(data->temp_max_hyst[0]));
+get_if(temp2_input, TEMP_FROM_REG(data->temp_input[1]), !data->one_temp);
+get_if(temp2_max, TEMP_FROM_REG(data->temp_max[1]), !data->one_temp);
+get_if(temp2_max_hyst, TEMP_FROM_REG(data->temp_max_hyst[1]), !data->one_temp);
+get(alarms, ALARMS_FROM_REG(data->alarms));
+get(beep_enable, NBOOL_FROM_REG(data->beep_enable));
+get(beep_mask, BEEP_MASK_FROM_REG(data->beep_mask));
+get(two_temps, NBOOL_FROM_REG(data->one_temp));
+
+setl(in0_min, data->in_min[0], VDD_TO_REG(val), GL520_REG_VDD_LIMIT);
+seth(in0_max, data->in_max[0], VDD_TO_REG(val), GL520_REG_VDD_LIMIT);
+setl(in1_min, data->in_min[1], IN_TO_REG(val), GL520_REG_IN1_LIMIT);
+seth(in1_max, data->in_max[1], IN_TO_REG(val), GL520_REG_IN1_LIMIT);
+setl(in2_min, data->in_min[2], IN_TO_REG(val), GL520_REG_IN2_LIMIT);
+seth(in2_max, data->in_max[2], IN_TO_REG(val), GL520_REG_IN2_LIMIT);
+setl(in3_min, data->in_min[3], IN_TO_REG(val), GL520_REG_IN3_LIMIT);
+seth(in3_max, data->in_max[3], IN_TO_REG(val), GL520_REG_IN3_LIMIT);
+set_if(in4_min, data->in_min[4], IN_TO_REG(val), GL520_REG_IN4_MIN, data->one_temp);
+set_if(in4_max, data->in_max[4], IN_TO_REG(val), GL520_REG_IN4_MAX, data->one_temp);
+seth_fan_min(fan1_min, data->fan_min[0], FAN_TO_REG(val, data->fan_div[0]), 0x20);
+setb(fan1_div, data->fan_div[0], DIV_TO_REG(val), GL520_REG_MISC, 0xc0, 6);
+setb(fan1_off, data->fan_off, BOOL_TO_REG(val), GL520_REG_MISC, 0x04, 2);
+setl_fan_min(fan2_min, data->fan_min[1], FAN_TO_REG(val, data->fan_div[1]), 0x40);
+setb(fan2_div, data->fan_div[1], DIV_TO_REG(val), GL520_REG_MISC, 0x30, 4);
+set(temp1_max, data->temp_max[0], TEMP_TO_REG(val), GL520_REG_TEMP1_MAX);
+set(temp1_max_hyst, data->temp_max_hyst[0], TEMP_TO_REG(val), GL520_REG_TEMP1_MAX_HYST);
+set_if(temp2_max, data->temp_max[1], TEMP_TO_REG(val), GL520_REG_TEMP2_MAX, !data->one_temp);
+set_if(temp2_max_hyst, data->temp_max_hyst[1], TEMP_TO_REG(val), GL520_REG_TEMP2_MAX_HYST, !data->one_temp);
+setb(beep_enable, data->beep_enable, NBOOL_TO_REG(val), GL520_REG_CONF, 0x04, 2);
+set(beep_mask, data->beep_mask, BEEP_MASK_TO_REG(val), GL520_REG_BEEP_MASK);
+setb(two_temps, data->one_temp, NBOOL_TO_REG(val), GL520_REG_CONF, 0x10, 4);
+
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, get_cpu0_vid, NULL);
+static DEVICE_ATTR(in0_input, S_IRUGO, get_in0_input, NULL);
+static DEVICE_ATTR(in0_min, S_IWUSR|S_IRUGO, get_in0_min, set_in0_min);
+static DEVICE_ATTR(in0_max, S_IWUSR|S_IRUGO, get_in0_max, set_in0_max);
+static DEVICE_ATTR(in1_input, S_IRUGO, get_in1_input, NULL);
+static DEVICE_ATTR(in1_min, S_IWUSR|S_IRUGO, get_in1_min, set_in1_min);
+static DEVICE_ATTR(in1_max, S_IWUSR|S_IRUGO, get_in1_max, set_in1_max);
+static DEVICE_ATTR(in2_input, S_IRUGO, get_in2_input, NULL);
+static DEVICE_ATTR(in2_min, S_IWUSR|S_IRUGO, get_in2_min, set_in2_min);
+static DEVICE_ATTR(in2_max, S_IWUSR|S_IRUGO, get_in2_max, set_in2_max);
+static DEVICE_ATTR(in3_input, S_IRUGO, get_in3_input, NULL);
+static DEVICE_ATTR(in3_min, S_IWUSR|S_IRUGO, get_in3_min, set_in3_min);
+static DEVICE_ATTR(in3_max, S_IWUSR|S_IRUGO, get_in3_max, set_in3_max);
+static DEVICE_ATTR(in4_input, S_IRUGO, get_in4_input, NULL);
+static DEVICE_ATTR(in4_min, S_IWUSR|S_IRUGO, get_in4_min, set_in4_min);
+static DEVICE_ATTR(in4_max, S_IWUSR|S_IRUGO, get_in4_max, set_in4_max);
+static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan1_input, NULL);
+static DEVICE_ATTR(fan1_min, S_IWUSR|S_IRUGO, get_fan1_min, set_fan1_min);
+static DEVICE_ATTR(fan1_div, S_IWUSR|S_IRUGO, get_fan1_div, set_fan1_div);
+static DEVICE_ATTR(fan1_off, S_IWUSR|S_IRUGO, get_fan1_off, set_fan1_off);
+static DEVICE_ATTR(fan2_input, S_IRUGO, get_fan2_input, NULL);
+static DEVICE_ATTR(fan2_min, S_IWUSR|S_IRUGO, get_fan2_min, set_fan2_min);
+static DEVICE_ATTR(fan2_div, S_IWUSR|S_IRUGO, get_fan2_div, set_fan2_div);
+static DEVICE_ATTR(temp1_input, S_IRUGO, get_temp1_input, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR|S_IRUGO, get_temp1_max, set_temp1_max);
+static DEVICE_ATTR(temp1_max_hyst, S_IWUSR|S_IRUGO, get_temp1_max_hyst, set_temp1_max_hyst);
+static DEVICE_ATTR(temp2_input, S_IRUGO, get_temp2_input, NULL);
+static DEVICE_ATTR(temp2_max, S_IWUSR|S_IRUGO, get_temp2_max, set_temp2_max);
+static DEVICE_ATTR(temp2_max_hyst, S_IWUSR|S_IRUGO, get_temp2_max_hyst, set_temp2_max_hyst);
+static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
+static DEVICE_ATTR(beep_enable, S_IWUSR|S_IRUGO, get_beep_enable, set_beep_enable);
+static DEVICE_ATTR(beep_mask, S_IWUSR|S_IRUGO, get_beep_mask, set_beep_mask);
+static DEVICE_ATTR(two_temps, S_IWUSR|S_IRUGO, get_two_temps, set_two_temps);
+
+/*
+ * Real code
+ */
+
+static int gl520_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_detect(adapter, &addr_data, gl520_detect);
+}
+
+static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct gl520_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		    goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access gl520_{read,write}_value. */
+
+	if (!(data = kmalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct gl520_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &gl520_driver;
+	new_client->flags = 0;
+
+	/* Determine the chip type. */
+	if (gl520_read_value(new_client, GL520_REG_CHIP_ID) != 0x20) {
+		dev_info(&adapter->dev,
+		    "Ignoring 'force' parameter for unknown "
+		    "chip at adapter %d, address 0x%02x\n",
+		    i2c_adapter_id(adapter), address);
+		goto exit_free;
+	} else {
+		kind = gl520sm;
+	}
+
+	/* Fill in the remaining client fields */
+	strlcpy(new_client->name, "gl520sm", I2C_NAME_SIZE);
+	new_client->id = gl520_id++;
+	data->type = kind;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the GL520SM chip */
+	data->alarm_mask = 0xff;
+	gl520_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan1_off);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_beep_enable);
+	device_create_file(&new_client->dev, &dev_attr_beep_mask);
+	device_create_file(&new_client->dev, &dev_attr_two_temps);
+
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+
+/* Called when we have found a new GL520SM. */
+static void gl520_init_client(struct i2c_client *client)
+{
+	u8 oldconf, conf;
+
+	conf = oldconf = gl520_read_value(client, GL520_REG_CONF);
+
+	/* If IRQ# is disabled, we can safely force comparator mode */
+	if (!(conf & 0x20))
+		conf &= 0xf7;
+
+	/* Enable monitoring if needed */
+	conf |= 0x40;
+
+	if (conf != oldconf)
+		gl520_write_value(client, GL520_REG_CONF, conf);
+}
+
+static int gl520_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+
+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized 
+   GL520 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int gl520_read_value(struct i2c_client *client, u8 reg)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return swab16(i2c_smbus_read_word_data(client, reg));
+	else
+		return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return i2c_smbus_write_word_data(client, reg, swab16(value));
+	else
+		return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static struct gl520_data *gl520_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int val;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+		dev_dbg(&client->dev, "Starting gl520sm update\n");
+
+		val = gl520_read_value(client, GL520_REG_CONF);
+		data->one_temp = val & 0x10;
+
+		data->alarms = gl520_read_value(client, GL520_REG_ALARMS);
+		data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
+		data->vid = gl520_read_value(client, GL520_REG_VID) & 0x1f;
+
+		val = gl520_read_value(client, GL520_REG_VDD_LIMIT);
+		data->in_min[0] = val & 0xff;
+		data->in_max[0] = (val >> 8) & 0xff;
+		val = gl520_read_value(client, GL520_REG_IN1_LIMIT);
+		data->in_min[1] = val & 0xff;
+		data->in_max[1] = (val >> 8) & 0xff;
+		val = gl520_read_value(client, GL520_REG_IN2_LIMIT);
+		data->in_min[2] = val & 0xff;
+		data->in_max[2] = (val >> 8) & 0xff;
+		val = gl520_read_value(client, GL520_REG_IN3_LIMIT);
+		data->in_min[3] = val & 0xff;
+		data->in_max[3] = (val >> 8) & 0xff;
+
+		val = gl520_read_value(client, GL520_REG_FAN);
+		data->fan_input[0] = (val >> 8) & 0xff;
+		data->fan_input[1] = val & 0xff;
+
+		val = gl520_read_value(client, GL520_REG_FAN_LIMIT);
+		data->fan_min[0] = (val >> 8) & 0xff;
+		data->fan_min[1] = val & 0xff;
+
+		data->temp_input[0] = gl520_read_value(client, GL520_REG_TEMP1);
+		data->temp_max[0] = gl520_read_value(client, GL520_REG_TEMP1_MAX);
+		data->temp_max_hyst[0] = gl520_read_value(client, GL520_REG_TEMP1_MAX_HYST);
+
+		val = gl520_read_value(client, GL520_REG_MISC);
+		data->fan_div[0] = (val >> 6) & 0x03;
+		data->fan_div[1] = (val >> 4) & 0x03;
+		data->fan_off = (val >> 2) & 0x01;
+
+		data->alarms &= data->alarm_mask;
+
+		val = gl520_read_value(client, GL520_REG_CONF);
+		data->beep_enable = (val >> 2) & 1;
+
+		data->in_input[0] = gl520_read_value(client, GL520_REG_VDD);
+		data->in_input[1] = gl520_read_value(client, GL520_REG_IN1);
+		data->in_input[2] = gl520_read_value(client, GL520_REG_IN2);
+		data->in_input[3] = gl520_read_value(client, GL520_REG_IN3);
+
+		/* Temp1 and Vin4 are the same input */
+		if (data->one_temp) {
+			data->in_input[4] = gl520_read_value(client, GL520_REG_IN4);
+			data->in_min[4] = gl520_read_value(client, GL520_REG_IN4_MIN);
+			data->in_max[4] = gl520_read_value(client, GL520_REG_IN4_MAX);
+		} else {
+			data->temp_input[1] = gl520_read_value(client, GL520_REG_TEMP2);
+			data->temp_max[1] = gl520_read_value(client, GL520_REG_TEMP2_MAX);
+			data->temp_max_hyst[1] = gl520_read_value(client, GL520_REG_TEMP2_MAX_HYST);
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+
+	return data;
+}
+
+static int __init sensors_gl520sm_init(void)
+{
+	return i2c_add_driver(&gl520_driver);
+}
+
+static void __exit sensors_gl520sm_exit(void)
+{
+	i2c_del_driver(&gl520_driver);
+}
+
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+	"Ky?sti M?lkki <kmalkki@cc.hut.fi>, "
+	"Maarten Deprez <maartendeprez@users.sourceforge.net>");
+MODULE_DESCRIPTION("GL520SM driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_gl520sm_init);
+module_exit(sensors_gl520sm_exit);
--- lm_sensors-2.9.0/lib/chips.c.orig	2004-11-24 05:31:40.000000000 +0100
+++ lm_sensors-2.9.0/lib/chips.c	2005-01-27 11:03:01.000000000 +0100
@@ -613,7 +613,7 @@
 static sensors_chip_feature gl520_features[]    {
     { SENSORS_GL520_VDD, "vdd", NOMAP,NOMAP,
-                            R, GL520_SYSCTL_VDD, VALUE(3), 2 },
+                            R, GL520_SYSCTL_VDD, VALUE(3), 2, "in0_input", 3 },
     { SENSORS_GL520_VIN1, "vin1", NOMAP,NOMAP,
                              R, GL520_SYSCTL_VIN1, VALUE(3), 
                              2 },
@@ -626,7 +626,7 @@
                              R, GL520_SYSCTL_VIN4, VALUE(3), 2 },
     { SENSORS_GL520_VDD_MIN, "vdd_min", SENSORS_GL520_VDD,
                                 SENSORS_GL520_VDD, RW,
-                                GL520_SYSCTL_VDD, VALUE(1), 2 },
+                                GL520_SYSCTL_VDD, VALUE(1), 2, "in0_min", 3 },
     { SENSORS_GL520_VIN1_MIN, "vin1_min", SENSORS_GL520_VIN1, 
                                  SENSORS_GL520_VIN1, RW,
                                  GL520_SYSCTL_VIN1, VALUE(1), 2 },
@@ -641,7 +641,7 @@
                                  GL520_SYSCTL_VIN4, VALUE(1), 2 },
     { SENSORS_GL520_VDD_MAX, "vdd_max", SENSORS_GL520_VDD,
                                 SENSORS_GL520_VDD, RW,
-                                GL520_SYSCTL_VDD, VALUE(2), 2 },
+                                GL520_SYSCTL_VDD, VALUE(2), 2, "in0_max", 3 },
     { SENSORS_GL520_VIN1_MAX, "vin1_max", SENSORS_GL520_VIN1, 
                                  SENSORS_GL520_VIN1, RW,
                                  GL520_SYSCTL_VIN1, VALUE(2), 2 },
-------------- next part --------------
--- drivers/pci/quirks.c.old	2004-12-24 22:33:49.000000000 +0100
+++ drivers/pci/quirks.c	2005-01-18 16:46:57.057499248 +0100
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
+#include "pci.h"
+
 #undef DEBUG
 
 /* Deal with broken BIOS'es that neglect to enable passive release,
@@ -280,6 +282,76 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi );
 
+/* ALi 1533 fixup to enable the M7101 SMBus Controller
+ *          ported from prog/hotplug of the lm_sensors
+ *          package
+ */
+static void __devinit quirk_ali1533_smbus(struct pci_dev *dev)
+{
+	u8 val = 0;
+	struct pci_dev *m7101;
+	
+	printk ( "M7101: Looking for disabled device... " );
+	
+	m7101 = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, NULL);
+	
+	if ( m7101 )
+	{
+		printk ( "not found!\n" );
+		return;
+	}
+
+	pci_read_config_byte ( dev, 0x5F, &val );
+
+	if ( val & 0x4 )
+	{
+		printk ( "found.\n" );	
+		printk ( "M7101: Enabling M7101 device ... " );
+
+	    	pci_write_config_byte ( dev, 0x5F, val & 0xFB );
+		pci_read_config_byte ( dev, 0x5F, &val );
+
+		if ( val & 0x4 )
+		{
+			printk ( "failed.\n" );
+			return;
+		}
+		
+		printk ( "OK.\n" );
+	}
+	else
+		printk ( "not found.\n" );
+
+	m7101 = pci_scan_single_device ( dev->bus, 0x18 );
+
+	printk ( "M7101: Do we need to unlock registers? ... " );
+
+	if ( pci_read_config_byte ( m7101, 0x05B, &val ) )
+	{
+		printk ( "Failed to read.\n");
+		return;
+	}
+
+	if ( val & 0x06 )
+	{
+		printk ( "yes.\n" );
+		printk ( "M7101: Unlocking registers ..." );
+		
+		val = val & ~0x06;
+
+		if ( pci_write_config_byte ( m7101, 0x05B, val ) )
+		{
+			printk ( "failed.\n" );
+			return;
+		}
+
+		printk ( "OK.\n" );
+	}
+	else
+		printk ( "no.\n" );
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533,		quirk_ali1533_smbus );
+
 /*
  * PIIX4 ACPI: Two IO regions pointed to by longwords at
  *	0x40 (64 bytes of ACPI registers)
