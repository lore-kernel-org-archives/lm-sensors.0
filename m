From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Wed, 04 Jan 2012 19:58:52 +0000
Subject: [lm-sensors] [PATCH 1/2] drivers/hwmon: replaced strict_str* with
Message-Id: <1325707133-21063-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

replaced strict_strtol with kstrtol and
replaced strict_strtuol with kstrtuol

This satisfies checkpatch -f
Compile tested only: no warnings or errors given

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/acpi_power_meter.c |    6 +++---
 drivers/hwmon/adcxx.c            |    2 +-
 drivers/hwmon/adm1031.c          |    2 +-
 drivers/hwmon/adm9240.c          |    2 +-
 drivers/hwmon/adt7411.c          |    2 +-
 drivers/hwmon/adt7462.c          |   28 ++++++++++++++--------------
 drivers/hwmon/adt7470.c          |   26 +++++++++++++-------------
 drivers/hwmon/adt7475.c          |   20 ++++++++++----------
 drivers/hwmon/amc6821.c          |   14 +++++++-------
 drivers/hwmon/applesmc.c         |    6 +++---
 drivers/hwmon/asc7621.c          |   24 ++++++++++++------------
 drivers/hwmon/coretemp.c         |    2 +-
 drivers/hwmon/ds620.c            |    2 +-
 drivers/hwmon/emc1403.c          |    6 +++---
 drivers/hwmon/emc2103.c          |   10 +++++-----
 drivers/hwmon/emc6w201.c         |    6 +++---
 drivers/hwmon/f71882fg.c         |   32 ++++++++++++++++----------------
 drivers/hwmon/g760a.c            |    2 +-
 drivers/hwmon/gpio-fan.c         |    6 +++---
 drivers/hwmon/ibmaem.c           |    2 +-
 drivers/hwmon/it87.c             |   34 +++++++++++++++++-----------------
 drivers/hwmon/jc42.c             |    4 ++--
 drivers/hwmon/lm73.c             |    2 +-
 drivers/hwmon/lm90.c             |   10 +++++-----
 drivers/hwmon/lm95241.c          |    8 ++++----
 drivers/hwmon/lm95245.c          |    8 ++++----
 drivers/hwmon/max16065.c         |    2 +-
 drivers/hwmon/max6639.c          |    8 ++++----
 drivers/hwmon/max6642.c          |    2 +-
 drivers/hwmon/pc87427.c          |    6 +++---
 drivers/hwmon/sht15.c            |    2 +-
 drivers/hwmon/tmp102.c           |    2 +-
 drivers/hwmon/tmp401.c           |   10 +++++-----
 drivers/hwmon/w83627ehf.c        |   22 +++++++++++-----------
 drivers/hwmon/w83791d.c          |    8 ++++----
 drivers/hwmon/w83792d.c          |    2 +-
 drivers/hwmon/w83793.c           |    2 +-
 drivers/hwmon/w83795.c           |   32 ++++++++++++++++----------------
 38 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 66f6729..522860a 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -170,7 +170,7 @@ static ssize_t set_avg_interval(struct device *dev,
 	unsigned long long data;
 	acpi_status status;
 
-	res = strict_strtoul(buf, 10, &temp);
+	res = kstrtoul(buf, 10, &temp);
 	if (res)
 		return res;
 
@@ -241,7 +241,7 @@ static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
 	unsigned long long data;
 	acpi_status status;
 
-	res = strict_strtoul(buf, 10, &temp);
+	res = kstrtoul(buf, 10, &temp);
 	if (res)
 		return res;
 
@@ -311,7 +311,7 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
 	int res;
 	unsigned long temp;
 
-	res = strict_strtoul(buf, 10, &temp);
+	res = kstrtoul(buf, 10, &temp);
 	if (res)
 		return res;
 
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index b2cacbe..ceb24a3 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -125,7 +125,7 @@ static ssize_t adcxx_set_max(struct device *dev,
 	struct adcxx *adc = spi_get_drvdata(spi);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 10, &value))
+	if (kstrtoul(buf, 10, &value))
 		return -EINVAL;
 
 	if (mutex_lock_interruptible(&adc->lock))
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 0683e6b..e6291da 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -767,7 +767,7 @@ static ssize_t set_update_interval(struct device *dev,
 	int i, err;
 	u8 reg;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
 
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 9e234b9..3f63f5f 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -503,7 +503,7 @@ static ssize_t chassis_clear(struct device *dev,
 	struct adm9240_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) || val != 0)
+	if (kstrtoul(buf, 10, &val) || val != 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 5cc3e37..5b02f7a 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -197,7 +197,7 @@ static ssize_t adt7411_set_bit(struct device *dev,
 	int ret;
 	unsigned long flag;
 
-	ret = strict_strtoul(buf, 0, &flag);
+	ret = kstrtoul(buf, 0, &flag);
 	if (ret || flag > 1)
 		return -EINVAL;
 
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 2af0c7b..7a14948 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -833,7 +833,7 @@ static ssize_t set_temp_min(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !temp_enabled(data, attr->index))
+	if (kstrtol(buf, 10, &temp) || !temp_enabled(data, attr->index))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + 64;
@@ -871,7 +871,7 @@ static ssize_t set_temp_max(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !temp_enabled(data, attr->index))
+	if (kstrtol(buf, 10, &temp) || !temp_enabled(data, attr->index))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + 64;
@@ -935,7 +935,7 @@ static ssize_t set_volt_max(struct device *dev,
 	int x = voltage_multiplier(data, attr->index);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !x)
+	if (kstrtol(buf, 10, &temp) || !x)
 		return -EINVAL;
 
 	temp *= 1000; /* convert mV to uV */
@@ -977,7 +977,7 @@ static ssize_t set_volt_min(struct device *dev,
 	int x = voltage_multiplier(data, attr->index);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !x)
+	if (kstrtol(buf, 10, &temp) || !x)
 		return -EINVAL;
 
 	temp *= 1000; /* convert mV to uV */
@@ -1066,7 +1066,7 @@ static ssize_t set_fan_min(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !temp ||
+	if (kstrtol(buf, 10, &temp) || !temp ||
 	    !fan_enabled(data, attr->index))
 		return -EINVAL;
 
@@ -1115,7 +1115,7 @@ static ssize_t set_force_pwm_max(struct device *dev,
 	long temp;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -1147,7 +1147,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 255);
@@ -1177,7 +1177,7 @@ static ssize_t set_pwm_max(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 255);
@@ -1209,7 +1209,7 @@ static ssize_t set_pwm_min(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 255);
@@ -1243,7 +1243,7 @@ static ssize_t set_pwm_hyst(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
@@ -1289,7 +1289,7 @@ static ssize_t set_pwm_tmax(struct device *dev,
 	int tmin, trange_value;
 	long trange;
 
-	if (strict_strtol(buf, 10, &trange))
+	if (kstrtol(buf, 10, &trange))
 		return -EINVAL;
 
 	/* trange = tmax - tmin */
@@ -1330,7 +1330,7 @@ static ssize_t set_pwm_tmin(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + 64;
@@ -1387,7 +1387,7 @@ static ssize_t set_pwm_auto(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	switch (temp) {
@@ -1446,7 +1446,7 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
 	struct adt7462_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = cvt_auto_temp(temp);
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index c6d1ce0..5e10c79 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -449,7 +449,7 @@ static ssize_t set_auto_update_interval(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 60000);
@@ -478,7 +478,7 @@ static ssize_t set_num_temp_sensors(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, -1, 10);
@@ -511,7 +511,7 @@ static ssize_t set_temp_min(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
@@ -545,7 +545,7 @@ static ssize_t set_temp_max(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
@@ -600,7 +600,7 @@ static ssize_t set_fan_max(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !temp)
+	if (kstrtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
 
 	temp = FAN_RPM_TO_PERIOD(temp);
@@ -637,7 +637,7 @@ static ssize_t set_fan_min(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp) || !temp)
+	if (kstrtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
 
 	temp = FAN_RPM_TO_PERIOD(temp);
@@ -682,7 +682,7 @@ static ssize_t set_force_pwm_max(struct device *dev,
 	long temp;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -714,7 +714,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 255);
@@ -746,7 +746,7 @@ static ssize_t set_pwm_max(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 255);
@@ -779,7 +779,7 @@ static ssize_t set_pwm_min(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = SENSORS_LIMIT(temp, 0, 255);
@@ -822,7 +822,7 @@ static ssize_t set_pwm_tmin(struct device *dev,
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	long temp;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
@@ -859,7 +859,7 @@ static ssize_t set_pwm_auto(struct device *dev,
 	long temp;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	if (attr->index % 2)
@@ -919,7 +919,7 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
 	long temp;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &temp))
+	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	temp = cvt_auto_temp(temp);
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index b5fcd87..7dab354 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -343,7 +343,7 @@ static ssize_t set_voltage(struct device *dev, struct device_attribute *attr,
 	unsigned char reg;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -432,7 +432,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	int temp;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -546,7 +546,7 @@ static ssize_t set_point2(struct device *dev, struct device_attribute *attr,
 	int temp;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -602,7 +602,7 @@ static ssize_t set_tach(struct device *dev, struct device_attribute *attr,
 	struct adt7475_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -653,7 +653,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	unsigned char reg = 0;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -758,7 +758,7 @@ static ssize_t set_pwmchan(struct device *dev, struct device_attribute *attr,
 	int r;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -781,7 +781,7 @@ static ssize_t set_pwmctrl(struct device *dev, struct device_attribute *attr,
 	int r;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -819,7 +819,7 @@ static ssize_t set_pwmfreq(struct device *dev, struct device_attribute *attr,
 	int out;
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	out = find_nearest(val, pwmfreq_table, ARRAY_SIZE(pwmfreq_table));
@@ -853,7 +853,7 @@ static ssize_t set_pwm_at_crit(struct device *dev,
 	struct adt7475_data *data = i2c_get_clientdata(client);
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 	if (val != 0 && val != 1)
 		return -EINVAL;
@@ -883,7 +883,7 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *devattr,
 	struct adt7475_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 	if (val < 0 || val > 255)
 		return -EINVAL;
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 4033974..89a6b9d 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -238,7 +238,7 @@ static ssize_t set_temp(
 	int ix = to_sensor_dev_attr(attr)->index;
 	long val;
 
-	int ret = strict_strtol(buf, 10, &val);
+	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	val = SENSORS_LIMIT(val / 1000, -128, 127);
@@ -327,7 +327,7 @@ static ssize_t set_pwm1(
 	struct i2c_client *client = to_i2c_client(dev);
 	struct amc6821_data *data = i2c_get_clientdata(client);
 	long val;
-	int ret = strict_strtol(buf, 10, &val);
+	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -356,7 +356,7 @@ static ssize_t set_pwm1_enable(
 	struct i2c_client *client = to_i2c_client(dev);
 	struct amc6821_data *data = i2c_get_clientdata(client);
 	long val;
-	int config = strict_strtol(buf, 10, &val);
+	int config = kstrtol(buf, 10, &val);
 	if (config)
 		return config;
 
@@ -477,7 +477,7 @@ static ssize_t set_temp_auto_point_temp(
 	u8 reg;
 	int dpwm;
 	long val;
-	int ret = strict_strtol(buf, 10, &val);
+	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -556,7 +556,7 @@ static ssize_t set_pwm1_auto_point_pwm(
 	struct amc6821_data *data = i2c_get_clientdata(client);
 	int dpwm;
 	long val;
-	int ret = strict_strtol(buf, 10, &val);
+	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -623,7 +623,7 @@ static ssize_t set_fan(
 	struct amc6821_data *data = i2c_get_clientdata(client);
 	long val;
 	int ix = to_sensor_dev_attr(attr)->index;
-	int ret = strict_strtol(buf, 10, &val);
+	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	val = 1 > val ? 0xFFFF : 6000000/val;
@@ -665,7 +665,7 @@ static ssize_t set_fan1_div(
 	struct i2c_client *client = to_i2c_client(dev);
 	struct amc6821_data *data = i2c_get_clientdata(client);
 	long val;
-	int config = strict_strtol(buf, 10, &val);
+	int config = kstrtol(buf, 10, &val);
 	if (config)
 		return config;
 
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 4c07436..b989553 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -782,7 +782,7 @@ static ssize_t applesmc_store_fan_speed(struct device *dev,
 	char newkey[5];
 	u8 buffer[2];
 
-	if (strict_strtoul(sysfsbuf, 10, &speed) < 0 || speed >= 0x4000)
+	if (kstrtoul(sysfsbuf, 10, &speed) < 0 || speed >= 0x4000)
 		return -EINVAL;		/* Bigger than a 14-bit value */
 
 	sprintf(newkey, fan_speed_fmt[to_option(attr)], to_index(attr));
@@ -822,7 +822,7 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
 	unsigned long input;
 	u16 val;
 
-	if (strict_strtoul(sysfsbuf, 10, &input) < 0)
+	if (kstrtoul(sysfsbuf, 10, &input) < 0)
 		return -EINVAL;
 
 	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
@@ -977,7 +977,7 @@ static ssize_t applesmc_key_at_index_store(struct device *dev,
 {
 	unsigned long newkey;
 
-	if (strict_strtoul(sysfsbuf, 10, &newkey) < 0
+	if (kstrtoul(sysfsbuf, 10, &newkey) < 0
 	    || newkey >= smcreg.key_count)
 		return -EINVAL;
 
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index d2596ce..3efd324 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -188,7 +188,7 @@ static ssize_t store_u8(struct device *dev, struct device_attribute *attr,
 	SETUP_STORE_data_param(dev, attr);
 	long reqval;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	reqval = SENSORS_LIMIT(reqval, 0, 255);
@@ -221,7 +221,7 @@ static ssize_t store_bitmask(struct device *dev,
 	long reqval;
 	u8 currval;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	reqval = SENSORS_LIMIT(reqval, 0, param->mask[0]);
@@ -265,7 +265,7 @@ static ssize_t store_fan16(struct device *dev,
 	SETUP_STORE_data_param(dev, attr);
 	long reqval;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	/* If a minimum RPM of zero is requested, then we set the register to
@@ -338,7 +338,7 @@ static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
 	long reqval;
 	u8 nr = sda->index;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	reqval = SENSORS_LIMIT(reqval, 0, 0xffff);
@@ -371,7 +371,7 @@ static ssize_t store_temp8(struct device *dev,
 	long reqval;
 	s8 temp;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	reqval = SENSORS_LIMIT(reqval, -127000, 127000);
@@ -427,7 +427,7 @@ static ssize_t store_temp62(struct device *dev,
 	long reqval, i, f;
 	s8 temp;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	reqval = SENSORS_LIMIT(reqval, -32000, 31750);
@@ -482,7 +482,7 @@ static ssize_t store_ap2_temp(struct device *dev,
 	int i;
 	u8 currval, newval = 0;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -538,7 +538,7 @@ static ssize_t store_pwm_ac(struct device *dev,
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x03,
 	};
 
-	if (strict_strtoul(buf, 10, &reqval))
+	if (kstrtoul(buf, 10, &reqval))
 		return -EINVAL;
 
 	if (reqval > 31)
@@ -601,7 +601,7 @@ static ssize_t store_pwm_enable(struct device *dev,
 	long reqval;
 	u8 currval, config, altbit, newval, minoff = 255;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	switch (reqval) {
@@ -675,7 +675,7 @@ static ssize_t store_pwm_freq(struct device *dev,
 	u8 currval, newval = 255;
 	int i;
 
-	if (strict_strtoul(buf, 10, &reqval))
+	if (kstrtoul(buf, 10, &reqval))
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(asc7621_pwm_freq_map); i++) {
@@ -724,7 +724,7 @@ static ssize_t store_pwm_ast(struct device *dev,
 	u8 currval, newval = 255;
 	u32 i;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(asc7621_pwm_auto_spinup_map); i++) {
@@ -771,7 +771,7 @@ static ssize_t store_temp_st(struct device *dev,
 	u8 currval, newval = 255;
 	u32 i;
 
-	if (strict_strtol(buf, 10, &reqval))
+	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(asc7621_temp_smoothing_time_map); i++) {
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5dfd81f..31f852c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -221,7 +221,7 @@ static ssize_t store_tx(struct device *dev,
 	unsigned long val;
 	int diff;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
index 225ae4f..300c3d4 100644
--- a/drivers/hwmon/ds620.c
+++ b/drivers/hwmon/ds620.c
@@ -161,7 +161,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds620_data *data = i2c_get_clientdata(client);
 
-	res = strict_strtol(buf, 10, &val);
+	res = kstrtol(buf, 10, &val);
 
 	if (res)
 		return res;
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index cd2a6e4..270ffab 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -80,7 +80,7 @@ static ssize_t store_temp(struct device *dev,
 	unsigned long val;
 	int retval;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 	retval = i2c_smbus_write_byte_data(client, sda->index,
 					DIV_ROUND_CLOSEST(val, 1000));
@@ -98,7 +98,7 @@ static ssize_t store_bit(struct device *dev,
 	unsigned long val;
 	int retval;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->mutex);
@@ -151,7 +151,7 @@ static ssize_t store_hyst(struct device *dev,
 	int hyst;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index af914ad..848a2b0 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -244,7 +244,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
 	struct emc2103_data *data = i2c_get_clientdata(client);
 	long val;
 
-	int result = strict_strtol(buf, 10, &val);
+	int result = kstrtol(buf, 10, &val);
 	if (result < 0)
 		return -EINVAL;
 
@@ -268,7 +268,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
 	struct emc2103_data *data = i2c_get_clientdata(client);
 	long val;
 
-	int result = strict_strtol(buf, 10, &val);
+	int result = kstrtol(buf, 10, &val);
 	if (result < 0)
 		return -EINVAL;
 
@@ -314,7 +314,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 	int new_range_bits, old_div = 8 / data->fan_multiplier;
 	long new_div;
 
-	int status = strict_strtol(buf, 10, &new_div);
+	int status = kstrtol(buf, 10, &new_div);
 	if (status < 0)
 		return -EINVAL;
 
@@ -388,7 +388,7 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
 	struct i2c_client *client = to_i2c_client(dev);
 	long rpm_target;
 
-	int result = strict_strtol(buf, 10, &rpm_target);
+	int result = kstrtol(buf, 10, &rpm_target);
 	if (result < 0)
 		return -EINVAL;
 
@@ -434,7 +434,7 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
 	long new_value;
 	u8 conf_reg;
 
-	int result = strict_strtol(buf, 10, &new_value);
+	int result = kstrtol(buf, 10, &new_value);
 	if (result < 0)
 		return -EINVAL;
 
diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index 0064432..6ebb9b7 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -212,7 +212,7 @@ static ssize_t set_in(struct device *dev, struct device_attribute *devattr,
 	long val;
 	u8 reg;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -249,7 +249,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	long val;
 	u8 reg;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -291,7 +291,7 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *devattr,
 	int err;
 	unsigned long val;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 59dd881..e503058 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1333,7 +1333,7 @@ static ssize_t store_fan_full_speed(struct device *dev,
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1367,7 +1367,7 @@ static ssize_t store_fan_beep(struct device *dev, struct device_attribute
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	unsigned long val;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1420,7 +1420,7 @@ static ssize_t store_in_max(struct device *dev, struct device_attribute
 	int err;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1454,7 +1454,7 @@ static ssize_t store_in_beep(struct device *dev, struct device_attribute
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	unsigned long val;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1524,7 +1524,7 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1566,7 +1566,7 @@ static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
 	u8 reg;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1609,7 +1609,7 @@ static ssize_t store_temp_crit(struct device *dev, struct device_attribute
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1670,7 +1670,7 @@ static ssize_t store_temp_beep(struct device *dev, struct device_attribute
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	unsigned long val;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1737,7 +1737,7 @@ static ssize_t store_pwm(struct device *dev,
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1788,7 +1788,7 @@ static ssize_t store_simple_pwm(struct device *dev,
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1835,7 +1835,7 @@ static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1915,7 +1915,7 @@ static ssize_t store_pwm_auto_point_pwm(struct device *dev,
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1969,7 +1969,7 @@ static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,
 	u8 reg;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -2015,7 +2015,7 @@ static ssize_t store_pwm_interpolate(struct device *dev,
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	unsigned long val;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -2055,7 +2055,7 @@ static ssize_t store_pwm_auto_point_channel(struct device *dev,
 	int err, nr = to_sensor_dev_attr_2(devattr)->index;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -2106,7 +2106,7 @@ static ssize_t store_pwm_auto_point_temp(struct device *dev,
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 	long val;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 1d6a6fa..781277d 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -166,7 +166,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
 	struct g760a_data *data = g760a_update_client(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 9ba38f3..2ce8c44 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -224,7 +224,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	int speed_index;
 	int ret = count;
 
-	if (strict_strtoul(buf, 10, &pwm) || pwm > 255)
+	if (kstrtoul(buf, 10, &pwm) || pwm > 255)
 		return -EINVAL;
 
 	mutex_lock(&fan_data->lock);
@@ -257,7 +257,7 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) || val > 1)
+	if (kstrtoul(buf, 10, &val) || val > 1)
 		return -EINVAL;
 
 	if (fan_data->pwm_enable = val)
@@ -314,7 +314,7 @@ static ssize_t set_rpm(struct device *dev, struct device_attribute *attr,
 	unsigned long rpm;
 	int ret = count;
 
-	if (strict_strtoul(buf, 10, &rpm))
+	if (kstrtoul(buf, 10, &rpm))
 		return -EINVAL;
 
 	mutex_lock(&fan_data->lock);
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 6a967d7..cc2981f 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -904,7 +904,7 @@ static ssize_t aem_set_power_period(struct device *dev,
 	unsigned long temp;
 	int res;
 
-	res = strict_strtoul(buf, 10, &temp);
+	res = kstrtoul(buf, 10, &temp);
 	if (res)
 		return res;
 
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index d912649..38c0b87 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -444,7 +444,7 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -463,7 +463,7 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -539,7 +539,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -557,7 +557,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -604,7 +604,7 @@ static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
 	long val;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	reg = it87_read_value(data, IT87_REG_TEMP_ENABLE);
@@ -718,7 +718,7 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	long val;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -751,7 +751,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	int min;
 	u8 old;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -820,7 +820,7 @@ static ssize_t set_pwm_enable(struct device *dev,
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 2)
+	if (kstrtol(buf, 10, &val) < 0 || val < 0 || val > 2)
 		return -EINVAL;
 
 	/* Check trip points before switching to automatic mode */
@@ -866,7 +866,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 255)
+	if (kstrtol(buf, 10, &val) < 0 || val < 0 || val > 255)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -900,7 +900,7 @@ static ssize_t set_pwm_freq(struct device *dev,
 	unsigned long val;
 	int i;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	/* Search for the nearest available frequency */
@@ -949,7 +949,7 @@ static ssize_t set_pwm_temp_map(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	switch (val) {
@@ -1001,7 +1001,7 @@ static ssize_t set_auto_pwm(struct device *dev,
 	int point = sensor_attr->index;
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 255)
+	if (kstrtol(buf, 10, &val) < 0 || val < 0 || val > 255)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1034,7 +1034,7 @@ static ssize_t set_auto_temp(struct device *dev,
 	int point = sensor_attr->index;
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0 || val < -128000 || val > 127000)
+	if (kstrtol(buf, 10, &val) < 0 || val < -128000 || val > 127000)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1126,7 +1126,7 @@ static ssize_t set_fan16_min(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1180,7 +1180,7 @@ static ssize_t clear_intrusion(struct device *dev, struct device_attribute
 	long val;
 	int config;
 
-	if (strict_strtol(buf, 10, &val) < 0 || val != 0)
+	if (kstrtol(buf, 10, &val) < 0 || val != 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1231,7 +1231,7 @@ static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0
+	if (kstrtol(buf, 10, &val) < 0
 	 || (val != 0 && val != 1))
 		return -EINVAL;
 
@@ -1278,7 +1278,7 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	data->vrm = val;
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 2d3d728..d8d88ab 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -309,7 +309,7 @@ static ssize_t set_##value(struct device *dev,				\
 	struct jc42_data *data = i2c_get_clientdata(client);		\
 	int err, ret = count;						\
 	long val;							\
-	if (strict_strtol(buf, 10, &val) < 0)				\
+	if (kstrtol(buf, 10, &val) < 0)				\
 		return -EINVAL;						\
 	mutex_lock(&data->update_lock);					\
 	data->value = jc42_temp_to_reg(val, data->extended);		\
@@ -337,7 +337,7 @@ static ssize_t set_temp_crit_hyst(struct device *dev,
 	int err;
 	int ret = count;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	diff = jc42_temp_from_reg(data->temp_crit) - val;
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 9e64d96..9c8093c 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -50,7 +50,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	long temp;
 	short value;
 
-	int status = strict_strtol(buf, 10, &temp);
+	int status = kstrtol(buf, 10, &temp);
 	if (status < 0)
 		return status;
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 615bc4f..bdfd675 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -730,7 +730,7 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 	long val;
 	int err;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -798,7 +798,7 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	long val;
 	int err;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -859,7 +859,7 @@ static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
 	int err;
 	int temp;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -912,7 +912,7 @@ static ssize_t set_update_interval(struct device *dev,
 	unsigned long val;
 	int err;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
 
@@ -1080,7 +1080,7 @@ static ssize_t set_pec(struct device *dev, struct device_attribute *dummy,
 	long val;
 	int err;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 513901d..70bca67 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -169,7 +169,7 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 	int shift;
 	u8 mask = to_sensor_dev_attr(attr)->index;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	if (val != 1 && val != 2)
 		return -EINVAL;
@@ -216,7 +216,7 @@ static ssize_t set_min(struct device *dev, struct device_attribute *attr,
 	struct lm95241_data *data = i2c_get_clientdata(client);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 	if (val < -128000)
 		return -EINVAL;
@@ -254,7 +254,7 @@ static ssize_t set_max(struct device *dev, struct device_attribute *attr,
 	struct lm95241_data *data = i2c_get_clientdata(client);
 	long val;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 	if (val >= 256000)
 		return -EINVAL;
@@ -290,7 +290,7 @@ static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
 	struct lm95241_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	data->interval = val * HZ / 1000;
diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index dce9e68..5e5fc1b 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -254,7 +254,7 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
 	int index = to_sensor_dev_attr(attr)->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	val /= 1000;
@@ -279,7 +279,7 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
 	struct lm95245_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	val /= 1000;
@@ -316,7 +316,7 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 	struct lm95245_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	if (val != 1 && val != 2)
 		return -EINVAL;
@@ -363,7 +363,7 @@ static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
 	struct lm95245_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 385886a..f8e323a 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -230,7 +230,7 @@ static ssize_t max16065_set_limit(struct device *dev,
 	int err;
 	int limit;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (unlikely(err < 0))
 		return err;
 
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index f20d997..e10a092 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -208,7 +208,7 @@ static ssize_t set_temp_max(struct device *dev,
 	unsigned long val;
 	int res;
 
-	res = strict_strtoul(buf, 10, &val);
+	res = kstrtoul(buf, 10, &val);
 	if (res)
 		return res;
 
@@ -241,7 +241,7 @@ static ssize_t set_temp_crit(struct device *dev,
 	unsigned long val;
 	int res;
 
-	res = strict_strtoul(buf, 10, &val);
+	res = kstrtoul(buf, 10, &val);
 	if (res)
 		return res;
 
@@ -275,7 +275,7 @@ static ssize_t set_temp_emergency(struct device *dev,
 	unsigned long val;
 	int res;
 
-	res = strict_strtoul(buf, 10, &val);
+	res = kstrtoul(buf, 10, &val);
 	if (res)
 		return res;
 
@@ -308,7 +308,7 @@ static ssize_t set_pwm(struct device *dev,
 	unsigned long val;
 	int res;
 
-	res = strict_strtoul(buf, 10, &val);
+	res = kstrtoul(buf, 10, &val);
 	if (res)
 		return res;
 
diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index e855d3b..209e8a5 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -234,7 +234,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	struct max6642_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(attr);
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 8da2181..cb35461 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -418,7 +418,7 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
 	unsigned long val;
 	int iobase = data->address[LD_FAN];
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -572,7 +572,7 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 	int nr = to_sensor_dev_attr(devattr)->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0 || val > 2)
+	if (kstrtoul(buf, 10, &val) < 0 || val > 2)
 		return -EINVAL;
 	/* Can't go to automatic mode if it isn't configured */
 	if (val = 2 && !(data->pwm_auto_ok & (1 << nr)))
@@ -604,7 +604,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute
 	int iobase = data->address[LD_FAN];
 	u8 mode;
 
-	if (strict_strtoul(buf, 10, &val) < 0 || val > 0xff)
+	if (kstrtoul(buf, 10, &val) < 0 || val > 0xff)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index fe4104c..6ddeae0 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -683,7 +683,7 @@ static ssize_t sht15_store_heater(struct device *dev,
 	long value;
 	u8 status;
 
-	if (strict_strtol(buf, 10, &value))
+	if (kstrtol(buf, 10, &value))
 		return -EINVAL;
 
 	mutex_lock(&data->read_lock);
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 643aa8c..c08eee2 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -112,7 +112,7 @@ static ssize_t tmp102_set_temp(struct device *dev,
 	long val;
 	int status;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 	val = SENSORS_LIMIT(val, -256000, 255000);
 
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index ad8d535..8b9a774 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -334,7 +334,7 @@ static ssize_t store_temp_min(struct device *dev, struct device_attribute
 	long val;
 	u16 reg;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	reg = tmp401_temp_to_register(val, data->config);
@@ -361,7 +361,7 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute
 	long val;
 	u16 reg;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	reg = tmp401_temp_to_register(val, data->config);
@@ -388,7 +388,7 @@ static ssize_t store_temp_crit(struct device *dev, struct device_attribute
 	long val;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	reg = tmp401_crit_temp_to_register(val, data->config);
@@ -413,7 +413,7 @@ static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
 	long val;
 	u8 reg;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	if (data->config & TMP401_CONFIG_RANGE)
@@ -447,7 +447,7 @@ static ssize_t reset_temp_history(struct device *dev,
 {
 	long val;
 
-	if (strict_strtol(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	if (val != 1) {
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 93f5fc7..0e0af04 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -937,7 +937,7 @@ store_in_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = sensor_attr->index; \
 	unsigned long val; \
 	int err; \
-	err = strict_strtoul(buf, 10, &val); \
+	err = kstrtoul(buf, 10, &val); \
 	if (err < 0) \
 		return err; \
 	mutex_lock(&data->update_lock); \
@@ -1054,7 +1054,7 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	unsigned int reg;
 	u8 new_div;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -1199,7 +1199,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = sensor_attr->index; \
 	int err; \
 	long val; \
-	err = strict_strtol(buf, 10, &val); \
+	err = kstrtol(buf, 10, &val); \
 	if (err < 0) \
 		return err; \
 	mutex_lock(&data->update_lock); \
@@ -1324,7 +1324,7 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 	int err;
 	u16 reg;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -1351,7 +1351,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	int err;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -1376,7 +1376,7 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 	int err;
 	u16 reg;
 
-	err = strict_strtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -1430,7 +1430,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	long val;
 	int err;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -1455,7 +1455,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	long val;
 	int err;
 
-	err = strict_strtol(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err < 0)
 		return err;
 
@@ -1556,7 +1556,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = sensor_attr->index; \
 	unsigned long val; \
 	int err; \
-	err = strict_strtoul(buf, 10, &val); \
+	err = kstrtoul(buf, 10, &val); \
 	if (err < 0) \
 		return err; \
 	val = SENSORS_LIMIT(val, 1, 255); \
@@ -1595,7 +1595,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = sensor_attr->index; \
 	unsigned long val; \
 	int err; \
-	err = strict_strtoul(buf, 10, &val); \
+	err = kstrtoul(buf, 10, &val); \
 	if (err < 0) \
 		return err; \
 	val = step_time_to_reg(val, data->pwm_mode[nr]); \
@@ -1702,7 +1702,7 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	u16 reg, mask;
 
-	if (strict_strtoul(buf, 10, &val) || val != 0)
+	if (kstrtoul(buf, 10, &val) || val != 0)
 		return -EINVAL;
 
 	mask = to_sensor_dev_attr_2(attr)->nr;
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 8c2844e..6e5d0ae 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -711,7 +711,7 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -756,7 +756,7 @@ static ssize_t store_pwmenable(struct device *dev,
 	u8 val_shift = 0;
 	u8 keep_mask = 0;
 
-	int ret = strict_strtoul(buf, 10, &val);
+	int ret = kstrtoul(buf, 10, &val);
 
 	if (ret || val < 1 || val > 3)
 		return -EINVAL;
@@ -819,7 +819,7 @@ static ssize_t store_temp_target(struct device *dev,
 	unsigned long val;
 	u8 target_mask;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -863,7 +863,7 @@ static ssize_t store_temp_tolerance(struct device *dev,
 	u8 val_shift = 0;
 	u8 keep_mask = 0;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
 	switch (nr) {
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index f3e7130..9ded133 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -749,7 +749,7 @@ store_chassis_clear(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	u8 reg;
 
-	if (strict_strtoul(buf, 10, &val) || val != 0)
+	if (kstrtoul(buf, 10, &val) || val != 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 854f911..3cc6fef 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -450,7 +450,7 @@ store_chassis_clear(struct device *dev,
 	unsigned long val;
 	u8 reg;
 
-	if (strict_strtoul(buf, 10, &val) || val != 0)
+	if (kstrtoul(buf, 10, &val) || val != 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 845232d..3ee398d 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -730,7 +730,7 @@ store_beep(struct device *dev, struct device_attribute *attr,
 	u8 beep_bit = 1 << shift;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	if (val != 0 && val != 1)
 		return -EINVAL;
@@ -755,7 +755,7 @@ store_chassis_clear(struct device *dev,
 	struct w83795_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0 || val != 0)
+	if (kstrtoul(buf, 10, &val) < 0 || val != 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -801,7 +801,7 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	struct w83795_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val))
+	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 	val = fan_to_reg(val);
 
@@ -863,7 +863,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -924,7 +924,7 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	int i;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	if (val < 1 || val > 2)
 		return -EINVAL;
@@ -1021,7 +1021,7 @@ store_temp_src(struct device *dev, struct device_attribute *attr,
 	unsigned long channel;
 	u8 val = index / 2;
 
-	if (strict_strtoul(buf, 10, &channel) < 0 ||
+	if (kstrtoul(buf, 10, &channel) < 0 ||
 	    channel < 1 || channel > 14)
 		return -EINVAL;
 
@@ -1088,7 +1088,7 @@ store_temp_pwm_enable(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	unsigned long tmp;
 
-	if (strict_strtoul(buf, 10, &tmp) < 0)
+	if (kstrtoul(buf, 10, &tmp) < 0)
 		return -EINVAL;
 
 	switch (nr) {
@@ -1149,7 +1149,7 @@ store_fanin(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1198,7 +1198,7 @@ store_temp_pwm(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	u8 tmp;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	val /= 1000;
 
@@ -1257,7 +1257,7 @@ store_sf4_pwm(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1293,7 +1293,7 @@ store_sf4_temp(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	val /= 1000;
 
@@ -1333,7 +1333,7 @@ store_temp(struct device *dev, struct device_attribute *attr,
 	struct w83795_data *data = i2c_get_clientdata(client);
 	long tmp;
 
-	if (strict_strtol(buf, 10, &tmp) < 0)
+	if (kstrtol(buf, 10, &tmp) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1394,7 +1394,7 @@ store_dts_ext(struct device *dev, struct device_attribute *attr,
 	struct w83795_data *data = i2c_get_clientdata(client);
 	long tmp;
 
-	if (strict_strtol(buf, 10, &tmp) < 0)
+	if (kstrtol(buf, 10, &tmp) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1436,7 +1436,7 @@ store_temp_mode(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	u8 tmp;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	if ((val != 4) && (val != 3))
 		return -EINVAL;
@@ -1512,7 +1512,7 @@ store_in(struct device *dev, struct device_attribute *attr,
 	u8 tmp;
 	u8 lsb_idx;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	val = in_to_reg(index, val);
 
@@ -1569,7 +1569,7 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 	struct w83795_data *data = i2c_get_clientdata(client);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 10, &val) < 0)
+	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	switch (nr) {
-- 
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
