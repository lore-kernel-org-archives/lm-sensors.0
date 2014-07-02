From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 02 Jul 2014 12:36:50 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (lm93) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404304610.15238.5.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm93.c | 154 ++++++++++++++++++++++-----------------------------
 1 file changed, 66 insertions(+), 88 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 6c2df57..90bb048 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -207,7 +207,7 @@ struct block1_t {
  * Client-specific data
  */
 struct lm93_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
@@ -919,8 +919,8 @@ static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 
 static struct lm93_data *lm93_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	const unsigned long interval = HZ + (HZ / 2);
 
 	mutex_lock(&data->update_lock);
@@ -1158,8 +1158,8 @@ static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int vccp = nr - 6;
 	long vid;
 	unsigned long val;
@@ -1239,8 +1239,8 @@ static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int vccp = nr - 6;
 	long vid;
 	unsigned long val;
@@ -1323,8 +1323,8 @@ static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1358,8 +1358,8 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1394,8 +1394,8 @@ static ssize_t store_temp_auto_base(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1430,8 +1430,8 @@ static ssize_t store_temp_auto_boost(struct device *dev,
 				     const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1469,8 +1469,8 @@ static ssize_t store_temp_auto_boost_hyst(struct device *dev,
 					  const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1520,8 +1520,8 @@ static ssize_t store_temp_auto_offset(struct device *dev,
 	struct sensor_device_attribute_2 *s_attr = to_sensor_dev_attr_2(attr);
 	int nr = s_attr->index;
 	int ofs = s_attr->nr;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1632,8 +1632,8 @@ static ssize_t store_temp_auto_pwm_min(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 reg, ctl4;
 	unsigned long val;
 	int err;
@@ -1680,8 +1680,8 @@ static ssize_t store_temp_auto_offset_hyst(struct device *dev,
 						const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 reg;
 	unsigned long val;
 	int err;
@@ -1741,8 +1741,8 @@ static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1824,8 +1824,8 @@ static ssize_t store_fan_smart_tach(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1880,8 +1880,8 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ctl2, ctl4;
 	unsigned long val;
 	int err;
@@ -1928,8 +1928,8 @@ static ssize_t store_pwm_enable(struct device *dev,
 				const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ctl2;
 	unsigned long val;
 	int err;
@@ -2006,8 +2006,8 @@ static ssize_t store_pwm_freq(struct device *dev,
 				const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ctl4;
 	unsigned long val;
 	int err;
@@ -2046,8 +2046,8 @@ static ssize_t store_pwm_auto_channels(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -2087,8 +2087,8 @@ static ssize_t store_pwm_auto_spinup_min(struct device *dev,
 						const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ctl3, ctl4;
 	unsigned long val;
 	int err;
@@ -2130,8 +2130,8 @@ static ssize_t store_pwm_auto_spinup_time(struct device *dev,
 						const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ctl3;
 	unsigned long val;
 	int err;
@@ -2168,8 +2168,8 @@ static ssize_t store_pwm_auto_prochot_ramp(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ramp;
 	unsigned long val;
 	int err;
@@ -2202,8 +2202,8 @@ static ssize_t store_pwm_auto_vrdhot_ramp(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 ramp;
 	unsigned long val;
 	int err;
@@ -2270,8 +2270,8 @@ static ssize_t store_prochot_max(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -2308,8 +2308,8 @@ static ssize_t store_prochot_override(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -2351,8 +2351,8 @@ static ssize_t store_prochot_interval(struct device *dev,
 					const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 tmp;
 	unsigned long val;
 	int err;
@@ -2390,8 +2390,8 @@ static ssize_t store_prochot_override_duty_cycle(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -2423,8 +2423,8 @@ static ssize_t store_prochot_short(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm93_data *data = i2c_get_clientdata(client);
+	struct lm93_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -2631,9 +2631,7 @@ static struct attribute *lm93_attrs[] = {
 	NULL
 };
 
-static struct attribute_group lm93_attr_grp = {
-	.attrs = lm93_attrs,
-};
+ATTRIBUTE_GROUPS(lm93);
 
 static void lm93_init_client(struct i2c_client *client)
 {
@@ -2726,61 +2724,42 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
 static int lm93_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm93_data *data;
-	int err, func;
+	struct device *hwmon_dev;
+	int func;
 	void (*update)(struct lm93_data *, struct i2c_client *);
 
 	/* choose update routine based on bus capabilities */
 	func = i2c_get_functionality(client->adapter);
 	if (((LM93_SMBUS_FUNC_FULL & func) = LM93_SMBUS_FUNC_FULL) &&
 			(!disable_block)) {
-		dev_dbg(&client->dev, "using SMBus block data transactions\n");
+		dev_dbg(dev, "using SMBus block data transactions\n");
 		update = lm93_update_client_full;
 	} else if ((LM93_SMBUS_FUNC_MIN & func) = LM93_SMBUS_FUNC_MIN) {
-		dev_dbg(&client->dev,
-			"disabled SMBus block data transactions\n");
+		dev_dbg(dev, "disabled SMBus block data transactions\n");
 		update = lm93_update_client_min;
 	} else {
-		dev_dbg(&client->dev,
-			"detect failed, smbus byte and/or word data not supported!\n");
+		dev_dbg(dev, "detect failed, smbus byte and/or word data not supported!\n");
 		return -ENODEV;
 	}
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm93_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm93_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	i2c_set_clientdata(client, data);
 
 	/* housekeeping */
+	data->client = client;
 	data->update = update;
 	mutex_init(&data->update_lock);
 
 	/* initialize the chip */
 	lm93_init_client(client);
 
-	err = sysfs_create_group(&client->dev.kobj, &lm93_attr_grp);
-	if (err)
-		return err;
-
-	/* Register hwmon driver class */
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
-
-	err = PTR_ERR(data->hwmon_dev);
-	dev_err(&client->dev, "error registering hwmon device.\n");
-	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
-	return err;
-}
-
-static int lm93_remove(struct i2c_client *client)
-{
-	struct lm93_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   lm93_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id lm93_id[] = {
@@ -2796,7 +2775,6 @@ static struct i2c_driver lm93_driver = {
 		.name	= "lm93",
 	},
 	.probe		= lm93_probe,
-	.remove		= lm93_remove,
 	.id_table	= lm93_id,
 	.detect		= lm93_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
