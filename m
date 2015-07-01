From: Constantine Shulyupin <const@MakeLinux.com>
Date: Wed, 01 Jul 2015 06:52:23 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (nct7802) add temperature sensor type attribute
Message-Id: <1435733543-21290-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: const <const@MakeLinux.com>

From: const <const@MakeLinux.com>

Sensor type:
3 diode (current mode), MD=1
4 thermistor, MD=2

Reference:
Nuvoton Hardware Monitoring IC NCT7802Y
7.2.32 Mode Selection Register
Location : Index 22h

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 72 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 1341e1f..afa242d 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -49,7 +49,7 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
 #define REG_VOLTAGE_LOW		0x0f
 #define REG_FANCOUNT_LOW	0x13
 #define REG_START		0x21
-#define REG_MODE		0x22
+#define REG_MODE		0x22 /* 7.2.32 Mode Selection Register */
 #define REG_PECI_ENABLE		0x23
 #define REG_FAN_ENABLE		0x24
 #define REG_VMON_ENABLE		0x25
@@ -66,6 +66,43 @@ struct nct7802_data {
 	struct mutex access_lock; /* for multi-byte read and write operations */
 };
 
+static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct nct7802_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	unsigned int mode;
+	int ret;
+
+	ret = regmap_read(data->regmap, REG_MODE, &mode);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%u\n", (mode >> (2 * sattr->index) & 3) + 2);
+}
+
+static ssize_t store_temp_type(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct nct7802_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	unsigned int type;
+	int err;
+
+	err = kstrtouint(buf, 0, &type);
+	if (err < 0)
+		return err;
+	if (sattr->index = 2 && type != 4) /* RD3 */
+		return -EINVAL;
+	if (type < 3 || type > 4)
+		return -EINVAL;
+	err = regmap_update_bits(data->regmap, REG_MODE,
+			3 << 2 * sattr->index, (type - 2) << 2 * sattr->index);
+	return err ? : count;
+}
+
+
 static int nct7802_read_temp(struct nct7802_data *data,
 			     u8 reg_temp, u8 reg_temp_low, int *temp)
 {
@@ -377,6 +414,8 @@ store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
 	return err ? : count;
 }
 
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
+			  show_temp_type, store_temp_type, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0x01,
 			    REG_TEMP_LSB);
 static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp,
@@ -386,6 +425,8 @@ static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp,
 static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp,
 			    store_temp, 0x3a, 0);
 
+static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
+			  show_temp_type, store_temp_type, 1);
 static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0x02,
 			    REG_TEMP_LSB);
 static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp,
@@ -395,6 +436,8 @@ static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp,
 static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp,
 			    store_temp, 0x3b, 0);
 
+static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
+			  show_temp_type, store_temp_type, 2);
 static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0x03,
 			    REG_TEMP_LSB);
 static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp,
@@ -475,6 +518,7 @@ static SENSOR_DEVICE_ATTR_2(temp6_beep, S_IRUGO | S_IWUSR, show_beep,
 			    store_beep, 0x5c, 5);
 
 static struct attribute *nct7802_temp_attrs[] = {
+	&sensor_dev_attr_temp1_type.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
@@ -485,7 +529,8 @@ static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp1_fault.dev_attr.attr,
 	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 
-	&sensor_dev_attr_temp2_input.dev_attr.attr,		/* 9 */
+	&sensor_dev_attr_temp2_type.dev_attr.attr,		/* 10 */
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
@@ -495,7 +540,8 @@ static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp2_beep.dev_attr.attr,
 
-	&sensor_dev_attr_temp3_input.dev_attr.attr,		/* 18 */
+	&sensor_dev_attr_temp3_type.dev_attr.attr,		/* 20 */
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
@@ -505,7 +551,7 @@ static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 	&sensor_dev_attr_temp3_beep.dev_attr.attr,
 
-	&sensor_dev_attr_temp4_input.dev_attr.attr,		/* 27 */
+	&sensor_dev_attr_temp4_input.dev_attr.attr,		/* 30 */
 	&sensor_dev_attr_temp4_min.dev_attr.attr,
 	&sensor_dev_attr_temp4_max.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit.dev_attr.attr,
@@ -514,7 +560,7 @@ static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_beep.dev_attr.attr,
 
-	&sensor_dev_attr_temp5_input.dev_attr.attr,		/* 35 */
+	&sensor_dev_attr_temp5_input.dev_attr.attr,		/* 38 */
 	&sensor_dev_attr_temp5_min.dev_attr.attr,
 	&sensor_dev_attr_temp5_max.dev_attr.attr,
 	&sensor_dev_attr_temp5_crit.dev_attr.attr,
@@ -523,7 +569,7 @@ static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp5_beep.dev_attr.attr,
 
-	&sensor_dev_attr_temp6_input.dev_attr.attr,		/* 43 */
+	&sensor_dev_attr_temp6_input.dev_attr.attr,		/* 46 */
 	&sensor_dev_attr_temp6_beep.dev_attr.attr,
 
 	NULL
@@ -541,25 +587,27 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (err < 0)
 		return 0;
 
-	if (index < 9 &&
+	if (index < 10 &&
 	    (reg & 03) != 0x01 && (reg & 0x03) != 0x02)		/* RD1 */
 		return 0;
-	if (index >= 9 && index < 18 &&
+
+	if (index >= 10 && index < 20 &&
 	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
 		return 0;
-	if (index >= 18 && index < 27 && (reg & 0x30) != 0x20)	/* RD3 */
+	if (index >= 20 && index < 30 && (reg & 0x30) != 0x20)	/* RD3 */
 		return 0;
-	if (index >= 27 && index < 35)				/* local */
+
+	if (index >= 30 && index < 38)				/* local */
 		return attr->mode;
 
 	err = regmap_read(data->regmap, REG_PECI_ENABLE, &reg);
 	if (err < 0)
 		return 0;
 
-	if (index >= 35 && index < 43 && !(reg & 0x01))		/* PECI 0 */
+	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x43 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
