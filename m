From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:56:09 +0000
Subject: [lm-sensors] [patch 09/36] hwmon: (w83795) Use 2D arrays for many
Message-Id: <20100915155609.7c3cb658@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use 2D arrays for in, fan, temp and dts device attributes. Using
linear arrays is too risky as we have to skip some groups depending
on the device model and configuration. Adding or removing an
attribute would let the driver build silently but then it would crash
at runtime. With 2D arrays, the consistency checking happens at build
time, which is much safer.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   66 ++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:48.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:50.000000000 +0200
@@ -1447,7 +1447,7 @@ store_sf_setup(struct device *dev, struc
 
 #define NOT_USED			-1
 
-#define SENSOR_ATTR_IN(index)		\
+#define SENSOR_ATTR_IN(index) {						\
 	SENSOR_ATTR_2(in##index##_input, S_IRUGO, show_in, NULL,	\
 		IN_READ, index), \
 	SENSOR_ATTR_2(in##index##_max, S_IRUGO | S_IWUSR, show_in,	\
@@ -1458,9 +1458,9 @@ store_sf_setup(struct device *dev, struc
 		NULL, ALARM_STATUS, index + ((index > 14) ? 1 : 0)), \
 	SENSOR_ATTR_2(in##index##_beep, S_IWUSR | S_IRUGO,		\
 		show_alarm_beep, store_beep, BEEP_ENABLE,		\
-		index + ((index > 14) ? 1 : 0))
+		index + ((index > 14) ? 1 : 0)) }
 
-#define SENSOR_ATTR_FAN(index)						\
+#define SENSOR_ATTR_FAN(index) {					\
 	SENSOR_ATTR_2(fan##index##_input, S_IRUGO, show_fan,		\
 		NULL, FAN_INPUT, index - 1), \
 	SENSOR_ATTR_2(fan##index##_min, S_IWUSR | S_IRUGO,		\
@@ -1468,7 +1468,7 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(fan##index##_alarm, S_IRUGO, show_alarm_beep,	\
 		NULL, ALARM_STATUS, index + 31),			\
 	SENSOR_ATTR_2(fan##index##_beep, S_IWUSR | S_IRUGO,		\
-		show_alarm_beep, store_beep, BEEP_ENABLE, index + 31)
+		show_alarm_beep, store_beep, BEEP_ENABLE, index + 31) }
 
 #define SENSOR_ATTR_PWM(index)						\
 	SENSOR_ATTR_2(pwm##index, S_IWUSR | S_IRUGO, show_pwm,		\
@@ -1488,7 +1488,7 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(speed_cruise##index##_target, S_IWUSR | S_IRUGO, \
 		show_fanin, store_fanin, FANIN_TARGET, index - 1)
 
-#define SENSOR_ATTR_DTS(index)						\
+#define SENSOR_ATTR_DTS(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO ,		\
 		show_dts_mode, NULL, NOT_USED, index - 7),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_dts,		\
@@ -1504,9 +1504,9 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(temp##index##_alarm, S_IRUGO,			\
 		show_alarm_beep, NULL, ALARM_STATUS, index + 17),	\
 	SENSOR_ATTR_2(temp##index##_beep, S_IWUSR | S_IRUGO,		\
-		show_alarm_beep, store_beep, BEEP_ENABLE, index + 17)
+		show_alarm_beep, store_beep, BEEP_ENABLE, index + 17) }
 
-#define SENSOR_ATTR_TEMP(index)						\
+#define SENSOR_ATTR_TEMP(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | S_IWUSR,		\
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
@@ -1568,10 +1568,10 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(temp##index##_auto_point6_temp, S_IRUGO | S_IWUSR,\
 		show_sf4_temp, store_sf4_temp, 5, index - 1),		\
 	SENSOR_ATTR_2(temp##index##_auto_point7_temp, S_IRUGO | S_IWUSR,\
-		show_sf4_temp, store_sf4_temp, 6, index - 1)
+		show_sf4_temp, store_sf4_temp, 6, index - 1) }
 
 
-static struct sensor_device_attribute_2 w83795_in[] = {
+static struct sensor_device_attribute_2 w83795_in[][5] = {
 	SENSOR_ATTR_IN(0),
 	SENSOR_ATTR_IN(1),
 	SENSOR_ATTR_IN(2),
@@ -1595,7 +1595,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_IN(20),
 };
 
-static struct sensor_device_attribute_2 w83795_fan[] = {
+static struct sensor_device_attribute_2 w83795_fan[][4] = {
 	SENSOR_ATTR_FAN(1),
 	SENSOR_ATTR_FAN(2),
 	SENSOR_ATTR_FAN(3),
@@ -1612,7 +1612,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_FAN(14),
 };
 
-static struct sensor_device_attribute_2 w83795_temp[] = {
+static struct sensor_device_attribute_2 w83795_temp[][29] = {
 	SENSOR_ATTR_TEMP(1),
 	SENSOR_ATTR_TEMP(2),
 	SENSOR_ATTR_TEMP(3),
@@ -1621,7 +1621,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_TEMP(6),
 };
 
-static struct sensor_device_attribute_2 w83795_dts[] = {
+static struct sensor_device_attribute_2 w83795_dts[][8] = {
 	SENSOR_ATTR_DTS(7),
 	SENSOR_ATTR_DTS(8),
 	SENSOR_ATTR_DTS(9),
@@ -1781,22 +1781,26 @@ static int w83795_handle_files(struct de
 			       const struct device_attribute *))
 {
 	struct w83795_data *data = dev_get_drvdata(dev);
-	int err, i;
+	int err, i, j;
 
 	for (i = 0; i < ARRAY_SIZE(w83795_in); i++) {
-		if (!(data->has_in & (1 << (i / 6))))
+		if (!(data->has_in & (1 << i)))
 			continue;
-		err = fn(dev, &w83795_in[i].dev_attr);
-		if (err)
-			return err;
+		for (j = 0; j < ARRAY_SIZE(w83795_in[0]); j++) {
+			err = fn(dev, &w83795_in[i][j].dev_attr);
+			if (err)
+				return err;
+		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++) {
-		if (!(data->has_fan & (1 << (i / 5))))
+		if (!(data->has_fan & (1 << i)))
 			continue;
-		err = fn(dev, &w83795_fan[i].dev_attr);
-		if (err)
-			return err;
+		for (j = 0; j < ARRAY_SIZE(w83795_fan[0]); j++) {
+			err = fn(dev, &w83795_fan[i][j].dev_attr);
+			if (err)
+				return err;
+		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
@@ -1814,20 +1818,24 @@ static int w83795_handle_files(struct de
 	}
 
 	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
-		if (!(data->has_temp & (1 << (i / 29))))
+		if (!(data->has_temp & (1 << i)))
 			continue;
-		err = fn(dev, &w83795_temp[i].dev_attr);
-		if (err)
-			return err;
+		for (j = 0; j < ARRAY_SIZE(w83795_temp[0]); j++) {
+			err = fn(dev, &w83795_temp[i][j].dev_attr);
+			if (err)
+				return err;
+		}
 	}
 
 	if (data->enable_dts != 0) {
 		for (i = 0; i < ARRAY_SIZE(w83795_dts); i++) {
-			if (!(data->has_dts & (1 << (i / 8))))
+			if (!(data->has_dts & (1 << i)))
 				continue;
-			err = fn(dev, &w83795_dts[i].dev_attr);
-			if (err)
-				return err;
+			for (j = 0; j < ARRAY_SIZE(w83795_dts[0]); j++) {
+				err = fn(dev, &w83795_dts[i][j].dev_attr);
+				if (err)
+					return err;
+			}
 		}
 	}
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
