From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 02:33:52 +0000
Subject: [lm-sensors] [patch pc87360 reroll 6/6] declare & initialize
Message-Id: <42F161ED.2040807@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> explicit sensor_device_attr array initializations
> a.   declare arrays, initialize them with repeated __SENSOR_DEVICE_ATTR's
> b.   loop over calls to device_create_file()
>
> b  could be done separately, but it seems silly -
>    all the calls need to be touched for (a) anyway, might as well do 
> so just once.
>    and its not like you'd declare an array wo planning to use it.
>
> This patch is motivated/justified by comments from GregKH, in msg 11 of:
>
> http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/fa10a47a3c843d08/2a1465afa2f83afe?q=dynamic+sysfs+callbacks&rnum&hl=en#2a1465afa2f83afe 
>
>
> > > No, I hate HEAD and TAIL macros.  This really isn't buying you much
> > > code savings, you could do it yourself with the __ATTR() macro
> > > yourself with the same ammount of code I bet...
>
> Hm, which makes me want to go look at trying to convert those attributes
> to an array right now...
>

$ diffstat 06-pc87360-array-init-loop.patch
 pc87360.c |  349 
++++++++++++++++++++++++++++----------------------------------
 1 files changed, 162 insertions(+), 187 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs gc-5/drivers/hwmon/pc87360.c gc-6/drivers/hwmon/pc87360.c
--- gc-5/drivers/hwmon/pc87360.c	2005-08-03 17:13:04.000000000 -0600
+++ gc-6/drivers/hwmon/pc87360.c	2005-08-03 17:13:50.000000000 -0600
@@ -310,18 +310,27 @@ static ssize_t set_fan_min(struct device
 	return _set_fan_min(dev, buf, count, attr->index);
 }
 
-#define show_and_set_fan(offset) \
-static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-	show_fan_input, NULL, offset-1); \
-static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IWUSR | S_IRUGO, \
-	show_fan_min, set_fan_min, offset-1); \
-static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
-	show_fan_div, NULL, offset-1); \
-static SENSOR_DEVICE_ATTR(fan##offset##_status, S_IRUGO, \
-	show_fan_status, NULL, offset-1);
-show_and_set_fan(1)
-show_and_set_fan(2)
-show_and_set_fan(3)
+static struct sensor_device_attribute sda_fan_input[] = {
+  __SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0),
+  __SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1),
+  __SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_input, NULL, 2),
+};
+static struct sensor_device_attribute sda_fan_status[] = {
+  __SENSOR_DEVICE_ATTR(fan1_status, S_IRUGO, show_fan_status, NULL, 0),
+  __SENSOR_DEVICE_ATTR(fan2_status, S_IRUGO, show_fan_status, NULL, 1),
+  __SENSOR_DEVICE_ATTR(fan3_status, S_IRUGO, show_fan_status, NULL, 2),
+};
+static struct sensor_device_attribute sda_fan_div[] = {
+  __SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO, show_fan_div, NULL, 0),
+  __SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO, show_fan_div, NULL, 1),
+  __SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2),
+};
+static struct sensor_device_attribute sda_fan_min[] = {
+  __SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 0),
+  __SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 1),
+  __SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
+};
+
 
 static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -349,12 +358,12 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }
 
-#define show_and_set_pwm(offset) \
-static SENSOR_DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
-	show_pwm, set_pwm, offset-1);
-show_and_set_pwm(1)
-show_and_set_pwm(2)
-show_and_set_pwm(3)
+static struct sensor_device_attribute sda_pwm[] = {
+  __SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0),
+  __SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1),
+  __SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
+};
+
 
 static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -414,26 +423,59 @@ static ssize_t set_in_max(struct device 
 	up(&data->update_lock);
 	return count;
 }
-#define show_and_set_in(offset) \
-static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-	show_in_input, NULL, offset); \
-static SENSOR_DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
-	show_in_min, set_in_min, offset); \
-static SENSOR_DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
-	show_in_max, set_in_max, offset); \
-static SENSOR_DEVICE_ATTR(in##offset##_status, S_IRUGO, \
-	show_in_status, NULL, offset);
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
+static struct sensor_device_attribute sda_in_input[] = {
+  __SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL, 0),
+  __SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in_input, NULL, 1),
+  __SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in_input, NULL, 2),
+  __SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in_input, NULL, 3),
+  __SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in_input, NULL, 4),
+  __SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in_input, NULL, 5),
+  __SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in_input, NULL, 6),
+  __SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in_input, NULL, 7),
+  __SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in_input, NULL, 8),
+  __SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in_input, NULL, 9),
+  __SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, show_in_input, NULL, 10),
+};
+static struct sensor_device_attribute sda_in_status[] = {
+  __SENSOR_DEVICE_ATTR(in0_status, S_IRUGO, show_in_status, NULL, 0),
+  __SENSOR_DEVICE_ATTR(in1_status, S_IRUGO, show_in_status, NULL, 1),
+  __SENSOR_DEVICE_ATTR(in2_status, S_IRUGO, show_in_status, NULL, 2),
+  __SENSOR_DEVICE_ATTR(in3_status, S_IRUGO, show_in_status, NULL, 3),
+  __SENSOR_DEVICE_ATTR(in4_status, S_IRUGO, show_in_status, NULL, 4),
+  __SENSOR_DEVICE_ATTR(in5_status, S_IRUGO, show_in_status, NULL, 5),
+  __SENSOR_DEVICE_ATTR(in6_status, S_IRUGO, show_in_status, NULL, 6),
+  __SENSOR_DEVICE_ATTR(in7_status, S_IRUGO, show_in_status, NULL, 7),
+  __SENSOR_DEVICE_ATTR(in8_status, S_IRUGO, show_in_status, NULL, 8),
+  __SENSOR_DEVICE_ATTR(in9_status, S_IRUGO, show_in_status, NULL, 9),
+  __SENSOR_DEVICE_ATTR(in10_status, S_IRUGO, show_in_status, NULL, 10),
+};
+static struct sensor_device_attribute sda_in_min[] = {
+  __SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 0),
+  __SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 1),
+  __SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 2),
+  __SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 3),
+  __SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 4),
+  __SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 5),
+  __SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 6),
+  __SENSOR_DEVICE_ATTR(in7_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 7),
+  __SENSOR_DEVICE_ATTR(in8_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 8),
+  __SENSOR_DEVICE_ATTR(in9_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 9),
+  __SENSOR_DEVICE_ATTR(in10_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 10),
+};
+static struct sensor_device_attribute sda_in_max[] = {
+  __SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 0),
+  __SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 1),
+  __SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 2),
+  __SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 3),
+  __SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 4),
+  __SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 5),
+  __SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 6),
+  __SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 7),
+  __SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 8),
+  __SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 9),
+  __SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
+};
 
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -460,7 +502,7 @@ static ssize_t show_therm_crit(struct de
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4],
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_therm_status(struct device *dev, struct device_attribute *devattr, char *buf)
@@ -515,20 +557,32 @@ static ssize_t set_therm_crit(struct dev
 	return count;
 }
 
-#define show_and_set_therm(offset) \
-static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_therm_input, NULL, offset-4); \
-static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_therm_min, set_therm_min, offset-4); \
-static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_therm_max, set_therm_max, offset-4); \
-static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_therm_crit, set_therm_crit, offset-4); \
-static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_therm_status, NULL, offset-4);
-show_and_set_therm(4)
-show_and_set_therm(5)
-show_and_set_therm(6)
+
+static struct sensor_device_attribute sda_therm_input[] = {
+  __SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, 0),
+  __SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, 1),
+  __SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_therm_input, NULL, 2),
+};
+static struct sensor_device_attribute sda_therm_status[] = {
+  __SENSOR_DEVICE_ATTR(temp4_status, S_IRUGO, show_therm_status, NULL, 0),
+  __SENSOR_DEVICE_ATTR(temp5_status, S_IRUGO, show_therm_status, NULL, 1),
+  __SENSOR_DEVICE_ATTR(temp6_status, S_IRUGO, show_therm_status, NULL, 2),
+};
+static struct sensor_device_attribute sda_therm_min[] = {
+  __SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR, show_therm_min, set_therm_min, 0),
+  __SENSOR_DEVICE_ATTR(temp5_min, S_IRUGO | S_IWUSR, show_therm_min, set_therm_min, 1),
+  __SENSOR_DEVICE_ATTR(temp6_min, S_IRUGO | S_IWUSR, show_therm_min, set_therm_min, 2),
+};
+static struct sensor_device_attribute sda_therm_max[] = {
+  __SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR, show_therm_max, set_therm_max, 0),
+  __SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO | S_IWUSR, show_therm_max, set_therm_max, 1),
+  __SENSOR_DEVICE_ATTR(temp6_max, S_IRUGO | S_IWUSR, show_therm_max, set_therm_max, 2),
+};
+static struct sensor_device_attribute sda_therm_crit[] = {
+  __SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO | S_IWUSR, show_therm_crit, set_therm_crit, 0),
+  __SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO | S_IWUSR, show_therm_crit, set_therm_crit, 1),
+  __SENSOR_DEVICE_ATTR(temp6_crit, S_IRUGO | S_IWUSR, show_therm_crit, set_therm_crit, 2),
+};
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -635,20 +689,31 @@ static ssize_t set_temp_crit(struct devi
 	return count;
 }
 
-#define show_and_set_temp(offset) \
-static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp_input, NULL, offset-1); \
-static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp_min, set_temp_min, offset-1); \
-static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp_max, set_temp_max, offset-1); \
-static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp_crit, set_temp_crit, offset-1); \
-static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp_status, NULL, offset-1);
-show_and_set_temp(1)
-show_and_set_temp(2)
-show_and_set_temp(3)
+static struct sensor_device_attribute sda_temp_input[] = {
+  __SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
+  __SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
+  __SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
+};
+static struct sensor_device_attribute sda_temp_status[] = {
+  __SENSOR_DEVICE_ATTR(temp1_status, S_IRUGO, show_temp_status, NULL, 0),
+  __SENSOR_DEVICE_ATTR(temp2_status, S_IRUGO, show_temp_status, NULL, 1),
+  __SENSOR_DEVICE_ATTR(temp3_status, S_IRUGO, show_temp_status, NULL, 2),
+};
+static struct sensor_device_attribute sda_temp_min[] = {
+  __SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 0),
+  __SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 1),
+  __SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 2),
+};
+static struct sensor_device_attribute sda_temp_max[] = {
+  __SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 0),
+  __SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 1),
+  __SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 2),
+};
+static struct sensor_device_attribute sda_temp_crit[] = {
+  __SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO | S_IWUSR, show_temp_crit, set_temp_crit, 0),
+  __SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR, show_temp_crit, set_temp_crit, 1),
+  __SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO | S_IWUSR, show_temp_crit, set_temp_crit, 2),
+};
 
 
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
@@ -865,137 +930,47 @@ static int pc87360_detect(struct i2c_ada
 	}
 
 	if (data->innr) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_status.dev_attr);
-
+		for (i=0; i<11; i++) { 
+			device_create_file(&new_client->dev, &sda_in_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_in_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_in_max[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_in_status[i].dev_attr);
+		}
 		device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 		device_create_file(&new_client->dev, &dev_attr_vrm);
 		device_create_file(&new_client->dev, &dev_attr_alarms_in);
 	}
 
 	if (data->tempnr) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_status.dev_attr);
-
+		for (i=0; i<data->tempnr; i++) {
+			device_create_file(&new_client->dev, &sda_temp_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_max[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_crit[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_status[i].dev_attr);
+		}
 		device_create_file(&new_client->dev, &dev_attr_alarms_temp);
 	}
-	if (data->tempnr = 3) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_status.dev_attr);
-	}
+
 	if (data->innr = 14) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_status.dev_attr);
-	}
-
-	if (data->fannr) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, 0)) {
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_input.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_min.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_div.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_status.dev_attr);
-		}
-
-		if (FAN_CONFIG_MONITOR(data->fan_conf, 1)) {
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_input.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_min.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_div.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_status.dev_attr);
-		}
-
-		if (FAN_CONFIG_CONTROL(data->fan_conf, 0))
-			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
-		if (FAN_CONFIG_CONTROL(data->fan_conf, 1))
-			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
-	}
-	if (data->fannr = 3) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, 2)) {
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_input.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_min.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_div.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_status.dev_attr);
+		for (i=0; i<3; i++) {
+			device_create_file(&new_client->dev, &sda_therm_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_max[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_crit[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_status[i].dev_attr);
 		}
+	}
 
-		if (FAN_CONFIG_CONTROL(data->fan_conf, 2))
-			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
+	for (i=0; i<data->fannr; i++) {
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
+			device_create_file(&new_client->dev, &sda_fan_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_fan_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_fan_div[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_fan_status[i].dev_attr);
+		}
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
+			device_create_file(&new_client->dev, &sda_pwm[i].dev_attr);
 	}
 
 	return 0;
