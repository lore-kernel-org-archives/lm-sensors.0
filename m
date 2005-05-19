From: hcb@chaoticmind.net (Helge Bahmann)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC/PATCH] i2c sensors driver for mtp008
Message-Id: <Pine.LNX.4.44.0505092331500.8626-200000@lothlorien.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This is a port of the original mtp008 sensors driver that works with
current kernels. It is tested on a Tyan S1834 Tiger 133 mainboard, with
two Intel P3 CPUs and AFAICT delivers correct results to user-space (or,
at least, the same values as the old driver and the BIOS does...)

I would like to submit it for inclusion, however I just read the
post regarding "dynamic sysfs callbacks":

	http://archives.andrew.net.au/lm-sensors/msg31380.html

If this is intended for inclusion anytime soon I retract the current patch
and will be happy to rework the driver to use the new infrastructure
(because it allows me to clean up the macro-generated-function-mess that
the presented driver unfortunately has to be).

Comments?

(Please CC, not on sensors list)

Best regards
-- 
Helge Bahmann <hcb@chaoticmind.net>                     /| \__
The past: Smart users in front of dumb terminals       /_|____\
                                                     _/\ |   __)
$ ./configure                                        \\ \|__/__|
checking whether build environment is sane... yes     \\/___/ |
checking for AIX... no (we already did this)            |
-------------- next part --------------
diff -r -u -N a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-05-09 23:34:34.529384909 +0200
+++ b/drivers/i2c/chips/Kconfig	2005-05-09 23:36:08.971654098 +0200
@@ -224,6 +224,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1619.
 
+config SENSORS_MTP008
+	tristate "Myson MTP008 sensor chip"
+	depends on I2C_SENSOR
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Myson MTP008 chip.
+	  
+	  This driver can also be built as a module. If so, the module
+	  will be called mtp008.
+
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	depends on I2C && EXPERIMENTAL
diff -r -u -N a/drivers/i2c/chips/mtp008.c b/drivers/i2c/chips/mtp008.c
--- a/drivers/i2c/chips/mtp008.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/i2c/chips/mtp008.c	2005-05-09 23:28:07.886034578 +0200
@@ -0,0 +1,1075 @@
+/*
+   mtp008.c - I2C driver for the Myson MTP008
+   
+   Copyright (C) 2005 Helge Bahmann <hcb@chaoticmind.net>
+   (port to 2.6 kernel)
+   Copyright (C) 2001, 2004  Kris Van Hees <aedil@alchar.org>
+   (original driver from lm_sensors project)
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+	This is a straight port of the original mtp008 driver for 2.6; it is
+	working	nicely for me, but I may have mixed up some of the magnitude
+	conversions while porting. If you find something that does not look
+	right, bug me (Helge Bahmann <hcb@chaoticmind>) and I will try to fix
+	it.
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+MODULE_LICENSE("GPL");
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
+static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(mtp008);
+
+/* The MTP008 registers */
+/*      in0 .. in6 */
+#define MTP008_REG_IN(nr)		(0x20 + (nr))
+#define MTP008_REG_IN_MAX(nr)		(0x2b + (nr) * 2)
+#define MTP008_REG_IN_MIN(nr)		(0x2c + (nr) * 2)
+
+/*      temp1 */
+#define MTP008_REG_TEMP			0x27
+#define MTP008_REG_TEMP_MAX		0x39
+#define MTP008_REG_TEMP_MAX_HYST	0x3a
+
+/*      fan1 .. fan3 */
+#define MTP008_REG_FAN(nr)		(0x27 + (nr))
+#define MTP008_REG_FAN_MIN(nr)		(0x3a + (nr))
+
+#define MTP008_REG_CONFIG		0x40
+#define MTP008_REG_INT_STAT1		0x41
+#define MTP008_REG_INT_STAT2		0x42
+
+#define MTP008_REG_SMI_MASK1		0x43
+#define MTP008_REG_SMI_MASK2		0x44
+
+#define MTP008_REG_NMI_MASK1		0x45
+#define MTP008_REG_NMI_MASK2		0x46
+
+#define MTP008_REG_VID_FANDIV		0x47
+
+#define MTP008_REG_I2C_ADDR		0x48
+
+#define MTP008_REG_RESET_VID4		0x49
+
+#define MTP008_REG_OVT_PROP		0x50
+
+#define MTP008_REG_BEEP_CTRL1		0x51
+#define MTP008_REG_BEEP_CTRL2		0x52
+
+/*      pwm1 .. pwm3  nr range 1-3 */
+#define MTP008_REG_PWM_CTRL(nr)		(0x52 + (nr))
+
+#define MTP008_REG_PIN_CTRL1		0x56
+#define MTP008_REG_PIN_CTRL2		0x57
+
+#define MTP008_REG_CHIPID		0x58
+
+/*
+ * Pin control register configuration constants.
+ */
+#define MTP008_CFG_VT1_PII		0x08
+#define MTP008_CFG_VT2_AIN		0x00
+#define MTP008_CFG_VT2_VT		0x03
+#define MTP008_CFG_VT2_PII		0x04
+#define MTP008_CFG_VT2_MASK		0x06
+#define MTP008_CFG_VT3_VT		0x01
+
+/* sensor pin types */
+#define VOLTAGE		1
+#define THERMISTOR	2
+#define PIIDIODE	3
+
+/*
+ * Conversion routines and macros.  Limit checking is only done on
+ * the TO_REG variants.
+ *
+ * Note that IN values are expressed as 1000 times the actual voltage to avoid
+ * having to use floating point values.  As such, IN values are between 0 and
+ * 4096 (0V to 4.096V).
+ */
+#define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 8) / 16), 0, 255))
+#define IN_FROM_REG(val)	(((val) * 16 + 5))
+
+/*
+ * The fan rotation count (as stored in the register) is calculated using the
+ * following formula:
+ *      count = (22.5K * 60) / (rpm * div) = 1350000 / (rpm * div)
+ * and the rpm is therefore:
+ *      rpm = 1350000 / (count * div)
+ */
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm = 0)
+		return 255;
+
+	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
+
+	return SENSORS_LIMIT(
+		 (1350000 + rpm * div / 2) / (rpm * div),
+		 1, 254
+	       );
+}
+
+#define FAN_FROM_REG(val, div)	((val) = 0 ? -1			      \
+					    : (val) = 255 ? 0		      \
+							   : 1350000 /	      \
+							     ((val) * (div))  \
+				)
+
+/*
+ * Temperatures are stored as two's complement values of the Celsius value.
+ * Scale to correct range for sensors.
+ */
+#define TEMP_TO_REG(val)	(					      \
+				 (val) < 0				      \
+				    ? SENSORS_LIMIT(((val) - 500) / 1000, 0, 255) \
+				    : SENSORS_LIMIT(((val) + 500) / 1000, 0, 255) \
+				)
+#define TEMP_FROM_REG(val)	(					      \
+				 (					      \
+				  (val) > 0x80 ? (val) - 0x100		      \
+					       : (val)			      \
+				 ) * 1000					      \
+				)
+
+/*
+ * VCORE voltage:
+ *      0x00 to 0x0f    = 2.05 to 1.30 (0.05 per unit)
+ *      0x10 to 0x1e    = 3.50 to 2.10 (0.10 per unit)
+ *      0x1f            = No CPU
+ */
+#define VID_FROM_REG(val)	((val) = 0x1f				      \
+					 ? 0				      \
+					 : (val) < 0x10 ? 205 - (val) * 5     \
+							: 510 - (val) * 10)
+
+/*
+ * Fan divider.
+ */
+#define DIV_FROM_REG(val)	(1 << (val))
+#define DIV_TO_REG(val)		((val) = 8 ? 3				      \
+					    : (val) = 4 ? 2		      \
+							 : (val) = 2 ? 1     \
+								      : 0)
+
+/*
+ * Alarms (interrupt status).
+ */
+#define ALARMS_FROM_REG(val)	(val)
+
+/*
+ * Beep controls.
+ */
+#define BEEPS_FROM_REG(val)	(val)
+#define BEEPS_TO_REG(val)	(val)
+
+/*
+ * PWM control. nr range 1 to 3
+ */
+#define PWM_FROM_REG(val)	(val)
+#define PWM_TO_REG(val)		(val)
+#define PWMENABLE_FROM_REG(nr, val)	(((val) >> ((nr) + 3)) & 1)
+
+/*
+ * For each registered MTP008, we need to keep some data in memory.  The
+ * structure itself is dynamically allocated, at the same time when a new
+ * mtp008 client is allocated.
+ */
+struct mtp008_data {
+	struct i2c_client client;
+	int sysctl_id;
+	enum chips type;
+
+	struct semaphore update_lock;
+	char valid;				/* !=0 if fields are valid */
+	unsigned long last_updated;		/* In jiffies */
+
+	u8 in[7];				/* Register value */
+	u8 in_max[7];				/* Register value */
+	u8 in_min[7];				/* Register value */
+	u8 temp;				/* Register value */
+	u8 temp_max;				/* Register value */
+	u8 temp_max_hyst;				/* Register value */
+	u8 fan[3];				/* Register value */
+	u8 fan_min[3];				/* Register value */
+	u8 vid;					/* Register encoding */
+	u8 fan_div[3];				/* Register encoding */
+	u16 alarms;				/* Register encoding */
+	u16 beeps;				/* Register encoding */
+	u8 pwm[4];				/* Register value */
+	u8 sens[3];				/* 1 = Analog input,
+						   2 = Thermistor,
+						   3 = PII/Celeron diode */
+	u8 pwmenable;				/* Register 0x57 value */
+};
+
+static int mtp008_attach_adapter(struct i2c_adapter *adapter);
+static int mtp008_detect(struct i2c_adapter *adapter, int address,
+			int kind);
+static int mtp008_detach_client(struct i2c_client *client);
+
+static int mtp008_read_value(struct i2c_client *client, u8 register);
+static int mtp008_write_value(struct i2c_client *client, u8 register, u8 value);
+static void mtp008_init_client(struct i2c_client *client);
+static struct mtp008_data *mtp008_update_device(struct device *dev);
+
+static void mtp008_getsensortype(struct mtp008_data *data, u8 inp);
+
+static struct i2c_driver mtp008_driver +{
+	.owner	= THIS_MODULE,
+	.name	= "mtp008",
+	.id	= I2C_DRIVERID_MTP008,
+	.flags	= I2C_DF_NOTIFY,
+	.attach_adapter	= mtp008_attach_adapter,
+	.detach_client	= mtp008_detach_client
+};
+
+
+/* Voltage functions and attributes */
+
+#define IN_FUNCTIONS(index) \
+static ssize_t show_in##index##_min(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	if ((index=4 || index=5) && (data->sens[index-3]!=VOLTAGE))\
+		return sprintf(buf, "0\n"); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[index])); \
+}\
+static ssize_t show_in##index##_max(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	if ((index=4 || index=5) && (data->sens[index-3]!=VOLTAGE))\
+		return sprintf(buf, "0\n"); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[index])); \
+}\
+static ssize_t show_in##index##_input(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	if ((index=4 || index=5) && (data->sens[index-3]!=VOLTAGE))\
+		return sprintf(buf, "0\n"); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[index])); \
+}\
+static ssize_t set_in##index##_min(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct mtp008_data *data = i2c_get_clientdata(client); \
+	long val = simple_strtol(buf, NULL, 10); \
+	if ((index=4 || index=5) && (data->sens[index-3]!=VOLTAGE))\
+		return count; \
+	data->in_min[index] = IN_TO_REG(val); \
+	mtp008_write_value(client, MTP008_REG_IN_MIN(index), data->in_min[index]); \
+	return count; \
+}\
+static ssize_t set_in##index##_max(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct mtp008_data *data = i2c_get_clientdata(client); \
+	long val = simple_strtol(buf, NULL, 10); \
+	if ((index=4 || index=5) && (data->sens[index-3]!=VOLTAGE))\
+		return count; \
+	data->in_max[index] = IN_TO_REG(val); \
+	mtp008_write_value(client, MTP008_REG_IN_MAX(index), data->in_max[index]); \
+	return count; \
+}
+
+IN_FUNCTIONS(0)
+IN_FUNCTIONS(1)
+IN_FUNCTIONS(2)
+IN_FUNCTIONS(3)
+IN_FUNCTIONS(4)
+IN_FUNCTIONS(5)
+IN_FUNCTIONS(6)
+
+static DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in0_min, set_in0_min);
+static DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in0_max, set_in0_max);
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in0_input, NULL);
+static DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in1_min, set_in1_min);
+static DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in1_max, set_in1_max);
+static DEVICE_ATTR(in1_input, S_IRUGO, show_in1_input, NULL);
+static DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in2_min, set_in2_min);
+static DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in2_max, set_in2_max);
+static DEVICE_ATTR(in2_input, S_IRUGO, show_in2_input, NULL);
+static DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in3_min, set_in3_min);
+static DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in3_max, set_in3_max);
+static DEVICE_ATTR(in3_input, S_IRUGO, show_in3_input, NULL);
+static DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in4_min, set_in4_min);
+static DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in4_max, set_in4_max);
+static DEVICE_ATTR(in4_input, S_IRUGO, show_in4_input, NULL);
+static DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in5_min, set_in5_min);
+static DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in5_max, set_in5_max);
+static DEVICE_ATTR(in5_input, S_IRUGO, show_in5_input, NULL);
+static DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in6_min, set_in6_min);
+static DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in6_max, set_in6_max);
+static DEVICE_ATTR(in6_input, S_IRUGO, show_in6_input, NULL);
+
+
+/* Fan functions and attributes */
+
+#define FAN_FUNCTIONS(index) \
+static ssize_t show_fan##index##_input(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[index-1], \
+		       DIV_FROM_REG(data->fan_div[index-1]))); \
+}\
+static ssize_t show_fan##index##_min(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[index-1], \
+		       DIV_FROM_REG(data->fan_div[index-1]))); \
+}\
+static ssize_t set_fan##index##_min(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct mtp008_data *data = i2c_get_clientdata(client); \
+	long val = simple_strtoul(buf, NULL, 10); \
+	data->fan_min[index-1] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[index-1])); \
+	mtp008_write_value(client, MTP008_REG_FAN_MIN(index), data->fan_min[index-1]); \
+	return count; \
+}\
+static ssize_t show_fan##index##_div(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[index-1])); \
+}
+
+FAN_FUNCTIONS(1)
+FAN_FUNCTIONS(2)
+FAN_FUNCTIONS(3)
+
+static ssize_t set_fan1_div(struct device *dev, const char *buf,
+	size_t count) 
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+	u8 tmp = mtp008_read_value(client, MTP008_REG_VID_FANDIV);
+	
+	data->fan_div[0] = DIV_TO_REG(val);
+	tmp = (tmp & 0xcf) | (data->fan_div[0] & 0x03) << 4;
+	mtp008_write_value(client, MTP008_REG_VID_FANDIV, tmp);
+	return count;
+}
+
+static ssize_t set_fan2_div(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+	u8 tmp = mtp008_read_value(client, MTP008_REG_VID_FANDIV);
+	
+	data->fan_div[1] = DIV_TO_REG(val);
+	tmp = (tmp & 0x3f) | (data->fan_div[1] & 0x03) << 6;
+	mtp008_write_value(client, MTP008_REG_VID_FANDIV, tmp);
+	return count;
+}
+
+static ssize_t set_fan3_div(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+	u8 tmp = mtp008_read_value(client, MTP008_REG_PIN_CTRL1);
+	
+	data->fan_div[2] = DIV_TO_REG(val);
+	tmp = (tmp & 0x3f) | (data->fan_div[2] & 0x03) << 6;
+	mtp008_write_value(client, MTP008_REG_PIN_CTRL1, tmp);
+	return count;
+}
+
+static DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan1_min, set_fan1_min);
+static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, show_fan1_div, set_fan1_div);
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan1_input, NULL);
+static DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan2_min, set_fan2_min);
+static DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO, show_fan2_div, set_fan2_div);
+static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan2_input, NULL);
+static DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan3_min, set_fan3_min);
+static DEVICE_ATTR(fan3_div, S_IWUSR | S_IRUGO, show_fan3_div, set_fan3_div);
+static DEVICE_ATTR(fan3_input, S_IRUGO, show_fan3_input, NULL);
+
+
+/* Temperature functions and attributes */
+
+/*
+ * These are open-coded because temperature sensors 2 and 3 read from wildly
+ * different registers; they may not even be available, depending on the 
+ * configuration
+ */
+
+static ssize_t show_temp1_max_hyst(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max_hyst));
+}
+static ssize_t show_temp1_max(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max));
+}
+static ssize_t show_temp1_input(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
+}
+static ssize_t set_temp1_max_hyst(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	data->temp_max_hyst = TEMP_TO_REG(val);
+	mtp008_write_value(client, MTP008_REG_TEMP_MAX_HYST, data->temp_max_hyst);
+	return count;
+}
+static ssize_t set_temp1_max(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	data->temp_max = TEMP_TO_REG(val);
+	mtp008_write_value(client, MTP008_REG_TEMP_MAX, data->temp_max);
+	return count;
+}
+
+
+static ssize_t show_temp2_max_hyst(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	if (data->sens[1]=VOLTAGE)
+		return sprintf(buf, "0\n");
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->in_min[4]));
+}
+static ssize_t show_temp2_max(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	if (data->sens[1]=VOLTAGE)
+		return sprintf(buf, "0\n");
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->in_max[4]));
+}
+static ssize_t show_temp2_input(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	if (data->sens[1]=VOLTAGE)
+		return sprintf(buf, "0\n");
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->in[4]));
+}
+static ssize_t set_temp2_max_hyst(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	if (data->sens[1]=VOLTAGE) return count;
+	data->in_min[4] = TEMP_TO_REG(val);
+	mtp008_write_value(client, MTP008_REG_IN_MIN(4), data->in_min[4]);
+	return count;
+}
+static ssize_t set_temp2_max(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	if (data->sens[1]=VOLTAGE) return count;
+	data->in_max[4] = TEMP_TO_REG(val);
+	mtp008_write_value(client, MTP008_REG_IN_MAX(4), data->in_max[4]);
+	return count;
+}
+
+
+static ssize_t show_temp3_max_hyst(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	if (data->sens[2]=VOLTAGE)
+		return sprintf(buf, "0\n");
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->in_min[5]));
+}
+static ssize_t show_temp3_max(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	if (data->sens[2]=VOLTAGE)
+		return sprintf(buf, "0\n");
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->in_max[5]));
+}
+static ssize_t show_temp3_input(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	if (data->sens[2]=VOLTAGE)
+		return sprintf(buf, "0\n");
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->in[5]));
+}
+static ssize_t set_temp3_max_hyst(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	if (data->sens[2]=VOLTAGE) return count;
+	data->in_min[5] = TEMP_TO_REG(val);
+	mtp008_write_value(client, MTP008_REG_IN_MIN(5), data->in_min[5]);
+	return count;
+}
+static ssize_t set_temp3_max(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	if (data->sens[2]=VOLTAGE) return count;
+	data->in_max[5] = TEMP_TO_REG(val);
+	mtp008_write_value(client, MTP008_REG_IN_MAX(5), data->in_max[5]);
+	return count;
+}
+
+static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp1_max_hyst, set_temp1_max_hyst);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp1_max, set_temp1_max);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1_input, NULL);
+static DEVICE_ATTR(temp2_max_hyst, S_IWUSR | S_IRUGO, show_temp2_max_hyst, set_temp2_max_hyst);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp2_max, set_temp2_max);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp2_input, NULL);
+static DEVICE_ATTR(temp3_max_hyst, S_IWUSR | S_IRUGO, show_temp3_max_hyst, set_temp3_max_hyst);
+static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp3_max, set_temp3_max);
+static DEVICE_ATTR(temp3_input, S_IRUGO, show_temp3_input, NULL);
+
+
+static ssize_t show_vid_input(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
+}
+static DEVICE_ATTR(vid_input, S_IRUGO, show_vid_input, NULL);
+
+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+static ssize_t show_beeps(struct device *dev, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", BEEPS_FROM_REG(data->beeps));
+}
+static ssize_t set_beeps(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	data->beeps = BEEPS_TO_REG(val) & 0xdf8f;
+	mtp008_write_value(client, MTP008_REG_BEEP_CTRL1,
+		data->beeps & 0xff);
+	mtp008_write_value(client, MTP008_REG_BEEP_CTRL2,
+		data->beeps >> 8);
+	return count;
+}
+static DEVICE_ATTR(beeps, S_IWUSR | S_IRUGO, show_beeps, set_beeps);
+
+
+/* pwm control functions */
+
+#define PWM_FUNCTIONS(index) \
+static ssize_t show_pwm##index(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[index-1])); \
+}\
+static ssize_t show_pwmenable##index(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	return sprintf(buf, "%d\n", PWMENABLE_FROM_REG(index, data->pwmenable)); \
+}\
+static ssize_t set_pwm##index(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct mtp008_data *data = i2c_get_clientdata(client); \
+	long val = simple_strtoul(buf, NULL, 10); \
+	data->pwm[index-1] = PWM_TO_REG(val); \
+	mtp008_write_value(client, MTP008_REG_PWM_CTRL(index-1), data->fan_min[index-1]); \
+	return count; \
+}\
+static ssize_t set_pwmenable##index(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct mtp008_data *data = i2c_get_clientdata(client); \
+	long val = simple_strtoul(buf, NULL, 10); \
+	if (val) data->pwmenable |= 0x10 << (index-1); \
+	else data->pwmenable &= ~(0x10 << (index-1)); \
+	data->pwm[index-1] = PWM_TO_REG(val); \
+	mtp008_write_value(client, MTP008_REG_PIN_CTRL2, \
+		data->pwmenable); \
+	return count; \
+}\
+
+PWM_FUNCTIONS(1)
+PWM_FUNCTIONS(2)
+PWM_FUNCTIONS(3)
+
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1);
+static DEVICE_ATTR(pwmenable1, S_IWUSR | S_IRUGO, show_pwmenable1, set_pwmenable1);
+static DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm2, set_pwm2);
+static DEVICE_ATTR(pwmenable2, S_IWUSR | S_IRUGO, show_pwmenable2, set_pwmenable2);
+static DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm3, set_pwm3);
+static DEVICE_ATTR(pwmenable3, S_IWUSR | S_IRUGO, show_pwmenable3, set_pwmenable3);
+
+/* sensor configuration */
+
+#define SENSOR_FUNCTIONS(index) \
+static ssize_t show_sensor##index(struct device *dev, char *buf) \
+{ \
+	struct mtp008_data *data = mtp008_update_device(dev); \
+	return sprintf(buf, "%d\n", data->sens[index-1]); \
+}
+
+SENSOR_FUNCTIONS(1)
+SENSOR_FUNCTIONS(2)
+SENSOR_FUNCTIONS(3)
+
+static ssize_t set_sensor1(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+	u8 tmp = mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
+	
+	switch(val) {
+		case THERMISTOR: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp & ~MTP008_CFG_VT1_PII);
+			data->sens[0]=2;
+			return count;
+		}
+		case PIIDIODE: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp | MTP008_CFG_VT1_PII);
+			data->sens[0]=3;
+			return count;
+		}
+		default:
+			return -EINVAL;
+	}
+}
+
+static ssize_t set_sensor2(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+	u8 tmp = mtp008_read_value(client, MTP008_REG_PIN_CTRL2)
+		& ~MTP008_CFG_VT2_MASK;
+	
+	switch(val) {
+		case VOLTAGE: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp | MTP008_CFG_VT2_AIN);
+			data->sens[1]=1;
+		}
+		case THERMISTOR: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp | MTP008_CFG_VT2_VT);
+			data->sens[1]=2;
+			return count;
+		}
+		case PIIDIODE: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp | MTP008_CFG_VT2_PII);
+			data->sens[1]=3;
+			return count;
+		}
+		default:
+			return -EINVAL;
+	}
+}
+
+static ssize_t set_sensor3(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+	u8 tmp = mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
+	
+	switch(val) {
+		case VOLTAGE: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp & ~MTP008_CFG_VT3_VT);
+			data->sens[2]=1;
+			return count;
+		}
+		case THERMISTOR: {
+			mtp008_write_value(client, MTP008_REG_PIN_CTRL2,
+				tmp | ~MTP008_CFG_VT3_VT);
+			data->sens[2]=2;
+			return count;
+		}
+		default:
+			return -EINVAL;
+	}
+}
+
+static DEVICE_ATTR(sensor1, S_IWUSR | S_IRUGO, show_sensor1, set_sensor1);
+static DEVICE_ATTR(sensor2, S_IWUSR | S_IRUGO, show_sensor2, set_sensor2);
+static DEVICE_ATTR(sensor3, S_IWUSR | S_IRUGO, show_sensor3, set_sensor3);
+
+static int mtp008_id=0;
+
+/* This function is called when:
+ * mtp008_driver is inserted (when this module is loaded), for each available
+ * adapter when a new adapter is inserted (and mtp008_driver is still present)
+ */
+static int mtp008_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, mtp008_detect);
+}
+
+int mtp008_detect(struct i2c_adapter *adapter, int address,
+		  int kind)
+{
+	const char *name;
+	int err;
+	struct i2c_client *new_client;
+	struct mtp008_data *data;
+	
+	err = 0;
+	
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
+	
+	/*
+	 * We presume we have a valid client.  We now create the client
+	 * structure, even though we cannot fill it completely yet.  But it
+	 * allows us to use mtp008_(read|write)_value().
+	 */
+	data = kmalloc(sizeof(struct mtp008_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+	
+	memset(data, 0, sizeof(struct mtp008_data));
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &mtp008_driver;
+	new_client->flags = 0;
+	
+	if (kind < 0)
+		if (mtp008_read_value(new_client, MTP008_REG_CHIPID) != 0xac)
+			goto ERROR1;
+	
+	/*
+	 * Fill in the remaining client fields and put it into the global list.
+	 */
+	name = "mtp008";
+	kind = mtp008;
+	data->type = kind;	/* hm, it's unused methinks... */
+	
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	
+	new_client->id = mtp008_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+	
+	/*
+	 * Tell the I2C layer that a new client has arrived.
+	 */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR1;
+	
+	/*
+	 * Initialize the MTP008 chip.
+	 */
+	mtp008_init_client(new_client);
+	
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in5_min);
+	device_create_file(&new_client->dev, &dev_attr_in5_max);
+	device_create_file(&new_client->dev, &dev_attr_in5_input);
+	device_create_file(&new_client->dev, &dev_attr_in6_min);
+	device_create_file(&new_client->dev, &dev_attr_in6_max);
+	device_create_file(&new_client->dev, &dev_attr_in6_input);
+	
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan3_min);
+	device_create_file(&new_client->dev, &dev_attr_fan3_div);
+	device_create_file(&new_client->dev, &dev_attr_fan3_input);
+	
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp3_input);
+	
+	device_create_file(&new_client->dev, &dev_attr_vid_input);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_beeps);
+	
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
+	device_create_file(&new_client->dev, &dev_attr_pwmenable1);
+	device_create_file(&new_client->dev, &dev_attr_pwm2);
+	device_create_file(&new_client->dev, &dev_attr_pwmenable2);
+	device_create_file(&new_client->dev, &dev_attr_pwm3);
+	device_create_file(&new_client->dev, &dev_attr_pwmenable3);
+	device_create_file(&new_client->dev, &dev_attr_sensor1);
+	device_create_file(&new_client->dev, &dev_attr_sensor2);
+	device_create_file(&new_client->dev, &dev_attr_sensor3);
+	
+	return 0;
+	
+ERROR1:
+	kfree(data);
+	
+ERROR0:
+	return err;
+}
+
+static int mtp008_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+		       "client not detached.\n");
+		return err;
+	}
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static int mtp008_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg) & 0xff;
+}
+
+static int mtp008_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+/* Called when we have found a new MTP008. It should set limits, etc. */
+static void mtp008_init_client(struct i2c_client *client)
+{
+	u8 save1, save2;
+	struct mtp008_data *data;
+
+	data = i2c_get_clientdata(client);
+
+	/*
+	 * Initialize the Myson MTP008 hardware monitoring chip.
+	 * Save the pin settings that the BIOS hopefully set.
+	 */
+	save1 = mtp008_read_value(client, MTP008_REG_PIN_CTRL1);
+	save2 = mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
+	mtp008_write_value(client, MTP008_REG_CONFIG,
+	     (mtp008_read_value(client, MTP008_REG_CONFIG) & 0x7f) | 0x80);
+	mtp008_write_value(client, MTP008_REG_PIN_CTRL1, save1);
+	mtp008_write_value(client, MTP008_REG_PIN_CTRL2, save2);
+
+	mtp008_getsensortype(data, save2);
+
+
+	/*
+	 * Start monitoring.
+	 */
+	mtp008_write_value(
+		client, MTP008_REG_CONFIG,
+		(mtp008_read_value(client, MTP008_REG_CONFIG) & 0xf7) | 0x01
+	);
+}
+
+static struct mtp008_data *mtp008_update_device(struct device *dev)
+{
+	int i;
+	u8 inp;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+		/*
+		 * Read in the analog inputs.  We're reading AIN4 and AIN5 as
+		 * regular analog inputs, even though they may have been
+		 * configured as temperature readings instead.  Interpretation
+		 * of these values is done elsewhere.
+		 */
+		for (i = 0; i < 7; i++) {
+			data->in[i] +				mtp008_read_value(client, MTP008_REG_IN(i));
+			data->in_max[i] +				mtp008_read_value(client, MTP008_REG_IN_MAX(i));
+			data->in_min[i] +				mtp008_read_value(client, MTP008_REG_IN_MIN(i));
+		}
+
+		/*
+		 * Read the temperature sensor.
+		 */
+		data->temp = mtp008_read_value(client, MTP008_REG_TEMP);
+		data->temp_max = mtp008_read_value(client, MTP008_REG_TEMP_MAX);
+		data->temp_max_hyst = mtp008_read_value(client, MTP008_REG_TEMP_MAX_HYST);
+
+		/*
+		 * Read the first 2 fan dividers and the VID setting.  Read the
+		 * third fan divider from a different register.
+		 */
+		inp = mtp008_read_value(client, MTP008_REG_VID_FANDIV);
+		data->vid = inp & 0x0f;
+		data->vid |= (mtp008_read_value(client,
+				     MTP008_REG_RESET_VID4) & 0x01) << 4;
+
+		data->fan_div[0] = (inp >> 4) & 0x03;
+		data->fan_div[1] = inp >> 6;
+		data->fan_div[2] +			mtp008_read_value(client, MTP008_REG_PIN_CTRL1) >> 6;
+
+		/*
+		 * Read the interrupt status registers.
+		 */
+		data->alarms +			(mtp008_read_value(client,
+					   MTP008_REG_INT_STAT1) & 0xdf) |
+			(mtp008_read_value(client,
+					   MTP008_REG_INT_STAT2) & 0x0f) << 8;
+
+		/*
+		 * Read the beep control registers.
+		 */
+		data->beeps +			(mtp008_read_value(client,
+					   MTP008_REG_BEEP_CTRL1) & 0xdf) |
+			(mtp008_read_value(client,
+					   MTP008_REG_BEEP_CTRL2) & 0x8f) << 8;
+
+		/*
+		 * Read the sensor configuration.
+		 */
+		inp = mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
+		mtp008_getsensortype(data, inp);
+		data->pwmenable = inp;
+
+		/*
+		 * Read the PWM registers if enabled.
+		 */
+		for (i = 1; i <= 3; i++)
+		{
+			if(PWMENABLE_FROM_REG(i, inp))
+				data->pwm[i-1] = mtp008_read_value(client,
+						  MTP008_REG_PWM_CTRL(i));
+			else
+				data->pwm[i-1] = 255;
+		}
+
+		/*
+		 * Read the fan sensors. Skip 3 if PWM1 enabled.
+		 */
+		for (i = 1; i <= 3; i++) {
+			if(i = 3 && PWMENABLE_FROM_REG(1, inp)) {
+				data->fan[2] = 0;
+				data->fan_min[2] = 0;
+			} else {
+				data->fan[i-1] = mtp008_read_value(client,
+					  MTP008_REG_FAN(i));
+				data->fan_min[i-1] = mtp008_read_value(client,
+					  MTP008_REG_FAN_MIN(i));
+			}
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	up(&data->update_lock);
+	
+	return data;
+}
+
+static void mtp008_getsensortype(struct mtp008_data *data, u8 inp)
+{
+	inp &= 0x0f;
+	data->sens[0] = (inp >> 3) + 2;			/* 2 or 3 */
+	data->sens[1] = ((inp >> 1) & 0x03) + 1;	/* 1, 2 or 3 */
+	data->sens[2] = (inp & 0x01) + 1;		/* 1 or 2 */
+}
+
+static int __init mtp008_init(void)
+{
+	return i2c_add_driver(&mtp008_driver);
+}
+
+static void __exit mtp008_exit(void)
+{
+	i2c_del_driver(&mtp008_driver);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+	      "Philip Edelbrock <phil@netroedge.com>, "
+	      "Kris Van Hees <aedil@alchar.org> "
+		  "and Helge Bahmann <hcb@chaoticmind.net>");
+MODULE_DESCRIPTION("MTP008 driver");
+
+module_init(mtp008_init);
+module_exit(mtp008_exit);
