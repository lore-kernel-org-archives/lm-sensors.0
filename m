From: Constantine Shulyupin <const@MakeLinux.com>
Date: Wed, 08 Jul 2015 22:49:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7802) Add autopoint attributes
Message-Id: <1436395749-4101-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Constantine Shulyupin <const@MakeLinux.com>

Introduced PWM_REG, TEMP_REG, auto_pointX_temp, auto_pointX_pwm,
nct7802_auto_point_attrs, nct7802_auto_point_group.

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 2f6bbe5..a3f3063 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -153,6 +153,10 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
 	return err ? : count;
 }
 
+#define PWM_REG(_name, _reg) \
+	SENSOR_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR, \
+				  show_pwm, store_pwm, _reg)
+
 static ssize_t show_pwm_enable(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -404,6 +408,10 @@ static ssize_t store_temp(struct device *dev, struct device_attribute *attr,
 	return err ? : count;
 }
 
+#define TEMP_REG(_name, _high, _low) \
+	SENSOR_DEVICE_ATTR_2(_name, S_IRUGO | S_IWUSR, \
+				    show_temp, store_temp, _high, _low)
+
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -890,11 +898,44 @@ static struct attribute_group nct7802_pwm_group = {
 	.attrs = nct7802_pwm_attrs,
 };
 
+/* 7.2.115... 0x80-0x83, 0x84 Temperature (X-axis) transition */
+static TEMP_REG(auto_point1_temp, 0x80, 0);
+static TEMP_REG(auto_point2_temp, 0x81, 0);
+static TEMP_REG(auto_point3_temp, 0x82, 0);
+static TEMP_REG(auto_point4_temp, 0x83, 0);
+static TEMP_REG(auto_point_crit_temp, 0x84, 0);
+
+/* 7.2.120... 0x85-0x88 PWM (Y-axis) transition */
+static PWM_REG(auto_point1_pwm, 0x85);
+static PWM_REG(auto_point2_pwm, 0x86);
+static PWM_REG(auto_point3_pwm, 0x87);
+static PWM_REG(auto_point4_pwm, 0x88);
+
+static struct attribute *nct7802_auto_point_attrs[] = {
+	&sensor_dev_attr_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_auto_point_crit_temp.dev_attr.attr,
+
+	&sensor_dev_attr_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_auto_point4_pwm.dev_attr.attr,
+
+	NULL
+};
+
+static struct attribute_group nct7802_auto_point_group = {
+	.attrs = nct7802_auto_point_attrs,
+};
+
 static const struct attribute_group *nct7802_groups[] = {
 	&nct7802_temp_group,
 	&nct7802_in_group,
 	&nct7802_fan_group,
 	&nct7802_pwm_group,
+	&nct7802_auto_point_group,
 	NULL
 };
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
