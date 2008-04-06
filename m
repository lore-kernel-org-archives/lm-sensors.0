From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 06 Apr 2008 18:07:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix common race conditions, batch 2
Message-Id: <20080406180721.GN27659@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

 atxp1.c    |    2 ++
 coretemp.c |    2 ++
 dme1737.c  |    6 ++++++
 f71882fg.c |   14 ++++++++++----
 gl518sm.c  |   18 ++++++++++++++----
 gl520sm.c  |   16 ++++++++++++----
 it87.c     |   26 ++++++++++++++++----------
 7 files changed, 62 insertions(+), 22 deletions(-)

NB: reviewers are also encouraged to have a look at these files, in which I
found no race condtions of this class:

ds1621.c
f71805f.c
f75375s.c
fscher.c
fschmd.c
fscpos.c
i5k_amb.c
ibmpex.c

commit e62da7be499f5553ce682aa6830a4e51ab293619
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Sun Apr 6 13:45:00 2008 -0400

    hwmon: fix common race conditions, batch 2
    
    Most hwmon drivers have one or more race conditions that could cause the driver
    to display incorrect data; in the absolute worst case, these races could allow
    divide-by-zero/OOPS.  The most common of these involves a race between setting
    a fan divider and displaying the fan data (RPMs).  This patch fixes these race
    conditions by taking the update lock (or equivalent) as necessary.
    
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 01c17e3..aca58c9 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -136,10 +136,12 @@ static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *att
 	}
 
 	/* If output enabled, use control register value. Otherwise original CPU VID */
+	mutex_lock(&data->update_lock);
 	if (data->reg.vid & ATXP1_VIDENA)
 		cvid = data->reg.vid & ATXP1_VIDMASK;
 	else
 		cvid = data->reg.cpu_vid;
+	mutex_unlock(&data->update_lock);
 
 	/* Nothing changed, aborting */
 	if (vid = cvid)
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 70239ac..1fbaeff 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -93,12 +93,14 @@ static ssize_t show_temp(struct device *dev,
 	struct coretemp_data *data = coretemp_update_device(dev);
 	int err;
 
+	mutex_lock(&data->update_lock);
 	if (attr->index = SHOW_TEMP)
 		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
 	else if (attr->index = SHOW_TJMAX)
 		err = sprintf(buf, "%d\n", data->tjmax);
 	else
 		err = sprintf(buf, "%d\n", data->ttarget);
+	mutex_unlock(&data->update_lock);
 	return err;
 }
 
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 7673f65..28c9d25 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -878,6 +878,7 @@ static ssize_t show_zone(struct device *dev, struct device_attribute *attr,
 	int fn = sensor_attr_2->nr;
 	int res;
 
+	mutex_lock(&data->update_lock);
 	switch (fn) {
 	case SYS_ZONE_AUTO_CHANNELS_TEMP:
 		/* check config2 for non-standard temp-to-zone mapping */
@@ -906,6 +907,7 @@ static ssize_t show_zone(struct device *dev, struct device_attribute *attr,
 		res = 0;
 		dev_dbg(dev, "Unknown function %d.\n", fn);
 	}
+	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", res);
 }
@@ -987,6 +989,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 	int fn = sensor_attr_2->nr;
 	int res;
 
+	mutex_lock(&data->update_lock);
 	switch (fn) {
 	case SYS_FAN_INPUT:
 		res = FAN_FROM_REG(data->fan[ix],
@@ -1013,6 +1016,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 		res = 0;
 		dev_dbg(dev, "Unknown function %d.\n", fn);
 	}
+	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", res);
 }
@@ -1099,6 +1103,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 	int fn = sensor_attr_2->nr;
 	int res;
 
+	mutex_lock(&data->update_lock);
 	switch (fn) {
 	case SYS_PWM:
 		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 0) {
@@ -1149,6 +1154,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 		res = 0;
 		dev_dbg(dev, "Unknown function %d.\n", fn);
 	}
+	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", res);
 }
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index cbeb498..a97ebde 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -593,9 +593,12 @@ static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr(devattr)->index;
+	int res;
 
-	return sprintf(buf, "%d\n",
-		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
+	mutex_lock(&data->update_lock);
+	res = (data->temp_high[nr] - data->temp_hyst[nr]) * 1000;
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", res);
 }
 
 static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
@@ -670,9 +673,12 @@ static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr(devattr)->index;
+	int res;
 
-	return sprintf(buf, "%d\n",
-		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
+	mutex_lock(&data->update_lock);
+	res = (data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000;
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", res);
 }
 
 static ssize_t show_temp_type(struct device *dev, struct device_attribute
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 33e9e8a..8b83690 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -191,8 +191,13 @@ static ssize_t show_fan_input(struct device *dev,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct gl518_data *data = gl518_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_in[nr],
-					DIV_FROM_REG(data->fan_div[nr])));
+	int result;
+
+	mutex_lock(&data->update_lock);
+	result = FAN_FROM_REG(data->fan_in[nr],
+				DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", result);
 }
 
 static ssize_t show_fan_min(struct device *dev,
@@ -200,8 +205,13 @@ static ssize_t show_fan_min(struct device *dev,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct gl518_data *data = gl518_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
-					DIV_FROM_REG(data->fan_div[nr])));
+	int result;
+
+	mutex_lock(&data->update_lock);
+	result = FAN_FROM_REG(data->fan_min[nr],
+				DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", result);
 }
 
 static ssize_t show_fan_div(struct device *dev,
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 8984ef1..804018d 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -273,9 +273,13 @@ static ssize_t get_fan_input(struct device *dev, struct device_attribute *attr,
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
+	int result;
 
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_input[n],
-						 data->fan_div[n]));
+	mutex_lock(&data->update_lock);
+	result = FAN_FROM_REG(data->fan_input[n],
+				data->fan_div[n]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", result);
 }
 
 static ssize_t get_fan_min(struct device *dev, struct device_attribute *attr,
@@ -283,9 +287,13 @@ static ssize_t get_fan_min(struct device *dev, struct device_attribute *attr,
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
+	int result;
 
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[n],
-						 data->fan_div[n]));
+	mutex_lock(&data->update_lock);
+	result = FAN_FROM_REG(data->fan_min[n],
+				 data->fan_div[n]);
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", result);
 }
 
 static ssize_t get_fan_div(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e12c132..45a216f 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -502,22 +502,28 @@ show_sensor_offset(3);
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
-				DIV_FROM_REG(data->fan_div[nr])));
+	int result;
+
+	mutex_lock(&data->update_lock);
+	result = FAN_FROM_REG(data->fan[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", result);
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
+	int result;
+
+	mutex_lock(&data->update_lock);
+	result = FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", result);
 }
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 		char *buf)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
