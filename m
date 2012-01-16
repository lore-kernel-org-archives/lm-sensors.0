From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:39 +0000
Subject: [lm-sensors] [PATCH 37/39] hwmon: (w83793) Fix checkpatch issues
Message-Id: <1326703781-14272-38-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space required after that ',' (ctx:VxV)
WARNING: braces {} are not necessary for any arm of this statement
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

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
 drivers/hwmon/w83793.c |  221 +++++++++++++++++++++++++++++-------------------
 1 files changed, 135 insertions(+), 86 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 3cc6fef..752f25b 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1,8 +1,7 @@
-/*
-    w83793.c - Linux kernel driver for hardware monitoring
+/* w83793.c - Linux kernel driver for hardware monitoring
     Copyright (C) 2006 Winbond Electronics Corp.
-                  Yuan Mu
-                  Rudolf Marek <r.marek@assembler.cz>
+		  Yuan Mu
+		  Rudolf Marek <r.marek@assembler.cz>
     Copyright (C) 2009-2010 Sven Anders <anders@anduras.de>, ANDURAS AG.
 		  Watchdog driver part
 		  (Based partially on fschmd driver,
@@ -181,7 +180,7 @@ static inline unsigned long FAN_FROM_REG(u16 val)
 {
 	if ((val >= 0xfff) || (val = 0))
 		return	0;
-	return (1350000UL / val);
+	return 1350000UL / val;
 }
 
 static inline u16 FAN_TO_REG(long rpm)
@@ -193,7 +192,7 @@ static inline u16 FAN_TO_REG(long rpm)
 
 static inline unsigned long TIME_FROM_REG(u8 reg)
 {
-	return (reg * 100);
+	return reg * 100;
 }
 
 static inline u8 TIME_TO_REG(unsigned long val)
@@ -203,7 +202,7 @@ static inline u8 TIME_TO_REG(unsigned long val)
 
 static inline long TEMP_FROM_REG(s8 reg)
 {
-	return (reg * 1000);
+	return reg * 1000;
 }
 
 static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
@@ -337,7 +336,14 @@ store_vrm(struct device *dev, struct device_attribute *attr,
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
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 
@@ -354,7 +360,7 @@ show_alarm_beep(struct device *dev, struct device_attribute *attr, char *buf)
 	int bit = sensor_attr->index & 0x07;
 	u8 val;
 
-	if (ALARM_STATUS = nr) {
+	if (nr = ALARM_STATUS) {
 		val = (data->alarms[index] >> (bit)) & 1;
 	} else {		/* BEEP_ENABLE */
 		val = (data->beeps[index] >> (bit)) & 1;
@@ -374,10 +380,14 @@ store_beep(struct device *dev, struct device_attribute *attr,
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
@@ -403,9 +413,14 @@ store_beep_enable(struct device *dev, struct device_attribute *attr,
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
@@ -449,8 +464,12 @@ store_chassis_clear(struct device *dev,
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
@@ -473,11 +492,10 @@ show_fan(struct device *dev, struct device_attribute *attr, char *buf)
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
@@ -491,7 +509,13 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
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
@@ -513,7 +537,7 @@ show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 
-	if (PWM_STOP_TIME = nr)
+	if (nr = PWM_STOP_TIME)
 		val = TIME_FROM_REG(data->pwm_stop_time[index]);
 	else
 		val = (data->pwm[index][nr] & 0x3f) << 2;
@@ -531,17 +555,21 @@ store_pwm(struct device *dev, struct device_attribute *attr,
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
@@ -563,7 +591,7 @@ show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83793_data *data = w83793_update_device(dev);
 	long temp = TEMP_FROM_REG(data->temp[index][nr]);
 
-	if (TEMP_READ = nr && index < 4) {	/* Only TD1-TD4 have low bits */
+	if (nr = TEMP_READ && index < 4) {	/* Only TD1-TD4 have low bits */
 		int low = ((data->temp_low_bits >> (index * 2)) & 0x03) * 250;
 		temp += temp > 0 ? low : -low;
 	}
@@ -580,7 +608,12 @@ store_temp(struct device *dev, struct device_attribute *attr,
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
@@ -622,11 +655,10 @@ show_temp_mode(struct device *dev, struct device_attribute *attr, char *buf)
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
@@ -642,7 +674,12 @@ store_temp_mode(struct device *dev, struct device_attribute *attr,
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
@@ -681,15 +718,14 @@ show_sf_setup(struct device *dev, struct device_attribute *attr, char *buf)
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
@@ -703,31 +739,34 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
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
@@ -777,12 +816,12 @@ show_sf_ctrl(struct device *dev, struct device_attribute *attr, char *buf)
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
@@ -801,16 +840,20 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
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
@@ -823,12 +866,11 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
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
@@ -838,9 +880,8 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
 		data->tolerance[i]  		    w83793_read_value(client, W83793_REG_TEMP_TOL(i));
 
-		val = TEMP_TO_REG(simple_strtol(buf, NULL, 10), 0, 0x0f);
 		data->tolerance[i] &= ~(0x0f << shift);
-		data->tolerance[i] |= val << shift;
+		data->tolerance[i] |= TEMP_TO_REG(val, 0, 0x0f) << shift;
 		w83793_write_value(client, W83793_REG_TEMP_TOL(i),
 							data->tolerance[i]);
 	}
@@ -871,7 +912,13 @@ store_sf2_pwm(struct device *dev, struct device_attribute *attr,
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
 	data->sf2_pwm[index][nr] @@ -906,7 +953,13 @@ store_sf2_temp(struct device *dev, struct device_attribute *attr,
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
 	data->sf2_temp[index][nr] @@ -948,17 +1001,19 @@ store_in(struct device *dev, struct device_attribute *attr,
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
@@ -1143,9 +1198,8 @@ static struct sensor_device_attribute_2 sda_single_files[] = {
 
 static void w83793_init_client(struct i2c_client *client)
 {
-	if (reset) {
+	if (reset)
 		w83793_write_value(client, W83793_REG_CONFIG, 0x80);
-	}
 
 	/* Start monitoring */
 	w83793_write_value(client, W83793_REG_CONFIG,
@@ -1556,9 +1610,8 @@ w83793_detect_subclients(struct i2c_client *client)
 	}
 
 	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
-	if (!(tmp & 0x08)) {
+	if (!(tmp & 0x08))
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (tmp & 0x7));
-	}
 	if (!(tmp & 0x80)) {
 		if ((data->lm75[0] != NULL)
 		    && ((tmp & 0x7) = ((tmp >> 4) & 0x7))) {
@@ -1591,9 +1644,8 @@ static int w83793_detect(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	unsigned short address = client->addr;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	bank = i2c_smbus_read_byte_data(client, W83793_REG_BANKSEL);
 
@@ -1723,7 +1775,7 @@ static int w83793_probe(struct i2c_client *client,
 	}
 
 	/* check the temp1-6 mode, ignore former AMDSI selected inputs */
-	tmp = w83793_read_value(client,W83793_REG_TEMP_MODE[0]);
+	tmp = w83793_read_value(client, W83793_REG_TEMP_MODE[0]);
 	if (tmp & 0x01)
 		data->has_temp |= 0x01;
 	if (tmp & 0x04)
@@ -1733,7 +1785,7 @@ static int w83793_probe(struct i2c_client *client,
 	if (tmp & 0x40)
 		data->has_temp |= 0x08;
 
-	tmp = w83793_read_value(client,W83793_REG_TEMP_MODE[1]);
+	tmp = w83793_read_value(client, W83793_REG_TEMP_MODE[1]);
 	if (tmp & 0x01)
 		data->has_temp |= 0x10;
 	if (tmp & 0x02)
@@ -1940,9 +1992,8 @@ static void w83793_update_nonvolatile(struct device *dev)
 
 	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		/* Update the Fan measured value and limits */
-		if (!(data->has_fan & (1 << i))) {
+		if (!(data->has_fan & (1 << i)))
 			continue;
-		}
 		data->fan_min[i]  		    w83793_read_value(client, W83793_REG_FAN_MIN(i)) << 8;
 		data->fan_min[i] |@@ -1997,9 +2048,8 @@ static void w83793_update_nonvolatile(struct device *dev)
 	    w83793_read_value(client, W83793_REG_TEMP_CRITICAL);
 	data->beep_enable = w83793_read_value(client, W83793_REG_OVT_BEEP);
 
-	for (i = 0; i < ARRAY_SIZE(data->beeps); i++) {
+	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
 		data->beeps[i] = w83793_read_value(client, W83793_REG_BEEP(i));
-	}
 
 	data->last_nonvolatile = jiffies;
 }
@@ -2025,9 +2075,8 @@ static struct w83793_data *w83793_update_device(struct device *dev)
 	    w83793_read_value(client, W83793_REG_IN_LOW_BITS[IN_READ]);
 
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
-		if (!(data->has_fan & (1 << i))) {
+		if (!(data->has_fan & (1 << i)))
 			continue;
-		}
 		data->fan[i]  		    w83793_read_value(client, W83793_REG_FAN(i)) << 8;
 		data->fan[i] |@@ -2103,16 +2152,16 @@ static int w83793_write_value(struct i2c_client *client, u16 reg, u8 value)
 
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
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
