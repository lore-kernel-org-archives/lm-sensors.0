From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 14:06:45 +0000
Subject: [lm-sensors] [PATCH 7/8] hwmon: (it87) Use strict_strtol instead of
Message-Id: <20100121150645.010dee93@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

For consistency and robustness, use strict_strtol instead of
simple_strtol.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   59 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 15 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-21 14:29:18.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-21 14:30:23.000000000 +0100
@@ -363,7 +363,10 @@ static ssize_t set_in_min(struct device
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -379,7 +382,10 @@ static ssize_t set_in_max(struct device
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -452,7 +458,10 @@ static ssize_t set_temp_max(struct devic
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = TEMP_TO_REG(val);
@@ -467,7 +476,10 @@ static ssize_t set_temp_min(struct devic
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	data->temp_low[nr] = TEMP_TO_REG(val);
@@ -510,7 +522,10 @@ static ssize_t set_sensor(struct device
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 
@@ -618,9 +633,12 @@ static ssize_t set_fan_min(struct device
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
 	u8 reg;
 
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	reg = it87_read_value(data, IT87_REG_FAN_DIV);
 	switch (nr) {
@@ -647,10 +665,13 @@ static ssize_t set_fan_div(struct device
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
 	int min;
 	u8 old;
 
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	old = it87_read_value(data, IT87_REG_FAN_DIV);
 
@@ -689,9 +710,9 @@ static ssize_t set_pwm_enable(struct dev
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
 
-	if (val < 0 || val > 2)
+	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 2)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -727,9 +748,9 @@ static ssize_t set_pwm(struct device *de
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
 
-	if (val < 0 || val > 255)
+	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 255)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -747,9 +768,12 @@ static ssize_t set_pwm_freq(struct devic
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
 	int i;
 
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
 	/* Search for the nearest available frequency */
 	for (i = 0; i < 7; i++) {
 		if (val > (pwm_freq[i] + pwm_freq[i+1]) / 2)
@@ -871,7 +895,10 @@ static ssize_t set_fan16_min(struct devi
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct it87_data *data = dev_get_drvdata(dev);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN16_TO_REG(val);
@@ -992,9 +1019,11 @@ static ssize_t store_vrm_reg(struct devi
 		const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
 
-	val = simple_strtoul(buf, NULL, 10);
 	data->vrm = val;
 
 	return count;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
