From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Feb 2014 01:03:34 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (max6639) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1393031014-26259-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach sysfs attricutes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6639.c |   81 +++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 52646bb..e4852bb 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -80,7 +80,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
  * Client data (each client gets its own)
  */
 struct max6639_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -104,8 +104,8 @@ struct max6639_data {
 
 static struct max6639_data *max6639_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
+	struct max6639_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct max6639_data *ret = data;
 	int i;
 	int status_reg;
@@ -191,9 +191,8 @@ static ssize_t show_temp_fault(struct device *dev,
 static ssize_t show_temp_max(struct device *dev,
 			     struct device_attribute *dev_attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000));
 }
@@ -202,9 +201,9 @@ static ssize_t set_temp_max(struct device *dev,
 			    struct device_attribute *dev_attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -224,9 +223,8 @@ static ssize_t set_temp_max(struct device *dev,
 static ssize_t show_temp_crit(struct device *dev,
 			      struct device_attribute *dev_attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000));
 }
@@ -235,9 +233,9 @@ static ssize_t set_temp_crit(struct device *dev,
 			     struct device_attribute *dev_attr,
 			     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -258,9 +256,8 @@ static ssize_t show_temp_emergency(struct device *dev,
 				   struct device_attribute *dev_attr,
 				   char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
 }
@@ -269,9 +266,9 @@ static ssize_t set_temp_emergency(struct device *dev,
 				  struct device_attribute *dev_attr,
 				  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -291,9 +288,8 @@ static ssize_t set_temp_emergency(struct device *dev,
 static ssize_t show_pwm(struct device *dev,
 			struct device_attribute *dev_attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
 }
@@ -302,9 +298,9 @@ static ssize_t set_pwm(struct device *dev,
 		       struct device_attribute *dev_attr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	struct max6639_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -378,7 +374,7 @@ static SENSOR_DEVICE_ATTR(temp1_emergency_alarm, S_IRUGO, show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp2_emergency_alarm, S_IRUGO, show_alarm, NULL, 4);
 
 
-static struct attribute *max6639_attributes[] = {
+static struct attribute *max6639_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_fault.dev_attr.attr,
@@ -403,10 +399,7 @@ static struct attribute *max6639_attributes[] = {
 	&sensor_dev_attr_temp2_emergency_alarm.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group max6639_group = {
-	.attrs = max6639_attributes,
-};
+ATTRIBUTE_GROUPS(max6639);
 
 /*
  *  returns respective index in rpm_ranges table
@@ -424,9 +417,9 @@ static int rpm_range_to_reg(int range)
 	return 1; /* default: 4000 RPM */
 }
 
-static int max6639_init_client(struct i2c_client *client)
+static int max6639_init_client(struct max6639_data *data,
+			       struct i2c_client *client)
 {
-	struct max6639_data *data = i2c_get_clientdata(client);
 	struct max6639_platform_data *max6639_info  		dev_get_platdata(&client->dev);
 	int i;
@@ -547,46 +540,25 @@ static int max6639_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct max6639_data *data;
+	struct device *hwmon_dev;
 	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the max6639 chip */
-	err = max6639_init_client(client);
+	err = max6639_init_client(data, client);
 	if (err < 0)
 		return err;
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&dev->kobj, &max6639_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error_remove;
-	}
-
-	return 0;
-
-error_remove:
-	sysfs_remove_group(&dev->kobj, &max6639_group);
-	return err;
-}
-
-static int max6639_remove(struct i2c_client *client)
-{
-	struct max6639_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &max6639_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   max6639_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -631,7 +603,6 @@ static struct i2c_driver max6639_driver = {
 		   .pm = &max6639_pm_ops,
 		   },
 	.probe = max6639_probe,
-	.remove = max6639_remove,
 	.id_table = max6639_id,
 	.detect = max6639_detect,
 	.address_list = normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
