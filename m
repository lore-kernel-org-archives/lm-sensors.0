From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 28 Jul 2005 08:27:51 +0000
Subject: [lm-sensors] [patch] pc87360 de-macro and code shrink
Message-Id: <42E87A0F.8060709@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


attached is a patch which:

1. adds an __ATTR_N macro to device.h,
which takes an extra _index arg, and initializes device_attibute's new 
.index member/

2. replaces lots of nested-macro-uses of these:

static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
    show_temp##offset##_input, NULL); \

with array initializers. like these:

static struct device_attribute dev_attr_temp_input[]   {
    __ATTR_N(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
    __ATTR_N(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
    __ATTR_N(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
    __ATTR_N(temp4_input, S_IRUGO, show_temp_input, NULL, 3),
    __ATTR_N(temp5_input, S_IRUGO, show_temp_input, NULL, 4),
    __ATTR_N(temp6_input, S_IRUGO, show_temp_input, NULL, 5),
  };

3.  de-macros the functions called by the individual items.
the functions use devattr->index to determine which item theyre working on.


this is an interim version, and has ifdefs to support back and forth 
debugging:

grep define pc87360.c |grep ATTR_LOOP
#define FAN_ATTR_LOOP 0
#define PWM_ATTR_LOOP 0
#define VOLT_ATTR_LOOP 1
#define TEMP_ATTR_LOOP 0

using loops results in a large savings in obj code.

baseline:           -rw-rw-r--  1 jimc jimc 168326 Jul 27 23:10 
drivers/hwmon/pc87360.ko
VOLT_ATTR_LOOP      -rw-rw-r--  1 jimc jimc 135940 Jul 27 23:11 
drivers/hwmon/pc87360.ko
+ TEMP_ATTR_LOOP    -rw-rw-r--  1 jimc jimc 127441 Jul 27 23:16 
drivers/hwmon/pc87360.ko
+ FAN/PWM_ATTR_LOOP -rw-rw-r--  1 jimc jimc 121062 Jul 27 23:55 
drivers/hwmon/pc87360.ko


I have a couple of questions that Im hoping you can clarify for me;
its late, and I could sleep now, and see your responses when I wake.

line 887 starts the show_and_set_temp(offset)  macro,
which looks to be a duplicate of
#define show_and_set_therm(offset) on line 651,

or if theyre not duplicates (I havent looked carefully), its an 
unfortunate naming,
creating functions which are disambiguated only by the offset.

OTOH, they could be different cuz the physical units on the chip have 
different capabilities.
ATM code has some unused data, but probly not another 10k

Using loops to call device_create_file also simplifies some of the logic 
wrt data->innr, tempnr, fannr;
the if-variations are hidden/abstracted by 0..configd_max.   Of course, 
I could have oversimplified.


Ive done cursory testing: new code does this.

root@soekris:~# sensors
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.02 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +5.01 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +14.01 V  (min =  +0.00 V, max = +60.56 V)
+12V:     +11.91 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.28 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.33 V  (min =  +0.00 V, max =  +6.03 V)
Vdd:       +2.91 V  (min =  +0.00 V, max =  +6.03 V)
Vbat:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
AVdd:      +3.31 V  (min =  +0.00 V, max =  +6.03 V)
Temp:       +107 C  (low  =   -55 C, high =  +127 C)
Critical:   +127 C

root@soekris:~#
root@soekris:~# cd /sys/bus/i2c/devices/0-6620/
alarms_temp   in2_max       in6_max       temp1_crit    temp4_input
bus           in2_min       in6_min       temp1_input   temp4_max
driver        in2_status    in6_status    temp1_max     temp4_min
in0_input     in3_input     in7_input     temp1_min     temp4_status
in0_max       in3_max       in7_max       temp1_status  temp5_crit
in0_min       in3_min       in7_min       temp2_crit    temp5_input
in0_status    in3_status    in7_status    temp2_input   temp5_max
in10_input    in4_input     in8_input     temp2_max     temp5_min
in10_max      in4_max       in8_max       temp2_min     temp5_status
in10_min      in4_min       in8_min       temp2_status  temp6_crit
in10_status   in4_status    in8_status    temp3_crit    temp6_input
in1_input     in5_input     in9_input     temp3_input   temp6_max
in1_max       in5_max       in9_max       temp3_max     temp6_min
in1_min       in5_min       in9_min       temp3_min     temp6_status
in1_status    in5_status    in9_status    temp3_status
in2_input     in6_input     name          temp4_crit

I have no fans on this board, and have never gotten temp readings I trust.
But the voltages look right :-)

thanks
jimc


-------------- next part --------------
diff -ruN -X exclude-diffs ../linux-2.6.13-rc3-mm1/drivers/hwmon/pc87360.c linux/drivers/hwmon/pc87360.c
--- ../linux-2.6.13-rc3-mm1/drivers/hwmon/pc87360.c	2005-07-18 12:36:02.000000000 -0600
+++ linux/drivers/hwmon/pc87360.c	2005-07-27 23:55:13.000000000 -0600
@@ -46,7 +46,7 @@
 static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
 static struct i2c_force_data forces[] = {{ NULL }};
 static u8 devid;
-static unsigned int extra_isa[3];
+static unsigned int extra_isa[3];	/* isa bus addresses of the 3 logical devices */
 static u8 confreg[4];
 
 enum chips { any_chip, pc87360, pc87363, pc87364, pc87365, pc87366 };
@@ -251,7 +251,7 @@
  * Sysfs stuff
  */
 
-static ssize_t set_fan_min(struct device *dev, const char *buf,
+static ssize_t _set_fan_min(struct device *dev, const char *buf,
 	size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -280,6 +280,9 @@
 	return count;
 }
 
+#define FAN_ATTR_LOOP 1
+#if ! FAN_ATTR_LOOP
+
 #define show_and_set_fan(offset) \
 static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
@@ -308,7 +311,7 @@
 static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
-	return set_fan_min(dev, buf, count, offset-1); \
+	return _set_fan_min(dev, buf, count, offset-1); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
 	show_fan##offset##_input, NULL); \
@@ -322,6 +325,68 @@
 show_and_set_fan(2)
 show_and_set_fan(3)
 
+#else
+
+static ssize_t show_fan_input(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index-1],
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])));
+}
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index-1],
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])));
+}
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]));
+}
+static ssize_t show_fan_status(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       FAN_STATUS_FROM_REG(data->fan_status[attr->index-1]));
+}
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	return _set_fan_min(dev, buf, count, attr->index-1);
+}
+
+static struct device_attribute dev_attr_fan_input[] +  {
+    __ATTR_N(fan1_input, S_IRUGO, show_fan_input, NULL, 0),
+    __ATTR_N(fan2_input, S_IRUGO, show_fan_input, NULL, 1),
+    __ATTR_N(fan3_input, S_IRUGO, show_fan_input, NULL, 2),
+  };
+static struct device_attribute dev_attr_fan_status[] +  {
+    __ATTR_N(fan_status, S_IRUGO, show_fan_status, NULL, 0),
+    __ATTR_N(fan_status, S_IRUGO, show_fan_status, NULL, 1),
+    __ATTR_N(fan_status, S_IRUGO, show_fan_status, NULL, 2),
+  };
+static struct device_attribute dev_attr_fan_div[] +  {
+    __ATTR_N(fan_div, S_IRUGO, show_fan_div, NULL, 0),
+    __ATTR_N(fan_div, S_IRUGO, show_fan_div, NULL, 1),
+    __ATTR_N(fan_div, S_IRUGO, show_fan_div, NULL, 2),
+  };
+static struct device_attribute dev_attr_fan_min[] +  {
+    __ATTR_N(fan_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 0),
+    __ATTR_N(fan_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 1),
+    __ATTR_N(fan_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
+  };
+
+#endif
+
+#define PWM_ATTR_LOOP 1
+#if ! PWM_ATTR_LOOP
+
 #define show_and_set_pwm(offset) \
 static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
@@ -352,6 +417,44 @@
 show_and_set_pwm(2)
 show_and_set_pwm(3)
 
+#else
+
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       PWM_FROM_REG(data->pwm[attr->index-1],
+				    FAN_CONFIG_INVERT(data->fan_conf,
+						      attr->index-1)));
+}
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->pwm[attr->index-1] = PWM_TO_REG(val,
+			      FAN_CONFIG_INVERT(data->fan_conf, attr->index-1));
+	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(attr->index-1),
+			    data->pwm[attr->index-1]);
+	up(&data->update_lock);
+	return count;
+}
+
+static struct device_attribute dev_attr_pwm[] +  {
+    __ATTR_N(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0),
+    __ATTR_N(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1),
+    __ATTR_N(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
+  };
+
+#endif
+
+#define VOLT_ATTR_LOOP 1
+#if ! VOLT_ATTR_LOOP
+
 #define show_and_set_in(offset) \
 static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
@@ -425,6 +528,125 @@
 show_and_set_in(9)
 show_and_set_in(10)
 
+#else
+
+static ssize_t show_v_input(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_v_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_v_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_v_status(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_status[attr->index]);
+}
+static ssize_t set_v_min(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
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
+static ssize_t set_v_max(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
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
+static struct device_attribute dev_attr_v_input[] +  {
+    __ATTR_N(in0_input, S_IRUGO, show_v_input, NULL, 0),
+    __ATTR_N(in1_input, S_IRUGO, show_v_input, NULL, 1),
+    __ATTR_N(in2_input, S_IRUGO, show_v_input, NULL, 2),
+    __ATTR_N(in3_input, S_IRUGO, show_v_input, NULL, 3),
+    __ATTR_N(in4_input, S_IRUGO, show_v_input, NULL, 4),
+    __ATTR_N(in5_input, S_IRUGO, show_v_input, NULL, 5),
+    __ATTR_N(in6_input, S_IRUGO, show_v_input, NULL, 6),
+    __ATTR_N(in7_input, S_IRUGO, show_v_input, NULL, 7),
+    __ATTR_N(in8_input, S_IRUGO, show_v_input, NULL, 8),
+    __ATTR_N(in9_input, S_IRUGO, show_v_input, NULL, 9),
+    __ATTR_N(in10_input, S_IRUGO, show_v_input, NULL, 10),
+  };
+static struct device_attribute dev_attr_v_status[] +  {
+    __ATTR_N(in0_status, S_IRUGO, show_v_status, NULL, 0),
+    __ATTR_N(in1_status, S_IRUGO, show_v_status, NULL, 1),
+    __ATTR_N(in2_status, S_IRUGO, show_v_status, NULL, 2),
+    __ATTR_N(in3_status, S_IRUGO, show_v_status, NULL, 3),
+    __ATTR_N(in4_status, S_IRUGO, show_v_status, NULL, 4),
+    __ATTR_N(in5_status, S_IRUGO, show_v_status, NULL, 5),
+    __ATTR_N(in6_status, S_IRUGO, show_v_status, NULL, 6),
+    __ATTR_N(in7_status, S_IRUGO, show_v_status, NULL, 7),
+    __ATTR_N(in8_status, S_IRUGO, show_v_status, NULL, 8),
+    __ATTR_N(in9_status, S_IRUGO, show_v_status, NULL, 9),
+    __ATTR_N(in10_status, S_IRUGO, show_v_status, NULL, 10),
+  };
+static struct device_attribute dev_attr_v_min[] = 
+  {
+    __ATTR_N(in0_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 0),
+    __ATTR_N(in1_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 1),
+    __ATTR_N(in2_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 2),
+    __ATTR_N(in3_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 3),
+    __ATTR_N(in4_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 4),
+    __ATTR_N(in5_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 5),
+    __ATTR_N(in6_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 6),
+    __ATTR_N(in7_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 7),
+    __ATTR_N(in8_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 8),
+    __ATTR_N(in9_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 9),
+    __ATTR_N(in10_min, S_IWUSR | S_IRUGO, show_v_min, set_v_min, 10),
+
+  };
+static struct device_attribute dev_attr_v_max[] +  {
+    __ATTR_N(in0_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 0),
+    __ATTR_N(in1_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 1),
+    __ATTR_N(in2_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 2),
+    __ATTR_N(in3_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 3),
+    __ATTR_N(in4_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 4),
+    __ATTR_N(in5_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 5),
+    __ATTR_N(in6_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 6),
+    __ATTR_N(in7_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 7),
+    __ATTR_N(in8_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 8),
+    __ATTR_N(in9_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 9),
+    __ATTR_N(in10_max, S_IWUSR | S_IRUGO, show_v_max, set_v_max, 10),
+  };
+
+#endif
+
+#define TEMP_ATTR_LOOP 1
+
+#if ! TEMP_ATTR_LOOP
+
 #define show_and_set_therm(offset) \
 static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
@@ -511,6 +733,129 @@
 show_and_set_therm(5)
 show_and_set_therm(6)
 
+#else 
+
+static ssize_t show_temp_input(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7],
+		       data->in_vref));
+}
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7],
+		       data->in_vref));
+}
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7],
+		       data->in_vref));
+}
+static ssize_t show_temp_crit(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4],
+		       data->in_vref));
+}
+static ssize_t show_temp_status(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_status[attr->index+7]);
+}
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_min[attr->index+7] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MIN,
+			    data->in_min[attr->index+7]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_max[attr->index+7] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MAX,
+			    data->in_max[attr->index+7]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_crit[attr->index-4] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_CRIT,
+			    data->in_crit[attr->index-4]);
+	up(&data->update_lock);
+	return count;
+}
+
+static struct device_attribute dev_attr_temp_input[] +  {
+    __ATTR_N(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
+    __ATTR_N(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
+    __ATTR_N(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
+    __ATTR_N(temp4_input, S_IRUGO, show_temp_input, NULL, 3),
+    __ATTR_N(temp5_input, S_IRUGO, show_temp_input, NULL, 4),
+    __ATTR_N(temp6_input, S_IRUGO, show_temp_input, NULL, 5),
+  };
+
+static struct device_attribute dev_attr_temp_status[] +  {
+    __ATTR_N(temp1_status, S_IRUGO, show_temp_status, NULL, 0),
+    __ATTR_N(temp2_status, S_IRUGO, show_temp_status, NULL, 1),
+    __ATTR_N(temp3_status, S_IRUGO, show_temp_status, NULL, 2),
+    __ATTR_N(temp4_status, S_IRUGO, show_temp_status, NULL, 3),
+    __ATTR_N(temp5_status, S_IRUGO, show_temp_status, NULL, 4),
+    __ATTR_N(temp6_status, S_IRUGO, show_temp_status, NULL, 5),
+  };
+static struct device_attribute dev_attr_temp_min[] +  {
+    __ATTR_N(temp1_min, S_IWUSR | S_IWUSR, show_temp_min, set_temp_min, 0),
+    __ATTR_N(temp2_min, S_IWUSR | S_IWUSR, show_temp_min, set_temp_min, 1),
+    __ATTR_N(temp3_min, S_IWUSR | S_IWUSR, show_temp_min, set_temp_min, 2),
+    __ATTR_N(temp4_min, S_IWUSR | S_IWUSR, show_temp_min, set_temp_min, 3),
+    __ATTR_N(temp5_min, S_IWUSR | S_IWUSR, show_temp_min, set_temp_min, 4),
+    __ATTR_N(temp6_min, S_IWUSR | S_IWUSR, show_temp_min, set_temp_min, 5),
+  };
+static struct device_attribute dev_attr_temp_max[] +  {
+    __ATTR_N(temp1_max, S_IWUSR | S_IWUSR, show_temp_max, set_temp_max, 0),
+    __ATTR_N(temp2_max, S_IWUSR | S_IWUSR, show_temp_max, set_temp_max, 1),
+    __ATTR_N(temp3_max, S_IWUSR | S_IWUSR, show_temp_max, set_temp_max, 2),
+    __ATTR_N(temp4_max, S_IWUSR | S_IWUSR, show_temp_max, set_temp_max, 3),
+    __ATTR_N(temp5_max, S_IWUSR | S_IWUSR, show_temp_max, set_temp_max, 4),
+    __ATTR_N(temp6_max, S_IWUSR | S_IWUSR, show_temp_max, set_temp_max, 5),
+  };
+static struct device_attribute dev_attr_temp_crit[] +  {
+    __ATTR_N(temp1_crit, S_IWUSR | S_IWUSR, show_temp_crit, set_temp_crit, 0),
+    __ATTR_N(temp2_crit, S_IWUSR | S_IWUSR, show_temp_crit, set_temp_crit, 1),
+    __ATTR_N(temp3_crit, S_IWUSR | S_IWUSR, show_temp_crit, set_temp_crit, 2),
+    __ATTR_N(temp4_crit, S_IWUSR | S_IWUSR, show_temp_crit, set_temp_crit, 3),
+    __ATTR_N(temp5_crit, S_IWUSR | S_IWUSR, show_temp_crit, set_temp_crit, 4),
+    __ATTR_N(temp6_crit, S_IWUSR | S_IWUSR, show_temp_crit, set_temp_crit, 5),
+  };
+
+#endif
+
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
@@ -683,6 +1028,7 @@
 			continue;
 		}
 
+		/* address points to extra_isa */
 		address[i] = val;
 
 		if (i=0) { /* Fans */
@@ -838,6 +1184,19 @@
 	}
 
 	/* Register sysfs hooks */
+
+	#if VOLT_ATTR_LOOP
+
+	if (data->innr)
+	  for (i=0; i<11; i++) { // data->innr; i++) {
+		device_create_file(&new_client->dev, &dev_attr_v_input[i]);
+		device_create_file(&new_client->dev, &dev_attr_v_min[i]);
+		device_create_file(&new_client->dev, &dev_attr_v_max[i]);
+		device_create_file(&new_client->dev, &dev_attr_v_status[i]);
+	}
+
+	#else
+
 	if (data->innr) {
 		device_create_file(&new_client->dev, &dev_attr_in0_input);
 		device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -888,6 +1247,19 @@
 		device_create_file(&new_client->dev, &dev_attr_vrm);
 		device_create_file(&new_client->dev, &dev_attr_alarms_in);
 	}
+	#endif
+
+	#if TEMP_ATTR_LOOP
+
+	for (i=0; i<data->tempnr; i++) {
+		device_create_file(&new_client->dev, &dev_attr_temp_input[i]);
+		device_create_file(&new_client->dev, &dev_attr_temp_min[i]);
+		device_create_file(&new_client->dev, &dev_attr_temp_max[i]);
+		device_create_file(&new_client->dev, &dev_attr_temp_status[i]);
+		device_create_file(&new_client->dev, &dev_attr_temp_crit[i]);
+	}
+
+	#else
 
 	if (data->tempnr) {
 		device_create_file(&new_client->dev, &dev_attr_temp1_input);
@@ -910,6 +1282,7 @@
 		device_create_file(&new_client->dev, &dev_attr_temp3_crit);
 		device_create_file(&new_client->dev, &dev_attr_temp3_status);
 	}
+
 	if (data->innr = 14) {
 		device_create_file(&new_client->dev, &dev_attr_temp4_input);
 		device_create_file(&new_client->dev, &dev_attr_temp5_input);
@@ -928,6 +1301,24 @@
 		device_create_file(&new_client->dev, &dev_attr_temp6_status);
 	}
 
+	#endif
+
+	#if FAN_ATTR_LOOP
+
+	for (i=0; i<data->fannr; i++) {
+
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
+			device_create_file(&new_client->dev, &dev_attr_fan_input[i]);
+			device_create_file(&new_client->dev, &dev_attr_fan_min[i]);
+			device_create_file(&new_client->dev, &dev_attr_fan_div[i]);
+			device_create_file(&new_client->dev, &dev_attr_fan_status[i]);
+		}
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
+			device_create_file(&new_client->dev, &dev_attr_pwm[i]);
+	}
+
+	#else
+
 	if (data->fannr) {
 		if (FAN_CONFIG_MONITOR(data->fan_conf, 0)) {
 			device_create_file(&new_client->dev,
@@ -971,6 +1362,7 @@
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 2))
 			device_create_file(&new_client->dev, &dev_attr_pwm3);
 	}
+	#endif
 
 	return 0;
 
diff -ruN -X exclude-diffs ../linux-2.6.13-rc3-mm1/include/linux/device.h linux/include/linux/device.h
--- ../linux-2.6.13-rc3-mm1/include/linux/device.h	2005-07-18 12:36:48.000000000 -0600
+++ linux/include/linux/device.h	2005-07-27 21:21:40.000000000 -0600
@@ -342,15 +342,29 @@
 
 struct device_attribute {
 	struct attribute	attr;
+
 	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
 			char *buf);
 	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count);
+	int index;
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
+#define __ATTR_N(_name,_mode,_show,_store,_index) { \
+	.attr = {.name = __stringify(_name),	\
+		 .mode = _mode,			\
+		 .owner = THIS_MODULE },	\
+	.show	= _show,			\
+	.store	= _store,			\
+	.index	= _index,			\
+}
+
+#define DEVICE_ATTR_N(_name,_mode,_show,_store, _index) \
+struct device_attribute dev_attr_##_name = __ATTR_N(_name,_mode,_show,_store,_index)
+
 
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
