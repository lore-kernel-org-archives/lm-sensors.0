From: se.witt@gmx.net (Sebastian Witt)
Date: Sat, 04 Jun 2005 16:48:58 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <42A1BF68.50606@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hi Sebastian
> 
> I will put some comments into the code. I think those I made are enough
> for next iteration.
> 
Hi Rudolf,

thanks for the comments, here's the next one. Patch against 2.6.12-rc5-mm2.

Regards,
Sebastian

-------------- next part --------------
--- linux-2.6.12-rc5-mm2_orig/drivers/i2c/chips/it87.c	2005-06-02 00:48:17.000000000 +0200
+++ linux-2.6.12-rc5-mm2/drivers/i2c/chips/it87.c	2005-06-04 16:21:17.000000000 +0200
@@ -154,6 +154,12 @@
 
 #define IT87_REG_CHIPID        0x58
 
+#define IT87_REG_SG_TEMP_OFF(nr) 	(0x60 + (nr) * 8)
+#define IT87_REG_SG_TEMP_START(nr)	(0x61 + (nr) * 8)
+#define IT87_REG_SG_TEMP_FULL(nr)	(0x62 + (nr) * 8)
+#define IT87_REG_SG_START_PWM(nr)	(0x63 + (nr) * 8)
+#define IT87_REG_SG_AM_CTRL(nr)		(0x64 + (nr) * 8)
+
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
 #define IN_FROM_REG(val) ((val) * 16)
 
@@ -213,6 +219,11 @@
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
+	u8 fan_limit_off[3];	/* Register value */
+	u8 fan_limit_start[3];	/* Register value */
+	u8 fan_limit_full[3];	/* Register value */
+	u8 fan_limit_stpwm[3];	/* Register value */
+	u8 fan_am_ctrl[3];	/* Register value */
 };
 
 
@@ -486,13 +497,52 @@
 }
 static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
 {
+	int val;
+	
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
+	
+	/* PWM enabled or disabled */
+	val = (data->fan_main_ctrl & (1 << nr)) ? 1 : 0;
+	/* Automatic mode - SmartGuardian */
+	val += (val && (data->manual_pwm_ctl[nr] & 0x80)) ? 1 : 0;
+	
+	return sprintf(buf,"%d\n", val);
 }
 static ssize_t show_pwm(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
+	/* Return 0 if automatic mode is enabled */
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
+	return sprintf(buf,"%d\n", data->fan_am_ctrl[nr] & 0x07);
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
@@ -564,12 +614,28 @@
 		/* set on/off mode */
 		data->fan_main_ctrl &= ~(1 << nr);
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
-	} else if (val = 1) {
+	} else if ((val = 1) || (val = 2)) {
 		/* set SmartGuardian mode */
 		data->fan_main_ctrl |= (1 << nr);
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
-		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
-		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+		if (val = 2) {
+			/* Set automatic SmartGuardian mode */
+			data->manual_pwm_ctl[nr] |= 0x80;
+			it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+			/* Enable temperature smoothing and fan spin up  time */
+			data->fan_am_ctrl[nr] = 0x80 | 0x18;
+			it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+			/* If start pwm and pwm step size not set, apply safe values */
+			if (data->fan_limit_stpwm[nr] = 0) {
+				data->fan_limit_stpwm[nr] = PWM_TO_REG(128);
+				it87_write_value(client, IT87_REG_SG_START_PWM(nr), data->fan_limit_stpwm[nr]);
+			}
+			if ((data->fan_am_ctrl[nr] & 0x07) = 0) {
+				/* 16 PWM values / K */
+				data->fan_am_ctrl[nr] |= 0x05;
+				it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+			}
+		}
 	} else {
 		up(&data->update_lock);
 		return -EINVAL;
@@ -595,6 +661,93 @@
 	up(&data->update_lock);
 	return count;
 }
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
+
+	return count;
+}
 
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
@@ -639,6 +792,30 @@
 {									\
 	return show_pwm(dev, buf, offset - 1);				\
 }									\
+static ssize_t show_pwm##offset##_limit_off (struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	return show_pwm_limit_off(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_limit_start (struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	return show_pwm_limit_start(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_limit_full (struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	return show_pwm_limit_full(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_start (struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	return show_pwm_start(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_temp_input (struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	return show_pwm_temp_input(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_pwm##offset##_step (struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	return show_pwm_step(dev, buf, offset - 1);				\
+}									\
 static ssize_t set_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
 		const char *buf, size_t count)				\
 {									\
@@ -649,11 +826,55 @@
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
+static ssize_t set_pwm##offset##_limit_off (struct device *dev, struct device_attribute *attr,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_limit_off(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_limit_start (struct device *dev, struct device_attribute *attr,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_limit_start(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_limit_full (struct device *dev, struct device_attribute *attr,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_limit_full(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_start (struct device *dev, struct device_attribute *attr,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_start(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_temp_input (struct device *dev, struct device_attribute *attr,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_temp_input(dev, buf, count, offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_step (struct device *dev, struct device_attribute *attr,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_step(dev, buf, count, offset - 1);			\
+}									\
 static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
 		show_pwm##offset##_enable,				\
 		set_pwm##offset##_enable);				\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
-		show_pwm##offset , set_pwm##offset );
+		show_pwm##offset , set_pwm##offset );			\
+static DEVICE_ATTR(pwm##offset##_limit_off, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_limit_off , set_pwm##offset##_limit_off );	\
+static DEVICE_ATTR(pwm##offset##_limit_start, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_limit_start , set_pwm##offset##_limit_start );	\
+static DEVICE_ATTR(pwm##offset##_limit_full, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_limit_full , set_pwm##offset##_limit_full );		\
+static DEVICE_ATTR(pwm##offset##_start, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_start , set_pwm##offset##_start );	\
+static DEVICE_ATTR(pwm##offset##_temp_input, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_temp_input , set_pwm##offset##_temp_input );		\
+static DEVICE_ATTR(pwm##offset##_step, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_step , set_pwm##offset##_step );
+
+
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -915,6 +1136,24 @@
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
@@ -1045,17 +1284,6 @@
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
@@ -1080,24 +1308,20 @@
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
+		data->manual_pwm_ctl[i] = it87_read_value(client, IT87_REG_PWM(i));
  	}
-
+	
+	/* Get fan control registers for SmartGuardian automatic mode */
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
