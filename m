From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Apr 2007 19:03:22 +0000
Subject: [lm-sensors] [PATCH 4/5] w83781d: Use dynamic sysfs callbacks
Message-Id: <20070407210322.d02ae214.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of some of the macro-generated functions and
shrinks the driver size significantly (about 9%).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |  482 +++++++++++++++++++++--------------------------
 1 file changed, 216 insertions(+), 266 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/w83781d.c	2007-04-07 15:29:14.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/w83781d.c	2007-04-07 15:29:18.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/ioport.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -80,8 +81,8 @@ MODULE_PARM_DESC(init, "Set to zero to b
 #define W83781D_ADDR_REG_OFFSET		5
 #define W83781D_DATA_REG_OFFSET		6
 
-/* The W83781D registers */
-/* The W83782D registers for nr=7,8 are in bank 5 */
+/* The device registers */
+/* in nr from 0 to 8 */
 #define W83781D_REG_IN_MAX(nr)		((nr < 7) ? (0x2b + (nr) * 2) : \
 						    (0x554 + (((nr) - 7) * 2)))
 #define W83781D_REG_IN_MIN(nr)		((nr < 7) ? (0x2c + (nr) * 2) : \
@@ -89,12 +90,14 @@ MODULE_PARM_DESC(init, "Set to zero to b
 #define W83781D_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
 						    (0x550 + (nr) - 7))
 
-#define W83781D_REG_FAN_MIN(nr)		(0x3a + (nr))
-#define W83781D_REG_FAN(nr)		(0x27 + (nr))
+/* fan nr from 0 to 2 */
+#define W83781D_REG_FAN_MIN(nr)		(0x3b + (nr))
+#define W83781D_REG_FAN(nr)		(0x28 + (nr))
 
 #define W83781D_REG_BANK		0x4E
 #define W83781D_REG_TEMP2_CONFIG	0x152
 #define W83781D_REG_TEMP3_CONFIG	0x252
+/* temp nr from 1 to 3 */
 #define W83781D_REG_TEMP(nr)		((nr = 3) ? (0x0250) : \
 					((nr = 2) ? (0x0150) : \
 						     (0x27)))
@@ -132,19 +135,9 @@ MODULE_PARM_DESC(init, "Set to zero to b
 #define W83781D_REG_VBAT		0x5D
 
 /* PWM 782D (1-4) and 783S (1-2) only */
-#define W83781D_REG_PWM1		0x5B	/* 782d and 783s/627hf datasheets disagree */
-						/* on which is which; */
-#define W83781D_REG_PWM2		0x5A	/* We follow the 782d convention here, */
-						/* However 782d is probably wrong. */
-#define W83781D_REG_PWM3		0x5E
-#define W83781D_REG_PWM4		0x5F
+static const u8 W83781D_REG_PWM[] = { 0x5B, 0x5A, 0x5E, 0x5F };
 #define W83781D_REG_PWMCLK12		0x5C
 #define W83781D_REG_PWMCLK34		0x45C
-static const u8 regpwm[] = { W83781D_REG_PWM1, W83781D_REG_PWM2,
-	W83781D_REG_PWM3, W83781D_REG_PWM4
-};
-
-#define W83781D_REG_PWM(nr)		(regpwm[(nr) - 1])
 
 #define W83781D_REG_I2C_ADDR		0x48
 #define W83781D_REG_I2C_SUBADDR		0x4A
@@ -255,7 +248,7 @@ struct w83781d_data {
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[4];		/* Register value */
-	u8 pwmenable[4];	/* Boolean */
+	u8 pwm2_enable;		/* Boolean */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
 				   3000-5000 = thermistor beta.
@@ -297,19 +290,25 @@ static struct platform_driver w83781d_is
 
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
-static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
+		char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = w83781d_update_device(dev); \
-	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf, "%ld\n", \
+		       (long)IN_FROM_REG(data->reg[attr->index])); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
 show_in_reg(in_max);
 
 #define store_in_reg(REG, reg) \
-static ssize_t store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+static ssize_t store_in_##reg (struct device *dev, struct device_attribute \
+		*da, const char *buf, size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
+	int nr = attr->index; \
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
@@ -324,29 +323,13 @@ static ssize_t store_in_##reg (struct de
 store_in_reg(MIN, min);
 store_in_reg(MAX, max);
 
-#define sysfs_in_offset(offset) \
-static ssize_t \
-show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-        return show_in(dev, buf, offset); \
-} \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
-
-#define sysfs_in_reg_offset(reg, offset) \
-static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_in_##reg (dev, buf, offset); \
-} \
-static ssize_t store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_in_##reg (dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset);
-
 #define sysfs_in_offsets(offset) \
-sysfs_in_offset(offset); \
-sysfs_in_reg_offset(min, offset); \
-sysfs_in_reg_offset(max, offset);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
+		show_in, NULL, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
+		show_in_min, store_in_min, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
+		show_in_max, store_in_max, offset)
 
 sysfs_in_offsets(0);
 sysfs_in_offsets(1);
@@ -359,62 +342,56 @@ sysfs_in_offsets(7);
 sysfs_in_offsets(8);
 
 #define show_fan_reg(reg) \
-static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
+		char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = w83781d_update_device(dev); \
 	return sprintf(buf,"%ld\n", \
-		FAN_FROM_REG(data->reg[nr-1], (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
+		FAN_FROM_REG(data->reg[attr->index], \
+			DIV_FROM_REG(data->fan_div[attr->index]))); \
 }
 show_fan_reg(fan);
 show_fan_reg(fan_min);
 
 static ssize_t
-store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
+store_fan_min(struct device *dev, struct device_attribute *da,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
+	int nr = attr->index;
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->fan_min[nr - 1] -	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
+	data->fan_min[nr] +	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	w83781d_write_value(data, W83781D_REG_FAN_MIN(nr),
-			    data->fan_min[nr - 1]);
+			    data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-#define sysfs_fan_offset(offset) \
-static ssize_t show_regs_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_fan(dev, buf, offset); \
-} \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
-
-#define sysfs_fan_min_offset(offset) \
-static ssize_t show_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_fan_min(dev, buf, offset); \
-} \
-static ssize_t store_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_fan_min(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset);
-
-sysfs_fan_offset(1);
-sysfs_fan_min_offset(1);
-sysfs_fan_offset(2);
-sysfs_fan_min_offset(2);
-sysfs_fan_offset(3);
-sysfs_fan_min_offset(3);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
+		show_fan_min, store_fan_min, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO | S_IWUSR,
+		show_fan_min, store_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO | S_IWUSR,
+		show_fan_min, store_fan_min, 2);
 
 #define show_temp_reg(reg) \
-static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
+		char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = w83781d_update_device(dev); \
+	int nr = attr->index; \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		return sprintf(buf,"%d\n", \
 			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
@@ -427,9 +404,12 @@ show_temp_reg(temp_max);
 show_temp_reg(temp_max_hyst);
 
 #define store_temp_reg(REG, reg) \
-static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+static ssize_t store_temp_##reg (struct device *dev, \
+		struct device_attribute *da, const char *buf, size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
+	int nr = attr->index; \
 	s32 val; \
 	 \
 	val = simple_strtol(buf, NULL, 10); \
@@ -452,29 +432,13 @@ static ssize_t store_temp_##reg (struct 
 store_temp_reg(OVER, max);
 store_temp_reg(HYST, max_hyst);
 
-#define sysfs_temp_offset(offset) \
-static ssize_t \
-show_regs_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_temp(dev, buf, offset); \
-} \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
-
-#define sysfs_temp_reg_offset(reg, offset) \
-static ssize_t show_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_temp_##reg (dev, buf, offset); \
-} \
-static ssize_t store_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_temp_##reg (dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
-
 #define sysfs_temp_offsets(offset) \
-sysfs_temp_offset(offset); \
-sysfs_temp_reg_offset(max, offset); \
-sysfs_temp_reg_offset(max_hyst, offset);
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
+		show_temp, NULL, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, \
+		show_temp_max, store_temp_max, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR, \
+		show_temp_max_hyst, store_temp_max_hyst, offset);
 
 sysfs_temp_offsets(1);
 sysfs_temp_offsets(2);
@@ -531,63 +495,64 @@ static ssize_t show_beep_enable (struct 
 	return sprintf(buf, "%ld\n", (long)data->beep_enable);
 }
 
-#define BEEP_ENABLE			0	/* Store beep_enable */
-#define BEEP_MASK			1	/* Store beep_mask */
-
 static ssize_t
-store_beep_reg(struct device *dev, const char *buf, size_t count,
-	       int update_mask)
+store_beep_mask(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	u32 val, val2;
+	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
+	data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
+	w83781d_write_value(data, W83781D_REG_BEEP_INTS1,
+			    data->beep_mask & 0xff);
+	w83781d_write_value(data, W83781D_REG_BEEP_INTS2,
+			    ((data->beep_mask >> 8) & 0x7f)
+			    | data->beep_enable << 7);
+	if (data->type != w83781d && data->type != as99127f) {
+		w83781d_write_value(data, W83781D_REG_BEEP_INTS3,
+				    ((data->beep_mask) >> 16) & 0xff);
+	}
+	mutex_unlock(&data->update_lock);
 
-	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
-		data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
-		w83781d_write_value(data, W83781D_REG_BEEP_INTS1,
-				    data->beep_mask & 0xff);
-
-		if ((data->type != w83781d) && (data->type != as99127f)) {
-			w83781d_write_value(data, W83781D_REG_BEEP_INTS3,
-					    ((data->beep_mask) >> 16) & 0xff);
-		}
+	return count;
+}
 
-		val2 = (data->beep_mask >> 8) & 0x7f;
-	} else {		/* We are storing beep_enable */
-		val2 = w83781d_read_value(data, W83781D_REG_BEEP_INTS2) & 0x7f;
-		data->beep_enable = !!val;
-	}
+static ssize_t
+store_beep_enable(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	u32 val;
 
-	w83781d_write_value(data, W83781D_REG_BEEP_INTS2,
-			    val2 | data->beep_enable << 7);
+	val = simple_strtoul(buf, NULL, 10);
+	if (val != 0 && val != 1)
+		return -EINVAL;
 
+	mutex_lock(&data->update_lock);
+	data->beep_enable = val;
+	val = w83781d_read_value(data, W83781D_REG_BEEP_INTS2) & 0x7f;
+	val |= data->beep_enable << 7;
+	w83781d_write_value(data, W83781D_REG_BEEP_INTS2, val);
 	mutex_unlock(&data->update_lock);
+
 	return count;
 }
 
-#define sysfs_beep(REG, reg) \
-static ssize_t show_regs_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_beep_##reg(dev, attr, buf); \
-} \
-static ssize_t store_regs_beep_##reg (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_beep_reg(dev, buf, count, BEEP_##REG); \
-} \
-static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, show_regs_beep_##reg, store_regs_beep_##reg);
-
-sysfs_beep(ENABLE, enable);
-sysfs_beep(MASK, mask);
+static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
+		show_beep_mask, store_beep_mask);
+static DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
+		show_beep_enable, store_beep_enable);
 
 static ssize_t
-show_fan_div_reg(struct device *dev, char *buf, int nr)
+show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
-		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
+		       (long) DIV_FROM_REG(data->fan_div[attr->index]));
 }
 
 /* Note: we save and restore the fan minimum here, because its value is
@@ -595,10 +560,13 @@ show_fan_div_reg(struct device *dev, cha
    least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
-store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
+store_fan_div(struct device *dev, struct device_attribute *da,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	unsigned long min;
+	int nr = attr->index;
 	u8 reg;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
@@ -625,58 +593,55 @@ store_fan_div_reg(struct device *dev, co
 
 	/* Restore fan_min */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	w83781d_write_value(data, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	w83781d_write_value(data, W83781D_REG_FAN_MIN(nr), data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-#define sysfs_fan_div(offset) \
-static ssize_t show_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_fan_div_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_fan_div_reg(dev, buf, count, offset - 1); \
-} \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset);
-
-sysfs_fan_div(1);
-sysfs_fan_div(2);
-sysfs_fan_div(3);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
+		show_fan_div, store_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
+		show_fan_div, store_fan_div, 1);
+static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO | S_IWUSR,
+		show_fan_div, store_fan_div, 2);
 
 static ssize_t
-show_pwm_reg(struct device *dev, char *buf, int nr)
+show_pwm(struct device *dev, struct device_attribute *da, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long)data->pwm[nr - 1]);
+	return sprintf(buf, "%d\n", (int)data->pwm[attr->index]);
 }
 
 static ssize_t
-show_pwmenable_reg(struct device *dev, char *buf, int nr)
+show_pwm2_enable(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->pwmenable[nr - 1]);
+	return sprintf(buf, "%d\n", (int)data->pwm2_enable);
 }
 
 static ssize_t
-store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
+store_pwm(struct device *dev, struct device_attribute *da, const char *buf,
+		size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
+	int nr = attr->index;
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->pwm[nr - 1] = SENSORS_LIMIT(val, 0, 255);
-	w83781d_write_value(data, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
+	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
+	w83781d_write_value(data, W83781D_REG_PWM[nr], data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
 static ssize_t
-store_pwmenable_reg(struct device *dev, const char *buf, size_t count, int nr)
+store_pwm2_enable(struct device *dev, struct device_attribute *da,
+		const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	u32 val, reg;
@@ -696,7 +661,7 @@ store_pwmenable_reg(struct device *dev, 
 		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG,
 				    (reg & 0xef) | (!val << 4));
 
-		data->pwmenable[nr - 1] = val;
+		data->pwm2_enable = val;
 		break;
 
 	default:
@@ -708,49 +673,29 @@ store_pwmenable_reg(struct device *dev, 
 	return count;
 }
 
-#define sysfs_pwm(offset) \
-static ssize_t show_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_pwm_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
-{ \
-	return store_pwm_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
-		show_regs_pwm_##offset, store_regs_pwm_##offset);
-
-#define sysfs_pwmenable(offset) \
-static ssize_t show_regs_pwmenable_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_pwmenable_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_pwmenable_##offset (struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
-{ \
-	return store_pwmenable_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, \
-		show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
-
-sysfs_pwm(1);
-sysfs_pwm(2);
-sysfs_pwmenable(2);		/* only PWM2 can be enabled/disabled */
-sysfs_pwm(3);
-sysfs_pwm(4);
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm4, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 3);
+/* only PWM2 can be enabled/disabled */
+static DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
+		show_pwm2_enable, store_pwm2_enable);
 
 static ssize_t
-show_sensor_reg(struct device *dev, char *buf, int nr)
+show_sensor(struct device *dev, struct device_attribute *da, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
+	return sprintf(buf, "%d\n", (int)data->sens[attr->index]);
 }
 
 static ssize_t
-store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
+store_sensor(struct device *dev, struct device_attribute *da,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
+	int nr = attr->index;
 	u32 val, tmp;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -761,26 +706,26 @@ store_sensor_reg(struct device *dev, con
 	case 1:		/* PII/Celeron diode */
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		w83781d_write_value(data, W83781D_REG_SCFG1,
-				    tmp | BIT_SCFG1[nr - 1]);
+				    tmp | BIT_SCFG1[nr]);
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG2);
 		w83781d_write_value(data, W83781D_REG_SCFG2,
-				    tmp | BIT_SCFG2[nr - 1]);
-		data->sens[nr - 1] = val;
+				    tmp | BIT_SCFG2[nr]);
+		data->sens[nr] = val;
 		break;
 	case 2:		/* 3904 */
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		w83781d_write_value(data, W83781D_REG_SCFG1,
-				    tmp | BIT_SCFG1[nr - 1]);
+				    tmp | BIT_SCFG1[nr]);
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG2);
 		w83781d_write_value(data, W83781D_REG_SCFG2,
-				    tmp & ~BIT_SCFG2[nr - 1]);
-		data->sens[nr - 1] = val;
+				    tmp & ~BIT_SCFG2[nr]);
+		data->sens[nr] = val;
 		break;
 	case W83781D_DEFAULT_BETA:	/* thermistor */
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		w83781d_write_value(data, W83781D_REG_SCFG1,
-				    tmp & ~BIT_SCFG1[nr - 1]);
-		data->sens[nr - 1] = val;
+				    tmp & ~BIT_SCFG1[nr]);
+		data->sens[nr] = val;
 		break;
 	default:
 		dev_err(dev, "Invalid sensor type %ld; must be 1, 2, or %d\n",
@@ -792,20 +737,12 @@ store_sensor_reg(struct device *dev, con
 	return count;
 }
 
-#define sysfs_sensor(offset) \
-static ssize_t show_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-    return show_sensor_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-    return store_sensor_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, show_regs_sensor_##offset, store_regs_sensor_##offset);
-
-sysfs_sensor(1);
-sysfs_sensor(2);
-sysfs_sensor(3);
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
+	show_sensor, store_sensor, 0);
+static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
+	show_sensor, store_sensor, 0);
+static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
+	show_sensor, store_sensor, 0);
 
 /* I2C devices get this name attribute automatically, but for ISA devices
    we must create it by ourselves. */
@@ -935,20 +872,20 @@ ERROR_SC_0:
 	return err;
 }
 
-#define IN_UNIT_ATTRS(X)			\
-	&dev_attr_in##X##_input.attr,		\
-	&dev_attr_in##X##_min.attr,		\
-	&dev_attr_in##X##_max.attr
-
-#define FAN_UNIT_ATTRS(X)			\
-	&dev_attr_fan##X##_input.attr,		\
-	&dev_attr_fan##X##_min.attr,		\
-	&dev_attr_fan##X##_div.attr
-
-#define TEMP_UNIT_ATTRS(X)			\
-	&dev_attr_temp##X##_input.attr,		\
-	&dev_attr_temp##X##_max.attr,		\
-	&dev_attr_temp##X##_max_hyst.attr
+#define IN_UNIT_ATTRS(X)					\
+	&sensor_dev_attr_in##X##_input.dev_attr.attr,		\
+	&sensor_dev_attr_in##X##_min.dev_attr.attr,		\
+	&sensor_dev_attr_in##X##_max.dev_attr.attr
+
+#define FAN_UNIT_ATTRS(X)					\
+	&sensor_dev_attr_fan##X##_input.dev_attr.attr,		\
+	&sensor_dev_attr_fan##X##_min.dev_attr.attr,		\
+	&sensor_dev_attr_fan##X##_div.dev_attr.attr
+
+#define TEMP_UNIT_ATTRS(X)					\
+	&sensor_dev_attr_temp##X##_input.dev_attr.attr,		\
+	&sensor_dev_attr_temp##X##_max.dev_attr.attr,		\
+	&sensor_dev_attr_temp##X##_max_hyst.dev_attr.attr
 
 static struct attribute* w83781d_attributes[] = {
 	IN_UNIT_ATTRS(0),
@@ -978,14 +915,14 @@ static struct attribute *w83781d_attribu
 	IN_UNIT_ATTRS(7),
 	IN_UNIT_ATTRS(8),
 	TEMP_UNIT_ATTRS(3),
-	&dev_attr_pwm1.attr,
-	&dev_attr_pwm2.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
 	&dev_attr_pwm2_enable.attr,
-	&dev_attr_pwm3.attr,
-	&dev_attr_pwm4.attr,
-	&dev_attr_temp1_type.attr,
-	&dev_attr_temp2_type.attr,
-	&dev_attr_temp3_type.attr,
+	&sensor_dev_attr_temp1_type.dev_attr.attr,
+	&sensor_dev_attr_temp2_type.dev_attr.attr,
+	&sensor_dev_attr_temp3_type.dev_attr.attr,
 	NULL
 };
 static const struct attribute_group w83781d_group_opt = {
@@ -1002,48 +939,64 @@ w83781d_create_files(struct device *dev,
 		return err;
 
 	if (kind != w83783s) {
-		if ((err = device_create_file(dev, &dev_attr_in1_input))
-		    || (err = device_create_file(dev, &dev_attr_in1_min))
-		    || (err = device_create_file(dev, &dev_attr_in1_max)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_in1_input.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in1_min.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in1_max.dev_attr)))
 			return err;
 	}
 	if (kind != as99127f && kind != w83781d && kind != w83783s) {
-		if ((err = device_create_file(dev, &dev_attr_in7_input))
-		    || (err = device_create_file(dev, &dev_attr_in7_min))
-		    || (err = device_create_file(dev, &dev_attr_in7_max))
-		    || (err = device_create_file(dev, &dev_attr_in8_input))
-		    || (err = device_create_file(dev, &dev_attr_in8_min))
-		    || (err = device_create_file(dev, &dev_attr_in8_max)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_in7_input.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in7_min.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in7_max.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in8_input.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in8_min.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_in8_max.dev_attr)))
 			return err;
 	}
 	if (kind != w83783s) {
-		if ((err = device_create_file(dev, &dev_attr_temp3_input))
-		    || (err = device_create_file(dev, &dev_attr_temp3_max))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_temp3_input.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_temp3_max.dev_attr))
 		    || (err = device_create_file(dev,
-						 &dev_attr_temp3_max_hyst)))
+				&sensor_dev_attr_temp3_max_hyst.dev_attr)))
 			return err;
 	}
 
 	if (kind != w83781d && kind != as99127f) {
-		if ((err = device_create_file(dev, &dev_attr_pwm1))
-		    || (err = device_create_file(dev, &dev_attr_pwm2))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_pwm1.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_pwm2.dev_attr))
 		    || (err = device_create_file(dev, &dev_attr_pwm2_enable)))
 			return err;
 	}
 	if (kind = w83782d && !is_isa) {
-		if ((err = device_create_file(dev, &dev_attr_pwm3))
-		    || (err = device_create_file(dev, &dev_attr_pwm4)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_pwm3.dev_attr))
+		    || (err = device_create_file(dev,
+		    		&sensor_dev_attr_pwm4.dev_attr)))
 			return err;
 	}
 
 	if (kind != as99127f && kind != w83781d) {
-		if ((err = device_create_file(dev, &dev_attr_temp1_type))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_temp1_type.dev_attr))
 		    || (err = device_create_file(dev,
-						 &dev_attr_temp2_type)))
+				&sensor_dev_attr_temp2_type.dev_attr)))
 			return err;
 		if (kind != w83783s) {
 			if ((err = device_create_file(dev,
-						      &dev_attr_temp3_type)))
+					&sensor_dev_attr_temp3_type.dev_attr)))
 				return err;
 		}
 	}
@@ -1571,13 +1524,10 @@ w83781d_init_device(struct device *dev)
 			    | 0x01);
 
 	/* A few vars need to be filled upon startup */
-	for (i = 1; i <= 3; i++) {
-		data->fan_min[i - 1] = w83781d_read_value(data,
+	for (i = 0; i < 3; i++) {
+		data->fan_min[i] = w83781d_read_value(data,
 					W83781D_REG_FAN_MIN(i));
 	}
-	if (type != w83781d && type != as99127f)
-		for (i = 0; i < 4; i++)
-			data->pwmenable[i] = 1;
 
 	mutex_init(&data->update_lock);
 }
@@ -1607,23 +1557,23 @@ static struct w83781d_data *w83781d_upda
 			    && (data->type != w83627hf) && (i = 6))
 				break;
 		}
-		for (i = 1; i <= 3; i++) {
-			data->fan[i - 1] +		for (i = 0; i < 3; i++) {
+			data->fan[i]  			    w83781d_read_value(data, W83781D_REG_FAN(i));
-			data->fan_min[i - 1] +			data->fan_min[i]  			    w83781d_read_value(data, W83781D_REG_FAN_MIN(i));
 		}
 		if (data->type != w83781d && data->type != as99127f) {
-			for (i = 1; i <= 4; i++) {
-				data->pwm[i - 1] +			for (i = 0; i < 4; i++) {
+				data->pwm[i]  				    w83781d_read_value(data,
-						       W83781D_REG_PWM(i));
+						       W83781D_REG_PWM[i]);
 				if ((data->type != w83782d || !client->driver)
-				    && i = 2)
+				    && i = 1)
 					break;
 			}
 			/* Only PWM2 can be disabled */
-			data->pwmenable[1] = (w83781d_read_value(data,
+			data->pwm2_enable = (w83781d_read_value(data,
 					      W83781D_REG_PWMCLK12) & 0x08) >> 3;
 		}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
