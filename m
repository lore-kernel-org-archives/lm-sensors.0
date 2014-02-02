From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Feb 2014 17:39:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1021) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1391362768-27750-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes to
hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1021.c |   70 ++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 29dd9f7..f340ea2 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -79,9 +79,11 @@ enum chips {
 
 /* Each client has this additional data */
 struct adm1021_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	enum chips type;
 
+	const struct attribute_group *groups[3];
+
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	char low_power;		/* !=0 if device in low power mode */
@@ -101,7 +103,6 @@ static int adm1021_probe(struct i2c_client *client,
 static int adm1021_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static void adm1021_init_client(struct i2c_client *client);
-static int adm1021_remove(struct i2c_client *client);
 static struct adm1021_data *adm1021_update_device(struct device *dev);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
@@ -128,7 +129,6 @@ static struct i2c_driver adm1021_driver = {
 		.name	= "adm1021",
 	},
 	.probe		= adm1021_probe,
-	.remove		= adm1021_remove,
 	.id_table	= adm1021_id,
 	.detect		= adm1021_detect,
 	.address_list	= normal_i2c,
@@ -182,8 +182,8 @@ static ssize_t set_temp_max(struct device *dev,
 			    const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1021_data *data = i2c_get_clientdata(client);
+	struct adm1021_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	int err;
 
@@ -207,8 +207,8 @@ static ssize_t set_temp_min(struct device *dev,
 			    const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1021_data *data = i2c_get_clientdata(client);
+	struct adm1021_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	int err;
 
@@ -238,8 +238,8 @@ static ssize_t set_low_power(struct device *dev,
 			     struct device_attribute *devattr,
 			     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1021_data *data = i2c_get_clientdata(client);
+	struct adm1021_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	char low_power;
 	unsigned long val;
 	int err;
@@ -412,15 +412,15 @@ static int adm1021_detect(struct i2c_client *client,
 static int adm1021_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct adm1021_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adm1021_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adm1021_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->type = id->driver_data;
 	mutex_init(&data->update_lock);
 
@@ -428,29 +428,16 @@ static int adm1021_probe(struct i2c_client *client,
 	if (data->type != lm84 && !read_only)
 		adm1021_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &adm1021_group);
-	if (err)
-		return err;
-
-	if (data->type != lm84) {
-		err = sysfs_create_group(&client->dev.kobj, &adm1021_min_group);
-		if (err)
-			goto error;
-	}
+	data->groups[0] = &adm1021_group;
+	if (data->type != lm84)
+		data->groups[1] = &adm1021_min_group;
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error;
-	}
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 	return 0;
-
-error:
-	sysfs_remove_group(&client->dev.kobj, &adm1021_min_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
-	return err;
 }
 
 static void adm1021_init_client(struct i2c_client *client)
@@ -462,21 +449,10 @@ static void adm1021_init_client(struct i2c_client *client)
 	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 0x04);
 }
 
-static int adm1021_remove(struct i2c_client *client)
-{
-	struct adm1021_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adm1021_min_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
-
-	return 0;
-}
-
 static struct adm1021_data *adm1021_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1021_data *data = i2c_get_clientdata(client);
+	struct adm1021_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -484,7 +460,7 @@ static struct adm1021_data *adm1021_update_device(struct device *dev)
 	    || !data->valid) {
 		int i;
 
-		dev_dbg(&client->dev, "Starting adm1021 update\n");
+		dev_dbg(dev, "Starting adm1021 update\n");
 
 		for (i = 0; i < 2; i++) {
 			data->temp[i] = 1000 *
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
