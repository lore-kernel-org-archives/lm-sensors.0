From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 07:01:28 +0000
Subject: [lm-sensors] patch
Message-Id: <20060928070125.6636C902DCA@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 12/23] w83627ehf: Fix unchecked return status

to my gregkh-2.6 tree.  Its filename is

     hwmon-unchecked-return-status-fixes-w83627ehf.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 12:04:49 2006
Date: Sun, 24 Sep 2006 21:04:38 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, David Hubbard <david.c.hubbard at gmail.com>
Subject: [PATCH 12/23] w83627ehf: Fix unchecked return status
Message-Id: <20060924210438.23b3af5b.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-w83627ehf.patch

From: David Hubbard <david.c.hubbard at gmail.com>

w83627ehf: Fix unchecked return status

Fix: check return value from device_create_file()
Fix: call device_remove_file() on error and module unload
Fix: call hwmon_device_register() after device_create_file() to eliminate race

Signed-off-by: David Hubbard <david.c.hubbard at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/w83627ehf.c |  122 ++++++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 40 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/w83627ehf.c
+++ gregkh-2.6/drivers/hwmon/w83627ehf.c
@@ -4,6 +4,7 @@
     Copyright (C) 2005  Jean Delvare <khali at linux-fr.org>
     Copyright (C) 2006  Yuan Mu <Ymu at Winbond.com.tw>,
                         Rudolf Marek <r.marek at sh.cvut.cz>
+                        David Hubbard <david.c.hubbard at gmail.com>
 
     Shamelessly ripped from the w83627hf driver
     Copyright (C) 2003  Mark Studebaker
@@ -621,14 +622,6 @@ static struct sensor_device_attribute sd
        SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 9),
 };
 
-static void device_create_file_in(struct device *dev, int i)
-{
-	device_create_file(dev, &sda_in_input[i].dev_attr);
-	device_create_file(dev, &sda_in_alarm[i].dev_attr);
-	device_create_file(dev, &sda_in_min[i].dev_attr);
-	device_create_file(dev, &sda_in_max[i].dev_attr);
-}
-
 #define show_fan_reg(reg) \
 static ssize_t \
 show_##reg(struct device *dev, struct device_attribute *attr, \
@@ -756,14 +749,6 @@ static struct sensor_device_attribute sd
 	SENSOR_ATTR(fan5_div, S_IRUGO, show_fan_div, NULL, 4),
 };
 
-static void device_create_file_fan(struct device *dev, int i)
-{
-	device_create_file(dev, &sda_fan_input[i].dev_attr);
-	device_create_file(dev, &sda_fan_alarm[i].dev_attr);
-	device_create_file(dev, &sda_fan_div[i].dev_attr);
-	device_create_file(dev, &sda_fan_min[i].dev_attr);
-}
-
 #define show_temp1_reg(reg) \
 static ssize_t \
 show_##reg(struct device *dev, struct device_attribute *attr, \
@@ -1036,15 +1021,6 @@ static struct sensor_device_attribute sd
 		    store_tolerance, 3),
 };
 
-static void device_create_file_pwm(struct device *dev, int i)
-{
-	device_create_file(dev, &sda_pwm[i].dev_attr);
-	device_create_file(dev, &sda_pwm_mode[i].dev_attr);
-	device_create_file(dev, &sda_pwm_enable[i].dev_attr);
-	device_create_file(dev, &sda_target_temp[i].dev_attr);
-	device_create_file(dev, &sda_tolerance[i].dev_attr);
-}
-
 /* Smart Fan registers */
 
 #define fan_functions(reg, REG) \
@@ -1131,6 +1107,39 @@ static struct sensor_device_attribute sd
  * Driver and client management
  */
 
+static void w83627ehf_device_remove_files(struct device *dev)
+{
+	/* some entries in the following arrays may not have been used in
+	 * device_create_file(), but device_remove_file() will ignore them */
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
+		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
+	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
+		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
+	for (i = 0; i < 10; i++) {
+		device_remove_file(dev, &sda_in_input[i].dev_attr);
+		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
+		device_remove_file(dev, &sda_in_min[i].dev_attr);
+		device_remove_file(dev, &sda_in_max[i].dev_attr);
+	}
+	for (i = 0; i < 5; i++) {
+		device_remove_file(dev, &sda_fan_input[i].dev_attr);
+		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
+		device_remove_file(dev, &sda_fan_div[i].dev_attr);
+		device_remove_file(dev, &sda_fan_min[i].dev_attr);
+	}
+	for (i = 0; i < 4; i++) {
+		device_remove_file(dev, &sda_pwm[i].dev_attr);
+		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
+		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
+		device_remove_file(dev, &sda_target_temp[i].dev_attr);
+		device_remove_file(dev, &sda_tolerance[i].dev_attr);
+	}
+	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
+		device_remove_file(dev, &sda_temp[i].dev_attr);
+}
+
 static struct i2c_driver w83627ehf_driver;
 
 static void w83627ehf_init_client(struct i2c_client *client)
@@ -1217,37 +1226,69 @@ static int w83627ehf_detect(struct i2c_a
 		data->has_fan |= (1 << 4);
 
 	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
-	}
-
   	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
-  		device_create_file(dev, &sda_sf3_arrays[i].dev_attr);
+		if ((err = device_create_file(dev,
+			&sda_sf3_arrays[i].dev_attr)))
+			goto exit_remove;
 
 	/* if fan4 is enabled create the sf3 files for it */
 	if (data->has_fan & (1 << 3))
-		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
-			device_create_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
+		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
+			if ((err = device_create_file(dev,
+				&sda_sf3_arrays_fan4[i].dev_attr)))
+				goto exit_remove;
+		}
 
 	for (i = 0; i < 10; i++)
-		device_create_file_in(dev, i);
+		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_in_alarm[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_in_min[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_in_max[i].dev_attr)))
+			goto exit_remove;
 
 	for (i = 0; i < 5; i++) {
 		if (data->has_fan & (1 << i)) {
-			device_create_file_fan(dev, i);
-			if (i != 4) /* we have only 4 pwm */
-				device_create_file_pwm(dev, i);
+			if ((err = device_create_file(dev,
+					&sda_fan_input[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_fan_alarm[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_fan_div[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_fan_min[i].dev_attr)))
+				goto exit_remove;
+			if (i < 4 && /* w83627ehf only has 4 pwm */
+				((err = device_create_file(dev,
+					&sda_pwm[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_pwm_mode[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_pwm_enable[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_target_temp[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_tolerance[i].dev_attr))))
+				goto exit_remove;
 		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
-		device_create_file(dev, &sda_temp[i].dev_attr);
+		if ((err = device_create_file(dev, &sda_temp[i].dev_attr)))
+			goto exit_remove;
+
+	data->class_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_remove;
+	}
 
 	return 0;
 
-exit_detach:
+exit_remove:
+	w83627ehf_device_remove_files(dev);
 	i2c_detach_client(client);
 exit_free:
 	kfree(data);
@@ -1263,6 +1304,7 @@ static int w83627ehf_detach_client(struc
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	w83627ehf_device_remove_files(&client->dev);
 
 	if ((err = i2c_detach_client(client)))
 		return err;


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

