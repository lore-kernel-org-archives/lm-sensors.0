From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 06 Jul 2007 21:11:45 +0000
Subject: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5843283103941329184=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============5843283103941329184==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Content-Disposition: inline


--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

Below is a first draft of a driver for the ADT7470 chip.  I've tested
the driver against the adt7470 in the IBM IntelliStation Z30 and as far
as I can tell it's good for controlling the speed of the CPU heatsink
fans and monitor CPU temperature.  Please let me know what you think of
the driver.  The patch should apply cleanly against 2.6.22-rc7.

Please cc me as I'm not subscribed to lm-sensors.

Datasheets available here:
http://www.analog.com/en/prod/0,2877,ADT7470,00.html

--Darrick
---
adt7470: new hwmon driver for adt7470 chip.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1=20
 drivers/hwmon/adt7470.c |  875 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 886 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 13eea47..bb57beb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -40,6 +40,16 @@ config SENSORS_ABITUGURU
 	  This driver can also be built as a module.  If so, the module
 	  will be called abituguru.
=20
+config SENSORS_ADT7470
+	tristate "Analog Devices ADT7470"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  ADT7470 temperature monitoring chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called adt7470.
+
 config SENSORS_AD7418
 	tristate "Analog Devices AD7416, AD7417 and AD7418"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index cfaf338..e5fc251 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SENSORS_W83781D)	+=3D w83781d.o
 obj-$(CONFIG_SENSORS_W83791D)	+=3D w83791d.o
=20
 obj-$(CONFIG_SENSORS_ABITUGURU)	+=3D abituguru.o
+obj-$(CONFIG_SENSORS_ADT7470)	+=3D adt7470.o
 obj-$(CONFIG_SENSORS_AD7418)	+=3D ad7418.o
 obj-$(CONFIG_SENSORS_ADM1021)	+=3D adm1021.o
 obj-$(CONFIG_SENSORS_ADM1025)	+=3D adm1025.o
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
new file mode 100644
index 0000000..cb2ac60
--- /dev/null
+++ b/drivers/hwmon/adt7470.c
@@ -0,0 +1,875 @@
+/*
+ * A hwmon driver for the Analog Devices ADT7470
+ * Copyright (C) 2007 IBM
+ *
+ * Author: Darrick J. Wong <djwong@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License,
+ * as published by the Free Software Foundation - version 2.
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+
+#define DRV_VERSION "0.22"
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] =3D { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END =
};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(adt7470);
+
+/* ADT7470 registers */
+#define ADT7470_REG_BASE		0x20
+#define ADT7470_REG_TEMP_BASE		0x20
+#define ADT7470_REG_TEMP_MAX		0x29
+#define ADT7470_REG_FAN_BASE		0x2A
+#define ADT7470_REG_FAN_MAX		0x31
+#define ADT7470_REG_PWM_BASE		0x32
+//#define ADT7470_REG_PWM_MAX		0x35
+#define ADT7470_REG_PWM_MAX_BASE	0x38
+#define ADT7470_REG_PWM_MAX_MAX		0x3B
+#define ADT7470_REG_CFG			0x40
+#define		ADT7470_FSPD_MASK	0x04
+#define ADT7470_REG_ALARM1		0x41
+#define ADT7470_REG_ALARM2		0x42
+#define ADT7470_REG_TEMP_LIMITS_BASE	0x44
+#define ADT7470_REG_TEMP_LIMITS_MAX	0x57
+#define ADT7470_REG_FAN_MIN_BASE	0x58
+#define ADT7470_REG_FAN_MIN_MAX		0x5F
+#define ADT7470_REG_FAN_MAX_BASE	0x60
+#define ADT7470_REG_FAN_MAX_MAX		0x67
+#define ADT7470_REG_PWM_CFG_BASE	0x68
+#define ADT7470_REG_PWM12_CFG		0x68
+#define		ADT7470_PWM1_AUTO_MASK	0x40
+#define		ADT7470_PWM2_AUTO_MASK	0x80
+#define ADT7470_REG_PWM34_CFG		0x69
+#define		ADT7470_PWM3_AUTO_MASK	0x40
+#define		ADT7470_PWM4_AUTO_MASK	0x80
+#define	ADT7470_REG_PWM_MIN_BASE	0x6A
+#define ADT7470_REG_PWM_MIN_MAX		0x6D
+#define ADT7470_REG_PWM_TEMP_MIN_BASE	0x6E
+#define ADT7470_REG_PWM_TEMP_MIN_MAX	0x71
+#define ADT7470_REG_ACOUSTICS12		0x75
+#define ADT7470_REG_ACOUSTICS34		0x76
+#define ADT7470_REG_DEVICE		0x3D
+#define ADT7470_REG_VENDOR		0x3E
+#define ADT7470_REG_REVISION		0x3F
+#define ADT7470_REG_ALARM1_MASK		0x72
+#define ADT7470_REG_ALARM2_MASK		0x73
+#define ADT7470_REG_PWM_AUTO_TEMP_BASE	0x7C
+#define ADT7470_REG_PWM_AUTO_TEMP_MAX	0x7D
+#define ADT7470_REG_MAX			0x81
+
+#define ADT7470_TEMP_COUNT	10
+#define ADT7470_TEMP_REG(x)	(ADT7470_REG_TEMP_BASE + (x))
+#define ADT7470_TEMP_MIN_REG(x) (ADT7470_REG_TEMP_LIMITS_BASE + (2 * (x)))
+#define ADT7470_TEMP_MAX_REG(x) (ADT7470_REG_TEMP_LIMITS_BASE + (2 * (x)) =
+ 1)
+
+#define ADT7470_FAN_COUNT	4
+
+#define ADT7470_PWM_COUNT	4
+#define ADT7470_REG_PWM(x)	(ADT7470_REG_PWM_BASE + (x))
+#define ADT7470_REG_PWM_MAX(x)	(ADT7470_REG_PWM_MAX_BASE + (x))
+#define ADT7470_REG_PWM_MIN(x)	(ADT7470_REG_PWM_MIN_BASE + (x))
+#define ADT7470_REG_PWM_TMIN(x)	(ADT7470_REG_PWM_TEMP_MIN_BASE + (x))
+
+#define ADT7470_VENDOR		0x41
+#define ADT7470_DEVICE		0x70
+#define ADT7470_REVISION	0x02
+
+#define ADT7470_PWM_ALL_TEMPS	0x3FF		/* "all temps" according to hwmon sys=
fs interface spec */
+
+#define REFRESH_INTERVAL	(2 * HZ)
+#define TEMP_COLLECTION_TIME	1000		/* sleep 1s while gathering temperature=
 data */
+
+#define power_of_2(x)	(((x) & ((x) - 1)) =3D=3D 0)
+
+struct adt7470_data {
+	struct i2c_client	client;
+	struct class_device	*class_dev;
+	struct attribute_group	attrs;
+	enum chips		type;
+	struct mutex		lock;
+	char			valid;
+	unsigned long		last_updated;	/* In jiffies */
+
+	u8			temp[ADT7470_TEMP_COUNT];
+	u8			temp_min[ADT7470_TEMP_COUNT];
+	u8			temp_max[ADT7470_TEMP_COUNT];
+	u16			fan[ADT7470_FAN_COUNT];
+	u16			fan_min[ADT7470_FAN_COUNT];
+	u16			fan_max[ADT7470_FAN_COUNT];
+	u16			alarms, alarms_mask;
+	u8			force_pwm_max;
+	u8			pwm[ADT7470_PWM_COUNT];
+	u8			pwm_max[ADT7470_PWM_COUNT];
+	u8			pwm_automatic[ADT7470_PWM_COUNT];
+	u8			pwm_min[ADT7470_PWM_COUNT];
+	u8			pwm_tmin[ADT7470_PWM_COUNT];
+	u8			pwm_auto_temp[ADT7470_PWM_COUNT];
+
+	u8			raw[256];
+};
+
+static int adt7470_attach_adapter(struct i2c_adapter *adapter);
+static int adt7470_detect(struct i2c_adapter *adapter, int address, int ki=
nd);
+static int adt7470_detach_client(struct i2c_client *client);
+
+static struct i2c_driver adt7470_driver =3D {
+	.driver =3D {
+		.name	=3D "adt7470",
+	},
+	.attach_adapter	=3D adt7470_attach_adapter,
+	.detach_client	=3D adt7470_detach_client,
+};
+
+/* 16-bit registers on the ADT7470 are low-byte first. */
+static inline int adt7470_read16(struct i2c_client *client, u8 reg)
+{
+	u16 foo;
+	foo =3D i2c_smbus_read_byte_data(client, reg) | ((u16)i2c_smbus_read_byte=
_data(client, reg + 1) << 8);
+	return foo;
+}
+
+static inline int adt7470_write16(struct i2c_client *client, u8 reg, u16 v=
alue)
+{
+	return i2c_smbus_write_word_data(client, reg, cpu_to_le16(value));
+}
+
+static void adt7470_init_client(struct i2c_client *client)
+{
+	//struct adt7470_data *data =3D i2c_get_clientdata(client);
+
+	int reg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+	if (reg < 0) {
+		dev_err(&client->dev, "cannot read configuration register\n");
+	} else {
+		// start monitoring (and do a self-test)
+		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
+	}
+}
+
+static u16 adt7470_read_fan_min(struct i2c_client *client, int fan)
+{
+	return adt7470_read16(client, ADT7470_REG_FAN_MIN_BASE + (2 * fan));
+}
+
+static u16 adt7470_read_fan_max(struct i2c_client *client, int fan)
+{
+	return adt7470_read16(client, ADT7470_REG_FAN_MAX_BASE + (2 * fan));
+}
+
+static u16 adt7470_read_fan(struct i2c_client *client, int fan)
+{
+	return adt7470_read16(client, ADT7470_REG_FAN_BASE + (2 * fan));
+}
+
+static struct adt7470_data *adt7470_update_device(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+
+	mutex_lock(&data->lock);
+
+	if (time_after(jiffies, data->last_updated + REFRESH_INTERVAL)
+		|| !data->valid) {
+		u8 cfg;
+		int i;
+
+		/* start reading temperature sensors */
+		cfg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+		cfg |=3D 0x80;
+		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+
+		/* delay is 200ms * number of tmp05 sensors */
+		udelay(TEMP_COLLECTION_TIME);
+
+		/* done reading temperature sensors */
+		cfg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+		cfg &=3D ~0x80;
+		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+
+		for (i =3D 0; i < ADT7470_TEMP_COUNT; i++) {
+			data->temp[i] =3D i2c_smbus_read_byte_data(client, ADT7470_TEMP_REG(i));
+			data->temp_min[i] =3D i2c_smbus_read_byte_data(client, ADT7470_TEMP_MIN=
_REG(i));
+			data->temp_max[i] =3D i2c_smbus_read_byte_data(client, ADT7470_TEMP_MAX=
_REG(i));
+		}
+
+		for (i =3D 0; i < ADT7470_FAN_COUNT; i++) {
+			data->fan[i] =3D adt7470_read_fan(client, i);
+			data->fan_min[i] =3D adt7470_read_fan_min(client, i);
+			data->fan_max[i] =3D adt7470_read_fan_max(client, i);
+		}
+
+		for (i =3D ADT7470_REG_BASE; i <=3D ADT7470_REG_MAX; i++) {
+			data->raw[i - ADT7470_REG_BASE] =3D i2c_smbus_read_byte_data(client, i);
+		}
+
+		for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
+			int reg =3D ADT7470_REG_PWM_CFG_BASE + (i / 2);
+			int reg_mask =3D ADT7470_PWM1_AUTO_MASK;
+			if (!(i % 2))
+				reg_mask <<=3D 1;
+
+			data->pwm[i] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
+			data->pwm_max[i] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_M=
AX(i));
+			data->pwm_min[i] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_M=
IN(i));
+			data->pwm_tmin[i] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_=
TMIN(i));
+			data->pwm_automatic[i] =3D ((i2c_smbus_read_byte_data(client, reg) & re=
g_mask) =3D=3D reg_mask);
+			reg =3D ADT7470_REG_PWM_AUTO_TEMP_BASE + (i / 2);
+			if (!(i % 2))
+				data->pwm_auto_temp[i] =3D i2c_smbus_read_byte_data(client, reg) >> 4;
+			else
+				data->pwm_auto_temp[i] =3D i2c_smbus_read_byte_data(client, reg) & 0xF;
+		}
+
+		data->force_pwm_max =3D ((i2c_smbus_read_byte_data(client, ADT7470_REG_C=
FG) & ADT7470_FSPD_MASK) =3D=3D ADT7470_FSPD_MASK);
+
+		data->alarms =3D adt7470_read16(client, ADT7470_REG_ALARM1);
+		data->alarms_mask =3D adt7470_read16(client, ADT7470_REG_ALARM1_MASK);
+
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return data;
+}
+
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *=
devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
+}
+
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *d=
evattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10) / 1000;
+
+	mutex_lock(&data->lock);
+	data->temp_min[attr->index] =3D temp;
+	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index), temp=
);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *=
devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
+}
+
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *d=
evattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10) / 1000;
+
+	mutex_lock(&data->lock);
+	data->temp_max[attr->index] =3D temp;
+	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index), temp=
);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_temp(struct device *dev, struct device_attribute *deva=
ttr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
+}
+
+static ssize_t show_alarms(struct device *dev, struct device_attribute *de=
vattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (attr->index)
+		return sprintf(buf, "%x\n", data->alarms);
+	else
+		return sprintf(buf, "%x\n", data->alarms_mask);
+}
+
+static ssize_t show_fan_max(struct device *dev, struct device_attribute *d=
evattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (data->fan_max[attr->index])
+		return sprintf(buf, "%d\n", (90000 * 60) / data->fan_max[attr->index]);
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *d=
evattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (data->fan_min[attr->index])
+		return sprintf(buf, "%d\n", (90000 * 60) / data->fan_min[attr->index]);
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t show_fan(struct device *dev, struct device_attribute *devat=
tr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (data->fan[attr->index] && data->fan[attr->index] !=3D 65535)
+		return sprintf(buf, "%d\n", (90000 * 60) / data->fan[attr->index]);
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t show_raw(struct device *dev, struct device_attribute *devat=
tr,
+			char *buf)
+{
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	int i;
+	char *b =3D buf;
+
+	for (i =3D ADT7470_REG_BASE; i <=3D ADT7470_REG_MAX; i++)
+		b +=3D sprintf(b, "0x%X: 0x%X\n", i, data->raw[i - ADT7470_REG_BASE]);
+
+	return b - buf;
+}
+
+static ssize_t show_force_pwm_max(struct device *dev, struct device_attrib=
ute *devattr,
+			char *buf)
+{
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", data->force_pwm_max);
+}
+
+static ssize_t set_force_pwm_max(struct device *dev, struct device_attribu=
te *devattr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10);
+	u8 reg;
+
+	mutex_lock(&data->lock);
+	data->force_pwm_max =3D temp;
+	reg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+	reg &=3D ~ADT7470_FSPD_MASK;
+	reg |=3D (temp ? ADT7470_FSPD_MASK : 0);
+	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
tr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", data->pwm[attr->index]);
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *devatt=
r,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->lock);
+	data->pwm[attr->index] =3D temp;
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_max(struct device *dev, struct device_attribute *d=
evattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
+}
+
+static ssize_t set_pwm_max(struct device *dev, struct device_attribute *de=
vattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->lock);
+	data->pwm_max[attr->index] =3D temp;
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index), temp);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_min(struct device *dev, struct device_attribute *d=
evattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
+}
+
+static ssize_t set_pwm_min(struct device *dev, struct device_attribute *de=
vattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->lock);
+	data->pwm_min[attr->index] =3D temp;
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index), temp);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_tmax(struct device *dev, struct device_attribute *=
devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
+}
+
+static ssize_t show_pwm_tmin(struct device *dev, struct device_attribute *=
devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
+}
+
+static ssize_t set_pwm_tmin(struct device *dev, struct device_attribute *d=
evattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10) / 1000;
+
+	mutex_lock(&data->lock);
+	data->pwm_tmin[attr->index] =3D temp;
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index), temp=
);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto(struct device *dev, struct device_attribute *=
devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
+}
+
+static ssize_t set_pwm_auto(struct device *dev, struct device_attribute *d=
evattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10);
+	int pwm_auto_reg =3D ADT7470_REG_PWM_CFG_BASE + (attr->index / 2);
+	int pwm_auto_reg_mask =3D ADT7470_PWM1_AUTO_MASK;
+	u8 reg;
+
+	if (!(attr->index % 2))
+		pwm_auto_reg_mask <<=3D 1;
+
+	if (temp !=3D 2 && temp !=3D 1)
+		return -EINVAL;
+	temp--;
+
+	mutex_lock(&data->lock);
+	data->pwm_automatic[attr->index] =3D temp;
+	reg =3D i2c_smbus_read_byte_data(client, pwm_auto_reg);
+	reg &=3D ~pwm_auto_reg_mask;
+	reg |=3D (temp ? pwm_auto_reg_mask : 0);
+	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_temp(struct device *dev, struct device_attrib=
ute *devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct adt7470_data *data =3D adt7470_update_device(dev);
+	u8 ctrl =3D data->pwm_auto_temp[attr->index];
+
+	if (ctrl)
+		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
+	else
+		return sprintf(buf, "%d\n", ADT7470_PWM_ALL_TEMPS);
+}
+
+static int cvt_auto_temp(int input)
+{
+	if (input =3D=3D ADT7470_PWM_ALL_TEMPS)
+		return 0;
+	if (input < 1 || !power_of_2(input))
+		return -EINVAL;
+	return ilog2(input) + 1;
+}
+
+static ssize_t set_pwm_auto_temp(struct device *dev, struct device_attribu=
te *devattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int temp =3D cvt_auto_temp(simple_strtol(buf, NULL, 10));
+	int pwm_auto_reg =3D ADT7470_REG_PWM_AUTO_TEMP_BASE + (attr->index / 2);
+	u8 reg;
+
+	if (temp < 0)
+		return temp;
+
+	mutex_lock(&data->lock);
+	data->pwm_automatic[attr->index] =3D temp;
+	reg =3D i2c_smbus_read_byte_data(client, pwm_auto_reg);
+
+	if (!(attr->index % 2)) {
+		reg &=3D 0xF;
+		reg |=3D (temp << 4) & 0xF0;
+	} else {
+		reg &=3D 0xF0;
+		reg |=3D temp & 0xF;
+	}
+
+	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL, 0);
+static SENSOR_DEVICE_ATTR(alarm_mask, S_IRUGO, show_alarms, NULL, 1);
+
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 2);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 3);
+static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 4);
+static SENSOR_DEVICE_ATTR(temp6_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 5);
+static SENSOR_DEVICE_ATTR(temp7_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 6);
+static SENSOR_DEVICE_ATTR(temp8_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 7);
+static SENSOR_DEVICE_ATTR(temp9_max, S_IWUSR | S_IRUGO, show_temp_max, set=
_temp_max, 8);
+static SENSOR_DEVICE_ATTR(temp10_max, S_IWUSR | S_IRUGO, show_temp_max, se=
t_temp_max, 9);
+
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 2);
+static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 3);
+static SENSOR_DEVICE_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 4);
+static SENSOR_DEVICE_ATTR(temp6_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 5);
+static SENSOR_DEVICE_ATTR(temp7_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 6);
+static SENSOR_DEVICE_ATTR(temp8_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 7);
+static SENSOR_DEVICE_ATTR(temp9_min, S_IWUSR | S_IRUGO, show_temp_min, set=
_temp_min, 8);
+static SENSOR_DEVICE_ATTR(temp10_min, S_IWUSR | S_IRUGO, show_temp_min, se=
t_temp_min, 9);
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp9_input, S_IRUGO, show_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 9);
+
+static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, show_fan_max, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_max, S_IRUGO, show_fan_max, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_max, S_IRUGO, show_fan_max, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_max, S_IRUGO, show_fan_max, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, show_fan_min, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO, show_fan_min, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO, show_fan_min, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_min, S_IRUGO, show_fan_min, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(raw_input, S_IRUGO, show_raw, NULL, 0);
+static SENSOR_DEVICE_ATTR(force_pwm_max, S_IWUSR | S_IRUGO, show_force_pwm=
_max, set_force_pwm_max, 0);
+
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pw=
m_min, set_pwm_min, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pw=
m_min, set_pwm_min, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pw=
m_min, set_pwm_min, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pw=
m_min, set_pwm_min, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pw=
m_max, set_pwm_max, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pw=
m_max, set_pwm_max, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pw=
m_max, set_pwm_max, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pw=
m_max, set_pwm_max, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO, show_p=
wm_tmin, set_pwm_tmin, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO, show_p=
wm_tmin, set_pwm_tmin, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO, show_p=
wm_tmin, set_pwm_tmin, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO, show_p=
wm_tmin, set_pwm_tmin, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax, N=
ULL, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax, N=
ULL, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax, N=
ULL, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax, N=
ULL, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto, s=
et_pwm_auto, 0);
+static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto, s=
et_pwm_auto, 1);
+static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto, s=
et_pwm_auto, 2);
+static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto, s=
et_pwm_auto, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO, show=
_pwm_auto_temp, set_pwm_auto_temp, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO, show=
_pwm_auto_temp, set_pwm_auto_temp, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO, show=
_pwm_auto_temp, set_pwm_auto_temp, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO, show=
_pwm_auto_temp, set_pwm_auto_temp, 3);
+
+static int adt7470_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, adt7470_detect);
+}
+
+static struct attribute *adt7470_attributes[] =3D {
+	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
+	&sensor_dev_attr_alarms.dev_attr.attr,
+	&sensor_dev_attr_alarm_mask.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp5_max.dev_attr.attr,
+	&sensor_dev_attr_temp6_max.dev_attr.attr,
+	&sensor_dev_attr_temp7_max.dev_attr.attr,
+	&sensor_dev_attr_temp8_max.dev_attr.attr,
+	&sensor_dev_attr_temp9_max.dev_attr.attr,
+	&sensor_dev_attr_temp10_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp4_min.dev_attr.attr,
+	&sensor_dev_attr_temp5_min.dev_attr.attr,
+	&sensor_dev_attr_temp6_min.dev_attr.attr,
+	&sensor_dev_attr_temp7_min.dev_attr.attr,
+	&sensor_dev_attr_temp8_min.dev_attr.attr,
+	&sensor_dev_attr_temp9_min.dev_attr.attr,
+	&sensor_dev_attr_temp10_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	&sensor_dev_attr_temp7_input.dev_attr.attr,
+	&sensor_dev_attr_temp8_input.dev_attr.attr,
+	&sensor_dev_attr_temp9_input.dev_attr.attr,
+	&sensor_dev_attr_temp10_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_max.dev_attr.attr,
+	&sensor_dev_attr_fan2_max.dev_attr.attr,
+	&sensor_dev_attr_fan3_max.dev_attr.attr,
+	&sensor_dev_attr_fan4_max.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_raw_input.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_channels_temp.dev_attr.attr,
+	NULL
+};
+
+static int adt7470_detect(struct i2c_adapter *adapter, int address, int ki=
nd)
+{
+	struct i2c_client *client;
+	struct adt7470_data *data;
+	int err =3D 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		goto exit;
+
+	if (!(data =3D kzalloc(sizeof(struct adt7470_data), GFP_KERNEL))) {
+		err =3D -ENOMEM;
+		goto exit;
+	}
+
+	client =3D &data->client;
+	client->addr =3D address;
+	client->adapter =3D adapter;
+	client->driver =3D &adt7470_driver;
+
+	i2c_set_clientdata(client, data);
+
+	mutex_init(&data->lock);
+
+	if (kind <=3D 0) {
+		int vendor, device, revision;
+
+		vendor =3D i2c_smbus_read_byte_data(client, ADT7470_REG_VENDOR);
+		if (vendor !=3D ADT7470_VENDOR) {
+			printk(KERN_ERR "%s: vendor=3D%x\n", __FUNCTION__, vendor);
+			err =3D -ENODEV;
+			goto exit_free;
+		}
+
+		device =3D i2c_smbus_read_byte_data(client, ADT7470_REG_DEVICE);
+		if (device !=3D ADT7470_DEVICE) {
+			printk(KERN_ERR "%s: device=3D%x\n", __FUNCTION__, device);
+			err =3D -ENODEV;
+			goto exit_free;
+		}
+
+		revision =3D i2c_smbus_read_byte_data(client, ADT7470_REG_REVISION);
+		if (revision !=3D ADT7470_REVISION) {
+			printk(KERN_ERR "%s: revision=3D%x\n", __FUNCTION__, revision);
+			err =3D -ENODEV;
+			goto exit_free;
+		}
+
+		data->type =3D adt7470;
+	} else {
+		dev_dbg(&adapter->dev, "detection forced\n");
+	}
+
+	if (kind > 0)
+		data->type =3D kind;
+
+	data->attrs.attrs =3D adt7470_attributes;
+	strlcpy(client->name, "adt7470", I2C_NAME_SIZE);
+
+	if ((err =3D i2c_attach_client(client)))
+		goto exit_free;
+
+	dev_info(&client->dev, "%s chip found\n", client->name);
+
+	/* Initialize the ADT7470 chip */
+	adt7470_init_client(client);
+
+	/* Register sysfs hooks */
+	if ((err =3D sysfs_create_group(&client->dev.kobj, &data->attrs)))
+		goto exit_detach;
+
+	data->class_dev =3D hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err =3D PTR_ERR(data->class_dev);
+		goto exit_remove;
+	}
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &data->attrs);
+exit_detach:
+	i2c_detach_client(client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int adt7470_detach_client(struct i2c_client *client)
+{
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &data->attrs);
+	i2c_detach_client(client);
+	kfree(data);
+	return 0;
+}
+
+static int __init adt7470_init(void)
+{
+	return i2c_add_driver(&adt7470_driver);
+}
+
+static void __exit adt7470_exit(void)
+{
+	i2c_del_driver(&adt7470_driver);
+}
+
+MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_DESCRIPTION("ADT7470 driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(adt7470_init);
+module_exit(adt7470_exit);

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGjrAQa6vRYYgWQuURAh+JAJ9W4+eDFFlC2srU+p5NhD4XeeLZlACfdurC
3aKV5t1X8YLNdQTOW6TTifA=
=NK7f
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--


--===============5843283103941329184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5843283103941329184==--
