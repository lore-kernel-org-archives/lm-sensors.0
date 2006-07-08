From: com.ea@tinet.org (com.ea)
Date: Sat, 08 Jul 2006 18:51:37 +0000
Subject: [lm-sensors] [PATCH] Resubmit w83627hf.c pwm clock selection and
Message-Id: <c9vva294j9d0900b7semonbu3807o8v2q9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry, I didnt follow the STANDARDS last time I send this patch.
As you can see, its for the 2.6.17.3 kernel driver w83627hf.c


From: Carlos Olalla  <com.ea at tinet.org>

filename=hwmon-w83627hf-add-pwm-support.patch

This patch adds support for pwm clock selection and pwm clock scaling
for the w83627hf and the w83697hf hardware monitors, both supported by this driver.

Signed-off-by: Carlos Olalla <com.ea at tinet.org>

---

--- linux-2.6.17.3/drivers/hwmon/w83627hf.c.orig	2006-07-08 20:43:42.000000000 +0200
+++ linux-2.6.17.3/drivers/hwmon/w83627hf.c	2006-07-05 17:43:31.000000000 +0200
@@ -219,6 +219,15 @@ static const u8 regpwm[] = { W83627THF_R
                              W83627THF_REG_PWM3 };
 #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
                                      regpwm_627hf[(nr) - 1] : regpwm[(nr) - 1])
+					 
+#define W83697HF_REG_PWMCLK1	0x00	/* Only for the 697HF */
+#define W83697HF_REG_PWMCLK2	0x02	/* Only for the 697HF */
+		 
+static const u8 reg_pwmclk_697hf[] = {W83697HF_REG_PWMCLK1, W83697HF_REG_PWMCLK2};
+							 
+#define W83627HF_REG_PWMCLK12	0x5C	/* Only for the 627HF */
+
+// To do : w83627thf, w83637hf and w83687thf pwmclk support
 
 #define W83781D_REG_I2C_ADDR 0x48
 #define W83781D_REG_I2C_SUBADDR 0x4A
@@ -319,6 +328,7 @@ struct w83627hf_data {
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[3];		/* Register value */
+	u8 pwmclk[3];		/* Register value */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
 				   3000-5000 = thermistor beta.
@@ -901,6 +911,68 @@ device_create_file(&client->dev, &dev_at
 } while (0)
 
 static ssize_t
+show_pwmclk_reg(struct device *dev, char *buf, int nr)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long) data->pwmclk[nr - 1]);
+}
+
+static ssize_t
+store_pwmclk_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627hf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+
+	if (data->type = w83627hf) {
+		/* bits 7 and 3 are reserved */
+		data->pwmclk[nr - 1] = PWM_TO_REG(val) & 0x77;
+		/* bits 6..4 pwmclk2 .. bits 2..0 pwmclk1 */
+		w83627hf_write_value(client,
+				     W83627HF_REG_PWMCLK12,
+				     data->pwmclk[nr - 1] |
+				     (w83627hf_read_value(client,
+				     W83627HF_REG_PWMCLK12) & 0x88)); 
+	} else  if (data->type = w83697hf) {
+		data->pwmclk[nr - 1] = PWM_TO_REG(val);
+		w83627hf_write_value(client,
+				     reg_pwmclk_697hf[nr - 1],
+				     data->pwmclk[nr - 1]);
+	} else  {
+		/* TODO w83627thf, w83637hf and w83687thf */
+	}
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+#define sysfs_pwmclk(offset) \
+static ssize_t show_regs_pwmclk_##offset (struct device *dev, struct device_attribute *attr, char
*buf) \
+{ \
+	return show_pwmclk_reg(dev, buf, offset); \
+} \
+static ssize_t \
+store_regs_pwmclk_##offset (struct device *dev, struct device_attribute *attr, const char *buf,
size_t count) \
+{ \
+	return store_pwmclk_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(pwmclk##offset, S_IRUGO | S_IWUSR, \
+		  show_regs_pwmclk_##offset, store_regs_pwmclk_##offset);
+
+sysfs_pwmclk(1);
+sysfs_pwmclk(2);
+// sysfs_pwmclk(3); /* TODO w83627thf, w83637hf and w83687thf */
+
+#define device_create_file_pwmclk(client, offset) \
+do { \
+device_create_file(&client->dev, &dev_attr_pwmclk##offset); \
+} while (0)
+
+static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1155,6 +1227,15 @@ static int w83627hf_detect(struct i2c_ad
 	device_create_file_pwm(new_client, 2);
 	if (kind = w83627thf || kind = w83637hf || kind = w83687thf)
 		device_create_file_pwm(new_client, 3);
+	
+	if (kind = w83697hf) {
+		device_create_file_pwmclk(new_client, 1);
+		device_create_file_pwmclk(new_client, 2);
+	} else if (kind = w83627hf) {
+		device_create_file_pwmclk(new_client, 1);
+	} else {
+		/* TODO w83627thf, w83637hf and w83687thf */
+	}
 
 	device_create_file_sensor(new_client, 1);
 	device_create_file_sensor(new_client, 2);
@@ -1469,6 +1550,18 @@ static struct w83627hf_data *w83627hf_up
 				break;
 		}
 
+		if ( data->type = w83697hf ) {
+			for (i = 1; i <= 2; i++) {
+				u8 tmp = w83627hf_read_value(client,reg_pwmclk_697hf[i-1]);
+				data->pwmclk[i - 1] = tmp;
+			}
+		} else if ( data->type = w83627hf ) {
+			u8 tmp = w83627hf_read_value(client,W83627HF_REG_PWMCLK12);
+			data->pwmclk[0] = tmp;
+		} else {
+			/* TODO w83627thf, w83637hf and w83687thf */
+		}
+
 		data->temp = w83627hf_read_value(client, W83781D_REG_TEMP(1));
 		data->temp_max  		    w83627hf_read_value(client, W83781D_REG_TEMP_OVER(1));


