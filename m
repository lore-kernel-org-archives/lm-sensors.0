From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jan 2012 17:36:13 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83795) Unconditionally support manual fan speed control
Message-Id: <20120122183613.4ba050f6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Manual fan speed control uses a standard interface and has received
sufficient testing and review by now, it can be enabled
unconditionally. This includes attributes pwm[1-8], pwm[1-8]_enable,
pwm[1-8]_mode and pwm[1-8]_freq.

We only let the user switch from automatic mode to manual mode, but
not the other way around, as automatic control settings may not have
been set properly by the BIOS.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/Kconfig  |    9 +++++----
 drivers/hwmon/w83795.c |   26 ++++++++++++++++++--------
 2 files changed, 23 insertions(+), 12 deletions(-)

--- linux-3.2.orig/drivers/hwmon/w83795.c	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.2/drivers/hwmon/w83795.c	2012-01-22 14:50:25.309726525 +0100
@@ -929,6 +929,14 @@ store_pwm_enable(struct device *dev, str
 	if (val < 1 || val > 2)
 		return -EINVAL;
 
+#ifndef CONFIG_SENSORS_W83795_FANCTRL
+	if (val > 1) {
+		dev_warn(dev, "Automatic fan speed control support disabled\n");
+		dev_warn(dev, "Build with CONFIG_SENSORS_W83795_FANCTRL=y if you want it\n");
+		return -EOPNOTSUPP;
+	}
+#endif
+
 	mutex_lock(&data->update_lock);
 	switch (val) {
 	case 1:
@@ -1625,18 +1633,18 @@ store_sf_setup(struct device *dev, struc
 #define SENSOR_ATTR_PWM(index) {					\
 	SENSOR_ATTR_2(pwm##index, S_IWUSR | S_IRUGO, show_pwm,		\
 		store_pwm, PWM_OUTPUT, index - 1),			\
+	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
+		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
+	SENSOR_ATTR_2(pwm##index##_mode, S_IRUGO,			\
+		show_pwm_mode, NULL, NOT_USED, index - 1),		\
+	SENSOR_ATTR_2(pwm##index##_freq, S_IWUSR | S_IRUGO,		\
+		show_pwm, store_pwm, PWM_FREQ, index - 1),		\
 	SENSOR_ATTR_2(pwm##index##_nonstop, S_IWUSR | S_IRUGO,		\
 		show_pwm, store_pwm, PWM_NONSTOP, index - 1),		\
 	SENSOR_ATTR_2(pwm##index##_start, S_IWUSR | S_IRUGO,		\
 		show_pwm, store_pwm, PWM_START, index - 1),		\
 	SENSOR_ATTR_2(pwm##index##_stop_time, S_IWUSR | S_IRUGO,	\
 		show_pwm, store_pwm, PWM_STOP_TIME, index - 1),	 \
-	SENSOR_ATTR_2(pwm##index##_freq, S_IWUSR | S_IRUGO,	\
-		show_pwm, store_pwm, PWM_FREQ, index - 1),	 \
-	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
-		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
-	SENSOR_ATTR_2(pwm##index##_mode, S_IRUGO,			\
-		show_pwm_mode, NULL, NOT_USED, index - 1),		\
 	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
 		show_fanin, store_fanin, FANIN_TARGET, index - 1) }
 
@@ -2006,15 +2014,17 @@ static int w83795_handle_files(struct de
 		}
 	}
 
-#ifdef CONFIG_SENSORS_W83795_FANCTRL
 	for (i = 0; i < data->has_pwm; i++) {
+#ifdef CONFIG_SENSORS_W83795_FANCTRL
 		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
+#else
+		for (j = 0; j < 4; j++) {
+#endif
 			err = fn(dev, &w83795_pwm[i][j].dev_attr);
 			if (err)
 				return err;
 		}
 	}
-#endif
 
 	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
 		if (!(data->has_temp & (1 << i)))
--- linux-3.2.orig/drivers/hwmon/Kconfig	2012-01-06 11:21:10.000000000 +0100
+++ linux-3.2/drivers/hwmon/Kconfig	2012-01-21 17:37:49.102223035 +0100
@@ -1226,18 +1226,19 @@ config SENSORS_W83795
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the Winbond W83795G and
-	  W83795ADG hardware monitoring chip.
+	  W83795ADG hardware monitoring chip, including manual fan speed
+	  control.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83795.
 
 config SENSORS_W83795_FANCTRL
-	boolean "Include fan control support (DANGEROUS)"
+	boolean "Include automatic fan control support (DANGEROUS)"
 	depends on SENSORS_W83795 && EXPERIMENTAL
 	default n
 	help
-	  If you say yes here, support for the both manual and automatic
-	  fan control features will be included in the driver.
+	  If you say yes here, support for automatic fan speed control
+	  will be included in the driver.
 
 	  This part of the code wasn't carefully reviewed and tested yet,
 	  so enabling this option is strongly discouraged on production


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
