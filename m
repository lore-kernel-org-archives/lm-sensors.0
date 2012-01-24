From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:26 +0000
Subject: [lm-sensors] [PATCH 47/79] hwmon: (lm85) Fix checkpatch issues
Message-Id: <1327373398-997-48-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Also: s/#define^I/#define /

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm85.c |  360 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 230 insertions(+), 130 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index fd26983..864c7d9 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1,28 +1,28 @@
 /*
-    lm85.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
-    Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
-    Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
-    Copyright (C) 2007--2009  Jean Delvare <khali@linux-fr.org>
-
-    Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * lm85.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	    monitoring
+ * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+ * Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
+ * Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
+ * Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
+ * Copyright (C) 2007--2009  Jean Delvare <khali@linux-fr.org>
+ *
+ * Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
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
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -46,88 +46,89 @@ enum chips {
 
 /* The LM85 registers */
 
-#define	LM85_REG_IN(nr)			(0x20 + (nr))
-#define	LM85_REG_IN_MIN(nr)		(0x44 + (nr) * 2)
-#define	LM85_REG_IN_MAX(nr)		(0x45 + (nr) * 2)
+#define LM85_REG_IN(nr)			(0x20 + (nr))
+#define LM85_REG_IN_MIN(nr)		(0x44 + (nr) * 2)
+#define LM85_REG_IN_MAX(nr)		(0x45 + (nr) * 2)
 
-#define	LM85_REG_TEMP(nr)		(0x25 + (nr))
-#define	LM85_REG_TEMP_MIN(nr)		(0x4e + (nr) * 2)
-#define	LM85_REG_TEMP_MAX(nr)		(0x4f + (nr) * 2)
+#define LM85_REG_TEMP(nr)		(0x25 + (nr))
+#define LM85_REG_TEMP_MIN(nr)		(0x4e + (nr) * 2)
+#define LM85_REG_TEMP_MAX(nr)		(0x4f + (nr) * 2)
 
 /* Fan speeds are LSB, MSB (2 bytes) */
-#define	LM85_REG_FAN(nr)		(0x28 + (nr) * 2)
-#define	LM85_REG_FAN_MIN(nr)		(0x54 + (nr) * 2)
+#define LM85_REG_FAN(nr)		(0x28 + (nr) * 2)
+#define LM85_REG_FAN_MIN(nr)		(0x54 + (nr) * 2)
 
-#define	LM85_REG_PWM(nr)		(0x30 + (nr))
+#define LM85_REG_PWM(nr)		(0x30 + (nr))
 
-#define	LM85_REG_COMPANY		0x3e
-#define	LM85_REG_VERSTEP		0x3f
+#define LM85_REG_COMPANY		0x3e
+#define LM85_REG_VERSTEP		0x3f
 
-#define	ADT7468_REG_CFG5		0x7c
-#define		ADT7468_OFF64		(1 << 0)
-#define		ADT7468_HFPWM		(1 << 1)
-#define	IS_ADT7468_OFF64(data)		\
+#define ADT7468_REG_CFG5		0x7c
+#define ADT7468_OFF64			(1 << 0)
+#define ADT7468_HFPWM			(1 << 1)
+#define IS_ADT7468_OFF64(data)		\
 	((data)->type = adt7468 && !((data)->cfg5 & ADT7468_OFF64))
-#define	IS_ADT7468_HFPWM(data)		\
+#define IS_ADT7468_HFPWM(data)		\
 	((data)->type = adt7468 && !((data)->cfg5 & ADT7468_HFPWM))
 
 /* These are the recognized values for the above regs */
-#define	LM85_COMPANY_NATIONAL		0x01
-#define	LM85_COMPANY_ANALOG_DEV		0x41
-#define	LM85_COMPANY_SMSC		0x5c
-#define	LM85_VERSTEP_VMASK              0xf0
-#define	LM85_VERSTEP_GENERIC		0x60
-#define	LM85_VERSTEP_GENERIC2		0x70
-#define	LM85_VERSTEP_LM85C		0x60
-#define	LM85_VERSTEP_LM85B		0x62
-#define	LM85_VERSTEP_LM96000_1		0x68
-#define	LM85_VERSTEP_LM96000_2		0x69
-#define	LM85_VERSTEP_ADM1027		0x60
-#define	LM85_VERSTEP_ADT7463		0x62
-#define	LM85_VERSTEP_ADT7463C		0x6A
-#define	LM85_VERSTEP_ADT7468_1		0x71
-#define	LM85_VERSTEP_ADT7468_2		0x72
-#define	LM85_VERSTEP_EMC6D100_A0        0x60
-#define	LM85_VERSTEP_EMC6D100_A1        0x61
-#define	LM85_VERSTEP_EMC6D102		0x65
-#define	LM85_VERSTEP_EMC6D103_A0	0x68
-#define	LM85_VERSTEP_EMC6D103_A1	0x69
-#define	LM85_VERSTEP_EMC6D103S		0x6A	/* Also known as EMC6D103:A2 */
-
-#define	LM85_REG_CONFIG			0x40
-
-#define	LM85_REG_ALARM1			0x41
-#define	LM85_REG_ALARM2			0x42
-
-#define	LM85_REG_VID			0x43
+#define LM85_COMPANY_NATIONAL		0x01
+#define LM85_COMPANY_ANALOG_DEV		0x41
+#define LM85_COMPANY_SMSC		0x5c
+#define LM85_VERSTEP_VMASK              0xf0
+#define LM85_VERSTEP_GENERIC		0x60
+#define LM85_VERSTEP_GENERIC2		0x70
+#define LM85_VERSTEP_LM85C		0x60
+#define LM85_VERSTEP_LM85B		0x62
+#define LM85_VERSTEP_LM96000_1		0x68
+#define LM85_VERSTEP_LM96000_2		0x69
+#define LM85_VERSTEP_ADM1027		0x60
+#define LM85_VERSTEP_ADT7463		0x62
+#define LM85_VERSTEP_ADT7463C		0x6A
+#define LM85_VERSTEP_ADT7468_1		0x71
+#define LM85_VERSTEP_ADT7468_2		0x72
+#define LM85_VERSTEP_EMC6D100_A0        0x60
+#define LM85_VERSTEP_EMC6D100_A1        0x61
+#define LM85_VERSTEP_EMC6D102		0x65
+#define LM85_VERSTEP_EMC6D103_A0	0x68
+#define LM85_VERSTEP_EMC6D103_A1	0x69
+#define LM85_VERSTEP_EMC6D103S		0x6A	/* Also known as EMC6D103:A2 */
+
+#define LM85_REG_CONFIG			0x40
+
+#define LM85_REG_ALARM1			0x41
+#define LM85_REG_ALARM2			0x42
+
+#define LM85_REG_VID			0x43
 
 /* Automated FAN control */
-#define	LM85_REG_AFAN_CONFIG(nr)	(0x5c + (nr))
-#define	LM85_REG_AFAN_RANGE(nr)		(0x5f + (nr))
-#define	LM85_REG_AFAN_SPIKE1		0x62
-#define	LM85_REG_AFAN_MINPWM(nr)	(0x64 + (nr))
-#define	LM85_REG_AFAN_LIMIT(nr)		(0x67 + (nr))
-#define	LM85_REG_AFAN_CRITICAL(nr)	(0x6a + (nr))
-#define	LM85_REG_AFAN_HYST1		0x6d
-#define	LM85_REG_AFAN_HYST2		0x6e
-
-#define	ADM1027_REG_EXTEND_ADC1		0x76
-#define	ADM1027_REG_EXTEND_ADC2		0x77
+#define LM85_REG_AFAN_CONFIG(nr)	(0x5c + (nr))
+#define LM85_REG_AFAN_RANGE(nr)		(0x5f + (nr))
+#define LM85_REG_AFAN_SPIKE1		0x62
+#define LM85_REG_AFAN_MINPWM(nr)	(0x64 + (nr))
+#define LM85_REG_AFAN_LIMIT(nr)		(0x67 + (nr))
+#define LM85_REG_AFAN_CRITICAL(nr)	(0x6a + (nr))
+#define LM85_REG_AFAN_HYST1		0x6d
+#define LM85_REG_AFAN_HYST2		0x6e
+
+#define ADM1027_REG_EXTEND_ADC1		0x76
+#define ADM1027_REG_EXTEND_ADC2		0x77
 
 #define EMC6D100_REG_ALARM3             0x7d
 /* IN5, IN6 and IN7 */
-#define	EMC6D100_REG_IN(nr)             (0x70 + ((nr) - 5))
-#define	EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr) - 5) * 2)
-#define	EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr) - 5) * 2)
-#define	EMC6D102_REG_EXTEND_ADC1	0x85
-#define	EMC6D102_REG_EXTEND_ADC2	0x86
-#define	EMC6D102_REG_EXTEND_ADC3	0x87
-#define	EMC6D102_REG_EXTEND_ADC4	0x88
-
-
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
+#define EMC6D100_REG_IN(nr)             (0x70 + ((nr) - 5))
+#define EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr) - 5) * 2)
+#define EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr) - 5) * 2)
+#define EMC6D102_REG_EXTEND_ADC1	0x85
+#define EMC6D102_REG_EXTEND_ADC2	0x86
+#define EMC6D102_REG_EXTEND_ADC3	0x87
+#define EMC6D102_REG_EXTEND_ADC4	0x88
+
+
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
  */
 
 /* IN are scaled according to built-in resistors */
@@ -166,7 +167,8 @@ static inline u16 FAN_TO_REG(unsigned long val)
 #define PWM_FROM_REG(val)		(val)
 
 
-/* ZONEs have the following parameters:
+/*
+ * ZONEs have the following parameters:
  *    Limit (low) temp,           1. degC
  *    Hysteresis (below limit),   1. degC (0-15)
  *    Range of speed control,     .1 degC (2-80)
@@ -228,7 +230,8 @@ static int FREQ_FROM_REG(const int *map, u8 reg)
 	return map[reg & 0x07];
 }
 
-/* Since we can't use strings, I'm abusing these numbers
+/*
+ * Since we can't use strings, I'm abusing these numbers
  *   to stand in for the following meanings:
  *      1 -- PWM responds to Zone 1
  *      2 -- PWM responds to Zone 2
@@ -258,7 +261,8 @@ static int ZONE_TO_REG(int zone)
 #define HYST_TO_REG(val)	SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
 #define HYST_FROM_REG(val)	((val) * 1000)
 
-/* Chip sampling rates
+/*
+ * Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
  *    so it doesn't make sense to read them more often than that.
@@ -274,7 +278,8 @@ static int ZONE_TO_REG(int zone)
 #define LM85_DATA_INTERVAL  (HZ + HZ / 2)
 #define LM85_CONFIG_INTERVAL  (1 * 60 * HZ)
 
-/* LM85 can automatically adjust fan speeds based on temperature
+/*
+ * LM85 can automatically adjust fan speeds based on temperature
  * This structure encapsulates an entire Zone config.  There are
  * three zones (one for each temperature input) on the lm85
  */
@@ -283,7 +288,8 @@ struct lm85_zone {
 	u8 hyst;	/* Low limit hysteresis. (0-15) */
 	u8 range;	/* Temp range, encoded */
 	s8 critical;	/* "All fans ON" temp limit */
-	u8 max_desired; /* Actual "max" temperature specified.  Preserved
+	u8 max_desired; /*
+			 * Actual "max" temperature specified.  Preserved
 			 * to prevent "drift" as other autofan control
 			 * values change.
 			 */
@@ -295,8 +301,10 @@ struct lm85_autofan {
 	u8 min_off;	/* Min PWM or OFF below "limit", flag */
 };
 
-/* For each registered chip, we need to keep some data in memory.
-   The structure is dynamically allocated. */
+/*
+ * For each registered chip, we need to keep some data in memory.
+ * The structure is dynamically allocated.
+ */
 struct lm85_data {
 	struct device *hwmon_dev;
 	const int *freq_map;
@@ -391,7 +399,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val);
@@ -443,7 +456,14 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct lm85_data *data = dev_get_drvdata(dev);
-	data->vrm = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm = val;
 	return count;
 }
 
@@ -500,7 +520,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = PWM_TO_REG(val);
@@ -537,8 +562,13 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 	u8 config;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	switch (val) {
 	case 0:
@@ -548,8 +578,10 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 		config = 7;
 		break;
 	case 2:
-		/* Here we have to choose arbitrarily one of the 5 possible
-		   configurations; I go for the safest */
+		/*
+		 * Here we have to choose arbitrarily one of the 5 possible
+		 * configurations; I go for the safest
+		 */
 		config = 6;
 		break;
 	default:
@@ -588,12 +620,19 @@ static ssize_t set_pwm_freq(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	/* The ADT7468 has a special high-frequency PWM output mode,
+	/*
+	 * The ADT7468 has a special high-frequency PWM output mode,
 	 * where all PWM outputs are driven by a 22.5 kHz clock.
-	 * This might confuse the user, but there's not much we can do. */
+	 * This might confuse the user, but there's not much we can do.
+	 */
 	if (data->type = adt7468 && val >= 11300) {	/* High freq. mode */
 		data->cfg5 &= ~ADT7468_HFPWM;
 		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
@@ -648,7 +687,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = INS_TO_REG(nr, val);
@@ -671,7 +715,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = INS_TO_REG(nr, val);
@@ -722,7 +771,12 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (IS_ADT7468_OFF64(data))
 		val += 64;
@@ -748,7 +802,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (IS_ADT7468_OFF64(data))
 		val += 64;
@@ -789,7 +848,12 @@ static ssize_t set_pwm_auto_channels(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].config = (data->autofan[nr].config & (~0xe0))
@@ -814,7 +878,12 @@ static ssize_t set_pwm_auto_pwm_min(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_pwm = PWM_TO_REG(val);
@@ -838,8 +907,13 @@ static ssize_t set_pwm_auto_pwm_minctl(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 	u8 tmp;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_off = val;
@@ -885,7 +959,12 @@ static ssize_t set_temp_auto_temp_off(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int min;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
@@ -916,7 +995,12 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->zone[nr].limit = TEMP_TO_REG(val);
@@ -951,7 +1035,12 @@ static ssize_t set_temp_auto_temp_max(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int min;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
@@ -979,7 +1068,12 @@ static ssize_t set_temp_auto_temp_crit(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->zone[nr].critical = TEMP_TO_REG(val);
@@ -1338,24 +1432,28 @@ static int lm85_probe(struct i2c_client *client,
 			goto err_remove_files;
 	}
 
-	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
-	   as a sixth digital VID input rather than an analog input. */
+	/*
+	 * The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
+	 * as a sixth digital VID input rather than an analog input.
+	 */
 	if (data->type = adt7463 || data->type = adt7468) {
 		u8 vid = lm85_read_value(client, LM85_REG_VID);
 		if (vid & 0x80)
 			data->has_vid5 = true;
 	}
 
-	if (!data->has_vid5)
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					&lm85_group_in4)))
+	if (!data->has_vid5) {
+		err = sysfs_create_group(&client->dev.kobj, &lm85_group_in4);
+		if (err)
 			goto err_remove_files;
+	}
 
 	/* The EMC6D100 has 3 additional voltage inputs */
-	if (data->type = emc6d100)
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					&lm85_group_in567)))
+	if (data->type = emc6d100) {
+		err = sysfs_create_group(&client->dev.kobj, &lm85_group_in567);
+		if (err)
 			goto err_remove_files;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1443,7 +1541,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 		/* Things that change quickly */
 		dev_dbg(&client->dev, "Reading sensor values\n");
 
-		/* Have to read extended bits first to "freeze" the
+		/*
+		 * Have to read extended bits first to "freeze" the
 		 * more significant bits that are read later.
 		 * There are 2 additional resolution bits per channel and we
 		 * have room for 4, so we shift them to the left.
@@ -1503,9 +1602,10 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 						EMC6D100_REG_ALARM3) << 16;
 		} else if (data->type = emc6d102 || data->type = emc6d103 ||
 			   data->type = emc6d103s) {
-			/* Have to read LSB bits after the MSB ones because
-			   the reading of the MSB bits has frozen the
-			   LSBs (backward from the ADM1027).
+			/*
+			 * Have to read LSB bits after the MSB ones because
+			 * the reading of the MSB bits has frozen the
+			 * LSBs (backward from the ADM1027).
 			 */
 			int ext1 = lm85_read_value(client,
 						   EMC6D102_REG_EXTEND_ADC1);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
