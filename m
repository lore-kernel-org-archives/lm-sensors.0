From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 28 Jul 2005 20:10:38 +0000
Subject: [lm-sensors] [patch pc87360 1/N] SENSOR_DEVICE_ATTR rework for
Message-Id: <42E91F76.5010903@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


attached patch (against 13-rc3-mm1) reworks the sysfs attributes
for the voltage sensors (only) in the style of Yani's rework of lm83

the #include is not alphabetical, cuz it needs something in i2c* to be a 
complete type,
I didnt look to see why.  I also didnt move jiffies after i2c*

Im heeding your preference for bite-sized patches.
If this one is/looks ok, Ill move on to the others,
one at a time, unless you want them in bulk.

1st, the reference/control (unpatched 13-rc3-git4)

root@soekris:~# uname -r
2.6.13-rc3-git4-v1
root@soekris:~# sensors -s
pc87366-isa-6620: At least one "set" statement failed
root@soekris:~# sensors
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.02 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +5.01 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +14.01 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.91 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.28 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.33 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.88 V  (min =  +2.79 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +109 C  (low  =    +0 C, high =   +70 C)   ALARM
Critical:    +85 C ALARM

now the experiment (rc3-mm1 + the patch)

root@soekris:~# uname -a
Linux soekris 2.6.13-rc3-mm1-v1 #4 Wed Jul 27 21:10:26 MDT 2005 i586 
GNU/Linux
root@soekris:~#
root@soekris:~# sensors -s
pc87366-isa-6620: At least one "set" statement failed
root@soekris:~#
root@soekris:~# sensors
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.03 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +5.03 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +13.77 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.91 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.28 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.33 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.91 V  (min =  +2.79 V, max =  +3.59 V)
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +110 C  (low  =    +0 C, high =   +70 C)   ALARM
Critical:    +85 C ALARM


I dont know which set statement is failing, but I twiddled Vdd, and 
changed the alarm state successfully

Vsb:       +3.33 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.91 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)

root@soekris:~# grep set /etc/sensors.conf
  set vid       1.235
  set in3_min    6.0
  set in3_max   28.0
        #  avp->scale, (a - avp->offset) * avp->scale + avp->offset,
  set in7_min    3.0
  set in7_max    3.6
  set in8_min    3.0
  set in8_max    3.6
  set in9_min    2.4
  set in9_max    3.6
  set in10_min   3.0
  set in10_max   3.6
  set temp3_min      0
  set temp3_max     70
  set temp3_crit    85

I tried changing  'set vid' line by adding '_max', since its that seemed 
to follow pattern, error changed:
root@soekris:~# sensors -s
Error: Line 6: Unknown feature name
pc87366-isa-6620: No such feature known
Commenting it out fixed the err.


-rw-rw-r--  1 jimc jimc 141784 Jul 28 10:27 drivers/hwmon/pc87360.ko

It doesnt get quite the same objcode savings as looping thru 
device_create_file()s,
but looping cant be done until the address offsets between items are 
guaranteed,
as they are when indexing arrays.  Thats for another day.

ciao
-------------- next part --------------
diff -ruN -X exclude-diffs ../linux-2.6.13-rc3-mm1/drivers/hwmon/pc87360.c lxp-sensor-dev-vin/drivers/hwmon/pc87360.c
--- ../linux-2.6.13-rc3-mm1/drivers/hwmon/pc87360.c	2005-07-18 12:36:02.000000000 -0600
+++ lxp-sensor-dev-vin/drivers/hwmon/pc87360.c	2005-07-28 10:25:54.000000000 -0600
@@ -40,6 +40,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon-sysfs.h>
 #include <asm/io.h>
 
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
@@ -352,78 +354,87 @@
 show_and_set_pwm(2)
 show_and_set_pwm(3)
 
-#define show_and_set_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
-		       data->in_vref)); \
-} \
-static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
-		       data->in_vref)); \
-} \
-static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
-		       data->in_vref)); \
-} \
-static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[offset]); \
-} \
-static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_min[offset] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MIN, \
-			    data->in_min[offset]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_max[offset] = IN_TO_REG(val, \
-			       data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MAX, \
-			    data->in_max[offset]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-	show_in##offset##_input, NULL); \
-static DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
-	show_in##offset##_min, set_in##offset##_min); \
-static DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
-	show_in##offset##_max, set_in##offset##_max); \
-static DEVICE_ATTR(in##offset##_status, S_IRUGO, \
-	show_in##offset##_status, NULL);
-show_and_set_in(0)
-show_and_set_in(1)
-show_and_set_in(2)
-show_and_set_in(3)
-show_and_set_in(4)
-show_and_set_in(5)
-show_and_set_in(6)
-show_and_set_in(7)
-show_and_set_in(8)
-show_and_set_in(9)
-show_and_set_in(10)
+
+static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_in_status(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_status[attr->index]);
+}
+static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN,
+			    data->in_min[attr->index]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_max[attr->index] = IN_TO_REG(val,
+			       data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX,
+			    data->in_max[attr->index]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define declare_voltage_attr(offset) \
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
+	show_in_input, NULL, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
+	show_in_min, set_in_min, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
+	show_in_max, set_in_max, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_status, S_IRUGO, \
+	show_in_status, NULL, offset)
+
+declare_voltage_attr(0);
+declare_voltage_attr(1);
+declare_voltage_attr(2);
+declare_voltage_attr(3);
+declare_voltage_attr(4);
+declare_voltage_attr(5);
+declare_voltage_attr(6);
+declare_voltage_attr(7);
+declare_voltage_attr(8);
+declare_voltage_attr(9);
+declare_voltage_attr(10);
 
 #define show_and_set_therm(offset) \
 static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
@@ -839,50 +850,50 @@
 
 	/* Register sysfs hooks */
 	if (data->innr) {
-		device_create_file(&new_client->dev, &dev_attr_in0_input);
-		device_create_file(&new_client->dev, &dev_attr_in1_input);
-		device_create_file(&new_client->dev, &dev_attr_in2_input);
-		device_create_file(&new_client->dev, &dev_attr_in3_input);
-		device_create_file(&new_client->dev, &dev_attr_in4_input);
-		device_create_file(&new_client->dev, &dev_attr_in5_input);
-		device_create_file(&new_client->dev, &dev_attr_in6_input);
-		device_create_file(&new_client->dev, &dev_attr_in7_input);
-		device_create_file(&new_client->dev, &dev_attr_in8_input);
-		device_create_file(&new_client->dev, &dev_attr_in9_input);
-		device_create_file(&new_client->dev, &dev_attr_in10_input);
-		device_create_file(&new_client->dev, &dev_attr_in0_min);
-		device_create_file(&new_client->dev, &dev_attr_in1_min);
-		device_create_file(&new_client->dev, &dev_attr_in2_min);
-		device_create_file(&new_client->dev, &dev_attr_in3_min);
-		device_create_file(&new_client->dev, &dev_attr_in4_min);
-		device_create_file(&new_client->dev, &dev_attr_in5_min);
-		device_create_file(&new_client->dev, &dev_attr_in6_min);
-		device_create_file(&new_client->dev, &dev_attr_in7_min);
-		device_create_file(&new_client->dev, &dev_attr_in8_min);
-		device_create_file(&new_client->dev, &dev_attr_in9_min);
-		device_create_file(&new_client->dev, &dev_attr_in10_min);
-		device_create_file(&new_client->dev, &dev_attr_in0_max);
-		device_create_file(&new_client->dev, &dev_attr_in1_max);
-		device_create_file(&new_client->dev, &dev_attr_in2_max);
-		device_create_file(&new_client->dev, &dev_attr_in3_max);
-		device_create_file(&new_client->dev, &dev_attr_in4_max);
-		device_create_file(&new_client->dev, &dev_attr_in5_max);
-		device_create_file(&new_client->dev, &dev_attr_in6_max);
-		device_create_file(&new_client->dev, &dev_attr_in7_max);
-		device_create_file(&new_client->dev, &dev_attr_in8_max);
-		device_create_file(&new_client->dev, &dev_attr_in9_max);
-		device_create_file(&new_client->dev, &dev_attr_in10_max);
-		device_create_file(&new_client->dev, &dev_attr_in0_status);
-		device_create_file(&new_client->dev, &dev_attr_in1_status);
-		device_create_file(&new_client->dev, &dev_attr_in2_status);
-		device_create_file(&new_client->dev, &dev_attr_in3_status);
-		device_create_file(&new_client->dev, &dev_attr_in4_status);
-		device_create_file(&new_client->dev, &dev_attr_in5_status);
-		device_create_file(&new_client->dev, &dev_attr_in6_status);
-		device_create_file(&new_client->dev, &dev_attr_in7_status);
-		device_create_file(&new_client->dev, &dev_attr_in8_status);
-		device_create_file(&new_client->dev, &dev_attr_in9_status);
-		device_create_file(&new_client->dev, &dev_attr_in10_status);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_status.dev_attr);
 
 		device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 		device_create_file(&new_client->dev, &dev_attr_vrm);
