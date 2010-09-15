From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:56:29 +0000
Subject: [lm-sensors] [patch 11/36] hwmon: (w83795) Only create
Message-Id: <20100915155629.64e7a3bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only create fan[1-8]_target files when the fan in question can be
controlled (PWM output is present.) Also name these files according
to the standard.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:18.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:22.000000000 +0200
@@ -1482,11 +1482,9 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(fan##index##_div, S_IWUSR | S_IRUGO,	\
 		show_pwm, store_pwm, PWM_DIV, index - 1),	 \
 	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
-		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1) }
-
-#define SENSOR_ATTR_FANIN_TARGET(index)					\
-	SENSOR_ATTR_2(speed_cruise##index##_target, S_IWUSR | S_IRUGO, \
-		show_fanin, store_fanin, FANIN_TARGET, index - 1)
+		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
+	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
+		show_fanin, store_fanin, FANIN_TARGET, index - 1) }
 
 #define SENSOR_ATTR_DTS(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO ,		\
@@ -1632,18 +1630,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_DTS(14),
 };
 
-static struct sensor_device_attribute_2 w83795_static[] = {
-	SENSOR_ATTR_FANIN_TARGET(1),
-	SENSOR_ATTR_FANIN_TARGET(2),
-	SENSOR_ATTR_FANIN_TARGET(3),
-	SENSOR_ATTR_FANIN_TARGET(4),
-	SENSOR_ATTR_FANIN_TARGET(5),
-	SENSOR_ATTR_FANIN_TARGET(6),
-	SENSOR_ATTR_FANIN_TARGET(7),
-	SENSOR_ATTR_FANIN_TARGET(8),
-};
-
-static struct sensor_device_attribute_2 w83795_pwm[][6] = {
+static struct sensor_device_attribute_2 w83795_pwm[][7] = {
 	SENSOR_ATTR_PWM(1),
 	SENSOR_ATTR_PWM(2),
 	SENSOR_ATTR_PWM(3),
@@ -1837,12 +1824,6 @@ static int w83795_handle_files(struct de
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(w83795_static); i++) {
-		err = fn(dev, &w83795_static[i].dev_attr);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
