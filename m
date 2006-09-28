From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 07:01:11 +0000
Subject: [lm-sensors] patch
Message-Id: <20060928070108.776E072C18F@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 10/23] pc87360: Delete sysfs files on device deletion

to my gregkh-2.6 tree.  Its filename is

     hwmon-unchecked-return-status-fixes-pc87360-2.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 12:02:48 2006
Date: Sun, 24 Sep 2006 21:02:44 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Jim Cromie <jim.cromie at gmail.com>
Subject: [PATCH 10/23] pc87360: Delete sysfs files on device deletion
Message-Id: <20060924210244.4df2c16a.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-pc87360-2.patch

From: Jim Cromie <jim.cromie at gmail.com>

pc87360: Delete sysfs files on device deletion

Add 4 explicit attribute groups for the 5 sensor types:
voltage (in), therm, temp, and fan & pwm (together in one group).
Use sysfs_remove_group() to drop them, but keeps the existing
startup code, which calls device_create_file in loops.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/pc87360.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

--- gregkh-2.6.orig/drivers/hwmon/pc87360.c
+++ gregkh-2.6/drivers/hwmon/pc87360.c
@@ -328,6 +328,12 @@ static struct sensor_device_attribute fa
 	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
 };
 
+#define FAN_UNIT_ATTRS(X)	\
+	&fan_input[X].dev_attr.attr,	\
+	&fan_status[X].dev_attr.attr,	\
+	&fan_div[X].dev_attr.attr,	\
+	&fan_min[X].dev_attr.attr
+
 static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -360,6 +366,19 @@ static struct sensor_device_attribute pw
 	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
 };
 
+static struct attribute * pc8736x_fan_attr_array[] = {
+	FAN_UNIT_ATTRS(0),
+	FAN_UNIT_ATTRS(1),
+	FAN_UNIT_ATTRS(2),
+	&pwm[0].dev_attr.attr,
+	&pwm[1].dev_attr.attr,
+	&pwm[2].dev_attr.attr,
+	NULL
+};
+static const struct attribute_group pc8736x_fan_group = {
+	.attrs = pc8736x_fan_attr_array,
+};
+
 static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -472,6 +491,12 @@ static struct sensor_device_attribute in
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+#define VIN_UNIT_ATTRS(X) \
+	&in_input[X].dev_attr.attr,	\
+	&in_status[X].dev_attr.attr,	\
+	&in_min[X].dev_attr.attr,	\
+	&in_max[X].dev_attr.attr
+
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
@@ -500,6 +525,27 @@ static ssize_t show_in_alarms(struct dev
 }
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
+static struct attribute *pc8736x_vin_attr_array[] = {
+	VIN_UNIT_ATTRS(0),
+	VIN_UNIT_ATTRS(1),
+	VIN_UNIT_ATTRS(2),
+	VIN_UNIT_ATTRS(3),
+	VIN_UNIT_ATTRS(4),
+	VIN_UNIT_ATTRS(5),
+	VIN_UNIT_ATTRS(6),
+	VIN_UNIT_ATTRS(7),
+	VIN_UNIT_ATTRS(8),
+	VIN_UNIT_ATTRS(9),
+	VIN_UNIT_ATTRS(10),
+	&dev_attr_cpu0_vid.attr,
+	&dev_attr_vrm.attr,
+	&dev_attr_alarms_in.attr,
+	NULL
+};
+static const struct attribute_group pc8736x_vin_group = {
+	.attrs = pc8736x_vin_attr_array,
+};
+
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -618,6 +664,23 @@ static struct sensor_device_attribute th
 		    show_therm_crit, set_therm_crit, 2+11),
 };
 
+#define THERM_UNIT_ATTRS(X) \
+	&therm_input[X].dev_attr.attr,	\
+	&therm_status[X].dev_attr.attr,	\
+	&therm_min[X].dev_attr.attr,	\
+	&therm_max[X].dev_attr.attr,	\
+	&therm_crit[X].dev_attr.attr
+
+static struct attribute * pc8736x_therm_attr_array[] = {
+	THERM_UNIT_ATTRS(0),
+	THERM_UNIT_ATTRS(1),
+	THERM_UNIT_ATTRS(2),
+	NULL
+};
+static const struct attribute_group pc8736x_therm_group = {
+	.attrs = pc8736x_therm_attr_array,
+};
+
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -736,6 +799,25 @@ static ssize_t show_temp_alarms(struct d
 }
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
+#define TEMP_UNIT_ATTRS(X) \
+	&temp_input[X].dev_attr.attr,	\
+	&temp_status[X].dev_attr.attr,	\
+	&temp_min[X].dev_attr.attr,	\
+	&temp_max[X].dev_attr.attr,	\
+	&temp_crit[X].dev_attr.attr
+
+static struct attribute * pc8736x_temp_attr_array[] = {
+	TEMP_UNIT_ATTRS(0),
+	TEMP_UNIT_ATTRS(1),
+	TEMP_UNIT_ATTRS(2),
+	/* include the few miscellaneous atts here */
+	&dev_attr_alarms_temp.attr,
+	NULL
+};
+static const struct attribute_group pc8736x_temp_group = {
+	.attrs = pc8736x_temp_attr_array,
+};
+
 /*
  * Device detection, registration and update
  */
@@ -1009,6 +1091,11 @@ static int pc87360_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
+
 	if ((i = i2c_detach_client(client)))
 		return i;
 


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

