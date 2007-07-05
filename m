From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 18:37:21 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon/lm85: Export in5,
Message-Id: <20070705203721.4138e022@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The SMSC EMC6D100 supports 3 additional voltage channels. The lm85
driver reads the register values for these, but doesn't create the
corresponding sysfs files, so the user can't read the values nor write
the limits. Create the missing sysfs files.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

--- linux-2.6.22-rc6.orig/drivers/hwmon/lm85.c	2007-07-01 11:08:58.000000000 +0200
+++ linux-2.6.22-rc6/drivers/hwmon/lm85.c	2007-07-01 12:41:52.000000000 +0200
@@ -595,6 +595,9 @@ show_in_reg(1);
 show_in_reg(2);
 show_in_reg(3);
 show_in_reg(4);
+show_in_reg(5);
+show_in_reg(6);
+show_in_reg(7);
 
 /* Temps */
 
@@ -1030,15 +1033,32 @@ static const struct attribute_group lm85
 	.attrs = lm85_attributes,
 };
 
-static struct attribute *lm85_attributes_opt[] = {
+static struct attribute *lm85_attributes_in4[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	NULL
 };
 
-static const struct attribute_group lm85_group_opt = {
-	.attrs = lm85_attributes_opt,
+static const struct attribute_group lm85_group_in4 = {
+	.attrs = lm85_attributes_in4,
+};
+
+static struct attribute *lm85_attributes_in567[] = {
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in7_min.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in7_max.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm85_group_in567 = {
+	.attrs = lm85_attributes_in567,
 };
 
 static int lm85_detect(struct i2c_adapter *adapter, int address,
@@ -1186,12 +1206,14 @@ static int lm85_detect(struct i2c_adapte
 	   as a sixth digital VID input rather than an analog input. */
 	data->vid = lm85_read_value(new_client, LM85_REG_VID);
 	if (!(kind = adt7463 && (data->vid & 0x80)))
-		if ((err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_input.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_min.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_max.dev_attr)))
+		if ((err = sysfs_create_group(&new_client->dev.kobj,
+					&lm85_group_in4)))
+			goto ERROR3;
+
+	/* The EMC6D100 has 3 additional voltage inputs */
+	if (kind = emc6d100)
+		if ((err = sysfs_create_group(&new_client->dev.kobj,
+					&lm85_group_in567)))
 			goto ERROR3;
 
 	data->class_dev = hwmon_device_register(&new_client->dev);
@@ -1205,7 +1227,9 @@ static int lm85_detect(struct i2c_adapte
 	/* Error out and cleanup code */
     ERROR3:
 	sysfs_remove_group(&new_client->dev.kobj, &lm85_group);
-	sysfs_remove_group(&new_client->dev.kobj, &lm85_group_opt);
+	sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in4);
+	if (kind = emc6d100)
+		sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in567);
     ERROR2:
 	i2c_detach_client(new_client);
     ERROR1:
@@ -1219,7 +1243,9 @@ static int lm85_detach_client(struct i2c
 	struct lm85_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm85_group);
-	sysfs_remove_group(&client->dev.kobj, &lm85_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
+	if (data->type = emc6d100)
+		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
 	i2c_detach_client(client);
 	kfree(data);
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
