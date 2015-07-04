From: Constantine Shulyupin <const@MakeLinux.com>
Date: Sat, 04 Jul 2015 14:57:34 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add pwm control
Message-Id: <1436021854-13072-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Constantine Shulyupin <const@MakeLinux.com>

Added fan output control registers.
Modes of operation are PWM (default) and DC.

Introduced show_pwm, store_pwm, nct7802_pwm_attrs, nct7802_pwm_group.

---
Change log:
Fixed in v2:
- renamed fanX_output to pwmX
- introduced nct7802_pwm_group and nct7802_pwm_attrs
- renamed show_dec to show_pwd
- used kstrtou8 instead kstrtouint
Fixed in v3:
- spilt functions declarations to fit 80 columns
- removed unnecessary initializations
- rearranged variable declarations
- shortened return expression
- renamed store_u8 to store_pwm

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index afa242d..6382d4d 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -102,6 +102,36 @@ static ssize_t store_temp_type(struct device *dev,
 	return err ? : count;
 }
 
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct nct7802_data *data = dev_get_drvdata(dev);
+	unsigned int;
+	int ret;
+
+	ret = regmap_read(data->regmap, attr->index, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct nct7802_data *data = dev_get_drvdata(dev);
+	int err;
+	u8 val;
+
+	err = kstrtou8(buf, 0, &val);
+	if (err < 0)
+		return err;
+
+	err = regmap_write(data->regmap, attr->index, val);
+	return err ? : count;
+}
 
 static int nct7802_read_temp(struct nct7802_data *data,
 			     u8 reg_temp, u8 reg_temp_low, int *temp)
@@ -735,6 +765,11 @@ static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 2);
 static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
 			    0x5b, 2);
 
+/* 7.2.91... Fan Control Output Value */
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x60);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x61);
+static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0x62);
+
 static struct attribute *nct7802_fan_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -773,10 +808,22 @@ static struct attribute_group nct7802_fan_group = {
 	.is_visible = nct7802_fan_is_visible,
 };
 
+static struct attribute *nct7802_pwm_attrs[] = {
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group nct7802_pwm_group = {
+	.attrs = nct7802_pwm_attrs,
+};
+
 static const struct attribute_group *nct7802_groups[] = {
 	&nct7802_temp_group,
 	&nct7802_in_group,
 	&nct7802_fan_group,
+	&nct7802_pwm_group,
 	NULL
 };
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
