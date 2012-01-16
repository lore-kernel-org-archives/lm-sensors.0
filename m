From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:41 +0000
Subject: [lm-sensors] [PATCH 39/39] hwmon: (w83627hf) Fix checkpatch issues
Message-Id: <1326703781-14272-40-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
ERROR: do not use assignment in if condition

Other checkpatch issues not fixed to reduce number of conflicts with pending
rewrite as mfd driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |  136 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 103 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index bde50e3..be0efb2 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -427,7 +427,12 @@ store_in_min(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -441,7 +446,12 @@ store_in_max(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -506,9 +516,12 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
 	const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	
@@ -533,9 +546,12 @@ static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *a
 	const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -584,7 +600,12 @@ store_fan_min(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -645,9 +666,15 @@ store_temp_max(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
-	u16 tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
+	u16 tmp;
+	long val;
+	int err;
 
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
+	tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = tmp;
 	w83627hf_write_value(data, w83627hf_reg_temp_over[nr], tmp);
@@ -661,9 +688,15 @@ store_temp_max_hyst(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
-	u16 tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
+	u16 tmp;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
+	tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
 	mutex_lock(&data->update_lock);
 	data->temp_max_hyst[nr] = tmp;
 	w83627hf_write_value(data, w83627hf_reg_temp_hyst[nr], tmp);
@@ -701,10 +734,13 @@ static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 
 	return count;
 }
@@ -755,8 +791,11 @@ store_beep_mask(struct device *dev, struct device_attribute *attr,
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -791,10 +830,14 @@ store_beep(struct device *dev, struct device_attribute *attr,
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
-	unsigned long bit;
 	u8 reg;
+	unsigned long bit;
+	int err;
+
+	err = kstrtoul(buf, 10, &bit);
+	if (err)
+		return err;
 
-	bit = simple_strtoul(buf, NULL, 10);
 	if (bit & ~1)
 		return -EINVAL;
 
@@ -884,7 +927,12 @@ store_fan_div(struct device *dev, struct device_attribute *devattr,
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long min;
 	u8 reg;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -933,7 +981,12 @@ store_pwm(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -974,10 +1027,15 @@ store_pwm_enable(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
+	unsigned long val;
+	int err;
 
-	if (!val || (val > 3))	/* modes 1, 2 and 3 are supported */
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (!val || val > 3)	/* modes 1, 2 and 3 are supported */
 		return -EINVAL;
 	mutex_lock(&data->update_lock);
 	data->pwm_enable[nr] = val;
@@ -1016,9 +1074,12 @@ store_pwm_freq(struct device *dev, struct device_attribute *devattr,
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	static const u8 mask[]={0xF8, 0x8F};
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -1060,9 +1121,13 @@ store_temp_type(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val, tmp;
+	unsigned long val;
+	u32 tmp;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -1290,7 +1355,8 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 		goto ERROR0;
 	}
 
-	if (!(data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
@@ -1311,7 +1377,8 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	w83627hf_update_fan_div(data);
 
 	/* Register common device attributes */
-	if ((err = sysfs_create_group(&dev->kobj, &w83627hf_group)))
+	err = sysfs_create_group(&dev->kobj, &w83627hf_group);
+	if (err)
 		goto ERROR3;
 
 	/* Register chip-specific device attributes */
@@ -1387,10 +1454,11 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	}
 
 	if (data->type = w83627thf || data->type = w83637hf
-	 || data->type = w83687thf)
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm3.dev_attr)))
+	    || data->type = w83687thf) {
+		err = device_create_file(dev, &sensor_dev_attr_pwm3.dev_attr);
+		if (err)
 			goto ERROR4;
+	}
 
 	if (data->type = w83637hf || data->type = w83687thf)
 		if ((err = device_create_file(dev,
@@ -1409,10 +1477,12 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 			goto ERROR4;
 
 	if (data->type = w83627thf || data->type = w83637hf
-	 || data->type = w83687thf)
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm3_enable.dev_attr)))
+	    || data->type = w83687thf) {
+		err = device_create_file(dev,
+					 &sensor_dev_attr_pwm3_enable.dev_attr);
+		if (err)
 			goto ERROR4;
+	}
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
