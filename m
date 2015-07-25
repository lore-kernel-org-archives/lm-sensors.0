From: Constantine Shulyupin <const@MakeLinux.com>
Date: Sat, 25 Jul 2015 10:14:31 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add autopoint attributes
Message-Id: <1437819272-26611-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Constantine Shulyupin <const@MakeLinux.com>

Introduced REG_PWM, pwm[1..3]_auto_point[1..5]_temp,
pwm[1..3]_auto_point[1..5]_pwm, nct7802_auto_point_attrs,
nct7802_auto_point_group, updated nct7802_regmap_is_volatile

---

Changed in v3:
- removed nct7802_auto_point_is_visible
- removed usage of sysfs_update_group
- introduced REG_PWM
- removed S_IWUSR from RO attributes
- added PWM registers to nct7802_regmap_is_volatile
Changed in v2:
- removed PWM_REG, TEMP_REG
- removed auto_point[1..4]_temp, auto_point[1..4]_pwm
  and auto_point_crit_temp
- introduced pwm[1..3]_auto_point[1..5]_temp
  and pwm[1..3]_auto_point[1..5]_pwm.
- introduced nct7802_auto_point_is_visible
- used sysfs_update_group in store_pwm_enable

Notes:
I think that better to leave function nct7802_auto_point_is_visible.
Autopoints attributes have default values and enabling autopoint doesn't
confuse the chip. The chip accepts changing autopoint (SmartFan)
registers after enabling autopoint mode.

I'll think about validating auto point settings latter.
The next fix I would like is to add OF support, which is more important.

BTW, Guenter, have you TODO list for the driver?

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index f4908bb..c8a6eda 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -53,6 +53,7 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
 #define REG_PECI_ENABLE		0x23
 #define REG_FAN_ENABLE		0x24
 #define REG_VMON_ENABLE		0x25
+#define REG_PWM(x)		(0x60 + (x))
 #define REG_SMARTFAN_EN(x)      (0x64 + (x) / 2)
 #define SMARTFAN_EN_SHIFT(x)    ((x) % 2 * 4)
 #define REG_VENDOR_ID		0xfd
@@ -130,6 +131,9 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
 	unsigned int val;
 	int ret;
 
+	if (!attr->index)
+		return sprintf(buf, "255\n");
+
 	ret = regmap_read(data->regmap, attr->index, &val);
 	if (ret < 0)
 		return ret;
@@ -826,9 +830,12 @@ static SENSOR_DEVICE_ATTR(pwm2_mode, S_IRUGO, show_pwm_mode, NULL, 1);
 static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
 
 /* 7.2.91... Fan Control Output Value */
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x60);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x61);
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x62);
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
+			  REG_PWM(0));
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
+			  REG_PWM(1));
+static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
+			  REG_PWM(2));
 
 /* 7.2.95... Temperature to Fan mapping Relationships Register */
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
@@ -893,11 +900,125 @@ static struct attribute_group nct7802_pwm_group = {
 	.attrs = nct7802_pwm_attrs,
 };
 
+/* 7.2.115... 0x80-0x83, 0x84 Temperature (X-axis) transition */
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x80, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x81, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x82, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point4_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x83, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point5_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x84, 0);
+
+/* 7.2.120... 0x85-0x88 PWM (Y-axis) transition */
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x85);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x86);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x87);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x88);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+
+/* 7.2.124 Table 2 X-axis Transition Point 1 Register */
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x90, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x91, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x92, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point4_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x93, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point5_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0x94, 0);
+
+/* 7.2.129 Table 2 Y-axis Transition Point 1 Register */
+static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x95);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x96);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point3_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x97);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point4_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0x98);
+static SENSOR_DEVICE_ATTR(pwm2_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+
+/* 7.2.133 Table 3 X-axis Transition Point 1 Register */
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0xA0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0xA1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0xA2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point4_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0xA3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point5_temp, S_IRUGO | S_IWUSR,
+			    show_temp, store_temp, 0xA4, 0);
+
+/* 7.2.138 Table 3 Y-axis Transition Point 1 Register */
+static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0xA5);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0xA6);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point3_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0xA7);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point4_pwm, S_IRUGO | S_IWUSR,
+			  show_pwm, store_pwm, 0xA8);
+static SENSOR_DEVICE_ATTR(pwm3_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+
+static struct attribute *nct7802_auto_point_attrs[] = {
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
+
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
+
+	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point5_temp.dev_attr.attr,
+
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point5_pwm.dev_attr.attr,
+
+	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point5_temp.dev_attr.attr,
+
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point5_pwm.dev_attr.attr,
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
 
@@ -945,7 +1066,8 @@ static int nct7802_detect(struct i2c_client *client,
 
 static bool nct7802_regmap_is_volatile(struct device *dev, unsigned int reg)
 {
-	return reg != REG_BANK && reg <= 0x20;
+	return reg != REG_BANK && reg <= 0x20
+		|| reg >= REG_PWM(0) && reg <= REG_PWM(3);
 }
 
 static const struct regmap_config nct7802_regmap_config = {
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
