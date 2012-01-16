From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:03 +0000
Subject: [lm-sensors] [PATCH 01/39] hwmon: (abitguru) Fix checkpatch issues
Message-Id: <1326703781-14272-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: else should follow close brace '}'
ERROR: switch and case should be at the same indent
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed:
WARNING: msleep < 20ms can sleep for up to 20ms

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru.c |  162 ++++++++++++++++++++++++++++----------------
 1 files changed, 103 insertions(+), 59 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 65a35cf..314a015 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -763,10 +763,18 @@ static ssize_t store_bank1_setting(struct device *dev, struct device_attribute
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	u8 val = (simple_strtoul(buf, NULL, 10) * 255 +
-		data->bank1_max_value[attr->index]/2) /
+	unsigned long val;
+	ssize_t ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = count;
+	val = (val * 255 + data->bank1_max_value[attr->index] / 2) /
 		data->bank1_max_value[attr->index];
-	ssize_t ret = count;
+	if (val > 255)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	if (data->bank1_settings[attr->index][attr->nr] != val) {
@@ -788,13 +796,19 @@ static ssize_t store_bank2_setting(struct device *dev, struct device_attribute
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	u8 val = (simple_strtoul(buf, NULL, 10)*255 + ABIT_UGURU_FAN_MAX/2) /
-		ABIT_UGURU_FAN_MAX;
-	ssize_t ret = count;
+	unsigned long val;
+	ssize_t ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = count;
+	val = (val * 255 + ABIT_UGURU_FAN_MAX / 2) / ABIT_UGURU_FAN_MAX;
 
 	/* this check can be done before taking the lock */
-	if ((val < abituguru_bank2_min_threshold) ||
-			(val > abituguru_bank2_max_threshold))
+	if (val < abituguru_bank2_min_threshold ||
+			val > abituguru_bank2_max_threshold)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -871,10 +885,15 @@ static ssize_t store_bank1_mask(struct device *dev,
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	int mask = simple_strtoul(buf, NULL, 10);
-	ssize_t ret = count;
+	ssize_t ret;
 	u8 orig_val;
+	unsigned long mask;
+
+	ret = kstrtoul(buf, 10, &mask);
+	if (ret)
+		return ret;
 
+	ret = count;
 	mutex_lock(&data->update_lock);
 	orig_val = data->bank1_settings[attr->index][0];
 
@@ -899,10 +918,15 @@ static ssize_t store_bank2_mask(struct device *dev,
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	int mask = simple_strtoul(buf, NULL, 10);
-	ssize_t ret = count;
+	ssize_t ret;
 	u8 orig_val;
+	unsigned long mask;
+
+	ret = kstrtoul(buf, 10, &mask);
+	if (ret)
+		return ret;
 
+	ret = count;
 	mutex_lock(&data->update_lock);
 	orig_val = data->bank2_settings[attr->index][0];
 
@@ -937,10 +961,17 @@ static ssize_t store_pwm_setting(struct device *dev, struct device_attribute
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	u8 min, val = (simple_strtoul(buf, NULL, 10) +
-		abituguru_pwm_settings_multiplier[attr->nr]/2) /
-		abituguru_pwm_settings_multiplier[attr->nr];
-	ssize_t ret = count;
+	u8 min;
+	unsigned long val;
+	ssize_t ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = count;
+	val = (val + abituguru_pwm_settings_multiplier[attr->nr] / 2) /
+				abituguru_pwm_settings_multiplier[attr->nr];
 
 	/* special case pwm1 min pwm% */
 	if ((attr->index = 0) && ((attr->nr = 1) || (attr->nr = 2)))
@@ -949,7 +980,7 @@ static ssize_t store_pwm_setting(struct device *dev, struct device_attribute
 		min = abituguru_pwm_min[attr->nr];
 
 	/* this check can be done before taking the lock */
-	if ((val < min) || (val > abituguru_pwm_max[attr->nr]))
+	if (val < min || val > abituguru_pwm_max[attr->nr])
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -996,27 +1027,32 @@ static ssize_t store_pwm_sensor(struct device *dev, struct device_attribute
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10) - 1;
-	ssize_t ret = count;
+	ssize_t ret;
+	unsigned long val;
+	u8 orig_val;
+	u8 address;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val = 0 || val > data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR])
+		return -EINVAL;
 
+	val -= 1;
+	ret = count;
 	mutex_lock(&data->update_lock);
-	if (val < data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR]) {
-		u8 orig_val = data->pwm_settings[attr->index][0];
-		u8 address = data->bank1_address[ABIT_UGURU_TEMP_SENSOR][val];
-		data->pwm_settings[attr->index][0] &= 0xF0;
-		data->pwm_settings[attr->index][0] |= address;
-		if (data->pwm_settings[attr->index][0] != orig_val) {
-			if (abituguru_write(data, ABIT_UGURU_FAN_PWM + 1,
-					attr->index,
-					data->pwm_settings[attr->index],
-					5) < 1) {
-				data->pwm_settings[attr->index][0] = orig_val;
-				ret = -EIO;
-			}
+	orig_val = data->pwm_settings[attr->index][0];
+	address = data->bank1_address[ABIT_UGURU_TEMP_SENSOR][val];
+	data->pwm_settings[attr->index][0] &= 0xF0;
+	data->pwm_settings[attr->index][0] |= address;
+	if (data->pwm_settings[attr->index][0] != orig_val) {
+		if (abituguru_write(data, ABIT_UGURU_FAN_PWM + 1, attr->index,
+				    data->pwm_settings[attr->index], 5) < 1) {
+			data->pwm_settings[attr->index][0] = orig_val;
+			ret = -EIO;
 		}
 	}
-	else
-		ret = -EINVAL;
 	mutex_unlock(&data->update_lock);
 	return ret;
 }
@@ -1037,22 +1073,27 @@ static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
-	u8 orig_val, user_val = simple_strtoul(buf, NULL, 10);
-	ssize_t ret = count;
+	u8 orig_val;
+	ssize_t ret;
+	unsigned long user_val;
 
+	ret = kstrtoul(buf, 10, &user_val);
+	if (ret)
+		return ret;
+
+	ret = count;
 	mutex_lock(&data->update_lock);
 	orig_val = data->pwm_settings[attr->index][0];
 	switch (user_val) {
-		case 0:
-			data->pwm_settings[attr->index][0] &-				~ABIT_UGURU_FAN_PWM_ENABLE;
-			break;
-		case 2:
-			data->pwm_settings[attr->index][0] |-				ABIT_UGURU_FAN_PWM_ENABLE;
-			break;
-		default:
-			ret = -EINVAL;
+	case 0:
+		data->pwm_settings[attr->index][0] &+			~ABIT_UGURU_FAN_PWM_ENABLE;
+		break;
+	case 2:
+		data->pwm_settings[attr->index][0] |= ABIT_UGURU_FAN_PWM_ENABLE;
+		break;
+	default:
+		ret = -EINVAL;
 	}
 	if ((data->pwm_settings[attr->index][0] != orig_val) &&
 			(abituguru_write(data, ABIT_UGURU_FAN_PWM + 1,
@@ -1153,7 +1194,8 @@ static int __devinit abituguru_probe(struct platform_device *pdev)
 		0x00, 0x01, 0x03, 0x04, 0x0A, 0x08, 0x0E, 0x02,
 		0x09, 0x06, 0x05, 0x0B, 0x0F, 0x0D, 0x07, 0x0C };
 
-	if (!(data = kzalloc(sizeof(struct abituguru_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct abituguru_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
@@ -1332,24 +1374,26 @@ static struct abituguru_data *abituguru_update_device(struct device *dev)
 	mutex_lock(&data->update_lock);
 	if (time_after(jiffies, data->last_updated + HZ)) {
 		success = 0;
-		if ((err = abituguru_read(data, ABIT_UGURU_ALARM_BANK, 0,
-				data->alarms, 3, 0)) != 3)
+		err = abituguru_read(data, ABIT_UGURU_ALARM_BANK, 0,
+				     data->alarms, 3, 0);
+		if (err != 3)
 			goto LEAVE_UPDATE;
 		for (i = 0; i < ABIT_UGURU_MAX_BANK1_SENSORS; i++) {
-			if ((err = abituguru_read(data,
-					ABIT_UGURU_SENSOR_BANK1, i,
-					&data->bank1_value[i], 1, 0)) != 1)
+			err = abituguru_read(data, ABIT_UGURU_SENSOR_BANK1,
+					     i, &data->bank1_value[i], 1, 0);
+			if (err != 1)
 				goto LEAVE_UPDATE;
-			if ((err = abituguru_read(data,
-					ABIT_UGURU_SENSOR_BANK1 + 1, i,
-					data->bank1_settings[i], 3, 0)) != 3)
+			err = abituguru_read(data, ABIT_UGURU_SENSOR_BANK1 + 1,
+					     i, data->bank1_settings[i], 3, 0);
+			if (err != 3)
 				goto LEAVE_UPDATE;
 		}
-		for (i = 0; i < data->bank2_sensors; i++)
-			if ((err = abituguru_read(data,
-					ABIT_UGURU_SENSOR_BANK2, i,
-					&data->bank2_value[i], 1, 0)) != 1)
+		for (i = 0; i < data->bank2_sensors; i++) {
+			err = abituguru_read(data, ABIT_UGURU_SENSOR_BANK2, i,
+					     &data->bank2_value[i], 1, 0);
+			if (err != 1)
 				goto LEAVE_UPDATE;
+		}
 		/* success! */
 		success = 1;
 		data->update_timeouts = 0;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
