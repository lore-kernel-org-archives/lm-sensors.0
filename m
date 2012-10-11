From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 14:36:12 +0000
Subject: [lm-sensors] [PATCH 2/7] hwmon: (it87) Save voltage register values in 2-dimensional array
Message-Id: <1349966177-25985-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reduces code size (more than 600 bytes on x86_64),
and gets rid of some checkpatch errors.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |  135 +++++++++++++++++++-------------------------------
 1 file changed, 52 insertions(+), 83 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 350d8f4..d211c2b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -258,9 +258,7 @@ struct it87_data {
 	unsigned long last_updated;	/* In jiffies */
 
 	u16 in_scaled;		/* Internal voltage sensors are scaled */
-	u8 in[9];		/* Register value */
-	u8 in_max[8];		/* Register value */
-	u8 in_min[8];		/* Register value */
+	u8 in[9][3];		/* [nr][0]=in, [1]=min, [2]=max */
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[5];		/* Register values, possibly combined */
 	u16 fan_min[5];		/* Register values, possibly combined */
@@ -445,40 +443,22 @@ static struct platform_driver it87_driver = {
 };
 
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
-		char *buf)
+		       char *buf)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
-	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", in_from_reg(data, nr, data->in[nr]));
-}
-
-static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
-	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", in_from_reg(data, nr, data->in_min[nr]));
-}
-
-static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	int nr = sattr->nr;
+	int index = sattr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", in_from_reg(data, nr, data->in_max[nr]));
+	return sprintf(buf, "%d\n", in_from_reg(data, nr, data->in[nr][index]));
 }
 
-static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t set_in(struct device *dev, struct device_attribute *attr,
+		      const char *buf, size_t count)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	int nr = sattr->nr;
+	int index = sattr->index;
 
 	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -487,59 +467,50 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->in_min[nr] = in_to_reg(data, nr, val);
-	it87_write_value(data, IT87_REG_VIN_MIN(nr),
-			data->in_min[nr]);
+	data->in[nr][index] = in_to_reg(data, nr, val);
+	it87_write_value(data,
+			 index = 1 ? IT87_REG_VIN_MIN(nr)
+				    : IT87_REG_VIN_MAX(nr),
+			 data->in[nr][index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
 
-	struct it87_data *data = dev_get_drvdata(dev);
-	unsigned long val;
+#define S_IRUGOWU	(S_IRUGO | S_IWUSR)
 
-	if (kstrtoul(buf, 10, &val) < 0)
-		return -EINVAL;
+static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0);
+static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGOWU, show_in, set_in, 0, 1);
+static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGOWU, show_in, set_in, 0, 2);
 
-	mutex_lock(&data->update_lock);
-	data->in_max[nr] = in_to_reg(data, nr, val);
-	it87_write_value(data, IT87_REG_VIN_MAX(nr),
-			data->in_max[nr]);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
+static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 1, 0);
+static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGOWU, show_in, set_in, 1, 1);
+static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGOWU, show_in, set_in, 1, 2);
+
+static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 2, 0);
+static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGOWU, show_in, set_in, 2, 1);
+static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGOWU, show_in, set_in, 2, 2);
+
+static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 3, 0);
+static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGOWU, show_in, set_in, 3, 1);
+static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGOWU, show_in, set_in, 3, 2);
 
-#define show_in_offset(offset)					\
-static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
-		show_in, NULL, offset);
-
-#define limit_in_offset(offset)					\
-static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
-		show_in_min, set_in_min, offset);		\
-static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
-		show_in_max, set_in_max, offset);
-
-show_in_offset(0);
-limit_in_offset(0);
-show_in_offset(1);
-limit_in_offset(1);
-show_in_offset(2);
-limit_in_offset(2);
-show_in_offset(3);
-limit_in_offset(3);
-show_in_offset(4);
-limit_in_offset(4);
-show_in_offset(5);
-limit_in_offset(5);
-show_in_offset(6);
-limit_in_offset(6);
-show_in_offset(7);
-limit_in_offset(7);
-show_in_offset(8);
+static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 4, 0);
+static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGOWU, show_in, set_in, 4, 1);
+static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGOWU, show_in, set_in, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 5, 0);
+static SENSOR_DEVICE_ATTR_2(in5_min, S_IRUGOWU, show_in, set_in, 5, 1);
+static SENSOR_DEVICE_ATTR_2(in5_max, S_IRUGOWU, show_in, set_in, 5, 2);
+
+static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 6, 0);
+static SENSOR_DEVICE_ATTR_2(in6_min, S_IRUGOWU, show_in, set_in, 6, 1);
+static SENSOR_DEVICE_ATTR_2(in6_max, S_IRUGOWU, show_in, set_in, 6, 2);
+
+static SENSOR_DEVICE_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 7, 0);
+static SENSOR_DEVICE_ATTR_2(in7_min, S_IRUGOWU, show_in, set_in, 7, 1);
+static SENSOR_DEVICE_ATTR_2(in7_max, S_IRUGOWU, show_in, set_in, 7, 2);
+
+static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 8, 0);
 
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
@@ -575,8 +546,6 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-#define S_IRUGOWU	(S_IRUGO | S_IWUSR)
-
 static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGOWU, show_temp, set_temp, 0, 1);
 static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGOWU, show_temp, set_temp, 0, 2);
@@ -2357,15 +2326,15 @@ static struct it87_data *it87_update_device(struct device *dev)
 				it87_read_value(data, IT87_REG_CONFIG) | 0x40);
 		}
 		for (i = 0; i <= 7; i++) {
-			data->in[i] +			data->in[i][0]  				it87_read_value(data, IT87_REG_VIN(i));
-			data->in_min[i] +			data->in[i][1]  				it87_read_value(data, IT87_REG_VIN_MIN(i));
-			data->in_max[i] +			data->in[i][2]  				it87_read_value(data, IT87_REG_VIN_MAX(i));
 		}
 		/* in8 (battery) has no limit registers */
-		data->in[8] = it87_read_value(data, IT87_REG_VIN(8));
+		data->in[8][0] = it87_read_value(data, IT87_REG_VIN(8));
 
 		for (i = 0; i < 5; i++) {
 			/* Skip disabled fans */
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
