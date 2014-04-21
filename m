From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Apr 2014 01:28:12 +0000
Subject: [lm-sensors] [PATCH v4 3/3] hwmon: (lm77) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1398043692-10522-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups API to attach attributes
to hwmon device, simplify code, and reduce code size.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: No change to v3

 drivers/hwmon/lm77.c |   53 +++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index ab1752a..5ceb443 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -62,7 +62,7 @@ static const u8 temp_regs[t_num_temp] = {
 
 /* Each client has this additional data */
 struct lm77_data {
-	struct device		*hwmon_dev;
+	struct i2c_client	*client;
 	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
@@ -111,8 +111,8 @@ static int lm77_write_value(struct i2c_client *client, u8 reg, u16 value)
 
 static struct lm77_data *lm77_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm77_data *data = i2c_get_clientdata(client);
+	struct lm77_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -165,8 +165,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm77_data *data = i2c_get_clientdata(client);
+	struct lm77_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	long val;
 	int err;
@@ -190,8 +190,8 @@ static ssize_t set_temp_hyst(struct device *dev,
 			     struct device_attribute *devattr,
 			     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm77_data *data = i2c_get_clientdata(client);
+	struct lm77_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -232,7 +232,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
 
-static struct attribute *lm77_attributes[] = {
+static struct attribute *lm77_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
@@ -245,10 +245,7 @@ static struct attribute *lm77_attributes[] = {
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group lm77_group = {
-	.attrs = lm77_attributes,
-};
+ATTRIBUTE_GROUPS(lm77);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info)
@@ -332,43 +329,22 @@ static void lm77_init_client(struct i2c_client *client)
 static int lm77_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct lm77_data *data;
-	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct lm77_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM77 chip */
 	lm77_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&dev->kobj, &lm77_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
-exit_remove:
-	sysfs_remove_group(&dev->kobj, &lm77_group);
-	return err;
-}
-
-static int lm77_remove(struct i2c_client *client)
-{
-	struct lm77_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm77_group);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, lm77_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id lm77_id[] = {
@@ -384,7 +360,6 @@ static struct i2c_driver lm77_driver = {
 		.name	= "lm77",
 	},
 	.probe		= lm77_probe,
-	.remove		= lm77_remove,
 	.id_table	= lm77_id,
 	.detect		= lm77_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
