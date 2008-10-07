From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:19:25 +0000
Subject: [lm-sensors] [PATCH 12/12] adt7473: Check inputs from sysfs writes
Message-Id: <20081007011925.12701.88807.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7473.c |   96 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 3a0b631..b4bcb63 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -360,6 +360,11 @@ static ssize_t show_volt_min(struct device *dev,
 		       decode_volt(attr->index, data->volt_min[attr->index]));
 }
 
+static int range_check(const long val, const long min, const long max)
+{
+	return val >= min && val <= max;
+}
+
 static ssize_t set_volt_min(struct device *dev,
 			    struct device_attribute *devattr,
 			    const char *buf,
@@ -368,7 +373,14 @@ static ssize_t set_volt_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int volt = encode_volt(attr->index, simple_strtol(buf, NULL, 10));
+	long volt;
+
+	if (strict_strtol(buf, 10, &volt))
+		return -EINVAL;
+
+	volt = encode_volt(attr->index, volt);
+	if (!range_check(volt, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->volt_min[attr->index] = volt;
@@ -397,7 +409,14 @@ static ssize_t set_volt_max(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int volt = encode_volt(attr->index, simple_strtol(buf, NULL, 10));
+	long volt;
+
+	if (strict_strtol(buf, 10, &volt))
+		return -EINVAL;
+
+	volt = encode_volt(attr->index, volt);
+	if (!range_check(volt, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->volt_max[attr->index] = volt;
@@ -452,8 +471,15 @@ static ssize_t set_temp_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10) / 1000;
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
+
+	temp /= 1000;
 	temp = encode_temp(data->temp_twos_complement, temp);
+	if (!range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] = temp;
@@ -483,8 +509,15 @@ static ssize_t set_temp_max(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10) / 1000;
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
+
+	temp /= 1000;
 	temp = encode_temp(data->temp_twos_complement, temp);
+	if (!range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] = temp;
@@ -526,11 +559,14 @@ static ssize_t set_fan_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
 
-	if (!temp)
+	if (strict_strtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
+
 	temp = FAN_RPM_TO_PERIOD(temp);
+	if (!range_check(temp, 0, 65535))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->fan_min[attr->index] = temp;
@@ -569,7 +605,10 @@ static ssize_t set_max_duty_at_crit(struct device *dev,
 	u8 reg;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->max_duty_at_overheat = !!temp;
@@ -598,7 +637,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp) || !range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->pwm[attr->index] = temp;
@@ -625,7 +667,10 @@ static ssize_t set_pwm_max(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp) || !range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] = temp;
@@ -653,7 +698,10 @@ static ssize_t set_pwm_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp) || !range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;
@@ -683,8 +731,15 @@ static ssize_t set_temp_tmax(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10) / 1000;
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
+
+	temp /= 1000;
 	temp = encode_temp(data->temp_twos_complement, temp);
+	if (!range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->temp_tmax[attr->index] = temp;
@@ -714,8 +769,15 @@ static ssize_t set_temp_tmin(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10) / 1000;
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
+
+	temp /= 1000;
 	temp = encode_temp(data->temp_twos_complement, temp);
+	if (!range_check(temp, 0, 255))
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->temp_tmin[attr->index] = temp;
@@ -752,7 +814,10 @@ static ssize_t set_pwm_enable(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
 
 	switch (temp) {
 	case 0:
@@ -816,7 +881,10 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp;
+
+	if (strict_strtol(buf, 10, &temp))
+		return -EINVAL;
 
 	switch (temp) {
 	case 1:


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
