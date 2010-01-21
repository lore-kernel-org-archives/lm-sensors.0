From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 13:48:51 +0000
Subject: [lm-sensors] [PATCH 2/8] hwmon: (it87) Expose the PWM/temperature
Message-Id: <20100121144851.471e3863@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Let the user read the PWM-to-temperature mappings. Until the trip
points are also exposed, this is essentially a way to know how the
BIOS has set things up. The ability to change the settings will be
added later, together with the trip points.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 4 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-21 13:03:25.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-21 13:15:53.000000000 +0100
@@ -751,6 +751,59 @@ static ssize_t set_pwm_freq(struct devic
 
 	return count;
 }
+static ssize_t show_pwm_temp_map(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+	int map;
+
+	if (data->pwm_temp_map[nr] < 3)
+		map = 1 << data->pwm_temp_map[nr];
+	else
+		map = 0;			/* Should never happen */
+	return sprintf(buf, "%d\n", map);
+}
+static ssize_t set_pwm_temp_map(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = dev_get_drvdata(dev);
+	long val;
+	u8 reg;
+
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	switch (val) {
+	case (1 << 0):
+		reg = 0x00;
+		break;
+	case (1 << 1):
+		reg = 0x01;
+		break;
+	case (1 << 2):
+		reg = 0x02;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->update_lock);
+	data->pwm_temp_map[nr] = reg;
+	/* If we are in automatic mode, write the temp mapping immediately;
+	 * otherwise, just store it for later use. */
+	if (data->pwm_ctrl[nr] & 0x80) {
+		data->pwm_ctrl[nr] = 0x80 | data->pwm_temp_map[nr];
+		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
 
 #define show_fan_offset(offset)					\
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
@@ -771,7 +824,10 @@ static SENSOR_DEVICE_ATTR(pwm##offset, S
 		show_pwm, set_pwm, offset - 1);				\
 static DEVICE_ATTR(pwm##offset##_freq,					\
 		(offset = 1 ? S_IRUGO | S_IWUSR : S_IRUGO),		\
-		show_pwm_freq, (offset = 1 ? set_pwm_freq : NULL));
+		show_pwm_freq, (offset = 1 ? set_pwm_freq : NULL));	\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_channels_temp,		\
+		S_IRUGO, show_pwm_temp_map, set_pwm_temp_map,		\
+		offset - 1);
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -995,6 +1051,9 @@ static struct attribute *it87_attributes
 	&dev_attr_pwm1_freq.attr,
 	&dev_attr_pwm2_freq.attr,
 	&dev_attr_pwm3_freq.attr,
+	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
 
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
@@ -1268,7 +1327,9 @@ static int __devinit it87_probe(struct p
 			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_pwm1.dev_attr))
 			 || (err = device_create_file(dev,
-			     &dev_attr_pwm1_freq)))
+			     &dev_attr_pwm1_freq))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm1_auto_channels_temp.dev_attr)))
 				goto ERROR4;
 		}
 		if (!(sio_data->skip_pwm & (1 << 1))) {
@@ -1277,7 +1338,9 @@ static int __devinit it87_probe(struct p
 			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_pwm2.dev_attr))
 			 || (err = device_create_file(dev,
-			     &dev_attr_pwm2_freq)))
+			     &dev_attr_pwm2_freq))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm2_auto_channels_temp.dev_attr)))
 				goto ERROR4;
 		}
 		if (!(sio_data->skip_pwm & (1 << 2))) {
@@ -1286,7 +1349,9 @@ static int __devinit it87_probe(struct p
 			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_pwm3.dev_attr))
 			 || (err = device_create_file(dev,
-			     &dev_attr_pwm3_freq)))
+			     &dev_attr_pwm3_freq))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm3_auto_channels_temp.dev_attr)))
 				goto ERROR4;
 		}
 	}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
