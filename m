From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [Patch 2.6] it87 part3(pwm)
Message-Id: <20040313143512.571098a9.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
Sorry for long silence but I want to go on adding some features
to it87 for 2.6.

Here's a patch to add pwm[1-3] and pwm_enable[1-3].
pwm[1-3] are bit different from the ones for 2.4.

Documentation/i2c/sysfs-interface says that the values for
pwm[1-3] should be 0-255 while it87 documentation for 2.4 says:
   Bit 7 of the pwm[1-3] registers enables/disables the chips 
   automatic temperature control mode for the specified fan.

I am not sure but I feel it's better to prepare another sysfs
entry(e.g. sg_enable) for "automatic temperature control mode".
pwm[1-3] accepts 0-255 with this trial patch. 

BTW, I have not subscribed to this list.
Would you add me to the list?

Thanks in advance.

--- linux-2.6.4/drivers/i2c/chips/it87.c.reset	2004-03-13 13:53:00.000000000 +0900
+++ linux-2.6.4/drivers/i2c/chips/it87.c	2004-03-13 13:57:29.589448414 +0900
@@ -85,6 +85,7 @@
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_CTRL      0x13
+#define IT87_REG_PWM(nr)       (0x15 + (nr))
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -115,6 +116,10 @@
 
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
 
+#define PWM_TO_REG(val) ((val)<0?0:(val)>255?127:((val)/2))
+
+#define PWM_FROM_REG(val) (((val)&0x7f)*2)
+
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
 					((val)+5)/10),0,255))
 #define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
@@ -150,6 +155,8 @@
 	u8 in_min[9];		/* Register value */
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
+	u8 pwm[3];		/* Register value */
+	u8 fan_ctrl;		/* Register encoding */
 	u8 temp[3];		/* Register value */
 	u8 temp_high[3];	/* Register value */
 	u8 temp_low[3];		/* Register value */
@@ -429,6 +436,22 @@
 	it87_update_client(client);
 	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
+static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm[nr]));
+}
+static ssize_t show_pwm_enable (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	if (data->fan_ctrl & (1 << nr))
+	    return sprintf(buf, "1\n");
+	return sprintf(buf, "0\n");
+}
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
 {
@@ -475,6 +498,34 @@
 	}
 	return count;
 }
+static ssize_t set_pwm(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	if (val < 0 || val > 255)
+	    return -1;
+	data->pwm[nr] = PWM_TO_REG(val);
+	it87_write_value(client, IT87_REG_PWM(nr), data->pwm[nr]);
+	return count;
+}
+static ssize_t set_pwm_enable (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	data->fan_ctrl &= ~(1 << nr);
+	if (val = 1)
+	    data->fan_ctrl |= 1 << nr;
+	else if (val != 0)
+	    return -1;
+	data->fan_ctrl |= 0x70;
+	it87_write_value(client, IT87_REG_FAN_CTRL, data->fan_ctrl);
+	return count;
+}
 
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
@@ -489,6 +540,15 @@
 {									\
 	return show_fan_div(dev, buf, 0x##offset - 1);			\
 }									\
+static ssize_t show_fan_##offset##_pwm (struct device *dev, char *buf)	\
+{									\
+	return show_pwm(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_pwm_##offset##_enable (struct device *dev		\
+					   , char *buf)			\
+{									\
+	return show_pwm_enable(dev, buf, 0x##offset - 1);		\
+}									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
@@ -499,11 +559,25 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
+static ssize_t set_fan_##offset##_pwm (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_pwm_##offset##_enable (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_pwm_enable(dev, buf, count, 0x##offset - 1);		\
+}									\
 static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
 static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
 		show_fan_##offset##_min, set_fan_##offset##_min) 	\
 static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
-		show_fan_##offset##_div, set_fan_##offset##_div)
+		show_fan_##offset##_div, set_fan_##offset##_div)        \
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_pwm, set_fan_##offset##_pwm)	\
+static DEVICE_ATTR(pwm_enable##offset, S_IRUGO | S_IWUSR, 		\
+		show_pwm_##offset##_enable, set_pwm_##offset##_enable)
 
 show_fan_offset(1);
 show_fan_offset(2);
@@ -697,6 +771,12 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
 	device_create_file(&new_client->dev, &dev_attr_fan_div3);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
+	device_create_file(&new_client->dev, &dev_attr_pwm2);
+	device_create_file(&new_client->dev, &dev_attr_pwm3);
+	device_create_file(&new_client->dev, &dev_attr_pwm_enable1);
+	device_create_file(&new_client->dev, &dev_attr_pwm_enable2);
+	device_create_file(&new_client->dev, &dev_attr_pwm_enable3);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
@@ -871,6 +951,11 @@
 		data->fan_div[1] = (i >> 3) & 0x07;
 		data->fan_div[2] = (i & 0x40) ? 3 : 1;
 
+		for(i = 0; i < 3; i++) {
+			data->pwm[i] = it87_read_value(client, IT87_REG_PWM(i));
+		}
+		data->fan_ctrl = it87_read_value(client, IT87_REG_FAN_CTRL);
+
 		data->alarms  			it87_read_value(client, IT87_REG_ALARM1) |
 			(it87_read_value(client, IT87_REG_ALARM2) << 8) |

-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
