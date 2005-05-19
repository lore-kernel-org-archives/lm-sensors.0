From: jmunsin@iki.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: it87 manual pwm patch form 2.6.7/8
Message-Id: <20040714144826.GA9936@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here is a patch adding manual pwm support to the it87 driver. I hope I
have addressed all the comments you gave to my initial version (btw,
thanks for taking the time to make them, they were helpful).

In addition to manual pwm, this patch contains some whitespace cleanups.
It also removes the "reset" module option, which IMO is just broken to
have there. Currently we lose a lot of BIOS suppleid settings when it is
used, rendering the chip useless (unless the requiered settings just
happen to match the chip defauls).  For a working reset, we should
really save and reload every register.  If someone wants to reset it,
use i2ctools.

The patch is against 2.6.7 with the cleanup patch I submitted earlier
applied (according to the kernel changelog this should be identical to
the version in 2.6.8-rc1, but I haven't verified that).

The autopwm patch will hopefully follow once this patch is approved
(the autopwm part is not quite in a submittable state yet).



--- drivers/i2c/chips/it87.c.2.6.7_gregkh_i2c_pending_applied	2004-07-02 21:48:37.000000000 +0300
+++ drivers/i2c/chips/it87.c	2004-07-14 17:24:27.000000000 +0300
@@ -101,9 +101,6 @@
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
-/* Reset the registers on init if true */
-static int reset;
-
 /* Many IT87 constants specified below */
 
 /* Length of ISA address segment */
@@ -129,6 +126,8 @@
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_MAIN_CTRL 0x13
+#define IT87_REG_FAN_CTL       0x14
+#define IT87_REG_PWM(nr)       (0x15 + (nr))
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -167,6 +166,9 @@
 				205-(val)*5)
 #define ALARMS_FROM_REG(val) (val)
 
+#define PWM_TO_REG(val)   ((val) >> 1)
+#define PWM_FROM_REG(val) (((val)&0x7f) << 1)
+
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
@@ -202,6 +204,9 @@
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
+
+	u8 fan_main_ctrl;	/* Register value */
+	u8 manual_pwm_ctl[3];   /* Register encoding */
 };
 
 
@@ -442,19 +447,30 @@
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
-				DIV_FROM_REG(data->fan_div[nr])) );
+				DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+static ssize_t show_fan_pwm_enable(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
 }
+static ssize_t show_fan_pwm(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->manual_pwm_ctl[nr]));
+}
+
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
 {
@@ -501,6 +517,48 @@
 	}
 	return count;
 }
+static ssize_t set_fan_pwm_enable(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int tmp;
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val = 0) {
+		data->fan_main_ctrl &= ~(1 << nr);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		/* make sure the fan is on */
+		tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+		if ((tmp & (1 << nr)) = 0)
+			it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr));
+	} else if (val = 1) {
+		/* set SmartGuardian mode */
+		data->fan_main_ctrl |= (1 << nr);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		/* set saved pwm value and FAN_CTLX PWM mode bit */
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr] & 0x7f);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+static ssize_t set_fan_pwm(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	data->manual_pwm_ctl[nr] = PWM_TO_REG(val);
+	if (data->fan_main_ctrl & (1 << nr))
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+
+	return count;
+}
 
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
@@ -515,6 +573,15 @@
 {									\
 	return show_fan_div(dev, buf, 0x##offset - 1);			\
 }									\
+static ssize_t show_fan_##offset##_pwm_enable (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_pwm_enable(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan_##offset##_pwm (struct device *dev, char *buf)	\
+{									\
+	return show_fan_pwm(dev, buf, 0x##offset - 1);			\
+}									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
@@ -525,11 +592,27 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
+static ssize_t set_fan_##offset##_pwm_enable (struct device *dev,	\
+		const char *buf, size_t count)				\
+{									\
+	return set_fan_pwm_enable(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_pwm (struct device *dev,		\
+		const char *buf, size_t count)				\
+{									\
+	return set_fan_pwm(dev, buf, count, 0x##offset - 1);		\
+}									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min) 	\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div)
+		show_fan_##offset##_div, set_fan_##offset##_div)	\
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_pwm_enable,				\
+		set_fan_##offset##_pwm_enable)				\
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_pwm, set_fan_##offset##_pwm)
+
 
 show_fan_offset(1);
 show_fan_offset(2);
@@ -739,6 +822,12 @@
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan3_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan3_pwm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
@@ -811,12 +900,11 @@
 /* Called when we have found a new IT87. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
-	int tmp;
+	int tmp, i;
 
-	if (reset) {
-		/* Reset all except Watchdog values and last conversion values
-		   This sets fan-divs to 2, among others */
-		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	/* initialize to sane defaults */
+	for (i = 0; i < 3; i++) {
+		data->manual_pwm_ctl[i] = 0x7f;
 	}
 
 	/* Check if temperature channnels are reset manually or by some reason */
@@ -836,11 +924,32 @@
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
-	if ((tmp & 0x70) = 0) {
+	data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
+	if ((data->fan_main_ctrl & 0x70) = 0) {
 		/* Enable all fan tachometers */
-		tmp = (tmp & 0x8f) | 0x70;
-		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, tmp);
+		data->fan_main_ctrl |= 0x70;
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+	}
+	/* Set current fan mode registers and the default settings for the other mode registers */
+	for (i = 0; i < 3; i++) {
+		if (data->fan_main_ctrl & (1 << i)) {
+			/* pwm mode */
+			tmp = it87_read_value(client, IT87_REG_PWM(i));
+			if (tmp & 0x80) {
+				/* automatic pwm - not yet implemented, but
+				 * leave the settings made by the BIOS alone
+				 * until a change is requested via the sysfs
+				 * interface */
+			} else {
+				/* manual pwm */
+				data->manual_pwm_ctl[i] = tmp & 0x7f;
+			}
+		} else {
+			/* on/off mode, make sure the fan is on */
+			tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+			if ((tmp & (1 << i)) = 0)
+				it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << i));
+		}
 	}
 
 	/* Start monitoring */
@@ -940,8 +1049,6 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-MODULE_PARM(reset, "i");
-MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);
