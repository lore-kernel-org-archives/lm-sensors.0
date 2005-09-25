From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:14:46 +0000
Subject: [lm-sensors] [PATCH] (1/13) hwmon: adm9240 whitespace cleanups
Message-Id: <20050925161418.34c03db7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This whitespace cleanup patch removes one trailing space and breaks 
lines longer than 80 characters.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/adm9240.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/hwmon/adm9240.c	2005-09-25 11:52:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/adm9240.c	2005-09-25 11:52:37.000000000 +0200
@@ -219,8 +219,8 @@
 				attr->index));
 }
 
-static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr,
-		char *buf)
+static ssize_t show_in_min(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
@@ -228,8 +228,8 @@
 				attr->index));
 }
 
-static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr,
-		char *buf)
+static ssize_t show_in_max(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
@@ -237,7 +237,8 @@
 				attr->index));
 }
 
-static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr,
+static ssize_t set_in_min(struct device *dev,
+		struct device_attribute *devattr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -253,7 +254,8 @@
 	return count;
 }
 
-static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr,
+static ssize_t set_in_max(struct device *dev,
+		struct device_attribute *devattr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -326,7 +328,7 @@
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* 
+/*
  * set fan speed low limit:
  *
  * - value is zero: disable fan speed low limit alarm
@@ -404,7 +406,8 @@
 fan(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -412,7 +415,8 @@
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -420,13 +424,16 @@
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* analog output */
-static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_aout(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
 
-static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
@@ -441,7 +448,9 @@
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);


-- 
Jean Delvare
