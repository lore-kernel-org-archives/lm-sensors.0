From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 May 2007 17:59:45 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon/ds1621: Use dynamic sysfs callbacks
Message-Id: <20070516195945.41f12e2e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by about 8%.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |  104 ++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 55 deletions(-)

--- linux-2.6.22-rc1.orig/drivers/hwmon/ds1621.c	2007-05-16 18:27:41.000000000 +0200
+++ linux-2.6.22-rc1/drivers/hwmon/ds1621.c	2007-05-16 18:37:49.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
@@ -52,9 +53,11 @@ MODULE_PARM_DESC(polarity, "Output's pol
 #define DS1621_REG_CONFIG_DONE		0x80
 
 /* The DS1621 registers */
-#define DS1621_REG_TEMP			0xAA /* word, RO */
-#define DS1621_REG_TEMP_MIN		0xA2 /* word, RW */
-#define DS1621_REG_TEMP_MAX		0xA1 /* word, RW */
+static const u8 DS1621_REG_TEMP[3] = {
+	0xAA,		/* input, word, RO */
+	0xA2,		/* min, word, RW */
+	0xA1,		/* max, word, RW */
+};
 #define DS1621_REG_CONF			0xAC /* byte, RW */
 #define DS1621_COM_START		0xEE /* no data */
 #define DS1621_COM_STOP			0x22 /* no data */
@@ -75,7 +78,7 @@ struct ds1621_data {
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u16 temp, temp_min, temp_max;	/* Register values, word */
+	u16 temp[3];			/* Register values, word */
 	u8 conf;			/* Register encoding, combined */
 };
 
@@ -133,50 +136,47 @@ static void ds1621_init_client(struct i2
 	i2c_smbus_write_byte(client, DS1621_COM_START);
 }
 
-#define show(value)							\
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	struct ds1621_data *data = ds1621_update_client(dev);		\
-	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
-}
-
-show(temp);
-show(temp_min);
-show(temp_max);
-
-#define set_temp(suffix, value, reg)					\
-static ssize_t set_temp_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
-				 size_t count)				\
-{									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct ds1621_data *data = ds1621_update_client(dev);		\
-	u16 val = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
-									\
-	mutex_lock(&data->update_lock);					\
-	data->value = val;						\
-	ds1621_write_value(client, reg, data->value);			\
-	mutex_unlock(&data->update_lock);				\
-	return count;							\
+static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ds1621_data *data = ds1621_update_client(dev);
+	return sprintf(buf, "%d\n",
+		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
 }
 
-set_temp(min, temp_min, DS1621_REG_TEMP_MIN);
-set_temp(max, temp_max, DS1621_REG_TEMP_MAX);
+static ssize_t set_temp(struct device *dev, struct device_attribute *da,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1621_data *data = ds1621_update_client(dev);
+	u16 val = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+	mutex_lock(&data->update_lock);
+	data->temp[attr->index] = val;
+	ds1621_write_value(client, DS1621_REG_TEMP[attr->index],
+			   data->temp[attr->index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_alarms(struct device *dev, struct device_attribute *da,
+			   char *buf)
 {
 	struct ds1621_data *data = ds1621_update_client(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static DEVICE_ATTR(temp1_input, S_IRUGO , show_temp, NULL);
-static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO , show_temp_min, set_temp_min);
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
 
 static struct attribute *ds1621_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp1_max.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	NULL
 };
@@ -200,7 +200,7 @@ static int ds1621_detect(struct i2c_adap
 	int conf, temp;
 	struct i2c_client *client;
 	struct ds1621_data *data;
-	int err = 0;
+	int i, err = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA 
 				     | I2C_FUNC_SMBUS_WORD_DATA 
@@ -230,15 +230,11 @@ static int ds1621_detect(struct i2c_adap
 		if (conf & DS1621_REG_CONFIG_NVB)
 			goto exit_free;
 		/* The 7 lowest bits of a temperature should always be 0. */
-		temp = ds1621_read_value(client, DS1621_REG_TEMP);
-		if (temp & 0x007f)
-			goto exit_free;
-		temp = ds1621_read_value(client, DS1621_REG_TEMP_MIN);
-		if (temp & 0x007f)
-			goto exit_free;
-		temp = ds1621_read_value(client, DS1621_REG_TEMP_MAX);
-		if (temp & 0x007f)
-			goto exit_free;
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
+			temp = ds1621_read_value(client, DS1621_REG_TEMP[i]);
+			if (temp & 0x007f)
+				goto exit_free;
+		}
 	}
 
 	/* Fill in remaining client fields and put it into the global list */
@@ -301,23 +297,21 @@ static struct ds1621_data *ds1621_update
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
+		int i;
 
 		dev_dbg(&client->dev, "Starting ds1621 update\n");
 
 		data->conf = ds1621_read_value(client, DS1621_REG_CONF);
 
-		data->temp = ds1621_read_value(client, DS1621_REG_TEMP);
-		
-		data->temp_min = ds1621_read_value(client,
-		                                    DS1621_REG_TEMP_MIN);
-		data->temp_max = ds1621_read_value(client,
-						    DS1621_REG_TEMP_MAX);
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
+			data->temp[i] = ds1621_read_value(client,
+							  DS1621_REG_TEMP[i]);
 
 		/* reset alarms if necessary */
 		new_conf = data->conf;
-		if (data->temp > data->temp_min)
+		if (data->temp[0] > data->temp[1])	/* input > min */
 			new_conf &= ~DS1621_ALARM_TEMP_LOW;
-		if (data->temp < data->temp_max)
+		if (data->temp[0] < data->temp[2])	/* input < max */
 			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
 		if (data->conf != new_conf)
 			ds1621_write_value(client, DS1621_REG_CONF,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
