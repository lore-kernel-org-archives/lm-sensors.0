From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Mar 2007 12:36:17 +0000
Subject: [lm-sensors] PATCH] lm75: Use dynamic sysfs callbacks
Message-Id: <20070319133617.cec1e59e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by about 8%.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/lm75.c |   88 +++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

--- linux-2.6.21-rc4.orig/drivers/hwmon/lm75.c	2007-03-19 11:14:23.000000000 +0100
+++ linux-2.6.21-rc4/drivers/hwmon/lm75.c	2007-03-19 11:17:07.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include "lm75.h"
@@ -39,10 +40,12 @@ I2C_CLIENT_INSMOD_1(lm75);
 /* Many LM75 constants specified below */
 
 /* The LM75 registers */
-#define LM75_REG_TEMP		0x00
 #define LM75_REG_CONF		0x01
-#define LM75_REG_TEMP_HYST	0x02
-#define LM75_REG_TEMP_OS	0x03
+static const u8 LM75_REG_TEMP[3] = {
+	0x00,		/* input */
+	0x03,		/* max */
+	0x02,		/* hyst */
+};
 
 /* Each client has this additional data */
 struct lm75_data {
@@ -51,9 +54,10 @@ struct lm75_data {
 	struct mutex		update_lock;
 	char			valid;		/* !=0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
-	u16			temp_input;	/* Register values */
-	u16			temp_max;
-	u16			temp_hyst;
+	u16			temp[3];	/* Register values,
+						   0 = input
+						   1 = max
+						   2 = hyst */
 };
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter);
@@ -75,35 +79,36 @@ static struct i2c_driver lm75_driver = {
 	.detach_client	= lm75_detach_client,
 };
 
-#define show(value)	\
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	struct lm75_data *data = lm75_update_device(dev);		\
-	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
-}
-show(temp_max);
-show(temp_hyst);
-show(temp_input);
-
-#define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct lm75_data *data = i2c_get_clientdata(client);	\
-	int temp = simple_strtoul(buf, NULL, 10);		\
-								\
-	mutex_lock(&data->update_lock);				\
-	data->value = LM75_TEMP_TO_REG(temp);			\
-	lm75_write_value(client, reg, data->value);		\
-	mutex_unlock(&data->update_lock);					\
-	return count;						\
-}
-set(temp_max, LM75_REG_TEMP_OS);
-set(temp_hyst, LM75_REG_TEMP_HYST);
-
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
+static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct lm75_data *data = lm75_update_device(dev);
+	return sprintf(buf, "%d\n",
+		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
+}
+
+static ssize_t set_temp(struct device *dev, struct device_attribute *da,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm75_data *data = i2c_get_clientdata(client);
+	int nr = attr->index;
+	unsigned long temp = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->temp[nr] = LM75_TEMP_TO_REG(temp);
+	lm75_write_value(client, LM75_REG_TEMP[nr], data->temp[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
+			show_temp, set_temp, 1);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
+			show_temp, set_temp, 2);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -113,9 +118,9 @@ static int lm75_attach_adapter(struct i2
 }
 
 static struct attribute *lm75_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_max_hyst.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 
 	NULL
 };
@@ -283,11 +288,12 @@ static struct lm75_data *lm75_update_dev
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
+		int i;
 		dev_dbg(&client->dev, "Starting lm75 update\n");
 
-		data->temp_input = lm75_read_value(client, LM75_REG_TEMP);
-		data->temp_max = lm75_read_value(client, LM75_REG_TEMP_OS);
-		data->temp_hyst = lm75_read_value(client, LM75_REG_TEMP_HYST);
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
+			data->temp[i] = lm75_read_value(client,
+							LM75_REG_TEMP[i]);
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}


-- 
Jean Delvare

