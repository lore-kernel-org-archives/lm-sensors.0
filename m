From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 20 Mar 2008 13:32:38 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <20080320133238.GB2946@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

 adm1026.c |   22 ++++++++++++++--------
 adm1029.c |   30 +++++++++++++++++++-----------
 adm1031.c |   20 +++++++++++++++-----
 adm9240.c |   20 ++++++++++++++------
 adt7470.c |   40 ++++++++++++++++++++++++----------------
 adt7473.c |   54 +++++++++++++++++++++++++++++++-----------------------
 asb100.c  |   16 ++++++++++++----
 7 files changed, 129 insertions(+), 73 deletions(-)

commit 3c798b55145f42725c54d64ac7d69062a5d62bad
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Mon Mar 3 23:35:52 2008 -0500

    hwmon: fix common race conditions, batch 1
    
    Most hwmon drivers have one or more race conditions that could cause the driver
    to display incorrect data; in the absolute worst case, these races could allow
    divide-by-zero/OOPS.  The most common of these involves a race between setting
    a fan divider and displaying the fan data (RPMs).  This patch fixes these race
    conditions by taking the update lock (or equivalent) as necessary.
    
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 904c6ce..ff1fded 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -838,20 +838,26 @@ static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_in16_m
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-		data->fan_div[nr]));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan[nr], data->fan_div[nr]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
-		data->fan_div[nr]));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan_min[nr], data->fan_div[nr]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 2c6608d..8cd6c5a 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -165,27 +165,35 @@ show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
 static ssize_t
 show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm1029_data *data = adm1029_update_device(dev);
 	u16 val;
-	if (data->fan[attr->index] = 0 || data->fan_div[attr->index] = 0
-	    || data->fan[attr->index] = 255) {
-		return sprintf(buf, "0\n");
-	}
 
-	val = 1880 * 120 / DIV_FROM_REG(data->fan_div[attr->index])
-	    / data->fan[attr->index];
+	mutex_lock(&data->update_lock);
+	if (data->fan[index] = 0 || data->fan_div[index] = 0
+					|| data->fan[index] = 255)
+		val = 0;
+	else
+		val = 1880 * 120 / DIV_FROM_REG(data->fan_div[index])
+					/ data->fan[index];
+	mutex_unlock(&data->update_lock);
 	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t
 show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm1029_data *data = adm1029_update_device(dev);
-	if (data->fan_div[attr->index] = 0)
-		return sprintf(buf, "0\n");
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	if (data->fan_div[index] = 0)
+		val = 0;
+	else
+		val = DIV_FROM_REG(data->fan_div[index]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_fan_div(struct device *dev,
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 2bffcab..c88187a 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -466,8 +466,10 @@ static ssize_t show_fan(struct device *dev,
 	struct adm1031_data *data = adm1031_update_device(dev);
 	int value;
 
+	mutex_lock(&data->update_lock);
 	value = trust_fan_readings(data, nr) ? FAN_FROM_REG(data->fan[nr],
 				 FAN_DIV_FROM_REG(data->fan_div[nr])) : 0;
+	mutex_unlock(&data->update_lock);
 	return sprintf(buf, "%d\n", value);
 }
 
@@ -483,9 +485,13 @@ static ssize_t show_fan_min(struct device *dev,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       FAN_FROM_REG(data->fan_min[nr],
-				    FAN_DIV_FROM_REG(data->fan_div[nr])));
+	int value;
+
+	mutex_lock(&data->update_lock);
+	value = FAN_FROM_REG(data->fan_min[nr],
+				    FAN_DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", value);
 }
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
@@ -567,11 +573,15 @@ static ssize_t show_temp(struct device *dev,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
-	int ext;
+	int ext, val;
+
+	mutex_lock(&data->update_lock);
 	ext = nr = 0 ?
 	    ((data->ext_temp[nr] >> 6) & 0x3) * 2 :
 	    (((data->ext_temp[nr] >> ((nr - 1) * 3)) & 7));
-	return sprintf(buf, "%d\n", TEMP_FROM_REG_EXT(data->temp[nr], ext));
+	val = TEMP_FROM_REG_EXT(data->temp[nr], ext);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 static ssize_t show_temp_min(struct device *dev,
 			     struct device_attribute *attr, char *buf)
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 149ef25..f43986d 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -290,19 +290,27 @@ vin(5);
 static ssize_t show_fan(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-				1 << data->fan_div[attr->index]));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan[index], 1 << data->fan_div[index]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_fan_min(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[attr->index],
-				1 << data->fan_div[attr->index]));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan_min[index], 1 << data->fan_div[index]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_fan_div(struct device *dev,
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 6b5325f..4573855 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -402,14 +402,17 @@ static ssize_t show_fan_max(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7470_data *data = adt7470_update_device(dev);
+	int val;
 
-	if (FAN_DATA_VALID(data->fan_max[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
+	mutex_lock(&data->lock);
+	if (FAN_DATA_VALID(data->fan_max[index]))
+		val = FAN_PERIOD_TO_RPM(data->fan_max[index]);
 	else
-		return sprintf(buf, "0\n");
+		val = 0;
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_fan_max(struct device *dev,
@@ -437,14 +440,16 @@ static ssize_t show_fan_min(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7470_data *data = adt7470_update_device(dev);
-
-	if (FAN_DATA_VALID(data->fan_min[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
+	int val;
+	mutex_lock(&data->lock);
+	if (FAN_DATA_VALID(data->fan_min[index]))
+		val = FAN_PERIOD_TO_RPM(data->fan_min[index]);
 	else
-		return sprintf(buf, "0\n");
+		val = 0;
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_fan_min(struct device *dev,
@@ -471,14 +476,17 @@ static ssize_t set_fan_min(struct device *dev,
 static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7470_data *data = adt7470_update_device(dev);
+	int val;
 
-	if (FAN_DATA_VALID(data->fan[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
+	mutex_lock(&data->lock);
+	if (FAN_DATA_VALID(data->fan[index]))
+		val = FAN_PERIOD_TO_RPM(data->fan[index]);
 	else
-		return sprintf(buf, "0\n");
+		val = 0;
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_force_pwm_max(struct device *dev,
diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index c1009d6..28af6cc 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -211,6 +211,9 @@ static inline int adt7473_write_word_data(struct i2c_client *client, u8 reg,
 
 static void adt7473_init_client(struct i2c_client *client)
 {
+	struct adt7473_data *data = i2c_get_clientdata(client);
+	u8 cfg;
+
 	int reg = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG1);
 
 	if (!(reg & ADT7473_CFG1_READY)) {
@@ -220,6 +223,18 @@ static void adt7473_init_client(struct i2c_client *client)
 		i2c_smbus_write_byte_data(client, ADT7473_REG_CFG1,
 					  reg | ADT7473_CFG1_START);
 	}
+
+	/* Determine temperature encoding */
+	cfg = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG5);
+	data->temp_twos_complement = (cfg & ADT7473_CFG5_TEMP_TWOS);
+
+	/*
+	 * What does this do? it implies a variable temperature sensor
+	 * offset, but the datasheet doesn't say anything about this bit
+	 * and other parts of the datasheet imply that "offset64" mode
+	 * means that you shift temp values by -64 if the above bit was set.
+	 */
+	data->temp_offset = (cfg & ADT7473_CFG5_TEMP_OFFSET);
 }
 
 static struct adt7473_data *adt7473_update_device(struct device *dev)
@@ -227,7 +242,6 @@ static struct adt7473_data *adt7473_update_device(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
 	unsigned long local_jiffies = jiffies;
-	u8 cfg;
 	int i;
 
 	mutex_lock(&data->lock);
@@ -240,18 +254,6 @@ static struct adt7473_data *adt7473_update_device(struct device *dev)
 		data->volt[i] = i2c_smbus_read_byte_data(client,
 						ADT7473_REG_VOLT(i));
 
-	/* Determine temperature encoding */
-	cfg = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG5);
-	data->temp_twos_complement = (cfg & ADT7473_CFG5_TEMP_TWOS);
-
-	/*
-	 * What does this do? it implies a variable temperature sensor
-	 * offset, but the datasheet doesn't say anything about this bit
-	 * and other parts of the datasheet imply that "offset64" mode
-	 * means that you shift temp values by -64 if the above bit was set.
-	 */
-	data->temp_offset = (cfg & ADT7473_CFG5_TEMP_OFFSET);
-
 	for (i = 0; i < ADT7473_TEMP_COUNT; i++)
 		data->temp[i] = i2c_smbus_read_byte_data(client,
 							 ADT7473_REG_TEMP(i));
@@ -508,14 +510,17 @@ static ssize_t show_fan_min(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
+	int val;
 
-	if (FAN_DATA_VALID(data->fan_min[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
+	mutex_lock(&data->lock);
+	if (FAN_DATA_VALID(data->fan_min[index]))
+		val = FAN_PERIOD_TO_RPM(data->fan_min[index]);
 	else
-		return sprintf(buf, "0\n");
+		val = 0;
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_fan_min(struct device *dev,
@@ -542,14 +547,17 @@ static ssize_t set_fan_min(struct device *dev,
 static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
+	int val;
 
-	if (FAN_DATA_VALID(data->fan[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
+	mutex_lock(&data->lock);
+	if (FAN_DATA_VALID(data->fan[index]))
+		val = FAN_PERIOD_TO_RPM(data->fan[index]);
 	else
-		return sprintf(buf, "0\n");
+		val = 0;
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_max_duty_at_crit(struct device *dev,
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index fe2eea4..2aeac1a 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -276,8 +276,12 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct asb100_data *data = asb100_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-		DIV_FROM_REG(data->fan_div[nr])));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan[nr], DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
@@ -285,8 +289,12 @@ static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct asb100_data *data = asb100_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
-		DIV_FROM_REG(data->fan_div[nr])));
+	int val;
+
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
