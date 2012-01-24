From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:37 +0000
Subject: [lm-sensors] [PATCH 58/79] hwmon: (w83793) Fix checkpatch issues
Message-Id: <1327373398-997-59-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space required after that ',' (ctx:VxV)
WARNING: braces {} are not necessary for any arm of this statement
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Also replaced "<constant> = <variable>" with "<variable> = <constant>".
Translation was done with the following coccinelle script to limit risk.

@@
identifier i;
constant C;
@@

<...
- C = i
+ i = C
...>

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83793.c |  434 ++++++++++++++++++++++++++++--------------------
 1 files changed, 253 insertions(+), 181 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 742bf13..834e49d 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1,34 +1,34 @@
 /*
-    w83793.c - Linux kernel driver for hardware monitoring
-    Copyright (C) 2006 Winbond Electronics Corp.
-                  Yuan Mu
-                  Rudolf Marek <r.marek@assembler.cz>
-    Copyright (C) 2009-2010 Sven Anders <anders@anduras.de>, ANDURAS AG.
-		  Watchdog driver part
-		  (Based partially on fschmd driver,
-		   Copyright 2007-2008 by Hans de Goede)
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation - version 2.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-    02110-1301 USA.
-*/
+ * w83793.c - Linux kernel driver for hardware monitoring
+ * Copyright (C) 2006 Winbond Electronics Corp.
+ *	      Yuan Mu
+ *	      Rudolf Marek <r.marek@assembler.cz>
+ * Copyright (C) 2009-2010 Sven Anders <anders@anduras.de>, ANDURAS AG.
+ *		Watchdog driver part
+ *		(Based partially on fschmd driver,
+ *		 Copyright 2007-2008 by Hans de Goede)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation - version 2.
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
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83793	10	12	8	6	0x7b	0x5ca3	yes	no
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83793	10	12	8	6	0x7b	0x5ca3	yes	no
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -78,9 +78,9 @@ MODULE_PARM_DESC(nowayout,
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 /*
-   Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved
-   as ID, Bank Select registers
-*/
+ * Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved
+ * as ID, Bank Select registers
+ */
 #define W83793_REG_BANKSEL		0x00
 #define W83793_REG_VENDORID		0x0d
 #define W83793_REG_CHIPID		0x0e
@@ -110,8 +110,10 @@ static u16 W83793_REG_TEMP_MODE[2] = { 0x5e, 0x5f };
 #define TEMP_CRIT_HYST	2
 #define TEMP_WARN	3
 #define TEMP_WARN_HYST	4
-/* only crit and crit_hyst affect real-time alarm status
-   current crit crit_hyst warn warn_hyst */
+/*
+ * only crit and crit_hyst affect real-time alarm status
+ * current crit crit_hyst warn warn_hyst
+ */
 static u16 W83793_REG_TEMP[][5] = {
 	{0x1c, 0x78, 0x79, 0x7a, 0x7b},
 	{0x1d, 0x7c, 0x7d, 0x7e, 0x7f},
@@ -218,7 +220,8 @@ struct w83793_data {
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned long last_nonvolatile;	/* In jiffies, last time we update the
-					   nonvolatile registers */
+					 * nonvolatile registers
+					 */
 
 	u8 bank;
 	u8 vrm;
@@ -233,7 +236,8 @@ struct w83793_data {
 	s8 temp[6][5];		/* current, crit, crit_hyst,warn, warn_hyst */
 	u8 temp_low_bits;	/* Additional resolution TD1-TD4 */
 	u8 temp_mode[2];	/* byte 0: Temp D1-D4 mode each has 2 bits
-				   byte 1: Temp R1,R2 mode, each has 1 bit */
+				 * byte 1: Temp R1,R2 mode, each has 1 bit
+				 */
 	u8 temp_critical;	/* If reached all fan will be at full speed */
 	u8 temp_fan_map[6];	/* Temp controls which pwm fan, bit field */
 
@@ -268,17 +272,21 @@ struct w83793_data {
 	int watchdog_timeout; /* watchdog timeout in minutes */
 };
 
-/* Somewhat ugly :( global data pointer list with all devices, so that
-   we can find our device data as when using misc_register. There is no
-   other method to get to one's device data from the open file-op and
-   for usage in the reboot notifier callback. */
+/*
+ * Somewhat ugly :( global data pointer list with all devices, so that
+ * we can find our device data as when using misc_register. There is no
+ * other method to get to one's device data from the open file-op and
+ * for usage in the reboot notifier callback.
+ */
 static LIST_HEAD(watchdog_data_list);
 
 /* Note this lock not only protect list access, but also data.kref access */
 static DEFINE_MUTEX(watchdog_data_mutex);
 
-/* Release our data struct when we're detached from the i2c client *and* all
-   references to our watchdog device are released */
+/*
+ * Release our data struct when we're detached from the i2c client *and* all
+ * references to our watchdog device are released
+ */
 static void w83793_release_resources(struct kref *ref)
 {
 	struct w83793_data *data = container_of(ref, struct w83793_data, kref);
@@ -337,7 +345,14 @@ store_vrm(struct device *dev, struct device_attribute *attr,
 	  const char *buf, size_t count)
 {
 	struct w83793_data *data = dev_get_drvdata(dev);
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
 
@@ -354,7 +369,7 @@ show_alarm_beep(struct device *dev, struct device_attribute *attr, char *buf)
 	int bit = sensor_attr->index & 0x07;
 	u8 val;
 
-	if (ALARM_STATUS = nr) {
+	if (nr = ALARM_STATUS) {
 		val = (data->alarms[index] >> (bit)) & 1;
 	} else {		/* BEEP_ENABLE */
 		val = (data->beeps[index] >> (bit)) & 1;
@@ -374,10 +389,14 @@ store_beep(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index >> 3;
 	int shift = sensor_attr->index & 0x07;
 	u8 beep_bit = 1 << shift;
-	u8 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
-	if (val != 0 && val != 1)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 1)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -403,9 +422,14 @@ store_beep_enable(struct device *dev, struct device_attribute *attr,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
-	u8 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	if (val != 0 && val != 1)
+	if (val > 1)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -449,8 +473,12 @@ store_chassis_clear(struct device *dev,
 	struct w83793_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 	u8 reg;
+	int err;
 
-	if (kstrtoul(buf, 10, &val) || val != 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -473,11 +501,10 @@ show_fan(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83793_data *data = w83793_update_device(dev);
 	u16 val;
 
-	if (FAN_INPUT = nr) {
+	if (nr = FAN_INPUT)
 		val = data->fan[index] & 0x0fff;
-	} else {
+	else
 		val = data->fan_min[index] & 0x0fff;
-	}
 
 	return sprintf(buf, "%lu\n", FAN_FROM_REG(val));
 }
@@ -491,7 +518,13 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
-	u16 val = FAN_TO_REG(simple_strtoul(buf, NULL, 10));
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	val = FAN_TO_REG(val);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[index] = val;
@@ -513,7 +546,7 @@ show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 
-	if (PWM_STOP_TIME = nr)
+	if (nr = PWM_STOP_TIME)
 		val = TIME_FROM_REG(data->pwm_stop_time[index]);
 	else
 		val = (data->pwm[index][nr] & 0x3f) << 2;
@@ -531,17 +564,21 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
-	u8 val;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if (PWM_STOP_TIME = nr) {
-		val = TIME_TO_REG(simple_strtoul(buf, NULL, 10));
+	if (nr = PWM_STOP_TIME) {
+		val = TIME_TO_REG(val);
 		data->pwm_stop_time[index] = val;
 		w83793_write_value(client, W83793_REG_PWM_STOP_TIME(index),
 				   val);
 	} else {
-		val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 0xff)
-		      >> 2;
+		val = SENSORS_LIMIT(val, 0, 0xff) >> 2;
 		data->pwm[index][nr]  		    w83793_read_value(client, W83793_REG_PWM(index, nr)) & 0xc0;
 		data->pwm[index][nr] |= val;
@@ -563,7 +600,7 @@ show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83793_data *data = w83793_update_device(dev);
 	long temp = TEMP_FROM_REG(data->temp[index][nr]);
 
-	if (TEMP_READ = nr && index < 4) {	/* Only TD1-TD4 have low bits */
+	if (nr = TEMP_READ && index < 4) {	/* Only TD1-TD4 have low bits */
 		int low = ((data->temp_low_bits >> (index * 2)) & 0x03) * 250;
 		temp += temp > 0 ? low : -low;
 	}
@@ -580,7 +617,12 @@ store_temp(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
-	long tmp = simple_strtol(buf, NULL, 10);
+	long tmp;
+	int err;
+
+	err = kstrtol(buf, 10, &tmp);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp[index][nr] = TEMP_TO_REG(tmp, -128, 127);
@@ -591,18 +633,18 @@ store_temp(struct device *dev, struct device_attribute *attr,
 }
 
 /*
-	TD1-TD4
-	each has 4 mode:(2 bits)
-	0:	Stop monitor
-	1:	Use internal temp sensor(default)
-	2:	Reserved
-	3:	Use sensor in Intel CPU and get result by PECI
-
-	TR1-TR2
-	each has 2 mode:(1 bit)
-	0:	Disable temp sensor monitor
-	1:	To enable temp sensors monitor
-*/
+ * TD1-TD4
+ * each has 4 mode:(2 bits)
+ * 0:	Stop monitor
+ * 1:	Use internal temp sensor(default)
+ * 2:	Reserved
+ * 3:	Use sensor in Intel CPU and get result by PECI
+ *
+ * TR1-TR2
+ * each has 2 mode:(1 bit)
+ * 0:	Disable temp sensor monitor
+ * 1:	To enable temp sensors monitor
+ */
 
 /* 0 disable, 6 PECI */
 static u8 TO_TEMP_MODE[] = { 0, 0, 0, 6 };
@@ -622,11 +664,10 @@ show_temp_mode(struct device *dev, struct device_attribute *attr, char *buf)
 	tmp = (data->temp_mode[index] >> shift) & mask;
 
 	/* for the internal sensor, found out if diode or thermistor */
-	if (tmp = 1) {
+	if (tmp = 1)
 		tmp = index = 0 ? 3 : 4;
-	} else {
+	else
 		tmp = TO_TEMP_MODE[tmp];
-	}
 
 	return sprintf(buf, "%d\n", tmp);
 }
@@ -642,7 +683,12 @@ store_temp_mode(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	u8 mask = (index < 4) ? 0x03 : 0x01;
 	u8 shift = (index < 4) ? (2 * index) : (index - 4);
-	u8 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	/* transform the sysfs interface values into table above */
 	if ((val = 6) && (index < 4)) {
@@ -681,15 +727,14 @@ show_sf_setup(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83793_data *data = w83793_update_device(dev);
 	u32 val = 0;
 
-	if (SETUP_PWM_DEFAULT = nr) {
+	if (nr = SETUP_PWM_DEFAULT)
 		val = (data->pwm_default & 0x3f) << 2;
-	} else if (SETUP_PWM_UPTIME = nr) {
+	else if (nr = SETUP_PWM_UPTIME)
 		val = TIME_FROM_REG(data->pwm_uptime);
-	} else if (SETUP_PWM_DOWNTIME = nr) {
+	else if (nr = SETUP_PWM_DOWNTIME)
 		val = TIME_FROM_REG(data->pwm_downtime);
-	} else if (SETUP_TEMP_CRITICAL = nr) {
+	else if (nr = SETUP_TEMP_CRITICAL)
 		val = TEMP_FROM_REG(data->temp_critical & 0x7f);
-	}
 
 	return sprintf(buf, "%d\n", val);
 }
@@ -703,31 +748,34 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if (SETUP_PWM_DEFAULT = nr) {
+	if (nr = SETUP_PWM_DEFAULT) {
 		data->pwm_default  		    w83793_read_value(client, W83793_REG_PWM_DEFAULT) & 0xc0;
-		data->pwm_default |= SENSORS_LIMIT(simple_strtoul(buf, NULL,
-								  10),
-						   0, 0xff) >> 2;
+		data->pwm_default |= SENSORS_LIMIT(val, 0, 0xff) >> 2;
 		w83793_write_value(client, W83793_REG_PWM_DEFAULT,
 							data->pwm_default);
-	} else if (SETUP_PWM_UPTIME = nr) {
-		data->pwm_uptime = TIME_TO_REG(simple_strtoul(buf, NULL, 10));
+	} else if (nr = SETUP_PWM_UPTIME) {
+		data->pwm_uptime = TIME_TO_REG(val);
 		data->pwm_uptime += data->pwm_uptime = 0 ? 1 : 0;
 		w83793_write_value(client, W83793_REG_PWM_UPTIME,
 							data->pwm_uptime);
-	} else if (SETUP_PWM_DOWNTIME = nr) {
-		data->pwm_downtime = TIME_TO_REG(simple_strtoul(buf, NULL, 10));
+	} else if (nr = SETUP_PWM_DOWNTIME) {
+		data->pwm_downtime = TIME_TO_REG(val);
 		data->pwm_downtime += data->pwm_downtime = 0 ? 1 : 0;
 		w83793_write_value(client, W83793_REG_PWM_DOWNTIME,
 							data->pwm_downtime);
 	} else {		/* SETUP_TEMP_CRITICAL */
 		data->temp_critical  		    w83793_read_value(client, W83793_REG_TEMP_CRITICAL) & 0x80;
-		data->temp_critical |= TEMP_TO_REG(simple_strtol(buf, NULL, 10),
-						   0, 0x7f);
+		data->temp_critical |= TEMP_TO_REG(val, 0, 0x7f);
 		w83793_write_value(client, W83793_REG_TEMP_CRITICAL,
 							data->temp_critical);
 	}
@@ -737,31 +785,31 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 }
 
 /*
-	Temp SmartFan control
-	TEMP_FAN_MAP
-	Temp channel control which pwm fan, bitfield, bit 0 indicate pwm1...
-	It's possible two or more temp channels control the same fan, w83793
-	always prefers to pick the most critical request and applies it to
-	the related Fan.
-	It's possible one fan is not in any mapping of 6 temp channels, this
-	means the fan is manual mode
-
-	TEMP_PWM_ENABLE
-	Each temp channel has its own SmartFan mode, and temp channel
-	control	fans that are set by TEMP_FAN_MAP
-	0:	SmartFanII mode
-	1:	Thermal Cruise Mode
-
-	TEMP_CRUISE
-	Target temperature in thermal cruise mode, w83793 will try to turn
-	fan speed to keep the temperature of target device around this
-	temperature.
-
-	TEMP_TOLERANCE
-	If Temp higher or lower than target with this tolerance, w83793
-	will take actions to speed up or slow down the fan to keep the
-	temperature within the tolerance range.
-*/
+ * Temp SmartFan control
+ * TEMP_FAN_MAP
+ * Temp channel control which pwm fan, bitfield, bit 0 indicate pwm1...
+ * It's possible two or more temp channels control the same fan, w83793
+ * always prefers to pick the most critical request and applies it to
+ * the related Fan.
+ * It's possible one fan is not in any mapping of 6 temp channels, this
+ * means the fan is manual mode
+ *
+ * TEMP_PWM_ENABLE
+ * Each temp channel has its own SmartFan mode, and temp channel
+ * control fans that are set by TEMP_FAN_MAP
+ * 0:	SmartFanII mode
+ * 1:	Thermal Cruise Mode
+ *
+ * TEMP_CRUISE
+ * Target temperature in thermal cruise mode, w83793 will try to turn
+ * fan speed to keep the temperature of target device around this
+ * temperature.
+ *
+ * TEMP_TOLERANCE
+ * If Temp higher or lower than target with this tolerance, w83793
+ * will take actions to speed up or slow down the fan to keep the
+ * temperature within the tolerance range.
+ */
 
 #define TEMP_FAN_MAP			0
 #define TEMP_PWM_ENABLE			1
@@ -777,12 +825,12 @@ show_sf_ctrl(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83793_data *data = w83793_update_device(dev);
 	u32 val;
 
-	if (TEMP_FAN_MAP = nr) {
+	if (nr = TEMP_FAN_MAP) {
 		val = data->temp_fan_map[index];
-	} else if (TEMP_PWM_ENABLE = nr) {
+	} else if (nr = TEMP_PWM_ENABLE) {
 		/* +2 to transfrom into 2 and 3 to conform with sysfs intf */
 		val = ((data->pwm_enable >> index) & 0x01) + 2;
-	} else if (TEMP_CRUISE = nr) {
+	} else if (nr = TEMP_CRUISE) {
 		val = TEMP_FROM_REG(data->temp_cruise[index] & 0x7f);
 	} else {		/* TEMP_TOLERANCE */
 		val = data->tolerance[index >> 1] >> ((index & 0x01) ? 4 : 0);
@@ -801,16 +849,20 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
-	u32 val;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if (TEMP_FAN_MAP = nr) {
-		val = simple_strtoul(buf, NULL, 10) & 0xff;
+	if (nr = TEMP_FAN_MAP) {
+		val = SENSORS_LIMIT(val, 0, 255);
 		w83793_write_value(client, W83793_REG_TEMP_FAN_MAP(index), val);
 		data->temp_fan_map[index] = val;
-	} else if (TEMP_PWM_ENABLE = nr) {
-		val = simple_strtoul(buf, NULL, 10);
-		if (2 = val || 3 = val) {
+	} else if (nr = TEMP_PWM_ENABLE) {
+		if (val = 2 || val = 3) {
 			data->pwm_enable  			    w83793_read_value(client, W83793_REG_PWM_ENABLE);
 			if (val - 2)
@@ -823,12 +875,11 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
 			mutex_unlock(&data->update_lock);
 			return -EINVAL;
 		}
-	} else if (TEMP_CRUISE = nr) {
+	} else if (nr = TEMP_CRUISE) {
 		data->temp_cruise[index]  		    w83793_read_value(client, W83793_REG_TEMP_CRUISE(index));
-		val = TEMP_TO_REG(simple_strtol(buf, NULL, 10), 0, 0x7f);
 		data->temp_cruise[index] &= 0x80;
-		data->temp_cruise[index] |= val;
+		data->temp_cruise[index] |= TEMP_TO_REG(val, 0, 0x7f);
 
 		w83793_write_value(client, W83793_REG_TEMP_CRUISE(index),
 						data->temp_cruise[index]);
@@ -838,9 +889,8 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
 		data->tolerance[i]  		    w83793_read_value(client, W83793_REG_TEMP_TOL(i));
 
-		val = TEMP_TO_REG(simple_strtol(buf, NULL, 10), 0, 0x0f);
 		data->tolerance[i] &= ~(0x0f << shift);
-		data->tolerance[i] |= val << shift;
+		data->tolerance[i] |= TEMP_TO_REG(val, 0, 0x0f) << shift;
 		w83793_write_value(client, W83793_REG_TEMP_TOL(i),
 							data->tolerance[i]);
 	}
@@ -871,7 +921,13 @@ store_sf2_pwm(struct device *dev, struct device_attribute *attr,
 	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
-	u8 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 0xff) >> 2;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	val = SENSORS_LIMIT(val, 0, 0xff) >> 2;
 
 	mutex_lock(&data->update_lock);
 	data->sf2_pwm[index][nr] @@ -906,7 +962,13 @@ store_sf2_temp(struct device *dev, struct device_attribute *attr,
 	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
-	u8 val = TEMP_TO_REG(simple_strtol(buf, NULL, 10), 0, 0x7f);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+	val = TEMP_TO_REG(val, 0, 0x7f);
 
 	mutex_lock(&data->update_lock);
 	data->sf2_temp[index][nr] @@ -948,17 +1010,19 @@ store_in(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
-	u32 val;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	val = (val + scale_in[index] / 2) / scale_in[index];
 
-	val -	    (simple_strtoul(buf, NULL, 10) +
-	     scale_in[index] / 2) / scale_in[index];
 	mutex_lock(&data->update_lock);
 	if (index > 2) {
 		/* fix the limit values of 5VDD and 5VSB to ALARM mechanism */
-		if (1 = nr || 2 = nr) {
+		if (nr = 1 || nr = 2)
 			val -= scale_in_add[index] / scale_in[index];
-		}
 		val = SENSORS_LIMIT(val, 0, 255);
 	} else {
 		val = SENSORS_LIMIT(val, 0, 0x3FF);
@@ -1143,9 +1207,8 @@ static struct sensor_device_attribute_2 sda_single_files[] = {
 
 static void w83793_init_client(struct i2c_client *client)
 {
-	if (reset) {
+	if (reset)
 		w83793_write_value(client, W83793_REG_CONFIG, 0x80);
-	}
 
 	/* Start monitoring */
 	w83793_write_value(client, W83793_REG_CONFIG,
@@ -1259,10 +1322,12 @@ static int watchdog_open(struct inode *inode, struct file *filp)
 	struct w83793_data *pos, *data = NULL;
 	int watchdog_is_open;
 
-	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
-	   call misc_register() from  w83793_probe() with watchdog_data_mutex
-	   hold, as misc_register() takes the misc_mtx lock, this is a possible
-	   deadlock, so we use mutex_trylock here. */
+	/*
+	 * We get called from drivers/char/misc.c with misc_mtx hold, and we
+	 * call misc_register() from  w83793_probe() with watchdog_data_mutex
+	 * hold, as misc_register() takes the misc_mtx lock, this is a possible
+	 * deadlock, so we use mutex_trylock here.
+	 */
 	if (!mutex_trylock(&watchdog_data_mutex))
 		return -ERESTARTSYS;
 	list_for_each_entry(pos, &watchdog_data_list, list) {
@@ -1275,8 +1340,10 @@ static int watchdog_open(struct inode *inode, struct file *filp)
 	/* Check, if device is already open */
 	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
 
-	/* Increase data reference counter (if not already done).
-	   Note we can never not have found data, so we don't check for this */
+	/*
+	 * Increase data reference counter (if not already done).
+	 * Note we can never not have found data, so we don't check for this
+	 */
 	if (!watchdog_is_open)
 		kref_get(&data->kref);
 
@@ -1556,9 +1623,8 @@ w83793_detect_subclients(struct i2c_client *client)
 	}
 
 	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
-	if (!(tmp & 0x08)) {
+	if (!(tmp & 0x08))
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (tmp & 0x7));
-	}
 	if (!(tmp & 0x80)) {
 		if ((data->lm75[0] != NULL)
 		    && ((tmp & 0x7) = ((tmp >> 4) & 0x7))) {
@@ -1591,9 +1657,8 @@ static int w83793_detect(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	unsigned short address = client->addr;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	bank = i2c_smbus_read_byte_data(client, W83793_REG_BANKSEL);
 
@@ -1604,8 +1669,10 @@ static int w83793_detect(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	/* If Winbond chip, address of chip and W83793_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Winbond chip, address of chip and W83793_REG_I2C_ADDR
+	 * should match
+	 */
 	if ((bank & 0x07) = 0
 	 && i2c_smbus_read_byte_data(client, W83793_REG_I2C_ADDR) ! 	    (address << 1)) {
@@ -1647,9 +1714,11 @@ static int w83793_probe(struct i2c_client *client,
 	INIT_LIST_HEAD(&data->list);
 	kref_init(&data->kref);
 
-	/* Store client pointer in our data struct for watchdog usage
-	   (where the client is found through a data ptr instead of the
-	   otherway around) */
+	/*
+	 * Store client pointer in our data struct for watchdog usage
+	 * (where the client is found through a data ptr instead of the
+	 * otherway around)
+	 */
 	data->client = client;
 
 	err = w83793_detect_subclients(client);
@@ -1660,8 +1729,8 @@ static int w83793_probe(struct i2c_client *client,
 	w83793_init_client(client);
 
 	/*
-	   Only fan 1-5 has their own input pins,
-	   Pwm 1-3 has their own pins
+	 * Only fan 1-5 has their own input pins,
+	 * Pwm 1-3 has their own pins
 	 */
 	data->has_fan = 0x1f;
 	data->has_pwm = 0x07;
@@ -1723,7 +1792,7 @@ static int w83793_probe(struct i2c_client *client,
 	}
 
 	/* check the temp1-6 mode, ignore former AMDSI selected inputs */
-	tmp = w83793_read_value(client,W83793_REG_TEMP_MODE[0]);
+	tmp = w83793_read_value(client, W83793_REG_TEMP_MODE[0]);
 	if (tmp & 0x01)
 		data->has_temp |= 0x01;
 	if (tmp & 0x04)
@@ -1733,7 +1802,7 @@ static int w83793_probe(struct i2c_client *client,
 	if (tmp & 0x40)
 		data->has_temp |= 0x08;
 
-	tmp = w83793_read_value(client,W83793_REG_TEMP_MODE[1]);
+	tmp = w83793_read_value(client, W83793_REG_TEMP_MODE[1]);
 	if (tmp & 0x01)
 		data->has_temp |= 0x10;
 	if (tmp & 0x02)
@@ -1823,9 +1892,11 @@ static int w83793_probe(struct i2c_client *client,
 		goto exit_devunreg;
 	}
 
-	/* Enable Watchdog registers.
-	   Set Configuration Register to Enable Watch Dog Registers
-	   (Bit 2) = XXXX, X1XX. */
+	/*
+	 * Enable Watchdog registers.
+	 * Set Configuration Register to Enable Watch Dog Registers
+	 * (Bit 2) = XXXX, X1XX.
+	 */
 	tmp = w83793_read_value(client, W83793_REG_CONFIG);
 	w83793_write_value(client, W83793_REG_CONFIG, tmp | 0x04);
 
@@ -1839,9 +1910,11 @@ static int w83793_probe(struct i2c_client *client,
 	/* Disable Soft Watchdog during initialiation */
 	watchdog_disable(data);
 
-	/* We take the data_mutex lock early so that watchdog_open() cannot
-	   run when misc_register() has completed, but we've not yet added
-	   our data to the watchdog_data_list (and set the default timeout) */
+	/*
+	 * We take the data_mutex lock early so that watchdog_open() cannot
+	 * run when misc_register() has completed, but we've not yet added
+	 * our data to the watchdog_data_list (and set the default timeout)
+	 */
 	mutex_lock(&watchdog_data_mutex);
 	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
 		/* Register our watchdog part */
@@ -1921,9 +1994,9 @@ static void w83793_update_nonvolatile(struct device *dev)
 	struct w83793_data *data = i2c_get_clientdata(client);
 	int i, j;
 	/*
-	   They are somewhat "stable" registers, and to update them every time
-	   takes so much time, it's just not worthy. Update them in a long
-	   interval to avoid exception.
+	 * They are somewhat "stable" registers, and to update them every time
+	 * takes so much time, it's just not worthy. Update them in a long
+	 * interval to avoid exception.
 	 */
 	if (!(time_after(jiffies, data->last_nonvolatile + HZ * 300)
 	      || !data->valid))
@@ -1940,9 +2013,8 @@ static void w83793_update_nonvolatile(struct device *dev)
 
 	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		/* Update the Fan measured value and limits */
-		if (!(data->has_fan & (1 << i))) {
+		if (!(data->has_fan & (1 << i)))
 			continue;
-		}
 		data->fan_min[i]  		    w83793_read_value(client, W83793_REG_FAN_MIN(i)) << 8;
 		data->fan_min[i] |@@ -1997,9 +2069,8 @@ static void w83793_update_nonvolatile(struct device *dev)
 	    w83793_read_value(client, W83793_REG_TEMP_CRITICAL);
 	data->beep_enable = w83793_read_value(client, W83793_REG_OVT_BEEP);
 
-	for (i = 0; i < ARRAY_SIZE(data->beeps); i++) {
+	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
 		data->beeps[i] = w83793_read_value(client, W83793_REG_BEEP(i));
-	}
 
 	data->last_nonvolatile = jiffies;
 }
@@ -2025,9 +2096,8 @@ static struct w83793_data *w83793_update_device(struct device *dev)
 	    w83793_read_value(client, W83793_REG_IN_LOW_BITS[IN_READ]);
 
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
-		if (!(data->has_fan & (1 << i))) {
+		if (!(data->has_fan & (1 << i)))
 			continue;
-		}
 		data->fan[i]  		    w83793_read_value(client, W83793_REG_FAN(i)) << 8;
 		data->fan[i] |@@ -2067,8 +2137,10 @@ END:
 	return data;
 }
 
-/* Ignore the possibility that somebody change bank outside the driver
-   Must be called with data->update_lock held, except during initialization */
+/*
+ * Ignore the possibility that somebody change bank outside the driver
+ * Must be called with data->update_lock held, except during initialization
+ */
 static u8 w83793_read_value(struct i2c_client *client, u16 reg)
 {
 	struct w83793_data *data = i2c_get_clientdata(client);
@@ -2103,16 +2175,16 @@ static int w83793_write_value(struct i2c_client *client, u16 reg, u8 value)
 
 	new_bank |= data->bank & 0xfc;
 	if (data->bank != new_bank) {
-		if ((res = i2c_smbus_write_byte_data
-		    (client, W83793_REG_BANKSEL, new_bank)) >= 0)
-			data->bank = new_bank;
-		else {
+		res = i2c_smbus_write_byte_data(client, W83793_REG_BANKSEL,
+						new_bank);
+		if (res < 0) {
 			dev_err(&client->dev,
 				"set bank to %d failed, fall back "
 				"to bank %d, write reg 0x%x error\n",
 				new_bank, data->bank, reg);
 			goto END;
 		}
+		data->bank = new_bank;
 	}
 
 	res = i2c_smbus_write_byte_data(client, reg & 0xff, value);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
