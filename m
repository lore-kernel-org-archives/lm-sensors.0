From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 01:02:56 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (tmp401) Add support for update_interval attribute
Message-Id: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp401.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index c0cf87d..e16544a 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -126,6 +126,8 @@ struct tmp401_data {
 	unsigned long last_updated; /* in jiffies */
 	enum chips kind;
 
+	int update_interval;	/* in milliseconds */
+
 	/* register values */
 	u8 status;
 	u8 config;
@@ -193,10 +195,13 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
 	struct tmp401_data *data = i2c_get_clientdata(client);
 	struct tmp401_data *ret = data;
 	int val;
+	unsigned long next_update;
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+	next_update = data->last_updated +
+	  msecs_to_jiffies(data->update_interval) + 1;
+	if (time_after(jiffies, next_update) || !data->valid) {
 		val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
 		if (val < 0) {
 			ret = ERR_PTR(val);
@@ -369,6 +374,46 @@ static ssize_t reset_temp_history(struct device *dev,
 	return count;
 }
 
+static ssize_t show_update_interval(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tmp401_data *data = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%u\n", data->update_interval);
+}
+
+static ssize_t set_update_interval(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tmp401_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int err, rate;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+	/*
+	 * For valid rates, interval can be calculated as
+	 *	interval = (1 << (7 - rate)) * 125;
+	 * Rounded rate is therefore
+	 *	rate = 8 - fls(interval * 4 / (125 * 3));
+	 * Use clamp_val() to avoid overflows, and to clamp the result
+	 * to its valid range.
+	 */
+	val = clamp_val(val, 0, 100000);
+	rate = clamp_val(8 - fls(val * 4 / (125 * 3)), 0, 7);
+	i2c_smbus_write_byte_data(client, TMP401_CONVERSION_RATE_WRITE, rate);
+	data->update_interval = (1 << (7 - rate)) * 125;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_min, S_IWUSR | S_IRUGO, show_temp,
 			    store_temp, 1, 0);
@@ -402,6 +447,9 @@ static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_status, NULL,
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_status, NULL,
 			  TMP401_STATUS_REMOTE_CRIT);
 
+static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
+		   set_update_interval);
+
 static struct attribute *tmp401_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
@@ -422,6 +470,8 @@ static struct attribute *tmp401_attributes[] = {
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
 
+	&dev_attr_update_interval.attr,
+
 	NULL
 };
 
@@ -463,9 +513,11 @@ static const struct attribute_group tmp411_group = {
 static void tmp401_init_client(struct i2c_client *client)
 {
 	int config, config_orig;
+	struct tmp401_data *data = i2c_get_clientdata(client);
 
 	/* Set the conversion rate to 2 Hz */
 	i2c_smbus_write_byte_data(client, TMP401_CONVERSION_RATE_WRITE, 5);
+	data->update_interval = 500;
 
 	/* Start conversions (disable shutdown if necessary) */
 	config = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
