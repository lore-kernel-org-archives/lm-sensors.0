From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:27 +0000
Subject: [lm-sensors] [PATCH 25/39] hwmon: (pcf8591) Fix checkpatch issues
Message-Id: <1326703781-14272-26-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: spaces required around that ':' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxV)
WARNING: line over 80 characters
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pcf8591.c |   63 +++++++++++++++++++++++++++++++---------------
 1 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 731b09a..474c97d 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -68,7 +68,7 @@ MODULE_PARM_DESC(input_mode,
 #define PCF8591_INIT_AOUT	0	/* DAC out = 0 */
 
 /* Conversions */
-#define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
+#define REG_TO_SIGNED(reg)	(((reg) & 0x80) ? ((reg) - 256) : (reg))
 
 struct pcf8591_data {
 	struct device *hwmon_dev;
@@ -83,7 +83,9 @@ static int pcf8591_read_channel(struct device *dev, int channel);
 
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\
-static ssize_t show_in##channel##_input(struct device *dev, struct device_attribute *attr, char *buf)	\
+static ssize_t show_in##channel##_input(struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
 {									\
 	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
 }									\
@@ -95,39 +97,57 @@ show_in_channel(1);
 show_in_channel(2);
 show_in_channel(3);
 
-static ssize_t show_out0_ouput(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_out0_ouput(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%d\n", data->aout * 10);
 }
 
-static ssize_t set_out0_output(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_out0_output(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
-	unsigned int value;
+	unsigned long val;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
-	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
-		data->aout = value;
-		i2c_smbus_write_byte_data(client, data->control, data->aout);
-		return count;
-	}
-	return -EINVAL;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	val /= 10;
+	if (val > 255)
+		return -EINVAL;
+
+	data->aout = val;
+	i2c_smbus_write_byte_data(client, data->control, data->aout);
+	return count;
 }
 
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO,
 		   show_out0_ouput, set_out0_output);
 
-static ssize_t show_out0_enable(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_out0_enable(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
 }
 
-static ssize_t set_out0_enable(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_out0_enable(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	if (val)
@@ -174,7 +194,8 @@ static int pcf8591_probe(struct i2c_client *client,
 	struct pcf8591_data *data;
 	int err;
 
-	if (!(data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -192,15 +213,15 @@ static int pcf8591_probe(struct i2c_client *client,
 
 	/* Register input2 if not in "two differential inputs" mode */
 	if (input_mode != 3) {
-		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in2_input)))
+		err = device_create_file(&client->dev, &dev_attr_in2_input);
+		if (err)
 			goto exit_sysfs_remove;
 	}
 
 	/* Register input3 only in "four single ended inputs" mode */
 	if (input_mode = 0) {
-		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in3_input)))
+		err = device_create_file(&client->dev, &dev_attr_in3_input);
+		if (err)
 			goto exit_sysfs_remove;
 	}
 
@@ -269,9 +290,9 @@ static int pcf8591_read_channel(struct device *dev, int channel)
 
 	if ((channel = 2 && input_mode = 2) ||
 	    (channel != 3 && (input_mode = 1 || input_mode = 3)))
-		return (10 * REG_TO_SIGNED(value));
+		return 10 * REG_TO_SIGNED(value);
 	else
-		return (10 * value);
+		return 10 * value;
 }
 
 static const struct i2c_device_id pcf8591_id[] = {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
