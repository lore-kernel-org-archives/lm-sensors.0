From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 24 Jun 2014 11:27:08 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1403609228.348.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

The 'sensors' command never worked with this driver, fixed with this conversion.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I think the 'sensors' command never worked with this driver, but I don't have
the h/w to test. I'd appreciate if someone can test it.
Thanks,
Axel
 drivers/hwmon/w83l786ng.c | 87 ++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 58 deletions(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 6ed76ce..8c0e370 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -124,7 +124,7 @@ DIV_TO_REG(long val)
 }
 
 struct w83l786ng_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -152,7 +152,6 @@ static int w83l786ng_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id);
 static int w83l786ng_detect(struct i2c_client *client,
 			    struct i2c_board_info *info);
-static int w83l786ng_remove(struct i2c_client *client);
 static void w83l786ng_init_client(struct i2c_client *client);
 static struct w83l786ng_data *w83l786ng_update_device(struct device *dev);
 
@@ -168,7 +167,6 @@ static struct i2c_driver w83l786ng_driver = {
 		   .name = "w83l786ng",
 	},
 	.probe		= w83l786ng_probe,
-	.remove		= w83l786ng_remove,
 	.id_table	= w83l786ng_id,
 	.detect		= w83l786ng_detect,
 	.address_list	= normal_i2c,
@@ -207,8 +205,8 @@ store_in_##reg(struct device *dev, struct device_attribute *attr, \
 	       const char *buf, size_t count) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83l786ng_data *data = i2c_get_clientdata(client); \
+	struct w83l786ng_data *data = dev_get_drvdata(dev); \
+	struct i2c_client *client = data->client; \
 	unsigned long val; \
 	int err = kstrtoul(buf, 10, &val); \
 	if (err) \
@@ -260,8 +258,8 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	      const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -298,8 +296,8 @@ store_fan_div(struct device *dev, struct device_attribute *attr,
 	      const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	unsigned long min;
 	u8 tmp_fan_div;
@@ -389,8 +387,8 @@ store_temp(struct device *dev, struct device_attribute *attr,
 	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -444,8 +442,8 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 reg;
 	unsigned long val;
 	int err;
@@ -472,8 +470,8 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	  const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -496,8 +494,8 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 		 const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 reg;
 	unsigned long val;
 	int err;
@@ -552,8 +550,8 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 tol_tmp, tol_mask;
 	unsigned long val;
 	int err;
@@ -608,7 +606,7 @@ static struct sensor_device_attribute sda_tolerance[] = {
 #define TOLERANCE_UNIT_ATTRS(X)	\
 	&sda_tolerance[X].dev_attr.attr
 
-static struct attribute *w83l786ng_attributes[] = {
+static struct attribute *w83l786ng_attrs[] = {
 	IN_UNIT_ATTRS(0),
 	IN_UNIT_ATTRS(1),
 	IN_UNIT_ATTRS(2),
@@ -623,9 +621,7 @@ static struct attribute *w83l786ng_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group w83l786ng_group = {
-	.attrs = w83l786ng_attributes,
-};
+ATTRIBUTE_GROUPS(w83l786ng);
 
 static int
 w83l786ng_detect(struct i2c_client *client, struct i2c_board_info *info)
@@ -667,15 +663,15 @@ w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct w83l786ng_data *data;
-	int i, err = 0;
+	struct device *hwmon_dev;
+	int i;
 	u8 reg_tmp;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct w83l786ng_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct w83l786ng_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the chip */
@@ -692,35 +688,10 @@ w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	data->fan_div[0] = reg_tmp & 0x07;
 	data->fan_div[1] = (reg_tmp >> 4) & 0x07;
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &w83l786ng_group);
-	if (err)
-		goto exit_remove;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
-	/* Unregister sysfs hooks */
-
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &w83l786ng_group);
-	return err;
-}
-
-static int
-w83l786ng_remove(struct i2c_client *client)
-{
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &w83l786ng_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   w83l786ng_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static void
@@ -739,8 +710,8 @@ w83l786ng_init_client(struct i2c_client *client)
 
 static struct w83l786ng_data *w83l786ng_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l786ng_data *data = i2c_get_clientdata(client);
+	struct w83l786ng_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i, j;
 	u8 reg_tmp, pwmcfg;
 
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
