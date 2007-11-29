From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 22:47:54 +0000
Subject: [lm-sensors] |PATCH 4/4] hwmon: (adm1026) Don't create files for
Message-Id: <20071129234754.306c14ec@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the ADM1026, pins 27 and 28 can be used for two different functions:
either temp3, or in8+in9. We should only create the sysfs files for the
function that is configured, otherwise it is confusing for the user.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1026.c |   70 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 20 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1026.c	2007-11-29 22:29:53.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1026.c	2007-11-29 22:58:24.000000000 +0100
@@ -1508,14 +1508,6 @@ static struct attribute *adm1026_attribu
 	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in7_min.dev_attr.attr,
 	&sensor_dev_attr_in7_alarm.dev_attr.attr,
-	&sensor_dev_attr_in8_input.dev_attr.attr,
-	&sensor_dev_attr_in8_max.dev_attr.attr,
-	&sensor_dev_attr_in8_min.dev_attr.attr,
-	&sensor_dev_attr_in8_alarm.dev_attr.attr,
-	&sensor_dev_attr_in9_input.dev_attr.attr,
-	&sensor_dev_attr_in9_max.dev_attr.attr,
-	&sensor_dev_attr_in9_min.dev_attr.attr,
-	&sensor_dev_attr_in9_alarm.dev_attr.attr,
 	&sensor_dev_attr_in10_input.dev_attr.attr,
 	&sensor_dev_attr_in10_max.dev_attr.attr,
 	&sensor_dev_attr_in10_min.dev_attr.attr,
@@ -1584,28 +1576,18 @@ static struct attribute *adm1026_attribu
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_input.dev_attr.attr,
-	&sensor_dev_attr_temp3_max.dev_attr.attr,
-	&sensor_dev_attr_temp3_min.dev_attr.attr,
-	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
-	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	&sensor_dev_attr_temp1_auto_point1_temp.dev_attr.attr,
 	&sensor_dev_attr_temp2_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_temp3_auto_point1_temp.dev_attr.attr,
 	&sensor_dev_attr_temp1_auto_point1_temp_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp2_auto_point1_temp_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp3_auto_point1_temp_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_temp2_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_temp3_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
-	&sensor_dev_attr_temp3_crit.dev_attr.attr,
 	&dev_attr_temp1_crit_enable.attr,
 	&dev_attr_temp2_crit_enable.attr,
-	&dev_attr_temp3_crit_enable.attr,
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
 	&dev_attr_alarms.attr,
@@ -1620,10 +1602,8 @@ static struct attribute *adm1026_attribu
 	&dev_attr_pwm3_enable.attr,
 	&dev_attr_temp1_auto_point1_pwm.attr,
 	&dev_attr_temp2_auto_point1_pwm.attr,
-	&dev_attr_temp3_auto_point1_pwm.attr,
 	&dev_attr_temp1_auto_point2_pwm.attr,
 	&dev_attr_temp2_auto_point2_pwm.attr,
-	&dev_attr_temp3_auto_point2_pwm.attr,
 	&dev_attr_analog_out.attr,
 	NULL
 };
@@ -1632,6 +1612,40 @@ static const struct attribute_group adm1
 	.attrs = adm1026_attributes,
 };
 
+static struct attribute *adm1026_attributes_temp3[] = {
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&dev_attr_temp3_crit_enable.attr,
+	&dev_attr_temp3_auto_point1_pwm.attr,
+	&dev_attr_temp3_auto_point2_pwm.attr,
+};
+
+static const struct attribute_group adm1026_group_temp3 = {
+	.attrs = adm1026_attributes_temp3,
+};
+
+static struct attribute *adm1026_attributes_in8_9[] = {
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in8_max.dev_attr.attr,
+	&sensor_dev_attr_in8_min.dev_attr.attr,
+	&sensor_dev_attr_in8_alarm.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in9_max.dev_attr.attr,
+	&sensor_dev_attr_in9_min.dev_attr.attr,
+	&sensor_dev_attr_in9_alarm.dev_attr.attr,
+};
+
+static const struct attribute_group adm1026_group_in8_9 = {
+	.attrs = adm1026_attributes_in8_9,
+};
+
 static int adm1026_detect(struct i2c_adapter *adapter, int address,
 			  int kind)
 {
@@ -1734,6 +1748,14 @@ static int adm1026_detect(struct i2c_ada
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &adm1026_group)))
 		goto exitdetach;
+	if (data->config1 & CFG1_AIN8_9)
+		err = sysfs_create_group(&client->dev.kobj,
+					 &adm1026_group_in8_9);
+	else
+		err = sysfs_create_group(&client->dev.kobj,
+					 &adm1026_group_temp3);
+	if (err)
+		goto exitremove;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1746,6 +1768,10 @@ static int adm1026_detect(struct i2c_ada
 	/* Error out and cleanup code */
 exitremove:
 	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
+	if (data->config1 & CFG1_AIN8_9)
+		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
+	else
+		sysfs_remove_group(&client->dev.kobj, &adm1026_group_temp3);
 exitdetach:
 	i2c_detach_client(client);
 exitfree:
@@ -1759,6 +1785,10 @@ static int adm1026_detach_client(struct 
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
+	if (data->config1 & CFG1_AIN8_9)
+		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
+	else
+		sysfs_remove_group(&client->dev.kobj, &adm1026_group_temp3);
 	i2c_detach_client(client);
 	kfree(data);
 	return 0;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
