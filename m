From: se.witt@gmx.net (Sebastian Witt)
Date: Wed, 01 Jun 2005 11:43:50 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <429CEBC2.80609@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Adds options to enable the SmartGuardian automatic fan control mode in the
IT8712 chip.

This patch adds following new /sys-files:

pwmX_auto_enable:	Enables automatic mode (manual mode is also working)
pwmX_limit_off:		If this temperature is reached the fan is disabled
pwmX_limit_start:	Temperatures above this will enable the fan
pwmX_limit_full:	Temperatures above this will set the max. fan speed
pwmX_temp_input:	Selects which temperature is used
pwmX_start:		PWM value to start the fan with if it was off
pwmX_step:		PWM step size / temperature C

The fan is controlled linear between limit_start and limit_full by increasing
the PWM value by pwmX_step every temperature increase.

Bye,
Sebastian
-------------- next part --------------
--- it87.c-orig	2005-06-01 00:35:39.000000000 +0200
+++ it87.c	2005-06-01 00:33:50.000000000 +0200
@@ -29,6 +29,10 @@
     Modified to fix bug with not all alarms enabled.
     Added ability to read battery voltage and select temperature sensor
     type at module load time.
+    
+    se.witt@gmx.net Sebastian Witt 5/31/05
+    Added support for SmartGuardian automatic mode and added
+    module option to force PWM initializing
 */
 
 #include <linux/config.h>
@@ -104,6 +108,9 @@
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
+/* Force enabling PWM */
+static int force_pwm;
+
 /* Chip Type */
 
 static u16 chip_type;
@@ -151,6 +158,12 @@
 
 #define IT87_REG_CHIPID        0x58
 
+#define IT87_REG_SG_TEMP_OFF(nr) 	(0x60 + (nr) * 8)
+#define IT87_REG_SG_TEMP_START(nr)  (0x61 + (nr) * 8)
+#define IT87_REG_SG_TEMP_FULL(nr)   (0x62 + (nr) * 8)
+#define IT87_REG_SG_START_PWM(nr)   (0x63 + (nr) * 8)
+#define IT87_REG_SG_AM_CTRL(nr)     (0x64 + (nr) * 8)
+
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
 #define IN_FROM_REG(val) ((val) * 16)
 
@@ -197,21 +210,27 @@
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u8 in[9];		/* Register value */
+	u8 in[9];			/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
-	u8 fan[3];		/* Register value */
+	u8 fan[3];			/* Register value */
 	u8 fan_min[3];		/* Register value */
-	u8 temp[3];		/* Register value */
+	u8 temp[3];			/* Register value */
 	u8 temp_high[3];	/* Register value */
 	u8 temp_low[3];		/* Register value */
-	u8 sensor;		/* Register value */
+	u8 sensor;			/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
-	u8 vid;			/* Register encoding, combined */
+	u8 vid;				/* Register encoding, combined */
 	int vrm;
-	u32 alarms;		/* Register encoding, combined */
+	u32 alarms;			/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
-	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
+	u8 fan_ctrl;		/* Register value */
+	u8 manual_pwm_ctl[3];   	/* manual PWM value set by user */
+	u8 fan_limit_off[3];		/* Register value */
+	u8 fan_limit_start[3];		/* Register value */
+	u8 fan_limit_full[3];		/* Register value */
+	u8 fan_limit_stpwm[3];		/* Register value */
+	u8 fan_am_ctrl[3];			/* Register value */
 };
 
 
@@ -468,10 +487,45 @@
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
 }
+static ssize_t show_pwm_auto_enable(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", (data->manual_pwm_ctl[nr] & 0x80) ? 1 : 0);
+}
 static ssize_t show_pwm(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
+	return sprintf(buf,"%d\n", (data->manual_pwm_ctl[nr] & 0x80) ? 0 : PWM_FROM_REG(data->manual_pwm_ctl[nr]));
+}
+static ssize_t show_pwm_limit_off(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_limit_off[nr]);
+}
+static ssize_t show_pwm_limit_start(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_limit_start[nr]);
+}
+static ssize_t show_pwm_limit_full(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_limit_full[nr]);
+}
+static ssize_t show_pwm_start(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->fan_limit_stpwm[nr]));
+}
+static ssize_t show_pwm_temp_input(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", (data->manual_pwm_ctl[nr] & 0x80) ? (data->manual_pwm_ctl[nr] & 0x03) + 1 : 0);
+}
+static ssize_t show_pwm_step(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", (data->fan_am_ctrl[nr] & 0x07) ? (1 << ((data->fan_am_ctrl[nr] & 0x07)-1)) : 0);
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
@@ -528,9 +582,9 @@
 
 	if (val = 0) {
 		int tmp;
-		/* make sure the fan is on when in on/off mode */
+		/* make sure the fan is on when in on/off mode and set polarity mode to active high */
 		tmp = it87_read_value(client, IT87_REG_FAN_CTL);
-		it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr));
+		it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr) | 0x80);
 		/* set on/off mode */
 		data->fan_main_ctrl &= ~(1 << nr);
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
@@ -538,8 +592,35 @@
 		/* set SmartGuardian mode */
 		data->fan_main_ctrl |= (1 << nr);
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
-		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
-		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+		/* set saved pwm value */
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+static ssize_t set_pwm_auto_enable(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val = 0) {
+		/* Disable automatic mode, set fans to full speed */
+		data->manual_pwm_ctl[nr] = 0x7f;
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+	} else if (val = 1) {
+		/* Start PWM control if required */
+		if ((data->fan_main_ctrl & (1 << nr)) = 0) {
+			set_pwm_enable(dev, "1", 1, nr);
+		}
+		/* Enable automatic mode */
+		data->manual_pwm_ctl[nr] |= 0x80;
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+		/* Enable temp. smoothing, fan spin up  time and 16 PWM / C */
+		data->fan_am_ctrl[nr] = 0x80 | 0x18 | 0x05;
+		it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
 	} else
 		return -EINVAL;
 
@@ -555,9 +636,97 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
 
-	data->manual_pwm_ctl[nr] = val;
+	/* Automatic mode gets disabled if writing a manual PWM value */
+	data->manual_pwm_ctl[nr] = PWM_TO_REG(val);
 	if (data->fan_main_ctrl & (1 << nr))
-		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+
+	return count;
+}
+static ssize_t set_pwm_limit_off(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	data->fan_limit_off[nr] = val;
+	it87_write_value(client, IT87_REG_SG_TEMP_OFF(nr), data->fan_limit_off[nr]);
+
+	return count;
+}
+static ssize_t set_pwm_limit_start(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	data->fan_limit_start[nr] = val;
+	it87_write_value(client, IT87_REG_SG_TEMP_START(nr), data->fan_limit_start[nr]);
+
+	return count;
+}
+static ssize_t set_pwm_limit_full(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	data->fan_limit_full[nr] = val;
+	it87_write_value(client, IT87_REG_SG_TEMP_FULL(nr), data->fan_limit_full[nr]);
+
+	return count;
+}
+static ssize_t set_pwm_start(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+	
+	data->fan_limit_stpwm[nr] = PWM_TO_REG(val);
+	it87_write_value(client, IT87_REG_SG_START_PWM(nr), data->fan_limit_stpwm[nr]);
+
+	return count;
+}
+static ssize_t set_pwm_temp_input(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 1 || val > 3)
+		return -EINVAL;
+	
+	/* Check if automatic control is enabled */
+	if (data->manual_pwm_ctl[nr] & 0x80) {
+		data->manual_pwm_ctl[nr] = 0x80 | (val - 1);
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+	}
+
+	return count;
+}
+static ssize_t set_pwm_step(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 7)
+		return -EINVAL;
+	
+	data->fan_am_ctrl[nr] &= ~0x07;
+	data->fan_am_ctrl[nr] |= val;
+	
+	it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+	
 
 	return count;
 }
@@ -601,25 +770,104 @@
 {									\
 	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
+static ssize_t show_pwm##offset##_auto_enable (struct device *dev,		\
+	char *buf)							\
+{									\
+	return show_pwm_auto_enable(dev, buf, offset - 1);			\
+}									\
 static ssize_t show_pwm##offset (struct device *dev, char *buf)		\
 {									\
 	return show_pwm(dev, buf, offset - 1);				\
 }									\
+static ssize_t show_pwm##offset##_limit_off (struct device *dev, char *buf)		\
+{									\
+	return show_pwm_limit_off(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_limit_start (struct device *dev, char *buf)		\
+{									\
+	return show_pwm_limit_start(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_limit_full (struct device *dev, char *buf)		\
+{									\
+	return show_pwm_limit_full(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_start (struct device *dev, char *buf)		\
+{									\
+	return show_pwm_start(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_temp_input (struct device *dev, char *buf)		\
+{									\
+	return show_pwm_temp_input(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_step (struct device *dev, char *buf)		\
+{									\
+	return show_pwm_step(dev, buf, offset - 1);				\
+}									\
 static ssize_t set_pwm##offset##_enable (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
 	return set_pwm_enable(dev, buf, count, offset - 1);		\
 }									\
+static ssize_t set_pwm##offset##_auto_enable (struct device *dev,		\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_auto_enable(dev, buf, count, offset - 1);		\
+}									\
 static ssize_t set_pwm##offset (struct device *dev,			\
 		const char *buf, size_t count)				\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
+static ssize_t set_pwm##offset##_limit_off (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_limit_off(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_limit_start (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_limit_start(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_limit_full (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_limit_full(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_start (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_start(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_temp_input (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_temp_input(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_step (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_step(dev, buf, count, offset - 1);			\
+}									\
 static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
 		show_pwm##offset##_enable,				\
 		set_pwm##offset##_enable);				\
+static DEVICE_ATTR(pwm##offset##_auto_enable, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_auto_enable,				\
+		set_pwm##offset##_auto_enable);				\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
-		show_pwm##offset , set_pwm##offset );
+		show_pwm##offset , set_pwm##offset );		\
+static DEVICE_ATTR(pwm##offset##_limit_off, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset##_limit_off , set_pwm##offset##_limit_off );	\
+static DEVICE_ATTR(pwm##offset##_limit_start, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset##_limit_start , set_pwm##offset##_limit_start );	\
+static DEVICE_ATTR(pwm##offset##_limit_full, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset##_limit_full , set_pwm##offset##_limit_full );	\
+static DEVICE_ATTR(pwm##offset##_start, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset##_start , set_pwm##offset##_start );		\
+static DEVICE_ATTR(pwm##offset##_temp_input, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset##_temp_input , set_pwm##offset##_temp_input );	\
+static DEVICE_ATTR(pwm##offset##_step, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset##_step , set_pwm##offset##_step );
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -829,11 +1077,13 @@
 	 * and polarity set to active low is sign that this is the case so we
 	 * disable pwm control to protect the user. */
 	enable_pwm_interface = 1;
-	tmp = it87_read_value(new_client, IT87_REG_FAN_CTL);
-	if ((tmp & 0x87) = 0) {
-		enable_pwm_interface = 0;
-		dev_info(&new_client->dev,
-			"detected broken BIOS defaults, disabling pwm interface");
+	if (!force_pwm) {
+		tmp = it87_read_value(new_client, IT87_REG_FAN_CTL);
+		if ((tmp & 0x87) = 0) {
+			enable_pwm_interface = 0;
+			dev_info(&new_client->dev,
+				"detected broken BIOS defaults, disabling pwm interface");
+		}
 	}
 
 	/* Register sysfs hooks */
@@ -888,9 +1138,30 @@
 		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
 		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
 		device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_auto_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_auto_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_auto_enable);
 		device_create_file(&new_client->dev, &dev_attr_pwm1);
 		device_create_file(&new_client->dev, &dev_attr_pwm2);
 		device_create_file(&new_client->dev, &dev_attr_pwm3);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_limit_off);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_limit_off);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_limit_off);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_limit_start);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_limit_start);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_limit_start);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_limit_full);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_limit_full);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_limit_full);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_start);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_start);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_start);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_temp_input);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_temp_input);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_temp_input);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_step);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_step);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_step);
 	}
 
 	if (data->type = it8712) {
@@ -971,17 +1242,6 @@
 {
 	int tmp, i;
 
-	/* initialize to sane defaults:
-	 * - if the chip is in manual pwm mode, this will be overwritten with
-	 *   the actual settings on the chip (so in this case, initialization
-	 *   is not needed)
-	 * - if in automatic or on/off mode, we could switch to manual mode,
-	 *   read the registers and set manual_pwm_ctl accordingly, but currently
-	 *   this is not implemented, so we initialize to something sane */
-	for (i = 0; i < 3; i++) {
-		data->manual_pwm_ctl[i] = 0xff;
-	}
-
 	/* Check if temperature channnels are reset manually or by some reason */
 	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 	if ((tmp & 0x3f) = 0) {
@@ -1006,24 +1266,21 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 
-	/* Set current fan mode registers and the default settings for the
-	 * other mode registers */
+	/* Set current fan mode registers */
 	for (i = 0; i < 3; i++) {
-		if (data->fan_main_ctrl & (1 << i)) {
-			/* pwm mode */
-			tmp = it87_read_value(client, IT87_REG_PWM(i));
-			if (tmp & 0x80) {
-				/* automatic pwm - not yet implemented, but
-				 * leave the settings made by the BIOS alone
-				 * until a change is requested via the sysfs
-				 * interface */
-			} else {
-				/* manual pwm */
-				data->manual_pwm_ctl[i] = PWM_FROM_REG(tmp);
-			}
-		}
+			data->manual_pwm_ctl[i] = it87_read_value(client, IT87_REG_PWM(i));
  	}
-
+	
+	/* Get fan control registers for SmartGuardian automatic mode */
+	data->fan_ctrl = it87_read_value(client, IT87_REG_FAN_CTL);
+	for (i = 0; i < 3; i++) {
+		data->fan_limit_off[i] = it87_read_value(client, IT87_REG_SG_TEMP_OFF(i));
+		data->fan_limit_start[i] = it87_read_value(client, IT87_REG_SG_TEMP_START(i));
+		data->fan_limit_full[i] = it87_read_value(client, IT87_REG_SG_TEMP_FULL(i));
+		data->fan_limit_stpwm[i] = it87_read_value(client, IT87_REG_SG_START_PWM(i));
+		data->fan_am_ctrl[i] = it87_read_value(client, IT87_REG_SG_AM_CTRL(i));
+	}
+	
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
 			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
@@ -1123,9 +1380,12 @@
 
 
 MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>");
+MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 module_param(update_vbat, bool, 0);
+module_param(force_pwm, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM_DESC(force_pwm, "Force initializing PWM");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);
