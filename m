From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 07:01:07 +0000
Subject: [lm-sensors] patch
Message-Id: <20060928070104.A0417902287@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 09/23] pc87360: Move some code around

to my gregkh-2.6 tree.  Its filename is

     hwmon-unchecked-return-status-fixes-pc87360-1.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 12:02:03 2006
Date: Sun, 24 Sep 2006 21:01:56 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Jim Cromie <jim.cromie at gmail.com>
Subject: [PATCH 09/23] pc87360: Move some code around
Message-Id: <20060924210156.4b9a5655.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-pc87360-1.patch

From: Jim Cromie <jim.cromie at gmail.com>

pc87360: Move some code around

Moves code for get-set-decl tuples for 3 items: cpu0_vid, vrm, alarms_in
up, to just after the get-set-decl tuple for voltages.
These items are already 'activated' together with the rest of the 
voltage attributes, so the move tightens the grouping that's made
explicit in next patch.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/pc87360.c |   56 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/pc87360.c
+++ gregkh-2.6/drivers/hwmon/pc87360.c
@@ -472,6 +472,34 @@ static struct sensor_device_attribute in
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->vrm);
+}
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	data->vrm = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_alarms);
+}
+static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -590,34 +618,6 @@ static struct sensor_device_attribute th
 		    show_therm_crit, set_therm_crit, 2+11),
 };
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
-}
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	data->vrm = simple_strtoul(buf, NULL, 10);
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
-static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_alarms);
-}
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
-
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);


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

