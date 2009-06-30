From: Ira Snyder <iws@ovro.caltech.edu>
Date: Tue, 30 Jun 2009 18:39:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1031) Add sysfs files for
Message-Id: <20090630183918.GA3322@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ADM1030/ADM1031 chips have temperature offset registers, for both the
local and remote temperature sensors. Following the example set forth in
the LM90/ADM1032 driver, expose the offset registers to userspace.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

I have tested this with an adm1031 chip, and I see the offsets as
expected. I do not have any other compatible chips to test with, however
I read the adm1030 datasheet, and everything should work fine.

On the adm1031, the datasheet claims the offset registers can be used to
add/subtract 15 degC from the temperature reading. I have found that it
is actually possible to add 15 degC and subtract 16 degC. Following the
data sheet, I clamped the value to +- 15 degC, just in case other chips
are not compatible.

 drivers/hwmon/adm1031.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 7894418..5690595 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -37,6 +37,7 @@
 #define ADM1031_REG_PWM			(0x22)
 #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))
 
+#define ADM1031_REG_TEMP_OFFSET(nr)	(0x0d + (nr))
 #define ADM1031_REG_TEMP_MAX(nr)	(0x14 + 4 * (nr))
 #define ADM1031_REG_TEMP_MIN(nr)	(0x15 + 4 * (nr))
 #define ADM1031_REG_TEMP_CRIT(nr)	(0x16 + 4 * (nr))
@@ -93,6 +94,7 @@ struct adm1031_data {
 	u8 auto_temp_min[3];
 	u8 auto_temp_off[3];
 	u8 auto_temp_max[3];
+	s8 temp_offset[3];
 	s8 temp_min[3];
 	s8 temp_max[3];
 	s8 temp_crit[3];
@@ -145,6 +147,10 @@ adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
 
 #define TEMP_FROM_REG_EXT(val, ext)	(TEMP_FROM_REG(val) + (ext) * 125)
 
+#define TEMP_OFFSET_TO_REG(val)		(TEMP_TO_REG(val) & 0x8f)
+#define TEMP_OFFSET_FROM_REG(val)	TEMP_FROM_REG((val) < 0 ? \
+						      (val) | 0x70 : (val))
+
 #define FAN_FROM_REG(reg, div)		((reg) ? (11250 * 60) / ((reg) * (div)) : 0)
 
 static int FAN_TO_REG(int reg, int div)
@@ -585,6 +591,14 @@ static ssize_t show_temp(struct device *dev,
 	    (((data->ext_temp[nr] >> ((nr - 1) * 3)) & 7));
 	return sprintf(buf, "%d\n", TEMP_FROM_REG_EXT(data->temp[nr], ext));
 }
+static ssize_t show_temp_offset(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct adm1031_data *data = adm1031_update_device(dev);
+	return sprintf(buf, "%d\n",
+		       TEMP_OFFSET_FROM_REG(data->temp_offset[nr]));
+}
 static ssize_t show_temp_min(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -606,6 +620,24 @@ static ssize_t show_temp_crit(struct device *dev,
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[nr]));
 }
+static ssize_t set_temp_offset(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
+	int val;
+
+	val = simple_strtol(buf, NULL, 10);
+	val = SENSORS_LIMIT(val, -15000, 15000);
+	mutex_lock(&data->update_lock);
+	data->temp_offset[nr] = TEMP_OFFSET_TO_REG(val);
+	adm1031_write_value(client, ADM1031_REG_TEMP_OFFSET(nr),
+			    data->temp_offset[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
 static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
@@ -661,6 +693,8 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 #define temp_reg(offset)						\
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
 		show_temp, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,	\
+		show_temp_offset, set_temp_offset, offset - 1);		\
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
 		show_temp_min, set_temp_min, offset - 1);		\
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
@@ -714,6 +748,7 @@ static struct attribute *adm1031_attributes[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_auto_fan1_channel.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
@@ -721,6 +756,7 @@ static struct attribute *adm1031_attributes[] = {
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
@@ -757,6 +793,7 @@ static struct attribute *adm1031_attributes_opt[] = {
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_auto_fan2_channel.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
@@ -937,6 +974,9 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
 			}
 			data->temp[chan] = newh;
 
+			data->temp_offset[chan] +			    adm1031_read_value(client,
+					       ADM1031_REG_TEMP_OFFSET(chan));
 			data->temp_min[chan]  			    adm1031_read_value(client,
 					       ADM1031_REG_TEMP_MIN(chan));
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
