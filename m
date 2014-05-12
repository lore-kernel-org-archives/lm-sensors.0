From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:50 +0000
Subject: [lm-sensors] [PATCH 8/9] hwmon: (emc1403) Add support for min_hyst attributes
Message-Id: <1399921311-9524-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The hysteresis value applies to all limits, so add support for
tempX_min_hyst.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index a9ebd68..9b1c45c 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -106,8 +106,9 @@ static ssize_t store_bit(struct device *dev,
 	return count;
 }
 
-static ssize_t show_hyst(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t show_hyst_common(struct device *dev,
+				struct device_attribute *attr, char *buf,
+				bool is_min)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
@@ -124,7 +125,19 @@ static ssize_t show_hyst(struct device *dev,
 	if (retval < 0)
 		return retval;
 
-	return sprintf(buf, "%d000\n", limit - hyst);
+	return sprintf(buf, "%d000\n", is_min ? limit + hyst : limit - hyst);
+}
+
+static ssize_t show_hyst(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return show_hyst_common(dev, attr, buf, false);
+}
+
+static ssize_t show_min_hyst(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return show_hyst_common(dev, attr, buf, true);
 }
 
 static ssize_t store_hyst(struct device *dev,
@@ -173,6 +186,7 @@ static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x01);
 static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x01);
+static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x06);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_hyst, NULL, 0x05);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO | S_IWUSR,
 	show_hyst, store_hyst, 0x20);
@@ -191,6 +205,7 @@ static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x02);
 static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x02);
+static SENSOR_DEVICE_ATTR(temp2_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x08);
 static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO, show_hyst, NULL, 0x07);
 static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_hyst, NULL, 0x19);
 
@@ -208,6 +223,7 @@ static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x04);
 static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x04);
+static SENSOR_DEVICE_ATTR(temp3_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x16);
 static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO, show_hyst, NULL, 0x15);
 static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_hyst, NULL, 0x1A);
 
@@ -225,6 +241,7 @@ static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x08);
 static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x08);
+static SENSOR_DEVICE_ATTR(temp4_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x2D);
 static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IRUGO, show_hyst, NULL, 0x2C);
 static SENSOR_DEVICE_ATTR(temp4_crit_hyst, S_IRUGO, show_hyst, NULL, 0x30);
 
@@ -236,6 +253,7 @@ static struct attribute *emc1402_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
 
@@ -243,6 +261,7 @@ static struct attribute *emc1402_attrs[] = {
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
 
@@ -272,6 +291,7 @@ static struct attribute *emc1403_attrs[] = {
 	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
 	NULL
@@ -290,6 +310,7 @@ static struct attribute *emc1404_attrs[] = {
 	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_min_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_hyst.dev_attr.attr,
 	NULL
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
