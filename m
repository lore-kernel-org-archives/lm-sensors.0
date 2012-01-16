From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:26 +0000
Subject: [lm-sensors] [PATCH 24/39] hwmon: (pc87360) Fix checkpatch issues
Message-Id: <1326703781-14272-25-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: "foo * bar" should be "foo *bar"
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxE)
ERROR: spaces required around that '=' (ctx:VxV)
WARNING: braces {} are not necessary for single statement blocks
WARNING: line over 80 characters
WARNING: please, no space before tabs
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not or not all fixed (code complexity):
ERROR: Macros with complex values should be enclosed in parenthesis
ERROR: do not use assignment in if condition

Cc: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pc87360.c |  404 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 260 insertions(+), 144 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 3d99b88..51c97ca 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -56,11 +56,11 @@ static u8 confreg[4];
 static int init = 1;
 module_param(init, int, 0);
 MODULE_PARM_DESC(init,
- "Chip initialization level:\n"
- " 0: None\n"
- "*1: Forcibly enable internal voltage and temperature channels, except in9\n"
- " 2: Forcibly enable all voltage and temperature channels, except in9\n"
- " 3: Forcibly enable all voltage and temperature channels, including in9");
+"Chip initialization level:\n"
+" 0: None\n"
+"*1: Forcibly enable internal voltage and temperature channels, except in9\n"
+" 2: Forcibly enable all voltage and temperature channels, except in9\n"
+" 3: Forcibly enable all voltage and temperature channels, including in9");
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -88,19 +88,19 @@ static const u8 logdev[LDNI_MAX] = { FSCM, VLM, TMS };
 static inline void superio_outb(int sioaddr, int reg, int val)
 {
 	outb(reg, sioaddr);
-	outb(val, sioaddr+1);
+	outb(val, sioaddr + 1);
 }
 
 static inline int superio_inb(int sioaddr, int reg)
 {
 	outb(reg, sioaddr);
-	return inb(sioaddr+1);
+	return inb(sioaddr + 1);
 }
 
 static inline void superio_exit(int sioaddr)
 {
 	outb(0x02, sioaddr);
-	outb(0x02, sioaddr+1);
+	outb(0x02, sioaddr + 1);
 }
 
 /*
@@ -122,18 +122,18 @@ static inline void superio_exit(int sioaddr)
 #define PC87360_REG_FAN(nr)		(0x07 + 3 * (nr))
 #define PC87360_REG_FAN_STATUS(nr)	(0x08 + 3 * (nr))
 
-#define FAN_FROM_REG(val,div)		((val) = 0 ? 0: \
-					 480000 / ((val)*(div)))
-#define FAN_TO_REG(val,div)		((val) <= 100 ? 0 : \
-					 480000 / ((val)*(div)))
-#define FAN_DIV_FROM_REG(val)		(1 << ((val >> 5) & 0x03))
+#define FAN_FROM_REG(val, div)		((val) = 0 ? 0 : \
+					 480000 / ((val) * (div)))
+#define FAN_TO_REG(val, div)		((val) <= 100 ? 0 : \
+					 480000 / ((val) * (div)))
+#define FAN_DIV_FROM_REG(val)		(1 << (((val) >> 5) & 0x03))
 #define FAN_STATUS_FROM_REG(val)	((val) & 0x07)
 
-#define FAN_CONFIG_MONITOR(val,nr)	(((val) >> (2 + nr * 3)) & 1)
-#define FAN_CONFIG_CONTROL(val,nr)	(((val) >> (3 + nr * 3)) & 1)
-#define FAN_CONFIG_INVERT(val,nr)	(((val) >> (4 + nr * 3)) & 1)
+#define FAN_CONFIG_MONITOR(val, nr)	(((val) >> (2 + (nr) * 3)) & 1)
+#define FAN_CONFIG_CONTROL(val, nr)	(((val) >> (3 + (nr) * 3)) & 1)
+#define FAN_CONFIG_INVERT(val, nr)	(((val) >> (4 + (nr) * 3)) & 1)
 
-#define PWM_FROM_REG(val,inv)		((inv) ? 255 - (val) : (val))
+#define PWM_FROM_REG(val, inv)		((inv) ? 255 - (val) : (val))
 static inline u8 PWM_TO_REG(int val, int inv)
 {
 	if (inv)
@@ -159,10 +159,10 @@ static inline u8 PWM_TO_REG(int val, int inv)
 #define PC87365_REG_IN_ALARMS2		0x01
 #define PC87365_REG_VID			0x06
 
-#define IN_FROM_REG(val,ref)		(((val) * (ref) + 128) / 256)
-#define IN_TO_REG(val,ref)		((val) < 0 ? 0 : \
-					 (val)*256 >= (ref)*255 ? 255: \
-					 ((val) * 256 + (ref)/2) / (ref))
+#define IN_FROM_REG(val, ref)		(((val) * (ref) + 128) / 256)
+#define IN_TO_REG(val, ref)		((val) < 0 ? 0 : \
+					 (val) * 256 >= (ref) * 255 ? 255 : \
+					 ((val) * 256 + (ref) / 2) / (ref))
 
 /*
  * Temperature registers and conversions
@@ -255,43 +255,54 @@ static struct platform_driver pc87360_driver = {
  * Sysfs stuff
  */
 
-static ssize_t show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_fan_input(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index],
 		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
 }
-static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_fan_min(struct device *dev,
+			    struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index],
 		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
 }
-static ssize_t show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_fan_div(struct device *dev,
+			    struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
 		       FAN_DIV_FROM_REG(data->fan_status[attr->index]));
 }
-static ssize_t show_fan_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_fan_status(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
 		       FAN_STATUS_FROM_REG(data->fan_status[attr->index]));
 }
-static ssize_t set_fan_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+static ssize_t set_fan_min(struct device *dev,
+			   struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long fan_min = simple_strtol(buf, NULL, 10);
+	long fan_min;
+	int err;
+
+	err = kstrtol(buf, 10, &fan_min);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	fan_min = FAN_TO_REG(fan_min, FAN_DIV_FROM_REG(data->fan_status[attr->index]));
+	fan_min = FAN_TO_REG(fan_min,
+			     FAN_DIV_FROM_REG(data->fan_status[attr->index]));
 
 	/* If it wouldn't fit, change clock divisor */
 	while (fan_min > 255
@@ -301,11 +312,13 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *devattr,
 		data->fan_status[attr->index] += 0x20;
 	}
 	data->fan_min[attr->index] = fan_min > 255 ? 255 : fan_min;
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_MIN(attr->index),
+	pc87360_write_value(data, LD_FAN, NO_BANK,
+			    PC87360_REG_FAN_MIN(attr->index),
 			    data->fan_min[attr->index]);
 
 	/* Write new divider, preserve alarm bits */
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_STATUS(attr->index),
+	pc87360_write_value(data, LD_FAN, NO_BANK,
+			    PC87360_REG_FAN_STATUS(attr->index),
 			    data->fan_status[attr->index] & 0xF9);
 	mutex_unlock(&data->update_lock);
 
@@ -339,7 +352,8 @@ static struct sensor_device_attribute fan_min[] = {
 	&fan_div[X].dev_attr.attr,	\
 	&fan_min[X].dev_attr.attr
 
-static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
@@ -348,12 +362,17 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, ch
 				    FAN_CONFIG_INVERT(data->fan_conf,
 						      attr->index)));
 }
-static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
+		       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm[attr->index] = PWM_TO_REG(val,
@@ -370,7 +389,7 @@ static struct sensor_device_attribute pwm[] = {
 	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
 };
 
-static struct attribute * pc8736x_fan_attr_array[] = {
+static struct attribute *pc8736x_fan_attr_array[] = {
 	FAN_UNIT_ATTRS(0),
 	FAN_UNIT_ATTRS(1),
 	FAN_UNIT_ATTRS(2),
@@ -383,39 +402,48 @@ static const struct attribute_group pc8736x_fan_group = {
 	.attrs = pc8736x_fan_attr_array,
 };
 
-static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_in_input(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
 		       data->in_vref));
 }
-static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_in_min(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
 		       data->in_vref));
 }
-static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_in_max(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
 		       data->in_vref));
 }
-static ssize_t show_in_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_in_status(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_status[attr->index]);
 }
-static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref);
@@ -424,12 +452,17 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] = IN_TO_REG(val,
@@ -554,27 +587,38 @@ static struct sensor_device_attribute in_max_alarm[] = {
 	&in_min_alarm[X].dev_attr.attr,	\
 	&in_max_alarm[X].dev_attr.attr
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct pc87360_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct pc87360_data *data = dev_get_drvdata(dev);
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
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in_alarms(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_alarms);
@@ -602,46 +646,58 @@ static const struct attribute_group pc8736x_vin_group = {
 	.attrs = pc8736x_vin_attr_array,
 };
 
-static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_therm_input(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
 		       data->in_vref));
 }
-static ssize_t show_therm_min(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_therm_min(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
 		       data->in_vref));
 }
-static ssize_t show_therm_max(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_therm_max(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
 		       data->in_vref));
 }
-static ssize_t show_therm_crit(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_therm_crit(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-11],
 		       data->in_vref));
 }
-static ssize_t show_therm_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_therm_status(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_status[attr->index]);
 }
-static ssize_t set_therm_min(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+
+static ssize_t set_therm_min(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref);
@@ -650,12 +706,19 @@ static ssize_t set_therm_min(struct device *dev, struct device_attribute *devatt
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_therm_max(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+
+static ssize_t set_therm_max(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] = IN_TO_REG(val, data->in_vref);
@@ -664,12 +727,18 @@ static ssize_t set_therm_max(struct device *dev, struct device_attribute *devatt
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_therm_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_therm_crit(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_crit[attr->index-11] = IN_TO_REG(val, data->in_vref);
@@ -683,38 +752,38 @@ static ssize_t set_therm_crit(struct device *dev, struct device_attribute *devat
    used in the chip to measure voltage across the thermistors
 */
 static struct sensor_device_attribute therm_input[] = {
-	SENSOR_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, 0+11),
-	SENSOR_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, 1+11),
-	SENSOR_ATTR(temp6_input, S_IRUGO, show_therm_input, NULL, 2+11),
+	SENSOR_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, 0 + 11),
+	SENSOR_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, 1 + 11),
+	SENSOR_ATTR(temp6_input, S_IRUGO, show_therm_input, NULL, 2 + 11),
 };
 static struct sensor_device_attribute therm_status[] = {
-	SENSOR_ATTR(temp4_status, S_IRUGO, show_therm_status, NULL, 0+11),
-	SENSOR_ATTR(temp5_status, S_IRUGO, show_therm_status, NULL, 1+11),
-	SENSOR_ATTR(temp6_status, S_IRUGO, show_therm_status, NULL, 2+11),
+	SENSOR_ATTR(temp4_status, S_IRUGO, show_therm_status, NULL, 0 + 11),
+	SENSOR_ATTR(temp5_status, S_IRUGO, show_therm_status, NULL, 1 + 11),
+	SENSOR_ATTR(temp6_status, S_IRUGO, show_therm_status, NULL, 2 + 11),
 };
 static struct sensor_device_attribute therm_min[] = {
 	SENSOR_ATTR(temp4_min, S_IRUGO | S_IWUSR,
-		    show_therm_min, set_therm_min, 0+11),
+		    show_therm_min, set_therm_min, 0 + 11),
 	SENSOR_ATTR(temp5_min, S_IRUGO | S_IWUSR,
-		    show_therm_min, set_therm_min, 1+11),
+		    show_therm_min, set_therm_min, 1 + 11),
 	SENSOR_ATTR(temp6_min, S_IRUGO | S_IWUSR,
-		    show_therm_min, set_therm_min, 2+11),
+		    show_therm_min, set_therm_min, 2 + 11),
 };
 static struct sensor_device_attribute therm_max[] = {
 	SENSOR_ATTR(temp4_max, S_IRUGO | S_IWUSR,
-		    show_therm_max, set_therm_max, 0+11),
+		    show_therm_max, set_therm_max, 0 + 11),
 	SENSOR_ATTR(temp5_max, S_IRUGO | S_IWUSR,
-		    show_therm_max, set_therm_max, 1+11),
+		    show_therm_max, set_therm_max, 1 + 11),
 	SENSOR_ATTR(temp6_max, S_IRUGO | S_IWUSR,
-		    show_therm_max, set_therm_max, 2+11),
+		    show_therm_max, set_therm_max, 2 + 11),
 };
 static struct sensor_device_attribute therm_crit[] = {
 	SENSOR_ATTR(temp4_crit, S_IRUGO | S_IWUSR,
-		    show_therm_crit, set_therm_crit, 0+11),
+		    show_therm_crit, set_therm_crit, 0 + 11),
 	SENSOR_ATTR(temp5_crit, S_IRUGO | S_IWUSR,
-		    show_therm_crit, set_therm_crit, 1+11),
+		    show_therm_crit, set_therm_crit, 1 + 11),
 	SENSOR_ATTR(temp6_crit, S_IRUGO | S_IWUSR,
-		    show_therm_crit, set_therm_crit, 2+11),
+		    show_therm_crit, set_therm_crit, 2 + 11),
 };
 
 /* show_therm_min/max_alarm() reads data from the per-channel voltage
@@ -747,27 +816,27 @@ static ssize_t show_therm_crit_alarm(struct device *dev,
 
 static struct sensor_device_attribute therm_min_alarm[] = {
 	SENSOR_ATTR(temp4_min_alarm, S_IRUGO,
-		    show_therm_min_alarm, NULL, 0+11),
+		    show_therm_min_alarm, NULL, 0 + 11),
 	SENSOR_ATTR(temp5_min_alarm, S_IRUGO,
-		    show_therm_min_alarm, NULL, 1+11),
+		    show_therm_min_alarm, NULL, 1 + 11),
 	SENSOR_ATTR(temp6_min_alarm, S_IRUGO,
-		    show_therm_min_alarm, NULL, 2+11),
+		    show_therm_min_alarm, NULL, 2 + 11),
 };
 static struct sensor_device_attribute therm_max_alarm[] = {
 	SENSOR_ATTR(temp4_max_alarm, S_IRUGO,
-		    show_therm_max_alarm, NULL, 0+11),
+		    show_therm_max_alarm, NULL, 0 + 11),
 	SENSOR_ATTR(temp5_max_alarm, S_IRUGO,
-		    show_therm_max_alarm, NULL, 1+11),
+		    show_therm_max_alarm, NULL, 1 + 11),
 	SENSOR_ATTR(temp6_max_alarm, S_IRUGO,
-		    show_therm_max_alarm, NULL, 2+11),
+		    show_therm_max_alarm, NULL, 2 + 11),
 };
 static struct sensor_device_attribute therm_crit_alarm[] = {
 	SENSOR_ATTR(temp4_crit_alarm, S_IRUGO,
-		    show_therm_crit_alarm, NULL, 0+11),
+		    show_therm_crit_alarm, NULL, 0 + 11),
 	SENSOR_ATTR(temp5_crit_alarm, S_IRUGO,
-		    show_therm_crit_alarm, NULL, 1+11),
+		    show_therm_crit_alarm, NULL, 1 + 11),
 	SENSOR_ATTR(temp6_crit_alarm, S_IRUGO,
-		    show_therm_crit_alarm, NULL, 2+11),
+		    show_therm_crit_alarm, NULL, 2 + 11),
 };
 
 #define THERM_UNIT_ATTRS(X) \
@@ -780,7 +849,7 @@ static struct sensor_device_attribute therm_crit_alarm[] = {
 	&therm_max_alarm[X].dev_attr.attr, \
 	&therm_crit_alarm[X].dev_attr.attr
 
-static struct attribute * pc8736x_therm_attr_array[] = {
+static struct attribute *pc8736x_therm_attr_array[] = {
 	THERM_UNIT_ATTRS(0),
 	THERM_UNIT_ATTRS(1),
 	THERM_UNIT_ATTRS(2),
@@ -790,42 +859,59 @@ static const struct attribute_group pc8736x_therm_group = {
 	.attrs = pc8736x_therm_attr_array,
 };
 
-static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_temp_input(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }
-static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr, char *buf)
+
+static ssize_t show_temp_min(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index]));
 }
-static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr, char *buf)
+
+static ssize_t show_temp_max(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index]));
 }
-static ssize_t show_temp_crit(struct device *dev, struct device_attribute *devattr, char *buf)
+
+static ssize_t show_temp_crit(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index]));
+	return sprintf(buf, "%d\n",
+		       TEMP_FROM_REG(data->temp_crit[attr->index]));
 }
-static ssize_t show_temp_status(struct device *dev, struct device_attribute *devattr, char *buf)
+
+static ssize_t show_temp_status(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_status[attr->index]);
 }
-static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+
+static ssize_t set_temp_min(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[attr->index] = TEMP_TO_REG(val);
@@ -834,12 +920,19 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_temp_max(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+
+static ssize_t set_temp_max(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[attr->index] = TEMP_TO_REG(val);
@@ -848,12 +941,19 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *devattr
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_temp_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+
+static ssize_t set_temp_crit(struct device *dev,
+			     struct device_attribute *devattr, const char *buf,
+			     size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_crit[attr->index] = TEMP_TO_REG(val);
@@ -898,11 +998,13 @@ static struct sensor_device_attribute temp_crit[] = {
 		    show_temp_crit, set_temp_crit, 2),
 };
 
-static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_alarms(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->temp_alarms);
 }
+
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
 /* show_temp_min/max_alarm() reads data from the per-channel status
@@ -917,6 +1019,7 @@ static ssize_t show_temp_min_alarm(struct device *dev,
 
 	return sprintf(buf, "%u\n", !!(data->temp_status[nr] & CHAN_ALM_MIN));
 }
+
 static ssize_t show_temp_max_alarm(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
@@ -925,6 +1028,7 @@ static ssize_t show_temp_max_alarm(struct device *dev,
 
 	return sprintf(buf, "%u\n", !!(data->temp_status[nr] & CHAN_ALM_MAX));
 }
+
 static ssize_t show_temp_crit_alarm(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
@@ -939,11 +1043,13 @@ static struct sensor_device_attribute temp_min_alarm[] = {
 	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 1),
 	SENSOR_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 2),
 };
+
 static struct sensor_device_attribute temp_max_alarm[] = {
 	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 0),
 	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 1),
 	SENSOR_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 2),
 };
+
 static struct sensor_device_attribute temp_crit_alarm[] = {
 	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 0),
 	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 1),
@@ -976,7 +1082,7 @@ static struct sensor_device_attribute temp_fault[] = {
 	&temp_crit_alarm[X].dev_attr.attr, \
 	&temp_fault[X].dev_attr.attr
 
-static struct attribute * pc8736x_temp_attr_array[] = {
+static struct attribute *pc8736x_temp_attr_array[] = {
 	TEMP_UNIT_ATTRS(0),
 	TEMP_UNIT_ATTRS(1),
 	TEMP_UNIT_ATTRS(2),
@@ -984,6 +1090,7 @@ static struct attribute * pc8736x_temp_attr_array[] = {
 	&dev_attr_alarms_temp.attr,
 	NULL
 };
+
 static const struct attribute_group pc8736x_temp_group = {
 	.attrs = pc8736x_temp_attr_array,
 };
@@ -994,13 +1101,15 @@ static ssize_t show_name(struct device *dev,
 	struct pc87360_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", data->name);
 }
+
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 /*
  * Device detection, registration and update
  */
 
-static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
+static int __init pc87360_find(int sioaddr, u8 *devid,
+			       unsigned short *addresses)
 {
 	u16 val;
 	int i;
@@ -1047,7 +1156,7 @@ static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses
 
 		addresses[i] = val;
 
-		if (i=0) { /* Fans */
+		if (i = 0) { /* Fans */
 			confreg[0] = superio_inb(sioaddr, 0xF0);
 			confreg[1] = superio_inb(sioaddr, 0xF1);
 
@@ -1060,7 +1169,7 @@ static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses
 			pr_debug("Fan %d: mon=%d ctrl=%d inv=%d\n", 3,
 				 confreg[1] & 1, (confreg[1] >> 1) & 1,
 				 (confreg[1] >> 2) & 1);
-		} else if (i=1) { /* Voltages */
+		} else if (i = 1) { /* Voltages */
 			/* Are we using thermistors? */
 			if (*devid = 0xE9) { /* PC87366 */
 				/* These registers are not logical-device
@@ -1094,7 +1203,8 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	int use_thermistors = 0;
 	struct device *dev = &pdev->dev;
 
-	if (!(data = kzalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct pc87360_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	data->fannr = 2;
@@ -1130,9 +1240,10 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	for (i = 0; i < LDNI_MAX; i++) {
-		if (((data->address[i] = extra_isa[i]))
+		data->address[i] = extra_isa[i];
+		if (data->address[i]
 		 && !request_region(extra_isa[i], PC87360_EXTENT,
-		 		    pc87360_driver.driver.name)) {
+				    pc87360_driver.driver.name)) {
 			dev_err(dev, "Region 0x%x-0x%x already "
 				"in use!\n", extra_isa[i],
 				extra_isa[i]+PC87360_EXTENT-1);
@@ -1182,15 +1293,17 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 
 	/* Register all-or-nothing sysfs groups */
 
-	if (data->innr &&
-	    (err = sysfs_create_group(&dev->kobj,
-				      &pc8736x_vin_group)))
-		goto ERROR3;
+	if (data->innr) {
+		err = sysfs_create_group(&dev->kobj, &pc8736x_vin_group);
+		if (err)
+			goto ERROR3;
+	}
 
-	if (data->innr = 14 &&
-	    (err = sysfs_create_group(&dev->kobj,
-				      &pc8736x_therm_group)))
-		goto ERROR3;
+	if (data->innr = 14) {
+		err = sysfs_create_group(&dev->kobj, &pc8736x_therm_group);
+		if (err)
+			goto ERROR3;
+	}
 
 	/* create device attr-files for varying sysfs groups */
 
@@ -1216,7 +1329,8 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 					&temp_fault[i].dev_attr)))
 				goto ERROR3;
 		}
-		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
+		err = device_create_file(dev, &dev_attr_alarms_temp);
+		if (err)
 			goto ERROR3;
 	}
 
@@ -1232,12 +1346,15 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 					&fan_status[i].dev_attr))))
 			goto ERROR3;
 
-		if (FAN_CONFIG_CONTROL(data->fan_conf, i)
-		    && (err = device_create_file(dev, &pwm[i].dev_attr)))
-			goto ERROR3;
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i)) {
+			err = device_create_file(dev, &pwm[i].dev_attr);
+			if (err)
+				goto ERROR3;
+		}
 	}
 
-	if ((err = device_create_file(dev, &dev_attr_name)))
+	err = device_create_file(dev, &dev_attr_name);
+	if (err)
 		goto ERROR3;
 
 	data->hwmon_dev = hwmon_device_register(dev);
@@ -1255,9 +1372,8 @@ ERROR3:
 	sysfs_remove_group(&dev->kobj, &pc8736x_therm_group);
 	sysfs_remove_group(&dev->kobj, &pc8736x_vin_group);
 	for (i = 0; i < 3; i++) {
-		if (data->address[i]) {
+		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-		}
 	}
 ERROR1:
 	kfree(data);
@@ -1278,9 +1394,8 @@ static int __devexit pc87360_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_vin_group);
 
 	for (i = 0; i < 3; i++) {
-		if (data->address[i]) {
+		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-		}
 	}
 	kfree(data);
 
@@ -1375,12 +1490,12 @@ static void pc87360_init_device(struct platform_device *pdev,
 	for (; i < data->tempnr; i++) {
 		reg = pc87360_read_value(data, LD_TEMP, i,
 					 PC87365_REG_TEMP_STATUS);
-		dev_dbg(&pdev->dev, "bios temp%d_status:0x%02x\n", i+1, reg);
+		dev_dbg(&pdev->dev, "bios temp%d_status:0x%02x\n", i + 1, reg);
 		if (init >= init_temp[i]) {
 			/* Forcibly enable temperature channel */
 			if (!(reg & CHAN_ENA)) {
-				dev_dbg(&pdev->dev, "Forcibly "
-					"enabling temp%d\n", i+1);
+				dev_dbg(&pdev->dev,
+					"Forcibly enabling temp%d\n", i + 1);
 				pc87360_write_value(data, LD_TEMP, i,
 						    PC87365_REG_TEMP_STATUS,
 						    0xCF);
@@ -1394,11 +1509,11 @@ static void pc87360_init_device(struct platform_device *pdev,
 				/* The pin may already be used by thermal
 				   diodes */
 				reg = pc87360_read_value(data, LD_TEMP,
-				      (i-11)/2, PC87365_REG_TEMP_STATUS);
+				      (i - 11) / 2, PC87365_REG_TEMP_STATUS);
 				if (reg & CHAN_ENA) {
-					dev_dbg(&pdev->dev, "Skipping "
-						"temp%d, pin already in use "
-						"by temp%d\n", i-7, (i-11)/2);
+					dev_dbg(&pdev->dev,
+			"Skipping temp%d, pin already in use by temp%d\n",
+						i - 7, (i - 11) / 2);
 					continue;
 				}
 
@@ -1406,8 +1521,9 @@ static void pc87360_init_device(struct platform_device *pdev,
 				reg = pc87360_read_value(data, LD_IN, i,
 							 PC87365_REG_IN_STATUS);
 				if (!(reg & CHAN_ENA)) {
-					dev_dbg(&pdev->dev, "Forcibly "
-						"enabling temp%d\n", i-7);
+					dev_dbg(&pdev->dev,
+						"Forcibly enabling temp%d\n",
+						i - 7);
 					pc87360_write_value(data, LD_IN, i,
 						PC87365_REG_TEMP_STATUS,
 						(reg & 0x60) | 0x8F);
@@ -1421,8 +1537,8 @@ static void pc87360_init_device(struct platform_device *pdev,
 					 PC87365_REG_IN_CONFIG);
 		dev_dbg(&pdev->dev, "bios vin-cfg:0x%02x\n", reg);
 		if (reg & CHAN_ENA) {
-			dev_dbg(&pdev->dev, "Forcibly "
-				"enabling monitoring (VLM)\n");
+			dev_dbg(&pdev->dev,
+				"Forcibly enabling monitoring (VLM)\n");
 			pc87360_write_value(data, LD_IN, NO_BANK,
 					    PC87365_REG_IN_CONFIG,
 					    reg & 0xFE);
@@ -1434,8 +1550,8 @@ static void pc87360_init_device(struct platform_device *pdev,
 					 PC87365_REG_TEMP_CONFIG);
 		dev_dbg(&pdev->dev, "bios temp-cfg:0x%02x\n", reg);
 		if (reg & CHAN_ENA) {
-			dev_dbg(&pdev->dev, "Forcibly enabling "
-				"monitoring (TMS)\n");
+			dev_dbg(&pdev->dev,
+				"Forcibly enabling monitoring (TMS)\n");
 			pc87360_write_value(data, LD_TEMP, NO_BANK,
 					    PC87365_REG_TEMP_CONFIG,
 					    reg & 0xFE);
@@ -1470,7 +1586,7 @@ static void pc87360_autodiv(struct device *dev, int nr)
 			data->fan[nr] >>= 1;
 			dev_dbg(dev, "Increasing "
 				"clock divider to %d for fan %d\n",
-				FAN_DIV_FROM_REG(data->fan_status[nr]), nr+1);
+				FAN_DIV_FROM_REG(data->fan_status[nr]), nr + 1);
 		}
 	} else {
 		/* Decrease clock divider if possible */
@@ -1483,7 +1599,7 @@ static void pc87360_autodiv(struct device *dev, int nr)
 			dev_dbg(dev, "Decreasing "
 				"clock divider to %d for fan %d\n",
 				FAN_DIV_FROM_REG(data->fan_status[nr]),
-				nr+1);
+				nr + 1);
 		}
 	}
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
