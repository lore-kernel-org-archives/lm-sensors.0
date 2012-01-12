From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 12 Jan 2012 01:47:32 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm63) Add support for update_interval sysfs attribute
Message-Id: <1326332852-8030-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The update interval is configurable on LM63 and compatibles. Add support for it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Simplify UPDATE_INTERVAL macro
    Range limit value passed to lm63_set_convrate
    Change type of 'kind' variable to enum chips
    Add 'unlikely' to new if statement

 drivers/hwmon/lm63.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index a9e6212..5f6da52 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -61,6 +61,7 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
  */
 
 #define LM63_REG_CONFIG1		0x03
+#define LM63_REG_CONVRATE		0x04
 #define LM63_REG_CONFIG2		0xBF
 #define LM63_REG_CONFIG_FAN		0x4A
 
@@ -96,6 +97,11 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define LM96163_REG_REMOTE_TEMP_U_LSB	0x32
 #define LM96163_REG_CONFIG_ENHANCED	0x45
 
+#define LM63_MAX_CONVRATE		9
+
+#define LM63_MAX_CONVRATE_HZ		32
+#define LM96163_MAX_CONVRATE_HZ		26
+
 /*
  * Conversions and various macros
  * For tachometer counts, the LM63 uses 16-bit values.
@@ -132,6 +138,9 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 				 (val) >= 127000 ? 127 : \
 				 ((val) + 500) / 1000)
 
+#define UPDATE_INTERVAL(max, rate) \
+			((1000 << (LM63_MAX_CONVRATE - (rate))) / (max))
+
 /*
  * Functions declaration
  */
@@ -180,9 +189,12 @@ struct lm63_data {
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
-	int kind;
+	enum chips kind;
 	int temp2_offset;
 
+	int update_interval;	/* in milliseconds */
+	int max_convrate_hz;
+
 	/* registers values */
 	u8 config, config_fan;
 	u16 fan[2];	/* 0: input
@@ -449,6 +461,58 @@ static ssize_t set_temp2_crit_hyst(struct device *dev,
 	return count;
 }
 
+/*
+ * Set conversion rate.
+ * client->update_lock must be held when calling this function.
+ */
+static void lm63_set_convrate(struct i2c_client *client, struct lm63_data *data,
+			      unsigned int interval)
+{
+	int i;
+	unsigned int update_interval;
+
+	/* Shift calculations to avoid rounding errors */
+	interval <<= 6;
+
+	/* find the nearest update rate */
+	update_interval = (1 << (LM63_MAX_CONVRATE + 6)) * 1000
+	  / data->max_convrate_hz;
+	for (i = 0; i < LM63_MAX_CONVRATE; i++, update_interval >>= 1)
+		if (interval >= update_interval * 3 / 4)
+			break;
+
+	i2c_smbus_write_byte_data(client, LM63_REG_CONVRATE, i);
+	data->update_interval = UPDATE_INTERVAL(data->max_convrate_hz, i);
+}
+
+static ssize_t show_update_interval(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct lm63_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", data->update_interval);
+}
+
+static ssize_t set_update_interval(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+	lm63_set_convrate(client, data, SENSORS_LIMIT(val, 0, 100000));
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
 			   char *buf)
 {
@@ -499,6 +563,9 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
 /* Raw alarm file for compatibility */
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
+		   set_update_interval);
+
 static struct attribute *lm63_attributes[] = {
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
@@ -517,6 +584,7 @@ static struct attribute *lm63_attributes[] = {
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_update_interval.attr,
 	NULL
 };
 
@@ -669,6 +737,7 @@ exit:
 static void lm63_init_client(struct i2c_client *client)
 {
 	struct lm63_data *data = i2c_get_clientdata(client);
+	u8 convrate;
 
 	data->config = i2c_smbus_read_byte_data(client, LM63_REG_CONFIG1);
 	data->config_fan = i2c_smbus_read_byte_data(client,
@@ -687,6 +756,21 @@ static void lm63_init_client(struct i2c_client *client)
 	if (data->pwm1_freq = 0)
 		data->pwm1_freq = 1;
 
+	switch (data->kind) {
+	case lm63:
+	case lm64:
+		data->max_convrate_hz = LM63_MAX_CONVRATE_HZ;
+		break;
+	case lm96163:
+		data->max_convrate_hz = LM96163_MAX_CONVRATE_HZ;
+		break;
+	}
+	convrate = i2c_smbus_read_byte_data(client, LM63_REG_CONVRATE);
+	if (unlikely(convrate > LM63_MAX_CONVRATE))
+		convrate = LM63_MAX_CONVRATE;
+	data->update_interval = UPDATE_INTERVAL(data->max_convrate_hz,
+						convrate);
+
 	/*
 	 * For LM96163, check if high resolution PWM
 	 * and unsigned temperature format is enabled.
@@ -730,10 +814,14 @@ static struct lm63_data *lm63_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
+	unsigned long next_update;
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+	next_update = data->last_updated
+	  + msecs_to_jiffies(data->update_interval) + 1;
+
+	if (time_after(jiffies, next_update) || !data->valid) {
 		if (data->config & 0x04) { /* tachometer enabled  */
 			/* order matters for fan1_input */
 			data->fan[0] = i2c_smbus_read_byte_data(client,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
