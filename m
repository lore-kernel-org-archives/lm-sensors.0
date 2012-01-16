From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:14 +0000
Subject: [lm-sensors] [PATCH 12/39] hwmon: (f71805f) Fix checkpatch issues
Message-Id: <1326703781-14272-13-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: "foo* bar" should be "foo *bar"
ERROR: need consistent spacing around '|' (ctx:VxW)
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
WARNING: static const char * array should probably be static const char * const

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71805f.c |  163 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 118 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 92f9497..859b203 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -202,7 +202,7 @@ struct f71805f_sio_data {
 
 static inline long in_from_reg(u8 reg)
 {
-	return (reg * 8);
+	return reg * 8;
 }
 
 /* The 2 least significant bits are not used */
@@ -212,13 +212,13 @@ static inline u8 in_to_reg(long val)
 		return 0;
 	if (val >= 2016)
 		return 0xfc;
-	return (((val + 16) / 32) << 2);
+	return ((val + 16) / 32) << 2;
 }
 
 /* in0 is downscaled by a factor 2 internally */
 static inline long in0_from_reg(u8 reg)
 {
-	return (reg * 16);
+	return reg * 16;
 }
 
 static inline u8 in0_to_reg(long val)
@@ -227,7 +227,7 @@ static inline u8 in0_to_reg(long val)
 		return 0;
 	if (val >= 4032)
 		return 0xfc;
-	return (((val + 32) / 64) << 2);
+	return ((val + 32) / 64) << 2;
 }
 
 /* The 4 most significant bits are not used */
@@ -236,7 +236,7 @@ static inline long fan_from_reg(u16 reg)
 	reg &= 0xfff;
 	if (!reg || reg = 0xfff)
 		return 0;
-	return (1500000 / reg);
+	return 1500000 / reg;
 }
 
 static inline u16 fan_to_reg(long rpm)
@@ -246,7 +246,7 @@ static inline u16 fan_to_reg(long rpm)
 	   so that no alarm will ever trigger. */
 	if (rpm < 367)
 		return 0xfff;
-	return (1500000 / rpm);
+	return 1500000 / rpm;
 }
 
 static inline unsigned long pwm_freq_from_reg(u8 reg)
@@ -278,7 +278,7 @@ static inline int pwm_mode_from_reg(u8 reg)
 
 static inline long temp_from_reg(u8 reg)
 {
-	return (reg * 1000);
+	return reg * 1000;
 }
 
 static inline u8 temp_to_reg(long val)
@@ -287,7 +287,7 @@ static inline u8 temp_to_reg(long val)
 		val = 0;
 	else if (val > 1000 * 0xff)
 		val = 0xff;
-	return ((val + 500) / 1000);
+	return (val + 500) / 1000;
 }
 
 /*
@@ -455,7 +455,12 @@ static ssize_t set_in0_max(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_high[nr] = in0_to_reg(val);
@@ -471,7 +476,12 @@ static ssize_t set_in0_min(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_low[nr] = in0_to_reg(val);
@@ -517,7 +527,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_high[nr] = in_to_reg(val);
@@ -533,7 +548,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_low[nr] = in_to_reg(val);
@@ -579,7 +599,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_low[nr] = fan_to_reg(val);
@@ -595,7 +620,12 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_target[nr] = fan_to_reg(val);
@@ -664,7 +694,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (val > 255)
 		return -EINVAL;
@@ -685,8 +720,13 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (val < 1 || val > 3)
 		return -EINVAL;
@@ -730,7 +770,12 @@ static ssize_t set_pwm_freq(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm_freq[nr] = pwm_freq_to_reg(val);
@@ -742,7 +787,7 @@ static ssize_t set_pwm_freq(struct device *dev, struct device_attribute
 
 static ssize_t show_pwm_auto_point_temp(struct device *dev,
 					struct device_attribute *devattr,
-					char* buf)
+					char *buf)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
@@ -755,13 +800,18 @@ static ssize_t show_pwm_auto_point_temp(struct device *dev,
 
 static ssize_t set_pwm_auto_point_temp(struct device *dev,
 				       struct device_attribute *devattr,
-				       const char* buf, size_t count)
+				       const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	int pwmnr = attr->nr;
 	int apnr = attr->index;
-	unsigned long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->auto_points[pwmnr].temp[apnr] = temp_to_reg(val);
@@ -774,7 +824,7 @@ static ssize_t set_pwm_auto_point_temp(struct device *dev,
 
 static ssize_t show_pwm_auto_point_fan(struct device *dev,
 				       struct device_attribute *devattr,
-				       char* buf)
+				       char *buf)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
@@ -787,18 +837,23 @@ static ssize_t show_pwm_auto_point_fan(struct device *dev,
 
 static ssize_t set_pwm_auto_point_fan(struct device *dev,
 				      struct device_attribute *devattr,
-				      const char* buf, size_t count)
+				      const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	int pwmnr = attr->nr;
 	int apnr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->auto_points[pwmnr].fan[apnr] = fan_to_reg(val);
 	f71805f_write16(data, F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr, apnr),
-		        data->auto_points[pwmnr].fan[apnr]);
+			data->auto_points[pwmnr].fan[apnr]);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -851,7 +906,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = temp_to_reg(val);
@@ -867,7 +927,12 @@ static ssize_t set_temp_hyst(struct device *dev, struct device_attribute
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst[nr] = temp_to_reg(val);
@@ -920,9 +985,9 @@ static ssize_t show_name(struct device *dev, struct device_attribute
 }
 
 static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL, 0);
-static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO| S_IWUSR,
+static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
 			  show_in0_max, set_in0_max, 0);
-static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO| S_IWUSR,
+static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
 			  show_in0_min, set_in0_min, 0);
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
 static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR,
@@ -1304,12 +1369,13 @@ static int __devinit f71805f_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, err;
 
-	static const char *names[] = {
+	static const char * const names[] = {
 		"f71805f",
 		"f71872f",
 	};
 
-	if (!(data = kzalloc(sizeof(struct f71805f_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct f71805f_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		pr_err("Out of memory\n");
 		goto exit;
@@ -1347,40 +1413,47 @@ static int __devinit f71805f_probe(struct platform_device *pdev)
 	f71805f_init_device(data);
 
 	/* Register sysfs interface files */
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &f71805f_group)))
+	err = sysfs_create_group(&pdev->dev.kobj, &f71805f_group);
+	if (err)
 		goto exit_release_region;
 	if (data->has_in & (1 << 4)) { /* in4 */
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &f71805f_group_optin[0])))
+		err = sysfs_create_group(&pdev->dev.kobj,
+					 &f71805f_group_optin[0]);
+		if (err)
 			goto exit_remove_files;
 	}
 	if (data->has_in & (1 << 8)) { /* in8 */
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &f71805f_group_optin[1])))
+		err = sysfs_create_group(&pdev->dev.kobj,
+					 &f71805f_group_optin[1]);
+		if (err)
 			goto exit_remove_files;
 	}
 	if (data->has_in & (1 << 9)) { /* in9 (F71872F/FG only) */
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &f71805f_group_optin[2])))
+		err = sysfs_create_group(&pdev->dev.kobj,
+					 &f71805f_group_optin[2]);
+		if (err)
 			goto exit_remove_files;
 	}
 	if (data->has_in & (1 << 10)) { /* in9 (F71872F/FG only) */
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &f71805f_group_optin[3])))
+		err = sysfs_create_group(&pdev->dev.kobj,
+					 &f71805f_group_optin[3]);
+		if (err)
 			goto exit_remove_files;
 	}
 	for (i = 0; i < 3; i++) {
 		/* If control mode is PWM, create pwm_freq file */
 		if (!(data->fan_ctrl[i] & FAN_CTRL_DC_MODE)) {
-			if ((err = sysfs_create_file(&pdev->dev.kobj,
-					f71805f_attributes_pwm_freq[i])))
+			err = sysfs_create_file(&pdev->dev.kobj,
+						f71805f_attributes_pwm_freq[i]);
+			if (err)
 				goto exit_remove_files;
 		}
 		/* If PWM is in manual mode, add write permission */
 		if (data->fan_ctrl[i] & FAN_CTRL_MODE_MANUAL) {
-			if ((err = sysfs_chmod_file(&pdev->dev.kobj,
-						    f71805f_attr_pwm[i],
-						    S_IRUGO | S_IWUSR))) {
+			err = sysfs_chmod_file(&pdev->dev.kobj,
+					       f71805f_attr_pwm[i],
+					       S_IRUGO | S_IWUSR);
+			if (err) {
 				dev_err(&pdev->dev, "chmod +w pwm%d failed\n",
 					i + 1);
 				goto exit_remove_files;
@@ -1495,7 +1568,7 @@ static int __init f71805f_find(int sioaddr, unsigned short *address,
 	int err = -ENODEV;
 	u16 devid;
 
-	static const char *names[] = {
+	static const char * const names[] = {
 		"F71805F/FG",
 		"F71872F/FG or F71806F/FG",
 	};
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
