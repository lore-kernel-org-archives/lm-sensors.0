From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Tue, 05 Aug 2008 22:29:36 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (w83791d) add manual PWM support
Message-Id: <200808060029.37112.m.hulsman@tudelft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_RRNmIa/U0UQjOl+"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_RRNmIa/U0UQjOl+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add PWM manual control.

Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>

---
 Documentation/hwmon/w83791d |   15 +++++----
 drivers/hwmon/w83791d.c     |   67 
+++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 7 deletions(-)

---
Index: linux-2.6.27-rc1/drivers/hwmon/w83791d.c
===================================================================
--- linux-2.6.27-rc1.orig/drivers/hwmon/w83791d.c
+++ linux-2.6.27-rc1/drivers/hwmon/w83791d.c
@@ -23,7 +23,7 @@
     Supports following chips:
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83791d	10	5	3	3	0x71	0x5ca3	yes	no
+    w83791d	10	5	5	3	0x71	0x5ca3	yes	no
 
     The w83791d chip appears to be part way between the 83781d and the
     83792d. Thus, this file is derived from both the w83792d.c and
@@ -45,6 +45,7 @@
 #define NUMBER_OF_VIN		10
 #define NUMBER_OF_FANIN		5
 #define NUMBER_OF_TEMPIN	3
+#define NUMBER_OF_PWM		5
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
@@ -116,6 +117,14 @@ static const u8 W83791D_REG_FAN_MIN[NUMB
 	0xBD,			/* FAN 5 Count Low Limit in DataSheet */
 };
 
+static const u8 W83791D_REG_PWM[NUMBER_OF_PWM] = {
+	0x81,			/* PWM 1 duty cycle register in DataSheet */
+	0x83,			/* PWM 2 duty cycle register in DataSheet */
+	0x94,			/* PWM 3 duty cycle register in DataSheet */
+	0xA0,			/* PWM 4 duty cycle register in DataSheet */
+	0xA1,			/* PWM 5 duty cycle register in DataSheet */
+};
+
 static const u8 W83791D_REG_FAN_CFG[2] = {
 	0x84,			/* FAN 1/2 configuration */
 	0x95,			/* FAN 3 configuration */
@@ -276,6 +285,9 @@ struct w83791d_data {
 				   two sensors with three values
 				   (cur, over, hyst)  */
 
+	/* PWMs */
+	u8 pwm[5];		/* pwm duty cycle */
+
 	/* Misc */
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 beep_enable;		/* Global beep enable */
@@ -653,6 +665,48 @@ static struct sensor_device_attribute sd
 	SENSOR_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22),
 };
 
+/* read/write PWMs */
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83791d_data *data = w83791d_update_device(dev);
+	return sprintf(buf, "%u\n", data->pwm[nr]);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83791d_data *data = i2c_get_clientdata(client);
+	int nr = sensor_attr->index;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
+	w83791d_write(client, W83791D_REG_PWM[nr], data->pwm[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static struct sensor_device_attribute sda_pwm[] = {
+	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 0),
+	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 1),
+	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 2),
+	SENSOR_ATTR(pwm4, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 3),
+	SENSOR_ATTR(pwm5, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 4),
+};
+
 /* read/write the temperature1, includes measured value and limits */
 static ssize_t show_temp1(struct device *dev, struct device_attribute 
*devattr,
 				char *buf)
@@ -917,6 +971,9 @@ static struct attribute *w83791d_attribu
 	&sda_beep_ctrl[1].dev_attr.attr,
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
+	&sda_pwm[0].dev_attr.attr,
+	&sda_pwm[1].dev_attr.attr,
+	&sda_pwm[2].dev_attr.attr,
 	NULL
 };
 
@@ -930,6 +987,8 @@ static const struct attribute_group w837
 static struct attribute *w83791d_attributes_fanpwm45[] = {
 	FAN_UNIT_ATTRS(3),
 	FAN_UNIT_ATTRS(4),
+	&sda_pwm[3].dev_attr.attr,
+	&sda_pwm[4].dev_attr.attr,
 	NULL
 };
 
@@ -1259,6 +1318,12 @@ static struct w83791d_data *w83791d_upda
 		for (i = 0; i < 3; i++)
 			data->fan_div[i] |= (vbat_reg >> (3 + i)) & 0x04;
 
+		/* Update PWM duty cycle */
+		for (i = 0; i < NUMBER_OF_PWM; i++) {
+			data->pwm[i] =  w83791d_read(client,
+						W83791D_REG_PWM[i]);
+		}
+
 		/* Update the first temperature sensor */
 		for (i = 0; i < 3; i++) {
 			data->temp1[i] = w83791d_read(client,
Index: linux-2.6.27-rc1/Documentation/hwmon/w83791d
===================================================================
--- linux-2.6.27-rc1.orig/Documentation/hwmon/w83791d
+++ linux-2.6.27-rc1/Documentation/hwmon/w83791d
@@ -58,29 +58,32 @@ internal state that allows no clean acce
 currently selected). If you know the address of the chip, use a 'force'
 parameter; this will put it into a more well-behaved state first.
 
-The driver implements three temperature sensors, five fan rotation speed
-sensors, and ten voltage sensors.
+The driver implements three temperature sensors, ten voltage sensors,
+five fan rotation speed sensors and manual PWM control of each fan.
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
 the temperature gets higher than the Overtemperature Shutdown value; it stays
 on until the temperature falls below the Hysteresis value.
 
+Voltage sensors (also known as IN sensors) report their values in millivolts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit.
+
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
 readings can be divided by a programmable divider (1, 2, 4, 8, 16,
 32, 64 or 128 for all fans) to give the readings more range or accuracy.
 
-Voltage sensors (also known as IN sensors) report their values in millivolts.
-An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit.
+Each fan controlled is controlled by PWM. The PWM duty cycle can be read and
+set for each fan separately. Valid values range from 0 (stop) to 255 (full).
 
 The w83791d has a global bit used to enable beeping from the speaker when an
 alarm is triggered as well as a bitmask to enable or disable the beep for
 specific alarms. You need both the global beep enable bit and the
 corresponding beep bit to be on for a triggered alarm to sound a beep.
 
-The sysfs interface to the gloabal enable is via the sysfs beep_enable file.
+The sysfs interface to the global enable is via the sysfs beep_enable file.
 This file is used for both legacy and new code.
 
 The sysfs interface to the beep bitmask has migrated from the original legacy

--Boundary-00=_RRNmIa/U0UQjOl+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="w83791d_pwm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w83791d_pwm.patch"

Add PWM manual control.

Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>

---
 Documentation/hwmon/w83791d |   15 +++++----
 drivers/hwmon/w83791d.c     |   67 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 7 deletions(-)

---
Index: linux-2.6.27-rc1/drivers/hwmon/w83791d.c
===================================================================
--- linux-2.6.27-rc1.orig/drivers/hwmon/w83791d.c
+++ linux-2.6.27-rc1/drivers/hwmon/w83791d.c
@@ -23,7 +23,7 @@
     Supports following chips:
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83791d	10	5	3	3	0x71	0x5ca3	yes	no
+    w83791d	10	5	5	3	0x71	0x5ca3	yes	no
 
     The w83791d chip appears to be part way between the 83781d and the
     83792d. Thus, this file is derived from both the w83792d.c and
@@ -45,6 +45,7 @@
 #define NUMBER_OF_VIN		10
 #define NUMBER_OF_FANIN		5
 #define NUMBER_OF_TEMPIN	3
+#define NUMBER_OF_PWM		5
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
@@ -116,6 +117,14 @@ static const u8 W83791D_REG_FAN_MIN[NUMB
 	0xBD,			/* FAN 5 Count Low Limit in DataSheet */
 };
 
+static const u8 W83791D_REG_PWM[NUMBER_OF_PWM] = {
+	0x81,			/* PWM 1 duty cycle register in DataSheet */
+	0x83,			/* PWM 2 duty cycle register in DataSheet */
+	0x94,			/* PWM 3 duty cycle register in DataSheet */
+	0xA0,			/* PWM 4 duty cycle register in DataSheet */
+	0xA1,			/* PWM 5 duty cycle register in DataSheet */
+};
+
 static const u8 W83791D_REG_FAN_CFG[2] = {
 	0x84,			/* FAN 1/2 configuration */
 	0x95,			/* FAN 3 configuration */
@@ -276,6 +285,9 @@ struct w83791d_data {
 				   two sensors with three values
 				   (cur, over, hyst)  */
 
+	/* PWMs */
+	u8 pwm[5];		/* pwm duty cycle */
+
 	/* Misc */
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 beep_enable;		/* Global beep enable */
@@ -653,6 +665,48 @@ static struct sensor_device_attribute sd
 	SENSOR_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22),
 };
 
+/* read/write PWMs */
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83791d_data *data = w83791d_update_device(dev);
+	return sprintf(buf, "%u\n", data->pwm[nr]);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83791d_data *data = i2c_get_clientdata(client);
+	int nr = sensor_attr->index;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
+	w83791d_write(client, W83791D_REG_PWM[nr], data->pwm[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static struct sensor_device_attribute sda_pwm[] = {
+	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 0),
+	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 1),
+	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 2),
+	SENSOR_ATTR(pwm4, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 3),
+	SENSOR_ATTR(pwm5, S_IWUSR | S_IRUGO,
+			show_pwm, store_pwm, 4),
+};
+
 /* read/write the temperature1, includes measured value and limits */
 static ssize_t show_temp1(struct device *dev, struct device_attribute *devattr,
 				char *buf)
@@ -917,6 +971,9 @@ static struct attribute *w83791d_attribu
 	&sda_beep_ctrl[1].dev_attr.attr,
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
+	&sda_pwm[0].dev_attr.attr,
+	&sda_pwm[1].dev_attr.attr,
+	&sda_pwm[2].dev_attr.attr,
 	NULL
 };
 
@@ -930,6 +987,8 @@ static const struct attribute_group w837
 static struct attribute *w83791d_attributes_fanpwm45[] = {
 	FAN_UNIT_ATTRS(3),
 	FAN_UNIT_ATTRS(4),
+	&sda_pwm[3].dev_attr.attr,
+	&sda_pwm[4].dev_attr.attr,
 	NULL
 };
 
@@ -1259,6 +1318,12 @@ static struct w83791d_data *w83791d_upda
 		for (i = 0; i < 3; i++)
 			data->fan_div[i] |= (vbat_reg >> (3 + i)) & 0x04;
 
+		/* Update PWM duty cycle */
+		for (i = 0; i < NUMBER_OF_PWM; i++) {
+			data->pwm[i] =  w83791d_read(client,
+						W83791D_REG_PWM[i]);
+		}
+
 		/* Update the first temperature sensor */
 		for (i = 0; i < 3; i++) {
 			data->temp1[i] = w83791d_read(client,
Index: linux-2.6.27-rc1/Documentation/hwmon/w83791d
===================================================================
--- linux-2.6.27-rc1.orig/Documentation/hwmon/w83791d
+++ linux-2.6.27-rc1/Documentation/hwmon/w83791d
@@ -58,29 +58,32 @@ internal state that allows no clean acce
 currently selected). If you know the address of the chip, use a 'force'
 parameter; this will put it into a more well-behaved state first.
 
-The driver implements three temperature sensors, five fan rotation speed
-sensors, and ten voltage sensors.
+The driver implements three temperature sensors, ten voltage sensors,
+five fan rotation speed sensors and manual PWM control of each fan.
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
 the temperature gets higher than the Overtemperature Shutdown value; it stays
 on until the temperature falls below the Hysteresis value.
 
+Voltage sensors (also known as IN sensors) report their values in millivolts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit.
+
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
 readings can be divided by a programmable divider (1, 2, 4, 8, 16,
 32, 64 or 128 for all fans) to give the readings more range or accuracy.
 
-Voltage sensors (also known as IN sensors) report their values in millivolts.
-An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit.
+Each fan controlled is controlled by PWM. The PWM duty cycle can be read and
+set for each fan separately. Valid values range from 0 (stop) to 255 (full).
 
 The w83791d has a global bit used to enable beeping from the speaker when an
 alarm is triggered as well as a bitmask to enable or disable the beep for
 specific alarms. You need both the global beep enable bit and the
 corresponding beep bit to be on for a triggered alarm to sound a beep.
 
-The sysfs interface to the gloabal enable is via the sysfs beep_enable file.
+The sysfs interface to the global enable is via the sysfs beep_enable file.
 This file is used for both legacy and new code.
 
 The sysfs interface to the beep bitmask has migrated from the original legacy

--Boundary-00=_RRNmIa/U0UQjOl+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_RRNmIa/U0UQjOl+--
