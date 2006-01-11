From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 11 Jan 2006 20:19:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: w83792d use sensor-attr arrays
Message-Id: <20060111211900.69139db6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECECCE220@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECECCE220@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> This patch uses the new sensor-attr arrays, please check.

Alright! I've applied it.

Additionally, I would like to apply the following patch on top of it.
It simplifies the creation of the alarm and chassis files. Are you OK
with it?

Thanks.

Content-Disposition: inline; filename=hwmon-w83792d-drop-useless-macros.patch

Drop 3 useless macros in the w83792d hardware monitoring driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83792d.c |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

--- linux-2.6.15-git.orig/drivers/hwmon/w83792d.c	2006-01-11 20:38:49.000000000 +0100
+++ linux-2.6.15-git/drivers/hwmon/w83792d.c	2006-01-11 21:12:40.000000000 +0100
@@ -618,10 +618,6 @@
 
 static
 DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
-#define device_create_file_alarms() \
-device_create_file(dev, &dev_attr_alarms);
-
-
 
 static ssize_t
 show_pwm(struct device *dev, struct device_attribute *attr,
@@ -775,12 +771,6 @@
 
 static DEVICE_ATTR(chassis, S_IRUGO, show_regs_chassis, NULL);
 
-#define device_create_file_chassis() \
-do { \
-device_create_file(dev, &dev_attr_chassis); \
-} while (0)
-
-
 static ssize_t
 show_chassis_clear(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -811,13 +801,6 @@
 static DEVICE_ATTR(chassis_clear, S_IRUGO | S_IWUSR,
 		show_chassis_clear, store_chassis_clear);
 
-#define device_create_file_chassis_clear() \
-do { \
-device_create_file(dev, &dev_attr_chassis_clear); \
-} while (0)
-
-
-
 /* For Smart Fan I / Thermal Cruise */
 static ssize_t
 show_thermal_cruise(struct device *dev, struct device_attribute *attr,
@@ -1294,16 +1277,15 @@
 		device_create_file(dev, &sda_tolerance[i].dev_attr);
 	}
 
-	device_create_file_alarms();
-
 	for (i = 0; i < ARRAY_SIZE(sda_pwm); i++) {
 		device_create_file(dev, &sda_pwm[i].dev_attr);
 		device_create_file(dev, &sda_pwm_enable[i].dev_attr);
 		device_create_file(dev, &sda_pwm_mode[i].dev_attr);
 	}
 
-	device_create_file_chassis();
-	device_create_file_chassis_clear();
+	device_create_file(dev, &dev_attr_alarms);
+	device_create_file(dev, &dev_attr_chassis);
+	device_create_file(dev, &dev_attr_chassis_clear);
 
 	for (i = 0; i < ARRAY_SIZE(sda_sf2_point); i++)
 		device_create_file(dev, &sda_sf2_point[i].dev_attr);


-- 
Jean Delvare

