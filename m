From: Constantine Shulyupin <const@MakeLinux.com>
Date: Tue, 07 Jul 2015 21:40:10 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (nct7802) Add pwmX_enable attribute
Message-Id: <1436305210-679-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Constantine Shulyupin <const@MakeLinux.com>

Introduced REG_SMARTFAN_EN, SMARTFAN_EN_SHIFT, pwmX_enable,
show_pwm_enable, store_pwm_enable.

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

---
Change log:
Fixed in v2:
- Introduced REG_SMARTFAN_EN, SMARTFAN_EN_SHIFT

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index a0d9010..2f6bbe5 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -53,6 +53,8 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
 #define REG_PECI_ENABLE		0x23
 #define REG_FAN_ENABLE		0x24
 #define REG_VMON_ENABLE		0x25
+#define REG_SMARTFAN_EN(x)      (0x64 + (x) / 2)
+#define SMARTFAN_EN_SHIFT(x)    ((x) % 2 * 4)
 #define REG_VENDOR_ID		0xfd
 #define REG_CHIP_ID		0xfe
 #define REG_VERSION_ID		0xff
@@ -151,6 +153,41 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
 	return err ? : count;
 }
 
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct nct7802_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	unsigned int reg, enabled;
+	int ret;
+
+	ret = regmap_read(data->regmap, REG_SMARTFAN_EN(sattr->index), &reg);
+	if (ret < 0)
+		return ret;
+	enabled = reg >> SMARTFAN_EN_SHIFT(sattr->index) & 1;
+	return sprintf(buf, "%u\n", enabled + 1);
+}
+
+static ssize_t store_pwm_enable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct nct7802_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val < 1 || val > 2)
+		return -EINVAL;
+	ret = regmap_update_bits(data->regmap, REG_SMARTFAN_EN(sattr->index),
+				 1 << SMARTFAN_EN_SHIFT(sattr->index),
+				 (val - 1) << SMARTFAN_EN_SHIFT(sattr->index));
+	return ret ? : count;
+}
+
 static int nct7802_read_temp(struct nct7802_data *data,
 			     u8 reg_temp, u8 reg_temp_low, int *temp)
 {
@@ -793,6 +830,11 @@ static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x60);
 static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x61);
 static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x62);
 
+/* 7.2.95... Temperature to Fan mapping Relationships Register */
+static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable, store_pwm_enable, 0);
+static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR, show_pwm_enable, store_pwm_enable, 1);
+static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR, show_pwm_enable, store_pwm_enable, 2);
+
 static struct attribute *nct7802_fan_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -832,10 +874,13 @@ static struct attribute_group nct7802_fan_group = {
 };
 
 static struct attribute *nct7802_pwm_attrs[] = {
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm2_mode.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm3_mode.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	NULL
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
