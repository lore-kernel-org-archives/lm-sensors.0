From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Jan 2013 14:46:08 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm73) Add support for max/min alarms
Message-Id: <1357915569-6669-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Chris Verges <kg4ysn@gmail.com>

Add support for temp1_min_alarm and temp1_max_alarm

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
[linux@roeck-us.net: cleanup; dropped platform data and interrupt support]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I dropped platform data and interrupt support from the patch because
I can not test it with my setup. We can add that back in later
if wanted/needed.

 Documentation/hwmon/lm73 |   11 +++++++++++
 drivers/hwmon/lm73.c     |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
index 782b3e1..8af059d 100644
--- a/Documentation/hwmon/lm73
+++ b/Documentation/hwmon/lm73
@@ -77,3 +77,14 @@ via the following function:
 
 where 'x' is the output from 'update_interval' and 'g(x)' is the
 resolution in degrees C per LSB.
+
+Alarm Support
+-------------
+
+The LM73 features a simple over-temperature alarm mechanism.  This
+feature is exposed via the sysfs attributes.
+
+The attributes 'temp1_max_alarm' and 'temp1_min_alarm' are flags
+provided by the LM73 that indicate whether the measured temperature has
+passed the 'temp1_max' and 'temp1_min' thresholds, respectively.  These
+values _must_ be read to clear the registers on the LM73.
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 904c9ba..6f0134e 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -8,6 +8,7 @@
  * Guillaume Ligneul <guillaume.ligneul@gmail.com>
  * Adrien Demarez <adrien.demarez@bolloretelecom.eu>
  * Jeremy Laine <jeremy.laine@bolloretelecom.eu>
+ * Chris Verges <kg4ysn@gmail.com>
  *
  * This software program is licensed subject to the GNU General Public License
  * (GPL).Version 2,June 1991, available at
@@ -43,6 +44,9 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 #define LM73_CTRL_RES_MASK	(BIT(5) | BIT(6))
 #define LM73_CTRL_TO_MASK	BIT(7)
 
+#define LM73_CTRL_HI_SHIFT	2
+#define LM73_CTRL_LO_SHIFT	1
+
 static const unsigned short lm73_convrates[] = {
 	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
 	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
@@ -141,6 +145,28 @@ static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
 	return scnprintf(buf, PAGE_SIZE, "%hu\n", lm73_convrates[res]);
 }
 
+static ssize_t show_maxmin_alarm(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct lm73_data *data = i2c_get_clientdata(client);
+	s32 ctrl;
+
+	mutex_lock(&data->lock);
+	ctrl = i2c_smbus_read_byte_data(client, LM73_REG_CTRL);
+	if (ctrl < 0)
+		goto abort;
+	data->ctrl = ctrl;
+	mutex_unlock(&data->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", (ctrl >> attr->index) & 1);
+
+abort:
+	mutex_unlock(&data->lock);
+	return ctrl;
+}
+
 /*-----------------------------------------------------------------------*/
 
 /* sysfs attributes for hwmon */
@@ -153,12 +179,18 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 			show_temp, NULL, LM73_REG_INPUT);
 static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
 			show_convrate, set_convrate, 0);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
+			show_maxmin_alarm, NULL, LM73_CTRL_HI_SHIFT);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
+			show_maxmin_alarm, NULL, LM73_CTRL_LO_SHIFT);
 
 static struct attribute *lm73_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
