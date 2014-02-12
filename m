From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 17:41:04 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (max6650) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1392226866-25968-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach sensor attributes
to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6650.c |   77 +++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 26b24f7..badff94 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -110,7 +110,8 @@ module_param(clock, int, S_IRUGO);
  */
 
 struct max6650_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	int nr_fans;
 	char valid; /* zero until following fields are valid */
@@ -134,9 +135,9 @@ static const u8 tach_reg[] = {
 
 static struct max6650_data *max6650_update_device(struct device *dev)
 {
+	struct max6650_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6650_data *data = i2c_get_clientdata(client);
 
 	mutex_lock(&data->update_lock);
 
@@ -254,8 +255,8 @@ static ssize_t get_target(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_target(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6650_data *data = i2c_get_clientdata(client);
+	struct max6650_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int kscale, ktach;
 	unsigned long rpm;
 	int err;
@@ -323,8 +324,8 @@ static ssize_t get_pwm(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6650_data *data = i2c_get_clientdata(client);
+	struct max6650_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long pwm;
 	int err;
 
@@ -369,8 +370,8 @@ static ssize_t get_enable(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_enable(struct device *dev, struct device_attribute *devattr,
 			  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6650_data *data = i2c_get_clientdata(client);
+	struct max6650_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int max6650_modes[3] = {0, 3, 2};
 	unsigned long mode;
 	int err;
@@ -419,8 +420,8 @@ static ssize_t get_div(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6650_data *data = i2c_get_clientdata(client);
+	struct max6650_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long div;
 	int err;
 
@@ -465,7 +466,7 @@ static ssize_t get_alarm(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct max6650_data *data = max6650_update_device(dev);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = data->client;
 	int alarm = 0;
 
 	if (data->alarm & attr->index) {
@@ -503,7 +504,8 @@ static umode_t max6650_attrs_visible(struct kobject *kobj, struct attribute *a,
 				    int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct max6650_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 alarm_en = i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM_EN);
 	struct device_attribute *devattr;
 
@@ -538,7 +540,7 @@ static struct attribute *max6650_attrs[] = {
 	NULL
 };
 
-static struct attribute_group max6650_attr_grp = {
+static const struct attribute_group max6650_group = {
 	.attrs = max6650_attrs,
 	.is_visible = max6650_attrs_visible,
 };
@@ -550,7 +552,7 @@ static struct attribute *max6651_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group max6651_attr_grp = {
+static const struct attribute_group max6651_group = {
 	.attrs = max6651_attrs,
 };
 
@@ -558,9 +560,9 @@ static const struct attribute_group max6651_attr_grp = {
  * Real code
  */
 
-static int max6650_init_client(struct i2c_client *client)
+static int max6650_init_client(struct max6650_data *data,
+			       struct i2c_client *client)
 {
-	struct max6650_data *data = i2c_get_clientdata(client);
 	int config;
 	int err = -EIO;
 
@@ -649,6 +651,7 @@ static int max6650_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct max6650_data *data;
+	struct device *hwmon_dev;
 	int err;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
@@ -658,49 +661,26 @@ static int max6650_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 	data->nr_fans = id->driver_data;
 
 	/*
 	 * Initialize the max6650 chip
 	 */
-	err = max6650_init_client(client);
+	err = max6650_init_client(data, client);
 	if (err)
 		return err;
 
-	err = sysfs_create_group(&client->dev.kobj, &max6650_attr_grp);
-	if (err)
-		return err;
+	data->groups[0] = &max6650_group;
 	/* 3 additional fan inputs for the MAX6651 */
-	if (data->nr_fans = 4) {
-		err = sysfs_create_group(&client->dev.kobj, &max6651_attr_grp);
-		if (err)
-			goto err_remove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
-
-	err = PTR_ERR(data->hwmon_dev);
-	dev_err(&client->dev, "error registering hwmon device.\n");
 	if (data->nr_fans = 4)
-		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
-err_remove:
-	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
-	return err;
-}
-
-static int max6650_remove(struct i2c_client *client)
-{
-	struct max6650_data *data = i2c_get_clientdata(client);
+		data->groups[1] = &max6651_group;
 
-	hwmon_device_unregister(data->hwmon_dev);
-	if (data->nr_fans = 4)
-		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
-	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id max6650_id[] = {
@@ -715,7 +695,6 @@ static struct i2c_driver max6650_driver = {
 		.name	= "max6650",
 	},
 	.probe		= max6650_probe,
-	.remove		= max6650_remove,
 	.id_table	= max6650_id,
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
