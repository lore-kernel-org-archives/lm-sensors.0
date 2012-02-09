From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Feb 2012 17:17:56 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Add support for temperature offset registers
Message-Id: <1328807876-26409-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for temperature offset registers for CPUTIN, SYSTIN,
and AUXTIN temperatures.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/w83627ehf.c |   73 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 57a31a0..5273fff 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -241,6 +241,8 @@ static const u16 W83627EHF_REG_FAN_MAX_OUTPUT_W83667_B[] = { 0x67, 0x69, 0x6b };
 static const u16 W83627EHF_REG_FAN_STEP_OUTPUT_W83667_B[]
 						= { 0x68, 0x6a, 0x6c };
 
+static const u16 W83627EHF_REG_TEMP_OFFSET[] = { 0x454, 0x455, 0x456 };
+
 static const u16 NCT6775_REG_TARGET[] = { 0x101, 0x201, 0x301 };
 static const u16 NCT6775_REG_FAN_MODE[] = { 0x102, 0x202, 0x302 };
 static const u16 NCT6775_REG_FAN_STOP_OUTPUT[] = { 0x105, 0x205, 0x305 };
@@ -466,6 +468,7 @@ struct w83627ehf_data {
 	u8 has_fan_min;		/* some fans don't have min register */
 	bool has_fan_div;
 	u8 temp_type[3];
+	s8 temp_offset[3];
 	s16 temp[9];
 	s16 temp_max[9];
 	s16 temp_max_hyst[9];
@@ -497,6 +500,7 @@ struct w83627ehf_data {
 	u8 vrm;
 
 	u16 have_temp;
+	u16 have_temp_offset;
 	u8 in6_skip:1;
 	u8 temp3_val_only:1;
 };
@@ -894,6 +898,10 @@ static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
 				data->temp_max_hyst[i]
 				  = w83627ehf_read_temp(data,
 						data->reg_temp_hyst[i]);
+			if (data->have_temp_offset & (1 << i))
+				data->temp_offset[i]
+				  = w83627ehf_read_value(data,
+						W83627EHF_REG_TEMP_OFFSET[i]);
 		}
 
 		data->alarms = w83627ehf_read_value(data,
@@ -1227,6 +1235,39 @@ store_temp_reg(reg_temp_over, temp_max);
 store_temp_reg(reg_temp_hyst, temp_max_hyst);
 
 static ssize_t
+show_temp_offset(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n",
+		       data->temp_offset[sensor_attr->index] * 1000);
+}
+
+static ssize_t
+store_temp_offset(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
+{
+	struct w83627ehf_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val = SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+
+	mutex_lock(&data->update_lock);
+	data->temp_offset[nr] = val;
+	w83627ehf_write_value(data, W83627EHF_REG_TEMP_OFFSET[nr], val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
 show_temp_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627ehf_data *data = w83627ehf_update_device(dev);
@@ -1313,6 +1354,15 @@ static struct sensor_device_attribute sda_temp_type[] = {
 	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
 };
 
+static struct sensor_device_attribute sda_temp_offset[] = {
+	SENSOR_ATTR(temp1_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 0),
+	SENSOR_ATTR(temp2_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 1),
+	SENSOR_ATTR(temp3_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		    store_temp_offset, 2),
+};
+
 #define show_pwm_reg(reg) \
 static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 			  char *buf) \
@@ -1805,6 +1855,7 @@ static void w83627ehf_device_remove_files(struct device *dev)
 			continue;
 		device_remove_file(dev, &sda_temp_alarm[i].dev_attr);
 		device_remove_file(dev, &sda_temp_type[i].dev_attr);
+		device_remove_file(dev, &sda_temp_offset[i].dev_attr);
 	}
 
 	device_remove_file(dev, &sda_caseopen[0].dev_attr);
@@ -2126,6 +2177,11 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 		} else {
 			data->temp_label = nct6775_temp_label;
 		}
+		data->have_temp_offset = data->have_temp & 0x07;
+		for (i = 0; i < 3; i++) {
+			if (data->temp_src[i] > 3)
+				data->have_temp_offset &= ~(1 << i);
+		}
 	} else if (sio_data->kind = w83667hg_b) {
 		u8 reg;
 
@@ -2168,6 +2224,11 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 			data->in6_skip = 1;
 
 		data->temp_label = w83667hg_b_temp_label;
+		data->have_temp_offset = data->have_temp & 0x07;
+		for (i = 0; i < 3; i++) {
+			if (data->temp_src[i] > 2)
+				data->have_temp_offset &= ~(1 << i);
+		}
 	} else if (sio_data->kind = w83627uhg) {
 		u8 reg;
 
@@ -2204,6 +2265,11 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 		data->in6_skip = 1;			/* No VIN3 */
 
 		data->temp_label = w83667hg_b_temp_label;
+		data->have_temp_offset = data->have_temp & 0x03;
+		for (i = 0; i < 2; i++) {
+			if (data->temp_src[i] > 1)
+				data->have_temp_offset &= ~(1 << i);
+		}
 	} else {
 		w83627ehf_set_temp_reg_ehf(data, 3);
 
@@ -2223,6 +2289,7 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 			else
 				data->in6_skip = 1;
 		}
+		data->have_temp_offset = data->have_temp & 0x07;
 	}
 
 	if (sio_data->kind = nct6775) {
@@ -2488,6 +2555,12 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 			|| (err = device_create_file(dev,
 				&sda_temp_type[i].dev_attr)))
 			goto exit_remove;
+		if (data->have_temp_offset & (1 << i)) {
+			err = device_create_file(dev,
+						 &sda_temp_offset[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
 	}
 
 	err = device_create_file(dev, &sda_caseopen[0].dev_attr);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
