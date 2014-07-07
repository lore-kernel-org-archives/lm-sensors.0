From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 07 Jul 2014 14:14:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adc128d818) Drop write support on inX_input attributes
Message-Id: <1404742496-14493-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Writes into input registers doesn't make sense, even more so since
the writes actually ended up writing into the maximum limit registers.
Drop it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adc128d818.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 5ffd81f..0625e50 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -239,50 +239,50 @@ static ssize_t adc128_show_alarm(struct device *dev,
 	return sprintf(buf, "%u\n", !!(alarms & mask));
 }
 
-static SENSOR_DEVICE_ATTR_2(in0_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 0, 0);
+static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO,
+			    adc128_show_in, NULL, 0, 0);
 static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 0, 1);
 static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 0, 2);
 
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 1, 0);
+static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO,
+			    adc128_show_in, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 1, 1);
 static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 1, 2);
 
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 2, 0);
+static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO,
+			    adc128_show_in, NULL, 2, 0);
 static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 2, 1);
 static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 2, 2);
 
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 3, 0);
+static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO,
+			    adc128_show_in, NULL, 3, 0);
 static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 3, 1);
 static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 3, 2);
 
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 4, 0);
+static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO,
+			    adc128_show_in, NULL, 4, 0);
 static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 4, 1);
 static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 4, 2);
 
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 5, 0);
+static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO,
+			    adc128_show_in, NULL, 5, 0);
 static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 5, 1);
 static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 5, 2);
 
-static SENSOR_DEVICE_ATTR_2(in6_input, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 6, 0);
+static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO,
+			    adc128_show_in, NULL, 6, 0);
 static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO,
 			    adc128_show_in, adc128_set_in, 6, 1);
 static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
