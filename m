From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 04 Mar 2008 14:54:40 +0000
Subject: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions, batch 1
Message-Id: <20080304145440.GE2892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

Here is the first in a batch of patches which aim to fix a common class
of race conditions in most hwmon drivers.  Credit goes to Herbert
Valerio Riedel for pointing this out, here:

http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/022014.html

To actually trip on any of these race conditions in practice would be
*exceedingly* rare.  In fact, I don't think we've ever seen a report for
such a case.  OTOH, one can see by looking at this patch that the fixes
are not always completely trivial.

I will concentrate on cranking out the remaining patches as I have time.
But of course I would like thorough reviews, especially from the driver
author/maintainer if possible.  To all potential reviewers: look not
just at the patch itself; please also scan the entire driver to see if
there are any races that I missed.  Testing is also much appreciated.

Thanks & regards,

commit 2475ee13652b392d9720b39f274205c815979557
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
index 904c6ce..92bed53 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -838,20 +838,24 @@ static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_in16_m
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
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan_min[nr], data->fan_div[nr]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 2c6608d..9080372 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -165,27 +165,33 @@ show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
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
-
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
index 149ef25..0023d44 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -290,19 +290,25 @@ vin(5);
 static ssize_t show_fan(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-				1 << data->fan_div[attr->index]));
+	int val;
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
+	mutex_lock(&data->update_lock);
+	val = FAN_FROM_REG(data->fan_min[index], 1 << data->fan_div[index]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_fan_div(struct device *dev,
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 6b5325f..2c398d5 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -402,14 +402,16 @@ static ssize_t show_fan_max(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7470_data *data = adt7470_update_device(dev);
-
-	if (FAN_DATA_VALID(data->fan_max[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
+	int val;
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
@@ -437,14 +439,16 @@ static ssize_t show_fan_min(struct device *dev,
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
@@ -471,14 +475,16 @@ static ssize_t set_fan_min(struct device *dev,
 static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7470_data *data = adt7470_update_device(dev);
-
-	if (FAN_DATA_VALID(data->fan[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
+	int val;
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
@@ -678,14 +684,15 @@ static ssize_t show_pwm_auto_temp(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7470_data *data = adt7470_update_device(dev);
-	u8 ctrl = data->pwm_auto_temp[attr->index];
-
-	if (ctrl)
-		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
-	else
-		return sprintf(buf, "%d\n", ADT7470_PWM_ALL_TEMPS);
+	u8 ctrl;
+	int val;
+	mutex_lock(&data->lock);
+	ctrl = data->pwm_auto_temp[index];
+	val = ctrl ?  (1 << (ctrl - 1)) : ADT7470_PWM_ALL_TEMPS;
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static int cvt_auto_temp(int input)
diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 9587869..3807062 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -422,11 +422,9 @@ static ssize_t show_volt(struct device *dev, struct device_attribute *devattr,
  * number in the range -128 to 127, or as an unsigned number that must
  * be offset by 64.
  */
-static int decode_temp(struct adt7473_data *data, u8 raw)
+static int decode_temp(u8 twos_complement, u8 raw)
 {
-	if (data->temp_twos_complement)
-		return (s8)raw;
-	return raw - 64;
+	return twos_complement ? (s8)raw : raw - 64;
 }
 
 static u8 encode_temp(struct adt7473_data *data, int cooked)
@@ -440,10 +438,14 @@ static ssize_t show_temp_min(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_min[attr->index]));
+	int val;
+	mutex_lock(&data->lock);
+	val = 1000 * decode_temp(data->temp_twos_complement,
+			data->temp_min[index]);
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_temp_min(struct device *dev,
@@ -470,10 +472,14 @@ static ssize_t show_temp_max(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_max[attr->index]));
+	int val;
+	mutex_lock(&data->lock);
+	val = 1000 * decode_temp(data->temp_twos_complement,
+			data->temp_max[index]);
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_temp_max(struct device *dev,
@@ -499,24 +505,30 @@ static ssize_t set_temp_max(struct device *dev,
 static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp[attr->index]));
+	int val;
+	mutex_lock(&data->lock);
+	val = 1000 * decode_temp(data->temp_twos_complement,
+			data->temp[index]);
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t show_fan_min(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
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
@@ -543,14 +555,16 @@ static ssize_t set_fan_min(struct device *dev,
 static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
-
-	if (FAN_DATA_VALID(data->fan[attr->index]))
-		return sprintf(buf, "%d\n",
-			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
+	int val;
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
@@ -669,10 +683,14 @@ static ssize_t show_temp_tmax(struct device *dev,
 			      struct device_attribute *devattr,
 			      char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_tmax[attr->index]));
+	int val;
+	mutex_lock(&data->lock);
+	val = 1000 * decode_temp(data->temp_twos_complement,
+			data->temp_tmax[index]);
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_temp_tmax(struct device *dev,
@@ -699,10 +717,14 @@ static ssize_t show_temp_tmin(struct device *dev,
 			      struct device_attribute *devattr,
 			      char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = to_sensor_dev_attr(devattr)->index;
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_tmin[attr->index]));
+	int val;
+	mutex_lock(&data->lock);
+	val = 1000 * decode_temp(data->temp_twos_complement,
+			data->temp_tmin[index]);
+	mutex_unlock(&data->lock);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t set_temp_tmin(struct device *dev,
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
