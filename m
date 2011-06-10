From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Jun 2011 01:14:07 +0000
Subject: [lm-sensors] =?utf-8?q?=5BPATCH=5D_hwmon=3A_=28max1668=29_Add_sup?=
Message-Id: <1307668447-2786-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

MAX1668 and compatibles have several external temperature sensors, but only
a single FAULT status bit. If a fault occurs, the temperature reported on
affected sensors is 127 degrees C. Use this knowledge to report faults on
individual external sensors.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Tested with MAX1668 with one sensor disconnected. Resulting output is as follows.
Seems to be better than just reporting extra-high temperature.

root@groeck-desktop# sensors
max1668-i2c-5-18
Adapter: i2c-devantech-iss at bus 001 device 007
temp1:        +23.0°C  (low  = -55.0°C, high = +127.0°C)
temp2:        +25.0°C  (low  = -55.0°C, high = +127.0°C)
temp3:        +25.0°C  (low  = -55.0°C, high = +127.0°C)
temp4:        +25.0°C  (low  = -55.0°C, high = +127.0°C)
temp5:          FAULT  (low  = -55.0°C, high = +127.0°C)    ALARM(MAX)

 drivers/hwmon/max1668.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index ddefb64..af85d44 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -123,7 +123,7 @@ static struct max1668_data *max1668_update_device(struct device *dev)
 		goto abort;
 	}
 	data->alarms &= 0x00ff;
-	data->alarms |= ((u8) (val & 0x60)) << 8;
+	data->alarms |= ((u8) (val & 0x70)) << 8;
 
 	val = i2c_smbus_read_byte_data(client, MAX1668_REG_STAT2);
 	if (unlikely(val < 0)) {
@@ -189,6 +189,19 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
 }
 
+static ssize_t show_fault(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct max1668_data *data = max1668_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n",
+		       (data->alarms & (1 << 12)) && data->temp[index] = 127);
+}
+
 static ssize_t set_temp_max(struct device *dev,
 			    struct device_attribute *devattr,
 			    const char *buf, size_t count)
@@ -276,6 +289,11 @@ static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, 0);
 
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_fault, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_fault, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_fault, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_fault, NULL, 4);
+
 /* Attributes common to MAX1668, MAX1989 and MAX1805 */
 static struct attribute *max1668_attribute_common[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
@@ -294,6 +312,9 @@ static struct attribute *max1668_attribute_common[] = {
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 	NULL
 };
 
@@ -310,6 +331,9 @@ static struct attribute *max1668_attribute_unique[] = {
 	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp5_min_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp5_fault.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
