From: Krzysztof Helt <krzysztof.h1@gmail.com>
Date: Sun, 09 Sep 2007 17:51:14 +0000
Subject: [lm-sensors] [PATCH] adm1021: dynamic sysfs callbacks conversion
Message-Id: <20070909195114.2baa4f66.krzysztof.h1@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46a4515e7829b@wp.pl>
In-Reply-To: <46a4515e7829b@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is conversion of the driver  to the dynamic sysfs callbacks.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.22/drivers/hwmon/adm1021.c	2007-09-09 19:36:59.782610177 +0200
+++ linux-2.6.23/drivers/hwmon/adm1021.c	2007-09-09 19:41:49.535122232 +0200
@@ -25,6 +25,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -43,8 +44,8 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
 
 /* The adm1021 registers */
 /* Read-only */
-#define ADM1021_REG_TEMP		0x00
-#define ADM1021_REG_REMOTE_TEMP		0x01
+/* For nr in 0-1 */
+#define ADM1021_REG_TEMP(nr)		(nr)
 #define ADM1021_REG_STATUS		0x02
 /* 0x41 = AD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi */
 #define ADM1021_REG_MAN_ID		0xFE
@@ -62,25 +63,14 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
 #define ADM1023_REG_REM_TOS_PREC	0x13
 #define ADM1023_REG_REM_THYST_PREC	0x14
 /* limits */
-#define ADM1021_REG_TOS_R		0x05
-#define ADM1021_REG_TOS_W		0x0B
-#define ADM1021_REG_REMOTE_TOS_R	0x07
-#define ADM1021_REG_REMOTE_TOS_W	0x0D
-#define ADM1021_REG_THYST_R		0x06
-#define ADM1021_REG_THYST_W		0x0C
-#define ADM1021_REG_REMOTE_THYST_R	0x08
-#define ADM1021_REG_REMOTE_THYST_W	0x0E
+/* For nr in 0-1 */
+#define ADM1021_REG_TOS_R(nr)		(0x05 + 2 * (nr))
+#define ADM1021_REG_TOS_W(nr)		(0x0B + 2 * (nr))
+#define ADM1021_REG_THYST_R(nr)		(0x06 + 2 * (nr))
+#define ADM1021_REG_THYST_W(nr)		(0x0C + 2 * (nr))
 /* write-only */
 #define ADM1021_REG_ONESHOT		0x0F
 
-
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
-/* Conversions  note: 1021 uses normal integer signed-byte format*/
-#define TEMP_TO_REG(val)	SENSORS_LIMIT((val) / 1000, -128, 127)
-
 /* Initial values */
 
 /* Note: Even though I left the low and high limits named os and hyst,
@@ -98,19 +88,16 @@ struct adm1021_data {
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	s8	temp_max;	/* Register values */
-	s8	temp_hyst;
-	s8	temp_input;
-	s8	remote_temp_max;
-	s8	remote_temp_hyst;
-	s8	remote_temp_input;
-	u8	alarms;
-        /* Special values for ADM1023 only */
-	u8	remote_temp_prec;
-	u8	remote_temp_os_prec;
-	u8	remote_temp_hyst_prec;
-	u8	remote_temp_offset;
-	u8	remote_temp_offset_prec;
+	s8 temp_max[2];		/* Register values */
+	s8 temp_min[2];
+	s8 temp[2];
+	u8 alarms;
+	/* Special values for ADM1023 only */
+	u8 remote_temp_prec;
+	u8 remote_temp_os_prec;
+	u8 remote_temp_hyst_prec;
+	u8 remote_temp_offset;
+	u8 remote_temp_offset_prec;
 };
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter);
@@ -133,19 +120,32 @@ static struct i2c_driver adm1021_driver 
 	.detach_client	= adm1021_detach_client,
 };
 
-#define show(value)							\
-static ssize_t show_##value(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)	\
-{									\
-	struct adm1021_data *data = adm1021_update_device(dev);		\
-	return sprintf(buf, "%d\n", 1000 * data->value);		\
-}
-show(temp_max);
-show(temp_hyst);
-show(temp_input);
-show(remote_temp_max);
-show(remote_temp_hyst);
-show(remote_temp_input);
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct adm1021_data *data = adm1021_update_device(dev);
+
+	return sprintf(buf, "%d\n", 1000 * data->temp[index]);
+}
+
+static ssize_t show_temp_max(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct adm1021_data *data = adm1021_update_device(dev);
+
+	return sprintf(buf, "%d\n", 1000 * data->temp_max[index]);
+}
+
+static ssize_t show_temp_min(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct adm1021_data *data = adm1021_update_device(dev);
+
+	return sprintf(buf, "%d\n", 1000 * data->temp_min[index]);
+}
 
 static ssize_t show_alarms(struct device *dev,
 			   struct device_attribute *attr,
@@ -155,35 +155,55 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%u\n", data->alarms);
 }
 
-#define set(value, reg)							\
-static ssize_t set_##value(struct device *dev,				\
-			   struct device_attribute *attr,		\
-			   const char *buf, size_t count)		\
-{									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct adm1021_data *data = i2c_get_clientdata(client);		\
-	long temp = simple_strtol(buf, NULL, 10);			\
-									\
-	mutex_lock(&data->update_lock);					\
-	data->value = TEMP_TO_REG(temp);				\
-	if (!read_only)							\
-		i2c_smbus_write_byte_data(client, reg, data->value);	\
-	mutex_unlock(&data->update_lock);				\
-	return count;							\
-}
-set(temp_max, ADM1021_REG_TOS_W);
-set(temp_hyst, ADM1021_REG_THYST_W);
-set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
-set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
-
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static ssize_t set_temp_max(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1021_data *data = i2c_get_clientdata(client);
+	long temp = simple_strtol(buf, NULL, 10) / 1000;
+
+	mutex_lock(&data->update_lock);
+	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);
+	if (!read_only)
+		i2c_smbus_write_byte_data(client, ADM1021_REG_TOS_W(index),
+					  data->temp_max[index]);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_temp_min(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1021_data *data = i2c_get_clientdata(client);
+	long temp = simple_strtol(buf, NULL, 10) / 1000;
 
+	mutex_lock(&data->update_lock);
+	data->temp_min[index] = SENSORS_LIMIT(temp, -128, 127);
+	if (!read_only)
+		i2c_smbus_write_byte_data(client, ADM1021_REG_THYST_W(index),
+					  data->temp_min[index]);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
+			  set_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
+			  set_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
+			  set_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
+			  set_temp_min, 1);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -193,12 +213,12 @@ static int adm1021_attach_adapter(struct
 }
 
 static struct attribute *adm1021_attributes[] = {
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp2_input.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	NULL
 };
@@ -370,20 +390,18 @@ static struct adm1021_data *adm1021_upda
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
+		int i;
+
 		dev_dbg(&client->dev, "Starting adm1021 update\n");
 
-		data->temp_input = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_TEMP);
-		data->temp_max = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_TOS_R);
-		data->temp_hyst = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_THYST_R);
-		data->remote_temp_input = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_REMOTE_TEMP);
-		data->remote_temp_max = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_REMOTE_TOS_R);
-		data->remote_temp_hyst = i2c_smbus_read_byte_data(client,
-						ADM1021_REG_REMOTE_THYST_R);
+		for (i = 0; i < 2; i++) {
+			data->temp[i] = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_TEMP(i));
+			data->temp_max[i] = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_TOS_R(i));
+			data->temp_min[i] = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_THYST_R(i));
+		}
 		data->alarms = i2c_smbus_read_byte_data(client,
 						ADM1021_REG_STATUS) & 0x7c;
 		if (data->type = adm1023) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
