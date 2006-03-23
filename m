From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:50 +0000
Subject: [lm-sensors] [PATCH 15/36] hwmon: w83792d drop useless macros
Message-Id: <11431538303983-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop 3 useless macros in the w83792d hardware monitoring driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/hwmon/w83792d.c |   24 +++---------------------
 1 files changed, 3 insertions(+), 21 deletions(-)

93766d2de6a3f7eead3fda57fd4638b90d6691fa
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index c5b57c7..2e86e18 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -618,10 +618,6 @@ show_alarms_reg(struct device *dev, stru
 
 static
 DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
-#define device_create_file_alarms() \
-device_create_file(dev, &dev_attr_alarms);
-
-
 
 static ssize_t
 show_pwm(struct device *dev, struct device_attribute *attr,
@@ -775,12 +771,6 @@ show_regs_chassis(struct device *dev, st
 
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
@@ -811,13 +801,6 @@ store_chassis_clear(struct device *dev, 
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
@@ -1294,16 +1277,15 @@ w83792d_detect(struct i2c_adapter *adapt
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
1.2.4



