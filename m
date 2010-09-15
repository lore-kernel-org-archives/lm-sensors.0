From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:56:19 +0000
Subject: [lm-sensors] [patch 10/36] hwmon: (w83795) Move PWM attributes to a
Message-Id: <20100915155619.16fb3870@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use a dedicated 2D array for PWM attributes. This way, PWM attributes
are handled the same way as other attributes, this is more consistent.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:50.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:18.000000000 +0200
@@ -1470,7 +1470,7 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(fan##index##_beep, S_IWUSR | S_IRUGO,		\
 		show_alarm_beep, store_beep, BEEP_ENABLE, index + 31) }
 
-#define SENSOR_ATTR_PWM(index)						\
+#define SENSOR_ATTR_PWM(index) {					\
 	SENSOR_ATTR_2(pwm##index, S_IWUSR | S_IRUGO, show_pwm,		\
 		store_pwm, PWM_OUTPUT, index - 1),			\
 	SENSOR_ATTR_2(pwm##index##_nonstop, S_IWUSR | S_IRUGO,		\
@@ -1482,7 +1482,7 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(fan##index##_div, S_IWUSR | S_IRUGO,	\
 		show_pwm, store_pwm, PWM_DIV, index - 1),	 \
 	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
-		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1)
+		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1) }
 
 #define SENSOR_ATTR_FANIN_TARGET(index)					\
 	SENSOR_ATTR_2(speed_cruise##index##_target, S_IWUSR | S_IRUGO, \
@@ -1641,13 +1641,11 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_FANIN_TARGET(6),
 	SENSOR_ATTR_FANIN_TARGET(7),
 	SENSOR_ATTR_FANIN_TARGET(8),
-	SENSOR_ATTR_PWM(1),
-	SENSOR_ATTR_PWM(2),
 };
 
-/* all registers existed in 795g than 795adg,
- * like PWM3 - PWM8 */
-static struct sensor_device_attribute_2 w83795_left_reg[] = {
+static struct sensor_device_attribute_2 w83795_pwm[][6] = {
+	SENSOR_ATTR_PWM(1),
+	SENSOR_ATTR_PWM(2),
 	SENSOR_ATTR_PWM(3),
 	SENSOR_ATTR_PWM(4),
 	SENSOR_ATTR_PWM(5),
@@ -1809,9 +1807,9 @@ static int w83795_handle_files(struct de
 			return err;
 	}
 
-	if (data->chip_type = w83795g) {
-		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++) {
-			err = fn(dev, &w83795_left_reg[i].dev_attr);
+	for (i = 0; i < data->has_pwm; i++) {
+		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
+			err = fn(dev, &w83795_pwm[i][j].dev_attr);
 			if (err)
 				return err;
 		}


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
