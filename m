From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Sep 2006 11:45:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: unchecked return status fixes
Message-Id: <20060922134559.7ca8d96c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060831220610.19a79141.khali@linux-fr.org>
In-Reply-To: <20060831220610.19a79141.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix up 5 more hwmon drivers so that they no longer ignore return
status from device_create_file(). Untested.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/atxp1.c   |   24 +++++++++--
 drivers/hwmon/ds1621.c  |   27 +++++++++----
 drivers/hwmon/max1619.c |   32 +++++++++++----
 drivers/hwmon/sis5595.c |  100 +++++++++++++++++++++++++++++++++--------------
 drivers/hwmon/via686a.c |   82 +++++++++++++++++++++++----------------
 5 files changed, 180 insertions(+), 85 deletions(-)

--- linux-2.6.18.orig/drivers/hwmon/atxp1.c	2006-09-21 21:41:55.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/atxp1.c	2006-09-22 13:32:30.000000000 +0200
@@ -250,6 +250,17 @@
 */
 static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
 
+static struct attribute *atxp1_attributes[] = {
+	&dev_attr_gpio1.attr,
+	&dev_attr_gpio2.attr,
+	&dev_attr_cpu0_vid.attr,
+	NULL
+};
+
+static const struct attribute_group atxp1_group = {
+	.attrs = atxp1_attributes,
+};
+
 
 static int atxp1_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -319,21 +330,23 @@
 		goto exit_free;
 	}
 
+	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group)))
+		goto exit_detach;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove_files;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_gpio1);
-	device_create_file(&new_client->dev, &dev_attr_gpio2);
-	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
-
 	dev_info(&new_client->dev, "Using VRM: %d.%d\n",
 			 data->vrm / 10, data->vrm % 10);
 
 	return 0;
 
+exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &atxp1_group);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
@@ -348,6 +361,7 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
 
 	err = i2c_detach_client(client);
 
--- linux-2.6.18.orig/drivers/hwmon/ds1621.c	2006-09-21 21:25:05.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/ds1621.c	2006-09-22 13:12:28.000000000 +0200
@@ -178,6 +178,18 @@
 static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO , show_temp_min, set_temp_min);
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
 
+static struct attribute *ds1621_attributes[] = {
+	&dev_attr_alarms.attr,
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_min.attr,
+	&dev_attr_temp1_max.attr,
+	NULL
+};
+
+static const struct attribute_group ds1621_group = {
+	.attrs = ds1621_attributes,
+};
+
 
 static int ds1621_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -253,21 +265,19 @@
 	ds1621_init_client(new_client);
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &ds1621_group)))
+		goto exit_detach;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove_files;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
+      exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &ds1621_group);
       exit_detach:
 	i2c_detach_client(new_client);
       exit_free:
@@ -282,6 +292,7 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
--- linux-2.6.18.orig/drivers/hwmon/max1619.c	2006-09-21 21:25:05.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/max1619.c	2006-09-22 13:34:07.000000000 +0200
@@ -172,6 +172,22 @@
 	set_temp_hyst2);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static struct attribute *max1619_attributes[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp2_min.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp2_crit.attr,
+	&dev_attr_temp2_crit_hyst.attr,
+
+	&dev_attr_alarms.attr,
+	NULL
+};
+
+static const struct attribute_group max1619_group = {
+	.attrs = max1619_attributes,
+};
+
 /*
  * Real code
  */
@@ -273,22 +289,19 @@
 	max1619_init_client(new_client);
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &max1619_group)))
+		goto exit_detach;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove_files;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_min);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit_hyst);
-	device_create_file(&new_client->dev, &dev_attr_alarms);
-
 	return 0;
 
+exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &max1619_group);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
@@ -318,6 +331,7 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &max1619_group);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
--- linux-2.6.18.orig/drivers/hwmon/sis5595.c	2006-09-21 21:41:50.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/sis5595.c	2006-09-22 13:30:36.000000000 +0200
@@ -473,6 +473,50 @@
 	return sprintf(buf, "%d\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+static struct attribute *sis5595_attributes[] = {
+	&dev_attr_in0_input.attr,
+	&dev_attr_in0_min.attr,
+	&dev_attr_in0_max.attr,
+	&dev_attr_in1_input.attr,
+	&dev_attr_in1_min.attr,
+	&dev_attr_in1_max.attr,
+	&dev_attr_in2_input.attr,
+	&dev_attr_in2_min.attr,
+	&dev_attr_in2_max.attr,
+	&dev_attr_in3_input.attr,
+	&dev_attr_in3_min.attr,
+	&dev_attr_in3_max.attr,
+
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_min.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan2_min.attr,
+	&dev_attr_fan2_div.attr,
+
+	&dev_attr_alarms.attr,
+	NULL
+};
+
+static const struct attribute_group sis5595_group = {
+	.attrs = sis5595_attributes,
+};
+
+static struct attribute *sis5595_attributes_opt[] = {
+	&dev_attr_in4_input.attr,
+	&dev_attr_in4_min.attr,
+	&dev_attr_in4_max.attr,
+
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_max_hyst.attr,
+	NULL
+};
+
+static const struct attribute_group sis5595_group_opt = {
+	.attrs = sis5595_attributes_opt,
+};
  
 /* This is called when the module is loaded */
 static int sis5595_detect(struct i2c_adapter *adapter)
@@ -566,43 +610,37 @@
 	}
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &sis5595_group)))
+		goto exit_detach;
+	if (data->maxins = 4) {
+		if ((err = device_create_file(&new_client->dev,
+					      &dev_attr_in4_input))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_in4_min))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_in4_max)))
+			goto exit_remove_files;
+	} else {
+		if ((err = device_create_file(&new_client->dev,
+					      &dev_attr_temp1_input))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_temp1_max))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_temp1_max_hyst)))
+			goto exit_remove_files;
+	}
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove_files;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	if (data->maxins = 4) {
-		device_create_file(&new_client->dev, &dev_attr_in4_input);
-		device_create_file(&new_client->dev, &dev_attr_in4_min);
-		device_create_file(&new_client->dev, &dev_attr_in4_max);
-	}
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_alarms);
-	if (data->maxins = 3) {
-		device_create_file(&new_client->dev, &dev_attr_temp1_input);
-		device_create_file(&new_client->dev, &dev_attr_temp1_max);
-		device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
-	}
 	return 0;
 
+exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &sis5595_group);
+	sysfs_remove_group(&new_client->dev.kobj, &sis5595_group_opt);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
@@ -619,6 +657,8 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &sis5595_group);
+	sysfs_remove_group(&client->dev.kobj, &sis5595_group_opt);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
--- linux-2.6.18.orig/drivers/hwmon/via686a.c	2006-09-21 21:41:50.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/via686a.c	2006-09-22 13:31:03.000000000 +0200
@@ -570,6 +570,48 @@
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static struct attribute *via686a_attributes[] = {
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
+	&dev_attr_in2_input.attr,
+	&dev_attr_in3_input.attr,
+	&dev_attr_in4_input.attr,
+	&dev_attr_in0_min.attr,
+	&dev_attr_in1_min.attr,
+	&dev_attr_in2_min.attr,
+	&dev_attr_in3_min.attr,
+	&dev_attr_in4_min.attr,
+	&dev_attr_in0_max.attr,
+	&dev_attr_in1_max.attr,
+	&dev_attr_in2_max.attr,
+	&dev_attr_in3_max.attr,
+	&dev_attr_in4_max.attr,
+
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp3_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp3_max.attr,
+	&dev_attr_temp1_max_hyst.attr,
+	&dev_attr_temp2_max_hyst.attr,
+	&dev_attr_temp3_max_hyst.attr,
+
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan1_min.attr,
+	&dev_attr_fan2_min.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan2_div.attr,
+
+	&dev_attr_alarms.attr,
+	NULL
+};
+
+static const struct attribute_group via686a_group = {
+	.attrs = via686a_attributes,
+};
+
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
@@ -650,46 +692,19 @@
 	via686a_init_client(new_client);
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &via686a_group)))
+		goto exit_detach;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove_files;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp3_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp3_max_hyst);
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_alarms);
-
 	return 0;
 
+exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &via686a_group);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
@@ -705,6 +720,7 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &via686a_group);
 
 	if ((err = i2c_detach_client(client)))
 		return err;

-- 
Jean Delvare

