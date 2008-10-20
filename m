From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 20 Oct 2008 09:28:38 +0000
Subject: [lm-sensors] PATCH: f71882fg-sensor_attr2.patch [1/2]
Message-Id: <48FC4F46.6060808@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020609010206070403050503"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609010206070403050503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Hi Jean (and all),

Convert f71882fg driver from SENSOR_ATTR to SENSOR_ATTR2 use, this is a
preparation patch for adding pwm support, which is broken out to make what
changes really in the pwm support patch clear.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
CC: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Regards,

Hans


--------------020609010206070403050503
Content-Type: text/plain;
 name="f71882fg-sensor_attr2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="f71882fg-sensor_attr2.patch"

From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Convert f71882fg driver from SENSOR_ATTR to SENSOR_ATTR2 use, this is a
preparation patch for adding pwm support, which is broken out to make what
changes really in the pwm support patch clear.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
CC: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
--- f71882fg.c.orig	2008-10-19 13:10:10.000000000 +0200
+++ f71882fg.c	2008-10-19 15:26:32.000000000 +0200
@@ -188,79 +188,84 @@
 	__ATTR( name, S_IRUGO, show_name, NULL ),
 };
 
-static struct sensor_device_attribute f71882fg_in_temp_attr[] =
+static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] =
 {
-	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
-	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
-	SENSOR_ATTR(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max, 1),
-	SENSOR_ATTR(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep, 1),
-	SENSOR_ATTR(in1_alarm, S_IRUGO, show_in_alarm, NULL, 1),
-	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
-	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
-	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
-	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
-	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
-	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
-	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
-	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
-	SENSOR_ATTR(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 0),
-	SENSOR_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 0),
-	SENSOR_ATTR(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 0),
-	SENSOR_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0),
-	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
-	SENSOR_ATTR(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0),
-	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0),
-	SENSOR_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0),
-	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
-	SENSOR_ATTR(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 1),
-	SENSOR_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 1),
-	SENSOR_ATTR(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 1),
-	SENSOR_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 1),
-	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
-	SENSOR_ATTR(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 1),
-	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 1),
-	SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1),
-	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
-	SENSOR_ATTR(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 2),
-	SENSOR_ATTR(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 2),
-	SENSOR_ATTR(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 2),
-	SENSOR_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 2),
-	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
-	SENSOR_ATTR(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 2),
-	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 2),
-	SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2)
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
+	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max,
+		0, 1),
+	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep,
+		0, 1),
+	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
+	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 0, 4),
+	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 0, 5),
+	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
+	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
+	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
+	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 0),
+	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 0),
+	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 0),
+	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		0, 0),
+	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 0),
+	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 1),
+	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 1),
+	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 1),
+	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		0, 1),
+	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 1),
+	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 2),
+	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 2),
+	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 2),
+	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		0, 2),
+	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 2),
+	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2)
 };
 
-static struct sensor_device_attribute f71882fg_fan_attr[] =
+static struct sensor_device_attribute_2 f71882fg_fan_attr[] =
 {
-	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
-	SENSOR_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0),
-	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0),
-	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
-	SENSOR_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 1),
-	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1),
-	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
-	SENSOR_ATTR(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 2),
-	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 2),
-	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
-	SENSOR_ATTR(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 3),
-	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3)
+	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
+	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 0),
+	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
+	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
+	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 1),
+	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
+	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 2),
+	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 3),
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
 };
 
 
@@ -417,7 +422,7 @@
 	char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int speed = fan_from_reg(data->fan[nr]);
 
 	if (speed == FAN_MIN_DETECT)
@@ -430,7 +435,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->fan_beep & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -442,7 +447,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -461,7 +466,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->fan_status & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -473,7 +478,7 @@
 	char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n", data->in[nr] * 8);
 }
@@ -507,7 +512,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->in_beep & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -519,7 +524,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -538,7 +543,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->in_status & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -550,7 +555,7 @@
 	char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n", data->temp[nr] * 1000);
 }
@@ -559,7 +564,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n", data->temp_high[nr] * 1000);
 }
@@ -568,7 +573,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int val = simple_strtoul(buf, NULL, 10) / 1000;
 
 	if (val > 255)
@@ -586,7 +591,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n",
 		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
@@ -596,7 +601,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int val = simple_strtoul(buf, NULL, 10) / 1000;
 	ssize_t ret = count;
 
@@ -636,7 +641,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n", data->temp_ovt[nr] * 1000);
 }
@@ -645,7 +650,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int val = simple_strtoul(buf, NULL, 10) / 1000;
 
 	if (val > 255)
@@ -663,7 +668,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n",
 		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
@@ -673,7 +678,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n", data->temp_type[nr]);
 }
@@ -682,7 +687,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->temp_beep & (1 << (nr + 1)))
 		return sprintf(buf, "1\n");
@@ -694,7 +699,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -713,7 +718,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->temp_status & (1 << (nr + 1)))
 		return sprintf(buf, "1\n");
@@ -725,7 +730,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
-	int nr = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	if (data->temp_diode_open & (1 << (nr + 1)))
 		return sprintf(buf, "1\n");

--------------020609010206070403050503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020609010206070403050503--
