From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 07:01:15 +0000
Subject: [lm-sensors] patch
Message-Id: <20060928070112.6BE118FF210@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 11/23] pc87360: Check for error on sysfs files creation

to my gregkh-2.6 tree.  Its filename is

     hwmon-unchecked-return-status-fixes-pc87360-3.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 12:03:32 2006
Date: Sun, 24 Sep 2006 21:03:25 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Jim Cromie <jim.cromie at gmail.com>
Subject: [PATCH 11/23] pc87360: Check for error on sysfs files creation
Message-Id: <20060924210325.901a1206.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-pc87360-3.patch

From: Jim Cromie <jim.cromie at gmail.com>

pc87360: Check for error on sysfs files creation

Use sysfs_create_group() for 2 sensor-types which are chip-model
invariant, i.e. all-or-nothing attribute groups.
Other 2 groups vary too much due to configuration, etc, so we keep the
loops of device_create_file(), but now check their returns.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/pc87360.c |   89 ++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/pc87360.c
+++ gregkh-2.6/drivers/hwmon/pc87360.c
@@ -1018,60 +1018,69 @@ static int pc87360_detect(struct i2c_ada
 		pc87360_init_client(client, use_thermistors);
 	}
 
-	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	/* Register all-or-nothing sysfs groups */
+
+	if (data->innr &&
+	    (err = sysfs_create_group(&client->dev.kobj,
+				      &pc8736x_vin_group)))
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
+	    (err = sysfs_create_group(&client->dev.kobj,
+				      &pc8736x_therm_group)))
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
+			if ((err = device_create_file(dev,
+					&temp_input[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_min[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_max[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_crit[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_status[i].dev_attr)))
+				goto ERROR3;
 		}
+		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
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
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i)
+		    && ((err = device_create_file(dev,
+					&fan_input[i].dev_attr))
+			|| (err = device_create_file(dev,
+					&fan_min[i].dev_attr))
+			|| (err = device_create_file(dev,
+					&fan_div[i].dev_attr))
+			|| (err = device_create_file(dev,
+					&fan_status[i].dev_attr))))
+			goto ERROR3;
+
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i)
+		    && (err = device_create_file(dev, &pwm[i].dev_attr)))
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
 	for (i = 0; i < 3; i++) {


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/hwmon-k8temp-documentation.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/hwmon-individual-alarm-files-1.patch
i2c/hwmon-kconfig-update.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/hwmon-remove-yuan-mu-address.patch
i2c/hwmon-unchecked-return-status-fixes-1.patch
i2c/hwmon-unchecked-return-status-fixes-2.patch
i2c/hwmon-unchecked-return-status-fixes-3.patch
i2c/hwmon-unchecked-return-status-fixes-4.patch
i2c/hwmon-unchecked-return-status-fixes-5.patch
i2c/hwmon-unchecked-return-status-fixes-6.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-1.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-2.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-3.patch
i2c/hwmon-unchecked-return-status-fixes-smsc.patch
i2c/hwmon-unchecked-return-status-fixes-vt8231.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch
i2c/hwmon-unchecked-return-status-fixes-w83627ehf.patch
i2c/hwmon-unchecked-return-status-fixes-w83781d.patch
i2c/hwmon-unchecked-return-status-fixes-w83792d.patch
i2c/hwmon-unchecked-return-status-fixes-w83l785ts.patch
i2c/hwmon-vt1211-add-module-parameters-description.patch
i2c/hwmon-vt1211-documentation.patch
i2c/hwmon-vt1211-new-driver.patch
i2c/hwmon-w83791d-doc-update.patch
driver-class/i2c-dev-device.patch
driver-class/i2c-dev-device.old.patch

