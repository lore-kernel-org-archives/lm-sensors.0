From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:23 +0000
Subject: [lm-sensors] [PATCH 8/9] hwmon: (ltc4245) Fix 'Macros with complex values' checkpatch error
Message-Id: <1363221864-15284-9-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/ltc4245.c |  116 ++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 57 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 3653f79..cdc1ecc 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -319,80 +319,82 @@ static ssize_t ltc4245_show_gpio(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", val * 10);
 }
 
-/*
- * These macros are used below in constructing device attribute objects
- * for use with sysfs_create_group() to make a sysfs device file
- * for each register.
- */
-
-#define LTC4245_VOLTAGE(name, ltc4245_cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4245_show_voltage, NULL, ltc4245_cmd_idx)
-
-#define LTC4245_CURRENT(name, ltc4245_cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4245_show_current, NULL, ltc4245_cmd_idx)
-
-#define LTC4245_POWER(name, ltc4245_cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4245_show_power, NULL, ltc4245_cmd_idx)
-
-#define LTC4245_ALARM(name, mask, reg) \
-	static SENSOR_DEVICE_ATTR_2(name, S_IRUGO, \
-	ltc4245_show_alarm, NULL, (mask), reg)
-
-#define LTC4245_GPIO_VOLTAGE(name, gpio_num) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4245_show_gpio, NULL, gpio_num)
-
 /* Construct a sensor_device_attribute structure for each register */
 
 /* Input voltages */
-LTC4245_VOLTAGE(in1_input,			LTC4245_12VIN);
-LTC4245_VOLTAGE(in2_input,			LTC4245_5VIN);
-LTC4245_VOLTAGE(in3_input,			LTC4245_3VIN);
-LTC4245_VOLTAGE(in4_input,			LTC4245_VEEIN);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_12VIN);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_5VIN);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_3VIN);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_VEEIN);
 
 /* Input undervoltage alarms */
-LTC4245_ALARM(in1_min_alarm,	(1 << 0),	LTC4245_FAULT1);
-LTC4245_ALARM(in2_min_alarm,	(1 << 1),	LTC4245_FAULT1);
-LTC4245_ALARM(in3_min_alarm,	(1 << 2),	LTC4245_FAULT1);
-LTC4245_ALARM(in4_min_alarm,	(1 << 3),	LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(in1_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 0, LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(in2_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 1, LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(in3_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 2, LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(in4_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 3, LTC4245_FAULT1);
 
 /* Currents (via sense resistor) */
-LTC4245_CURRENT(curr1_input,			LTC4245_12VSENSE);
-LTC4245_CURRENT(curr2_input,			LTC4245_5VSENSE);
-LTC4245_CURRENT(curr3_input,			LTC4245_3VSENSE);
-LTC4245_CURRENT(curr4_input,			LTC4245_VEESENSE);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4245_show_current, NULL,
+			  LTC4245_12VSENSE);
+static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO, ltc4245_show_current, NULL,
+			  LTC4245_5VSENSE);
+static SENSOR_DEVICE_ATTR(curr3_input, S_IRUGO, ltc4245_show_current, NULL,
+			  LTC4245_3VSENSE);
+static SENSOR_DEVICE_ATTR(curr4_input, S_IRUGO, ltc4245_show_current, NULL,
+			  LTC4245_VEESENSE);
 
 /* Overcurrent alarms */
-LTC4245_ALARM(curr1_max_alarm,	(1 << 4),	LTC4245_FAULT1);
-LTC4245_ALARM(curr2_max_alarm,	(1 << 5),	LTC4245_FAULT1);
-LTC4245_ALARM(curr3_max_alarm,	(1 << 6),	LTC4245_FAULT1);
-LTC4245_ALARM(curr4_max_alarm,	(1 << 7),	LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(curr1_max_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 4, LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(curr2_max_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 5, LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(curr3_max_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 6, LTC4245_FAULT1);
+static SENSOR_DEVICE_ATTR_2(curr4_max_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 7, LTC4245_FAULT1);
 
 /* Output voltages */
-LTC4245_VOLTAGE(in5_input,			LTC4245_12VOUT);
-LTC4245_VOLTAGE(in6_input,			LTC4245_5VOUT);
-LTC4245_VOLTAGE(in7_input,			LTC4245_3VOUT);
-LTC4245_VOLTAGE(in8_input,			LTC4245_VEEOUT);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_12VOUT);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_5VOUT);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_3VOUT);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, ltc4245_show_voltage, NULL,
+			  LTC4245_VEEOUT);
 
 /* Power Bad alarms */
-LTC4245_ALARM(in5_min_alarm,	(1 << 0),	LTC4245_FAULT2);
-LTC4245_ALARM(in6_min_alarm,	(1 << 1),	LTC4245_FAULT2);
-LTC4245_ALARM(in7_min_alarm,	(1 << 2),	LTC4245_FAULT2);
-LTC4245_ALARM(in8_min_alarm,	(1 << 3),	LTC4245_FAULT2);
+static SENSOR_DEVICE_ATTR_2(in5_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 0, LTC4245_FAULT2);
+static SENSOR_DEVICE_ATTR_2(in6_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 1, LTC4245_FAULT2);
+static SENSOR_DEVICE_ATTR_2(in7_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 2, LTC4245_FAULT2);
+static SENSOR_DEVICE_ATTR_2(in8_min_alarm, S_IRUGO, ltc4245_show_alarm, NULL,
+			    1 << 3, LTC4245_FAULT2);
 
 /* GPIO voltages */
-LTC4245_GPIO_VOLTAGE(in9_input,			0);
-LTC4245_GPIO_VOLTAGE(in10_input,		1);
-LTC4245_GPIO_VOLTAGE(in11_input,		2);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, ltc4245_show_gpio, NULL, 0);
+static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, ltc4245_show_gpio, NULL, 1);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, ltc4245_show_gpio, NULL, 2);
 
 /* Power Consumption (virtual) */
-LTC4245_POWER(power1_input,			LTC4245_12VSENSE);
-LTC4245_POWER(power2_input,			LTC4245_5VSENSE);
-LTC4245_POWER(power3_input,			LTC4245_3VSENSE);
-LTC4245_POWER(power4_input,			LTC4245_VEESENSE);
+static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ltc4245_show_power, NULL,
+			  LTC4245_12VSENSE);
+static SENSOR_DEVICE_ATTR(power2_input, S_IRUGO, ltc4245_show_power, NULL,
+			  LTC4245_5VSENSE);
+static SENSOR_DEVICE_ATTR(power3_input, S_IRUGO, ltc4245_show_power, NULL,
+			  LTC4245_3VSENSE);
+static SENSOR_DEVICE_ATTR(power4_input, S_IRUGO, ltc4245_show_power, NULL,
+			  LTC4245_VEESENSE);
 
 /*
  * Finally, construct an array of pointers to members of the above objects,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
