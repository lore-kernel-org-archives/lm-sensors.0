From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Sep 2006 18:59:49 +0000
Subject: [lm-sensors] [PATCH 08/23] hwmon: Fix unchecked return status,
Message-Id: <20060924205949.47d2a24f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Mark M. Hoffman" <mhoffman at lightlink.com>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-1.patch

hwmon: Fix unchecked return status, batch 1

Fix up some hwmon drivers so that they no longer ignore return status
from device_create_file().

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/asb100.c     |  122 +++++++++++++----------
 drivers/hwmon/lm75.c       |   24 +++--
 drivers/hwmon/lm78.c       |   88 ++++++++++-------
 drivers/hwmon/smsc47b397.c |   39 ++++---
 drivers/hwmon/w83627hf.c   |  232 ++++++++++++++++++++++++++------------------
 5 files changed, 299 insertions(+), 206 deletions(-)

--- linux-2.6.18.orig/drivers/hwmon/asb100.c	2006-09-23 15:24:24.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/asb100.c	2006-09-23 16:35:16.000000000 +0200
@@ -298,12 +298,6 @@
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
@@ -421,12 +415,6 @@
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
@@ -515,12 +503,6 @@
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
@@ -528,8 +510,6 @@
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-#define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* VRM */
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
@@ -549,8 +529,6 @@
 
 /* Alarms */
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm);
 
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -559,8 +537,6 @@
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-#define device_create_file_alarms(client) \
-device_create_file(&client->dev, &dev_attr_alarms)
 
 /* 1 PWM */
 static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
@@ -607,10 +583,65 @@
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
+	NULL
+};
+
+static const struct attribute_group asb100_group = {
+	.attrs = asb100_attributes,
+};
 
 /* This function is called when:
 	asb100_driver is inserted (when this module is loaded), for each
@@ -810,38 +841,19 @@
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
@@ -861,8 +873,10 @@
 	int err;
 
 	/* main client */
-	if (data)
+	if (data) {
 		hwmon_device_unregister(data->class_dev);
+		sysfs_remove_group(&client->dev.kobj, &asb100_group);
+	}
 
 	if ((err = i2c_detach_client(client)))
 		return err;
--- linux-2.6.18.orig/drivers/hwmon/lm75.c	2006-09-23 15:24:24.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/lm75.c	2006-09-23 16:35:16.000000000 +0200
@@ -112,6 +112,18 @@
 	return i2c_probe(adapter, &addr_data, lm75_detect);
 }
 
+static struct attribute *lm75_attributes[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_max_hyst.attr,
+
+	NULL
+};
+
+static const struct attribute_group lm75_group = {
+	.attrs = lm75_attributes,
+};
+
 /* This function is called by i2c_probe */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
@@ -199,18 +211,19 @@
 	lm75_init_client(new_client);
 	
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm75_group)))
+		goto exit_detach;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-
 	return 0;
 
+exit_remove:
+	sysfs_remove_group(&new_client->dev.kobj, &lm75_group);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
@@ -223,6 +236,7 @@
 {
 	struct lm75_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 	i2c_detach_client(client);
 	kfree(data);
 	return 0;
--- linux-2.6.18.orig/drivers/hwmon/lm78.c	2006-09-23 15:24:24.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/lm78.c	2006-09-23 16:35:16.000000000 +0200
@@ -482,6 +482,50 @@
 	return lm78_detect(adapter, isa_address, -1);
 }
 
+static struct attribute *lm78_attributes[] = {
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
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_max_hyst.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_min.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan2_min.attr,
+	&dev_attr_fan2_div.attr,
+	&dev_attr_fan3_input.attr,
+	&dev_attr_fan3_min.attr,
+	&dev_attr_fan3_div.attr,
+	&dev_attr_alarms.attr,
+	&dev_attr_cpu0_vid.attr,
+
+	NULL
+};
+
+static const struct attribute_group lm78_group = {
+	.attrs = lm78_attributes,
+};
+
 /* This function is called by i2c_probe */
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
@@ -616,50 +660,19 @@
 	}
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm78_group)))
+		goto ERROR3;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto ERROR3;
+		goto ERROR4;
 	}
 
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
-	device_create_file(&new_client->dev, &dev_attr_in5_input);
-	device_create_file(&new_client->dev, &dev_attr_in5_min);
-	device_create_file(&new_client->dev, &dev_attr_in5_max);
-	device_create_file(&new_client->dev, &dev_attr_in6_input);
-	device_create_file(&new_client->dev, &dev_attr_in6_min);
-	device_create_file(&new_client->dev, &dev_attr_in6_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_fan3_input);
-	device_create_file(&new_client->dev, &dev_attr_fan3_min);
-	device_create_file(&new_client->dev, &dev_attr_fan3_div);
-	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
-
 	return 0;
 
+ERROR4:
+	sysfs_remove_group(&new_client->dev.kobj, &lm78_group);
 ERROR3:
 	i2c_detach_client(new_client);
 ERROR2:
@@ -677,6 +690,7 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm78_group);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
--- linux-2.6.18.orig/drivers/hwmon/smsc47b397.c	2006-09-23 15:24:24.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/smsc47b397.c	2006-09-23 16:35:16.000000000 +0200
@@ -176,9 +176,6 @@
 sysfs_temp(3);
 sysfs_temp(4);
 
-#define device_create_file_temp(client, num) \
-	device_create_file(&client->dev, &dev_attr_temp##num##_input)
-
 /* FAN: 1 RPM/bit
    REG: count of 90kHz pulses / revolution */
 static int fan_from_reg(u16 reg)
@@ -205,8 +202,22 @@
 sysfs_fan(3);
 sysfs_fan(4);
 
-#define device_create_file_fan(client, num) \
-	device_create_file(&client->dev, &dev_attr_fan##num##_input)
+static struct attribute *smsc47b397_attributes[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp3_input.attr,
+	&dev_attr_temp4_input.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan3_input.attr,
+	&dev_attr_fan4_input.attr,
+
+	NULL
+};
+
+static const struct attribute_group smsc47b397_group = {
+	.attrs = smsc47b397_attributes,
+};
 
 static int smsc47b397_detach_client(struct i2c_client *client)
 {
@@ -214,6 +225,7 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &smsc47b397_group);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
@@ -268,24 +280,19 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto error_free;
 
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &smsc47b397_group)))
+		goto error_detach;
+
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto error_detach;
+		goto error_remove;
 	}
 
-	device_create_file_temp(new_client, 1);
-	device_create_file_temp(new_client, 2);
-	device_create_file_temp(new_client, 3);
-	device_create_file_temp(new_client, 4);
-
-	device_create_file_fan(new_client, 1);
-	device_create_file_fan(new_client, 2);
-	device_create_file_fan(new_client, 3);
-	device_create_file_fan(new_client, 4);
-
 	return 0;
 
+error_remove:
+	sysfs_remove_group(&new_client->dev.kobj, &smsc47b397_group);
 error_detach:
 	i2c_detach_client(new_client);
 error_free:
--- linux-2.6.18.orig/drivers/hwmon/w83627hf.c	2006-09-23 15:24:24.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/w83627hf.c	2006-09-23 16:35:16.000000000 +0200
@@ -512,13 +512,6 @@
 static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
 	show_regs_in_max0, store_regs_in_max0);
 
-#define device_create_file_in(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_in##offset##_input); \
-device_create_file(&client->dev, &dev_attr_in##offset##_min); \
-device_create_file(&client->dev, &dev_attr_in##offset##_max); \
-} while (0)
-
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
@@ -576,12 +569,6 @@
 sysfs_fan_offset(3);
 sysfs_fan_min_offset(3);
 
-#define device_create_file_fan(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
-device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
-} while (0)
-
 #define show_temp_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
@@ -656,13 +643,6 @@
 sysfs_temp_offsets(2);
 sysfs_temp_offsets(3);
 
-#define device_create_file_temp(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
-device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
-device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
-} while (0)
-
 static ssize_t
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -670,8 +650,6 @@
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
-#define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -692,8 +670,6 @@
 	return count;
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm)
 
 static ssize_t
 show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -702,8 +678,6 @@
 	return sprintf(buf, "%ld\n", (long) data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
-#define device_create_file_alarms(client) \
-device_create_file(&client->dev, &dev_attr_alarms)
 
 #define show_beep_reg(REG, reg) \
 static ssize_t show_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
@@ -766,12 +740,6 @@
 sysfs_beep(ENABLE, enable);
 sysfs_beep(MASK, mask);
 
-#define device_create_file_beep(client) \
-do { \
-device_create_file(&client->dev, &dev_attr_beep_enable); \
-device_create_file(&client->dev, &dev_attr_beep_mask); \
-} while (0)
-
 static ssize_t
 show_fan_div_reg(struct device *dev, char *buf, int nr)
 {
@@ -837,11 +805,6 @@
 sysfs_fan_div(2);
 sysfs_fan_div(3);
 
-#define device_create_file_fan_div(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
-} while (0)
-
 static ssize_t
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
@@ -896,11 +859,6 @@
 sysfs_pwm(2);
 sysfs_pwm(3);
 
-#define device_create_file_pwm(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_pwm##offset); \
-} while (0)
-
 static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
@@ -972,12 +930,6 @@
 sysfs_sensor(2);
 sysfs_sensor(3);
 
-#define device_create_file_sensor(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
-} while (0)
-
-
 static int __init w83627hf_find(int sioaddr, unsigned short *addr)
 {
 	u16 val;
@@ -1009,6 +961,85 @@
 	return 0;
 }
 
+static struct attribute *w83627hf_attributes[] = {
+	&dev_attr_in0_input.attr,
+	&dev_attr_in0_min.attr,
+	&dev_attr_in0_max.attr,
+	&dev_attr_in2_input.attr,
+	&dev_attr_in2_min.attr,
+	&dev_attr_in2_max.attr,
+	&dev_attr_in3_input.attr,
+	&dev_attr_in3_min.attr,
+	&dev_attr_in3_max.attr,
+	&dev_attr_in4_input.attr,
+	&dev_attr_in4_min.attr,
+	&dev_attr_in4_max.attr,
+	&dev_attr_in7_input.attr,
+	&dev_attr_in7_min.attr,
+	&dev_attr_in7_max.attr,
+	&dev_attr_in8_input.attr,
+	&dev_attr_in8_min.attr,
+	&dev_attr_in8_max.attr,
+
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_min.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan2_min.attr,
+	&dev_attr_fan2_div.attr,
+
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_max_hyst.attr,
+	&dev_attr_temp1_type.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp2_max_hyst.attr,
+	&dev_attr_temp2_type.attr,
+
+	&dev_attr_alarms.attr,
+	&dev_attr_beep_enable.attr,
+	&dev_attr_beep_mask.attr,
+
+	&dev_attr_pwm1.attr,
+	&dev_attr_pwm2.attr,
+
+	NULL
+};
+
+static const struct attribute_group w83627hf_group = {
+	.attrs = w83627hf_attributes,
+};
+
+static struct attribute *w83627hf_attributes_opt[] = {
+	&dev_attr_in1_input.attr,
+	&dev_attr_in1_min.attr,
+	&dev_attr_in1_max.attr,
+	&dev_attr_in5_input.attr,
+	&dev_attr_in5_min.attr,
+	&dev_attr_in5_max.attr,
+	&dev_attr_in6_input.attr,
+	&dev_attr_in6_min.attr,
+	&dev_attr_in6_max.attr,
+
+	&dev_attr_fan3_input.attr,
+	&dev_attr_fan3_min.attr,
+	&dev_attr_fan3_div.attr,
+
+	&dev_attr_temp3_input.attr,
+	&dev_attr_temp3_max.attr,
+	&dev_attr_temp3_max_hyst.attr,
+	&dev_attr_temp3_type.attr,
+
+	&dev_attr_pwm3.attr,
+
+	NULL
+};
+
+static const struct attribute_group w83627hf_group_opt = {
+	.attrs = w83627hf_attributes_opt,
+};
+
 static int w83627hf_detect(struct i2c_adapter *adapter)
 {
 	int val, kind;
@@ -1108,62 +1139,72 @@
 	data->fan_min[1] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(2));
 	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
 
-	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	/* Register common device attributes */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &w83627hf_group)))
 		goto ERROR3;
-	}
 
-	device_create_file_in(new_client, 0);
-	if (kind != w83697hf)
-		device_create_file_in(new_client, 1);
-	device_create_file_in(new_client, 2);
-	device_create_file_in(new_client, 3);
-	device_create_file_in(new_client, 4);
-	if (kind = w83627hf || kind = w83697hf) {
-		device_create_file_in(new_client, 5);
-		device_create_file_in(new_client, 6);
-	}
-	device_create_file_in(new_client, 7);
-	device_create_file_in(new_client, 8);
+	/* Register chip-specific device attributes */
+	if (kind = w83627hf || kind = w83697hf)
+		if ((err = device_create_file(&new_client->dev,
+					&dev_attr_in5_input))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in5_min))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in5_max))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in6_input))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in6_min))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in6_max)))
+			goto ERROR4;
 
-	device_create_file_fan(new_client, 1);
-	device_create_file_fan(new_client, 2);
 	if (kind != w83697hf)
-		device_create_file_fan(new_client, 3);
+		if ((err = device_create_file(&new_client->dev,
+					&dev_attr_in1_input))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in1_min))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_in1_max))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_fan3_input))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_fan3_min))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_fan3_div))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_temp3_input))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_temp3_max))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_temp3_max_hyst))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_temp3_type)))
+			goto ERROR4;
+
+	if (kind != w83697hf && data->vid != 0xff)
+		if ((err = device_create_file(&new_client->dev,
+					&dev_attr_cpu0_vid))
+		 || (err = device_create_file(&new_client->dev,
+					&dev_attr_vrm)))
+			goto ERROR4;
 
-	device_create_file_temp(new_client, 1);
-	device_create_file_temp(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_temp(new_client, 3);
-
-	if (kind != w83697hf && data->vid != 0xff) {
-		device_create_file_vid(new_client);
-		device_create_file_vrm(new_client);
-	}
-
-	device_create_file_fan_div(new_client, 1);
-	device_create_file_fan_div(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_fan_div(new_client, 3);
-
-	device_create_file_alarms(new_client);
-
-	device_create_file_beep(new_client);
-
-	device_create_file_pwm(new_client, 1);
-	device_create_file_pwm(new_client, 2);
 	if (kind = w83627thf || kind = w83637hf || kind = w83687thf)
-		device_create_file_pwm(new_client, 3);
+		if ((err = device_create_file(&new_client->dev,
+					&dev_attr_pwm3)))
+			goto ERROR4;
 
-	device_create_file_sensor(new_client, 1);
-	device_create_file_sensor(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_sensor(new_client, 3);
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR4;
+	}
 
 	return 0;
 
+      ERROR4:
+	sysfs_remove_group(&new_client->dev.kobj, &w83627hf_group);
+	sysfs_remove_group(&new_client->dev.kobj, &w83627hf_group_opt);
       ERROR3:
 	i2c_detach_client(new_client);
       ERROR2:
@@ -1181,6 +1222,9 @@
 
 	hwmon_device_unregister(data->class_dev);
 
+	sysfs_remove_group(&client->dev.kobj, &w83627hf_group);
+	sysfs_remove_group(&client->dev.kobj, &w83627hf_group_opt);
+
 	if ((err = i2c_detach_client(client)))
 		return err;
 

-- 
Jean Delvare

