From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 14 Dec 2008 14:32:04 +0000
Subject: Re: [lm-sensors] PATCH: fix various sysfs callback function issues
Message-Id: <494518E4.9010000@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080909090608010003000508"
List-Id: <lm-sensors.vger.kernel.org>
References: <4941926A.600@redhat.com>
In-Reply-To: <4941926A.600@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909090608010003000508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Jean Delvare wrote:
> Hi Hans,
> 
> On Thu, 11 Dec 2008 23:21:30 +0100, Hans de Goede wrote:
>> Again see attachment.
> 
> Review:
> 

Thanks,

Attached is a new version with all mentioned issues fixed.

I'll send a separate patch with the fan hyst code cleanup as requested in the 
review.

Regards,

Hans

--------------080909090608010003000508
Content-Type: text/plain; name="hwmon-f71882fg-08-fix-store-functions-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-08-fix-store-functions-v2.patch"

While working on adding f8000 support I noticed that various of the
store sysfs functions (and a few of the show also) had issues.

This patch fixes the following issues in these functions:
* store: storing the result of strto[u]l in an int, resulting in a possible
  overflow before boundary checking
* store: use of f71882fg_update_device(), we don't want to read the whole
  device in store functions, just the registers we need
* store: use of cached register values instead of reading the needed regs
  in the store function, including cases where f71882fg_update_device() was
  not used, this could cause real isues
* show: shown value is a calculation of 2 or more cached register reads,
  without locking the data struct.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.07-applied	2008-12-14 14:06:02.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-14 14:19:47.000000000 +0100
@@ -835,6 +835,7 @@
 	val = fan_to_reg(val);
 
 	mutex_lock(&data->update_lock);
+	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 	if (data->pwm_enable & (1 << (2 * nr)))
 		/* PWM mode */
 		count = -EINVAL;
@@ -865,9 +866,10 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
+	data->fan_beep = f71882fg_read8(data, F71882FG_REG_FAN_BEEP);
 	if (val)
 		data->fan_beep |= 1 << nr;
 	else
@@ -912,10 +914,8 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int val = simple_strtoul(buf, NULL, 10) / 8;
-
-	if (val > 255)
-		val = 255;
+	long val = simple_strtol(buf, NULL, 10) / 8;
+	val = SENSORS_LIMIT(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_IN1_HIGH, val);
@@ -942,9 +942,10 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
+	data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
 	if (val)
 		data->in_beep |= 1 << nr;
 	else
@@ -991,10 +992,8 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10) / 1000;
-
-	if (val > 255)
-		val = 255;
+	long val = simple_strtol(buf, NULL, 10) / 1000;
+	val = SENSORS_LIMIT(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_TEMP_HIGH(nr), val);
@@ -1009,9 +1008,13 @@
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int temp_max_hyst;
 
-	return sprintf(buf, "%d\n",
-		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
+	mutex_lock(&data->update_lock);
+	temp_max_hyst = (data->temp_high[nr] - data->temp_hyst[nr]) * 1000;
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%d\n", temp_max_hyst);
 }
 
 static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
@@ -1019,37 +1022,38 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10) / 1000;
+	long val = simple_strtol(buf, NULL, 10) / 1000;
 	ssize_t ret = count;
+	u8 reg;
 
 	mutex_lock(&data->update_lock);
 
 	/* convert abs to relative and check */
+	data->temp_high[nr] = f71882fg_read8(data, F71882FG_REG_TEMP_HIGH(nr));
+	val = SENSORS_LIMIT(val, data->temp_high[nr] - 15,
+			    data->temp_high[nr]);
 	val = data->temp_high[nr] - val;
-	if (val < 0 || val > 15) {
-		ret = -EINVAL;
-		goto store_temp_max_hyst_exit;
-	}
-
 	data->temp_hyst[nr] = val;
 
 	/* convert value to register contents */
 	switch (nr) {
 		case 1:
-			val = val << 4;
+			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST1);
+			reg = (reg & 0x0f) | (val << 4);
 			break;
 		case 2:
-			val = val | (data->temp_hyst[3] << 4);
+			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
+			reg = (reg & 0xf0) | val;
 			break;
 		case 3:
-			val = data->temp_hyst[2] | (val << 4);
+			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
+			reg = (reg & 0x0f) | (val << 4);
 			break;
 	}
 
 	f71882fg_write8(data, (nr <= 1) ? F71882FG_REG_TEMP_HYST1 :
-		F71882FG_REG_TEMP_HYST23, val);
+		F71882FG_REG_TEMP_HYST23, reg);
 
-store_temp_max_hyst_exit:
 	mutex_unlock(&data->update_lock);
 	return ret;
 }
@@ -1068,10 +1072,8 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10) / 1000;
-
-	if (val > 255)
-		val = 255;
+	long val = simple_strtol(buf, NULL, 10) / 1000;
+	val = SENSORS_LIMIT(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_TEMP_OVT(nr), val);
@@ -1086,9 +1088,13 @@
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int temp_crit_hyst;
 
-	return sprintf(buf, "%d\n",
-		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
+	mutex_lock(&data->update_lock);
+	temp_crit_hyst = (data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000;
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%d\n", temp_crit_hyst);
 }
 
 static ssize_t show_temp_type(struct device *dev, struct device_attribute
@@ -1117,9 +1123,10 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
+	data->temp_beep = f71882fg_read8(data, F71882FG_REG_TEMP_BEEP);
 	if (val)
 		data->temp_beep |= 1 << nr;
 	else
@@ -1160,16 +1167,16 @@
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int val, nr = to_sensor_dev_attr_2(devattr)->index;
+	mutex_lock(&data->update_lock);
 	if (data->pwm_enable & (1 << (2 * nr)))
 		/* PWM mode */
 		val = data->pwm[nr];
 	else {
 		/* RPM mode */
-		mutex_lock(&data->update_lock);
 		val = 255 * fan_from_reg(data->fan_target[nr])
 			/ fan_from_reg(data->fan_full_speed[nr]);
-		mutex_unlock(&data->update_lock);
 	}
+	mutex_unlock(&data->update_lock);
 	return sprintf(buf, "%d\n", val);
 }
 
@@ -1177,23 +1184,26 @@
 			 struct device_attribute *devattr, const char *buf,
 			 size_t count)
 {
-	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
-	struct f71882fg_data *data = f71882fg_update_device(dev);
+	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 	long val = simple_strtol(buf, NULL, 10);
 	val = SENSORS_LIMIT(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
+	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 	if (data->pwm_enable & (1 << (2 * nr))) {
 		/* PWM mode */
 		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
 		data->pwm[nr] = val;
 	} else {
 		/* RPM mode */
-		int target = val * fan_from_reg(data->fan_full_speed[nr]) / 255;
-		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr),
-				 fan_to_reg(target));
-		data->fan_target[nr] = fan_to_reg(target);
+		int target, full_speed;
+		full_speed = f71882fg_read16(data,
+					     F71882FG_REG_FAN_FULL_SPEED(nr));
+		target = fan_to_reg(val * fan_from_reg(full_speed) / 255);
+		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr), target);
+		data->fan_target[nr] = target;
+		data->fan_full_speed[nr] = full_speed;
 	}
 	mutex_unlock(&data->update_lock);
 
@@ -1225,6 +1235,7 @@
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
+	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 	switch (val) {
 	case 1:
 		data->pwm_enable |= 2 << (2 * nr);
@@ -1258,6 +1269,7 @@
 	int pwm = to_sensor_dev_attr_2(devattr)->index;
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 
+	mutex_lock(&data->update_lock);
 	if (data->pwm_enable & (1 << (2 * pwm))) {
 		/* PWM mode */
 		result = data->pwm_auto_point_pwm[pwm][point];
@@ -1265,6 +1277,7 @@
 		/* RPM mode */
 		result = 32 * 255 / (32 + data->pwm_auto_point_pwm[pwm][point]);
 	}
+	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", result);
 }
@@ -1273,14 +1286,14 @@
 					struct device_attribute *devattr,
 					const char *buf, size_t count)
 {
-	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
-	struct f71882fg_data *data = f71882fg_update_device(dev);
+	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int pwm = to_sensor_dev_attr_2(devattr)->index;
 	int point = to_sensor_dev_attr_2(devattr)->nr;
-	int val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 	val = SENSORS_LIMIT(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
+	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 	if (data->pwm_enable & (1 << (2 * pwm))) {
 		/* PWM mode */
 	} else {
@@ -1331,16 +1344,25 @@
 					      struct device_attribute *devattr,
 					      const char *buf, size_t count)
 {
-	struct f71882fg_data *data = f71882fg_update_device(dev);
+	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 	long val = simple_strtol(buf, NULL, 10) / 1000;
 
 	mutex_lock(&data->update_lock);
+	data->pwm_auto_point_temp[nr][point] =
+		f71882fg_read8(data, F71882FG_REG_POINT_TEMP(nr, point));
 	val = SENSORS_LIMIT(val, data->pwm_auto_point_temp[nr][point] - 15,
 				data->pwm_auto_point_temp[nr][point]);
 	val = data->pwm_auto_point_temp[nr][point] - val;
 
+	if (nr == 0 || nr == 1) {
+		data->pwm_auto_point_hyst[0] =
+			f71882fg_read8(data, F71882FG_REG_FAN_HYST0, val);
+	} else {
+		data->pwm_auto_point_hyst[1] =
+			f71882fg_read8(data, F71882FG_REG_FAN_HYST1, val);
+	}
 	switch (nr) {
 	case 0:
 		val = (data->pwm_auto_point_hyst[0] & 0xf0) | val;
@@ -1383,11 +1405,13 @@
 				     struct device_attribute *devattr,
 				     const char *buf, size_t count)
 {
-	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
-	struct f71882fg_data *data = f71882fg_update_device(dev);
+	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
 	mutex_lock(&data->update_lock);
+	data->pwm_auto_point_mapping[nr] =
+		f71882fg_read8(data, F71882FG_REG_POINT_MAPPING(nr));
 	if (val)
 		val = data->pwm_auto_point_mapping[nr] | (1 << 4);
 	else
@@ -1416,8 +1440,7 @@
 					    struct device_attribute *devattr,
 					    const char *buf, size_t count)
 {
-	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
-	struct f71882fg_data *data = f71882fg_update_device(dev);
+	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 	long val = simple_strtol(buf, NULL, 10);
 	switch (val) {
@@ -1434,6 +1457,8 @@
 		return -EINVAL;
 	}
 	mutex_lock(&data->update_lock);
+	data->pwm_auto_point_mapping[nr] =
+		f71882fg_read8(data, F71882FG_REG_POINT_MAPPING(nr));
 	val = (data->pwm_auto_point_mapping[nr] & 0xfc) | val;
 	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);
 	data->pwm_auto_point_mapping[nr] = val;
@@ -1459,8 +1484,7 @@
 					 struct device_attribute *devattr,
 					 const char *buf, size_t count)
 {
-	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
-	struct f71882fg_data *data = f71882fg_update_device(dev);
+	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int pwm = to_sensor_dev_attr_2(devattr)->index;
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 	long val = simple_strtol(buf, NULL, 10) / 1000;

--------------080909090608010003000508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080909090608010003000508--
