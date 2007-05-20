From: Carlos Olalla =?iso-8859-1?Q?Mart=EDnez?= <com.ea@tinet.org>
Date: Sun, 20 May 2007 13:52:21 +0000
Subject: [lm-sensors] hwmon/w83627hf pwm_freq support
Message-Id: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Couldnt test it, but w83697hf was OK in 2.6.21.1; any tester with a w83627hf?

Signed-off-by: Carlos Olalla <com.ea@tinet.org>
diff -uprN -X linux-2.6.22-rc1/Documentation/dontdiff
linux-2.6.22-rc1.orig/drivers/hwmon/w83627hf.c
linux-2.6.22-rc1/drivers/hwmon/w83627hf.c
--- linux-2.6.22-rc1.orig/drivers/hwmon/w83627hf.c	2007-05-13
03:45:56.000000000 +0200
+++ linux-2.6.22-rc1/drivers/hwmon/w83627hf.c	2007-05-19
18:31:55.000000000 +0200
@@ -25,12 +25,12 @@
 /*
     Supports following chips:

-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
-    w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
-    w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
-    w83687thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
+    Chip	#vin	#fanin	#pwm	#pwm_freq	#temp	wchipid	vendid	i2c	ISA
+    w83627hf	9	3	2	2		3	0x20	0x5ca3	no	yes(LPC)
+    w83627thf	7	3	3	X		3	0x90	0x5ca3	no	yes(LPC)
+    w83637hf	7	3	3	3		3	0x80	0x5ca3	no	yes(LPC)
+    w83687thf	7	3	3	3		3	0x90	0x5ca3	no	yes(LPC)
+    w83697hf	8	2	2	2		2	0x60	0x5ca3	no	yes(LPC)

     For other winbond chips, and for i2c support in the above chips,
     use w83781d.c.
@@ -220,6 +220,25 @@ static const u8 regpwm[] = { W83627THF_R
 #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
                                      regpwm_627hf[(nr) - 1] : regpwm[(nr)
- 1])

+#define W83627HF_REG_PWM_FREQ1		0x5C	/* Only for the 627HF */
+#define W83627HF_REG_PWM_FREQ2		0x5C	/* Only for the 627HF */
+
+#define W83637HF_REG_PWM_FREQ1		0x00	/* 697HF/687THF too */
+#define W83637HF_REG_PWM_FREQ2		0x02	/* 697HF/687THF too */
+#define W83637HF_REG_PWM_FREQ3		0x10	/* 687THF too */
+
+/* 687thf uses DC output by default and 627thf only uses DC output.
+ PWMCLK is useless for DC output */
+static const u8 regpwmfreq_627hf[] = { W83627HF_REG_PWM_FREQ1,
W83627HF_REG_PWM_FREQ2 };
+static const u8 regpwmfreq[] = { W83637HF_REG_PWM_FREQ1,
W83637HF_REG_PWM_FREQ2,
+				 W83637HF_REG_PWM_FREQ3 };
+#define W836X7HF_REG_PWM_FREQ(type, nr) (((type) = w83627hf) ? \
+                                     regpwmfreq_627hf[(nr) - 1] :
regpwmfreq[(nr) - 1])
+
+/* From manual 627hf -> 46870 Hz is the base,
+	we take 46880 to avoid float results with divisors. */
+#define W83627HF_DEFAULT_PWM_FREQ	46880
+
 #define W83781D_REG_I2C_ADDR 0x48
 #define W83781D_REG_I2C_SUBADDR 0x4A

@@ -267,6 +286,49 @@ static int TEMP_FROM_REG(u8 reg)

 #define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))

+static inline unsigned long pwm_freq_from_reg_627hf(u8 reg, int nr)
+{
+	unsigned long freq;
+	/* bits 6..4 pwmclk2 (nr=2) .. bits 2..0 pwmclk1 (nr=1) */
+	reg = (reg >> ((nr-1)*4)) & 0x07;
+	freq = W83627HF_DEFAULT_PWM_FREQ/(2^reg);
+	return freq;
+}
+static inline u8 pwm_freq_to_reg_627hf(unsigned long val, int nr)
+{
+	u8 i;
+	/* Only 5 dividers (1 2 4 8 16)... Search for the nearest available
frequency */
+	for (i = 0; i < 5; i++) {
+		if (val > (W83627HF_DEFAULT_PWM_FREQ/(2^i) +
W83627HF_DEFAULT_PWM_FREQ/(2^(i+1))) / 2)
+			break;
+	}
+	return (i << ((nr-1)*4));
+}
+
+static inline unsigned long pwm_freq_from_reg(u8 reg)
+{
+	/* Clock bit 8 -> 180 kHz or 24 MHz */
+	unsigned long clock = (reg & 0x80) ? 180000UL : 24000000UL;
+
+	reg &= 0x7f;
+	/* This should not happen but anyway... */
+	if (reg = 0)
+		reg++;
+	return clock / ( reg << 8 );
+}
+static inline u8 pwm_freq_to_reg(unsigned long val)
+{
+	/* Minimum divider value is 0x01 and maximum is 0x7F */
+	if (val >= 93750)	/* The highest we can do */
+		return 0x01;
+	if (val >= 738)	/* Use 24 MHz clock */
+		return (24000000UL / (val << 8));
+	if (val < 6)		/* The lowest we can do */
+		return 0xFF;
+	else			/* Use 180 kHz clock */
+		return 0x80 | (180000UL / (val << 8));
+}
+
 #define BEEP_MASK_FROM_REG(val)		 (val)
 #define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
 #define BEEP_ENABLE_TO_REG(val)		((val)?1:0)
@@ -316,6 +378,7 @@ struct w83627hf_data {
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[3];		/* Register value */
+	u8 pwm_freq[3];		/* Register value */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
 				   3000-5000 = thermistor beta.
@@ -852,6 +915,61 @@ sysfs_pwm(2);
 sysfs_pwm(3);

 static ssize_t
+show_pwm_freq_reg(struct device *dev, char *buf, int nr)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+//	return sprintf(buf, "%ld\n", (long) data->pwm_freq[nr - 1]);
+	if (data->type = w83627hf)
+		return sprintf(buf, "%ld\n",
pwm_freq_from_reg_627hf(data->pwm_freq[nr-1],nr));
+	else
+		return sprintf(buf, "%ld\n", pwm_freq_from_reg(data->pwm_freq[nr-1]));
+}
+
+static ssize_t
+store_pwm_freq_reg(struct device *dev, const char *buf, size_t count, int
nr)
+{
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+	u32 val;
+	u8 mask[]={0xF8, 0x8F};
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+
+	if (data->type = w83627hf) {
+		data->pwm_freq[nr - 1] = pwm_freq_to_reg_627hf(val,nr);
+		w83627hf_write_value( data, regpwmfreq_627hf[nr - 1],
+					data->pwm_freq[nr - 1] |
+					(w83627hf_read_value(data,
+					regpwmfreq_627hf[nr - 1]) & mask[nr - 1]) );
+	} else if ( (data->type = w83637hf) || (data->type = w83697hf) ||
(data->type = w83687thf) ) {
+		data->pwm_freq[nr - 1] = pwm_freq_to_reg(val);
+		w83627hf_write_value(data, regpwmfreq[nr - 1],
+					data->pwm_freq[nr - 1]);
+	}
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+#define sysfs_pwm_freq(offset) \
+static ssize_t show_regs_pwm_freq_##offset (struct device *dev, struct
device_attribute *attr, char *buf) \
+{ \
+	return show_pwm_freq_reg(dev, buf, offset); \
+} \
+static ssize_t \
+store_regs_pwm_freq_##offset (struct device *dev, struct device_attribute
*attr, const char *buf, size_t count) \
+{ \
+	return store_pwm_freq_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(pwm##offset##_freq, S_IRUGO | S_IWUSR, \
+		  show_regs_pwm_freq_##offset, store_regs_pwm_freq_##offset);
+
+sysfs_pwm_freq(1);
+sysfs_pwm_freq(2);
+sysfs_pwm_freq(3);
+
+static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1044,6 +1162,8 @@ static struct attribute *w83627hf_attrib

 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm2.attr,
+	&dev_attr_pwm1_freq.attr,
+	&dev_attr_pwm2_freq.attr,

 	&dev_attr_name.attr,
 	NULL
@@ -1074,6 +1194,7 @@ static struct attribute *w83627hf_attrib
 	&dev_attr_temp3_type.attr,

 	&dev_attr_pwm3.attr,
+	&dev_attr_pwm3_freq.attr,

 	NULL
 };
@@ -1167,6 +1288,10 @@ static int __devinit w83627hf_probe(stru
 		if ((err = device_create_file(dev, &dev_attr_pwm3)))
 			goto ERROR4;

+	if (data->type = w83637hf || data->type = w83687thf)
+		if ((err = device_create_file(dev, &dev_attr_pwm3_freq)))
+			goto ERROR4;
+
 	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
@@ -1470,6 +1595,14 @@ static struct w83627hf_data *w83627hf_up
 			   (data->type = w83627hf || data->type = w83697hf))
 				break;
 		}
+		for (i = 1; i <= 3; i++) {
+			u8 tmp = w83627hf_read_value(data,
+				W836X7HF_REG_PWM_FREQ(data->type, i));
+			data->pwm_freq[i - 1] = tmp;
+			if(i = 2 &&
+			   (data->type != w83637hf || data->type != w83687thf))
+				break;
+		}

 		data->temp = w83627hf_read_value(data, W83781D_REG_TEMP(1));
 		data->temp_max 
--

Carlos


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
