From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Feb 2014 01:16:47 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm80) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1391390207-19144-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes to
hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use PTR_ERR_OR_ZERO
    Associate driver messages with hwmon device

 drivers/hwmon/lm80.c |   70 ++++++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index eba89aa..bd0a1eb 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -112,7 +112,7 @@ static inline long TEMP_FROM_REG(u16 temp)
  */
 
 struct lm80_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char error;		/* !=0 if error occurred during last update */
 	char valid;		/* !=0 if following fields are valid */
@@ -140,7 +140,6 @@ static int lm80_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
 static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void lm80_init_client(struct i2c_client *client);
-static int lm80_remove(struct i2c_client *client);
 static struct lm80_data *lm80_update_device(struct device *dev);
 static int lm80_read_value(struct i2c_client *client, u8 reg);
 static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value);
@@ -162,7 +161,6 @@ static struct i2c_driver lm80_driver = {
 		.name	= "lm80",
 	},
 	.probe		= lm80_probe,
-	.remove		= lm80_remove,
 	.id_table	= lm80_id,
 	.detect		= lm80_detect,
 	.address_list	= normal_i2c,
@@ -191,8 +189,8 @@ static ssize_t set_in_##suffix(struct device *dev, \
 	struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
+	struct lm80_data *data = dev_get_drvdata(dev); \
+	struct i2c_client *client = data->client; \
 	long val; \
 	int err = kstrtol(buf, 10, &val); \
 	if (err < 0) \
@@ -235,8 +233,8 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm80_data *data = i2c_get_clientdata(client);
+	struct lm80_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err = kstrtoul(buf, 10, &val);
 	if (err < 0)
@@ -259,8 +257,8 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm80_data *data = i2c_get_clientdata(client);
+	struct lm80_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long min, val;
 	u8 reg;
 	int err = kstrtoul(buf, 10, &val);
@@ -286,7 +284,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		data->fan_div[nr] = 3;
 		break;
 	default:
-		dev_err(&client->dev,
+		dev_err(dev,
 			"fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n",
 			val);
 		mutex_unlock(&data->update_lock);
@@ -332,8 +330,8 @@ show_temp(os_hyst, temp_os_hyst);
 static ssize_t set_temp_##suffix(struct device *dev, \
 	struct device_attribute *attr, const char *buf, size_t count) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
+	struct lm80_data *data = dev_get_drvdata(dev); \
+	struct i2c_client *client = data->client; \
 	long val; \
 	int err = kstrtol(buf, 10, &val); \
 	if (err < 0) \
@@ -440,7 +438,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 13);
  * Real code
  */
 
-static struct attribute *lm80_attributes[] = {
+static struct attribute *lm80_attrs[] = {
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
@@ -487,10 +485,7 @@ static struct attribute *lm80_attributes[] = {
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group lm80_group = {
-	.attrs = lm80_attributes,
-};
+ATTRIBUTE_GROUPS(lm80);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
@@ -541,14 +536,15 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
 static int lm80_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct lm80_data *data;
-	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm80_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM80 chip */
@@ -558,32 +554,10 @@ static int lm80_probe(struct i2c_client *client,
 	data->fan_min[0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
 	data->fan_min[1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &lm80_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error_remove;
-	}
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, lm80_groups);
 
-	return 0;
-
-error_remove:
-	sysfs_remove_group(&client->dev.kobj, &lm80_group);
-	return err;
-}
-
-static int lm80_remove(struct i2c_client *client)
-{
-	struct lm80_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm80_group);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static int lm80_read_value(struct i2c_client *client, u8 reg)
@@ -614,8 +588,8 @@ static void lm80_init_client(struct i2c_client *client)
 
 static struct lm80_data *lm80_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm80_data *data = i2c_get_clientdata(client);
+	struct lm80_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 	int rv;
 	int prev_rv;
@@ -627,7 +601,7 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 		lm80_init_client(client);
 
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
-		dev_dbg(&client->dev, "Starting lm80 update\n");
+		dev_dbg(dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
 			rv = lm80_read_value(client, LM80_REG_IN(i));
 			if (rv < 0)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
