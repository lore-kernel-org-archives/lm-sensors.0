From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 19 Aug 2006 16:08:05 +0000
Subject: [lm-sensors] [patch 3/3] pc87360 - fix unchecked
Message-Id: <44E73765.80603@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


3- rework sys-device-interface startup
    use sysfs_create_group() for 2 sensor-types which are chip-model 
invariant.
       ie all-or-nothing attribute groups
    other 2 groups vary too much due to configuration, etc,
       so we keep the loops of device_create_file(), but now check their 
returns.

Signed-off-by:   Jim Cromie  <jim.cromie at gmail.com>

[jimc at harpo hwmon-stuff]$ diffstat diff.ab-3.20060818.185837
 pc87360.c |   90 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 46 insertions(+), 44 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs ab-2/drivers/hwmon/pc87360.c ab-3/drivers/hwmon/pc87360.c
--- ab-2/drivers/hwmon/pc87360.c	2006-08-18 17:40:35.000000000 -0600
+++ ab-3/drivers/hwmon/pc87360.c	2006-08-18 18:54:24.000000000 -0600
@@ -1017,67 +1017,69 @@ static int pc87360_detect(struct i2c_ada
 		pc87360_init_client(client, use_thermistors);
 	}
 
-	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	/* Register all-or-nothing sysfs groups */
+
+	if (data->innr && 
+	    sysfs_create_group(&client->dev.kobj,
+			       &pc8736x_vin_group))
 		goto ERROR3;
-	}
 
-	if (data->innr) {
-		for (i = 0; i < 11; i++) {
-			device_create_file(dev, &in_input[i].dev_attr);
-			device_create_file(dev, &in_min[i].dev_attr);
-			device_create_file(dev, &in_max[i].dev_attr);
-			device_create_file(dev, &in_status[i].dev_attr);
-		}
-		device_create_file(dev, &dev_attr_cpu0_vid);
-		device_create_file(dev, &dev_attr_vrm);
-		device_create_file(dev, &dev_attr_alarms_in);
-	}
+	if (data->innr = 14 &&
+	    sysfs_create_group(&client->dev.kobj, 
+			       &pc8736x_therm_group))
+		goto ERROR3;
+
+	/* create device attr-files for varying sysfs groups */
 
 	if (data->tempnr) {
 		for (i = 0; i < data->tempnr; i++) {
-			device_create_file(dev, &temp_input[i].dev_attr);
-			device_create_file(dev, &temp_min[i].dev_attr);
-			device_create_file(dev, &temp_max[i].dev_attr);
-			device_create_file(dev, &temp_crit[i].dev_attr);
-			device_create_file(dev, &temp_status[i].dev_attr);
-		}
-		device_create_file(dev, &dev_attr_alarms_temp);
-	}
-
-	if (data->innr = 14) {
-		for (i = 0; i < 3; i++) {
-			device_create_file(dev, &therm_input[i].dev_attr);
-			device_create_file(dev, &therm_min[i].dev_attr);
-			device_create_file(dev, &therm_max[i].dev_attr);
-			device_create_file(dev, &therm_crit[i].dev_attr);
-			device_create_file(dev, &therm_status[i].dev_attr);
+			if (device_create_file(dev, &temp_input[i].dev_attr)
+			    || device_create_file(dev, &temp_min[i].dev_attr)
+			    || device_create_file(dev, &temp_max[i].dev_attr)
+			    || device_create_file(dev, &temp_crit[i].dev_attr)
+			    || device_create_file(dev, &temp_status[i].dev_attr))
+
+				goto ERROR3;
 		}
+		if (device_create_file(dev, &dev_attr_alarms_temp))
+			goto ERROR3;
 	}
 
 	for (i = 0; i < data->fannr; i++) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
-			device_create_file(dev, &fan_input[i].dev_attr);
-			device_create_file(dev, &fan_min[i].dev_attr);
-			device_create_file(dev, &fan_div[i].dev_attr);
-			device_create_file(dev, &fan_status[i].dev_attr);
-		}
-		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
-			device_create_file(dev, &pwm[i].dev_attr);
+
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i)
+		    && device_create_file(dev, &pwm[i].dev_attr))
+
+			goto ERROR3;
+
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i)
+		    && (device_create_file(dev, &fan_input[i].dev_attr)
+			|| device_create_file(dev, &fan_min[i].dev_attr)
+			|| device_create_file(dev, &fan_div[i].dev_attr)
+			|| device_create_file(dev, &fan_status[i].dev_attr)))
+
+			goto ERROR3;
 	}
 
+	data->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
 	return 0;
 
 ERROR3:
+	/* can still remove groups whose members were added individually */
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
+
 	i2c_detach_client(client);
 ERROR2:
-	for (i = 0; i < 3; i++) {
-		if (data->address[i]) {
+	for (i = 0; i < 3; i++)
+		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-		}
-	}
 ERROR1:
 	kfree(data);
 	return err;



