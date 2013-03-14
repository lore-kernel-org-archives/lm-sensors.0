From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:22 +0000
Subject: [lm-sensors] [PATCH 7/9] hwmon: (ltc4215) Fix 'Macros with complex values' checkpatch error
Message-Id: <1363221864-15284-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:
ERROR: Macros with complex values should be enclosed in parenthesis

by unwinding the problematic macros.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4215.c |   46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index e887610..8a14296 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -172,12 +172,12 @@ static ssize_t ltc4215_show_alarm(struct device *dev,
 					  struct device_attribute *da,
 					  char *buf)
 {
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(da);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ltc4215_data *data = ltc4215_update_device(dev);
-	const u8 reg = data->regs[attr->index];
-	const u32 mask = attr->nr;
+	const u8 reg = data->regs[LTC4215_STATUS];
+	const u32 mask = attr->index;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", (reg & mask) ? 1 : 0);
+	return snprintf(buf, PAGE_SIZE, "%u\n", !!(reg & mask));
 }
 
 /*
@@ -186,39 +186,29 @@ static ssize_t ltc4215_show_alarm(struct device *dev,
  * for each register.
  */
 
-#define LTC4215_VOLTAGE(name, ltc4215_cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4215_show_voltage, NULL, ltc4215_cmd_idx)
-
-#define LTC4215_CURRENT(name) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4215_show_current, NULL, 0);
-
-#define LTC4215_POWER(name) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4215_show_power, NULL, 0);
-
-#define LTC4215_ALARM(name, mask, reg) \
-	static SENSOR_DEVICE_ATTR_2(name, S_IRUGO, \
-	ltc4215_show_alarm, NULL, (mask), reg)
-
 /* Construct a sensor_device_attribute structure for each register */
 
 /* Current */
-LTC4215_CURRENT(curr1_input);
-LTC4215_ALARM(curr1_max_alarm,	(1 << 2),	LTC4215_STATUS);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4215_show_current, NULL, 0);
+static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
+			  1 << 2);
 
 /* Power (virtual) */
-LTC4215_POWER(power1_input);
+static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ltc4215_show_power, NULL, 0);
 
 /* Input Voltage */
-LTC4215_VOLTAGE(in1_input,			LTC4215_ADIN);
-LTC4215_ALARM(in1_max_alarm,	(1 << 0),	LTC4215_STATUS);
-LTC4215_ALARM(in1_min_alarm,	(1 << 1),	LTC4215_STATUS);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4215_show_voltage, NULL,
+			  LTC4215_ADIN);
+static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
+			  1 << 0);
+static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
+			  1 << 1);
 
 /* Output Voltage */
-LTC4215_VOLTAGE(in2_input,			LTC4215_SOURCE);
-LTC4215_ALARM(in2_min_alarm,	(1 << 3),	LTC4215_STATUS);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4215_show_voltage, NULL,
+			  LTC4215_SOURCE);
+static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
+			  1 << 3);
 
 /*
  * Finally, construct an array of pointers to members of the above objects,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
