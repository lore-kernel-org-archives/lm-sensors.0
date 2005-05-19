From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 1/2] i2c: sensors chip driver updates
Message-Id: <20040923041609.GG4256@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch modifies some sysfs file names for sensors chip drivers in
accordance with the standard interface proposed here [1] and refined
here [2].  The lm_sensors userspace tools have been modified to accept
both the new and old names.  This patch was tested for some drivers,
and at least compile tested for the rest.

[1] http://archives.andrew.net.au/lm-sensors/msg08477.html

[2] http://archives.andrew.net.au/lm-sensors/msg18391.html

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.9-rc2-bk6/Documentation/i2c/sysfs-interface
=================================--- linux-2.6.9-rc2-bk6.orig/Documentation/i2c/sysfs-interface	2004-09-22 23:25:52.090798084 -0400
+++ linux-2.6.9-rc2-bk6/Documentation/i2c/sysfs-interface	2004-09-22 23:31:15.457022507 -0400
@@ -135,12 +135,15 @@ fan[1-3]_div	Fan divisor.
 		Note that this is actually an internal clock divisor, which
 		affects the measurable speed range, not the read value.
 
-fan[1-3]_pwm	Pulse width modulation fan control.
+*******
+* PWM *
+*******
+pwm[1-3]	Pulse width modulation fan control.
 		Integer value in the range 0 to 255
 		Read/Write
 		255 is max or 100%.
 
-fan[1-3]_pwm_enable
+pwm[1-3]_enable
 		Switch PWM on and off.
 		Not always present even if fan*_pwm is.
 		0 to turn off
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/adm1031.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/adm1031.c	2004-09-22 23:25:52.086798723 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/adm1031.c	2004-09-22 23:31:15.459022186 -0400
@@ -436,7 +436,7 @@ static ssize_t set_pwm_##offset (struct 
 {									\
 	return set_pwm(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
 		   show_pwm_##offset, set_pwm_##offset)
 
 pwm_reg(1);
@@ -799,7 +799,7 @@ static int adm1031_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
 	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
 	device_create_file(&new_client->dev, &dev_attr_auto_fan1_channel);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -826,7 +826,7 @@ static int adm1031_detect(struct i2c_ada
 		device_create_file(&new_client->dev, &dev_attr_fan2_input);
 		device_create_file(&new_client->dev, &dev_attr_fan2_div);
 		device_create_file(&new_client->dev, &dev_attr_fan2_min);
-		device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
+		device_create_file(&new_client->dev, &dev_attr_pwm2);
 		device_create_file(&new_client->dev,
 				   &dev_attr_auto_fan2_channel);
 		device_create_file(&new_client->dev, &dev_attr_temp3_input);
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/asb100.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/asb100.c	2004-09-22 23:25:52.089798244 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/asb100.c	2004-09-22 23:31:15.461021866 -0400
@@ -591,12 +591,12 @@ static ssize_t set_pwm_enable1(struct de
 	return count;
 }
 
-static DEVICE_ATTR(fan1_pwm, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
-static DEVICE_ATTR(fan1_pwm_enable, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
+static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 		show_pwm_enable1, set_pwm_enable1);
 #define device_create_file_pwm1(client) do { \
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm); \
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable); \
+	device_create_file(&new_client->dev, &dev_attr_pwm1); \
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable); \
 } while (0)
 
 /* This function is called when:
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/lm85.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/lm85.c	2004-09-22 23:25:52.085798883 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/lm85.c	2004-09-22 23:31:15.463021545 -0400
@@ -538,9 +538,10 @@ static ssize_t show_pwm_enable##offset (
 {									\
 	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
 }									\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
 		show_pwm_##offset, set_pwm_##offset);			\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL);
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO, 			\
+		show_pwm_enable##offset, NULL);
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -843,12 +844,12 @@ int lm85_detect(struct i2c_adapter *adap
 	device_create_file(&new_client->dev, &dev_attr_fan2_min);
 	device_create_file(&new_client->dev, &dev_attr_fan3_min);
 	device_create_file(&new_client->dev, &dev_attr_fan4_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan3_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
-	device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
-	device_create_file(&new_client->dev, &dev_attr_fan3_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
+	device_create_file(&new_client->dev, &dev_attr_pwm2);
+	device_create_file(&new_client->dev, &dev_attr_pwm3);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/smsc47m1.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/smsc47m1.c	2004-09-22 23:25:52.082799362 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/smsc47m1.c	2004-09-22 23:31:15.464021384 -0400
@@ -182,13 +182,13 @@ static ssize_t get_fan_div(struct device
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 
-static ssize_t get_fan_pwm(struct device *dev, char *buf, int nr)
+static ssize_t get_pwm(struct device *dev, char *buf, int nr)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
 }
 
-static ssize_t get_fan_pwm_en(struct device *dev, char *buf, int nr)
+static ssize_t get_pwm_en(struct device *dev, char *buf, int nr)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[nr]));
@@ -256,7 +256,7 @@ static ssize_t set_fan_div(struct device
 	return count;
 }
 
-static ssize_t set_fan_pwm(struct device *dev, const char *buf,
+static ssize_t set_pwm(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -275,7 +275,7 @@ static ssize_t set_fan_pwm(struct device
 	return count;
 }
 
-static ssize_t set_fan_pwm_en(struct device *dev, const char *buf,
+static ssize_t set_pwm_en(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -318,23 +318,23 @@ static ssize_t set_fan##offset##_div (st
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t get_fan##offset##_pwm (struct device *dev, char *buf)	\
+static ssize_t get_pwm##offset (struct device *dev, char *buf)		\
 {									\
-	return get_fan_pwm(dev, buf, 0x##offset - 1);			\
+	return get_pwm(dev, buf, 0x##offset - 1);			\
 }									\
-static ssize_t set_fan##offset##_pwm (struct device *dev,		\
+static ssize_t set_pwm##offset (struct device *dev,			\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t get_fan##offset##_pwm_en (struct device *dev, char *buf)	\
+static ssize_t get_pwm##offset##_en (struct device *dev, char *buf)	\
 {									\
-	return get_fan_pwm_en(dev, buf, 0x##offset - 1);		\
+	return get_pwm_en(dev, buf, 0x##offset - 1);			\
 }									\
-static ssize_t set_fan##offset##_pwm_en (struct device *dev,		\
+static ssize_t set_pwm##offset##_en (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_pwm_en(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm_en(dev, buf, count, 0x##offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, get_fan##offset,	\
 		NULL);							\
@@ -342,10 +342,10 @@ static DEVICE_ATTR(fan##offset##_min, S_
 		get_fan##offset##_min, set_fan##offset##_min);		\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
 		get_fan##offset##_div, set_fan##offset##_div);		\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
-		get_fan##offset##_pwm, set_fan##offset##_pwm);		\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR,		\
-		get_fan##offset##_pwm_en, set_fan##offset##_pwm_en);
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
+		get_pwm##offset, set_pwm##offset);			\
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
+		get_pwm##offset##_en, set_pwm##offset##_en);
 
 fan_present(1);
 fan_present(2);
@@ -462,15 +462,15 @@ static int smsc47m1_detect(struct i2c_ad
 
 	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
 	    = 0x04) {
-		device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
-		device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm1);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
 	} else
 		dev_dbg(&new_client->dev, "PWM 1 not enabled by hardware, "
 			"skipping\n");
 	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
 	    = 0x04) {
-		device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
-		device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm2);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
 	} else
 		dev_dbg(&new_client->dev, "PWM 2 not enabled by hardware, "
 			"skipping\n");
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83627hf.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/w83627hf.c	2004-09-22 23:25:52.087798563 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83627hf.c	2004-09-22 23:31:15.466021064 -0400
@@ -845,7 +845,7 @@ store_regs_pwm_##offset (struct device *
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
 		  show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 sysfs_pwm(1);
@@ -854,7 +854,7 @@ sysfs_pwm(3);
 
 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
+device_create_file(&client->dev, &dev_attr_pwm##offset); \
 } while (0)
 
 static ssize_t
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83781d.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/w83781d.c	2004-09-22 23:25:52.084799043 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83781d.c	2004-09-22 23:31:15.469020582 -0400
@@ -740,22 +740,26 @@ static ssize_t show_regs_pwm_##offset (s
 { \
 	return show_pwm_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_pwm_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_pwm_##offset (struct device *dev, \
+		const char *buf, size_t count) \
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset);
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
+		show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 #define sysfs_pwmenable(offset) \
 static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
 { \
 	return show_pwmenable_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_pwmenable_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_pwmenable_##offset (struct device *dev, \
+		const char *buf, size_t count) \
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, \
+		show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
 
 sysfs_pwm(1);
 sysfs_pwm(2);
@@ -765,12 +769,12 @@ sysfs_pwm(4);
 
 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
+device_create_file(&client->dev, &dev_attr_pwm##offset); \
 } while (0)
 
 #define device_create_file_pwmenable(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_pwm_enable); \
+device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
 } while (0)
 
 static ssize_t
-- 
Mark M. Hoffman
mhoffman@lightlink.com
