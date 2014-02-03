From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Feb 2014 01:21:50 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (lm63) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1391390510-19238-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, attach hwmon attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Do not drop client variable in various functions to reduce scope
    of code changes.
    Associate error message in lm63_lut_looks_bad with hwmon device.
    Note: Doing the same in lm62_init_client() doesn't work since
	  the hwmon device is not yet available.

 drivers/hwmon/lm63.c |  106 +++++++++++++++++++-------------------------------
 1 file changed, 40 insertions(+), 66 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 7dc4873..c529164 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -155,7 +155,7 @@ enum chips { lm63, lm64, lm96163 };
  */
 
 struct lm63_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	const struct attribute_group *groups[5];
 	char valid; /* zero until following fields are valid */
@@ -219,9 +219,9 @@ static inline int lut_temp_to_reg(struct lm63_data *data, long val)
  * Update the lookup table register cache.
  * client->update_lock must be held when calling this function.
  */
-static void lm63_update_lut(struct i2c_client *client)
+static void lm63_update_lut(struct lm63_data *data)
 {
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = data->client;
 	int i;
 
 	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
@@ -242,8 +242,8 @@ static void lm63_update_lut(struct i2c_client *client)
 
 static struct lm63_data *lm63_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long next_update;
 
 	mutex_lock(&data->update_lock);
@@ -311,7 +311,7 @@ static struct lm63_data *lm63_update_device(struct device *dev)
 		data->valid = 1;
 	}
 
-	lm63_update_lut(client);
+	lm63_update_lut(data);
 
 	mutex_unlock(&data->update_lock);
 
@@ -322,18 +322,17 @@ static struct lm63_data *lm63_update_device(struct device *dev)
  * Trip points in the lookup table should be in ascending order for both
  * temperatures and PWM output values.
  */
-static int lm63_lut_looks_bad(struct i2c_client *client)
+static int lm63_lut_looks_bad(struct device *dev, struct lm63_data *data)
 {
-	struct lm63_data *data = i2c_get_clientdata(client);
 	int i;
 
 	mutex_lock(&data->update_lock);
-	lm63_update_lut(client);
+	lm63_update_lut(data);
 
 	for (i = 1; i < data->lut_size; i++) {
 		if (data->pwm1[1 + i - 1] > data->pwm1[1 + i]
 		 || data->temp8[3 + i - 1] > data->temp8[3 + i]) {
-			dev_warn(&client->dev,
+			dev_warn(dev,
 				 "Lookup table doesn't look sane (check entries %d and %d)\n",
 				 i, i + 1);
 			break;
@@ -359,8 +358,8 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_fan(struct device *dev, struct device_attribute *dummy,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -400,8 +399,8 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	unsigned long val;
 	int err;
@@ -436,8 +435,8 @@ static ssize_t set_pwm1_enable(struct device *dev,
 			       struct device_attribute *dummy,
 			       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -451,7 +450,7 @@ static ssize_t set_pwm1_enable(struct device *dev,
 	 * Only let the user switch to automatic mode if the lookup table
 	 * looks sane.
 	 */
-	if (val = 2 && lm63_lut_looks_bad(client))
+	if (val = 2 && lm63_lut_looks_bad(dev, data))
 		return -EPERM;
 
 	mutex_lock(&data->update_lock);
@@ -462,7 +461,7 @@ static ssize_t set_pwm1_enable(struct device *dev,
 	else
 		data->config_fan &= ~0x20;
 	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN,
-	data->config_fan);
+				  data->config_fan);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -506,8 +505,8 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	long val;
 	int err;
@@ -580,8 +579,8 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	};
 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 	int nr = attr->index;
@@ -636,8 +635,8 @@ static ssize_t set_temp2_crit_hyst(struct device *dev,
 				   struct device_attribute *dummy,
 				   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 	long hyst;
@@ -658,11 +657,11 @@ static ssize_t set_temp2_crit_hyst(struct device *dev,
  * Set conversion rate.
  * client->update_lock must be held when calling this function.
  */
-static void lm63_set_convrate(struct i2c_client *client, struct lm63_data *data,
-			      unsigned int interval)
+static void lm63_set_convrate(struct lm63_data *data, unsigned int interval)
 {
-	int i;
+	struct i2c_client *client = data->client;
 	unsigned int update_interval;
+	int i;
 
 	/* Shift calculations to avoid rounding errors */
 	interval <<= 6;
@@ -690,8 +689,7 @@ static ssize_t set_update_interval(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 	int err;
 
@@ -700,7 +698,7 @@ static ssize_t set_update_interval(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	lm63_set_convrate(client, data, clamp_val(val, 0, 100000));
+	lm63_set_convrate(data, clamp_val(val, 0, 100000));
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -709,8 +707,7 @@ static ssize_t set_update_interval(struct device *dev,
 static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, data->trutherm ? "1\n" : "2\n");
 }
@@ -718,8 +715,8 @@ static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int ret;
 	u8 reg;
@@ -956,8 +953,7 @@ static umode_t lm63_attribute_mode(struct kobject *kobj,
 				   struct attribute *attr, int index)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct lm63_data *data = dev_get_drvdata(dev);
 
 	if (attr = &sensor_dev_attr_temp2_crit.dev_attr.attr
 	    && (data->kind = lm64 ||
@@ -1036,9 +1032,9 @@ static int lm63_detect(struct i2c_client *client,
  * Ideally we shouldn't have to initialize anything, since the BIOS
  * should have taken care of everything
  */
-static void lm63_init_client(struct i2c_client *client)
+static void lm63_init_client(struct lm63_data *data)
 {
-	struct lm63_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = data->client;
 	struct device *dev = &client->dev;
 	u8 convrate;
 
@@ -1116,15 +1112,15 @@ static int lm63_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct lm63_data *data;
 	int groups = 0;
-	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct lm63_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
@@ -1134,7 +1130,7 @@ static int lm63_probe(struct i2c_client *client,
 		data->temp2_offset = 16000;
 
 	/* Initialize chip */
-	lm63_init_client(client);
+	lm63_init_client(data);
 
 	/* Register sysfs hooks */
 	data->groups[groups++] = &lm63_group;
@@ -1146,30 +1142,9 @@ static int lm63_probe(struct i2c_client *client,
 		data->groups[groups++] = &lm63_group_extra_lut;
 	}
 
-	err = sysfs_create_groups(&dev->kobj, data->groups);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_groups(&dev->kobj, data->groups);
-	return err;
-}
-
-static int lm63_remove(struct i2c_client *client)
-{
-	struct lm63_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_groups(&client->dev.kobj, data->groups);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 /*
@@ -1190,7 +1165,6 @@ static struct i2c_driver lm63_driver = {
 		.name	= "lm63",
 	},
 	.probe		= lm63_probe,
-	.remove		= lm63_remove,
 	.id_table	= lm63_id,
 	.detect		= lm63_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
