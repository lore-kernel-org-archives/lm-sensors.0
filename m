From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 19 Aug 2006 16:00:48 +0000
Subject: [lm-sensors] [patch 2/3] pc87360 - fix unchecked
Message-Id: <44E735B0.3030306@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


2- add 4 explicit attribute groups for the 5 sensor types:
    voltage (in), therm, temp, and fan & pwm (together in one group).
    use sysfs_remove_group() to drop them,
    but keeps the existing startup code, which calls device_create_file 
in loops.

Signed-off-by:   Jim Cromie  <jim.cromie at gmail.com>

[jimc at harpo hwmon-stuff]$ diffstat diff.ab-2.20060818.185720
 pc87360.c |   95 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 90 insertions(+), 5 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs ab-1/drivers/hwmon/pc87360.c ab-2/drivers/hwmon/pc87360.c
--- ab-1/drivers/hwmon/pc87360.c	2006-08-18 17:35:53.000000000 -0600
+++ ab-2/drivers/hwmon/pc87360.c	2006-08-18 17:40:35.000000000 -0600
@@ -327,6 +327,12 @@ static struct sensor_device_attribute fa
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
@@ -359,6 +365,19 @@ static struct sensor_device_attribute pw
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
@@ -471,6 +490,12 @@ static struct sensor_device_attribute in
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
@@ -499,6 +524,27 @@ static ssize_t show_in_alarms(struct dev
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
@@ -617,6 +663,23 @@ static struct sensor_device_attribute th
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
@@ -735,6 +798,25 @@ static ssize_t show_temp_alarms(struct d
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
@@ -1008,16 +1090,19 @@ static int pc87360_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
+
 	if ((i = i2c_detach_client(client)))
 		return i;
 
-	for (i = 0; i < 3; i++) {
-		if (data->address[i]) {
+	for (i = 0; i < 3; i++)
+		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-		}
-	}
-	kfree(data);
 
+	kfree(data);
 	return 0;
 }
 



