From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 07:01:42 +0000
Subject: [lm-sensors] patch
Message-Id: <20060928070139.C6B42902D5A@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 19/23] w83l785ts: Fix unchecked return status

to my gregkh-2.6 tree.  Its filename is

     hwmon-unchecked-return-status-fixes-w83l785ts.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 12:23:29 2006
Date: Sun, 24 Sep 2006 21:23:26 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Rudolf Marek <r.marek at assembler.cz>
Subject: [PATCH 19/23] w83l785ts: Fix unchecked return status
Message-Id: <20060924212326.f391f226.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-w83l785ts.patch

From: Rudolf Marek <r.marek at assembler.cz>

w83l785ts: Fix unchecked return status

Fix the w83l785ts driver. Add error checking to device_create_file
and also care to destroy the files upon exit.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/w83l785ts.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/w83l785ts.c
+++ gregkh-2.6/drivers/hwmon/w83l785ts.c
@@ -236,21 +236,30 @@ static int w83l785ts_detect(struct i2c_a
 	 * Nothing yet, assume it is already started.
 	 */
 
+	err = device_create_file(&new_client->dev,
+				 &sensor_dev_attr_temp1_input.dev_attr);
+	if (err)
+		goto exit_remove;
+
+	err = device_create_file(&new_client->dev,
+				 &sensor_dev_attr_temp1_max.dev_attr);
+	if (err)
+		goto exit_remove;
+
 	/* Register sysfs hooks */
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove;
 	}
 
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp1_input.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp1_max.dev_attr);
-
 	return 0;
 
-exit_detach:
+exit_remove:
+	device_remove_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_remove_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
 	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
@@ -264,7 +273,10 @@ static int w83l785ts_detach_client(struc
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
-
+	device_remove_file(&client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_remove_file(&client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
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

