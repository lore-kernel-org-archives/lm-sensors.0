From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 02 Jul 2014 12:26:32 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (smm665) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404303992.15238.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/smm665.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 4ef5802..627c9c3 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -140,7 +140,7 @@ enum chips { smm465, smm665, smm665c, smm764, smm766 };
 struct smm665_data {
 	enum chips type;
 	int conversion_time;		/* ADC conversion time */
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	bool valid;
 	unsigned long last_updated;	/* in jiffies */
@@ -239,8 +239,8 @@ static int smm665_read_adc(struct smm665_data *data, int adc)
 
 static struct smm665_data *smm665_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smm665_data *data = i2c_get_clientdata(client);
+	struct smm665_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct smm665_data *ret = data;
 
 	mutex_lock(&data->update_lock);
@@ -315,32 +315,28 @@ static int smm665_convert(u16 adcval, int index)
 
 static int smm665_get_min(struct device *dev, int index)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smm665_data *data = i2c_get_clientdata(client);
+	struct smm665_data *data = dev_get_drvdata(dev);
 
 	return data->alarm_min_limit[index];
 }
 
 static int smm665_get_max(struct device *dev, int index)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smm665_data *data = i2c_get_clientdata(client);
+	struct smm665_data *data = dev_get_drvdata(dev);
 
 	return data->alarm_max_limit[index];
 }
 
 static int smm665_get_lcrit(struct device *dev, int index)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smm665_data *data = i2c_get_clientdata(client);
+	struct smm665_data *data = dev_get_drvdata(dev);
 
 	return data->critical_min_limit[index];
 }
 
 static int smm665_get_crit(struct device *dev, int index)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smm665_data *data = i2c_get_clientdata(client);
+	struct smm665_data *data = dev_get_drvdata(dev);
 
 	return data->critical_max_limit[index];
 }
@@ -486,7 +482,7 @@ SMM665_ATTR(temp1, crit_alarm, SMM665_FAULT_TEMP);
  * Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
-static struct attribute *smm665_attributes[] = {
+static struct attribute *smm665_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
@@ -567,15 +563,14 @@ static struct attribute *smm665_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group smm665_group = {
-	.attrs = smm665_attributes,
-};
+ATTRIBUTE_GROUPS(smm665);
 
 static int smm665_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct smm665_data *data;
+	struct device *hwmon_dev;
 	int i, ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
@@ -592,6 +587,7 @@ static int smm665_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
+	data->client = client;
 	data->type = id->driver_data;
 	data->cmdreg = i2c_new_dummy(adapter, (client->addr & ~SMM665_REGMASK)
 				     | SMM665_CMDREG_BASE);
@@ -662,21 +658,16 @@ static int smm665_probe(struct i2c_client *client,
 			data->alarm_max_limit[i] = smm665_convert(val, i);
 	}
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &smm665_group);
-	if (ret)
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   smm665_groups);
+	if (IS_ERR(hwmon_dev)) {
+		ret = PTR_ERR(hwmon_dev);
 		goto out_unregister;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto out_remove_group;
 	}
 
 	return 0;
 
-out_remove_group:
-	sysfs_remove_group(&client->dev.kobj, &smm665_group);
 out_unregister:
 	i2c_unregister_device(data->cmdreg);
 	return ret;
@@ -687,9 +678,6 @@ static int smm665_remove(struct i2c_client *client)
 	struct smm665_data *data = i2c_get_clientdata(client);
 
 	i2c_unregister_device(data->cmdreg);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &smm665_group);
-
 	return 0;
 }
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
