From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 12 Apr 2006 01:04:36 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <4dfa50520604111804n1f234486md8f41d09c7d87e4b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> You need the file I sent to you plus the fancrt patch on the top of it. This will create
> the file with all alarms voltages EHF driver, then when fancrt is applied you have the
> current base to start on it.
>
> Do your changes and when done just diff to same file but with your changes (so simply the ehf driver that I sent to you plus the fancrt patch)
>
> > I'll send a patch that has these things:
> > 1. switch DC 0 PWM 1
> > 2. new RPM cruise modes
>
> Good that is what I want to see.

Okay, first patch:
1. changes W83627EHF_PWM_ENALE_SHIFT to W83627EHF_PWM_ENABLE_SHIFT
2. changes to 0->DC and 1->PWM

Second patch:
1. Fix pwmN_enable = 0 (disabled) mode.
2. Comment pwmN_enable = 1 (manual) and pwmN_enable = 2 (thermal
cruise or SmartFan I)

And the regression test script (no changes) works with this new patch.
Please look these over. I'm getting the other patches ready.

Thanks,
David
-------------- next part --------------
Change W83627EHF_PWM_ENALE_SHIFT to W83627EHF_PWM_ENABLE_SHIFT
pwm_mode = 0->DC mode->1 stored in register
pwm_mode = 1->PWM mode->0 stored in register

diff -ur linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c
--- linux-2.6.16-rc5-mm-rudolf/drivers/hwmon/w83627ehf.c	2006-03-23 22:02:09.000000000 -0800
+++ linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c	2006-04-11 17:12:31.000000000 -0700
@@ -160,7 +160,7 @@
 static const u8 W83627EHF_PWM_MODE_USER_MAP[] = { 0, 0, 1, 3 };
 static const u8 W83627EHF_PWM_MODE_CHIP_MAP[] = { 1, 2, 4, 3 };
 static const u8 W83627EHF_PWM_MODE_SHIFT[] = { 0, 1, 0, 6 };
-static const u8 W83627EHF_PWM_ENALE_SHIFT[] = { 2, 4, 1, 4 };
+static const u8 W83627EHF_PWM_ENABLE_SHIFT[] = { 2, 4, 1, 4 };
 
 /* FAN Duty Cycle, be used to control */
 static const u8 W83627EHF_REG_PWM[] = { 0x01, 0x03, 0x11, 0x61 };
@@ -265,7 +265,12 @@
 	s16 temp_max_hyst[2];
 	u32 alarms;
  
- 	u8 pwm_mode[4]; /* 1 is fan speed cruise */
+	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle
+			 * Note that this is backward from the datasheet, but
+			 * consistent with the w83792d driver. Hopefully, any
+			 * new drivers which have PWM and DC modes will also
+			 * follow this convention for the sysfs pwmN_mode file.
+			 */
  	u8 pwm_enable[4];
  	u8 pwm[4];
  	u8 target_temp[4];
@@ -475,9 +480,10 @@
 				tmp = w83627ehf_read_value(client,
 						W83627EHF_REG_PWM_ENABLE[i]);
 			data->pwm_mode[i] -				(tmp >> W83627EHF_PWM_MODE_SHIFT[i]) & 1;
+				((tmp >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
+				?0:1;
 			data->pwm_enable[i] = W83627EHF_PWM_MODE_CHIP_MAP[
-						(tmp >> W83627EHF_PWM_ENALE_SHIFT[i]) & 3];
+						(tmp >> W83627EHF_PWM_ENABLE_SHIFT[i]) & 3];
 			data->pwm[i] = w83627ehf_read_value(client,
 						W83627EHF_REG_PWM[i]);
 			data->fan_min_output[i] = w83627ehf_read_value(client,
@@ -892,7 +898,7 @@
 	if (data->pwm_mode[nr] != val) {
 		data->pwm_mode[nr] = val;
 		reg = (reg & ~(1 << W83627EHF_PWM_MODE_SHIFT[nr]));
-		if (val)
+		if (!val)
 			reg |= 1 << W83627EHF_PWM_MODE_SHIFT[nr];
 		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
 					reg);
@@ -915,8 +921,8 @@
 		if (!val)
 			data->pwm[nr] = 0xff;
 		data->pwm_enable[nr] = val;
-		reg = (reg & ~(11 << W83627EHF_PWM_ENALE_SHIFT[nr]));
-		reg |= W83627EHF_PWM_MODE_USER_MAP[val] << W83627EHF_PWM_ENALE_SHIFT[nr];
+		reg = (reg & ~(11 << W83627EHF_PWM_ENABLE_SHIFT[nr]));
+		reg |= W83627EHF_PWM_MODE_USER_MAP[val] << W83627EHF_PWM_ENABLE_SHIFT[nr];
 		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
 					reg);
 	}
@@ -1225,13 +1231,15 @@
 	for (i = 0; i < 10; i++)
 		device_create_file_in(dev, i);
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < 5; i++)
 		if (data->has_fan & (1 << i))
 			device_create_file_fan(dev, i);
-//this condition needs to be fixed
-  		if (i != 4)
-  			device_create_file_pwm(dev, i);
+
+	for (i = 0; i < 4; i++) {
+		device_create_file_pwm(dev, i);
+		data->pwm_mode[i] = 1; /* initialize in PWM mode */
 	}
+
 	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
 		device_create_file(dev, &sda_temp[i].dev_attr);
 


-------------- next part --------------
pwmN_enable = 0 (disabled) locks pwmN at 255
pwmN_enable = 1 (manual) commented
pwmN_enable = 2 (thermal cruise or SmartFan I) commented

diff -ur linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c
--- linux-2.6.16-rc5-mm-01/drivers/hwmon/w83627ehf.c	2006-04-11 17:45:54.000000000 -0700
+++ linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c	2006-04-11 18:30:11.000000000 -0700
@@ -157,8 +157,6 @@
 };
 
 /* maps the user modes to chip modes */
-static const u8 W83627EHF_PWM_MODE_USER_MAP[] = { 0, 0, 1, 3 };
-static const u8 W83627EHF_PWM_MODE_CHIP_MAP[] = { 1, 2, 4, 3 };
 static const u8 W83627EHF_PWM_MODE_SHIFT[] = { 0, 1, 0, 6 };
 static const u8 W83627EHF_PWM_ENABLE_SHIFT[] = { 2, 4, 1, 4 };
 
@@ -271,7 +269,10 @@
 			 * new drivers which have PWM and DC modes will also
 			 * follow this convention for the sysfs pwmN_mode file.
 			 */
- 	u8 pwm_enable[4];
+	u8 pwm_enable[4]; /* 0->disabled
+			   * 1->manual
+			   * 2->thermal cruise (also called SmartFan I)
+			   */
  	u8 pwm[4];
  	u8 target_temp[4];
  	u8 tolerance[4];
@@ -482,8 +483,11 @@
 			data->pwm_mode[i]  				((tmp >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
 				?0:1;
-			data->pwm_enable[i] = W83627EHF_PWM_MODE_CHIP_MAP[
-						(tmp >> W83627EHF_PWM_ENABLE_SHIFT[i]) & 3];
+			if (data->pwm_enable[i] != 0 ||
+			    ((tmp >> W83627EHF_PWM_ENABLE_SHIFT[i]) & 3) != 0)
+				data->pwm_enable[i] = 
+					((tmp >> W83627EHF_PWM_ENABLE_SHIFT[i])
+						& 3)+1;
 			data->pwm[i] = w83627ehf_read_value(client,
 						W83627EHF_REG_PWM[i]);
 			data->fan_min_output[i] = w83627ehf_read_value(client,
@@ -907,42 +911,47 @@
 }
 
 static ssize_t
-store_pwm_enable(struct device *dev, struct device_attribute *attr,
+store_pwm(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct w83627ehf_data *data = w83627ehf_update_device(dev);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 3);
-	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
+	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);
 
-	if (data->pwm_enable[nr] != val) {
-		if (!val)
-			data->pwm[nr] = 0xff;
-		data->pwm_enable[nr] = val;
-		reg = (reg & ~(11 << W83627EHF_PWM_ENABLE_SHIFT[nr]));
-		reg |= W83627EHF_PWM_MODE_USER_MAP[val] << W83627EHF_PWM_ENABLE_SHIFT[nr];
-		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
-					reg);
+	if (data->pwm_enable[nr] != 0 && data->pwm[nr] != val) {
+		data->pwm[nr] = val;
+		w83627ehf_write_value(client, W83627EHF_REG_PWM[nr],
+					val);
 	}
 	return count;
 }
 
 static ssize_t
-store_pwm(struct device *dev, struct device_attribute *attr,
+store_pwm_enable(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct w83627ehf_data *data = w83627ehf_update_device(dev);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);
+	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 3);
+	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
 
-	if (data->pwm[nr] != val) {
-		data->pwm[nr] = val;
-		w83627ehf_write_value(client, W83627EHF_REG_PWM[nr],
-					val);
+	if (data->pwm_enable[nr] != val) {
+		if (!val) {
+			store_pwm(dev, attr, "255", 3);
+			data->pwm_enable[nr] = val;
+		}
+		else {
+			data->pwm_enable[nr] = val;
+			val--;
+		}
+		reg = (reg & ~(11 << W83627EHF_PWM_ENABLE_SHIFT[nr]));
+		reg |= val << W83627EHF_PWM_ENABLE_SHIFT[nr];
+		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
+					reg);
 	}
 	return count;
 }

-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 14767 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060412/47706ed4/w83627ehf_regression.sh
