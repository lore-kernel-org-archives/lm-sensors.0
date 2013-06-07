From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Jun 2013 15:51:19 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (adm1021) Do not create min sysfs attributes for LM84
Message-Id: <1370620280-32415-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM84 does not support minimum temperature registers.
Only create the respective sysfs attributes for other chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1021.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 7e76922..08f3762 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -284,15 +284,11 @@ static DEVICE_ATTR(low_power, S_IWUSR | S_IRUGO, show_low_power, set_low_power);
 
 static struct attribute *adm1021_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
-	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_low_power.attr,
@@ -303,6 +299,18 @@ static const struct attribute_group adm1021_group = {
 	.attrs = adm1021_attributes,
 };
 
+static struct attribute *adm1021_min_attributes[] = {
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adm1021_min_group = {
+	.attrs = adm1021_min_attributes,
+};
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int adm1021_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -383,6 +391,12 @@ static int adm1021_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
+	if (data->type != lm84) {
+		err = sysfs_create_group(&client->dev.kobj, &adm1021_min_group);
+		if (err)
+			goto error;
+	}
+
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
@@ -392,6 +406,7 @@ static int adm1021_probe(struct i2c_client *client,
 	return 0;
 
 error:
+	sysfs_remove_group(&client->dev.kobj, &adm1021_min_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
 	return err;
 }
@@ -410,6 +425,7 @@ static int adm1021_remove(struct i2c_client *client)
 	struct adm1021_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &adm1021_min_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
 
 	return 0;
@@ -435,9 +451,11 @@ static struct adm1021_data *adm1021_update_device(struct device *dev)
 			data->temp_max[i] = 1000 *
 				(s8) i2c_smbus_read_byte_data(
 					client, ADM1021_REG_TOS_R(i));
-			data->temp_min[i] = 1000 *
-				(s8) i2c_smbus_read_byte_data(
-					client, ADM1021_REG_THYST_R(i));
+			if (data->type != lm84) {
+				data->temp_min[i] = 1000 *
+				  (s8) i2c_smbus_read_byte_data(client,
+							ADM1021_REG_THYST_R(i));
+			}
 		}
 		data->alarms = i2c_smbus_read_byte_data(client,
 						ADM1021_REG_STATUS) & 0x7c;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
