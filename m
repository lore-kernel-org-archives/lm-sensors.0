From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Tue, 05 Aug 2008 22:29:41 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (w83791d) add pwm_enable support
Message-Id: <200808060029.41402.m.hulsman@tudelft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_VRNmIaL87X1ubF0"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_VRNmIaL87X1ubF0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

These patches add support for pwm_enable. I did allow for setting fan speed 
cruise mode although I will only implement further support for thermal cruise 
mode (next patch), as the bios could initialize the chip with this mode. 

Marc

---
Add support for pwm_enable.

Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl> 

---
 Documentation/hwmon/w83791d |   13 ++++++-
 drivers/hwmon/w83791d.c     |   79 
++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

---
Index: linux-2.6.27-rc1/Documentation/hwmon/w83791d
===================================================================
--- linux-2.6.27-rc1.orig/Documentation/hwmon/w83791d
+++ linux-2.6.27-rc1/Documentation/hwmon/w83791d
@@ -108,6 +108,17 @@ going forward.
 The driver reads the hardware chip values at most once every three seconds.
 User mode code requesting values more often will receive cached values.
 
+/sys files
+----------
+The sysfs-interface is documented in the 'sysfs-interface' file. Only
+chip-specific options are documented here.
+
+pwm[1-3]_enable - 	this file controls mode of fan/temperature control for
+		  	fan 1-3. Fan/PWM 4-5 only support manual mode.
+		            * 1 Manual mode
+		            * 2 Thermal Cruise mode   (no further support)
+		            * 3 Fan Speed Cruise mode (no further support)
+
 Alarms bitmap vs. beep_mask bitmask
 ------------------------------------
 For legacy code using the alarms and beep_mask files:
@@ -138,4 +149,4 @@ global_enable:  alarms: -------- beep_ma
 
 W83791D TODO:
 ---------------
-Provide a patch for smart-fan control (still need appropriate 
motherboard/fans)
+Provide a patch for Thermal Cruise registers.
Index: linux-2.6.27-rc1/drivers/hwmon/w83791d.c
===================================================================
--- linux-2.6.27-rc1.orig/drivers/hwmon/w83791d.c
+++ linux-2.6.27-rc1/drivers/hwmon/w83791d.c
@@ -287,6 +287,8 @@ struct w83791d_data {
 
 	/* PWMs */
 	u8 pwm[5];		/* pwm duty cycle */
+	u8 pwm_enable[3];	/* pwm enable status for fan 1-3
+					(fan 4-5 only support manual mode) */
 
 	/* Misc */
 	u32 alarms;		/* realtime status register encoding,combined */
@@ -707,6 +709,71 @@ static struct sensor_device_attribute sd
 			show_pwm, store_pwm, 4),
 };
 
+static ssize_t show_pwmenable(struct device *dev, struct device_attribute 
*attr,
+				char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83791d_data *data = w83791d_update_device(dev);
+	return sprintf(buf, "%u\n", data->pwm_enable[nr]);
+}
+
+static ssize_t store_pwmenable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83791d_data *data = i2c_get_clientdata(client);
+	int nr = sensor_attr->index;
+	unsigned long val;
+	u8 reg_cfg_tmp;
+	u8 reg_idx = 0;
+	u8 val_shift = 0;
+	u8 keep_mask = 0;
+
+	int ret = strict_strtoul(buf, 10, &val);
+
+	if (ret || val < 1 || val > 3)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm_enable[nr] = val - 1;
+	switch (nr) {
+	case 0:
+		reg_idx = 0;
+		val_shift = 2;
+		keep_mask = 0xf3;
+		break;
+	case 1:
+		reg_idx = 0;
+		val_shift = 4;
+		keep_mask = 0xcf;
+		break;
+	case 2:
+		reg_idx = 1;
+		val_shift = 2;
+		keep_mask = 0xf3;
+		break;
+	}
+
+	reg_cfg_tmp = w83791d_read(client, W83791D_REG_FAN_CFG[reg_idx]);
+	reg_cfg_tmp = (reg_cfg_tmp & keep_mask) |
+					data->pwm_enable[nr] << val_shift;
+
+	w83791d_write(client, W83791D_REG_FAN_CFG[reg_idx], reg_cfg_tmp);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+static struct sensor_device_attribute sda_pwmenable[] = {
+	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+			show_pwmenable, store_pwmenable, 0),
+	SENSOR_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
+			show_pwmenable, store_pwmenable, 1),
+	SENSOR_ATTR(pwm3_enable, S_IWUSR | S_IRUGO,
+			show_pwmenable, store_pwmenable, 2),
+};
+
 /* read/write the temperature1, includes measured value and limits */
 static ssize_t show_temp1(struct device *dev, struct device_attribute 
*devattr,
 				char *buf)
@@ -974,6 +1041,9 @@ static struct attribute *w83791d_attribu
 	&sda_pwm[0].dev_attr.attr,
 	&sda_pwm[1].dev_attr.attr,
 	&sda_pwm[2].dev_attr.attr,
+	&sda_pwmenable[0].dev_attr.attr,
+	&sda_pwmenable[1].dev_attr.attr,
+	&sda_pwmenable[2].dev_attr.attr,
 	NULL
 };
 
@@ -1324,6 +1394,15 @@ static struct w83791d_data *w83791d_upda
 						W83791D_REG_PWM[i]);
 		}
 
+		/* Update PWM enable status */
+		for (i = 0; i < 2; i++) {
+			reg_array_tmp[i] = w83791d_read(client,
+						W83791D_REG_FAN_CFG[i]);
+		}
+		data->pwm_enable[0] = ((reg_array_tmp[0] >> 2) & 0x03) + 1;
+		data->pwm_enable[1] = ((reg_array_tmp[0] >> 4) & 0x03) + 1;
+		data->pwm_enable[2] = ((reg_array_tmp[1] >> 2) & 0x03) + 1;
+
 		/* Update the first temperature sensor */
 		for (i = 0; i < 3; i++) {
 			data->temp1[i] = w83791d_read(client,

--Boundary-00=_VRNmIaL87X1ubF0
Content-Type: text/x-diff; charset="us-ascii"; name="w83791d_pwmenable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w83791d_pwmenable.patch"

Add support for pwm_enable.

Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl> 

---
 Documentation/hwmon/w83791d |   13 ++++++-
 drivers/hwmon/w83791d.c     |   79 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

---
Index: linux-2.6.27-rc1/Documentation/hwmon/w83791d
===================================================================
--- linux-2.6.27-rc1.orig/Documentation/hwmon/w83791d
+++ linux-2.6.27-rc1/Documentation/hwmon/w83791d
@@ -108,6 +108,17 @@ going forward.
 The driver reads the hardware chip values at most once every three seconds.
 User mode code requesting values more often will receive cached values.
 
+/sys files
+----------
+The sysfs-interface is documented in the 'sysfs-interface' file. Only
+chip-specific options are documented here.
+
+pwm[1-3]_enable - 	this file controls mode of fan/temperature control for
+		  	fan 1-3. Fan/PWM 4-5 only support manual mode.
+		            * 1 Manual mode
+		            * 2 Thermal Cruise mode   (no further support)
+		            * 3 Fan Speed Cruise mode (no further support)
+
 Alarms bitmap vs. beep_mask bitmask
 ------------------------------------
 For legacy code using the alarms and beep_mask files:
@@ -138,4 +149,4 @@ global_enable:  alarms: -------- beep_ma
 
 W83791D TODO:
 ---------------
-Provide a patch for smart-fan control (still need appropriate motherboard/fans)
+Provide a patch for Thermal Cruise registers.
Index: linux-2.6.27-rc1/drivers/hwmon/w83791d.c
===================================================================
--- linux-2.6.27-rc1.orig/drivers/hwmon/w83791d.c
+++ linux-2.6.27-rc1/drivers/hwmon/w83791d.c
@@ -287,6 +287,8 @@ struct w83791d_data {
 
 	/* PWMs */
 	u8 pwm[5];		/* pwm duty cycle */
+	u8 pwm_enable[3];	/* pwm enable status for fan 1-3
+					(fan 4-5 only support manual mode) */
 
 	/* Misc */
 	u32 alarms;		/* realtime status register encoding,combined */
@@ -707,6 +709,71 @@ static struct sensor_device_attribute sd
 			show_pwm, store_pwm, 4),
 };
 
+static ssize_t show_pwmenable(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83791d_data *data = w83791d_update_device(dev);
+	return sprintf(buf, "%u\n", data->pwm_enable[nr]);
+}
+
+static ssize_t store_pwmenable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83791d_data *data = i2c_get_clientdata(client);
+	int nr = sensor_attr->index;
+	unsigned long val;
+	u8 reg_cfg_tmp;
+	u8 reg_idx = 0;
+	u8 val_shift = 0;
+	u8 keep_mask = 0;
+
+	int ret = strict_strtoul(buf, 10, &val);
+
+	if (ret || val < 1 || val > 3)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm_enable[nr] = val - 1;
+	switch (nr) {
+	case 0:
+		reg_idx = 0;
+		val_shift = 2;
+		keep_mask = 0xf3;
+		break;
+	case 1:
+		reg_idx = 0;
+		val_shift = 4;
+		keep_mask = 0xcf;
+		break;
+	case 2:
+		reg_idx = 1;
+		val_shift = 2;
+		keep_mask = 0xf3;
+		break;
+	}
+
+	reg_cfg_tmp = w83791d_read(client, W83791D_REG_FAN_CFG[reg_idx]);
+	reg_cfg_tmp = (reg_cfg_tmp & keep_mask) |
+					data->pwm_enable[nr] << val_shift;
+
+	w83791d_write(client, W83791D_REG_FAN_CFG[reg_idx], reg_cfg_tmp);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+static struct sensor_device_attribute sda_pwmenable[] = {
+	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+			show_pwmenable, store_pwmenable, 0),
+	SENSOR_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
+			show_pwmenable, store_pwmenable, 1),
+	SENSOR_ATTR(pwm3_enable, S_IWUSR | S_IRUGO,
+			show_pwmenable, store_pwmenable, 2),
+};
+
 /* read/write the temperature1, includes measured value and limits */
 static ssize_t show_temp1(struct device *dev, struct device_attribute *devattr,
 				char *buf)
@@ -974,6 +1041,9 @@ static struct attribute *w83791d_attribu
 	&sda_pwm[0].dev_attr.attr,
 	&sda_pwm[1].dev_attr.attr,
 	&sda_pwm[2].dev_attr.attr,
+	&sda_pwmenable[0].dev_attr.attr,
+	&sda_pwmenable[1].dev_attr.attr,
+	&sda_pwmenable[2].dev_attr.attr,
 	NULL
 };
 
@@ -1324,6 +1394,15 @@ static struct w83791d_data *w83791d_upda
 						W83791D_REG_PWM[i]);
 		}
 
+		/* Update PWM enable status */
+		for (i = 0; i < 2; i++) {
+			reg_array_tmp[i] = w83791d_read(client,
+						W83791D_REG_FAN_CFG[i]);
+		}
+		data->pwm_enable[0] = ((reg_array_tmp[0] >> 2) & 0x03) + 1;
+		data->pwm_enable[1] = ((reg_array_tmp[0] >> 4) & 0x03) + 1;
+		data->pwm_enable[2] = ((reg_array_tmp[1] >> 2) & 0x03) + 1;
+
 		/* Update the first temperature sensor */
 		for (i = 0; i < 3; i++) {
 			data->temp1[i] = w83791d_read(client,

--Boundary-00=_VRNmIaL87X1ubF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_VRNmIaL87X1ubF0--
