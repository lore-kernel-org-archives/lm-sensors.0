From: Jordan Crouse <jordan.crouse@amd.com>
Date: Mon, 15 Sep 2008 20:27:07 +0000
Subject: Re: [lm-sensors] hwmon: Add a driver for the ADT7475 thermal sensor
Message-Id: <20080915202707.GA10659@cosmic.amd.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
List-Id: <lm-sensors.vger.kernel.org>
References: <20080908174853.GG24308@cosmic.amd.com>
In-Reply-To: <20080908174853.GG24308@cosmic.amd.com>
To: lm-sensors@vger.kernel.org

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14/09/08 19:50 +0200, Hans de Goede wrote:
> >   CC [M]  drivers/hwmon/adt7475.o
> > drivers/hwmon/adt7475.c: In function =E2=80=98adt7475_update_device=E2=
=80=99:
> > drivers/hwmon/adt7475.c:1043: warning: array subscript is above array b=
ounds
> >=20
>=20
> <snip>
>=20
> > Apparently struct adt7475_data should be changed from
> > 	s16 temp[6][3];
> > to
> > 	s16 temp[7][3];
> >=20
>=20
> Looking closer at the code: you are completely right
>=20
> Also while looking closer:
>=20
> This snippet in adt7475_update_device() :
>=20
>          data->temp[HYSTERSIS][0] =3D (u16) adt7475_read(REG_REMOTE1_HYST=
ERSIS);
>          data->temp[HYSTERSIS][1] =3D (u16) adt7475_read(REG_REMOTE1_HYST=
ERSIS);
>          data->temp[HYSTERSIS][2] =3D (u16) adt7475_read(REG_REMOTE2_HYST=
ERSIS);
>=20
> Should be rewritten to:
>          data->temp[HYSTERSIS][0] =3D (u16) adt7475_read(REG_REMOTE1_HYST=
ERSIS);
>          data->temp[HYSTERSIS][1] =3D data->temp[HYSTERSIS][0];
>          data->temp[HYSTERSIS][2] =3D (u16) adt7475_read(REG_REMOTE2_HYST=
ERSIS);
>=20
> To avoid 1 (slow) unnecessary i2c transaction.

With much egg on my face, here is an updated patch.  Compiles clean
with gcc 4.2.3.  Updated the index and removed the redundant smbus read.

Jordan

--=20
Jordan Crouse
Systems Software Development Engineer=20
Advanced Micro Devices, Inc.

--yrj/dFKFPuw6o+aM
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: inline; filename="adt7475.patch"

[PATCH] hwmon:  Add a driver for the ADT7475 thermal sensor

From: Jordan Crouse <jordan.crouse@amd.com>

HWMON driver for the ADT7475 thermal sensor.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 Documentation/hwmon/adt7475 |   90 +++
 drivers/hwmon/Kconfig       |   10 
 drivers/hwmon/Makefile      |    2 
 drivers/hwmon/adt7475.c     | 1140 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1242 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/adt7475 b/Documentation/hwmon/adt7475
new file mode 100644
index 0000000..ec760c8
--- /dev/null
+++ b/Documentation/hwmon/adt7475
@@ -0,0 +1,90 @@
+This describes the interface for the ADT7475 driver:
+
+(there are 4 fans, numbered fan1 to fan4):
+
+fanX_input              Read the current speed of the fan (in RPMs)
+fanX_min                Read/write the minimum speed of the fan.  Dropping
+	   		below this sets an alarm.
+
+(there are three PWMs, numbered pwm1 to pwm3):
+
+pwmX                    Read/write the current duty cycle of the PWM.  Writes
+     			only have effect when auto mode is turned off (see
+			below).  Range is 0 - 255.
+
+pwmX_enable             Fan speed control method:
+
+		        0 - No control (fan at full speed)
+			1 - Manual fan speed control (using pwm[1-*])
+			2 - Automatic fan speed control
+
+pwmX_auto_channels_temp	Select which channels affect this PWM
+			
+			1 - TEMP1 controls PWM
+			2 - TEMP2 controls PWM
+			4 - TEMP3 controls PWM
+			6 - TEMP2 and TEMP3 control PWM
+			7 - All three inputs control PWM
+
+pwmX_freq               Read/write the PWM frequency in Hz. The number
+			should be one of the following:
+
+		        11 Hz
+		        14 Hz
+		        22 Hz
+		        29 Hz
+		        35 Hz
+		        44 Hz
+		        58 Hz
+		        88 Hz
+
+pwmX_max                Read/write the maximum PWM duty cycle.  The PWM
+                        duty cycle will never exceed this.
+
+pwmX_min                Read/write the minimum PWM duty cycle in automatic mode
+
+(there are three temperature settings numbered temp1 to temp3):
+
+tempX_input             Read the current temperature.  The value is in milli
+			degrees of Celsius.
+
+tempX_max               Read/write the upper temperature limit - exceeding this
+	                will cause an alarm.
+
+tempX_min               Read/write the lower temperature limit - exceeding this
+                        will cause an alarm.
+
+tempX_offset            Read/write the temperature adjustment offset
+
+tempX_crit              Read/write the THERM limit for remote1.  Exceeding this
+                        causes the chip to force the processor off.
+
+tempX_auto_point1_temp 	Read/write the minimum temperature where the fans will
+                        turn on in automatic mode.
+
+tempX_auto_point2_temp  Read/write the maximum temperature over which the fans
+			will run in automatic mode.  tempX_auto_point1_temp
+			and tempX_auto_point2_temp together define the
+			range of automatic control.
+
+tempX_crit_hyst 	set the temperature value below crit where the
+                        fans will stay on - this helps drive the temperature
+                        low enough so it doesn't stay near the edge and
+                        cause THERM to keep tripping.
+
+tempX_alarm		Read a 1 if the max/min alarm is set
+tempX_crit_alarm	Read a 1 if the critical limit is exceeded
+tempX_fault		Read a 1 if either temp1 or temp3 diode has a fault
+
+(There are two voltage settings, in1 and in2):
+
+inX_input               Read the current voltage on VCC.  Value is in
+			millivolts.
+
+inX_min                 read/write the minimum voltage limit.
+			Dropping below this causes an alarm.
+
+inX_max   		read/write the maximum voltage limit.
+			Exceeding this causes an alarm.
+
+inX_alarm		Read a 1 if the max/min alarm is set.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d402e8d..8a1baf5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -179,6 +179,16 @@ config SENSORS_ADT7473
 	  This driver can also be built as a module. If so, the module
 	  will be called adt7473.
 
+config SENSORS_ADT7475
+	tristate "Analog Devices ADT7475"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  ADT7475 temperature monitoring chips.
+
+	  This driver can also be build as a module.  If so, the module
+	  will be called adt7475.
+
 config SENSORS_K8TEMP
 	tristate "AMD Athlon64/FX or Opteron temperature sensor"
 	depends on X86 && PCI && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 950134a..424094c 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
 obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7473)	+= adt7473.o
+obj-$(CONFIG_SENSORS_ADT7475)   += adt7475.o
+
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+= ams/
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
new file mode 100644
index 0000000..e3ccc18
--- /dev/null
+++ b/drivers/hwmon/adt7475.c
@@ -0,0 +1,1140 @@
+/*
+ * adt7475 - Thermal sensor driver for the ADT7475 chip and derivatives
+ * Copyright (C) 2007-2008, Advanced Micro Devices, Inc.
+ *
+ * Derived from the lm83 driver by Jean Delvare
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+
+/* Indexes for the sysfs hooks */
+
+#define INPUT     0
+#define MIN       1
+#define MAX       2
+#define CONTROL   3
+#define OFFSET    3
+#define AUTOMIN   4
+#define FREQ      4
+#define THERM     5
+#define HYSTERSIS 6
+#define RANGE     7
+#define ALARM     9
+#define CRIT_ALARM 10
+#define FAULT      11
+
+
+/* 7475 Common Registers */
+
+#define REG_VOLTAGE_BASE        0x21
+#define REG_TEMP_BASE           0x25
+#define REG_TACH_BASE		0x28
+#define REG_PWM_BASE            0x30
+#define REG_PWM_MAX_BASE        0x38
+
+#define REG_DEVID               0x3D
+#define REG_VENDID              0x3E
+
+#define REG_CONFIG1             0x40
+#define REG_STATUS1             0x41
+#define REG_STATUS2             0x42
+
+/* Not all the alarm bits are enabled - mask the ones we don't use */
+#define ALARM_MASK              0xFE76
+
+#define REG_VOLTAGE_MIN_BASE    0x46
+#define REG_VOLTAGE_MAX_BASE    0x47
+
+#define REG_TEMP_MIN_BASE       0x4E
+#define REG_TEMP_MAX_BASE	0x4F
+
+#define REG_TACH_MIN_BASE	0x54
+
+#define REG_PWM_CONFIG_BASE     0x5C
+
+#define REG_TEMP_TRANGE_BASE    0x5F
+
+#define REG_ACOUSTICS1          0x62
+#define REG_ACOUSTICS2          0x63
+
+#define REG_PWM_MIN_BASE        0x64
+
+#define REG_TEMP_TMIN_BASE      0x67
+#define REG_TEMP_THERM_BASE     0x6A
+
+#define REG_REMOTE1_HYSTERSIS   0x6D
+#define REG_REMOTE2_HYSTERSIS   0x6E
+
+#define REG_TEMP_OFFSET_BASE    0x70
+
+#define REG_CONFIG2             0x73
+#define REG_INTERRUPT_MASK1     0x74
+#define REG_INTERRUPT_MASK2     0x75
+#define REG_EXTEND1             0x76
+#define REG_EXTEND2             0x77
+#define REG_CONFIG3             0x78
+#define REG_THERM_TIMER_STATUS  0x79
+#define REG_THERM_TIMER_LIMIT   0x7A
+#define REG_TACH_PULSES         0x7B
+#define REG_CONFIG5             0x7C
+
+#define CONFIG5_TWOSCOMP        0x01
+#define CONFIG5_TEMPOFFSET      0x02
+
+#define REG_CONFIG4             0x7D
+
+/* ADT7475 Settings */
+
+#define ADT7475_VOLTAGE_COUNT   2
+#define ADT7475_TEMP_COUNT      3
+#define ADT7475_TACH_COUNT	4
+#define ADT7475_PWM_COUNT       3
+
+/* 7475 specific registers */
+
+#define REG_CONFIG6             0x10
+#define REG_CONFIG7             0x11
+
+
+/* Macro to read the registers */
+
+#define adt7475_read(reg) i2c_smbus_read_byte_data(client, (reg))
+
+/* Macros to easily index the registers */
+
+#define TACH_REG(idx) (REG_TACH_BASE + ((idx) * 2))
+#define TACH_MIN_REG(idx) (REG_TACH_MIN_BASE + ((idx) * 2))
+
+#define PWM_REG(idx) (REG_PWM_BASE + (idx))
+#define PWM_MAX_REG(idx) (REG_PWM_MAX_BASE + (idx))
+#define PWM_MIN_REG(idx) (REG_PWM_MIN_BASE + (idx))
+#define PWM_CONFIG_REG(idx) (REG_PWM_CONFIG_BASE + (idx))
+
+#define VOLTAGE_REG(idx) (REG_VOLTAGE_BASE + (idx))
+#define VOLTAGE_MIN_REG(idx) (REG_VOLTAGE_MIN_BASE + ((idx) * 2))
+#define VOLTAGE_MAX_REG(idx) (REG_VOLTAGE_MAX_BASE + ((idx) * 2))
+
+#define TEMP_REG(idx) (REG_TEMP_BASE + (idx))
+#define TEMP_MIN_REG(idx) (REG_TEMP_MIN_BASE + ((idx) * 2))
+#define TEMP_MAX_REG(idx) (REG_TEMP_MAX_BASE + ((idx) * 2))
+#define TEMP_TMIN_REG(idx) (REG_TEMP_TMIN_BASE + (idx))
+#define TEMP_THERM_REG(idx) (REG_TEMP_THERM_BASE + (idx))
+#define TEMP_OFFSET_REG(idx) (REG_TEMP_OFFSET_BASE + (idx))
+#define TEMP_TRANGE_REG(idx) (REG_TEMP_TRANGE_BASE + (idx))
+
+/* Convert the tach reading into RPMs */
+
+#define TACH2RPM(val) ((90000 * 60) / (val))
+#define RPM2TACH(val) ((90000 * 60) / (val))
+
+/* Convert the voltage registers into mW */
+
+#define REG2VCC(val) ((42 * (int)(val)) / 10)
+#define REG2VCCP(val) ((293 * (int)(val)) / 100)
+
+#define VCC2REG(val)  (((val) * 10) / 42)
+#define VCCP2REG(val) (((val) * 100) / 293)
+
+/* 2's complement temp conversion - this is used when CONFIG5 bit 0 is set */
+
+#define REG2TEMP(val) ((((val) >> 2) * 1000) + (((val) & 3) * 250))
+
+#define TEMP2REG(val) ((val) <= -128000 ? -128 : \
+	(val) >= 127000 ? 127 : \
+	(val) < 0 ? ((val) - 500) / 1000 : \
+	((val) + 500) / 1000)
+
+
+/* Offset 64 temp conversion - this is used when CONFIG5 bit 0 is clear */
+
+#define OFF64_REG2TEMP(val) (((((val) >> 2) - 64) * 1000) + (((val) & 3) * 250))
+#define OFF64_TEMP2REG(val) ((((val) + 64500) / 1000) << 2)
+
+#define CONV2TEMP(_v) \
+((data->temptype & CONFIG5_TWOSCOMP) ? REG2TEMP(_v) : OFF64_REG2TEMP(_v))
+
+static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD_1(adt7475);
+
+struct adt7475_data {
+	struct i2c_client client;
+	struct device *hwmon_dev;
+	struct mutex lock;
+
+	int type;
+	char temptype;
+
+	char valid;
+	unsigned long updated;
+
+	u16 alarms;
+	u16 voltage[3][3];
+	s16 temp[7][3];
+	u16 tach[2][4];
+	u8  pwm[4][3];
+	u8  range[3];
+	u8 pwmctl[3];
+	u8 pwmchan[3];
+};
+
+static struct i2c_driver adt7475_driver;
+static struct adt7475_data *adt7475_update_device(struct device *dev);
+
+static u16 adt7475_read_word(struct i2c_client *client, int reg)
+{
+	u16 val;
+
+	val = i2c_smbus_read_byte_data(client, reg);
+	val |= (i2c_smbus_read_byte_data(client, reg + 1) << 8);
+
+	return val;
+}
+
+static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)
+{
+	i2c_smbus_write_byte_data(client, reg + 1, val >> 8);
+	i2c_smbus_write_byte_data(client, reg, val & 0xFF);
+}
+
+/* Find the nearest value in a table - used for pwm frequency and
+   auto temp range
+*/
+
+static int find_nearest(int val, int *array, int size)
+{
+	int i;
+
+	if (val < array[0])
+		return 0;
+
+	if (val > array[size - 1])
+		return array[size - 1];
+
+	for (i = 0; i < size - 1; i++) {
+		int a, b;
+
+		if (val > array[i + 1])
+			continue;
+
+		a = val - array[i];
+		b = array[i + 1] - val;
+
+		return (a >= b) ? i : i + 1;
+	}
+
+	return 0;
+}
+
+static ssize_t show_voltage(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	unsigned short val = data->voltage[sattr->nr][sattr->index];
+
+	switch (sattr->nr) {
+	case ALARM:
+		return sprintf(buf, "%d\n",
+			(data->alarms >> (sattr->index + 1)) & 1);
+	default:
+		return sprintf(buf, "%d\n",
+			sattr->index == 0 ? REG2VCCP(val) : REG2VCC(val));
+	}
+}
+
+static ssize_t set_voltage(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count) {
+
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	unsigned char reg;
+
+	mutex_lock(&data->lock);
+
+	data->voltage[sattr->nr][sattr->index] =
+		sattr->index ? VCC2REG(val) : VCCP2REG(val);
+
+	if (sattr->nr == MIN)
+		reg = VOLTAGE_MIN_REG(sattr->index);
+	else
+		reg = VOLTAGE_MAX_REG(sattr->index);
+
+	i2c_smbus_write_byte_data(client, reg,
+		(u8) (data->voltage[sattr->nr][sattr->index] >> 2));
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	unsigned short val = data->temp[sattr->nr][sattr->index];
+	int ret = 0;
+	int out;
+
+	switch (sattr->nr) {
+	case HYSTERSIS:
+		if (sattr->index != 1)
+			out = (val >> 4) & 0xF;
+		else
+			out = (val & 0xF);
+
+		/* Show the value as an absolute number tied to
+		 * THERM */
+		ret = sprintf(buf, "%d\n",
+			CONV2TEMP(data->temp[THERM][sattr->index])
+			- (out * 1000));
+		break;
+
+	case OFFSET:
+		/* Offset is always 2's complement, regardless of the
+		 * setting in CONFIG5 */
+
+		if (data->temptype & CONFIG5_TEMPOFFSET)
+			ret = sprintf(buf, "%d\n", (s8) val);
+		else
+			ret = sprintf(buf, "%d\n", ((s8)val) >> 1);
+		break;
+
+	case ALARM:
+		ret = sprintf(buf, "%d\n",
+			(data->alarms >> (sattr->index + 4))  & 1);
+		break;
+
+	case CRIT_ALARM:
+		ret = sprintf(buf, "%d\n",
+			((data->alarms & 0x200) ? 1 : 0));
+		break;
+
+	case FAULT:
+		/* Note - only for remote1 and remote2 */
+
+		ret = sprintf(buf, "%d\n",
+			(data->alarms & (sattr->index ? 0x4000 : 0x8000)));
+		break;
+
+	default:
+		/* All other temp values are in the configured format */
+
+		ret = sprintf(buf, "%d\n", CONV2TEMP(val));
+	}
+
+	return ret;
+}
+
+static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	unsigned char reg = 0;
+	u8 out;
+	int l;
+
+	mutex_lock(&data->lock);
+
+	switch (sattr->nr) {
+	case OFFSET:
+		l = val;
+
+		if (data->temptype & CONFIG5_TEMPOFFSET) {
+			if (l > 127)
+				l = 127;
+			else if (l < -127)
+				l = -126;
+		} else {
+			if (l > 64)
+				l = 64;
+			else if (l < -63)
+				l = -63;
+
+			l <<= 1;
+		}
+
+		out = data->temp[OFFSET][sattr->index] = (u8) l;
+		break;
+
+	case HYSTERSIS:
+		/* The value will be given as an absolute value, turn it
+		   into an offset based on THERM */
+
+		val = CONV2TEMP(data->temp[THERM][sattr->index]) - val;
+
+		if (sattr->index != 1) {
+			data->temp[HYSTERSIS][sattr->index] &= 0xF0;
+			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4;
+		} else {
+			data->temp[HYSTERSIS][sattr->index] &= 0x0F;
+			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF);
+		}
+
+		out = data->temp[HYSTERSIS][sattr->index];
+		break;
+
+	default:
+		data->temp[sattr->nr][sattr->index] =
+			(data->temptype & CONFIG5_TWOSCOMP) ?
+			TEMP2REG(val) : OFF64_TEMP2REG(val);
+
+		/* We maintain an extra 2 digits of precision for simplicity
+		 * - shift those back off before writing the value */
+
+		out = (u8) (data->temp[sattr->nr][sattr->index] >> 2);
+	}
+
+	switch (sattr->nr) {
+	case MIN:
+		reg = TEMP_MIN_REG(sattr->index);
+		break;
+	case MAX:
+		reg = TEMP_MAX_REG(sattr->index);
+		break;
+	case OFFSET:
+		reg = TEMP_OFFSET_REG(sattr->index);
+		break;
+	case AUTOMIN:
+		reg = TEMP_TMIN_REG(sattr->index);
+		break;
+	case THERM:
+		reg = TEMP_THERM_REG(sattr->index);
+		break;
+	case HYSTERSIS:
+		if (sattr->index != 2)
+			reg = REG_REMOTE1_HYSTERSIS;
+		else
+			reg = REG_REMOTE2_HYSTERSIS;
+
+		break;
+	}
+
+	i2c_smbus_write_byte_data(client, reg, out);
+
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+/* Table of autorange values - the user will write the value in millidegrees,
+   and we'll convert it */
+
+static const int autorange_table[] = {
+	2000,  2500,   3330,  4000,  5000,  6670,  8000,
+	10000, 13330, 16000, 20000, 26670, 32000, 40000,
+	53330, 80000 };
+
+static ssize_t show_point2(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	int out = (data->range[sattr->index] >> 4) & 0x0F;
+
+	int val = CONV2TEMP(data->temp[AUTOMIN][sattr->index]);
+	return sprintf(buf, "%d\n", val + autorange_table[out]);
+}
+
+static ssize_t set_point2(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	long val = simple_strtol(buf, NULL, 10);
+	int out;
+
+	/* The user will write an absolute value, so subtract the start point
+	   to figure the range */
+
+	val -= CONV2TEMP(data->temp[AUTOMIN][sattr->index]);
+
+	mutex_lock(&data->lock);
+
+	/* Find the nearest table entry to what the user wrote */
+
+	out = find_nearest(val, (int *) autorange_table, 0x10);
+
+	data->range[sattr->index] &= ~0xF0;
+	data->range[sattr->index] |= (out & 0xF) << 4;
+
+	i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(sattr->index),
+				  data->range[sattr->index]);
+
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static ssize_t show_tach(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+
+	/* 0xFFFF means the period was invalid */
+
+	switch (sattr->nr) {
+	case ALARM:
+		return sprintf(buf, "%d\n",
+			(data->alarms >> (sattr->index + 10) & 1));
+	default:
+	if (data->tach[sattr->nr][sattr->index] == 0xFFFF)
+		return sprintf(buf, "0\n");
+	else
+		return sprintf(buf, "%d\n",
+		       TACH2RPM(data->tach[sattr->nr][sattr->index]));
+	}
+}
+
+static ssize_t set_tach(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->lock);
+
+	data->tach[MIN][sattr->index] = (u16) RPM2TACH(val);
+
+	adt7475_write_word(client, TACH_MIN_REG(sattr->index),
+			   data->tach[MIN][sattr->index]);
+
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	return sprintf(buf, "%d\n", data->pwm[sattr->nr][sattr->index]);
+}
+
+static ssize_t show_pwmchan(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	return sprintf(buf, "%d\n",
+		data->pwmchan[sattr->index]);
+}
+
+static ssize_t show_pwmctrl(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	return sprintf(buf, "%d\n",
+		data->pwmctl[sattr->index]);
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+
+	long val = simple_strtol(buf, NULL, 10);
+
+	unsigned char reg = 0;
+
+	mutex_lock(&data->lock);
+
+	data->pwm[sattr->nr][sattr->index] = (u8) val;
+
+	switch (sattr->nr) {
+	case INPUT:
+		/* If we are not in manual mode, then we shouldn't allow
+		 * the user to set the pwm speed */
+
+		if (((data->pwm[CONTROL][sattr->index] >> 5) & 7) != 7)
+			return 0;
+
+		reg = PWM_REG(sattr->index);
+		break;
+
+	case MIN:
+		reg = PWM_MIN_REG(sattr->index);
+		break;
+
+	case MAX:
+		reg = PWM_MAX_REG(sattr->index);
+		break;
+	}
+
+	i2c_smbus_write_byte_data(client, reg,
+		data->pwm[sattr->nr][sattr->index]);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+/* Called by set_pwmctrl and set_pwmchan */
+
+static void hw_set_pwm(struct i2c_client *client, int index,
+			struct adt7475_data *data)
+{
+	long val = 0;
+
+	switch (data->pwmctl[index]) {
+	case 0:
+		val = 0x03;  /* Run at full speed */
+		break;
+	case 1:
+		val = 0x07;  /* Manual mode */
+		break;
+	case 2:
+		switch (data->pwmchan[index]) {
+		case 1:
+			/* Remote1 controls PWM */
+			val = 0x00;
+			break;
+		case 2:
+			/* local controls PWM */
+			val = 0x01;
+			break;
+		case 4:
+			/* remote2 controls PWM */
+			val = 0x02;
+			break;
+		case 6:
+			/* local/remote2 control PWM */
+			val = 0x05;
+			break;
+		case 7:
+			/* All three control PWM */
+			val = 0x06;
+			break;
+		}
+		break;
+	}
+
+	data->pwm[CONTROL][index] &= ~0xE0;
+	data->pwm[CONTROL][index] |= (val & 7) << 5;
+
+	i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+				  data->pwm[CONTROL][index]);
+}
+
+static ssize_t set_pwmchan(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+
+	long val = simple_strtol(buf, NULL, 10);
+
+	if (val > 7)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->pwmctl[sattr->index] = val;
+	hw_set_pwm(client, sattr->index, data);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t set_pwmctrl(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+
+	long val = simple_strtol(buf, NULL, 10);
+
+	if (val > 2)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->pwmctl[sattr->index] = val;
+	hw_set_pwm(client, sattr->index, data);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+/* List of frequencies for the PWM */
+
+static const int pwmfreq_table[] = {
+	11, 14, 22, 29, 35, 44, 58, 88
+};
+
+static ssize_t show_pwmfreq(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	return sprintf(buf, "%d\n",
+		pwmfreq_table[data->range[sattr->index] & 3]);
+}
+
+static ssize_t set_pwmfreq(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+
+	long val = simple_strtol(buf, NULL, 10);
+	int out;
+
+	out = find_nearest(val, (int *) pwmfreq_table, 8);
+
+	mutex_lock(&data->lock);
+
+	data->range[sattr->index] &= ~3;
+	data->range[sattr->index] |= out & 0x03;
+
+	i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(sattr->index),
+				  data->range[sattr->index]);
+
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_voltage, set_voltage, MAX, 0);
+static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGO | S_IWUSR, show_voltage, set_voltage, MIN, 0);
+static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, show_voltage, NULL, ALARM, 0);
+static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_voltage, NULL, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_voltage, set_voltage, MAX, 1);
+static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_voltage, set_voltage, MIN, 1);
+static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_voltage, NULL, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_alarm, S_IRUGO, show_temp, NULL, ALARM, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, show_temp, NULL, CRIT_ALARM, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_temp, NULL, FAULT, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp, MAX, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp, set_temp, MIN, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGO | S_IWUSR, show_temp, set_temp, OFFSET, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_auto_point1_temp, S_IRUGO | S_IWUSR, show_temp, set_temp, AUTOMIN, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_auto_point2_temp, S_IRUGO | S_IWUSR, show_point2, set_point2, 0, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, set_temp, THERM, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_crit_hyst, S_IRUGO | S_IWUSR, show_temp, set_temp, HYSTERSIS, 0);
+static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_alarm, S_IRUGO, show_temp, NULL, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_temp, NULL, CRIT_ALARM, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp, MAX, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp, set_temp, MIN, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGO | S_IWUSR, show_temp, set_temp, OFFSET, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_auto_point1_temp, S_IRUGO | S_IWUSR, show_temp, set_temp, AUTOMIN, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_auto_point2_temp, S_IRUGO | S_IWUSR, show_point2, set_point2, 0, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, set_temp, THERM, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_crit_hyst, S_IRUGO | S_IWUSR, show_temp, set_temp, HYSTERSIS, 1);
+static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_alarm, S_IRUGO, show_temp, NULL, ALARM, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO, show_temp, NULL, CRIT_ALARM, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_temp, NULL, FAULT, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp, MAX, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp, set_temp, MIN, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGO | S_IWUSR, show_temp, set_temp, OFFSET, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_auto_point1_temp, S_IRUGO | S_IWUSR, show_temp, set_temp, AUTOMIN, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_auto_point2_temp, S_IRUGO | S_IWUSR, show_point2, set_point2, 0, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, set_temp, THERM, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_crit_hyst, S_IRUGO | S_IWUSR, show_temp, set_temp, HYSTERSIS, 2);
+static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_tach, NULL, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_tach, set_tach, MIN, 0);
+static SENSOR_DEVICE_ATTR_2(fan1_alarm, S_IRUGO, show_tach, NULL, ALARM, 0);
+static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_tach, NULL, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_tach, set_tach, MIN, 1);
+static SENSOR_DEVICE_ATTR_2(fan2_alarm, S_IRUGO, show_tach, NULL, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2(fan3_input, S_IRUGO, show_tach, NULL, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_tach, set_tach, MIN, 2);
+static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_tach, NULL, ALARM, 2);
+static SENSOR_DEVICE_ATTR_2(fan4_input, S_IRUGO, show_tach, NULL, INPUT, 3);
+static SENSOR_DEVICE_ATTR_2(fan4_min, S_IRUGO | S_IWUSR, show_tach, set_tach, MIN, 3);
+static SENSOR_DEVICE_ATTR_2(fan4_alarm, S_IRUGO, show_tach, NULL, ALARM, 3);
+static SENSOR_DEVICE_ATTR_2(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_freq, S_IRUGO | S_IWUSR, show_pwmfreq, set_pwmfreq, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_enable, S_IRUGO | S_IWUSR, show_pwmctrl, set_pwmctrl, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_channel_temp, S_IRUGO | S_IWUSR, show_pwmchan, set_pwmchan, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_max, S_IRUGO | S_IWUSR, show_pwm, set_pwm, MAX, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_min, S_IRUGO | S_IWUSR, show_pwm, set_pwm, MIN, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_freq, S_IRUGO | S_IWUSR, show_pwmfreq, set_pwmfreq, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_enable, S_IRUGO | S_IWUSR, show_pwmctrl, set_pwmctrl, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_channel_temp, S_IRUGO | S_IWUSR, show_pwmchan, set_pwmchan, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_max, S_IRUGO | S_IWUSR, show_pwm, set_pwm, MAX, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_min, S_IRUGO | S_IWUSR, show_pwm, set_pwm, MIN, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_freq, S_IRUGO | S_IWUSR, show_pwmfreq, set_pwmfreq, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_enable, S_IRUGO | S_IWUSR, show_pwmctrl, set_pwmctrl, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_channel_temp, S_IRUGO | S_IWUSR, show_pwmchan, set_pwmchan, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_max, S_IRUGO | S_IWUSR, show_pwm, set_pwm, MAX, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_min, S_IRUGO | S_IWUSR, show_pwm, set_pwm, MIN, 2);
+
+static struct attribute *adt7475_attrs[] = {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_fault.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channel_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_max.dev_attr.attr,
+	&sensor_dev_attr_pwm1_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channel_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_max.dev_attr.attr,
+	&sensor_dev_attr_pwm2_min.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channel_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_max.dev_attr.attr,
+	&sensor_dev_attr_pwm3_min.dev_attr.attr,
+	NULL,
+};
+
+/* The list of chips we support - these index into the following structure */
+
+#define ADT7475 0
+#define ADT7475_MAX_ID 1
+
+static struct adt7475_chip {
+	const char *name;
+	struct attribute_group group;
+} adt7475_chips[ADT7475_MAX_ID] = {
+	{ .name = "adt7475",
+	  .group = {
+		  .attrs = adt7475_attrs,
+	  }
+	},
+};
+
+static int adt7475_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct adt7475_data *data;
+	unsigned char val;
+	int ret = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return 0;
+
+	/* Figure out what type of sensor is attached */
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+
+	if (data == NULL)
+		return -ENOMEM;
+
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &adt7475_driver;
+	client->flags = 0;
+
+	/* Check the company version first */
+
+	if (i2c_smbus_read_byte_data(client, REG_VENDID) != 0x41) {
+		dev_err(&adapter->dev, "This is not an adt7475 part\n");
+		goto efree;
+	}
+
+	/* Then check the part number */
+	val = i2c_smbus_read_byte_data(client, REG_DEVID);
+
+	if (val == 0x75)
+		data->type = ADT7475;
+	else {
+		dev_err(&adapter->dev,
+		"Couldn't detect a adt7475 part at 0x%02x\n", address);
+
+		goto efree;
+	}
+
+	/* Record how the temp registers are presented, either 2's complement
+	   or offset 64
+	*/
+
+	data->temptype = i2c_smbus_read_byte_data(client, REG_CONFIG5) & 3;
+
+	/* FIXME: Get the reading type */
+	/* FIXME:  Get the scale of the temprature readings */
+
+	strlcpy(client->name, adt7475_chips[data->type].name, I2C_NAME_SIZE);
+
+	data->valid = 0;
+	mutex_init(&data->lock);
+
+	ret = i2c_attach_client(client);
+
+	if (ret)
+		goto efree;
+
+	ret = sysfs_create_group(&client->dev.kobj,
+		&adt7475_chips[data->type].group);
+
+	if (ret)
+		goto edetach;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+
+	if (!IS_ERR(data->hwmon_dev))
+		return 0;
+
+	ret = PTR_ERR(data->hwmon_dev);
+
+	sysfs_remove_group(&client->dev.kobj, &adt7475_chips[data->type].group);
+ edetach:
+	i2c_detach_client(client);
+ efree:
+	kfree(data);
+	return ret;
+}
+
+static int adt7475_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+
+	return i2c_probe(adapter, &addr_data, adt7475_detect);
+}
+
+static int adt7475_detach_client(struct i2c_client *client)
+{
+	struct adt7475_data *data = i2c_get_clientdata(client);
+	int ret = 0;
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &adt7475_chips[data->type].group);
+
+	ret = i2c_detach_client(client);
+	if (!ret)
+		kfree(data);
+	return ret;
+}
+
+static struct i2c_driver adt7475_driver = {
+	.driver = {
+		.name   = "adt7475",
+	},
+	.attach_adapter = adt7475_attach_adapter,
+	.detach_client  = adt7475_detach_client,
+};
+
+static struct adt7475_data *adt7475_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+	u8 ext;
+	int i;
+
+	mutex_lock(&data->lock);
+
+	if (!time_after(jiffies, data->updated + HZ * 2) && data->valid) {
+		mutex_unlock(&data->lock);
+		return data;
+	}
+
+	data->alarms = adt7475_read(REG_STATUS2) << 8;
+	data->alarms |= adt7475_read(REG_STATUS1);
+
+	ext = adt7475_read(REG_EXTEND1);
+
+	/* Get the voltage readings */
+
+	for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++) {
+		data->voltage[INPUT][i] = (adt7475_read(VOLTAGE_REG(i)) << 2) |
+			((ext >> ((i + 1) * 2)) & 3);
+
+		/* Adjust these values so they match the input precision */
+
+		data->voltage[MIN][i] = adt7475_read(VOLTAGE_MIN_REG(i)) << 2;
+		data->voltage[MAX][i] = adt7475_read(VOLTAGE_MAX_REG(i)) << 2;
+	}
+
+	ext = adt7475_read(REG_EXTEND2);
+
+	for (i = 0; i < ADT7475_TEMP_COUNT; i++) {
+		data->temp[INPUT][i] = (adt7475_read(TEMP_REG(i)) << 2) |
+			((ext >> ((i + 1) * 2)) & 3);
+
+		/* Adjust these values so they match the input precision */
+
+		data->temp[MIN][i] = adt7475_read(TEMP_MIN_REG(i)) << 2;
+		data->temp[MAX][i] = adt7475_read(TEMP_MAX_REG(i)) << 2;
+		data->temp[AUTOMIN][i] = adt7475_read(TEMP_TMIN_REG(i)) << 2;
+		data->temp[THERM][i] = adt7475_read(TEMP_THERM_REG(i)) << 2;
+
+		data->temp[OFFSET][i] = adt7475_read(TEMP_OFFSET_REG(i));
+	}
+
+	data->temp[HYSTERSIS][0] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
+	data->temp[HYSTERSIS][1] = data->temp[HYSTERSIS][0];
+	data->temp[HYSTERSIS][1] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
+	data->temp[HYSTERSIS][2] = (u16) adt7475_read(REG_REMOTE2_HYSTERSIS);
+
+	for (i = 0; i < ADT7475_TACH_COUNT; i++) {
+		data->tach[INPUT][i] = adt7475_read_word(client, TACH_REG(i));
+		data->tach[MIN][i] = adt7475_read_word(client, TACH_MIN_REG(i));
+	}
+
+	for (i = 0; i < ADT7475_PWM_COUNT; i++) {
+		long v;
+
+		data->pwm[INPUT][i] = adt7475_read(PWM_REG(i));
+		data->pwm[MAX][i] = adt7475_read(PWM_MAX_REG(i));
+		data->pwm[MIN][i] = adt7475_read(PWM_MIN_REG(i));
+		data->pwm[CONTROL][i] = adt7475_read(PWM_CONFIG_REG(i));
+
+		/* Figure out the internal value for pwmctrl and pwmchan
+		   based on the current settings */
+
+		v = (data->pwm[CONTROL][i] >> 5) & 7;
+
+		if (v == 3)
+			data->pwmctl[i] = 0;
+		else if (v == 7)
+			data->pwmctl[i] = 1;
+		else if (v == 4) {
+			/* The fan is disabled - we don't want to
+			   support that, so change to manual mode and
+			   set the duty cycle to 0 instead
+			*/
+
+			data->pwm[INPUT][i] = 0;
+			data->pwm[CONTROL][i] &= ~0xE0;
+			data->pwm[CONTROL][i] |= (7 << 5);
+
+			i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(i),
+						  data->pwm[INPUT][i]);
+
+			i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(i),
+						  data->pwm[CONTROL][i]);
+
+			data->pwmctl[i] = 1;
+		} else {
+			data->pwmctl[i] = 2;
+
+			switch (v) {
+			case 0:
+				data->pwmchan[i] = 1;
+				break;
+			case 1:
+				data->pwmchan[i] = 2;
+				break;
+			case 2:
+				data->pwmchan[i] = 4;
+				break;
+			case 5:
+				data->pwmchan[i] = 6;
+				break;
+			case 6:
+				data->pwmchan[i] = 7;
+				break;
+			}
+		}
+
+	}
+
+	data->range[0] =  adt7475_read(TEMP_TRANGE_REG(0));
+	data->range[1] =  adt7475_read(TEMP_TRANGE_REG(1));
+	data->range[2] =  adt7475_read(TEMP_TRANGE_REG(2));
+
+	data->updated = jiffies;
+	data->valid = 1;
+
+	mutex_unlock(&data->lock);
+
+	return data;
+}
+
+static int __init sensors_adt7475_init(void)
+{
+	return i2c_add_driver(&adt7475_driver);
+}
+
+static void __exit sensors_adt7475_exit(void)
+{
+	i2c_del_driver(&adt7475_driver);
+}
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_DESCRIPTION("adt7475 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_adt7475_init);
+module_exit(sensors_adt7475_exit);

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--yrj/dFKFPuw6o+aM--
