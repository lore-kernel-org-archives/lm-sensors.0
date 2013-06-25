From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Jun 2013 17:11:08 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Add support for beep attributes
Message-Id: <1372180269-3213-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372180172-3159-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372180172-3159-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies on top of previosuly sent patches. Target release is 3.12.

 drivers/hwmon/nct6775.c |  239 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 218 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 1560f23..6386d1b 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -171,6 +171,7 @@ superio_exit(int ioreg)
 #define NUM_TEMP_FIXED	6	/* Max number of fixed temp attribute sets */
 
 #define NUM_REG_ALARM	7	/* Max number of alarm registers */
+#define NUM_REG_BEEP	5	/* Max number of beep registers */
 
 /* Common and NCT6775 specific data */
 
@@ -197,7 +198,7 @@ static const u16 NCT6775_REG_IN[] = {
 
 static const u16 NCT6775_REG_ALARM[NUM_REG_ALARM] = { 0x459, 0x45A, 0x45B };
 
-/* 0..15 voltages, 16..23 fans, 24..31 temperatures */
+/* 0..15 voltages, 16..23 fans, 24..29 temperatures, 30..31 intrusion */
 
 static const s8 NCT6775_ALARM_BITS[] = {
 	0, 1, 2, 3, 8, 21, 20, 16,	/* in0.. in7 */
@@ -212,6 +213,23 @@ static const s8 NCT6775_ALARM_BITS[] = {
 #define TEMP_ALARM_BASE		24
 #define INTRUSION_ALARM_BASE	30
 
+static const u16 NCT6775_REG_BEEP[NUM_REG_BEEP] = { 0x56, 0x57, 0x453, 0x4e };
+
+/*
+ * 0..14 voltages, 15 global beep enable, 16..23 fans, 24..29 temperatures,
+ * 30..31 intrusion
+ */
+static const s8 NCT6775_BEEP_BITS[] = {
+	0, 1, 2, 3, 8, 9, 10, 16,	/* in0.. in7 */
+	17, -1, -1, -1, -1, -1, -1,	/* in8..in14 */
+	21,				/* global beep enable */
+	6, 7, 11, 28, -1,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
+	12, -1 };			/* intrusion0, intrusion1 */
+
+#define BEEP_ENABLE_BASE		15
+
 static const u8 NCT6775_REG_CR_CASEOPEN_CLR[] = { 0xe6, 0xee };
 static const u8 NCT6775_CR_CASEOPEN_CLR_MASK[] = { 0x20, 0x01 };
 
@@ -330,6 +348,17 @@ static const s8 NCT6776_ALARM_BITS[] = {
 	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
 	12, 9 };			/* intrusion0, intrusion1 */
 
+static const u16 NCT6776_REG_BEEP[NUM_REG_BEEP] = { 0xb2, 0xb3, 0xb4, 0xb5 };
+
+static const s8 NCT6776_BEEP_BITS[] = {
+	0, 1, 2, 3, 4, 5, 6, 7,		/* in0.. in7 */
+	8, -1, -1, -1, -1, -1, -1,	/* in8..in14 */
+	24,				/* global beep enable */
+	25, 26, 27, 28, 29,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	16, 17, 18, 19, 20, 21,		/* temp1..temp6 */
+	30, 31 };			/* intrusion0, intrusion1 */
+
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c };
 
@@ -395,6 +424,15 @@ static const s8 NCT6779_ALARM_BITS[] = {
 	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
 	12, 9 };			/* intrusion0, intrusion1 */
 
+static const s8 NCT6779_BEEP_BITS[] = {
+	0, 1, 2, 3, 4, 5, 6, 7,		/* in0.. in7 */
+	8, 9, 10, 11, 12, 13, 14,	/* in8..in14 */
+	24,				/* global beep enable */
+	25, 26, 27, 28, 29,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	16, 17, -1, -1, -1, -1,		/* temp1..temp6 */
+	30, 31 };			/* intrusion0, intrusion1 */
+
 static const u16 NCT6779_REG_FAN[] = { 0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8 };
 static const u16 NCT6779_REG_FAN_PULSES[] = {
 	0x644, 0x645, 0x646, 0x647, 0x648 };
@@ -535,6 +573,19 @@ static const s8 NCT6106_ALARM_BITS[] = {
 	48, -1				/* intrusion0, intrusion1 */
 };
 
+static const u16 NCT6106_REG_BEEP[NUM_REG_BEEP] = {
+	0x3c0, 0x3c1, 0x3c2, 0x3c3, 0x3c4 };
+
+static const s8 NCT6106_BEEP_BITS[] = {
+	0, 1, 2, 3, 4, 5, 7, 8,		/* in0.. in7 */
+	9, 10, 11, 12, -1, -1, -1,	/* in8..in14 */
+	32,				/* global beep enable */
+	24, 25, 26, 27, 28,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	16, 17, 18, 19, 20, 21,		/* temp1..temp6 */
+	34, -1				/* intrusion0, intrusion1 */
+};
+
 static const u16 NCT6106_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6776_temp_label) - 1]
 	= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x51, 0x52, 0x54 };
 
@@ -665,6 +716,7 @@ struct nct6775_data {
 	u8 DIODE_MASK;
 
 	const s8 *ALARM_BITS;
+	const s8 *BEEP_BITS;
 
 	const u16 *REG_VIN;
 	const u16 *REG_IN_MINMAX[2];
@@ -706,6 +758,7 @@ struct nct6775_data {
 	const u16 *REG_TEMP_OFFSET;
 
 	const u16 *REG_ALARM;
+	const u16 *REG_BEEP;
 
 	unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
 	unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divreg);
@@ -728,12 +781,14 @@ struct nct6775_data {
 	bool has_fan_div;
 
 	u8 num_temp_alarms;	/* 2, 3, or 6 */
+	u8 num_temp_beeps;	/* 2, 3, or 6 */
 	u8 temp_fixed_num;	/* 3 or 6 */
 	u8 temp_type[NUM_TEMP_FIXED];
 	s8 temp_offset[NUM_TEMP_FIXED];
 	s16 temp[4][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
 				* 3=temp_crit */
 	u64 alarms;
+	u64 beeps;
 
 	u8 pwm_num;	/* number of pwm */
 	u8 pwm_mode[5]; /* 1->DC variable voltage, 0->PWM variable duty cycle */
@@ -1385,6 +1440,15 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			data->alarms |= ((u64)alarm) << (i << 3);
 		}
 
+		data->beeps = 0;
+		for (i = 0; i < NUM_REG_BEEP; i++) {
+			u8 beep;
+			if (!data->REG_BEEP[i])
+				continue;
+			beep = nct6775_read_value(data, data->REG_BEEP[i]);
+			data->beeps |= ((u64)beep) << (i << 3);
+		}
+
 		data->last_updated = jiffies;
 		data->valid = true;
 	}
@@ -1472,12 +1536,105 @@ show_temp_alarm(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%u\n", alarm);
 }
 
+static ssize_t
+show_beep(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct nct6775_data *data = nct6775_update_device(dev);
+	int nr = data->BEEP_BITS[sattr->index];
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)((data->beeps >> nr) & 0x01));
+}
+
+static ssize_t
+store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
+	   size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct nct6775_data *data = dev_get_drvdata(dev);
+	int nr = data->BEEP_BITS[sattr->index];
+	int regindex = nr >> 3;
+	unsigned long val;
+
+	int err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	if (val)
+		data->beeps |= (1ULL << nr);
+	else
+		data->beeps &= ~(1ULL << nr);
+	nct6775_write_value(data, data->REG_BEEP[regindex],
+			    (data->beeps >> (regindex << 3)) & 0xff);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_temp_beep(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct nct6775_data *data = nct6775_update_device(dev);
+	unsigned int beep = 0;
+	int nr;
+
+	/*
+	 * For temperatures, there is no fixed mapping from registers to beep
+	 * enable bits. Beep enable bits are determined by the temperature
+	 * source mapping.
+	 */
+	nr = find_temp_source(data, sattr->index, data->num_temp_beeps);
+	if (nr >= 0) {
+		int bit = data->BEEP_BITS[nr + TEMP_ALARM_BASE];
+		beep = (data->beeps >> bit) & 0x01;
+	}
+	return sprintf(buf, "%u\n", beep);
+}
+
+static ssize_t
+store_temp_beep(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct nct6775_data *data = dev_get_drvdata(dev);
+	int nr, bit, regindex;
+	unsigned long val;
+
+	int err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	if (val > 1)
+		return -EINVAL;
+
+	nr = find_temp_source(data, sattr->index, data->num_temp_beeps);
+	if (nr < 0)
+		return -ENODEV;
+
+	bit = data->BEEP_BITS[nr + TEMP_ALARM_BASE];
+	regindex = bit >> 3;
+
+	mutex_lock(&data->update_lock);
+	if (val)
+		data->beeps |= (1ULL << bit);
+	else
+		data->beeps &= ~(1ULL << bit);
+	nct6775_write_value(data, data->REG_BEEP[regindex],
+			    (data->beeps >> (regindex << 3)) & 0xff);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static umode_t nct6775_in_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int in = index / 4;	/* voltage index */
+	int in = index / 5;	/* voltage index */
 
 	if (!(data->have_in & (1 << in)))
 		return 0;
@@ -1487,6 +1644,8 @@ static umode_t nct6775_in_is_visible(struct kobject *kobj,
 
 SENSOR_TEMPLATE_2(in_input, "in%d_input", S_IRUGO, show_in_reg, NULL, 0, 0);
 SENSOR_TEMPLATE(in_alarm, "in%d_alarm", S_IRUGO, show_alarm, NULL, 0);
+SENSOR_TEMPLATE(in_beep, "in%d_beep", S_IWUSR | S_IRUGO, show_beep, store_beep,
+		0);
 SENSOR_TEMPLATE_2(in_min, "in%d_min", S_IWUSR | S_IRUGO, show_in_reg,
 		  store_in_reg, 0, 1);
 SENSOR_TEMPLATE_2(in_max, "in%d_max", S_IWUSR | S_IRUGO, show_in_reg,
@@ -1500,6 +1659,7 @@ SENSOR_TEMPLATE_2(in_max, "in%d_max", S_IWUSR | S_IRUGO, show_in_reg,
 static struct sensor_device_template *nct6775_attributes_in_template[] = {
 	&sensor_dev_template_in_input,
 	&sensor_dev_template_in_alarm,
+	&sensor_dev_template_in_beep,
 	&sensor_dev_template_in_min,
 	&sensor_dev_template_in_max,
 	NULL
@@ -1677,17 +1837,19 @@ static umode_t nct6775_fan_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int fan = index / 5;	/* fan index */
-	int nr = index % 5;	/* attribute index */
+	int fan = index / 6;	/* fan index */
+	int nr = index % 6;	/* attribute index */
 
 	if (!(data->has_fan & (1 << fan)))
 		return 0;
 
 	if (nr = 1 && data->ALARM_BITS[FAN_ALARM_BASE + fan] = -1)
 		return 0;
-	if (nr = 3 && !(data->has_fan_min & (1 << fan)))
+	if (nr = 2 && data->BEEP_BITS[FAN_ALARM_BASE + fan] = -1)
 		return 0;
-	if (nr = 4 && data->kind != nct6775)
+	if (nr = 4 && !(data->has_fan_min & (1 << fan)))
+		return 0;
+	if (nr = 5 && data->kind != nct6775)
 		return 0;
 
 	return attr->mode;
@@ -1696,6 +1858,8 @@ static umode_t nct6775_fan_is_visible(struct kobject *kobj,
 SENSOR_TEMPLATE(fan_input, "fan%d_input", S_IRUGO, show_fan, NULL, 0);
 SENSOR_TEMPLATE(fan_alarm, "fan%d_alarm", S_IRUGO, show_alarm, NULL,
 		FAN_ALARM_BASE);
+SENSOR_TEMPLATE(fan_beep, "fan%d_beep", S_IWUSR | S_IRUGO, show_beep,
+		store_beep, FAN_ALARM_BASE);
 SENSOR_TEMPLATE(fan_pulses, "fan%d_pulses", S_IWUSR | S_IRUGO, show_fan_pulses,
 		store_fan_pulses, 0);
 SENSOR_TEMPLATE(fan_min, "fan%d_min", S_IWUSR | S_IRUGO, show_fan_min,
@@ -1710,9 +1874,10 @@ SENSOR_TEMPLATE(fan_div, "fan%d_div", S_IRUGO, show_fan_div, NULL, 0);
 static struct sensor_device_template *nct6775_attributes_fan_template[] = {
 	&sensor_dev_template_fan_input,
 	&sensor_dev_template_fan_alarm,	/* 1 */
+	&sensor_dev_template_fan_beep,	/* 2 */
 	&sensor_dev_template_fan_pulses,
-	&sensor_dev_template_fan_min,	/* 3 */
-	&sensor_dev_template_fan_div,	/* 4 */
+	&sensor_dev_template_fan_min,	/* 4 */
+	&sensor_dev_template_fan_div,	/* 5 */
 	NULL
 };
 
@@ -1855,8 +2020,8 @@ static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int temp = index / 9;	/* temp index */
-	int nr = index % 9;	/* attribute index */
+	int temp = index / 10;	/* temp index */
+	int nr = index % 10;	/* attribute index */
 
 	if (!(data->have_temp & (1 << temp)))
 		return 0;
@@ -1864,20 +2029,23 @@ static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 	if (nr = 2 && find_temp_source(data, temp, data->num_temp_alarms) < 0)
 		return 0;				/* alarm */
 
-	if (nr = 3 && !data->reg_temp[1][temp])	/* max */
+	if (nr = 3 && find_temp_source(data, temp, data->num_temp_beeps) < 0)
+		return 0;				/* beep */
+
+	if (nr = 4 && !data->reg_temp[1][temp])	/* max */
 		return 0;
 
-	if (nr = 4 && !data->reg_temp[2][temp])	/* max_hyst */
+	if (nr = 5 && !data->reg_temp[2][temp])	/* max_hyst */
 		return 0;
 
-	if (nr = 5 && !data->reg_temp[3][temp])	/* crit */
+	if (nr = 6 && !data->reg_temp[3][temp])	/* crit */
 		return 0;
 
-	if (nr = 6 && !data->reg_temp[4][temp])	/* lcrit */
+	if (nr = 7 && !data->reg_temp[4][temp])	/* lcrit */
 		return 0;
 
 	/* offset and type only apply to fixed sensors */
-	if (nr > 6 && !(data->have_temp_fixed & (1 << temp)))
+	if (nr > 7 && !(data->have_temp_fixed & (1 << temp)))
 		return 0;
 
 	return attr->mode;
@@ -1898,6 +2066,8 @@ SENSOR_TEMPLATE(temp_offset, "temp%d_offset", S_IRUGO | S_IWUSR,
 SENSOR_TEMPLATE(temp_type, "temp%d_type", S_IRUGO | S_IWUSR, show_temp_type,
 		store_temp_type, 0);
 SENSOR_TEMPLATE(temp_alarm, "temp%d_alarm", S_IRUGO, show_temp_alarm, NULL, 0);
+SENSOR_TEMPLATE(temp_beep, "temp%d_beep", S_IRUGO | S_IWUSR, show_temp_beep,
+		store_temp_beep, 0);
 
 /*
  * nct6775_temp_is_visible uses the index into the following array
@@ -1908,12 +2078,13 @@ static struct sensor_device_template *nct6775_attributes_temp_template[] = {
 	&sensor_dev_template_temp_input,
 	&sensor_dev_template_temp_label,
 	&sensor_dev_template_temp_alarm,	/* 2 */
-	&sensor_dev_template_temp_max,		/* 3 */
-	&sensor_dev_template_temp_max_hyst,	/* 4 */
-	&sensor_dev_template_temp_crit,		/* 5 */
-	&sensor_dev_template_temp_lcrit,	/* 6 */
-	&sensor_dev_template_temp_offset,	/* 7 */
-	&sensor_dev_template_temp_type,		/* 8 */
+	&sensor_dev_template_temp_beep,		/* 3 */
+	&sensor_dev_template_temp_max,		/* 4 */
+	&sensor_dev_template_temp_max_hyst,	/* 5 */
+	&sensor_dev_template_temp_crit,		/* 6 */
+	&sensor_dev_template_temp_lcrit,	/* 7 */
+	&sensor_dev_template_temp_offset,	/* 8 */
+	&sensor_dev_template_temp_type,		/* 9 */
 	NULL
 };
 
@@ -2845,6 +3016,12 @@ static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm,
 			  clear_caseopen, INTRUSION_ALARM_BASE);
 static SENSOR_DEVICE_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_alarm,
 			  clear_caseopen, INTRUSION_ALARM_BASE + 1);
+static SENSOR_DEVICE_ATTR(intrusion0_beep, S_IWUSR | S_IRUGO, show_beep,
+			  store_beep, INTRUSION_ALARM_BASE);
+static SENSOR_DEVICE_ATTR(intrusion1_beep, S_IWUSR | S_IRUGO, show_beep,
+			  store_beep, INTRUSION_ALARM_BASE + 1);
+static SENSOR_DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_beep,
+			  store_beep, BEEP_ENABLE_BASE);
 
 static umode_t nct6775_other_is_visible(struct kobject *kobj,
 					struct attribute *attr, int index)
@@ -2860,6 +3037,11 @@ static umode_t nct6775_other_is_visible(struct kobject *kobj,
 			return 0;
 	}
 
+	if (index = 4 || index = 5) {
+		if (data->BEEP_BITS[INTRUSION_ALARM_BASE + index - 4] < 0)
+			return 0;
+	}
+
 	return attr->mode;
 }
 
@@ -2873,6 +3055,9 @@ static struct attribute *nct6775_attributes_other[] = {
 	&dev_attr_cpu0_vid.attr,				/* 1 */
 	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,	/* 2 */
 	&sensor_dev_attr_intrusion1_alarm.dev_attr.attr,	/* 3 */
+	&sensor_dev_attr_intrusion0_beep.dev_attr.attr,		/* 4 */
+	&sensor_dev_attr_intrusion1_beep.dev_attr.attr,		/* 5 */
+	&sensor_dev_attr_beep_enable.dev_attr.attr,		/* 6 */
 
 	NULL
 };
@@ -3094,6 +3279,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->auto_pwm_num = 4;
 		data->temp_fixed_num = 3;
 		data->num_temp_alarms = 6;
+		data->num_temp_beeps = 6;
 
 		data->fan_from_reg = fan_from_reg13;
 		data->fan_from_reg_min = fan_from_reg13;
@@ -3142,6 +3328,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_WEIGHT_TEMP[2] = NCT6106_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM = NCT6106_REG_ALARM;
 		data->ALARM_BITS = NCT6106_ALARM_BITS;
+		data->REG_BEEP = NCT6106_REG_BEEP;
+		data->BEEP_BITS = NCT6106_BEEP_BITS;
 
 		reg_temp = NCT6106_REG_TEMP;
 		num_reg_temp = ARRAY_SIZE(NCT6106_REG_TEMP);
@@ -3161,8 +3349,10 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->has_fan_div = true;
 		data->temp_fixed_num = 3;
 		data->num_temp_alarms = 3;
+		data->num_temp_beeps = 3;
 
 		data->ALARM_BITS = NCT6775_ALARM_BITS;
+		data->BEEP_BITS = NCT6775_BEEP_BITS;
 
 		data->fan_from_reg = fan_from_reg16;
 		data->fan_from_reg_min = fan_from_reg8;
@@ -3211,6 +3401,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
 		data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM = NCT6775_REG_ALARM;
+		data->REG_BEEP = NCT6775_REG_BEEP;
 
 		reg_temp = NCT6775_REG_TEMP;
 		num_reg_temp = ARRAY_SIZE(NCT6775_REG_TEMP);
@@ -3228,8 +3419,10 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->has_fan_div = false;
 		data->temp_fixed_num = 3;
 		data->num_temp_alarms = 3;
+		data->num_temp_beeps = 6;
 
 		data->ALARM_BITS = NCT6776_ALARM_BITS;
+		data->BEEP_BITS = NCT6776_BEEP_BITS;
 
 		data->fan_from_reg = fan_from_reg13;
 		data->fan_from_reg_min = fan_from_reg13;
@@ -3278,6 +3471,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
 		data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM = NCT6775_REG_ALARM;
+		data->REG_BEEP = NCT6776_REG_BEEP;
 
 		reg_temp = NCT6775_REG_TEMP;
 		num_reg_temp = ARRAY_SIZE(NCT6775_REG_TEMP);
@@ -3295,8 +3489,10 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->has_fan_div = false;
 		data->temp_fixed_num = 6;
 		data->num_temp_alarms = 2;
+		data->num_temp_beeps = 2;
 
 		data->ALARM_BITS = NCT6779_ALARM_BITS;
+		data->BEEP_BITS = NCT6779_BEEP_BITS;
 
 		data->fan_from_reg = fan_from_reg13;
 		data->fan_from_reg_min = fan_from_reg13;
@@ -3349,6 +3545,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
 		data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM = NCT6779_REG_ALARM;
+		data->REG_BEEP = NCT6776_REG_BEEP;
 
 		reg_temp = NCT6779_REG_TEMP;
 		num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
