From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 02 Aug 2006 13:08:11 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc2-mm1] hwmon: unchecked return
Message-Id: <20060802130811.GF3141@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

Here is asb100.c... I'll add lm75, lm78, smsc47b397, and w83627hf
to this patch as I have time.  (Jean: don't apply yet.)

---

This patch fixes up some hwmon drivers so that they no longer ignore
return status from device_create_file().

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>

--- linux-2.6.18-rc2-mm1.orig/drivers/hwmon/asb100.c
+++ linux-2.6.18-rc2-mm1/drivers/hwmon/asb100.c
@@ -298,12 +298,6 @@ sysfs_in(4);
 sysfs_in(5);
 sysfs_in(6);
 
-#define device_create_file_in(client, offset) do { \
-	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
-	device_create_file(&client->dev, &dev_attr_in##offset##_min); \
-	device_create_file(&client->dev, &dev_attr_in##offset##_max); \
-} while (0)
-
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
@@ -421,12 +415,6 @@ sysfs_fan(1);
 sysfs_fan(2);
 sysfs_fan(3);
 
-#define device_create_file_fan(client, offset) do { \
-	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
-	device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
-	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
-} while (0)
-
 /* 4 Temp. Sensors */
 static int sprintf_temp_from_reg(u16 reg, char *buf, int nr)
 {
@@ -515,12 +503,6 @@ sysfs_temp(3);
 sysfs_temp(4);
 
 /* VID */
-#define device_create_file_temp(client, num) do { \
-	device_create_file(&client->dev, &dev_attr_temp##num##_input); \
-	device_create_file(&client->dev, &dev_attr_temp##num##_max); \
-	device_create_file(&client->dev, &dev_attr_temp##num##_max_hyst); \
-} while (0)
-
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
@@ -528,8 +510,6 @@ static ssize_t show_vid(struct device *d
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-#define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* VRM */
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
@@ -549,8 +529,6 @@ static ssize_t set_vrm(struct device *de
 
 /* Alarms */
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm);
 
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -559,8 +537,6 @@ static ssize_t show_alarms(struct device
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-#define device_create_file_alarms(client) \
-device_create_file(&client->dev, &dev_attr_alarms)
 
 /* 1 PWM */
 static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
@@ -607,10 +583,65 @@ static ssize_t set_pwm_enable1(struct de
 static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
 static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 		show_pwm_enable1, set_pwm_enable1);
-#define device_create_file_pwm1(client) do { \
-	device_create_file(&new_client->dev, &dev_attr_pwm1); \
-	device_create_file(&new_client->dev, &dev_attr_pwm1_enable); \
-} while (0)
+
+static struct attribute *asb100_attributes[] = {
+	&dev_attr_in0_input.attr,
+	&dev_attr_in0_min.attr,
+	&dev_attr_in0_max.attr,
+	&dev_attr_in1_input.attr,
+	&dev_attr_in1_min.attr,
+	&dev_attr_in1_max.attr,
+	&dev_attr_in2_input.attr,
+	&dev_attr_in2_min.attr,
+	&dev_attr_in2_max.attr,
+	&dev_attr_in3_input.attr,
+	&dev_attr_in3_min.attr,
+	&dev_attr_in3_max.attr,
+	&dev_attr_in4_input.attr,
+	&dev_attr_in4_min.attr,
+	&dev_attr_in4_max.attr,
+	&dev_attr_in5_input.attr,
+	&dev_attr_in5_min.attr,
+	&dev_attr_in5_max.attr,
+	&dev_attr_in6_input.attr,
+	&dev_attr_in6_min.attr,
+	&dev_attr_in6_max.attr,
+
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_min.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan2_min.attr,
+	&dev_attr_fan2_div.attr,
+	&dev_attr_fan3_input.attr,
+	&dev_attr_fan3_min.attr,
+	&dev_attr_fan3_div.attr,
+
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_max_hyst.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp2_max_hyst.attr,
+	&dev_attr_temp3_input.attr,
+	&dev_attr_temp3_max.attr,
+	&dev_attr_temp3_max_hyst.attr,
+	&dev_attr_temp4_input.attr,
+	&dev_attr_temp4_max.attr,
+	&dev_attr_temp4_max_hyst.attr,
+
+	&dev_attr_cpu0_vid.attr,
+	&dev_attr_vrm.attr,
+	&dev_attr_alarms.attr,
+	&dev_attr_pwm1.attr,
+	&dev_attr_pwm1_enable.attr,
+
+	NULL,
+};
+
+static struct attribute_group asb100_group = {
+	.attrs = asb100_attributes,
+};
 
 /* This function is called when:
 	asb100_driver is inserted (when this module is loaded), for each
@@ -810,38 +841,19 @@ static int asb100_detect(struct i2c_adap
 	data->fan_min[2] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &asb100_group)))
+		goto ERROR3;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto ERROR3;
+		goto ERROR4;
 	}
 
-	device_create_file_in(new_client, 0);
-	device_create_file_in(new_client, 1);
-	device_create_file_in(new_client, 2);
-	device_create_file_in(new_client, 3);
-	device_create_file_in(new_client, 4);
-	device_create_file_in(new_client, 5);
-	device_create_file_in(new_client, 6);
-
-	device_create_file_fan(new_client, 1);
-	device_create_file_fan(new_client, 2);
-	device_create_file_fan(new_client, 3);
-
-	device_create_file_temp(new_client, 1);
-	device_create_file_temp(new_client, 2);
-	device_create_file_temp(new_client, 3);
-	device_create_file_temp(new_client, 4);
-
-	device_create_file_vid(new_client);
-	device_create_file_vrm(new_client);
-
-	device_create_file_alarms(new_client);
-
-	device_create_file_pwm1(new_client);
-
 	return 0;
 
+ERROR4:
+	sysfs_remove_group(&new_client->dev.kobj, &asb100_group);
 ERROR3:
 	i2c_detach_client(data->lm75[1]);
 	i2c_detach_client(data->lm75[0]);
@@ -861,8 +873,10 @@ static int asb100_detach_client(struct i
 	int err;
 
 	/* main client */
-	if (data)
+	if (data) {
 		hwmon_device_unregister(data->class_dev);
+		sysfs_remove_group(&client->dev.kobj, &asb100_group);
+	}
 
 	if ((err = i2c_detach_client(client)))
 		return err;
-- 
Mark M. Hoffman
mhoffman at lightlink.com


