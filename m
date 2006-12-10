From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 10 Dec 2006 11:00:48 +0000
Subject: [lm-sensors] [PATCH] it87: Add PWM base frequency control
Message-Id: <20061210120048.d3a6e2b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let the user select the base PWM frequency when using the it87
hardware monitoring driver. Different frequencies can give better
control on some fans.

Also update the documentation to mention the PWM frequency control
files, with misc cleanups to the PWM section.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/it87            |   10 ++++++
 Documentation/hwmon/sysfs-interface |   15 ++++++---
 drivers/hwmon/it87.c                |   56 ++++++++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 7 deletions(-)

--- linux-2.6.19-git.orig/drivers/hwmon/it87.c	2006-12-09 16:58:57.000000000 +0100
+++ linux-2.6.19-git/drivers/hwmon/it87.c	2006-12-10 11:11:56.000000000 +0100
@@ -202,6 +202,17 @@
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
+static const unsigned int pwm_freq[8] = {
+	48000000 / 128,
+	24000000 / 128,
+	12000000 / 128,
+	8000000 / 128,
+	6000000 / 128,
+	3000000 / 128,
+	1500000 / 128,
+	750000 / 128,
+};
+
 
 /* For each registered IT87, we need to keep some data in memory. That
    data is pointed to by it87_list[NR]->data. The structure itself is
@@ -232,6 +243,7 @@
 	u8 vrm;
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
+	u8 fan_ctl;		/* Register value */
 	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
 };
 
@@ -519,6 +531,14 @@
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
 }
+static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct it87_data *data = it87_update_device(dev);
+	int index = (data->fan_ctl >> 4) & 0x07;
+
+	return sprintf(buf, "%u\n", pwm_freq[index]);
+}
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
@@ -639,6 +659,28 @@
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+static ssize_t set_pwm_freq(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	int i;
+
+	/* Search for the nearest available frequency */
+	for (i = 0; i < 7; i++) {
+		if (val > (pwm_freq[i] + pwm_freq[i+1]) / 2)
+			break;
+	}
+
+	mutex_lock(&data->update_lock);
+	data->fan_ctl = it87_read_value(client, IT87_REG_FAN_CTL) & 0x8f;
+	data->fan_ctl |= i << 4;
+	it87_write_value(client, IT87_REG_FAN_CTL, data->fan_ctl);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
 
 #define show_fan_offset(offset)					\
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
@@ -656,7 +698,10 @@
 static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
 		show_pwm_enable, set_pwm_enable, offset - 1);		\
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
-		show_pwm, set_pwm, offset - 1);
+		show_pwm, set_pwm, offset - 1);				\
+static DEVICE_ATTR(pwm##offset##_freq,					\
+		(offset = 1 ? S_IRUGO | S_IWUSR : S_IRUGO),		\
+		show_pwm_freq, (offset = 1 ? set_pwm_freq : NULL));
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -1021,7 +1066,13 @@
 		 || (err = device_create_file(&new_client->dev,
 		     &sensor_dev_attr_pwm2.dev_attr))
 		 || (err = device_create_file(&new_client->dev,
-		     &sensor_dev_attr_pwm3.dev_attr)))
+		     &sensor_dev_attr_pwm3.dev_attr))
+		 || (err = device_create_file(&new_client->dev,
+		     &dev_attr_pwm1_freq))
+		 || (err = device_create_file(&new_client->dev,
+		     &dev_attr_pwm2_freq))
+		 || (err = device_create_file(&new_client->dev,
+		     &dev_attr_pwm3_freq)))
 			goto ERROR4;
 	}
 
@@ -1316,6 +1367,7 @@
 			(it87_read_value(client, IT87_REG_ALARM2) << 8) |
 			(it87_read_value(client, IT87_REG_ALARM3) << 16);
 		data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
+		data->fan_ctl = it87_read_value(client, IT87_REG_FAN_CTL);
 
 		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 		/* The 8705 does not have VID capability */
--- linux-2.6.19-git.orig/Documentation/hwmon/it87	2006-12-09 16:58:57.000000000 +0100
+++ linux-2.6.19-git/Documentation/hwmon/it87	2006-12-10 11:15:43.000000000 +0100
@@ -135,6 +135,16 @@
 startup, consult lm_sensors's /etc/sensors.conf. (2 = thermistor;
 3 = thermal diode)
 
+
+Fan speed control
+-----------------
+
 The fan speed control features are limited to manual PWM mode. Automatic
 "Smart Guardian" mode control handling is not implemented. However
 if you want to go for "manual mode" just write 1 to pwmN_enable.
+
+If you are only able to control the fan speed with very small PWM values,
+try lowering the PWM base frequency (pwm1_freq). Depending on the fan,
+it may give you a somewhat greater control range. The same frequency is
+used to drive all fan outputs, which is why pwm2_freq and pwm3_freq are
+read-only.
--- linux-2.6.19-git.orig/Documentation/hwmon/sysfs-interface	2006-12-09 16:58:57.000000000 +0100
+++ linux-2.6.19-git/Documentation/hwmon/sysfs-interface	2006-12-10 11:43:51.000000000 +0100
@@ -166,16 +166,21 @@
 
 pwm[1-*]_enable
 		Switch PWM on and off.
-		Not always present even if fan*_pwm is.
+		Not always present even if pwmN is.
 		0: turn off
 		1: turn on in manual mode
 		2+: turn on in automatic mode
-		Check individual chip documentation files for automatic mode details.
+		Check individual chip documentation files for automatic mode
+		details.
 		RW
 
-pwm[1-*]_mode
-		0: DC mode
-		1: PWM mode
+pwm[1-*]_mode	0: DC mode (direct current)
+		1: PWM mode (pulse-width modulation)
+		RW
+
+pwm[1-*]_freq	Base PWM frequency in Hz.
+		Only possibly available when pwmN_mode is PWM, but not always
+		present even then.
 		RW
 
 pwm[1-*]_auto_channels_temp


-- 
Jean Delvare

