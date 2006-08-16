From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 16 Aug 2006 05:35:51 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <44E2AEB7.6040209@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi folks,
(trimming aggressively)

>> What is the point of generating the group at runtime?
>>     
>
> Having a single file group to create and delete. I made something
> similar for the pcf8591 driver (although I didn't publish that patch
> yet.)
>
>   
and further, that the number of sensors changes by chip model in some cases.


>> I changed the ordering in asb100 on purpose... it closes the small window
>> of time between when the hwmon class is registered and the device attributes
>> are populated.  It's something of a race condition... sensors(1) could run
>> in the middle of that.
>>     
>
> And I second that change. We should fix all drivers in a similar way,
> before we add feature detection capability to libsensors.
>
>   
Cool.  Observation becomes Knowledge   :-D

>>> --- ../linux-2.6.18-rc3-sk/drivers/hwmon/pc87360.c	2006-06-17 19:49:35.000000000 -0600
>>> +++ sysdev/drivers/hwmon/pc87360.c	2006-08-03 12:58:29.000000000 -0600
>>> @@ -829,6 +829,83 @@ static int __init pc87360_find(int sioad
>>>  	return 0;
>>>  }
>>>  
>>> +/* Declare and use an attribute-group for simplicity.
>>> +   This driver declares all attributes statically, so we count uses of 
>>> +   SENSOR_ATTR, DEVICE_ATTR, and add 1 space for trailing NULL (+0 fudge)
>>> +*/
>>> +#define ENOUGH_ATTRS	89 + 4 + 1 + 0
>>>       
>
> My experience is that this kind of construct is likely to break as soon
> as the driver evolves :( I see you check carefully so no overflow can
> happen, good, but still...
>
>   
I was never comfortable with that, hence the goofy symbol names.
>>
>> You can't fill your static array from here.  What if you have two
>> pc87360s?  If you're going to do it at runtime, it has to be during
>> module init.  But again, why do it at runtime in the first place?
>>     
>
> There will never be two PC87360s in a machine, that wouldn't make
> sense. But this raises a concern about Jim's approach: it only works
> for drivers which can handle a single chip, or at least where all chips
> are guaranteed to share the exact same configuration. I took that
> shortcut for the PCF8591 as well, but on second though it's plain
> wrong. This doesn't fit in the device driver model at all. Given that
> we want to convert all i2c-isa drivers to platform drivers at the end
> of this year, and the i2c subsystem to the driver model hopefully even
> before that, we are shooting ourselves in the feet if we go Jim's (and
> my) way.
>
> Mark's approach is magnitudes better.
>
> Jim, sorry about that, nothing personal ;) Thanks for your contribution
> anyway, I'm certain it helps Mark refine his own excellent ideas :)
>
>   

Im not sure which parts bother you most, so I'll break it down as I see it.

1.  static decls of ATTRs  intrinsically limits driver to 1 instance, I 
agree.

As you note, the chip wouldnt be used 2x on a board, so designing for that
wasnt valuable (Im guessing).  I dont see the value now in re-doing the 
driver
to change this, unless theres something about the migration plan ( that
has effects, requirements that I dont appreciate yet)

2.  Previous patch built groups at runtime - thats now gone.

This patch version declares a separate sub-group for each sensor-type,
which allows the same runtime-choices, but now creating attr-groups,
instead of looping thru and creating single attrs.
As I see it, this copies Marks approach closely.

patch includes a code-move to bring 3 volts-related attrs and callbacks up
with the code for VIN, so theyre in-scope for the vin-attr-grp declaration.

Its had cursory testing, will test over next few days.

--------

Convert loops of device_create_file() calls, with unchecked return codes,
into declarations of attribute groups per sensor-type, and a call
to sysfs-create-group() for each.

Signed-off-by:  Jim Cromie  jim.cromie at gmail.com

[jimc at harpo hwmon-stuff]$ diffstat diff.sys-grp.20060815.223612
 pc87360.c |  216 
++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 142 insertions(+), 74 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc4-mm1-sk/drivers/hwmon/pc87360.c sys-grp/drivers/hwmon/pc87360.c
--- ../linux-2.6.18-rc4-mm1-sk/drivers/hwmon/pc87360.c	2006-08-14 21:19:24.000000000 -0600
+++ sys-grp/drivers/hwmon/pc87360.c	2006-08-15 22:46:16.000000000 -0600
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
@@ -471,6 +490,61 @@ static struct sensor_device_attribute in
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+#define VIN_UNIT_ATTRS(X) \
+	&in_input[X].dev_attr.attr,	\
+	&in_status[X].dev_attr.attr,	\
+	&in_min[X].dev_attr.attr,	\
+	&in_max[X].dev_attr.attr
+
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
@@ -589,33 +663,22 @@ static struct sensor_device_attribute th
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
 
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
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
@@ -935,67 +1017,46 @@ static int pc87360_detect(struct i2c_ada
 		pc87360_init_client(client, use_thermistors);
 	}
 
-	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	/* Register sysfs groups */
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
+	if (data->tempnr &&
+	    sysfs_create_group(&client->dev.kobj, 
+			       &pc8736x_temp_group))
+		goto ERROR3;
 
-	if (data->tempnr) {
-		for (i = 0; i < data->tempnr; i++) {
-			device_create_file(dev, &temp_input[i].dev_attr);
-			device_create_file(dev, &temp_min[i].dev_attr);
-			device_create_file(dev, &temp_max[i].dev_attr);
-			device_create_file(dev, &temp_crit[i].dev_attr);
-			device_create_file(dev, &temp_status[i].dev_attr);
-		}
-		device_create_file(dev, &dev_attr_alarms_temp);
-	}
+	if (data->innr = 14 &&
+	    sysfs_create_group(&client->dev.kobj, 
+			       &pc8736x_therm_group))
+		goto ERROR3;
 
-	if (data->innr = 14) {
-		for (i = 0; i < 3; i++) {
-			device_create_file(dev, &therm_input[i].dev_attr);
-			device_create_file(dev, &therm_min[i].dev_attr);
-			device_create_file(dev, &therm_max[i].dev_attr);
-			device_create_file(dev, &therm_crit[i].dev_attr);
-			device_create_file(dev, &therm_status[i].dev_attr);
-		}
-	}
+	if (data->fannr &&
+	    sysfs_create_group(&client->dev.kobj,
+			       &pc8736x_fan_group))
+		goto ERROR3;
 
-	for (i = 0; i < data->fannr; i++) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
-			device_create_file(dev, &fan_input[i].dev_attr);
-			device_create_file(dev, &fan_min[i].dev_attr);
-			device_create_file(dev, &fan_div[i].dev_attr);
-			device_create_file(dev, &fan_status[i].dev_attr);
-		}
-		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
-			device_create_file(dev, &pwm[i].dev_attr);
+	data->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
 	}
-
 	return 0;
 
 ERROR3:
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
@@ -1008,16 +1069,19 @@ static int pc87360_detach_client(struct 
 
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
 



