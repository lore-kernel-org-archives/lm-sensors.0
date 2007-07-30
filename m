From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 30 Jul 2007 19:16:53 +0000
Subject: [lm-sensors] [PATCH] adt7470: Use sysfs_create_group for attributes
Message-Id: <20070730191652.GC2795@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Downloaded a new version of sparse and it complained about the
ARRAY_SIZE() macro.  Since neither the maintainer nor sparse seem to
like this setup, I suppose it's worth the time to put it back... even if
it does make the driver lengthier and use more memory.  Heh.

--D
---
Use sysfs_create_group and two static attribute arrays instead of one array
and a for loop to eliminate sparse warnings and make maintainer happy.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7470.c |  378 ++++++++++++++++++++++++++++-------------------
 1 files changed, 224 insertions(+), 154 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 582fa7a..c4dc205 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -125,6 +125,7 @@ I2C_CLIENT_INSMOD_1(adt7470);
 struct adt7470_data {
 	struct i2c_client	client;
 	struct class_device	*class_dev;
+	struct attribute_group	attrs;
 	struct mutex		lock;
 	char			sensors_valid;
 	char			limits_valid;
@@ -714,148 +715,223 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
 	return count;
 }
 
-static struct sensor_device_attribute adt7470_attr[] -{
-	SENSOR_ATTR(alarms, S_IRUGO, show_alarms, NULL, 0),
-	SENSOR_ATTR(alarm_mask, S_IRUGO, show_alarms, NULL, 1),
-
-	SENSOR_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 0),
-	SENSOR_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 1),
-	SENSOR_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 2),
-	SENSOR_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 3),
-	SENSOR_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 4),
-	SENSOR_ATTR(temp6_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 5),
-	SENSOR_ATTR(temp7_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 6),
-	SENSOR_ATTR(temp8_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 7),
-	SENSOR_ATTR(temp9_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 8),
-	SENSOR_ATTR(temp10_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 9),
-
-	SENSOR_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 0),
-	SENSOR_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 1),
-	SENSOR_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 2),
-	SENSOR_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 3),
-	SENSOR_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 4),
-	SENSOR_ATTR(temp6_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 5),
-	SENSOR_ATTR(temp7_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 6),
-	SENSOR_ATTR(temp8_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 7),
-	SENSOR_ATTR(temp9_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 8),
-	SENSOR_ATTR(temp10_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 9),
-
-	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
-	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
-	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
-	SENSOR_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3),
-	SENSOR_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4),
-	SENSOR_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5),
-	SENSOR_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6),
-	SENSOR_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7),
-	SENSOR_ATTR(temp9_input, S_IRUGO, show_temp, NULL, 8),
-	SENSOR_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 9),
-
-	SENSOR_ATTR(fan1_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 0),
-	SENSOR_ATTR(fan2_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 1),
-	SENSOR_ATTR(fan3_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 2),
-	SENSOR_ATTR(fan4_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 3),
-
-	SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 0),
-	SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 1),
-	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 2),
-	SENSOR_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 3),
-
-	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
-	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
-	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
-	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
-
-	SENSOR_ATTR(force_pwm_max, S_IWUSR | S_IRUGO,
-		    show_force_pwm_max, set_force_pwm_max, 0),
-
-	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0),
-	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1),
-	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
-	SENSOR_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3),
-
-	SENSOR_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 0),
-	SENSOR_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 1),
-	SENSOR_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 2),
-	SENSOR_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 3),
-
-	SENSOR_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 0),
-	SENSOR_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 1),
-	SENSOR_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 2),
-	SENSOR_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 3),
-
-	SENSOR_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 0),
-	SENSOR_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 1),
-	SENSOR_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 2),
-	SENSOR_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 3),
-
-	SENSOR_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 0),
-	SENSOR_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 1),
-	SENSOR_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 2),
-	SENSOR_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 3),
-
-	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 0),
-	SENSOR_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 1),
-	SENSOR_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 2),
-	SENSOR_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 3),
-
-	SENSOR_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 0),
-	SENSOR_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 1),
-	SENSOR_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 2),
-	SENSOR_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 3)
+static SENSOR_DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL, 0);
+static SENSOR_DEVICE_ATTR(alarm_mask, S_IRUGO, show_alarms, NULL, 1);
+
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 2);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 3);
+static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 4);
+static SENSOR_DEVICE_ATTR(temp6_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 5);
+static SENSOR_DEVICE_ATTR(temp7_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 6);
+static SENSOR_DEVICE_ATTR(temp8_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 7);
+static SENSOR_DEVICE_ATTR(temp9_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 8);
+static SENSOR_DEVICE_ATTR(temp10_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    set_temp_max, 9);
+
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 2);
+static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 3);
+static SENSOR_DEVICE_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 4);
+static SENSOR_DEVICE_ATTR(temp6_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 5);
+static SENSOR_DEVICE_ATTR(temp7_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 6);
+static SENSOR_DEVICE_ATTR(temp8_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 7);
+static SENSOR_DEVICE_ATTR(temp9_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 8);
+static SENSOR_DEVICE_ATTR(temp10_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    set_temp_min, 9);
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp9_input, S_IRUGO, show_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 9);
+
+static SENSOR_DEVICE_ATTR(fan1_max, S_IWUSR | S_IRUGO, show_fan_max,
+		    set_fan_max, 0);
+static SENSOR_DEVICE_ATTR(fan2_max, S_IWUSR | S_IRUGO, show_fan_max,
+		    set_fan_max, 1);
+static SENSOR_DEVICE_ATTR(fan3_max, S_IWUSR | S_IRUGO, show_fan_max,
+		    set_fan_max, 2);
+static SENSOR_DEVICE_ATTR(fan4_max, S_IWUSR | S_IRUGO, show_fan_max,
+		    set_fan_max, 3);
+
+static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    set_fan_min, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    set_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    set_fan_min, 2);
+static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
+		    set_fan_min, 3);
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(force_pwm_max, S_IWUSR | S_IRUGO,
+		    show_force_pwm_max, set_force_pwm_max, 0);
+
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_min, set_pwm_min, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_min, set_pwm_min, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_min, set_pwm_min, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_min, set_pwm_min, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_max, set_pwm_max, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_max, set_pwm_max, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_max, set_pwm_max, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		    show_pwm_max, set_pwm_max, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_tmin, set_pwm_tmin, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_tmin, set_pwm_tmin, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_tmin, set_pwm_tmin, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_tmin, set_pwm_tmin, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+		    NULL, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+		    NULL, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+		    NULL, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+		    NULL, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
+		    set_pwm_auto, 0);
+static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
+		    set_pwm_auto, 1);
+static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
+		    set_pwm_auto, 2);
+static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
+		    set_pwm_auto, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_auto_temp, set_pwm_auto_temp, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_auto_temp, set_pwm_auto_temp, 1);
+static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_auto_temp, set_pwm_auto_temp, 2);
+static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
+		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
+
+static struct attribute *adt7470_attr[] +{
+	&sensor_dev_attr_alarms.dev_attr.attr,
+	&sensor_dev_attr_alarm_mask.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp5_max.dev_attr.attr,
+	&sensor_dev_attr_temp6_max.dev_attr.attr,
+	&sensor_dev_attr_temp7_max.dev_attr.attr,
+	&sensor_dev_attr_temp8_max.dev_attr.attr,
+	&sensor_dev_attr_temp9_max.dev_attr.attr,
+	&sensor_dev_attr_temp10_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp4_min.dev_attr.attr,
+	&sensor_dev_attr_temp5_min.dev_attr.attr,
+	&sensor_dev_attr_temp6_min.dev_attr.attr,
+	&sensor_dev_attr_temp7_min.dev_attr.attr,
+	&sensor_dev_attr_temp8_min.dev_attr.attr,
+	&sensor_dev_attr_temp9_min.dev_attr.attr,
+	&sensor_dev_attr_temp10_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	&sensor_dev_attr_temp7_input.dev_attr.attr,
+	&sensor_dev_attr_temp8_input.dev_attr.attr,
+	&sensor_dev_attr_temp9_input.dev_attr.attr,
+	&sensor_dev_attr_temp10_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_max.dev_attr.attr,
+	&sensor_dev_attr_fan2_max.dev_attr.attr,
+	&sensor_dev_attr_fan3_max.dev_attr.attr,
+	&sensor_dev_attr_fan4_max.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm4_auto_channels_temp.dev_attr.attr,
+	NULL
 };
 
 static int adt7470_attach_adapter(struct i2c_adapter *adapter)
@@ -870,7 +946,6 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
 	struct i2c_client *client;
 	struct adt7470_data *data;
 	int err = 0;
-	int i;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
@@ -924,12 +999,9 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
 	adt7470_init_client(client);
 
 	/* Register sysfs hooks */
-	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++) {
-		err = device_create_file(&client->dev,
-					 &adt7470_attr[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
+	data->attrs.attrs = adt7470_attr;
+	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
+		goto exit_detach;
 
 	data->class_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->class_dev)) {
@@ -940,8 +1012,8 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
 	return 0;
 
 exit_remove:
-	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++)
-		device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);
+	sysfs_remove_group(&client->dev.kobj, &data->attrs);
+exit_detach:
 	i2c_detach_client(client);
 exit_free:
 	kfree(data);
@@ -952,11 +1024,9 @@ exit:
 static int adt7470_detach_client(struct i2c_client *client)
 {
 	struct adt7470_data *data = i2c_get_clientdata(client);
-	int i;
 
 	hwmon_device_unregister(data->class_dev);
-	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++)
-		device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);
+	sysfs_remove_group(&client->dev.kobj, &data->attrs);
 	i2c_detach_client(client);
 	kfree(data);
 	return 0;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
