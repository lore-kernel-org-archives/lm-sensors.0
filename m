From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 04 Mar 2006 08:43:25 +0000
Subject: [lm-sensors] w83627ehf fan control
Message-Id: <4dfa50520603040043h4476dccbqc397d65cd8187913@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <aseBbf5V.1141374656.2047650.khali@localhost>
In-Reply-To: <aseBbf5V.1141374656.2047650.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Here's a patch that adds some basic PWM abilities to the w83627ehf
driver. It's only worth testing, because if you go to manual fan
control right now, since the automatic modes lose their settings when
you write something to pwmN_enable, and there isn't an interface to
put in some settings. So going back to an automatic mode isn't going
to do much good. Sorry to drop a 150-line patch, but it does let you
set fan PWM values, which is good. Please take a look at this. I'd
like to hear what you think. The email may wrap the first two lines of
the patch; I hope that doesn't mangle it too badly.

Thanks,
David

 drivers/hwmon/w83627ehf.c | ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 1 deletion(-)

diff -u linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c
new/drivers/hwmon/w83627ehf.c
--- linux-2.6.16-rc5-mm/drivers/hwmon/w83627ehf.c	2006-03-04
00:13:34.000000000 -0800
+++ new/drivers/hwmon/w83627ehf.c	2006-03-04 00:05:14.000000000 -0800
@@ -30,7 +30,7 @@
     Supports the following chips:

     Chip        #vin    #fan    #pwm    #temp   chip_id man_id
-    w83627ehf   -       5       -       3       0x88    0x5ca3
+    w83627ehf   -       5       4       3       0x88    0x5ca3

     This is a preliminary version of the driver, only supporting the
     fan and temperature inputs. The chip does much more than that.
@@ -136,6 +136,22 @@
 #define W83627EHF_REG_DIODE		0x59
 #define W83627EHF_REG_SMI_OVT		0x4C

+#define PWM_FROM_REG(val)		(val)
+#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
+
+#define W83627EHF_REG_PWM1		0x01
+#define W83627EHF_REG_PWM2		0x03
+#define W83627EHF_REG_PWM3		0x11
+#define W83627EHF_REG_PWM4		0x61
+static const u8 regpwm[] = { W83627EHF_REG_PWM1, W83627EHF_REG_PWM2,
+	W83627EHF_REG_PWM3, W83627EHF_REG_PWM4
+};
+#define W83627EHF_REG_PWM(nr)		(regpwm[(nr)])
+
+#define W83627EHF_REG_PWMCF1		0x04
+#define W83627EHF_REG_PWMCF2		0x12
+#define W83627EHF_REG_PWMCF3		0x62
+
 /*
  * Conversions
  */
@@ -196,6 +212,18 @@
 	s16 temp[2];
 	s16 temp_max[2];
 	s16 temp_max_hyst[2];
+	u8 pwm[4];		/* Fan PWM duty cycle
+				   [0] SYSFANOUT (pin 116)
+				   [1] CPUFANOUT0 (pin 115)
+				   [2] AUXFANOUT (pin 7)
+				   [3] CPUFANOUT1/GP20/MSO (pin 120) */
+	u8 pwm_mode[4];		/* PWM or DC mode: 1->PWM (default); 0->DC */
+	u8 pwmenable[4];	/* Fan PWM enable
+				   CPUFANOUT0 and CPUFANOUT1 support SmartFanIII
+				   0   = PWM, Fixed (manual) Speed
+				   1   = PWM, SmartFanI Thermal Cruise
+				   2   = PWM, SmartFanI Fan Speed Cruise
+				   3   = PWM, SmartFanIII (thermal cruise) */
 };

 static inline int is_word_sized(u16 reg)
@@ -395,6 +423,22 @@
 						 W83627EHF_REG_TEMP_HYST[i]);
 		}

+		/* PWM */
+		for (i = 0; i < 4; i++)
+			data->pwm[i] = PWM_FROM_REG(w83627ehf_read_value(client,
+					W83627EHF_REG_PWM(i)));
+		i = w83627ehf_read_value(client, W83627EHF_REG_PWMCF1);
+		data->pwm_mode[0] = (i & 1)!=0?0:1;
+		data->pwm_mode[1] = (i & 2)!=0?0:1;
+		data->pwmenable[0] = (i >> 2) & 3;
+		data->pwmenable[1] = (i >> 4) & 3;
+		i = w83627ehf_read_value(client, W83627EHF_REG_PWMCF2);
+		data->pwm_mode[2] = (i & 1)!=0?0:1;
+		data->pwmenable[2] = (i >> 1) & 3;
+		i = w83627ehf_read_value(client, W83627EHF_REG_PWMCF3);
+		data->pwm_mode[3] = (i & 0x40)!=0?0:1;
+		data->pwmenable[3] = (i >> 4) & 3;
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -619,6 +663,157 @@
 };

 /*
+ * PWM show and store functions
+ */
+
+static ssize_t
+show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
+}
+
+static ssize_t
+show_pwmenable(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long) data->pwmenable[nr - 1]);
+}
+
+static ssize_t
+show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	return sprintf(buf, "%ld\n", (long) data->pwm_mode[nr - 1]);
+}
+
+static ssize_t
+store_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->pwm[nr] = PWM_TO_REG(val);
+	w83627ehf_write_value(client, W83627EHF_REG_PWM(nr), data->pwm[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+/* w83627ehf_write_pwmenable_and_mode assumes the data->update_lock mutex
+ * is held when it is called. */
+static void w83627ehf_write_pwmenable_and_mode(struct i2c_client * client,
+	struct w83627ehf_data *data, int nr)
+{
+	u16 reg;
+
+	switch (nr)
+	{
+	case 0: /* register 0x04: [0] SYSFANOUT [1] CPUFANOUT0 */
+	case 1:
+		reg = w83627ehf_read_value(client, W83627EHF_REG_PWMCF1) & 0xc0;
+		reg |= data->pwmenable[1] << 4;
+		reg |= data->pwmenable[0] << 2;
+		reg |= (data->pwm_mode[1]!=0?0:1) << 1;
+		reg |= (data->pwm_mode[0]!=0?0:1);
+		w83627ehf_write_value(client, W83627EHF_REG_PWMCF1, reg);
+		break;
+	case 2: /* register 0x12: [2] AUXFANOUT */
+		reg = w83627ehf_read_value(client, W83627EHF_REG_PWMCF2) & 0xf8;
+		reg |= data->pwmenable[2] << 1;
+		reg |= (data->pwm_mode[2]!=0?0:1);
+		w83627ehf_write_value(client, W83627EHF_REG_PWMCF2, reg);
+		break;
+	case 3: /* register 0x62: [3] CPUFANOUT1 */
+		reg = w83627ehf_read_value(client, W83627EHF_REG_PWMCF3) & 0xf8;
+		reg |= data->pwmenable[3] << 4;
+		reg |= (data->pwm_mode[3]!=0?0:1) << 6;
+		w83627ehf_write_value(client, W83627EHF_REG_PWMCF3, reg);
+		break;
+	}
+}
+
+static ssize_t
+store_pwmenable(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	/* CPUFANOUT0 and CPUFANOUT1 (nr=1 and nr=3) support SmartFanIII */
+	/* SYSFANOUT and AUXFANOUT (nr=0 and nr=2| will return -EINVAL if */
+	/* user attempts to set them to SmartFanIII mode. */
+	if (val >= 3 + (nr & 1)) return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwmenable[nr] = val;
+	w83627ehf_write_pwmenable_and_mode(client, data, nr);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+store_pwm_mode(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	if (val > 1) return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm_mode[nr] = val;
+	w83627ehf_write_pwmenable_and_mode(client, data, nr);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static struct sensor_device_attribute sda_pwm[] = {
+	SENSOR_ATTR(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 1),
+	SENSOR_ATTR(pwm1_enable, S_IRUGO|S_IWUSR, show_pwmenable,
+			store_pwmenable, 1),
+	SENSOR_ATTR(pwm1_mode, S_IRUGO|S_IWUSR, show_pwm_mode,
+			store_pwm_mode, 1),
+	SENSOR_ATTR(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 2),
+	SENSOR_ATTR(pwm2_enable, S_IRUGO|S_IWUSR, show_pwmenable,
+			store_pwmenable, 2),
+	SENSOR_ATTR(pwm2_mode, S_IRUGO|S_IWUSR, show_pwm_mode,
+			store_pwm_mode, 2),
+	SENSOR_ATTR(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 3),
+	SENSOR_ATTR(pwm3_enable, S_IRUGO|S_IWUSR, show_pwmenable,
+			store_pwmenable, 3),
+	SENSOR_ATTR(pwm3_mode, S_IRUGO|S_IWUSR, show_pwm_mode,
+			store_pwm_mode, 3),
+	SENSOR_ATTR(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 4),
+	SENSOR_ATTR(pwm4_enable, S_IRUGO|S_IWUSR, show_pwmenable,
+			store_pwmenable, 4),
+	SENSOR_ATTR(pwm4_mode, S_IRUGO|S_IWUSR, show_pwm_mode,
+			store_pwm_mode, 4),
+};
+
+/*
  * Driver and client management
  */

@@ -711,6 +906,8 @@
 	}
 	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
 		device_create_file(dev, &sda_temp[i].dev_attr);
+	for (i = 0; i < ARRAY_SIZE(sda_pwm); i++)
+		device_create_file(dev, &sda_pwm[i].dev_attr);

 	return 0;

End-of-patch

