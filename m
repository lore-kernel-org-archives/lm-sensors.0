From: linux@rick.claranet.de (Hartmut Rick)
Date: Tue, 28 Feb 2006 01:21:40 +0000
Subject: [lm-sensors] 2.6.15.1 Kernel patch for hardware monitoring support
Message-Id: <Pine.LNX.4.63.0602272321260.3095@Laila>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Jean,

thanks a lot for your advice and encouragement.

On Mon, 27 Feb 2006, Jean Delvare wrote:

>> /* Alarms */
>
> For newer designs, we try to have one sysfs file per alarm type (here,
> one for voltages and one for temperatures) with bits sorted for
> userspace. That way userspace doesn't need to know about the chip
> internals. Can you try to do that in your driver? You'd have one
> alarms_in file and one alarms_temp file.

What would I do with temperature sensor faults? Create another file?
What would it be called?
temp_faults ?
alarms_temp_faults ?
faults_temp ?
... ?
I've used the first for now, but there's no problem to change that.


Otherwise I think I've included all your comments and suggestions.
The patch for 2.6.15.1 kernel is attached to this email.

I'll send documentation for the chip driver later.


Best regards,
  Hartmut
-------------- next part --------------
diff -uprN1 linux-2.6.15.1/Documentation/hwmon/sysfs-interface linux-2.6.15.1_changed/Documentation/hwmon/sysfs-interface
--- linux-2.6.15.1/Documentation/hwmon/sysfs-interface	2006-01-15 07:16:02.000000000 +0100
+++ linux-2.6.15.1_changed/Documentation/hwmon/sysfs-interface	2006-02-28 01:37:34.000000000 +0100
@@ -219,2 +219,8 @@ temp[1-2]_crit_hyst
 
+temp[1-4]_offset
+		Temperature offset which is added to the temperature reading
+		by the chip.
+		Unit: millidegree Celcius
+		Read/Write only value.
+
 		If there are multiple temperature sensors, temp1_* is
@@ -226,3 +232,2 @@ temp[1-2]_crit_hyst
 
-
 ************
@@ -263,2 +268,10 @@ alarms		Alarm bitmask.
 
+alarms_in	Alarm bit pattern for voltages, bits sorted in the order
+		of the in[0-8]_input. Bit 0 is the alarm for in0_input.
+alarms_temp	Alarm bit pattern for temperatures temp[1-4].
+		Bit 0 is the alarm for temp1_input.
+temp_faults	Bit pattern of detected temperature sensor faults
+		Bit 0 is the fault indicator for the temp1_input sensor.
+		A '1' bit means a sensor fault has been detected.
+
 beep_enable	Beep/interrupt enable
diff -uprN1 linux-2.6.15.1/drivers/hwmon/Kconfig linux-2.6.15.1_changed/drivers/hwmon/Kconfig
--- linux-2.6.15.1/drivers/hwmon/Kconfig	2006-01-15 07:16:02.000000000 +0100
+++ linux-2.6.15.1_changed/drivers/hwmon/Kconfig	2006-02-28 01:39:34.000000000 +0100
@@ -341,2 +341,13 @@ config SENSORS_SMSC47B397
 
+config SENSORS_SMSC47M192
+	tristate "SMSC LPC47M192 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select HWMON_VID
+	help
+	  If you say yes here you get support for the hardware sensor
+	  capabilities of the SMSC LPC47M192 and LPC47M997 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called smsc47m192.
+
 config SENSORS_VIA686A
diff -uprN1 linux-2.6.15.1/drivers/hwmon/Makefile linux-2.6.15.1_changed/drivers/hwmon/Makefile
--- linux-2.6.15.1/drivers/hwmon/Makefile	2006-01-15 07:16:02.000000000 +0100
+++ linux-2.6.15.1_changed/drivers/hwmon/Makefile	2006-02-28 01:38:22.000000000 +0100
@@ -41,2 +41,3 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc4
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
+obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
diff -uprN1 linux-2.6.15.1/drivers/hwmon/smsc47m192.c linux-2.6.15.1_changed/drivers/hwmon/smsc47m192.c
--- linux-2.6.15.1/drivers/hwmon/smsc47m192.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15.1_changed/drivers/hwmon/smsc47m192.c	2006-02-28 01:37:58.000000000 +0100
@@ -0,0 +1,596 @@
+/*
+    smsc47m192.c - Support for hardware monitoring block of
+ 		SMSC LPC47M192 and LPC47M997 Super I/O chips.
+
+    Copyright (c) 2006  Hartmut Rick <linux at rick.claranet.de> 
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
+#define SMSC47M192_REG_TEMP(nr)		(0x28 - (nr) + ((nr)>2 ? 0x2d : 0))
+#define SMSC47M192_REG_TEMP_MAX(nr)	(0x3b - (nr) * 2 + ((nr)>2 ? 0x23 : 0))
+#define SMSC47M192_REG_TEMP_MIN(nr)	(0x3c - (nr) * 2 + ((nr)>2 ? 0x23 : 0))
+#define SMSC47M192_REG_TEMP_OFFSET(nr)	(0x21 - (nr))
+
+#define SMSC47M192_REG_ALARM1		0x41
+#define SMSC47M192_REG_ALARM2		0x42
+
+#define SMSC47M192_REG_VID		0x47
+#define SMSC47M192_REG_VID4		0x49
+
+#define SMSC47M192_REG_CONFIG		0x40
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
+/* TEMP: mC (-128C to +127C)
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
+	s8 temp_offset[2];	/* Register value */
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
+	.owner		= THIS_MODULE,
+	.name		= "smsc47m192",
+	.flags		= I2C_DF_NOTIFY,
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
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,		\
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
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr-1]));
+}
+
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr-1]));
+}
+
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr-1]));
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
+	data->temp_min[nr-1] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MIN(nr),
+						data->temp_min[nr-1]);
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
+	data->temp_max[nr-1] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MAX(nr),
+						data->temp_max[nr-1]);
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
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_offset[nr-2]));
+}
+
+static ssize_t set_temp_offset(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_offset[nr-2] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_OFFSET(nr),
+						data->temp_offset[nr-2]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define show_temp_index(index)					\
+static SENSOR_DEVICE_ATTR(temp##index##_input, S_IRUGO, 		\
+			show_temp, NULL, index);		\
+static SENSOR_DEVICE_ATTR(temp##index##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, index);		\
+static SENSOR_DEVICE_ATTR(temp##index##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, index);
+
+show_temp_index(1);
+show_temp_index(2);
+show_temp_index(3);
+
+static SENSOR_DEVICE_ATTR(temp2_offset, S_IRUGO | S_IWUSR,
+		show_temp_offset, set_temp_offset, 2);
+static SENSOR_DEVICE_ATTR(temp3_offset, S_IRUGO | S_IWUSR,
+		show_temp_offset, set_temp_offset, 3);
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
+        struct smsc47m192_data *data = smsc47m192_update_device(dev);
+        return sprintf(buf, "%d\n", data->vrm);
+}
+
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+        struct i2c_client *client = to_i2c_client(dev);
+        struct smsc47m192_data *data = i2c_get_clientdata(client);
+        data->vrm = simple_strtoul(buf, NULL, 10);
+        return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+/* Alarms */
+static ssize_t show_raw_alarms(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%u\n", data->raw_alarms);
+}
+static DEVICE_ATTR(alarms, S_IRUGO, show_raw_alarms, NULL);
+
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	return sprintf(buf, "%u\n", data->alarm[nr]);
+}
+static SENSOR_DEVICE_ATTR(alarms_in, S_IRUGO, show_alarms, NULL, 0);
+static SENSOR_DEVICE_ATTR(alarms_temp, S_IRUGO, show_alarms, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp_faults, S_IRUGO, show_alarms, NULL, 2);
+
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
+	int version;
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
+        if (kind = 0)
+                kind = smsc47m192;
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
+	device_create_file(&client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in4_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in4_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in4_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in5_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in6_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in7_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&client->dev,
+					&sensor_dev_attr_temp2_offset.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+	device_create_file(&client->dev,
+					&sensor_dev_attr_temp3_offset.dev_attr);
+	device_create_file(&client->dev, &dev_attr_alarms);
+	device_create_file(&client->dev, &sensor_dev_attr_alarms_in.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_alarms_temp.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp_faults.dev_attr);
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
+	u8 config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
+
+	/* Start monitoring */
+	if (!(config & 0x01))
+		i2c_smbus_write_byte_data(client, SMSC47M192_REG_CONFIG,
+				 (config & 0xf7) | 0x01);
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
+	    || !data->valid) {
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
+						SMSC47M192_REG_TEMP(i+1));
+			data->temp_max[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_MAX(i+1));
+			data->temp_min[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_MIN(i+1));
+		}
+		for (i = 0; i < 2; i++)
+			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_OFFSET(i+2));
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
