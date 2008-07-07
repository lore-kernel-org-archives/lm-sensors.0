From: Andrew Paprocki <andrew@ishiboo.com>
Date: Mon, 07 Jul 2008 10:40:10 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: it87 sysfs PWM interface for fan4-5
Message-Id: <1215427211-6001-3-git-send-email-andrew@ishiboo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

PWM interface files are now created for fan4-5 on all chips except
the IT8705F if the chip indicates fan4-5 are enabled. Fans 4 and 5
do not allow selection between "ON/OFF" mode and SmartGuardian;
SmartGuardian is the only mode. FAN_CTL4-5 are identicial in
operation to FAN_CTL1-3, so the IT87_REG_PWM() macro is now the
IT87_REG_FAN_PWM[5] array.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
---
 Documentation/hwmon/it87 |    6 +++-
 drivers/hwmon/it87.c     |   89 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 3496b70..77196bf 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -146,6 +146,10 @@ startup, consult lm_sensors's /etc/sensors.conf. (2 = thermistor;
 Fan speed control
 -----------------
 
+The fan speed control sysfs interface will only be exposed if a working
+BIOS is detected. The PWM files will only be created for each individual
+fan which is enabled.
+
 The fan speed control features are limited to manual PWM mode. Automatic
 "Smart Guardian" mode control handling is not implemented. However
 if you want to go for "manual mode" just write 1 to pwmN_enable.
@@ -153,5 +157,5 @@ if you want to go for "manual mode" just write 1 to pwmN_enable.
 If you are only able to control the fan speed with very small PWM values,
 try lowering the PWM base frequency (pwm1_freq). Depending on the fan,
 it may give you a somewhat greater control range. The same frequency is
-used to drive all fan outputs, which is why pwm2_freq and pwm3_freq are
+used to drive all fan outputs, which is why all other pwmN_freq files are
 read-only.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 7de4af8..b7b9b58 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -165,7 +165,7 @@ static const u8 IT87_REG_FANX[]		= { 0x18, 0x19, 0x1a, 0x81, 0x83 };
 static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
 #define IT87_REG_FAN_MAIN_CTRL 0x13
 #define IT87_REG_FAN_CTL       0x14
-#define IT87_REG_PWM(nr)       (0x15 + (nr))
+static const u8 IT87_REG_FAN_PWM[]	= { 0x15, 0x16, 0x17, 0x88, 0x89 };
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -267,7 +267,7 @@ struct it87_data {
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 fan_ctl;		/* Register value */
-	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
+	u8 manual_pwm_ctl[5];   /* manual PWM value set by user */
 };
 
 static inline int has_16bit_fans(const struct it87_data *data)
@@ -281,6 +281,14 @@ static inline int has_16bit_fans(const struct it87_data *data)
 	    || data->type = it8718;
 }
 
+static inline int num_fans(const struct it87_data *data)
+{
+	if (data->type = it87)
+		return 3;
+	else
+		return 5;
+}
+
 static int it87_probe(struct platform_device *pdev);
 static int __devexit it87_remove(struct platform_device *pdev);
 
@@ -547,6 +555,11 @@ static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
+
+	/* Fans 4 and 5 are always PWM enabled if the chip supports them */
+	if (nr > 2)
+		return sprintf(buf, "%d\n", 1);
+
 	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
 }
 static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
@@ -655,7 +668,8 @@ static ssize_t set_pwm_enable(struct device *dev,
 		data->fan_main_ctrl |= (1 << nr);
 		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
-		it87_write_value(data, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+		it87_write_value(data, IT87_REG_FAN_PWM[nr],
+				 PWM_TO_REG(data->manual_pwm_ctl[nr]));
 	} else {
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -678,8 +692,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->manual_pwm_ctl[nr] = val;
-	if (data->fan_main_ctrl & (1 << nr))
-		it87_write_value(data, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+	/* Fans 4 and 5 are always PWM enabled if the chip supports them */
+	if (nr > 2 || data->fan_main_ctrl & (1 << nr))
+		it87_write_value(data, IT87_REG_FAN_PWM[nr],
+				 PWM_TO_REG(data->manual_pwm_ctl[nr]));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -730,6 +746,17 @@ show_pwm_offset(1);
 show_pwm_offset(2);
 show_pwm_offset(3);
 
+#define show_pwm45_offset(offset)					\
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO,		\
+		show_pwm_enable, NULL, offset - 1);			\
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
+		show_pwm, set_pwm, offset - 1);				\
+static DEVICE_ATTR(pwm##offset##_freq, S_IRUGO,				\
+		show_pwm_freq, NULL);
+
+show_pwm45_offset(4);
+show_pwm45_offset(5);
+
 /* A different set of callbacks for 16-bit fans */
 static ssize_t show_fan16(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -942,12 +969,18 @@ static struct attribute *it87_attributes_opt[] = {
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm5_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm5.dev_attr.attr,
 	&dev_attr_pwm1_freq.attr,
 	&dev_attr_pwm2_freq.attr,
 	&dev_attr_pwm3_freq.attr,
+	&dev_attr_pwm4_freq.attr,
+	&dev_attr_pwm5_freq.attr,
 
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
@@ -1195,6 +1228,24 @@ static int __devinit it87_probe(struct platform_device *pdev)
 			     &dev_attr_pwm3_freq)))
 				goto ERROR4;
 		}
+		if (data->has_fan & (1 << 3)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm4_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm4.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm4_freq)))
+				goto ERROR4;
+		}
+		if (data->has_fan & (1 << 4)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm5_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm5.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm5_freq)))
+				goto ERROR4;
+		}
 	}
 
 	if (data->type = it8712 || data->type = it8716
@@ -1276,24 +1327,26 @@ static int __devinit it87_check_pwm(struct device *dev)
 			 * This means switching to active high polarity and
 			 * inverting all fan speed values. */
 			int i;
-			u8 pwm[3];
+			u8 pwm[5], pwm_or = 0;
 
-			for (i = 0; i < 3; i++)
+			for (i = 0; i < num_fans(data); i++) {
 				pwm[i] = it87_read_value(data,
-							 IT87_REG_PWM(i));
+							 IT87_REG_FAN_PWM[i]);
+				pwm_or |= pwm[i];
+			}
 
 			/* If any fan is in automatic pwm mode, the polarity
 			 * might be correct, as suspicious as it seems, so we
 			 * better don't change anything (but still disable the
 			 * PWM interface). */
-			if (!((pwm[0] | pwm[1] | pwm[2]) & 0x80)) {
+			if (!(pwm_or & 0x80)) {
 				dev_info(dev, "Reconfiguring PWM to "
 					 "active high polarity\n");
 				it87_write_value(data, IT87_REG_FAN_CTL,
 						 tmp | 0x87);
-				for (i = 0; i < 3; i++)
+				for (i = 0; i < num_fans(data); i++)
 					it87_write_value(data,
-							 IT87_REG_PWM(i),
+							 IT87_REG_FAN_PWM[i],
 							 0x7f & ~pwm[i]);
 				return 1;
 			}
@@ -1380,8 +1433,7 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
-		/* IT8705F only supports three fans. */
-		if (data->type != it87) {
+		if (num_fans(data) = 5) {
 			if (tmp & (1 << 4))
 				data->has_fan |= (1 << 3); /* fan4 enabled */
 			if (tmp & (1 << 5))
@@ -1391,10 +1443,11 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 
 	/* Set current fan mode registers and the default settings for the
 	 * other mode registers */
-	for (i = 0; i < 3; i++) {
-		if (data->fan_main_ctrl & (1 << i)) {
+	for (i = 0; i < num_fans(data); i++) {
+		/* Fans 4 and 5 are always PWM enabled */
+		if (i > 2 || data->fan_main_ctrl & (1 << i)) {
 			/* pwm mode */
-			tmp = it87_read_value(data, IT87_REG_PWM(i));
+			tmp = it87_read_value(data, IT87_REG_FAN_PWM[i]);
 			if (tmp & 0x80) {
 				/* automatic pwm - not yet implemented, but
 				 * leave the settings made by the BIOS alone
@@ -1405,7 +1458,7 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 				data->manual_pwm_ctl[i] = PWM_FROM_REG(tmp);
 			}
 		}
- 	}
+	}
 
 	/* Start monitoring */
 	it87_write_value(data, IT87_REG_CONFIG,
@@ -1441,7 +1494,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 		data->in[8]  		    it87_read_value(data, IT87_REG_VIN(8));
 
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < num_fans(data); i++) {
 			/* Skip disabled fans */
 			if (!(data->has_fan & (1 << i)))
 				continue;
-- 
1.5.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
