From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Oct 2010 15:52:39 +0000
Subject: [lm-sensors] hwmon: (w83795) Exclude fan control feature by default
Message-Id: <20101028175239.574d5a35@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The fan control feature of the w83795 driver is insufficiently
reviewed and tested for public consumption at this time, so make it
optional and disabled by default. We will change the default when
review and testing is deemed sufficient. Ultimately the option will
go away.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
With this, the only non-standard attribute showing by default is "chassis". I'll
fix it now and send a patch immediately.

 drivers/hwmon/Kconfig  |   17 +++++++++++++++++
 drivers/hwmon/w83795.c |   10 ++++++++++
 2 files changed, 27 insertions(+)

--- linux-2.6.37-rc0.orig/drivers/hwmon/Kconfig	2010-10-28 16:26:10.000000000 +0200
+++ linux-2.6.37-rc0/drivers/hwmon/Kconfig	2010-10-28 17:24:25.000000000 +0200
@@ -1041,6 +1041,23 @@ config SENSORS_W83795
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83795.
 
+config SENSORS_W83795_FANCTRL
+	boolean "Include fan control support (DANGEROUS)"
+	depends on SENSORS_W83795 && EXPERIMENTAL
+	default n
+	help
+	  If you say yes here, support for the both manual and automatic
+	  fan control features will be included in the driver.
+
+	  This part of the code wasn't carefully reviewed and tested yet,
+	  so enabling this option is strongly discouraged on production
+	  servers. Only developers and testers should enable it for the
+	  time being.
+
+	  Please also note that this option will create sysfs attribute
+	  files which may change in the future, so you shouldn't rely
+	  on them being stable.
+
 config SENSORS_W83L785TS
 	tristate "Winbond W83L785TS-S"
 	depends on I2C && EXPERIMENTAL
--- linux-2.6.37-rc0.orig/drivers/hwmon/w83795.c	2010-10-28 16:41:32.000000000 +0200
+++ linux-2.6.37-rc0/drivers/hwmon/w83795.c	2010-10-28 17:39:12.000000000 +0200
@@ -1455,6 +1455,7 @@ store_in(struct device *dev, struct devi
 }
 
 
+#ifdef CONFIG_SENSORS_W83795_FANCTRL
 static ssize_t
 show_sf_setup(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -1506,6 +1507,7 @@ store_sf_setup(struct device *dev, struc
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+#endif
 
 
 #define NOT_USED			-1
@@ -1711,6 +1713,7 @@ static const struct sensor_device_attrib
 		      store_chassis_clear, ALARM_STATUS, 46),
 	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_beep, BEEP_ENABLE, 47),
+#ifdef CONFIG_SENSORS_W83795_FANCTRL
 	SENSOR_ATTR_2(speed_cruise_tolerance, S_IWUSR | S_IRUGO, show_fanin,
 		store_fanin, FANIN_TOL, NOT_USED),
 	SENSOR_ATTR_2(pwm_default, S_IWUSR | S_IRUGO, show_sf_setup,
@@ -1719,6 +1722,7 @@ static const struct sensor_device_attrib
 		      store_sf_setup, SETUP_PWM_UPTIME, NOT_USED),
 	SENSOR_ATTR_2(pwm_downtime, S_IWUSR | S_IRUGO, show_sf_setup,
 		      store_sf_setup, SETUP_PWM_DOWNTIME, NOT_USED),
+#endif
 };
 
 /*
@@ -1872,6 +1876,7 @@ static int w83795_handle_files(struct de
 			return err;
 	}
 
+#ifdef CONFIG_SENSORS_W83795_FANCTRL
 	for (i = 0; i < data->has_pwm; i++) {
 		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
 			err = fn(dev, &w83795_pwm[i][j].dev_attr);
@@ -1879,11 +1884,16 @@ static int w83795_handle_files(struct de
 				return err;
 		}
 	}
+#endif
 
 	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
 		if (!(data->has_temp & (1 << i)))
 			continue;
+#ifdef CONFIG_SENSORS_W83795_FANCTRL
 		for (j = 0; j < ARRAY_SIZE(w83795_temp[0]); j++) {
+#else
+		for (j = 0; j < 8; j++) {
+#endif
 			err = fn(dev, &w83795_temp[i][j].dev_attr);
 			if (err)
 				return err;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
