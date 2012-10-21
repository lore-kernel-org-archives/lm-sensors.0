From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Oct 2012 17:53:10 +0000
Subject: [lm-sensors] [PATCH 3/8] hwmon: (it87) Replace macro defining tempX_type sensors with direct definit
Message-Id: <1350841995-5748-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The macro name show_sensor_offset is confusing since it related to the sensor
type, not an offset - even more so when we introduce offset attributes later on.
Replace it with direct definitions, and replace the show_sensor/set_sensor
function names with show_type/set_type. This also resolves a checkpatch error.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index d211c2b..82f7924 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -556,8 +556,8 @@ static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
 static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGOWU, show_temp, set_temp, 2, 1);
 static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGOWU, show_temp, set_temp, 2, 2);
 
-static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
@@ -570,8 +570,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
 		return sprintf(buf, "4\n");  /* thermistor */
 	return sprintf(buf, "0\n");      /* disabled */
 }
-static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
@@ -606,13 +607,10 @@ static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-#define show_sensor_offset(offset)					\
-static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	\
-		show_sensor, set_sensor, offset - 1);
 
-show_sensor_offset(1);
-show_sensor_offset(2);
-show_sensor_offset(3);
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGOWU, show_type, set_type, 0);
+static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGOWU, show_type, set_type, 1);
+static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGOWU, show_type, set_type, 2);
 
 /* 3 Fans */
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
