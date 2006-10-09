From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 09 Oct 2006 01:27:08 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min, max,
Message-Id: <4529A56C.1030507@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


implement separate min, max, alarms for each voltage input,
and min, max, crit alarms for temps.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---
$ diffstat hwmon-pc87360-separate-alarms.patch
 pc87360.c |  181 
++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 141 insertions(+), 40 deletions(-)

patch is against 19-rc1, you're accepting separate-alarms patches for 
2.6.20 now ?

It passes this exersise:

#!/bin/bash
sensors -s
sensors
cd /sys/class/hwmon/hwmon0/device
function set_check {
    local lim=$1
    local setting=$2
    local want=$3
    echo $setting > $lim
    sleep 2
    local in=`cat ${lim}_alarm`
    [ $in = $want ] && echo ok setting $lim $setting alarm ${lim}_alarm $in
}
# in8_input is 1477
set_check in8_min 1500 1
set_check in8_min 1400 0
set_check in8_max 1400 1
set_check in8_max 1500 0
# temp3_input is 99000
set_check temp3_min 101000 1
set_check temp3_min 95000 0
set_check temp3_max 95000 1
set_check temp3_max 101000 0
set_check temp3_crit 95000 1
set_check temp3_crit 101000 0

The need for 'sleep 2' above made me think to reset data->valid when any 
setter callback is called.
I didnt add it, but it seems the right thing to do.  My preference is to 
add it into a forthcoming
2D-callback patch.



diff -ruNp -X dontdiff -X exclude-diffs 19rc1-0/drivers/hwmon/pc87360.c alarms-only/drivers/hwmon/pc87360.c
--- 19rc1-0/drivers/hwmon/pc87360.c	2006-10-05 20:17:51.000000000 -0600
+++ alarms-only/drivers/hwmon/pc87360.c	2006-10-08 14:43:01.000000000 -0600
@@ -144,15 +144,14 @@ static inline u8 PWM_TO_REG(int val, int
  * Voltage registers and conversions
  */
 
+#define PC87365_REG_VID			0x06
 #define PC87365_REG_IN_CONVRATE		0x07
 #define PC87365_REG_IN_CONFIG		0x08
+/* per-channel (0-13) registers */
+#define PC87365_REG_IN_STATUS		0x0A
 #define PC87365_REG_IN			0x0B
-#define PC87365_REG_IN_MIN		0x0D
 #define PC87365_REG_IN_MAX		0x0C
-#define PC87365_REG_IN_STATUS		0x0A
-#define PC87365_REG_IN_ALARMS1		0x00
-#define PC87365_REG_IN_ALARMS2		0x01
-#define PC87365_REG_VID			0x06
+#define PC87365_REG_IN_MIN		0x0D
 
 #define IN_FROM_REG(val,ref)		(((val) * (ref) + 128) / 256)
 #define IN_TO_REG(val,ref)		((val) < 0 ? 0 : \
@@ -205,7 +204,6 @@ struct pc87360_data {
 	u8 in_max[14];		/* Register value */
 	u8 in_crit[3];		/* Register value */
 	u8 in_status[14];	/* Register value */
-	u16 in_alarms;		/* Register values, combined, masked */
 	u8 vid_conf;		/* Configuration register value */
 	u8 vrm;
 	u8 vid;			/* Register value */
@@ -215,7 +213,6 @@ struct pc87360_data {
 	s8 temp_max[3];		/* Register value */
 	s8 temp_crit[3];	/* Register value */
 	u8 temp_status[3];	/* Register value */
-	u8 temp_alarms;		/* Register value, masked */
 };
 
 /*
@@ -495,7 +492,9 @@ static struct sensor_device_attribute in
 	&in_input[X].dev_attr.attr,	\
 	&in_status[X].dev_attr.attr,	\
 	&in_min[X].dev_attr.attr,	\
-	&in_max[X].dev_attr.attr
+	&in_max[X].dev_attr.attr,	\
+	&in_min_alarm[X].dev_attr.attr,	\
+	&in_max_alarm[X].dev_attr.attr
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -518,12 +517,45 @@ static ssize_t set_vrm(struct device *de
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 4) >> 2); 
+}
+static struct sensor_device_attribute in_max_alarm[] = {
+	SENSOR_ATTR(in0_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 0),
+	SENSOR_ATTR(in1_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 1),
+	SENSOR_ATTR(in2_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 2),
+	SENSOR_ATTR(in3_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 3),
+	SENSOR_ATTR(in4_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 4),
+	SENSOR_ATTR(in5_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 5),
+	SENSOR_ATTR(in6_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 6),
+	SENSOR_ATTR(in7_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 7),
+	SENSOR_ATTR(in8_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 8),
+	SENSOR_ATTR(in9_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 9),
+	SENSOR_ATTR(in10_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 10),
+};
+
+static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_alarms);
+	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 2) >> 1);
 }
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+static struct sensor_device_attribute in_min_alarm[] = {
+	SENSOR_ATTR(in0_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 0),
+	SENSOR_ATTR(in1_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 1),
+	SENSOR_ATTR(in2_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
+	SENSOR_ATTR(in3_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
+	SENSOR_ATTR(in4_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 4),
+	SENSOR_ATTR(in5_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 5),
+	SENSOR_ATTR(in6_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 6),
+	SENSOR_ATTR(in7_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 7),
+	SENSOR_ATTR(in8_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 8),
+	SENSOR_ATTR(in9_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 9),
+	SENSOR_ATTR(in10_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 10),
+};
 
 static struct attribute *pc8736x_vin_attr_array[] = {
 	VIN_UNIT_ATTRS(0),
@@ -539,7 +571,6 @@ static struct attribute *pc8736x_vin_att
 	VIN_UNIT_ATTRS(10),
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
-	&dev_attr_alarms_in.attr,
 	NULL
 };
 static const struct attribute_group pc8736x_vin_group = {
@@ -664,12 +695,60 @@ static struct sensor_device_attribute th
 		    show_therm_crit, set_therm_crit, 2+11),
 };
 
+static ssize_t show_therm_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 2) >> 1); 
+}
+static struct sensor_device_attribute therm_min_alarm[] = {
+	SENSOR_ATTR(temp4_min_alarm, S_IRUGO,
+		    show_therm_min_alarm, NULL, 0+11),
+	SENSOR_ATTR(temp5_min_alarm, S_IRUGO,
+		    show_therm_min_alarm, NULL, 1+11),
+	SENSOR_ATTR(temp6_min_alarm, S_IRUGO,
+		    show_therm_min_alarm, NULL, 2+11),
+};
+
+static ssize_t show_therm_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 4) >> 2); 
+}
+static struct sensor_device_attribute therm_max_alarm[] = {
+	SENSOR_ATTR(temp4_max_alarm, S_IRUGO,
+		    show_therm_max_alarm, NULL, 0+11),
+	SENSOR_ATTR(temp5_max_alarm, S_IRUGO,
+		    show_therm_max_alarm, NULL, 1+11),
+	SENSOR_ATTR(temp6_max_alarm, S_IRUGO,
+		    show_therm_max_alarm, NULL, 2+11),
+};
+
+static ssize_t show_therm_crit_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 8) >> 3); 
+}
+static struct sensor_device_attribute therm_crit_alarm[] = {
+	SENSOR_ATTR(temp4_crit_alarm, S_IRUGO,
+		    show_therm_crit_alarm, NULL, 0+11),
+	SENSOR_ATTR(temp5_crit_alarm, S_IRUGO,
+		    show_therm_crit_alarm, NULL, 1+11),
+	SENSOR_ATTR(temp6_crit_alarm, S_IRUGO,
+		    show_therm_crit_alarm, NULL, 2+11),
+};
+
 #define THERM_UNIT_ATTRS(X) \
 	&therm_input[X].dev_attr.attr,	\
 	&therm_status[X].dev_attr.attr,	\
 	&therm_min[X].dev_attr.attr,	\
 	&therm_max[X].dev_attr.attr,	\
-	&therm_crit[X].dev_attr.attr
+	&therm_crit[X].dev_attr.attr,	\
+	&therm_min_alarm[X].dev_attr.attr, \
+	&therm_max_alarm[X].dev_attr.attr, \
+	&therm_crit_alarm[X].dev_attr.attr
 
 static struct attribute * pc8736x_therm_attr_array[] = {
 	THERM_UNIT_ATTRS(0),
@@ -792,26 +871,56 @@ static struct sensor_device_attribute te
 		    show_temp_crit, set_temp_crit, 2),
 };
 
-static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->temp_alarms);
+	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 2) >> 1);
 }
-static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
+static struct sensor_device_attribute temp_min_alarm[] = {
+	SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 2),
+};
+
+static ssize_t show_temp_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 4) >> 2);
+}
+static struct sensor_device_attribute temp_max_alarm[] = {
+	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 2),
+};
+
+static ssize_t show_temp_crit_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 8) >> 3);
+}
+static struct sensor_device_attribute temp_crit_alarm[] = {
+	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+	SENSOR_ATTR(temp3_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+};
 
 #define TEMP_UNIT_ATTRS(X) \
 	&temp_input[X].dev_attr.attr,	\
 	&temp_status[X].dev_attr.attr,	\
 	&temp_min[X].dev_attr.attr,	\
 	&temp_max[X].dev_attr.attr,	\
-	&temp_crit[X].dev_attr.attr
+	&temp_crit[X].dev_attr.attr,	\
+	&temp_min_alarm[X].dev_attr.attr, \
+	&temp_max_alarm[X].dev_attr.attr, \
+	&temp_crit_alarm[X].dev_attr.attr
 
 static struct attribute * pc8736x_temp_attr_array[] = {
 	TEMP_UNIT_ATTRS(0),
 	TEMP_UNIT_ATTRS(1),
 	TEMP_UNIT_ATTRS(2),
-	/* include the few miscellaneous atts here */
-	&dev_attr_alarms_temp.attr,
 	NULL
 };
 static const struct attribute_group pc8736x_temp_group = {
@@ -1032,21 +1141,23 @@ static int pc87360_detect(struct i2c_ada
 
 	/* create device attr-files for varying sysfs groups */
 
-	if (data->tempnr) {
-		for (i = 0; i < data->tempnr; i++) {
-			if ((err = device_create_file(dev,
+	for (i = 0; i < data->tempnr; i++) {
+		if ((err = device_create_file(dev,
 					&temp_input[i].dev_attr))
-			    || (err = device_create_file(dev,
+		    || (err = device_create_file(dev,
 					&temp_min[i].dev_attr))
-			    || (err = device_create_file(dev,
+		    || (err = device_create_file(dev,
 					&temp_max[i].dev_attr))
-			    || (err = device_create_file(dev,
+		    || (err = device_create_file(dev,
 					&temp_crit[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_status[i].dev_attr)))
-				goto ERROR3;
-		}
-		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
+		    || (err = device_create_file(dev,
+					&temp_status[i].dev_attr))
+		    || (err = device_create_file(dev,
+					&temp_min_alarm[i].dev_attr))
+		    || (err = device_create_file(dev,
+					&temp_max_alarm[i].dev_attr))
+		    || (err = device_create_file(dev,
+					&temp_crit_alarm[i].dev_attr)))
 			goto ERROR3;
 	}
 
@@ -1367,11 +1478,6 @@ static struct pc87360_data *pc87360_upda
 			}
 		}
 		if (data->innr) {
-			data->in_alarms = pc87360_read_value(data, LD_IN,
-					  NO_BANK, PC87365_REG_IN_ALARMS1)
-					| ((pc87360_read_value(data, LD_IN,
-					    NO_BANK, PC87365_REG_IN_ALARMS2)
-					    & 0x07) << 8);
 			data->vid = (data->vid_conf & 0xE0) ?
 				    pc87360_read_value(data, LD_IN,
 				    NO_BANK, PC87365_REG_VID) : 0x1F;
@@ -1403,11 +1509,6 @@ static struct pc87360_data *pc87360_upda
 						     PC87365_REG_TEMP_CRIT);
 			}
 		}
-		if (data->tempnr) {
-			data->temp_alarms = pc87360_read_value(data, LD_TEMP,
-					    NO_BANK, PC87365_REG_TEMP_ALARMS)
-					    & 0x3F;
-		}
 
 		data->last_updated = jiffies;
 		data->valid = 1;



