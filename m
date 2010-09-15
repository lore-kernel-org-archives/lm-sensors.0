From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:57:57 +0000
Subject: [lm-sensors] [patch 19/36] hwmon: (w83795) Rename temperature limit
Message-Id: <20100915155757.03749f52@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Follow the standard for temperature limit attribute naming, so that
libsensors will pick the values.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:13:46.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:13:50.000000000 +0200
@@ -1541,13 +1541,13 @@ store_sf_setup(struct device *dev, struc
 		show_dts_mode, NULL, NOT_USED, index - 7),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_dts,		\
 		NULL, NOT_USED, index - 7),				\
-	SENSOR_ATTR_2(temp##index##_max, S_IRUGO | S_IWUSR, show_dts_ext, \
+	SENSOR_ATTR_2(temp##index##_crit, S_IRUGO | S_IWUSR, show_dts_ext, \
 		store_dts_ext, DTS_CRIT, NOT_USED),			\
-	SENSOR_ATTR_2(temp##index##_max_hyst, S_IRUGO | S_IWUSR,	\
+	SENSOR_ATTR_2(temp##index##_crit_hyst, S_IRUGO | S_IWUSR,	\
 		show_dts_ext, store_dts_ext, DTS_CRIT_HYST, NOT_USED),	\
-	SENSOR_ATTR_2(temp##index##_warn, S_IRUGO | S_IWUSR, show_dts_ext, \
+	SENSOR_ATTR_2(temp##index##_max, S_IRUGO | S_IWUSR, show_dts_ext, \
 		store_dts_ext, DTS_WARN, NOT_USED),			\
-	SENSOR_ATTR_2(temp##index##_warn_hyst, S_IRUGO | S_IWUSR,	\
+	SENSOR_ATTR_2(temp##index##_max_hyst, S_IRUGO | S_IWUSR,	\
 		show_dts_ext, store_dts_ext, DTS_WARN_HYST, NOT_USED),	\
 	SENSOR_ATTR_2(temp##index##_alarm, S_IRUGO,			\
 		show_alarm_beep, NULL, ALARM_STATUS, index + 17),	\
@@ -1559,13 +1559,13 @@ store_sf_setup(struct device *dev, struc
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
 		NULL, TEMP_READ, index - 1),				\
-	SENSOR_ATTR_2(temp##index##_max, S_IRUGO | S_IWUSR, show_temp,	\
+	SENSOR_ATTR_2(temp##index##_crit, S_IRUGO | S_IWUSR, show_temp,	\
 		store_temp, TEMP_CRIT, index - 1),			\
-	SENSOR_ATTR_2(temp##index##_max_hyst, S_IRUGO | S_IWUSR,	\
+	SENSOR_ATTR_2(temp##index##_crit_hyst, S_IRUGO | S_IWUSR,	\
 		show_temp, store_temp, TEMP_CRIT_HYST, index - 1),	\
-	SENSOR_ATTR_2(temp##index##_warn, S_IRUGO | S_IWUSR, show_temp,	\
+	SENSOR_ATTR_2(temp##index##_max, S_IRUGO | S_IWUSR, show_temp,	\
 		store_temp, TEMP_WARN, index - 1),			\
-	SENSOR_ATTR_2(temp##index##_warn_hyst, S_IRUGO | S_IWUSR,	\
+	SENSOR_ATTR_2(temp##index##_max_hyst, S_IRUGO | S_IWUSR,	\
 		show_temp, store_temp, TEMP_WARN_HYST, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_alarm, S_IRUGO,			\
 		show_alarm_beep, NULL, ALARM_STATUS,			\
@@ -1583,9 +1583,9 @@ store_sf_setup(struct device *dev, struc
 		TEMP_PWM_FAN_MAP, index - 1),				\
 	SENSOR_ATTR_2(thermal_cruise##index, S_IWUSR | S_IRUGO,		\
 		show_temp_pwm, store_temp_pwm, TEMP_PWM_TTTI, index - 1), \
-	SENSOR_ATTR_2(temp##index##_crit, S_IWUSR | S_IRUGO,		\
+	SENSOR_ATTR_2(temp##index##_warn, S_IWUSR | S_IRUGO,		\
 		show_temp_pwm, store_temp_pwm, TEMP_PWM_CTFS, index - 1), \
-	SENSOR_ATTR_2(temp##index##_crit_hyst, S_IWUSR | S_IRUGO,	\
+	SENSOR_ATTR_2(temp##index##_warn_hyst, S_IWUSR | S_IRUGO,	\
 		show_temp_pwm, store_temp_pwm, TEMP_PWM_HCT, index - 1), \
 	SENSOR_ATTR_2(temp##index##_operation_hyst, S_IWUSR | S_IRUGO,	\
 		show_temp_pwm, store_temp_pwm, TEMP_PWM_HOT, index - 1), \


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
