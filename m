From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 23 Sep 2005 01:53:19 +0000
Subject: [lm-sensors] [PATCH] driver hwmon adm9240 cleanup whitespace
Message-Id: <qpg6j1pggcu2ikstsufniueja8rg42sbt0@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

A catchup patch so we in sync.  Sorry for patch numbering ballsup.

Cheers,
Grant.

This whitespace cleanup patch removes one trailing space and breaks 
lines longer than 80 characters.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)

--- linux-2.6.14-rc2-mm1/drivers/hwmon/adm9240.c	2005-09-22 18:09:04.000000000 +1000
+++ linux-2.6.14-rc2-mm1a/drivers/hwmon/adm9240.c	2005-09-23 08:42:13.000000000 +1000
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
