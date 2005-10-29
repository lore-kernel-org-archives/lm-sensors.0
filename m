From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:30:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: adm9240 whitespace cleanups
Message-Id: <11305336583325@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: adm9240 whitespace cleanups

This whitespace cleanup patch removes one trailing space and breaks
lines longer than 80 characters.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/hwmon/adm9240.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

---
commit e415e48b68155bea8b5452113dedba4ec486f3f6
tree 6da1a29383371ab143d0ae5b3d5e6fd9f7d3d0fd
parent 088341bd0c78143bf82ff21f7f0a715f99568c73
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:14:18 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:06 -0700

 drivers/hwmon/adm9240.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 8bb6d6e..11dc95f 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -219,8 +219,8 @@ static ssize_t show_in(struct device *de
 				attr->index));
 }
 
-static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr,
-		char *buf)
+static ssize_t show_in_min(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
@@ -228,8 +228,8 @@ static ssize_t show_in_min(struct device
 				attr->index));
 }
 
-static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr,
-		char *buf)
+static ssize_t show_in_max(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
@@ -237,7 +237,8 @@ static ssize_t show_in_max(struct device
 				attr->index));
 }
 
-static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr,
+static ssize_t set_in_min(struct device *dev,
+		struct device_attribute *devattr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -253,7 +254,8 @@ static ssize_t set_in_min(struct device 
 	return count;
 }
 
-static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr,
+static ssize_t set_in_max(struct device *dev,
+		struct device_attribute *devattr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -326,7 +328,7 @@ static void adm9240_write_fan_div(struct
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* 
+/*
  * set fan speed low limit:
  *
  * - value is zero: disable fan speed low limit alarm
@@ -404,7 +406,8 @@ fan(1);
 fan(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -412,7 +415,8 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -420,13 +424,16 @@ static ssize_t show_vid(struct device *d
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
@@ -441,7 +448,9 @@ static ssize_t set_aout(struct device *d
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);

