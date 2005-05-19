From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040128231658.0aef4454.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Yes, I did follow the guidelines as well as the sysfs-interface, but
> since its my first kernel module attempt, it might need improvement.

OK, I reviewed your code and you have done a great job. I can hardly
believe that this is your first contact with kernel code.

I have adjusted a few things in your original port. If we left apart
uninteresting things such as white space changes, indentation and the
such (which BTW weren't bad at all), here is a list of changes:

* Add standard debug stuff. This is something I need to add to the
porting-clients doc.

* Reorder includes.

* No function declaration for swap_bytes();

* Switch from gl518_list to gl518_id. This makes the driver more in line
with the others I've seen so far. The other method looks like something
leftover from older times. I think that this change could be backported
to the 2.4 driver as well, since new code is more simple and doesn't
imply any arbitrary limit to the number of chips supported. However, I'd
like you to confirm that the new code works.

* Looks like you forgot to create the sysfs file "beep_mask". I added
the required line. Please correct me if I'm mistaking.

* Remove one use of DEBUG_VIN, which seems to be bogus. It makes non-00
revision chips use revision 00 code if DEBUG_VIN is set. This doesn't
match the description of DEBUG_VIN, so I took the liberty to clear it.

Attached is a patch against Linux 2.6.2-rc2 which adds the new driver
and integrates it cleanly into the kernel tree. I'd like you to make
sure it works correctly for you before we add it to the official tree.

For reference, can you tell us wether your test system uses release 0x00
or 0x80 of the gl518sm? If 0x00, please try with DEBUG turned on too, to
make sure it still works.

Greg, I've reviewed the code and it looks good, however I'm not familiar
with threads, neither in Linux 2.4 nor in 2.6. Could you review that
part of the code (bottom of the file) and confirm that it's correct for
inclusion into Linux 2.6? The easier way to check is probably to read a
diff between the driver as it exists in our CVS repository and the
attached ported driver. One thing that looks strange to me is the
suppression of this line:
current->pgrp =3D 1;
This is in gl518_update_thread(). Might be correct however, I just don't
know bit about threads so I am wondering if it's correct to remove the
line. This is the first chip driver I see that deals with threads, so I
really need assistance in reviewing it.

Also, Greg, can you tell me wether my "inclusion" of DEBUG_VIN into
DEBUG is correct or not? (that's at the top of the new driver.)

After tests and code review are completed, we will have a new chip
driver ported to Linux 2.6. Yeah! :)

Thanks.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
diff -ruN linux-2.6.2-rc2/drivers/i2c/chips/Kconfig linux-2.6.2-rc2-k1/driv=
ers/i2c/chips/Kconfig
--- linux-2.6.2-rc2/drivers/i2c/chips/Kconfig	Tue Jan 27 19:22:59 2004
+++ linux-2.6.2-rc2-k1/drivers/i2c/chips/Kconfig	Wed Jan 28 21:48:20 2004
@@ -45,6 +45,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
=20
+config SENSORS_GL518SM
+	tristate "Genesys Logic GL518SM"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Genesys Logic GL518SM
+	  sensor chips (releases 0x00 and 0x80).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called gl518sm.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on I2C && EXPERIMENTAL
diff -ruN linux-2.6.2-rc2/drivers/i2c/chips/Makefile linux-2.6.2-rc2-k1/dri=
vers/i2c/chips/Makefile
--- linux-2.6.2-rc2/drivers/i2c/chips/Makefile	Tue Jan 27 19:22:59 2004
+++ linux-2.6.2-rc2-k1/drivers/i2c/chips/Makefile	Wed Jan 28 21:48:20 2004
@@ -8,6 +8,7 @@
=20
 obj-$(CONFIG_SENSORS_ADM1021)	+=3D adm1021.o
 obj-$(CONFIG_SENSORS_EEPROM)	+=3D eeprom.o
+obj-$(CONFIG_SENSORS_GL518SM)	+=3D gl518sm.o
 obj-$(CONFIG_SENSORS_IT87)	+=3D it87.o
 obj-$(CONFIG_SENSORS_LM75)	+=3D lm75.o
 obj-$(CONFIG_SENSORS_LM78)	+=3D lm78.o
diff -ruN linux-2.6.2-rc2/drivers/i2c/chips/gl518sm.c linux-2.6.2-rc2-k1/dr=
ivers/i2c/chips/gl518sm.c
--- linux-2.6.2-rc2/drivers/i2c/chips/gl518sm.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6.2-rc2-k1/drivers/i2c/chips/gl518sm.c	Wed Jan 28 22:38:26 2004
@@ -0,0 +1,840 @@
+/*
+ * gl518sm.c - Part of lm_sensors, Linux kernel modules for hardware
+ *             monitoring
+ * Copyright (C) 1998, 1999	Frodo Looijaard	<frodol@dds.nl>,
+ * 				Kyosti Malkki	<kmalkki@cc.hut.fi>
+ * port to 2.6 Kernel
+ * Copyright (C) 2004		Hong-Gunn Chew	<hglinux@gunnet.org>
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
+ */
+
+/*
+ * v2.0 (2004-01-24, Hong-Gunn Chew)
+ *	- ported to 2.6 kernel
+ * v2.1 (2004-01-28, Hong-Gunn Chew)
+ *	- Updated sysfs output according to standard data format
+ *	  (temp, in)
+ */
+
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#ifdef __SMP__
+#include <linux/smp_lock.h>
+#endif
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] =3D { I2C_CLIENT_END };
+static unsigned int normal_isa[] =3D { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] =3D { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_2(gl518sm_r00, gl518sm_r80);
+
+/* Defining this will enable debug messages for the voltage iteration
+   code used with rev 0 ICs */
+#undef DEBUG_VIN
+#ifdef DEBUG
+#define DEBUG_VIN
+#endif
+
+/* Many GL518 constants specified below */
+
+/* The GL518 registers */
+#define GL518_REG_CHIP_ID	0x00
+#define GL518_REG_REVISION	0x01
+#define GL518_REG_VENDOR_ID	0x02
+#define GL518_REG_CONF		0x03
+#define GL518_REG_TEMP_IN	0x04
+#define GL518_REG_TEMP_MAX	0x05
+#define GL518_REG_TEMP_HYST	0x06
+#define GL518_REG_FAN_COUNT	0x07
+#define GL518_REG_FAN_LIMIT	0x08
+#define GL518_REG_VIN1_LIMIT	0x09
+#define GL518_REG_VIN2_LIMIT	0x0a
+#define GL518_REG_VIN3_LIMIT	0x0b
+#define GL518_REG_VDD_LIMIT	0x0c
+#define GL518_REG_VIN3		0x0d
+#define GL518_REG_MISC		0x0f
+#define GL518_REG_ALARM		0x10
+#define GL518_REG_MASK		0x11
+#define GL518_REG_INT		0x12
+#define GL518_REG_VIN2		0x13
+#define GL518_REG_VIN1		0x14
+#define GL518_REG_VDD		0x15
+
+
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
+ * Fixing this is just not worth it.
+ */
+
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT(((((val)<0? \
+				(val)-500:(val)+500)/1000)+119),0,255))
+#define TEMP_FROM_REG(val)	(((val) - 119) * 1000)
+
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm =3D 0)
+		return 255;
+	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);
+	return SENSORS_LIMIT((960000 + rpm * div / 2) / (rpm * div), 1, 254);
+}
+
+#define FAN_FROM_REG(val,div)	((val)=3D0 ? 0 : (val)=3D255 ? 0 : \
+				(960000/((val)*(div))))
+
+#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)+8)/19),0,255))
+#define IN_FROM_REG(val)	((val)*19)
+
+#define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)+11)/23),0,255))
+#define VDD_FROM_REG(val)	((val)*23)
+
+#define DIV_TO_REG(val)		((val)=3D8?3:(val)=3D4?2:(val)=3D1?0:1)
+#define DIV_FROM_REG(val)	(1 << (val))
+
+#define ALARMS_FROM_REG(val)	val
+
+#define BEEP_ENABLE_TO_REG(val)		((val)?0:1)
+#define BEEP_ENABLE_FROM_REG(val)	((val)?0:1)
+
+#define BEEP_MASK_TO_REG(val)		((val) & 0x7f & data->alarm_mask)
+#define BEEP_MASK_FROM_REG(val)		((val) & 0x7f)
+
+/* Each client has this additional data */
+struct gl518_data {
+	enum chips type;
+
+	struct semaphore update_lock;
+
+	int iterate_lock;
+	int quit_thread;
+	struct task_struct *thread;
+	wait_queue_head_t wq;
+	char valid;		/* !=3D0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+	unsigned long last_updated_v00;
+	/* In jiffies (used only by rev00 chips) */
+
+	u8 voltage_in[4];	/* Register values; [0] =3D VDD */
+	u8 voltage_min[4];	/* Register values; [0] =3D VDD */
+	u8 voltage_max[4];	/* Register values; [0] =3D VDD */
+	u8 iter_voltage_in[4];	/* Register values; [0] =3D VDD */
+	u8 fan_in[2];
+	u8 fan_min[2];
+	u8 fan_div[2];		/* Register encoding, shifted right */
+	u8 temp_in;		/* Register values */
+	u8 temp_max;		/* Register values */
+	u8 temp_hyst;		/* Register values */
+	u8 alarms;		/* Register value */
+	u8 alarm_mask;		/* Register value */
+	u8 beep_mask;		/* Register value */
+	u8 beep_enable;		/* Boolean */
+	u8 iterate;		/* Voltage iteration mode */
+};
+
+static int gl518_attach_adapter(struct i2c_adapter *adapter);
+static int gl518_detect(struct i2c_adapter *adapter, int address, int kind=
);
+static void gl518_init_client(struct i2c_client *client);
+static int gl518_detach_client(struct i2c_client *client);
+
+static int gl518_read_value(struct i2c_client *client, u8 reg);
+static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value);
+
+static void gl518_update_client(struct i2c_client *client);
+static void gl518_update_client_rev00(struct i2c_client *client);
+static void gl518_update_iterate(struct i2c_client *client);
+static int gl518_update_thread(void *c);
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver gl518_driver =3D {
+	.owner		=3D THIS_MODULE,
+	.name		=3D "gl518sm",
+	.id		=3D I2C_DRIVERID_GL518,
+	.flags		=3D I2C_DF_NOTIFY,
+	.attach_adapter	=3D gl518_attach_adapter,
+	.detach_client	=3D gl518_detach_client,
+};
+
+/*
+ * Internal variables
+ */
+
+static int gl518_id =3D 0;
+
+
+/*
+ * Sysfs stuff
+ */
+
+#define show(type, suffix, value)					\
+static ssize_t show_##suffix(struct device *dev, char *buf)		\
+{									\
+	struct i2c_client *client =3D to_i2c_client(dev);			\
+	struct gl518_data *data =3D i2c_get_clientdata(client);		\
+	gl518_update_client(client);					\
+	return sprintf(buf, "%d\n", type##_FROM_REG(data->value));	\
+}
+
+#define show_fan(suffix, value, index)					\
+static ssize_t show_##suffix(struct device *dev, char *buf)		\
+{									\
+	struct i2c_client *client =3D to_i2c_client(dev);			\
+	struct gl518_data *data =3D i2c_get_clientdata(client);		\
+	gl518_update_client(client);					\
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[index],	\
+		DIV_FROM_REG(data->fan_div[index])));			\
+}
+
+show(TEMP, temp_input, temp_in);
+show(TEMP, temp_max, temp_max);
+show(TEMP, temp_hyst, temp_hyst);
+show_fan(fan_input1, fan_in, 0);
+show_fan(fan_input2, fan_in, 1);
+show_fan(fan_min1, fan_min, 0);
+show_fan(fan_min2, fan_min, 1);
+show(DIV, fan_div1, fan_div[0]);
+show(DIV, fan_div2, fan_div[1]);
+show(VDD, in_input1, voltage_in[0]);
+show(IN, in_input2, voltage_in[1]);
+show(IN, in_input3, voltage_in[2]);
+show(IN, in_input4, voltage_in[3]);
+show(VDD, in_min1, voltage_min[0]);
+show(IN, in_min2, voltage_min[1]);
+show(IN, in_min3, voltage_min[2]);
+show(IN, in_min4, voltage_min[3]);
+show(VDD, in_max1, voltage_max[0]);
+show(IN, in_max2, voltage_max[1]);
+show(IN, in_max3, voltage_max[2]);
+show(IN, in_max4, voltage_max[3]);
+show(ALARMS, alarms, alarms);
+show(BEEP_ENABLE, beep_enable, beep_enable);
+show(BEEP_MASK, beep_mask, beep_mask);
+
+static ssize_t show_iterate(struct device *dev, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	return sprintf(buf, "%d\n", data->iterate);
+}
+
+#define set(type, suffix, value, reg)					\
+static ssize_t set_##suffix(struct device *dev, const char *buf,	\
+	size_t count)							\
+{									\
+	struct i2c_client *client =3D to_i2c_client(dev);			\
+	struct gl518_data *data =3D i2c_get_clientdata(client);		\
+	data->value =3D type##_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	gl518_write_value(client, reg, data->value);			\
+	return count;							\
+}
+
+#define set_bits(type, suffix, value, reg, mask, shift)			\
+static ssize_t set_##suffix(struct device *dev, const char *buf,	\
+	size_t count)							\
+{									\
+	struct i2c_client *client =3D to_i2c_client(dev);			\
+	struct gl518_data *data =3D i2c_get_clientdata(client);		\
+	int regvalue =3D gl518_read_value(client, reg);			\
+	data->value =3D type##_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	regvalue =3D (regvalue & mask) | (data->value << shift);		\
+	gl518_write_value(client, reg, regvalue);			\
+	return count;							\
+}
+#define set_low(type, suffix, value, reg)				\
+	set_bits(type, suffix, value, reg, 0xff00, 0)
+#define set_high(type, suffix, value, reg)				\
+	set_bits(type, suffix, value, reg, 0x00ff, 8)
+
+set(TEMP, temp_max, temp_max, GL518_REG_TEMP_MAX);
+set(TEMP, temp_hyst, temp_hyst, GL518_REG_TEMP_HYST);
+set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0x3f, 4);
+set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0xcf, 6);
+set_low(VDD, in_min1, voltage_min[0], GL518_REG_VDD_LIMIT);
+set_low(IN, in_min2, voltage_min[1], GL518_REG_VIN1_LIMIT);
+set_low(IN, in_min3, voltage_min[2], GL518_REG_VIN2_LIMIT);
+set_low(IN, in_min4, voltage_min[3], GL518_REG_VIN3_LIMIT);
+set_high(VDD, in_max1, voltage_max[0], GL518_REG_VDD_LIMIT);
+set_high(IN, in_max2, voltage_max[1], GL518_REG_VIN1_LIMIT);
+set_high(IN, in_max3, voltage_max[2], GL518_REG_VIN2_LIMIT);
+set_high(IN, in_max4, voltage_max[3], GL518_REG_VIN3_LIMIT);
+set_bits(BEEP_ENABLE, beep_enable, beep_enable, GL518_REG_CONF, 0xfb, 2);
+set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
+
+static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t co=
unt)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	int regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+
+	data->fan_min[0] =3D FAN_TO_REG(simple_strtoul(buf, NULL, 10),
+		DIV_FROM_REG(data->fan_div[0]));
+	regvalue =3D (regvalue & 0xff00) | data->fan_min[0];
+	if (data->fan_min[0] =3D 0)
+		data->alarm_mask &=3D ~0x0020;
+	else
+		data->alarm_mask |=3D 0x0020;
+	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
+
+	return count;
+}
+
+static ssize_t set_fan_min2(struct device *dev, const char *buf, size_t co=
unt)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	int regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+
+	data->fan_min[1] =3D FAN_TO_REG(simple_strtoul(buf, NULL, 10),
+		DIV_FROM_REG(data->fan_div[0]));
+	regvalue =3D (regvalue & 0x00ff) | (data->fan_min[1] << 8);
+	if (data->fan_min[1] =3D 0)
+		data->alarm_mask &=3D ~0x0040;
+	else
+		data->alarm_mask |=3D 0x0040;
+	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
+
+	return count;
+}
+
+static ssize_t set_iterate(struct device *dev, const char *buf, size_t cou=
nt)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+
+	if (data->type =3D gl518sm_r00) {
+		u8 newiterate =3D simple_strtoul(buf, NULL, 10);
+		if ((data->iterate !=3D newiterate) && (newiterate <=3D 2)) {
+			int i;
+
+			data->iterate =3D newiterate;
+			data->valid =3D 0;
+			for (i=3D0; i<4; i++) {
+				data->voltage_in[i] =3D 0;
+				data->iter_voltage_in[i] =3D 0;
+			}
+			if (newiterate !=3D 2) {
+				if  (data->thread) {
+					data->quit_thread =3D 1;
+					wake_up_interruptible(&data->wq);
+				}
+			} else if (!data->thread) {
+				init_waitqueue_head(&data->wq);
+				kernel_thread(gl518_update_thread,
+					(void *) client, 0);
+			}
+		}
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp_max, S_IWUSR|S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_hyst, S_IWUSR|S_IRUGO, show_temp_hyst, set_temp_hy=
st);
+static DEVICE_ATTR(fan_input1, S_IRUGO, show_fan_input1, NULL);
+static DEVICE_ATTR(fan_input2, S_IRUGO, show_fan_input2, NULL);
+static DEVICE_ATTR(fan_min1, S_IWUSR|S_IRUGO, show_fan_min1, set_fan_min1);
+static DEVICE_ATTR(fan_min2, S_IWUSR|S_IRUGO, show_fan_min2, set_fan_min2);
+static DEVICE_ATTR(fan_div1, S_IWUSR|S_IRUGO, show_fan_div1, set_fan_div1);
+static DEVICE_ATTR(fan_div2, S_IWUSR|S_IRUGO, show_fan_div2, set_fan_div2);
+static DEVICE_ATTR(in_input1, S_IRUGO, show_in_input1, NULL);
+static DEVICE_ATTR(in_input2, S_IRUGO, show_in_input2, NULL);
+static DEVICE_ATTR(in_input3, S_IRUGO, show_in_input3, NULL);
+static DEVICE_ATTR(in_input4, S_IRUGO, show_in_input4, NULL);
+static DEVICE_ATTR(in_min1, S_IWUSR|S_IRUGO, show_in_min1, set_in_min1);
+static DEVICE_ATTR(in_min2, S_IWUSR|S_IRUGO, show_in_min2, set_in_min2);
+static DEVICE_ATTR(in_min3, S_IWUSR|S_IRUGO, show_in_min3, set_in_min3);
+static DEVICE_ATTR(in_min4, S_IWUSR|S_IRUGO, show_in_min4, set_in_min4);
+static DEVICE_ATTR(in_max1, S_IWUSR|S_IRUGO, show_in_max1, set_in_max1);
+static DEVICE_ATTR(in_max2, S_IWUSR|S_IRUGO, show_in_max2, set_in_max2);
+static DEVICE_ATTR(in_max3, S_IWUSR|S_IRUGO, show_in_max3, set_in_max3);
+static DEVICE_ATTR(in_max4, S_IWUSR|S_IRUGO, show_in_max4, set_in_max4);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(beep_enable, S_IWUSR|S_IRUGO,
+	show_beep_enable, set_beep_enable);
+static DEVICE_ATTR(beep_mask, S_IWUSR|S_IRUGO,
+	show_beep_mask, set_beep_mask);
+static DEVICE_ATTR(iterate, S_IWUSR|S_IRUGO, show_iterate, set_iterate);
+
+/*
+ * Real code
+ */
+
+static int gl518_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
+	return i2c_detect(adapter, &addr_data, gl518_detect);
+}
+
+static int gl518_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int i;
+	struct i2c_client *new_client;
+	struct gl518_data *data;
+	int err =3D 0;
+	const char *name =3D "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		    goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access gl518_{read,write}_value. */
+
+	if (!(new_client =3D kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct gl518_data),
+				   GFP_KERNEL))) {
+		err =3D -ENOMEM;
+		goto exit;
+	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+		sizeof(struct gl518_data));
+
+	data =3D (struct gl518_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+
+	new_client->addr =3D address;
+	new_client->adapter =3D adapter;
+	new_client->driver =3D &gl518_driver;
+	new_client->flags =3D 0;
+
+	/* Now, we do the remaining detection. */
+
+	if (kind < 0) {
+		if ((gl518_read_value(new_client, GL518_REG_CHIP_ID) !=3D 0x80)
+		 || (gl518_read_value(new_client, GL518_REG_CONF) & 0x80))
+                 	goto exit_free;
+	}
+
+	/* Determine the chip type. */
+	if (kind <=3D 0) {
+		i =3D gl518_read_value(new_client, GL518_REG_REVISION);
+		if (i =3D 0x00) {
+			kind =3D gl518sm_r00;
+			name =3D "gl518sm_r00";
+		} else if (i =3D 0x80) {
+			kind =3D gl518sm_r80;
+			name =3D "gl518sm_r80";
+		} else {
+			if (kind <=3D 0)
+				dev_info(&adapter->dev,
+				    "Ignoring 'force' parameter for unknown "
+				    "chip at adapter %d, address 0x%02x\n",
+				    i2c_adapter_id(adapter), address);
+			goto exit_free;
+		}
+	}
+
+	/* Fill in the remaining client fields */
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	new_client->id =3D gl518_id++;
+	data->type =3D kind;
+	data->valid =3D 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err =3D i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the GL518SM chip */
+	if (kind =3D gl518sm_r00)
+		data->iterate =3D 0;
+	else
+		data->iterate =3D 3;
+	data->iterate_lock =3D 0;
+	data->quit_thread =3D 0;
+	data->thread =3D NULL;
+	data->alarm_mask =3D 0xff;
+	data->voltage_in[0]=DAta->voltage_in[1]=DAta->voltage_in[2]=3D0;
+	gl518_init_client((struct i2c_client *) new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_in_input1);
+	device_create_file(&new_client->dev, &dev_attr_in_input2);
+	device_create_file(&new_client->dev, &dev_attr_in_input3);
+	device_create_file(&new_client->dev, &dev_attr_in_input4);
+	device_create_file(&new_client->dev, &dev_attr_in_min1);
+	device_create_file(&new_client->dev, &dev_attr_in_min2);
+	device_create_file(&new_client->dev, &dev_attr_in_min3);
+	device_create_file(&new_client->dev, &dev_attr_in_min4);
+	device_create_file(&new_client->dev, &dev_attr_in_max1);
+	device_create_file(&new_client->dev, &dev_attr_in_max2);
+	device_create_file(&new_client->dev, &dev_attr_in_max3);
+	device_create_file(&new_client->dev, &dev_attr_in_max4);
+	device_create_file(&new_client->dev, &dev_attr_fan_input1);
+	device_create_file(&new_client->dev, &dev_attr_fan_input2);
+	device_create_file(&new_client->dev, &dev_attr_fan_min1);
+	device_create_file(&new_client->dev, &dev_attr_fan_min2);
+	device_create_file(&new_client->dev, &dev_attr_fan_div1);
+	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input);
+	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_beep_enable);
+	device_create_file(&new_client->dev, &dev_attr_beep_mask);
+	device_create_file(&new_client->dev, &dev_attr_iterate);
+
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+exit_free:
+	kfree(new_client);
+exit:
+	return err;
+}
+
+
+/* Called when we have found a new GL518SM. */
+static void gl518_init_client(struct i2c_client *client)
+{
+	/* Power-on defaults (bit 7=3D1) */
+	gl518_write_value(client, GL518_REG_CONF, 0x80);
+
+	/* No noisy output (bit 2=3D1), Comparator mode (bit 3=3D0), two fans (bi=
t4=3D0),
+	   standby mode (bit6=3D0) */
+	gl518_write_value(client, GL518_REG_CONF, 0x04);
+
+	/* Never interrupts */
+	gl518_write_value(client, GL518_REG_MASK, 0x00);
+
+	/* Clear status register (bit 5=3D1), start (bit6=3D1) */
+	gl518_write_value(client, GL518_REG_CONF, 0x24);
+	gl518_write_value(client, GL518_REG_CONF, 0x44);
+}
+
+static int gl518_detach_client(struct i2c_client *client)
+{
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	int err;
+
+	if ((err =3D i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+
+	if (data->thread) {
+		data->quit_thread =3D 1;
+		wake_up_interruptible(&data->wq);
+	}
+
+	kfree(client);
+
+	return 0;
+}
+
+static inline u16 swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
+}
+
+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized=20
+   GL518 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int gl518_read_value(struct i2c_client *client, u8 reg)
+{
+	if ((reg >=3D 0x07) && (reg <=3D 0x0c))
+		return swap_bytes(i2c_smbus_read_word_data(client, reg));
+	else
+		return i2c_smbus_read_byte_data(client, reg);
+}
+
+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized=20
+   GL518 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if ((reg >=3D 0x07) && (reg <=3D 0x0c))
+		return i2c_smbus_write_word_data(client, reg,
+						 swap_bytes(value));
+	else
+		return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static void gl518_update_client(struct i2c_client *client)
+{
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	int val;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+		dev_dbg(&client->dev, "Starting gl518 update\n");
+
+		data->alarms =3D gl518_read_value(client, GL518_REG_INT);
+		data->beep_mask =3D gl518_read_value(client, GL518_REG_ALARM);
+
+		val =3D gl518_read_value(client, GL518_REG_VDD_LIMIT);
+		data->voltage_min[0] =3D val & 0xff;
+		data->voltage_max[0] =3D (val >> 8) & 0xff;
+		val =3D gl518_read_value(client, GL518_REG_VIN1_LIMIT);
+		data->voltage_min[1] =3D val & 0xff;
+		data->voltage_max[1] =3D (val >> 8) & 0xff;
+		val =3D gl518_read_value(client, GL518_REG_VIN2_LIMIT);
+		data->voltage_min[2] =3D val & 0xff;
+		data->voltage_max[2] =3D (val >> 8) & 0xff;
+		val =3D gl518_read_value(client, GL518_REG_VIN3_LIMIT);
+		data->voltage_min[3] =3D val & 0xff;
+		data->voltage_max[3] =3D (val >> 8) & 0xff;
+
+		val =3D gl518_read_value(client, GL518_REG_FAN_COUNT);
+		data->fan_in[0] =3D (val >> 8) & 0xff;
+		data->fan_in[1] =3D val & 0xff;
+
+		val =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+		data->fan_min[0] =3D (val >> 8) & 0xff;
+		data->fan_min[1] =3D val & 0xff;
+
+		data->temp_in =3D gl518_read_value(client, GL518_REG_TEMP_IN);
+		data->temp_max +		    gl518_read_value(client, GL518_REG_TEMP_MAX);
+		data->temp_hyst +		    gl518_read_value(client, GL518_REG_TEMP_HYST);
+
+		val =3D gl518_read_value(client, GL518_REG_MISC);
+		data->fan_div[0] =3D (val >> 6) & 0x03;
+		data->fan_div[1] =3D (val >> 4) & 0x03;
+
+		data->alarms &=3D data->alarm_mask;
+
+		val =3D gl518_read_value(client, GL518_REG_CONF);
+		data->beep_enable =3D (val >> 2) & 1;
+
+		if (data->type !=3D gl518sm_r00) {
+			data->voltage_in[0] +			    gl518_read_value(client, GL518_REG_VDD);
+			data->voltage_in[1] +			    gl518_read_value(client, GL518_REG_VIN1);
+			data->voltage_in[2] +			    gl518_read_value(client, GL518_REG_VIN2);
+			data->voltage_in[3] +			    gl518_read_value(client, GL518_REG_VIN3);
+		} else
+			gl518_update_client_rev00(client);
+
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+	up(&data->update_lock);
+}
+
+/* Here we decide how to run the iteration code.
+   When called, we trigger the iteration and report the last
+   measured voltage. No delay for user apps */
+static void gl518_update_client_rev00(struct i2c_client *client)
+{
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	int i;
+
+	if (data->iterate =3D 1) {	/* 10 sec delay */
+		/* as that update is slow, we consider the data valid for 30 seconds */
+		if (
+		    ((jiffies - data->last_updated_v00 > 30 * HZ)
+		     || (data->alarms & 7)
+		     || (!data->valid)) && (!data->iterate_lock)) {
+			data->iterate_lock =3D 1;
+			gl518_update_iterate(client);
+			data->iterate_lock =3D 0;
+		}
+		for (i =3D 0; i < 4; i++)
+			data->voltage_in[i] =3D data->iter_voltage_in[i];
+	} else if (data->iterate =3D 2) {	/* show results of last iteration */
+		for (i =3D 0; i < 4; i++)
+			data->voltage_in[i] =3D data->iter_voltage_in[i];
+		wake_up_interruptible(&data->wq);
+	} else {		/* no iteration */
+		data->voltage_in[3] +		    gl518_read_value(client, GL518_REG_VIN3);
+	}
+}
+
+static int gl518_update_thread(void *c)
+{
+	struct i2c_client *client =3D c;
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+
+#ifdef __SMP__
+	lock_kernel();
+#endif
+	exit_mm(current);
+	current->session =3D 1;
+	sigfillset(&current->blocked);
+	current->fs->umask =3D 0;
+	strcpy(current->comm, "gl518sm");
+
+	init_waitqueue_head(&(data->wq));
+	data->thread =3D current;
+
+#ifdef __SMP__
+	unlock_kernel();
+#endif
+
+	for (;;) {
+		if (!data->iterate_lock) {
+			data->iterate_lock =3D 1;
+			gl518_update_iterate(client);
+			data->iterate_lock =3D 0;
+		}
+
+		if ((data->quit_thread) || signal_pending(current))
+			break;
+		wait_event_interruptible(data->wq, data->quit_thread);
+	}
+
+	data->thread =3D NULL;
+	data->quit_thread =3D 0;
+	return 0;
+}
+
+/* This updates vdd, vin1, vin2 values by doing slow and multiple
+   comparisons for the GL518SM rev 00 that lacks support for direct
+   reading of these values.   Values are kept in iter_voltage   */
+
+static void gl518_update_iterate(struct i2c_client *client)
+{
+	struct gl518_data *data =3D i2c_get_clientdata(client);
+	int i, j, loop_more =3D 1, min[3], max[3], delta[3];
+	int alarm, beep_mask, irqs;
+
+#define VIN_REG(c) c=3D0?GL518_REG_VDD_LIMIT:\
+                   c=3D1?GL518_REG_VIN1_LIMIT:\
+                   GL518_REG_VIN2_LIMIT
+
+	/* disable beeps & irqs for vin0-2 */
+	beep_mask =3D gl518_read_value(client, GL518_REG_ALARM);
+	irqs =3D gl518_read_value(client, GL518_REG_MASK);
+	gl518_write_value(client, GL518_REG_ALARM, beep_mask & ~0x7);
+	gl518_write_value(client, GL518_REG_MASK, irqs & ~0x7);
+
+	alarm =3D data->alarms;
+
+	for (i =3D 0; i < 3; i++) {
+		if (alarm & (1 << i)) {
+			min[i] =3D 0;
+			max[i] =3D 127;
+		} else {
+			min[i] =3D data->voltage_min[i];
+			max[i] +			    (data->voltage_max[i] +
+			     data->voltage_min[i]) / 2;
+		}
+		delta[i] =3D (max[i] - min[i]) / 2;
+	}
+
+	for (j =3D 0; j < 10 && loop_more; j++) {
+		for (i =3D 0; i < 3; i++)
+			gl518_write_value(client, VIN_REG(i),
+					  max[i] << 8 | min[i]);
+
+		if ((data->thread) &&
+		    ((data->quit_thread) || signal_pending(current)))
+			goto finish;
+
+		/* we wait now 1.5 seconds before comparing */
+		current->state =3D TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ + HZ / 2);
+
+		alarm =3D gl518_read_value(client, GL518_REG_INT);
+
+#ifdef DEBUG_VIN
+		dev_dbg(&client->dev, "iteration %2d: %4d%c %4d%c %4d%c\n",
+			j,
+			max[0], (alarm & 1) ? '!' : ' ',
+			max[1], (alarm & 2) ? '!' : ' ',
+			max[2], (alarm & 4) ? '!' : ' ');
+#endif
+
+		for (loop_more =3D 0, i =3D 0; i < 3; i++) {
+			if (alarm & (1 << i))
+				max[i] +=3D delta[i];
+			else
+				max[i] -=3D delta[i];
+
+			if (delta[i])
+				loop_more++;
+			delta[i] >>=3D 1;
+		}
+
+	}
+
+	for (i =3D 0; i < 3; i++)
+		if (alarm & (1 << i))
+			max[i]++;
+
+#ifdef DEBUG_VIN
+	dev_dbg(&client->dev, "   final   :%5d %5d %5d\n", max[0], max[1],
+		max[2]);
+	dev_dbg(&client->dev, "   meter   :%5d %5d %5d\n",
+		data->voltage_in[0], data->voltage_in[1],
+		data->voltage_in[2]);
+#endif
+
+	/* update values, including vin3 */
+	for (i =3D 0; i < 3; i++) {
+		data->iter_voltage_in[i] =3D max[i];
+	}
+	data->iter_voltage_in[3] =3D gl518_read_value(client, GL518_REG_VIN3);
+	data->last_updated_v00 =3D jiffies;
+
+finish:
+
+	/* reset values */
+	for (i =3D 0; i < 3; i++) {
+		gl518_write_value(client, VIN_REG(i),
+			(data->voltage_max[i] << 8) | data->voltage_min[i]);
+	}
+
+	gl518_write_value(client, GL518_REG_ALARM, beep_mask);
+	gl518_write_value(client, GL518_REG_MASK, irqs);
+}
+
+static int __init sensors_gl518sm_init(void)
+{
+	return i2c_add_driver(&gl518_driver);
+}
+
+static void __exit sensors_gl518sm_exit(void)
+{
+	i2c_del_driver(&gl518_driver);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+	"Kyosti Malkki <kmalkki@cc.hut.fi> and "
+	"Hong-Gunn Chew <hglinux@gunnet.org>");
+MODULE_DESCRIPTION("GL518SM driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_gl518sm_init);
+module_exit(sensors_gl518sm_exit);
