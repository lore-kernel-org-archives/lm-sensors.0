From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Feb 2010 08:01:35 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (it87) Add support for old
Message-Id: <20100225090135.4fefd2f6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the automatic fan speed control interface as
implemented by IT8705F chips up to revision F and IT8712F chips up to
revision G. This implementation fits very well in our standard sysfs
interface.

I implemented the old and not the new interface because the only chip
I have at hand is an old one, and the new interface is more difficult
to map to the standard sysfs interface. Adding support later should be
possible though, if someone with a supported chip is interested.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |   27 ++++++
 drivers/hwmon/it87.c     |  182 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 4 deletions(-)

--- linux-2.6.33-rc8.orig/drivers/hwmon/it87.c	2010-02-22 08:38:19.000000000 +0100
+++ linux-2.6.33-rc8/drivers/hwmon/it87.c	2010-02-22 11:09:33.000000000 +0100
@@ -192,6 +192,9 @@ static const u8 IT87_REG_FANX_MIN[]	= {
 
 #define IT87_REG_CHIPID        0x58
 
+#define IT87_REG_AUTO_TEMP(nr, i) (0x60 + (nr) * 8 + (i))
+#define IT87_REG_AUTO_PWM(nr, i)  (0x65 + (nr) * 8 + (i))
+
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
 #define IN_FROM_REG(val) ((val) * 16)
 
@@ -293,6 +296,10 @@ struct it87_data {
 	u8 pwm_ctrl[3];		/* Register value */
 	u8 pwm_duty[3];		/* Manual PWM value set by user (bit 6-0) */
 	u8 pwm_temp_map[3];	/* PWM to temp. chan. mapping (bits 1-0) */
+
+	/* Automatic fan speed control registers */
+	u8 auto_pwm[3][4];	/* [nr][3] is hard-coded */
+	s8 auto_temp[3][5];	/* [nr][0] is point1_temp_hyst */
 };
 
 static inline int has_16bit_fans(const struct it87_data *data)
@@ -307,6 +314,15 @@ static inline int has_16bit_fans(const s
 	    || data->type = it8720;
 }
 
+static inline int has_old_autopwm(const struct it87_data *data)
+{
+	/* The old automatic fan speed control interface is implemented
+	   by IT8705F chips up to revision F and IT8712F chips up to
+	   revision G. */
+	return (data->type = it87 && data->revision < 0x03)
+	    || (data->type = it8712 && data->revision < 0x08);
+}
+
 static int it87_probe(struct platform_device *pdev);
 static int __devexit it87_remove(struct platform_device *pdev);
 
@@ -813,6 +829,13 @@ static ssize_t set_pwm_temp_map(struct d
 	long val;
 	u8 reg;
 
+	/* This check can go away if we ever support automatic fan speed
+	   control on newer chips. */
+	if (!has_old_autopwm(data)) {
+		dev_notice(dev, "Mapping change disabled for safety reasons\n");
+		return -EINVAL;
+	}
+
 	if (strict_strtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
@@ -842,6 +865,72 @@ static ssize_t set_pwm_temp_map(struct d
 	return count;
 }
 
+static ssize_t show_auto_pwm(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct it87_data *data = it87_update_device(dev);
+	struct sensor_device_attribute_2 *sensor_attr +			to_sensor_dev_attr_2(attr);
+	int nr = sensor_attr->nr;
+	int point = sensor_attr->index;
+
+	return sprintf(buf, "%d\n", PWM_FROM_REG(data->auto_pwm[nr][point]));
+}
+
+static ssize_t set_auto_pwm(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct it87_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sensor_attr +			to_sensor_dev_attr_2(attr);
+	int nr = sensor_attr->nr;
+	int point = sensor_attr->index;
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 255)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->auto_pwm[nr][point] = PWM_TO_REG(val);
+	it87_write_value(data, IT87_REG_AUTO_PWM(nr, point),
+			 data->auto_pwm[nr][point]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_auto_temp(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct it87_data *data = it87_update_device(dev);
+	struct sensor_device_attribute_2 *sensor_attr +			to_sensor_dev_attr_2(attr);
+	int nr = sensor_attr->nr;
+	int point = sensor_attr->index;
+
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->auto_temp[nr][point]));
+}
+
+static ssize_t set_auto_temp(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct it87_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sensor_attr +			to_sensor_dev_attr_2(attr);
+	int nr = sensor_attr->nr;
+	int point = sensor_attr->index;
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0 || val < -128000 || val > 127000)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->auto_temp[nr][point] = TEMP_TO_REG(val);
+	it87_write_value(data, IT87_REG_AUTO_TEMP(nr, point),
+			 data->auto_temp[nr][point]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 #define show_fan_offset(offset)					\
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
 		show_fan, NULL, offset - 1);			\
@@ -863,8 +952,34 @@ static DEVICE_ATTR(pwm##offset##_freq,
 		(offset = 1 ? S_IRUGO | S_IWUSR : S_IRUGO),		\
 		show_pwm_freq, (offset = 1 ? set_pwm_freq : NULL));	\
 static SENSOR_DEVICE_ATTR(pwm##offset##_auto_channels_temp,		\
-		S_IRUGO, show_pwm_temp_map, set_pwm_temp_map,		\
-		offset - 1);
+		S_IRUGO | S_IWUSR, show_pwm_temp_map, set_pwm_temp_map,	\
+		offset - 1);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point1_pwm,		\
+		S_IRUGO | S_IWUSR, show_auto_pwm, set_auto_pwm,		\
+		offset - 1, 0);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point2_pwm,		\
+		S_IRUGO | S_IWUSR, show_auto_pwm, set_auto_pwm,		\
+		offset - 1, 1);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point3_pwm,		\
+		S_IRUGO | S_IWUSR, show_auto_pwm, set_auto_pwm,		\
+		offset - 1, 2);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point4_pwm,		\
+		S_IRUGO, show_auto_pwm, NULL, offset - 1, 3);		\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point1_temp,		\
+		S_IRUGO | S_IWUSR, show_auto_temp, set_auto_temp,	\
+		offset - 1, 1);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point1_temp_hyst,	\
+		S_IRUGO | S_IWUSR, show_auto_temp, set_auto_temp,	\
+		offset - 1, 0);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point2_temp,		\
+		S_IRUGO | S_IWUSR, show_auto_temp, set_auto_temp,	\
+		offset - 1, 2);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point3_temp,		\
+		S_IRUGO | S_IWUSR, show_auto_temp, set_auto_temp,	\
+		offset - 1, 3);						\
+static SENSOR_DEVICE_ATTR_2(pwm##offset##_auto_point4_temp,		\
+		S_IRUGO | S_IWUSR, show_auto_temp, set_auto_temp,	\
+		offset - 1, 4);
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -1219,6 +1334,47 @@ static const struct attribute_group it87
 	{ .attrs = it87_attributes_pwm[2] },
 };
 
+static struct attribute *it87_attributes_autopwm[3][9+1] = { {
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point4_temp.dev_attr.attr,
+	NULL
+} };
+
+static const struct attribute_group it87_group_autopwm[3] = {
+	{ .attrs = it87_attributes_autopwm[0] },
+	{ .attrs = it87_attributes_autopwm[1] },
+	{ .attrs = it87_attributes_autopwm[2] },
+};
+
 static struct attribute *it87_attributes_fan_beep[] = {
 	&sensor_dev_attr_fan1_beep.dev_attr.attr,
 	&sensor_dev_attr_fan2_beep.dev_attr.attr,
@@ -1382,6 +1538,9 @@ static void it87_remove_files(struct dev
 		if (sio_data->skip_pwm & (1 << 0))
 			continue;
 		sysfs_remove_group(&dev->kobj, &it87_group_pwm[i]);
+		if (has_old_autopwm(data))
+			sysfs_remove_group(&dev->kobj,
+					   &it87_group_autopwm[i]);
 	}
 	if (!sio_data->skip_vid)
 		sysfs_remove_group(&dev->kobj, &it87_group_vid);
@@ -1491,6 +1650,13 @@ static int __devinit it87_probe(struct p
 						 &it87_group_pwm[i]);
 			if (err)
 				goto ERROR4;
+
+			if (!has_old_autopwm(data))
+				continue;
+			err = sysfs_create_group(&dev->kobj,
+						 &it87_group_autopwm[i]);
+			if (err)
+				goto ERROR4;
 		}
 	}
 
@@ -1624,6 +1790,7 @@ static void __devinit it87_init_device(s
 	for (i = 0; i < 3; i++) {
 		data->pwm_temp_map[i] = i;
 		data->pwm_duty[i] = 0x7f;	/* Full speed */
+		data->auto_pwm[i][3] = 0x7f;	/* Full speed, hard-coded */
 	}
 
 	/* Some chips seem to have default value 0xff for all limit
@@ -1703,6 +1870,17 @@ static void it87_update_pwm_ctrl(struct
 		data->pwm_temp_map[nr] = data->pwm_ctrl[nr] & 0x03;
 	else				/* Manual mode */
 		data->pwm_duty[nr] = data->pwm_ctrl[nr] & 0x7f;
+
+	if (has_old_autopwm(data)) {
+		int i;
+
+		for (i = 0; i < 5 ; i++)
+			data->auto_temp[nr][i] = it87_read_value(data,
+						IT87_REG_AUTO_TEMP(nr, i));
+		for (i = 0; i < 3 ; i++)
+			data->auto_pwm[nr][i] = it87_read_value(data,
+						IT87_REG_AUTO_PWM(nr, i));
+	}
 }
 
 static struct it87_data *it87_update_device(struct device *dev)
--- linux-2.6.33-rc8.orig/Documentation/hwmon/it87	2010-02-22 08:38:20.000000000 +0100
+++ linux-2.6.33-rc8/Documentation/hwmon/it87	2010-02-22 08:38:21.000000000 +0100
@@ -146,11 +146,34 @@ Fan speed control
 -----------------
 
 The fan speed control features are limited to manual PWM mode. Automatic
-"Smart Guardian" mode control handling is not implemented. However
-if you want to go for "manual mode" just write 1 to pwmN_enable.
+"Smart Guardian" mode control handling is only implemented for older chips
+(see below.) However if you want to go for "manual mode" just write 1 to
+pwmN_enable.
 
 If you are only able to control the fan speed with very small PWM values,
 try lowering the PWM base frequency (pwm1_freq). Depending on the fan,
 it may give you a somewhat greater control range. The same frequency is
 used to drive all fan outputs, which is why pwm2_freq and pwm3_freq are
 read-only.
+
+
+Automatic fan speed control (old interface)
+-------------------------------------------
+
+The driver supports the old interface to automatic fan speed control
+which is implemented by IT8705F chips up to revision F and IT8712F
+chips up to revision G.
+
+This interface implements 4 temperature vs. PWM output trip points.
+The PWM output of trip point 4 is always the maximum value (fan running
+at full speed) while the PWM output of the other 3 trip points can be
+freely chosen. The temperature of all 4 trip points can be freely chosen.
+Additionally, trip point 1 has an hysteresis temperature attached, to
+prevent fast switching between fan on and off.
+
+The chip automatically computes the PWM output value based on the input
+temperature, based on this simple rule: if the temperature value is
+between trip point N and trip point N+1 then the PWM output value is
+the one of trip point N. The automatic control mode is less flexible
+than the manual control mode, but it reacts faster, is more robust and
+doesn't use CPU cycles.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
