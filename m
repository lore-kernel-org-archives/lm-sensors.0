From: se.witt@gmx.net (Sebastian Witt)
Date: Tue, 14 Jun 2005 22:33:47 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <42AF5B1C.7030805@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

> It was against Greg's current i2c tree as I wrote it. The easier for you
> would be to start from 2.6.12-rc6 + this patch:
> 
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.12-rc6-i2c.patch.gz
> 
> Or the latest -mm, at your option (but be aware that
> linux-2.6.12-rc6-mm1 has a few known issues WRT hardware monitoring.)
> 
> Both include the all the latest it87 patches.
> 

Ok, here's a patch against 2.6.12-rc6.

>>it87: Found IT8705F chip at 0x290, revision 3
> 
> Hey, lucky you. I'd like to have this one, but unfortunately mine is
> revision 2 only. So, yours implements the newer auto-pwm model, while
> mine implements the old one. You might even get VID readings if your
> chip was wired for this.

I've now added only support for the auto-pwm with slope setting and a check for 
revision 3.

Bye,
Sebastian



-------------- next part --------------
--- linux-2.6.12-rc6_orig/drivers/i2c/chips/it87.c	2005-06-15 00:12:22.000000000 +0200
+++ linux-2.6.12-rc6/drivers/i2c/chips/it87.c	2005-06-15 00:20:58.000000000 +0200
@@ -111,6 +111,7 @@
 /* Chip Type */
 
 static u16 chip_type;
+static u8  chip_revision;
 
 /* Many IT87 constants specified below */
 
@@ -155,6 +156,12 @@
 
 #define IT87_REG_CHIPID        0x58
 
+#define IT87_REG_SG_TEMP_OFF(nr) 	(0x60 + (nr) * 8)
+#define IT87_REG_SG_TEMP_START(nr)	(0x61 + (nr) * 8)
+#define IT87_REG_SG_TEMP_FULL(nr)	(0x62 + (nr) * 8)
+#define IT87_REG_SG_START_PWM(nr)	(0x63 + (nr) * 8)
+#define IT87_REG_SG_AM_CTRL(nr)		(0x64 + (nr) * 8)
+
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
 #define IN_FROM_REG(val) ((val) * 16)
 
@@ -185,6 +192,7 @@
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
+#define SLOPE_FROM_REG(val) ((val) ? (1 << (val-1)) : 0)
 
 /* For each registered IT87, we need to keep some data in memory. That
    data is pointed to by it87_list[NR]->data. The structure itself is
@@ -214,6 +222,12 @@
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
+	u8 fan_limit_off[3];	/* Register value */
+	u8 fan_limit_start[3];	/* Register value */
+	u8 fan_limit_full[3];	/* Register value */
+	u8 fan_limit_stpwm[3];	/* Register value */
+	u8 fan_am_ctrl[3];	/* Register value */
+	u8 fan_point2_pwm[3];	/* Used for slope calculation */
 };
 
 
@@ -454,6 +468,31 @@
 show_sensor_offset(2);
 show_sensor_offset(3);
 
+static void calc_slope(struct it87_data *data, int nr)
+{
+	u8 val = data->fan_point2_pwm[nr];
+	
+	if (data->fan_limit_full[nr] <= data->fan_limit_start[nr])
+		val = 14;
+	else {
+		val -= data->fan_limit_stpwm[nr];
+		val /= (data->fan_limit_full[nr] - data->fan_limit_start[nr]);
+	}
+	
+	data->fan_am_ctrl[nr] &= ~0x03;
+	if (val > 48)
+		data->fan_am_ctrl[nr] |= 0x07;	/* 64 PWM / K */
+	else if (val > 24)
+		data->fan_am_ctrl[nr] |= 0x06;	/* 32 PWM / K */
+	else if (val > 12)
+		data->fan_am_ctrl[nr] |= 0x05;	/* 16 PWM / K */
+	else if (val > 6)
+		data->fan_am_ctrl[nr] |= 0x04;	/*  8 PWM / K */
+	else if (val > 3)
+		data->fan_am_ctrl[nr] |= 0x03;	/*  4 PWM / K */
+	else
+		data->fan_am_ctrl[nr] |= 0x02;	/*  2 PWM / K */
+}
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -489,9 +528,15 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
+	int val;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
+	/* PWM enabled or disabled */
+	val = (data->fan_main_ctrl & (1 << nr)) ? 1 : 0;
+	/* Automatic mode - SmartGuardian */
+	val += (val && (data->manual_pwm_ctl[nr] & 0x80)) ? 1 : 0;
+	
+	return sprintf(buf,"%d\n", val);
 }
 static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -500,7 +545,64 @@
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
+	/* Return 0 if automatic mode is enabled */
+	return sprintf(buf,"%d\n", (data->manual_pwm_ctl[nr] & 0x80) ? 0 : PWM_FROM_REG(data->manual_pwm_ctl[nr]));
+}
+static ssize_t show_pwm_auto_channels_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+
+	return sprintf(buf,"%d\n", (data->manual_pwm_ctl[nr] & 0x80) ? 
+				   (1 << (data->manual_pwm_ctl[nr] & 0x03)): 0);
+}
+static ssize_t show_pwm_auto_point1_pwm(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->fan_limit_stpwm[nr]));
+}
+static ssize_t show_pwm_auto_point1_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_limit_start[nr]);
+}
+static ssize_t show_pwm_auto_point1_temp_hyst(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_limit_off[nr]);
+}
+static ssize_t show_pwm_auto_point2_pwm(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_point2_pwm[nr]);
+}
+static ssize_t show_pwm_auto_point2_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_limit_full[nr]);
 }
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -581,12 +683,33 @@
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
+		if ((val = 2) && (chip_revision = 0x03)) {
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
+		else {
+			/* Disable automatic SmartGuardian mode */
+			data->manual_pwm_ctl[nr] &= ~0x80;
+			it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+		}
 	} else {
 		up(&data->update_lock);
 		return -EINVAL;
@@ -615,7 +738,123 @@
 	up(&data->update_lock);
 	return count;
 }
+static ssize_t set_pwm_auto_point1_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	down(&data->update_lock);
+	data->fan_limit_stpwm[nr] = PWM_TO_REG(val);
+	calc_slope(data, nr);
+	it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+	it87_write_value(client, IT87_REG_SG_START_PWM(nr), data->fan_limit_stpwm[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_pwm_auto_point1_temp(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	
+	down(&data->update_lock);
+	data->fan_limit_start[nr] = val;
+	calc_slope(data, nr);
+	it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+	it87_write_value(client, IT87_REG_SG_TEMP_START(nr), data->fan_limit_start[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_pwm_auto_point1_temp_hyst(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->fan_limit_off[nr] = val;
+	it87_write_value(client, IT87_REG_SG_TEMP_OFF(nr), data->fan_limit_off[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_pwm_auto_point2_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	down(&data->update_lock);
+	data->fan_point2_pwm[nr] = val;
+	calc_slope(data, nr);
+	it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_pwm_auto_point2_temp(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	
+	down(&data->update_lock);
+	data->fan_limit_full[nr] = val;
+	calc_slope(data, nr);
+	it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
+	it87_write_value(client, IT87_REG_SG_TEMP_FULL(nr), data->fan_limit_full[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_pwm_auto_channels_temp(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 4)
+		return -EINVAL;
+
+	/* Check if automatic control is enabled */
+	if (data->manual_pwm_ctl[nr] & 0x80) {
+		down(&data->update_lock);
+		data->manual_pwm_ctl[nr] = 0x80 | (val >> 1);
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+		up(&data->update_lock);
+	}
+
+	return count;
+}
+	
 #define show_fan_offset(offset)					\
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
 		show_fan, NULL, offset - 1);			\
@@ -632,7 +871,19 @@
 static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
 		show_pwm_enable, set_pwm_enable, offset - 1);		\
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
-		show_pwm, set_pwm, offset - 1);
+		show_pwm, set_pwm, offset - 1);				\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_channels_temp, S_IRUGO | S_IWUSR,		\
+		show_pwm_auto_channels_temp, set_pwm_auto_channels_temp, offset - 1);	\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_point1_pwm, S_IRUGO | S_IWUSR,		\
+		show_pwm_auto_point1_pwm, set_pwm_auto_point1_pwm, offset - 1);	\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_point1_temp, S_IRUGO | S_IWUSR,		\
+		show_pwm_auto_point1_temp, set_pwm_auto_point1_temp, offset - 1);	\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,	\
+		show_pwm_auto_point1_temp_hyst, set_pwm_auto_point1_temp_hyst, offset - 1);\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_point2_pwm, S_IRUGO | S_IWUSR,		\
+		show_pwm_auto_point2_pwm, set_pwm_auto_point2_pwm, offset - 1);		\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_point2_temp, S_IRUGO | S_IWUSR,		\
+		show_pwm_auto_point2_temp, set_pwm_auto_point2_temp, offset - 1);
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -713,8 +964,9 @@
 	}
 
 	err = 0;
+	chip_revision = superio_inb(DEVREV) & 0x0f;
 	pr_info("it87: Found IT%04xF chip at 0x%x, revision %d\n",
-		chip_type, *address, superio_inb(DEVREV) & 0x0f);
+		chip_type, *address, chip_revision);
 
 exit:
 	superio_exit();
@@ -894,6 +1146,27 @@
 		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
 		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
 		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
+		/* Enable automatic SmartGuardian mode */
+		if (chip_revision = 0x03) {
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_auto_channels_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_auto_channels_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_auto_channels_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_auto_point1_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_auto_point1_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_auto_point1_temp_hyst.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_auto_point1_temp_hyst.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_auto_point1_temp_hyst.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_auto_point2_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_auto_point2_temp.dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_auto_point2_temp.dev_attr);
+		}
 	}
 
 	if (data->type = it8712) {
@@ -1024,17 +1297,6 @@
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
@@ -1059,6 +1321,18 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 
+	/* Set current fan mode registers */
+	for (i = 0; i < 3; i++) {
+		data->manual_pwm_ctl[i] = it87_read_value(client, IT87_REG_PWM(i));
+	
+		/* Get fan control registers for SmartGuardian automatic mode */
+		data->fan_limit_off[i] = it87_read_value(client, IT87_REG_SG_TEMP_OFF(i));
+		data->fan_limit_start[i] = it87_read_value(client, IT87_REG_SG_TEMP_START(i));
+		data->fan_limit_full[i] = it87_read_value(client, IT87_REG_SG_TEMP_FULL(i));
+		data->fan_limit_stpwm[i] = it87_read_value(client, IT87_REG_SG_START_PWM(i));
+		data->fan_am_ctrl[i] = it87_read_value(client, IT87_REG_SG_AM_CTRL(i));
+	}
+	
 	/* Set current fan mode registers and the default settings for the
 	 * other mode registers */
 	for (i = 0; i < 3; i++) {
