From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Nov 2014 18:15:14 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Add blank lines after declarations
Message-Id: <1416161714-23796-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

checkpatch complains about
	WARNING: Missing a blank line after declarations

Add missing blank lines. Also reorder variables length-wise where appropriate
if a function header is touched anyway.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index ffe7427..630073d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1073,6 +1073,7 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 static inline void nct6775_set_bank(struct nct6775_data *data, u16 reg)
 {
 	u8 bank = reg >> 8;
+
 	if (data->bank != bank) {
 		outb_p(NCT6775_REG_BANK, data->addr + ADDR_REG_OFFSET);
 		outb_p(bank, data->addr + DATA_REG_OFFSET);
@@ -1310,6 +1311,7 @@ static void nct6775_update_pwm(struct device *dev)
 		if (!data->target_speed_tolerance[i] ||
 		    data->pwm_enable[i] = speed_cruise) {
 			u8 t = fanmodecfg & 0x0f;
+
 			if (data->REG_TOLERANCE_H) {
 				t |= (nct6775_read_value(data,
 				      data->REG_TOLERANCE_H[i]) & 0x70) >> 1;
@@ -1484,6 +1486,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 		data->alarms = 0;
 		for (i = 0; i < NUM_REG_ALARM; i++) {
 			u8 alarm;
+
 			if (!data->REG_ALARM[i])
 				continue;
 			alarm = nct6775_read_value(data, data->REG_ALARM[i]);
@@ -1493,6 +1496,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 		data->beeps = 0;
 		for (i = 0; i < NUM_REG_BEEP; i++) {
 			u8 beep;
+
 			if (!data->REG_BEEP[i])
 				continue;
 			beep = nct6775_read_value(data, data->REG_BEEP[i]);
@@ -1515,8 +1519,9 @@ show_in_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int nr = sattr->nr;
 	int index = sattr->index;
+	int nr = sattr->nr;
+
 	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr][index], nr));
 }
 
@@ -1526,10 +1531,12 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int nr = sattr->nr;
 	int index = sattr->index;
+	int nr = sattr->nr;
 	unsigned long val;
-	int err = kstrtoul(buf, 10, &val);
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 	mutex_lock(&data->update_lock);
@@ -1546,6 +1553,7 @@ show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = data->ALARM_BITS[sattr->index];
+
 	return sprintf(buf, "%u\n",
 		       (unsigned int)((data->alarms >> nr) & 0x01));
 }
@@ -1581,6 +1589,7 @@ show_temp_alarm(struct device *dev, struct device_attribute *attr, char *buf)
 	nr = find_temp_source(data, sattr->index, data->num_temp_alarms);
 	if (nr >= 0) {
 		int bit = data->ALARM_BITS[nr + TEMP_ALARM_BASE];
+
 		alarm = (data->alarms >> bit) & 0x01;
 	}
 	return sprintf(buf, "%u\n", alarm);
@@ -1606,8 +1615,9 @@ store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
 	int nr = data->BEEP_BITS[sattr->index];
 	int regindex = nr >> 3;
 	unsigned long val;
+	int err;
 
-	int err = kstrtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 	if (val > 1)
@@ -1640,6 +1650,7 @@ show_temp_beep(struct device *dev, struct device_attribute *attr, char *buf)
 	nr = find_temp_source(data, sattr->index, data->num_temp_beeps);
 	if (nr >= 0) {
 		int bit = data->BEEP_BITS[nr + TEMP_ALARM_BASE];
+
 		beep = (data->beeps >> bit) & 0x01;
 	}
 	return sprintf(buf, "%u\n", beep);
@@ -1653,8 +1664,9 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int nr, bit, regindex;
 	unsigned long val;
+	int err;
 
-	int err = kstrtoul(buf, 10, &val);
+	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
 	if (val > 1)
@@ -1726,6 +1738,7 @@ show_fan(struct device *dev, struct device_attribute *attr, char *buf)
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = sattr->index;
+
 	return sprintf(buf, "%d\n", data->rpm[nr]);
 }
 
@@ -1735,6 +1748,7 @@ show_fan_min(struct device *dev, struct device_attribute *attr, char *buf)
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = sattr->index;
+
 	return sprintf(buf, "%d\n",
 		       data->fan_from_reg_min(data->fan_min[nr],
 					      data->fan_div[nr]));
@@ -1746,6 +1760,7 @@ show_fan_div(struct device *dev, struct device_attribute *attr, char *buf)
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = sattr->index;
+
 	return sprintf(buf, "%u\n", div_from_reg(data->fan_div[nr]));
 }
 
@@ -1757,9 +1772,9 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = sattr->index;
 	unsigned long val;
-	int err;
 	unsigned int reg;
 	u8 new_div;
+	int err;
 
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
@@ -1943,6 +1958,7 @@ show_temp_label(struct device *dev, struct device_attribute *attr, char *buf)
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = sattr->index;
+
 	return sprintf(buf, "%s\n", data->temp_label[data->temp_src[nr]]);
 }
 
@@ -2019,6 +2035,7 @@ show_temp_type(struct device *dev, struct device_attribute *attr, char *buf)
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	int nr = sattr->index;
+
 	return sprintf(buf, "%d\n", (int)data->temp_type[nr]);
 }
 
@@ -3009,6 +3026,7 @@ static ssize_t
 show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
+
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
