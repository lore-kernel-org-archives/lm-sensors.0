From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 10 Oct 2006 18:42:43 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min,
Message-Id: <452BE9A3.9060509@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4529A56C.1030507@gmail.com>
In-Reply-To: <4529A56C.1030507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

implement separate min, max, alarms for each voltage input,
and min, max, crit alarms for temps.


Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---

$ diffstat pc-set/hwmon-pc87360-separate-alarms.patch
 pc87360.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 139 insertions(+), 5 deletions(-)



> What about the fans?
>   
Current driver has no existing alarms on the fans, and my mobo has no 
fans either.
So adding them is a- more risky cuz its untestable here, b - a new feature.
I'll look at it later.

> Hmm, I guess it makes some sense, but OTOH you don't know how much time
> the hardware will take to trigger the new alarms if needed. So you may
> still get a wrong reading if you rush, which means you'll still need to
> sleep. There doesn't seem to be much benefit in practice.
>
>   
>> I didnt add it, but it seems the right thing to do.  My preference is to 
>> add it into a forthcoming 2D-callback patch.
>>     
>
> No, the preference is a different patch for every unrelated change.
>
>   
Did I say into ?  I meant after ! ( into the 5 setter-callbacks  ;-)
> Please don't move things around that way, it hurts readbility. The
> defines were sorted according to functionality, on purpose.
>
>   
ack.  dropped that chunk.
> We do not want to remove the old all-in-one alarm
> files, it would break compatibility with lm-sensors. Even lm-sensors
> 2.10.1, which was released 2 weeks ago, doesn't support the new alarm
> model yet!
>
> So for now we are only adding the individual files. Then we teach
> libsensors how to use them. Then, _much later_, we will drop the legacy
> all-in-one alarm files.
>
> As a nice side effect it will make your patch more readable :)
>
>   
Ack.

> Thanks,
>   
thank you.


diff -ruNp -X dontdiff -X exclude-diffs 19rc1-0/drivers/hwmon/pc87360.c 19rc1-1/drivers/hwmon/pc87360.c
--- 19rc1-0/drivers/hwmon/pc87360.c	2006-10-05 20:17:51.000000000 -0600
+++ 19rc1-1/drivers/hwmon/pc87360.c	2006-10-10 09:00:29.000000000 -0600
@@ -495,7 +495,9 @@ static struct sensor_device_attribute in
 	&in_input[X].dev_attr.attr,	\
 	&in_status[X].dev_attr.attr,	\
 	&in_min[X].dev_attr.attr,	\
-	&in_max[X].dev_attr.attr
+	&in_max[X].dev_attr.attr,	\
+	&in_min_alarm[X].dev_attr.attr,	\
+	&in_max_alarm[X].dev_attr.attr
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -525,6 +527,46 @@ static ssize_t show_in_alarms(struct dev
 }
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
+static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
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
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 2) >> 1);
+}
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
+
 static struct attribute *pc8736x_vin_attr_array[] = {
 	VIN_UNIT_ATTRS(0),
 	VIN_UNIT_ATTRS(1),
@@ -664,12 +706,60 @@ static struct sensor_device_attribute th
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
@@ -799,18 +889,56 @@ static ssize_t show_temp_alarms(struct d
 }
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
+static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 2) >> 1);
+}
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
+	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+};
+
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
 	&dev_attr_alarms_temp.attr,
 	NULL
 };
@@ -1043,7 +1171,13 @@ static int pc87360_detect(struct i2c_ada
 			    || (err = device_create_file(dev,
 					&temp_crit[i].dev_attr))
 			    || (err = device_create_file(dev,
-					&temp_status[i].dev_attr)))
+					&temp_status[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_min_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_max_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_crit_alarm[i].dev_attr)))
 				goto ERROR3;
 		}
 		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))



