From: Marcin.Dawidowicz@kontron.pl (Marcin Dawidowicz)
Date: Mon, 24 Jul 2006 10:55:42 +0000
Subject: [lm-sensors] [PATCH] driver for SMSC SCH311x
Message-Id: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Below you find my SMSC SCH311x chips driver. Currently, it supports voltage, temperature inputs and alarms.
There is not implemented support for fans and pwm control (I couldn't test it on my hardware).

Thanks for your feedback,
Marcin

Signed-off-by: Marcin Dawidowicz <Marcin.Dawidowicz at kontron.pl>

diff -uprN -X ./linux-2.6.18-rc2-vanilla/Documentation/dontdiff linux-2.6.18-rc2-vanilla/drivers/hwmon/Kconfig linux-2.6.18-rc2-sch311x/drivers/hwmon/Kconfig
--- linux-2.6.18-rc2-vanilla/drivers/hwmon/Kconfig	2006-07-15 23:53:08.000000000 +0200
+++ linux-2.6.18-rc2-sch311x/drivers/hwmon/Kconfig	2006-07-20 17:57:01.000000000 +0200
@@ -396,6 +396,17 @@ config SENSORS_SMSC47B397
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47b397.
 
+config SENSORS_SCH311X
+	tristate "SMSC SCH311x family"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the SMSC SCH311x family
+	  sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sch311x.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on HWMON && I2C && PCI
diff -uprN -X ./linux-2.6.18-rc2-vanilla/Documentation/dontdiff linux-2.6.18-rc2-vanilla/drivers/hwmon/Makefile linux-2.6.18-rc2-sch311x/drivers/hwmon/Makefile
--- linux-2.6.18-rc2-vanilla/drivers/hwmon/Makefile	2006-07-15 23:53:08.000000000 +0200
+++ linux-2.6.18-rc2-sch311x/drivers/hwmon/Makefile	2006-07-20 17:57:41.000000000 +0200
@@ -44,6 +44,7 @@ obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
+obj-$(CONFIG_SENSORS_SCH311X)	+= sch311x.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
diff -uprN -X ./linux-2.6.18-rc2-vanilla/Documentation/dontdiff linux-2.6.18-rc2-vanilla/drivers/hwmon/sch311x.c linux-2.6.18-rc2-sch311x/drivers/hwmon/sch311x.c
--- linux-2.6.18-rc2-vanilla/drivers/hwmon/sch311x.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-rc2-sch311x/drivers/hwmon/sch311x.c	2006-07-24 12:36:02.000000000 +0200
@@ -0,0 +1,629 @@
+/*
+    sch311x.c - Part of lm_sensors, Linux kernel modules
+			for hardware monitoring
+
+    Supports the SMSC SCH311x Super-I/O chips.
+
+    Author: Marcin Dawidowicz <Marcin.Dawidowicz at kontron.pl>
+	Copyright (C) 2006 Kontron Modular Computers
+
+    derived in part from smsc47m1.c and smsc47b397:
+	Copyright (C) 2002 Mark D. Studebaker <mdsxyz123 at yahoo.com>
+	Copyright (C) 2004 Jean Delvare <khali at linux-fr.org>
+	Copyright (C) 2004 Mark M. Hoffman <mhoffman at lightlink.com>
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
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/i2c-isa.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <asm/io.h>
+
+/* Address is autodetected, there is no default value */
+static unsigned short address;
+
+/* Miscellaneous defines */
+
+#define SUPERIO_REG_DEVID		0x20
+#define SUPERIO_REG_DEVREV		0x21
+#define SUPERIO_REG_BASE_MSB		0x60
+#define SUPERIO_REG_BASE_LSB		0x61
+#define SUPERIO_REG_LD			0x0A
+
+#define SMSC_EXTENT			0x02	/* hw mon registers size */
+
+#define SCH311X_REG_TEMP(nr)		(0x25 + nr)
+#define SCH311X_REG_TEMP_HIGH(nr)	(0x4f + (nr*2))
+#define SCH311X_REG_TEMP_LOW(nr)	(0x4e + (nr*2))
+#define SCH311X_REG_FANTACH_LSB(nr)	(0x28 + (nr*2))
+#define SCH311X_REG_FANTACH_MSB(nr)	(0x29 + (nr*2))
+#define SCH311X_REG_FANTACH_MIN_LSB(nr)	(0x54 + (nr*2))
+#define SCH311X_REG_FANTACH_MIN_MSB(nr)	(0x55 + (nr*2))
+
+static const u8 sch311x_volt_regs[7] = {
+	0x20	/*	2.5 V */,
+	0x21	/* Vccp	1.5 V */,
+	0x22	/* VCC	3.3 V */,
+	0x23	/*	  5 V */,
+	0x24	/*	 12 V */,
+	0x99	/* VTR	3.3 V */,
+	0x9a	/* Vbat	3.0 V */
+};
+
+/* max volt values multiplied by 1000 */
+static const u16 sch311x_volt_max_vals[7] = {
+	6640	/*	2.5 V */,
+	3000	/* Vccp	1.5 V */,
+	4380	/* VCC	3.3 V */,
+	6640	/*	  5 V */,
+	16000	/*	 12 V */,
+	4380	/* VTR	3.3 V */,
+	4380	/* Vbat	3.0 V */
+};
+
+#define SCH311X_REG_IN(nr)	(sch311x_volt_regs[nr])
+
+static const u8 sch311x_volt_lo_regs[7] = {
+	0x44, 0x46, 0x48, 0x4a, 0x4c, 0x9b, 0x9d
+};
+
+#define SCH311X_REG_MIN(nr)	(sch311x_volt_lo_regs[nr])
+
+static const u8 sch311x_volt_hi_regs[7] = {
+	0x45, 0x47, 0x49, 0x4b, 0x4d, 0x9c, 0x9e
+};
+
+#define SCH311X_REG_MAX(nr)	(sch311x_volt_hi_regs[nr])
+
+/* Interrupt enable voltages */
+#define SCH311X_REG_INT_VOLT_EN	(0x7e)
+
+#define VOLT_EN_2_5V		(1<<2)
+#define VOLT_EN_VCPP		(1<<3)
+#define VOLT_EN_VCC		(1<<7)
+#define VOLT_EN_5V		(1<<5)
+#define VOLT_EN_12V		(1<<6)
+#define VOLT_EN_VRT		(1<<4)
+#define VOLT_EN_VBAT		(1<<1)
+
+/* Interrupt status registers */
+#define SCH311X_REG_ISR1	(0x41)
+#define SCH311X_REG_ISR2	(0x42)
+#define SCH311X_REG_ISR3	(0x83)
+
+/* Alarm bits meaning */
+#define ISR_TEMP3		(6)
+#define ISR_TEMP2		(5)
+#define ISR_TEMP1		(4)
+#define ISR_5V			(3)
+#define ISR_VCC			(2)
+#define ISR_Vccp		(1)
+#define ISR_2_5V		(0)
+
+#define ISR_ERR3		(15)
+#define ISR_ERR1		(14)
+#define ISR_FAN_3		(12)
+#define ISR_FAN_2		(11)
+#define ISR_FAN_1		(10)
+#define ISR_12V			(8)
+
+#define ISR_VRT			(16)
+#define ISR_Vbat		(17)
+
+/* logical device for hardware monitoring is 0x0A */
+#define superio_select() superio_outb(0x07, SUPERIO_REG_LD)
+
+/* Super-I/0 registers and commands */
+#define	REG	0x2e	/* The register to read/write */
+#define	VAL	0x2f	/* The value to read/write */
+
+static inline void
+superio_outb(int reg, int val)
+{
+	outb(reg, REG);
+	outb(val, VAL);
+}
+
+static inline int
+superio_inb(int reg)
+{
+	outb(reg, REG);
+	return inb(VAL);
+}
+
+static inline void
+superio_enter(void)
+{
+	outb(0x55, REG);
+}
+
+static inline void
+superio_exit(void)
+{
+	outb(0xAA, REG);
+}
+
+struct sch311x_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+	struct mutex lock;
+
+	struct mutex update_lock;
+	unsigned long last_updated;	/* In jiffies */
+	int valid;
+
+	u32 alarms;		/* Register value of interrupt status */
+
+	s8 temp[3];		/* register value */
+	s8 temp_high[3];	/* register value */
+	s8 temp_low[3];		/* register value */
+
+	u8 in[7];		/* register value */
+	u8 in_max[7];		/* register value */
+	u8 in_min[7];		/* register value */
+};
+
+static int sch311x_detect(struct i2c_adapter *adapter);
+static int sch311x_detach_client(struct i2c_client *client);
+
+static struct i2c_driver sch311x_driver = {
+	.driver = {
+		.name	= "sch311x",
+	},
+	.attach_adapter	= sch311x_detect,
+	.detach_client	= sch311x_detach_client,
+};
+
+static int sch311x_read_value(struct i2c_client *client, u8 reg)
+{
+	struct sch311x_data *data = i2c_get_clientdata(client);
+	int res;
+
+	mutex_lock(&data->lock);
+
+	outb(reg, client->addr);
+	res = inb_p(client->addr + 1);
+
+	mutex_unlock(&data->lock);
+	return res;
+}
+
+static void sch311x_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+	struct sch311x_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->lock);
+
+	outb(reg, client->addr);
+	outb(value, client->addr + 1);
+
+	mutex_unlock(&data->lock);
+}
+
+static struct sch311x_data *sch311x_update_device(struct device *dev)
+{
+ 	struct i2c_client *client = to_i2c_client(dev);
+	struct sch311x_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		dev_dbg(&client->dev, "starting device update...\n");
+
+		/* read alarms */
+		data->alarms = sch311x_read_value(client,
+				SCH311X_REG_ISR1);
+		data->alarms|= sch311x_read_value(client,
+				SCH311X_REG_ISR2) << 8;
+		data->alarms|= sch311x_read_value(client,
+				SCH311X_REG_ISR3) << 16;
+
+		/* 3 temperature inputs */
+		for (i = 0; i < 3; i++) {
+			data->temp[i] = sch311x_read_value(client,
+					SCH311X_REG_TEMP(i));
+			data->temp_high[i] = sch311x_read_value(client,
+					SCH311X_REG_TEMP_HIGH(i));
+			data->temp_low[i] = sch311x_read_value(client,
+					SCH311X_REG_TEMP_LOW(i));
+		}
+		/* 7 voltage inputs */
+		for (i = 0; i < 7; i++) {
+			data->in[i] = sch311x_read_value(client,
+					SCH311X_REG_IN(i));
+			data->in_max[i] = sch311x_read_value(client,
+					SCH311X_REG_MAX(i));
+			data->in_min[i] = sch311x_read_value(client,
+					SCH311X_REG_MIN(i));
+		}
+
+		/* clear alarms */
+		sch311x_write_value(client, SCH311X_REG_ISR1, 0xff);
+		sch311x_write_value(client, SCH311X_REG_ISR2, 0xff);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+
+		dev_dbg(&client->dev, "... device update complete\n");
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static int temp_from_reg(u8 reg)
+{
+	return (s8)reg * 100;
+}
+
+/* 0 <= nr <= 3 */
+static ssize_t show_temp(struct device *dev, char *buf, int nr)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp[nr]));
+}
+
+static ssize_t show_temp_high(struct device *dev, char *buf, int nr)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp_high[nr]));
+}
+
+static ssize_t show_temp_low(struct device *dev, char *buf, int nr)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp_low[nr]));
+}
+
+#define sysfs_temp(num) \
+static ssize_t show_temp##num(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_temp(dev, buf, num-1); \
+} \
+static ssize_t show_temp_high##num(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_temp_high(dev, buf, num-1); \
+} \
+static ssize_t show_temp_low##num(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_temp_low(dev, buf, num-1); \
+} \
+static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL)
+
+sysfs_temp(1);
+sysfs_temp(2);
+sysfs_temp(3);
+
+static void set_temp_high(struct device *dev, const char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s32 val;
+
+	val = simple_strtol(buf, NULL, 10);
+	sch311x_write_value(client, SCH311X_REG_TEMP_HIGH(nr), val/100);
+}
+
+static void set_temp_low(struct device *dev, const char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s32 val;
+
+	val = simple_strtol(buf, NULL, 10);
+	sch311x_write_value(client, SCH311X_REG_TEMP_LOW(nr), val/100);
+}
+
+#define sysfs_set_temp(num) \
+static ssize_t set_temp_high##num(struct device *dev, struct device_attribute *attr, \
+		const char *buf, size_t count) \
+{ \
+	set_temp_high(dev, buf, num - 1); \
+	return count; \
+} \
+static ssize_t set_temp_low##num(struct device *dev, struct device_attribute *attr, \
+		const char *buf, size_t count) \
+{ \
+	set_temp_low(dev, buf, num - 1); \
+	return count; \
+} \
+static DEVICE_ATTR(temp##num##_low, S_IRUGO | S_IWUSR, \
+		show_temp_low##num, set_temp_low##num); \
+static DEVICE_ATTR(temp##num##_high, S_IRUGO | S_IWUSR, \
+		show_temp_high##num, set_temp_high##num)
+
+sysfs_set_temp(1);
+sysfs_set_temp(2);
+sysfs_set_temp(3);
+
+#define device_create_file_temp(client, num) \
+	device_create_file(&client->dev, &dev_attr_temp##num##_input); \
+	device_create_file(&client->dev, &dev_attr_temp##num##_high); \
+	device_create_file(&client->dev, &dev_attr_temp##num##_low)
+
+static int in_from_reg(u8 reg, u16 max_val)
+{
+	return (int) reg * max_val / 255;
+}
+
+/* 0 <= nr <= 7 */
+static ssize_t show_in(struct device *dev, char *buf, int nr)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	return sprintf(buf, "%d\n", in_from_reg(data->in[nr], sch311x_volt_max_vals[nr]));
+}
+
+static ssize_t show_max(struct device *dev, char *buf, int nr)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	return sprintf(buf, "%d\n", in_from_reg(data->in_max[nr], sch311x_volt_max_vals[nr]));
+}
+
+static ssize_t show_min(struct device *dev, char *buf, int nr)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	return sprintf(buf, "%d\n", in_from_reg(data->in_min[nr], sch311x_volt_max_vals[nr]));
+}
+
+#define sysfs_in(num) \
+static ssize_t show_in##num##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_in(dev, buf, num); \
+} \
+static ssize_t show_in##num##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_max(dev, buf, num); \
+} \
+static ssize_t show_in##num##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_min(dev, buf, num); \
+} \
+static DEVICE_ATTR(in##num##_input, S_IRUGO, show_in##num##_input, NULL)
+
+sysfs_in(0);
+sysfs_in(1);
+sysfs_in(2);
+sysfs_in(3);
+sysfs_in(4);
+sysfs_in(5);
+sysfs_in(6);
+
+static void set_min(struct device *dev, const char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10) * 255 / sch311x_volt_max_vals[nr];
+	sch311x_write_value(client, SCH311X_REG_MIN(nr), val);
+}
+
+static void set_max(struct device *dev, const char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10) * 255 / sch311x_volt_max_vals[nr];
+	sch311x_write_value(client, SCH311X_REG_MAX(nr), val);
+}
+
+#define sysfs_set_in(num) \
+static ssize_t set_in##num##_min(struct device *dev, struct device_attribute *attr, \
+		const char *buf, size_t count) \
+{ \
+	set_min(dev, buf, num); \
+	return count; \
+} \
+static ssize_t set_in##num##_max(struct device *dev, struct device_attribute *attr, \
+		const char *buf, size_t count) \
+{ \
+	set_max(dev, buf, num); \
+	return count; \
+} \
+static DEVICE_ATTR(in##num##_min, S_IRUGO | S_IWUSR, \
+		show_in##num##_min, set_in##num##_min); \
+static DEVICE_ATTR(in##num##_max, S_IRUGO | S_IWUSR, \
+		show_in##num##_max, set_in##num##_max)
+
+#define device_create_file_in(client, num) \
+	device_create_file(&client->dev, &dev_attr_in##num##_input); \
+	device_create_file(&client->dev, &dev_attr_in##num##_max); \
+	device_create_file(&client->dev, &dev_attr_in##num##_min); \
+	device_create_file(&client->dev, &sensor_dev_attr_in##num##_alarm.dev_attr)
+
+sysfs_set_in(0);
+sysfs_set_in(1);
+sysfs_set_in(2);
+sysfs_set_in(3);
+sysfs_set_in(4);
+sysfs_set_in(5);
+sysfs_set_in(6);
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sch311x_data *data = sch311x_update_device(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	return sprintf(buf, "%u\n", (data->alarms & (1<<nr)) ? 1 : 0);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, ISR_TEMP1);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, ISR_TEMP2);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, ISR_TEMP3);
+static SENSOR_DEVICE_ATTR(temp1_error, S_IRUGO, show_alarm, NULL, ISR_ERR1);
+static SENSOR_DEVICE_ATTR(temp3_error, S_IRUGO, show_alarm, NULL, ISR_ERR3);
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, ISR_2_5V);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, ISR_Vccp);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, ISR_VCC);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, ISR_5V);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, ISR_12V);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, ISR_VRT);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, ISR_Vbat);
+
+static int sch311x_detach_client(struct i2c_client *client)
+{
+	struct sch311x_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	release_region(client->addr, SMSC_EXTENT);
+	kfree(data);
+
+	return 0;
+}
+
+static int sch311x_detect(struct i2c_adapter *adapter)
+{
+	struct i2c_client *new_client;
+	struct sch311x_data *data;
+	int err = 0;
+	u8 mon_volt;
+
+	if (!request_region(address, SMSC_EXTENT,
+			    sch311x_driver.driver.name)) {
+		dev_err(&adapter->dev, "Region 0x%x already in use!\n",
+			address);
+		return -EBUSY;
+	}
+
+	if (!(data = kzalloc(sizeof(struct sch311x_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto error_release;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	mutex_init(&data->lock);
+	new_client->adapter = adapter;
+	new_client->driver = &sch311x_driver;
+	new_client->flags = 0;
+
+	strlcpy(new_client->name, "sch311x", I2C_NAME_SIZE);
+
+	mutex_init(&data->update_lock);
+
+	if ((err = i2c_attach_client(new_client)))
+		goto error_free;
+
+	mon_volt = superio_inb(SCH311X_REG_INT_VOLT_EN);
+
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto error_detach;
+	}
+
+	/* temp values */
+	device_create_file_temp(new_client, 1);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_alarm.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_error.dev_attr);
+	device_create_file_temp(new_client, 2);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_alarm.dev_attr);
+	device_create_file_temp(new_client, 3);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_alarm.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_error.dev_attr);
+
+	/* voltage values */
+	if (mon_volt & VOLT_EN_2_5V) device_create_file_in(new_client, 0);
+	if (mon_volt & VOLT_EN_VCPP) device_create_file_in(new_client, 1);
+	if (mon_volt & VOLT_EN_VCC) device_create_file_in(new_client, 2);
+	if (mon_volt & VOLT_EN_5V) device_create_file_in(new_client, 3);
+	if (mon_volt & VOLT_EN_12V) device_create_file_in(new_client, 4);
+	if (mon_volt & VOLT_EN_VRT) device_create_file_in(new_client, 5);
+	if (mon_volt & VOLT_EN_VBAT) device_create_file_in(new_client, 6);
+
+	return 0;
+
+error_detach:
+	i2c_detach_client(new_client);
+error_free:
+	kfree(data);
+error_release:
+	release_region(address, SMSC_EXTENT);
+	return err;
+}
+
+static int __init sch311x_find(unsigned short *addr)
+{
+	u8 id, rev;
+
+	superio_enter();
+	id = superio_inb(SUPERIO_REG_DEVID);
+
+	if ((id & 0xfc) != 0x7c) {
+		superio_exit();
+		return -ENODEV;
+	}
+
+	rev = superio_inb(SUPERIO_REG_DEVREV);
+
+	superio_select();
+
+	/*
+	 * base address to "Runtime Registers"
+	 * plus offset to HWM Index/Data
+	 * registers
+	 */
+	*addr = ((superio_inb(SUPERIO_REG_BASE_MSB) << 8)
+		 |  superio_inb(SUPERIO_REG_BASE_LSB))
+		 + 0x70;
+
+	printk(KERN_INFO "sch311x: found SMSC %s "
+		"(base address 0x%04x, revision %u)\n",
+		id = 0x7c ? "SCH3112" :
+		id = 0x7d ? "SCH3114" :
+		id = 0x7f ? "SCH3116" :
+		"SCH311X id=0x7e <Reserved>"
+		, *addr, rev);
+
+	superio_exit();
+
+	return 0;
+}
+
+static int __init sch311x_init(void)
+{
+	int ret;
+
+	if ((ret = sch311x_find(&address)))
+		return ret;
+
+	return i2c_isa_add_driver(&sch311x_driver);
+}
+
+static void __exit sch311x_exit(void)
+{
+	i2c_isa_del_driver(&sch311x_driver);
+}
+
+MODULE_AUTHOR("Marcin Dawidowicz <Marcin.Dawidowicz at kontron.pl>");
+MODULE_DESCRIPTION("SMSC SCH311x driver");
+MODULE_LICENSE("GPL");
+
+module_init(sch311x_init);
+module_exit(sch311x_exit);

