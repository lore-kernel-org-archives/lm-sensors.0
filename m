From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 08 Jul 2007 00:59:51 +0000
Subject: [lm-sensors] [ patch ]  de-macro-fy w83627hf.c
Message-Id: <46903707.4000300@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090708050605090105060502"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090708050605090105060502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All, Mark,

w83627hf.c has lots of macros which generate repetetive sysfs callback 
functions.

Attached patch replaces most of them, and upgrades several DEVICE_ATTR
declarations with SENSOR_DEVICE_ATTRs as needed to determine which
the callbacks need to determine which sensor-number is being accessed.

Patched driver works on my W83627HF equipped AMD-Barton MOBO.

If you have one of the other parts supported by this board, please test 
this patch
and let me know.  (ie Ack/Nack this and subsequent revisions)


WRT Submission:

1 - the patch is getting big, so Id like to hear whether its acceptable 
in one big lump.

 diffstat diff.hwmon-w83627hf-demacro-sysfs-callbacks
 w83627hf.c |  516 
++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 254 insertions(+), 262 deletions(-)

If I should break it up, Id probably do it on VIN, FAN, PWM, TEMP 
boundaries,
unless you have other thoughts.


2 - checkpatch complains about a few things - and fixing them would 
enlarge the patch,
and thus may qualify for separation (or ignoring)

line over 80 characters
#27: FILE: drivers/hwmon/w83627hf.c:422:
+static ssize_t show_in_input(struct device *dev, struct 
device_attribute *devattr, char *buf)

IIUC, Linus thinks this check is somewhat nazi-ish (his word), and I 
recall that some people
prefer to have the entire function-signature on a single line (grep 
friendly)

Macros with multiple statements should be enclosed in a do - while loop
#76: FILE: drivers/hwmon/w83627hf.c:471:
+#define vin_decl(offset)       \
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,                 \

Ive stuffed repetetive declarations and initializations into macros,
and this warning is unavoidable for those uses.



--------------090708050605090105060502
Content-Type: text/plain;
 name="diff.hwmon-w83627hf-demacro-sysfs-callbacks"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="diff.hwmon-w83627hf-demacro-sysfs-callbacks"

diff -ruNp -X dontdiff -X exclude-diffs lx-22rc7-hwmon/drivers/hwmon/w83627hf.c lx-22rc7-hwmon-slim/drivers/hwmon/w83627hf.c
--- lx-22rc7-hwmon/drivers/hwmon/w83627hf.c	2007-07-01 13:54:24.000000000 -0600
+++ lx-22rc7-hwmon-slim/drivers/hwmon/w83627hf.c	2007-07-07 17:50:16.000000000 -0600
@@ -45,6 +45,7 @@
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -347,75 +348,73 @@ static struct platform_driver w83627hf_d
 	.remove		= __devexit_p(w83627hf_remove),
 };
 
-/* following are the sysfs callback functions */
-#define show_in_reg(reg) \
-static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
-{ \
-	struct w83627hf_data *data = w83627hf_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->in[attr->index]));
+}
+static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->in_min[attr->index]));
+}
+static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->in_max[attr->index]));
 }
-show_in_reg(in)
-show_in_reg(in_min)
-show_in_reg(in_max)
 
-#define store_in_reg(REG, reg) \
-static ssize_t \
-store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
-{ \
-	struct w83627hf_data *data = dev_get_drvdata(dev); \
-	u32 val; \
-	 \
-	val = simple_strtoul(buf, NULL, 10); \
-	 \
-	mutex_lock(&data->update_lock); \
-	data->in_##reg[nr] = IN_TO_REG(val); \
-	w83627hf_write_value(data, W83781D_REG_IN_##REG(nr), \
-			    data->in_##reg[nr]); \
-	 \
-	mutex_unlock(&data->update_lock); \
-	return count; \
+static ssize_t store_in_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+			  size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->in_min[attr->index] = IN_TO_REG(val);
+	w83627hf_write_value(data, W83781D_REG_IN_MIN(attr->index), data->in_min[attr->index]);
+
+	mutex_unlock(&data->update_lock);
+	return count;
 }
-store_in_reg(MIN, min)
-store_in_reg(MAX, max)
 
-#define sysfs_in_offset(offset) \
-static ssize_t \
-show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-        return show_in(dev, buf, offset); \
-} \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
+static ssize_t store_in_max(struct device *dev, struct device_attribute *devattr, const char *buf,
+			  size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+	long val = simple_strtol(buf, NULL, 10);
 
-#define sysfs_in_reg_offset(reg, offset) \
-static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_in_##reg (dev, buf, offset); \
-} \
-static ssize_t \
-store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, \
-			    const char *buf, size_t count) \
-{ \
-	return store_in_##reg (dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
-		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
+	mutex_lock(&data->update_lock);
+	data->in_max[attr->index] = IN_TO_REG(val);
+	w83627hf_write_value(data, W83781D_REG_IN_MAX(attr->index), data->in_max[attr->index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
 
-#define sysfs_in_offsets(offset) \
-sysfs_in_offset(offset) \
-sysfs_in_reg_offset(min, offset) \
-sysfs_in_reg_offset(max, offset)
-
-sysfs_in_offsets(1);
-sysfs_in_offsets(2);
-sysfs_in_offsets(3);
-sysfs_in_offsets(4);
-sysfs_in_offsets(5);
-sysfs_in_offsets(6);
-sysfs_in_offsets(7);
-sysfs_in_offsets(8);
+#define vin_decl(offset)	\
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
+			  show_in_input, NULL, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+			  show_in_min, store_in_min, offset);	\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+			  show_in_max, store_in_max, offset);
+
+vin_decl(1);
+vin_decl(2);
+vin_decl(3);
+vin_decl(4);
+vin_decl(5);
+vin_decl(6);
+vin_decl(7);
+vin_decl(8);
 
 /* use a different set of functions for in0 */
-static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
+static ssize_t _show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
 {
 	long in0;
 
@@ -432,26 +431,26 @@ static ssize_t show_in_0(struct w83627hf
 	return sprintf(buf,"%ld\n", in0);
 }
 
-static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in_0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return show_in_0(data, buf, data->in[0]);
+	return _show_in_0(data, buf, data->in[0]);
 }
 
-static ssize_t show_regs_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return show_in_0(data, buf, data->in_min[0]);
+	return _show_in_0(data, buf, data->in_min[0]);
 }
 
-static ssize_t show_regs_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return show_in_0(data, buf, data->in_max[0]);
+	return _show_in_0(data, buf, data->in_max[0]);
 }
 
-static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t store_in_min0(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
@@ -477,8 +476,8 @@ static ssize_t store_regs_in_min0(struct
 	return count;
 }
 
-static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t store_in_max0(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
@@ -504,70 +503,58 @@ static ssize_t store_regs_in_max0(struct
 	return count;
 }
 
-static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL);
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in_0, NULL);
 static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
-	show_regs_in_min0, store_regs_in_min0);
+	show_in_min0, store_in_min0);
 static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
-	show_regs_in_max0, store_regs_in_max0);
+	show_in_max0, store_in_max0);
 
-#define show_fan_reg(reg) \
-static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
-{ \
-	struct w83627hf_data *data = w83627hf_update_device(dev); \
-	return sprintf(buf,"%ld\n", \
-		FAN_FROM_REG(data->reg[nr-1], \
-			    (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
+static ssize_t show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)FAN_FROM_REG(data->fan[attr->index-1],
+					(long)DIV_FROM_REG(data->fan_div[attr->index-1])));
+}
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)FAN_FROM_REG(data->fan_min[attr->index-1],
+					(long)DIV_FROM_REG(data->fan_div[attr->index-1])));
 }
-show_fan_reg(fan);
-show_fan_reg(fan_min);
-
 static ssize_t
-store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
+store_fan_min (struct device *dev, struct device_attribute *devattr,
+	       const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->fan_min[nr - 1] =
-	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
-	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr),
-			    data->fan_min[nr - 1]);
+	data->fan_min[attr->index - 1] =
+	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[attr->index - 1]));
+	w83627hf_write_value(data, W83781D_REG_FAN_MIN(attr->index),
+			    data->fan_min[attr->index - 1]);
 
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
-static ssize_t \
-store_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_fan_min(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		  show_regs_fan_min##offset, store_regs_fan_min##offset);
-
-sysfs_fan_offset(1);
-sysfs_fan_min_offset(1);
-sysfs_fan_offset(2);
-sysfs_fan_min_offset(2);
-sysfs_fan_offset(3);
-sysfs_fan_min_offset(3);
+#define sysfs_fan_decl(offset)	\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+			  show_fan_input, NULL, offset);		\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+			  show_fan_min, store_fan_min, offset);
+
+sysfs_fan_decl(1);
+sysfs_fan_decl(2);
+sysfs_fan_decl(3);
 
 #define show_temp_reg(reg) \
-static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+static ssize_t _show_##reg (struct device *dev, char *buf, int nr) \
 { \
 	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
@@ -583,7 +570,7 @@ show_temp_reg(temp_max_hyst);
 
 #define store_temp_reg(REG, reg) \
 static ssize_t \
-store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+_store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
 	struct w83627hf_data *data = dev_get_drvdata(dev); \
 	u32 val; \
@@ -608,36 +595,52 @@ store_temp_##reg (struct device *dev, co
 store_temp_reg(OVER, max);
 store_temp_reg(HYST, max_hyst);
 
-#define sysfs_temp_offset(offset) \
-static ssize_t \
-show_regs_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_temp(dev, buf, offset); \
-} \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
+static ssize_t
+show_temp (struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return _show_temp(dev, buf, attr->index);
+}
 
-#define sysfs_temp_reg_offset(reg, offset) \
-static ssize_t show_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_temp_##reg (dev, buf, offset); \
-} \
-static ssize_t \
-store_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, \
-			      const char *buf, size_t count) \
-{ \
-	return store_temp_##reg (dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
-		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
+static ssize_t show_temp_max (struct device *dev,
+				   struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return _show_temp_max (dev, buf, attr->index);
+}
+static ssize_t show_temp_max_hyst (struct device *dev,
+					struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return _show_temp_max_hyst (dev, buf, attr->index);
+}
+
+static ssize_t
+store_temp_max (struct device *dev, struct device_attribute *devattr,
+		     const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return _store_temp_max (dev, buf, count, attr->index);
+}
+static ssize_t
+store_temp_max_hyst (struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return _store_temp_max_hyst (dev, buf, count, attr->index);
+}
 
-#define sysfs_temp_offsets(offset) \
-sysfs_temp_offset(offset) \
-sysfs_temp_reg_offset(max, offset) \
-sysfs_temp_reg_offset(max_hyst, offset)
-
-sysfs_temp_offsets(1);
-sysfs_temp_offsets(2);
-sysfs_temp_offsets(3);
+#define temp_decl(offset) \
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, 		\
+			  show_temp, NULL, offset);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 	\
+			  show_temp_max, store_temp_max, offset);	\
+static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR,	\
+			  show_temp_max_hyst, store_temp_max_hyst, offset);
+
+temp_decl(1);
+temp_decl(2);
+temp_decl(3);
 
 static ssize_t
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -654,7 +657,8 @@ show_vrm_reg(struct device *dev, struct 
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
@@ -780,23 +784,25 @@ store_fan_div_reg(struct device *dev, co
 	return count;
 }
 
-#define sysfs_fan_div(offset) \
-static ssize_t show_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_fan_div_reg(dev, buf, offset); \
-} \
-static ssize_t \
-store_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, \
-			    const char *buf, size_t count) \
-{ \
-	return store_fan_div_reg(dev, buf, count, offset - 1); \
-} \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		  show_regs_fan_div_##offset, store_regs_fan_div_##offset);
+static ssize_t show_fan_div (struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return show_fan_div_reg(dev, buf, attr->index);
+}
+static ssize_t
+store_fan_div (struct device *dev, struct device_attribute *devattr,
+		    const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return store_fan_div_reg(dev, buf, count, attr->index - 1);
+}
 
-sysfs_fan_div(1);
-sysfs_fan_div(2);
-sysfs_fan_div(3);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR, \
+		   show_fan_div, store_fan_div, 1);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR, \
+		   show_fan_div, store_fan_div, 2);
+static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO | S_IWUSR, \
+		   show_fan_div, store_fan_div, 3);
 
 static ssize_t
 show_pwm_reg(struct device *dev, char *buf, int nr)
@@ -834,22 +840,24 @@ store_pwm_reg(struct device *dev, const 
 	return count;
 }
 
-#define sysfs_pwm(offset) \
-static ssize_t show_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_pwm_reg(dev, buf, offset); \
-} \
-static ssize_t \
-store_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_pwm_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
-		  show_regs_pwm_##offset, store_regs_pwm_##offset);
+static ssize_t show_pwm (struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return show_pwm_reg(dev, buf, attr->index);
+}
+static ssize_t
+store_pwm (struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return store_pwm_reg(dev, buf, count, attr->index);
+}
 
-sysfs_pwm(1);
-sysfs_pwm(2);
-sysfs_pwm(3);
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, \
+			  show_pwm, store_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, \
+			  show_pwm, store_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, \
+			  show_pwm, store_pwm, 3);
 
 static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
@@ -904,22 +912,25 @@ store_sensor_reg(struct device *dev, con
 	return count;
 }
 
-#define sysfs_sensor(offset) \
-static ssize_t show_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-    return show_sensor_reg(dev, buf, offset); \
-} \
-static ssize_t \
-store_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-    return store_sensor_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
-		  show_regs_sensor_##offset, store_regs_sensor_##offset);
+static ssize_t show_sensor (struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return show_sensor_reg(dev, buf, attr->index);
+}
+static ssize_t
+store_sensor (struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return store_sensor_reg(dev, buf, count, attr->index);
+}
+
+#define sensor_decl(offset) \
+static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
+			  show_sensor, store_sensor, offset);
 
-sysfs_sensor(1);
-sysfs_sensor(2);
-sysfs_sensor(3);
+sensor_decl(1);
+sensor_decl(2);
+sensor_decl(3);
 
 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
@@ -1004,48 +1015,43 @@ static int __init w83627hf_find(int sioa
 	return err;
 }
 
+#define VIN_UNIT_ATTRS(X)	\
+	&sensor_dev_attr_in##X##_input.dev_attr.attr,	    \
+	&sensor_dev_attr_in##X##_min.dev_attr.attr,	    \
+	&sensor_dev_attr_in##X##_max.dev_attr.attr
+
+#define FAN_UNIT_ATTRS(X)	\
+	&sensor_dev_attr_fan##X##_input.dev_attr.attr,	    \
+	&sensor_dev_attr_fan##X##_min.dev_attr.attr,	    \
+	&sensor_dev_attr_fan##X##_div.dev_attr.attr
+
+#define TEMP_UNIT_ATTRS(X)	\
+	&sensor_dev_attr_temp##X##_input.dev_attr.attr,		\
+	&sensor_dev_attr_temp##X##_max.dev_attr.attr,		\
+	&sensor_dev_attr_temp##X##_max_hyst.dev_attr.attr,	\
+	&sensor_dev_attr_temp##X##_type.dev_attr.attr
+
 static struct attribute *w83627hf_attributes[] = {
 	&dev_attr_in0_input.attr,
 	&dev_attr_in0_min.attr,
 	&dev_attr_in0_max.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in2_max.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in3_max.attr,
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
-	&dev_attr_in7_input.attr,
-	&dev_attr_in7_min.attr,
-	&dev_attr_in7_max.attr,
-	&dev_attr_in8_input.attr,
-	&dev_attr_in8_min.attr,
-	&dev_attr_in8_max.attr,
-
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan2_div.attr,
-
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_max_hyst.attr,
-	&dev_attr_temp1_type.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_max_hyst.attr,
-	&dev_attr_temp2_type.attr,
+
+	VIN_UNIT_ATTRS(2),
+	VIN_UNIT_ATTRS(3),
+	VIN_UNIT_ATTRS(4),
+	VIN_UNIT_ATTRS(7),
+	VIN_UNIT_ATTRS(8),
+	FAN_UNIT_ATTRS(1),
+	FAN_UNIT_ATTRS(2),
+	TEMP_UNIT_ATTRS(1),
+	TEMP_UNIT_ATTRS(2),
 
 	&dev_attr_alarms.attr,
 	&dev_attr_beep_enable.attr,
 	&dev_attr_beep_mask.attr,
 
-	&dev_attr_pwm1.attr,
-	&dev_attr_pwm2.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
 
 	&dev_attr_name.attr,
 	NULL
@@ -1056,27 +1062,13 @@ static const struct attribute_group w836
 };
 
 static struct attribute *w83627hf_attributes_opt[] = {
-	&dev_attr_in1_input.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in1_max.attr,
-	&dev_attr_in5_input.attr,
-	&dev_attr_in5_min.attr,
-	&dev_attr_in5_max.attr,
-	&dev_attr_in6_input.attr,
-	&dev_attr_in6_min.attr,
-	&dev_attr_in6_max.attr,
-
-	&dev_attr_fan3_input.attr,
-	&dev_attr_fan3_min.attr,
-	&dev_attr_fan3_div.attr,
-
-	&dev_attr_temp3_input.attr,
-	&dev_attr_temp3_max.attr,
-	&dev_attr_temp3_max_hyst.attr,
-	&dev_attr_temp3_type.attr,
-
-	&dev_attr_pwm3.attr,
+	VIN_UNIT_ATTRS(1),
+	VIN_UNIT_ATTRS(5),
+	VIN_UNIT_ATTRS(6),
+	FAN_UNIT_ATTRS(3),
+	TEMP_UNIT_ATTRS(3),
 
+	&sensor_dev_attr_pwm3.dev_attr.attr,
 	NULL
 };
 
@@ -1134,25 +1126,25 @@ static int __devinit w83627hf_probe(stru
 
 	/* Register chip-specific device attributes */
 	if (data->type == w83627hf || data->type == w83697hf)
-		if ((err = device_create_file(dev, &dev_attr_in5_input))
-		 || (err = device_create_file(dev, &dev_attr_in5_min))
-		 || (err = device_create_file(dev, &dev_attr_in5_max))
-		 || (err = device_create_file(dev, &dev_attr_in6_input))
-		 || (err = device_create_file(dev, &dev_attr_in6_min))
-		 || (err = device_create_file(dev, &dev_attr_in6_max)))
+		if ((err = device_create_file(dev, &sensor_dev_attr_in5_input.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_in5_min.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_in5_max.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_in6_input.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_in6_min.dev_attr))
+		    || (err = device_create_file(dev, &sensor_dev_attr_in6_max.dev_attr)))
 			goto ERROR4;
 
 	if (data->type != w83697hf)
-		if ((err = device_create_file(dev, &dev_attr_in1_input))
-		 || (err = device_create_file(dev, &dev_attr_in1_min))
-		 || (err = device_create_file(dev, &dev_attr_in1_max))
-		 || (err = device_create_file(dev, &dev_attr_fan3_input))
-		 || (err = device_create_file(dev, &dev_attr_fan3_min))
-		 || (err = device_create_file(dev, &dev_attr_fan3_div))
-		 || (err = device_create_file(dev, &dev_attr_temp3_input))
-		 || (err = device_create_file(dev, &dev_attr_temp3_max))
-		 || (err = device_create_file(dev, &dev_attr_temp3_max_hyst))
-		 || (err = device_create_file(dev, &dev_attr_temp3_type)))
+		if ((err = device_create_file(dev, &sensor_dev_attr_in1_input.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_in1_min.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_in1_max.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_fan3_input.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_fan3_min.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_fan3_div.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_temp3_input.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_temp3_max.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_temp3_max_hyst.dev_attr))
+		 || (err = device_create_file(dev, &sensor_dev_attr_temp3_type.dev_attr)))
 			goto ERROR4;
 
 	if (data->type != w83697hf && data->vid != 0xff) {
@@ -1166,7 +1158,7 @@ static int __devinit w83627hf_probe(stru
 
 	if (data->type == w83627thf || data->type == w83637hf
 	 || data->type == w83687thf)
-		if ((err = device_create_file(dev, &dev_attr_pwm3)))
+		if ((err = device_create_file(dev, &sensor_dev_attr_pwm3.dev_attr)))
 			goto ERROR4;
 
 	data->class_dev = hwmon_device_register(dev);

--------------090708050605090105060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090708050605090105060502--
