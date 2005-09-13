From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 13 Sep 2005 08:41:37 +0000
Subject: [lm-sensors] PATCH adm9240 driver update, convert to dynamic sysfs
Message-Id: <51tci1tdqq2m3olisda9eddgru06ol7bfg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch updates the adm9240 driver:
o  remove half-bit offset from scaled zero value
o  remove i2c read/write wrappers
o  convert kmalloc + memset calls to kzalloc
o  convert temperature, voltage and fan accessors to dynamic sysfs callbacks 
   which shrinks driver memory footprint from 16472 to 14264 bytes.

Depends on adm9240 whitespace cleanup patch submitted earlier.

Run tested.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |  400 +++++++++++++++++++++++++++++---------------------------------
 1 files changed, 191 insertions(+), 209 deletions(-)

--- linux-2.6.13-mm3b/drivers/hwmon/adm9240.c	2005-09-13 12:12:54.000000000 +1000
+++ linux-2.6.13-mm3d/drivers/hwmon/adm9240.c	2005-09-13 15:26:00.000000000 +1000
@@ -45,6 +45,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
@@ -69,8 +70,7 @@ I2C_CLIENT_INSMOD_3(adm9240, ds1780, lm8
 #define ADM9240_REG_INT(nr)		(0x41 + (nr))
 #define ADM9240_REG_INT_MASK(nr)	(0x43 + (nr))
 #define ADM9240_REG_TEMP		0x27
-#define ADM9240_REG_TEMP_HIGH		0x39
-#define ADM9240_REG_TEMP_HYST		0x3a
+#define ADM9240_REG_TEMP_MAX(nr)	(0x39 + (nr))	/* 0..1 */
 #define ADM9240_REG_ANALOG_OUT		0x19
 #define ADM9240_REG_CHASSIS_CLEAR	0x46
 #define ADM9240_REG_VID_FAN_DIV		0x47
@@ -81,6 +81,8 @@ I2C_CLIENT_INSMOD_3(adm9240, ds1780, lm8
 /* generalised scaling with integer rounding */
 static inline int SCALE(long val, int mul, int div)
 {
+	if (val = 0)
+		return 0;
 	if (val < 0)
 		return (val * mul - div / 2) / div;
 	else
@@ -162,177 +164,153 @@ struct adm9240_data {
 	u8 fan_min[2];		/* rw	fan1_min */
 	u8 fan_div[2];		/* rw	fan1_div, read-only accessor */
 	s16 temp;		/* ro	temp1_input, 9-bit sign-extended */
-	s8 temp_high;		/* rw	temp1_max */
-	s8 temp_hyst;		/* rw	temp1_max_hyst */
+	s8 temp_max[2];		/* rw	0 -> temp_max, 1 -> temp_max_hyst */
 	u16 alarms;		/* ro	alarms */
 	u8 aout;		/* rw	aout_output */
 	u8 vid;			/* ro	vid */
 	u8 vrm;			/* --	vrm set on startup, no accessor */
 };
 
-/* i2c byte read/write interface */
-static int adm9240_read_value(struct i2c_client *client, u8 reg)
+/*** sysfs accessors ***/
+
+/* temperature */
+static ssize_t show_temp(struct device *dev, struct device_attribute *dummy,
+		char *buf)
 {
-	return i2c_smbus_read_byte_data(client, reg);
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", data->temp * 500); /* 9-bit value */
 }
 
-static int adm9240_write_value(struct i2c_client *client, u8 reg, u8 value)
+static ssize_t show_max(struct device *dev, struct device_attribute *devattr,
+		char *buf)
 {
-	return i2c_smbus_write_byte_data(client, reg, value);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", data->temp_max[attr->index] * 1000);
 }
 
-/*** sysfs accessors ***/
+static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_max[attr->index] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_TEMP_MAX(attr->index),
+			data->temp_max[attr->index]);
+	up(&data->update_lock);
+	return count;
+}
 
-/* temperature */
-#define show_temp(value, scale)					\
-static ssize_t show_##value(struct device *dev,			\
-			    struct device_attribute *attr,	\
-			    char *buf)				\
-{								\
-	struct adm9240_data *data = adm9240_update_device(dev);	\
-	return sprintf(buf, "%d\n", data->value * scale);	\
-}
-show_temp(temp_high, 1000);
-show_temp(temp_hyst, 1000);
-show_temp(temp, 500); /* 0.5'C per bit */
-
-#define set_temp(value, reg)					\
-static ssize_t set_##value(struct device *dev, 			\
-			   struct device_attribute *attr,	\
-			   const char *buf, size_t count)	\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct adm9240_data *data = adm9240_update_device(dev);	\
-	long temp = simple_strtoul(buf, NULL, 10);		\
-								\
-	down(&data->update_lock);				\
-	data->value = TEMP_TO_REG(temp);			\
-	adm9240_write_value(client, reg, data->value);		\
-	up(&data->update_lock);					\
-	return count;						\
-}
-
-set_temp(temp_high, ADM9240_REG_TEMP_HIGH);
-set_temp(temp_hyst, ADM9240_REG_TEMP_HYST);
-
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-		show_temp_high, set_temp_high);
-static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
-		show_temp_hyst, set_temp_hyst);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
+		show_max, set_max, 0);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
+		show_max, set_max, 1);
 
 /* voltage */
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
+		char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr], nr));
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[attr->index],
+				attr->index));
 }
 
-static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr,
+		char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr], nr));
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[attr->index],
+				attr->index));
 }
 
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr,
+		char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr], nr));
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[attr->index],
+				attr->index));
 }
 
-static ssize_t set_in_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_min[nr] = IN_TO_REG(val, nr);
-	adm9240_write_value(client, ADM9240_REG_IN_MIN(nr), data->in_min[nr]);
+	data->in_min[attr->index] = IN_TO_REG(val, attr->index);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MIN(attr->index),
+			data->in_min[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
 
-static ssize_t set_in_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_max[nr] = IN_TO_REG(val, nr);
-	adm9240_write_value(client, ADM9240_REG_IN_MAX(nr), data->in_max[nr]);
+	data->in_max[attr->index] = IN_TO_REG(val, attr->index);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MAX(attr->index),
+			data->in_max[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
 
-#define show_in_offset(offset)						\
-static ssize_t show_in##offset(struct device *dev,			\
-			       struct device_attribute *attr,		\
-			       char *buf)				\
-{									\
-	return show_in(dev, buf, offset);				\
-}									\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);	\
-static ssize_t show_in##offset##_min(struct device *dev,		\
-				     struct device_attribute *attr,	\
-				     char *buf)				\
-{									\
-	return show_in_min(dev, buf, offset);				\
-}									\
-static ssize_t show_in##offset##_max(struct device *dev,		\
-				     struct device_attribute *attr,	\
-				     char *buf)				\
-{									\
-	return show_in_max(dev, buf, offset);				\
-}									\
-static ssize_t								\
-set_in##offset##_min(struct device *dev,				\
-		     struct device_attribute *attr, const char *buf,	\
-		     size_t count)					\
-{									\
-	return set_in_min(dev, buf, count, offset);			\
-}									\
-static ssize_t								\
-set_in##offset##_max(struct device *dev,				\
-		     struct device_attribute *attr, const char *buf,	\
-		     size_t count)					\
-{									\
-	return set_in_max(dev, buf, count, offset);			\
-}									\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,			\
-		show_in##offset##_min, set_in##offset##_min);		\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,			\
-		show_in##offset##_max, set_in##offset##_max);
-
-show_in_offset(0);
-show_in_offset(1);
-show_in_offset(2);
-show_in_offset(3);
-show_in_offset(4);
-show_in_offset(5);
+#define vin(nr)							\
+static SENSOR_DEVICE_ATTR(in##nr##_input, S_IRUGO, 		\
+		show_in, NULL, (nr));				\
+static SENSOR_DEVICE_ATTR(in##nr##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, (nr));			\
+static SENSOR_DEVICE_ATTR(in##nr##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, (nr));
+
+vin(0);
+vin(1);
+vin(2);
+vin(3);
+vin(4);
+vin(5);
 
 /* fans */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-				1 << data->fan_div[nr]));
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
+				1 << data->fan_div[attr->index]));
 }
 
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
-				1 << data->fan_div[nr]));
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[attr->index],
+				1 << data->fan_div[attr->index]));
 }
 
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev,
+		struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", 1 << data->fan_div[nr]);
+	return sprintf(buf, "%d\n", 1 << data->fan_div[attr->index]);
 }
 
 /* write new fan div, callers must hold data->update_lock */
@@ -341,11 +319,11 @@ static void adm9240_write_fan_div(struct
 {
 	u8 reg, old, shift = (nr + 2) * 2;
 
-	reg = adm9240_read_value(client, ADM9240_REG_VID_FAN_DIV);
+	reg = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
 	old = (reg >> shift) & 3;
 	reg &= ~(3 << shift);
 	reg |= (fan_div << shift);
-	adm9240_write_value(client, ADM9240_REG_VID_FAN_DIV, reg);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_VID_FAN_DIV, reg);
 	dev_dbg(&client->dev, "fan%d clock divider changed from %u "
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
@@ -361,12 +339,15 @@ static void adm9240_write_fan_div(struct
  * - otherwise: select fan clock divider to suit fan speed low limit,
  *   measurement code may adjust registers to ensure fan speed reading
  */
-static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev,
+		struct device_attribute *devattr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+	int nr = attr->index;
 	u8 new_div;
 
 	down(&data->update_lock);
@@ -406,47 +387,23 @@ static ssize_t set_fan_min(struct device
 		data->fan_div[nr] = new_div;
 		adm9240_write_fan_div(client, nr, new_div);
 	}
-	adm9240_write_value(client, ADM9240_REG_FAN_MIN(nr),
+	i2c_smbus_write_byte_data(client, ADM9240_REG_FAN_MIN(nr),
 			data->fan_min[nr]);
 
 	up(&data->update_lock);
 	return count;
 }
 
-#define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev,			\
-				  struct device_attribute *attr,	\
-				  char *buf)				\
-{									\
-return show_fan(dev, buf, offset - 1);					\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
-{									\
-return show_fan_div(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
-{									\
-return show_fan_min(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, 		\
-				       struct device_attribute *attr,	\
-				       const char *buf, size_t count)	\
-{									\
-return set_fan_min(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, 			\
-		show_fan_##offset, NULL);				\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO, 				\
-		show_fan_##offset##_div, NULL);				\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min);
+#define fan(nr)							\
+static SENSOR_DEVICE_ATTR(fan##nr##_input, S_IRUGO,		\
+		show_fan, NULL, (nr - 1));			\
+static SENSOR_DEVICE_ATTR(fan##nr##_div, S_IRUGO,		\
+		show_fan_div, NULL, (nr - 1));			\
+static SENSOR_DEVICE_ATTR(fan##nr##_min, S_IRUGO | S_IWUSR,	\
+		show_fan_min, set_fan_min, (nr - 1));
 
-show_fan_offset(1);
-show_fan_offset(2);
+fan(1);
+fan(2);
 
 /* alarms */
 static ssize_t show_alarms(struct device *dev,
@@ -483,7 +440,7 @@ static ssize_t set_aout(struct device *d
 
 	down(&data->update_lock);
 	data->aout = AOUT_TO_REG(val);
-	adm9240_write_value(client, ADM9240_REG_ANALOG_OUT, data->aout);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_ANALOG_OUT, data->aout);
 	up(&data->update_lock);
 	return count;
 }
@@ -497,7 +454,7 @@ static ssize_t chassis_clear(struct devi
 	unsigned long val = simple_strtol(buf, NULL, 10);
 
 	if (val = 1) {
-		adm9240_write_value(client, ADM9240_REG_CHASSIS_CLEAR, 0x80);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_CHASSIS_CLEAR, 0x80);
 		dev_dbg(&client->dev, "chassis intrusion latch cleared\n");
 	}
 	return count;
@@ -518,11 +475,10 @@ static int adm9240_detect(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm9240_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm9240_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
@@ -538,7 +494,7 @@ static int adm9240_detect(struct i2c_ada
 	if (kind < 0) {
 
 		/* verify chip: reg address should match i2c address */
-		if (adm9240_read_value(new_client, ADM9240_REG_I2C_ADDR)
+		if (i2c_smbus_read_byte_data(new_client, ADM9240_REG_I2C_ADDR)
 				!= address) {
 			dev_err(&adapter->dev, "detect fail: address match, "
 					"0x%02x\n", address);
@@ -546,7 +502,7 @@ static int adm9240_detect(struct i2c_ada
 		}
 
 		/* check known chip manufacturer */
-		man_id = adm9240_read_value(new_client, ADM9240_REG_MAN_ID);
+		man_id = i2c_smbus_read_byte_data(new_client, ADM9240_REG_MAN_ID);
 
 		if (man_id = 0x23) {
 			kind = adm9240;
@@ -561,7 +517,7 @@ static int adm9240_detect(struct i2c_ada
 		}
 
 		/* successful detect, print chip info */
-		die_rev = adm9240_read_value(new_client, ADM9240_REG_DIE_REV);
+		die_rev = i2c_smbus_read_byte_data(new_client, ADM9240_REG_DIE_REV);
 		dev_info(&adapter->dev, "found %s revision %u\n",
 				man_id = 0x23 ? "ADM9240" :
 				man_id = 0xda ? "DS1780" : "LM81", die_rev);
@@ -593,33 +549,59 @@ static int adm9240_detect(struct i2c_ada
 		goto exit_detach;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
-	device_create_file(&new_client->dev, &dev_attr_in5_input);
-	device_create_file(&new_client->dev, &dev_attr_in5_min);
-	device_create_file(&new_client->dev, &dev_attr_in5_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in0_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in0_max.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in4_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in4_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in4_max.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_in5_max.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_temp1_max_hyst.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_fan1_div.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_fan1_min.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_fan2_div.dev_attr);
+	device_create_file(&new_client->dev,
+			&sensor_dev_attr_fan2_min.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_aout_output);
 	device_create_file(&new_client->dev, &dev_attr_chassis_clear);
@@ -659,8 +641,8 @@ static int adm9240_detach_client(struct 
 static void adm9240_init_client(struct i2c_client *client)
 {
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	u8 conf = adm9240_read_value(client, ADM9240_REG_CONFIG);
-	u8 mode = adm9240_read_value(client, ADM9240_REG_TEMP_CONF) & 3;
+	u8 conf = i2c_smbus_read_byte_data(client, ADM9240_REG_CONFIG);
+	u8 mode = i2c_smbus_read_byte_data(client, ADM9240_REG_TEMP_CONF) & 3;
 
 	data->vrm = vid_which_vrm(); /* need this to report vid as mV */
 
@@ -677,18 +659,18 @@ static void adm9240_init_client(struct i
 
 		for (i = 0; i < 6; i++)
 		{
-			adm9240_write_value(client,
+			i2c_smbus_write_byte_data(client,
 					ADM9240_REG_IN_MIN(i), 0);
-			adm9240_write_value(client,
+			i2c_smbus_write_byte_data(client,
 					ADM9240_REG_IN_MAX(i), 255);
 		}
-		adm9240_write_value(client, ADM9240_REG_FAN_MIN(0), 255);
-		adm9240_write_value(client, ADM9240_REG_FAN_MIN(1), 255);
-		adm9240_write_value(client, ADM9240_REG_TEMP_HIGH, 127);
-		adm9240_write_value(client, ADM9240_REG_TEMP_HYST, 127);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_FAN_MIN(0), 255);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_FAN_MIN(1), 255);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_TEMP_MAX(0), 127);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_TEMP_MAX(1), 127);
 
 		/* start measurement cycle */
-		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_CONFIG, 1);
 
 		dev_info(&client->dev, "cold start: config was 0x%02x "
 				"mode %u\n", conf, mode);
@@ -709,25 +691,25 @@ static struct adm9240_data *adm9240_upda
 
 		for (i = 0; i < 6; i++) /* read voltages */
 		{
-			data->in[i] = adm9240_read_value(client,
+			data->in[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN(i));
 		}
-		data->alarms = adm9240_read_value(client,
+		data->alarms = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_INT(0)) |
-					adm9240_read_value(client,
+					i2c_smbus_read_byte_data(client,
 					ADM9240_REG_INT(1)) << 8;
 
 		/* read temperature: assume temperature changes less than
 		 * 0.5'C per two measurement cycles thus ignore possible
 		 * but unlikely aliasing error on lsb reading. --Grant */
-		data->temp = ((adm9240_read_value(client,
+		data->temp = ((i2c_smbus_read_byte_data(client,
 					ADM9240_REG_TEMP) << 8) |
-					adm9240_read_value(client,
+					i2c_smbus_read_byte_data(client,
 					ADM9240_REG_TEMP_CONF)) / 128;
 
 		for (i = 0; i < 2; i++) /* read fans */
 		{
-			data->fan[i] = adm9240_read_value(client,
+			data->fan[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_FAN(i));
 
 			/* adjust fan clock divider on overflow */
@@ -752,30 +734,30 @@ static struct adm9240_data *adm9240_upda
 
 		for (i = 0; i < 6; i++)
 		{
-			data->in_min[i] = adm9240_read_value(client,
+			data->in_min[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN_MIN(i));
-			data->in_max[i] = adm9240_read_value(client,
+			data->in_max[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN_MAX(i));
 		}
 		for (i = 0; i < 2; i++)
 		{
-			data->fan_min[i] = adm9240_read_value(client,
+			data->fan_min[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_FAN_MIN(i));
 		}
-		data->temp_high = adm9240_read_value(client,
-				ADM9240_REG_TEMP_HIGH);
-		data->temp_hyst = adm9240_read_value(client,
-				ADM9240_REG_TEMP_HYST);
+		data->temp_max[0] = i2c_smbus_read_byte_data(client,
+				ADM9240_REG_TEMP_MAX(0));
+		data->temp_max[1] = i2c_smbus_read_byte_data(client,
+				ADM9240_REG_TEMP_MAX(1));
 
 		/* read fan divs and 5-bit VID */
-		i = adm9240_read_value(client, ADM9240_REG_VID_FAN_DIV);
+		i = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
 		data->fan_div[0] = (i >> 4) & 3;
 		data->fan_div[1] = (i >> 6) & 3;
 		data->vid = i & 0x0f;
-		data->vid |= (adm9240_read_value(client,
+		data->vid |= (i2c_smbus_read_byte_data(client,
 					ADM9240_REG_VID4) & 1) << 4;
 		/* read analog out */
-		data->aout = adm9240_read_value(client,
+		data->aout = i2c_smbus_read_byte_data(client,
 				ADM9240_REG_ANALOG_OUT);
 
 		data->last_updated_config = jiffies;
