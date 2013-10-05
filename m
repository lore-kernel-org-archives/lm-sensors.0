From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Oct 2013 22:23:25 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (emc1403) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1381011806-25136-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce its size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c |   73 +++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 142e1cb..dc2a917 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -40,7 +40,7 @@
 #define THERMAL_REVISION_REG	0xff
 
 struct thermal_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex mutex;
 	/*
 	 * Cache the hyst value so we don't keep re-reading it. In theory
@@ -53,10 +53,11 @@ struct thermal_data {
 static ssize_t show_temp(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
-	int retval = i2c_smbus_read_byte_data(client, sda->index);
+	struct thermal_data *data = dev_get_drvdata(dev);
+	int retval;
 
+	retval = i2c_smbus_read_byte_data(data->client, sda->index);
 	if (retval < 0)
 		return retval;
 	return sprintf(buf, "%d000\n", retval);
@@ -65,27 +66,27 @@ static ssize_t show_temp(struct device *dev,
 static ssize_t show_bit(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
-	int retval = i2c_smbus_read_byte_data(client, sda->nr);
+	struct thermal_data *data = dev_get_drvdata(dev);
+	int retval;
 
+	retval = i2c_smbus_read_byte_data(data->client, sda->nr);
 	if (retval < 0)
 		return retval;
-	retval &= sda->index;
-	return sprintf(buf, "%d\n", retval ? 1 : 0);
+	return sprintf(buf, "%d\n", !!(retval & sda->index));
 }
 
 static ssize_t store_temp(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct thermal_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 	int retval;
 
 	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
-	retval = i2c_smbus_write_byte_data(client, sda->index,
+	retval = i2c_smbus_write_byte_data(data->client, sda->index,
 					DIV_ROUND_CLOSEST(val, 1000));
 	if (retval < 0)
 		return retval;
@@ -95,9 +96,9 @@ static ssize_t store_temp(struct device *dev,
 static ssize_t store_bit(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thermal_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
+	struct thermal_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int retval;
 
@@ -124,9 +125,9 @@ fail:
 static ssize_t show_hyst(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thermal_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct thermal_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int retval;
 	int hyst;
 
@@ -147,9 +148,9 @@ static ssize_t show_hyst(struct device *dev,
 static ssize_t store_hyst(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thermal_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct thermal_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int retval;
 	int hyst;
 	unsigned long val;
@@ -235,7 +236,7 @@ static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR_2(power_state, S_IRUGO | S_IWUSR,
 	show_bit, store_bit, 0x03, 0x40);
 
-static struct attribute *mid_att_thermal[] = {
+static struct attribute *emc1403_attrs[] = {
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
@@ -263,10 +264,7 @@ static struct attribute *mid_att_thermal[] = {
 	&sensor_dev_attr_power_state.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group m_thermal_gr = {
-	.attrs = mid_att_thermal
-};
+ATTRIBUTE_GROUPS(emc1403);
 
 static int emc1403_detect(struct i2c_client *client,
 			struct i2c_board_info *info)
@@ -304,43 +302,25 @@ static int emc1403_detect(struct i2c_client *client,
 static int emc1403_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int res;
 	struct thermal_data *data;
+	struct device *hwmon_dev;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct thermal_data),
 			    GFP_KERNEL);
 	if (data = NULL)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->mutex);
 	data->hyst_valid = jiffies - 1;		/* Expired */
 
-	res = sysfs_create_group(&client->dev.kobj, &m_thermal_gr);
-	if (res) {
-		dev_warn(&client->dev, "create group failed\n");
-		return res;
-	}
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		res = PTR_ERR(data->hwmon_dev);
-		dev_warn(&client->dev, "register hwmon dev failed\n");
-		goto thermal_error;
-	}
-	dev_info(&client->dev, "EMC1403 Thermal chip found\n");
-	return 0;
-
-thermal_error:
-	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
-	return res;
-}
+	hwmon_dev = hwmon_device_register_with_groups(&client->dev,
+						      client->name, data,
+						      emc1403_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
-static int emc1403_remove(struct i2c_client *client)
-{
-	struct thermal_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
+	dev_info(&client->dev, "EMC1403 Thermal chip found\n");
 	return 0;
 }
 
@@ -362,7 +342,6 @@ static struct i2c_driver sensor_emc1403 = {
 	},
 	.detect = emc1403_detect,
 	.probe = emc1403_probe,
-	.remove = emc1403_remove,
 	.id_table = emc1403_idtable,
 	.address_list = emc1403_address_list,
 };
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
