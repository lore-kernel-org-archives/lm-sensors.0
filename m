From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:12 +0000
Subject: [lm-sensors] [PATCH 10/39] hwmon: (dme1737) Fix checkpatch issues
Message-Id: <1326703781-14272-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
WARNING: braces {} are not necessary for any arm of this statement
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/dme1737.c |  217 +++++++++++++++++++++--------------------------
 1 files changed, 97 insertions(+), 120 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index d980395..fc442ff 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -300,9 +300,8 @@ static int TEMP_RANGE_TO_REG(int val, int reg)
 	int i;
 
 	for (i = 15; i > 0; i--) {
-		if (val > (TEMP_RANGE[i] + TEMP_RANGE[i - 1] + 1) / 2) {
+		if (val > (TEMP_RANGE[i] + TEMP_RANGE[i - 1] + 1) / 2)
 			break;
-		}
 	}
 
 	return (reg & 0x0f) | (i << 4);
@@ -327,21 +326,19 @@ static inline int TEMP_HYST_TO_REG(int val, int ix, int reg)
 /* Fan input RPM */
 static inline int FAN_FROM_REG(int reg, int tpc)
 {
-	if (tpc) {
+	if (tpc)
 		return tpc * reg;
-	} else {
+	else
 		return (reg = 0 || reg = 0xffff) ? 0 : 90000 * 60 / reg;
-	}
 }
 
 static inline int FAN_TO_REG(int val, int tpc)
 {
-	if (tpc) {
+	if (tpc)
 		return SENSORS_LIMIT(val / tpc, 0, 0xffff);
-	} else {
+	else
 		return (val <= 0) ? 0xffff :
 			SENSORS_LIMIT(90000 * 60 / val, 0, 0xfffe);
-	}
 }
 
 /* Fan TPC (tach pulse count)
@@ -378,9 +375,8 @@ static int FAN_MAX_FROM_REG(int reg)
 	int i;
 
 	for (i = 10; i > 0; i--) {
-		if (reg = FAN_MAX[i]) {
+		if (reg = FAN_MAX[i])
 			break;
-		}
 	}
 
 	return 1000 + i * 500;
@@ -391,9 +387,8 @@ static int FAN_MAX_TO_REG(int val)
 	int i;
 
 	for (i = 10; i > 0; i--) {
-		if (val > (1000 + (i - 1) * 500)) {
+		if (val > (1000 + (i - 1) * 500))
 			break;
-		}
 	}
 
 	return FAN_MAX[i];
@@ -468,9 +463,8 @@ static int PWM_FREQ_TO_REG(int val, int reg)
 		i = 11;
 	} else {
 		for (i = 9; i > 0; i--) {
-			if (val > (PWM_FREQ[i] + PWM_FREQ[i - 1] + 1) / 2) {
+			if (val > (PWM_FREQ[i] + PWM_FREQ[i - 1] + 1) / 2)
 				break;
-			}
 		}
 	}
 
@@ -495,9 +489,8 @@ static int PWM_RR_TO_REG(int val, int ix, int reg)
 	int i;
 
 	for (i = 0; i < 7; i++) {
-		if (val > (PWM_RR[i] + PWM_RR[i + 1] + 1) / 2) {
+		if (val > (PWM_RR[i] + PWM_RR[i + 1] + 1) / 2)
 			break;
-		}
 	}
 
 	return (ix = 1) ? (reg & 0x8f) | (i << 4) : (reg & 0xf8) | i;
@@ -607,9 +600,8 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 			/* Voltage inputs are stored as 16 bit values even
 			 * though they have only 12 bits resolution. This is
 			 * to make it consistent with the temp inputs. */
-			if (ix = 7 && !(data->has_features & HAS_IN7)) {
+			if (ix = 7 && !(data->has_features & HAS_IN7))
 				continue;
-			}
 			data->in[ix] = dme1737_read(data,
 					DME1737_REG_IN(ix)) << 8;
 			data->in_min[ix] = dme1737_read(data,
@@ -642,16 +634,14 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 		 * which the registers are read (MSB first, then LSB) is
 		 * important! */
 		for (ix = 0; ix < ARRAY_SIZE(lsb); ix++) {
-			if (ix = 5 && !(data->has_features & HAS_IN7)) {
+			if (ix = 5 && !(data->has_features & HAS_IN7))
 				continue;
-			}
 			lsb[ix] = dme1737_read(data,
 					DME1737_REG_IN_TEMP_LSB(ix));
 		}
 		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
-			if (ix = 7 && !(data->has_features & HAS_IN7)) {
+			if (ix = 7 && !(data->has_features & HAS_IN7))
 				continue;
-			}
 			data->in[ix] |= (lsb[DME1737_REG_IN_LSB[ix]] <<
 					DME1737_REG_IN_LSB_SHL[ix]) & 0xf0;
 		}
@@ -664,9 +654,8 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 		for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {
 			/* Skip reading registers if optional fans are not
 			 * present */
-			if (!(data->has_features & HAS_FAN(ix))) {
+			if (!(data->has_features & HAS_FAN(ix)))
 				continue;
-			}
 			data->fan[ix] = dme1737_read(data,
 					DME1737_REG_FAN(ix));
 			data->fan[ix] |= dme1737_read(data,
@@ -688,9 +677,8 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 		for (ix = 0; ix < ARRAY_SIZE(data->pwm); ix++) {
 			/* Skip reading registers if optional PWMs are not
 			 * present */
-			if (!(data->has_features & HAS_PWM(ix))) {
+			if (!(data->has_features & HAS_PWM(ix)))
 				continue;
-			}
 			data->pwm[ix] = dme1737_read(data,
 					DME1737_REG_PWM(ix));
 			data->pwm_freq[ix] = dme1737_read(data,
@@ -711,9 +699,8 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 		/* Thermal zone registers */
 		for (ix = 0; ix < ARRAY_SIZE(data->zone_low); ix++) {
 			/* Skip reading registers if zone3 is not present */
-			if ((ix = 2) && !(data->has_features & HAS_ZONE3)) {
+			if ((ix = 2) && !(data->has_features & HAS_ZONE3))
 				continue;
-			}
 			/* sch5127 zone2 registers are special */
 			if ((ix = 1) && (data->type = sch5127)) {
 				data->zone_low[1] = dme1737_read(data,
@@ -750,18 +737,12 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 		 * Don't worry, an alarm will come back if the condition
 		 * that causes it still exists */
 		if (!data->client) {
-			if (data->alarms & 0xff0000) {
-				dme1737_write(data, DME1737_REG_ALARM3,
-					      0xff);
-			}
-			if (data->alarms & 0xff00) {
-				dme1737_write(data, DME1737_REG_ALARM2,
-					      0xff);
-			}
-			if (data->alarms & 0xff) {
-				dme1737_write(data, DME1737_REG_ALARM1,
-					      0xff);
-			}
+			if (data->alarms & 0xff0000)
+				dme1737_write(data, DME1737_REG_ALARM3, 0xff);
+			if (data->alarms & 0xff00)
+				dme1737_write(data, DME1737_REG_ALARM2, 0xff);
+			if (data->alarms & 0xff)
+				dme1737_write(data, DME1737_REG_ALARM1, 0xff);
 		}
 
 		data->last_update = jiffies;
@@ -822,7 +803,12 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	switch (fn) {
@@ -901,7 +887,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	switch (fn) {
@@ -952,11 +943,10 @@ static ssize_t show_zone(struct device *dev, struct device_attribute *attr,
 	switch (fn) {
 	case SYS_ZONE_AUTO_CHANNELS_TEMP:
 		/* check config2 for non-standard temp-to-zone mapping */
-		if ((ix = 1) && (data->config2 & 0x02)) {
+		if ((ix = 1) && (data->config2 & 0x02))
 			res = 4;
-		} else {
+		else
 			res = 1 << ix;
-		}
 		break;
 	case SYS_ZONE_AUTO_POINT1_TEMP_HYST:
 		res = TEMP_FROM_REG(data->zone_low[ix], 8) -
@@ -989,7 +979,12 @@ static ssize_t set_zone(struct device *dev, struct device_attribute *attr,
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	switch (fn) {
@@ -1095,7 +1090,12 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	switch (fn) {
@@ -1170,21 +1170,19 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 
 	switch (fn) {
 	case SYS_PWM:
-		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 0) {
+		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 0)
 			res = 255;
-		} else {
+		else
 			res = data->pwm[ix];
-		}
 		break;
 	case SYS_PWM_FREQ:
 		res = PWM_FREQ_FROM_REG(data->pwm_freq[ix]);
 		break;
 	case SYS_PWM_ENABLE:
-		if (ix >= 3) {
+		if (ix >= 3)
 			res = 1; /* pwm[5-6] hard-wired to manual mode */
-		} else {
+		else
 			res = PWM_EN_FROM_REG(data->pwm_config[ix]);
-		}
 		break;
 	case SYS_PWM_RAMP_RATE:
 		/* Only valid for pwm[1-3] */
@@ -1192,19 +1190,17 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 		break;
 	case SYS_PWM_AUTO_CHANNELS_ZONE:
 		/* Only valid for pwm[1-3] */
-		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
+		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2)
 			res = PWM_ACZ_FROM_REG(data->pwm_config[ix]);
-		} else {
+		else
 			res = data->pwm_acz[ix];
-		}
 		break;
 	case SYS_PWM_AUTO_PWM_MIN:
 		/* Only valid for pwm[1-3] */
-		if (PWM_OFF_FROM_REG(data->pwm_rr[0], ix)) {
+		if (PWM_OFF_FROM_REG(data->pwm_rr[0], ix))
 			res = data->pwm_min[ix];
-		} else {
+		else
 			res = 0;
-		}
 		break;
 	case SYS_PWM_AUTO_POINT1_PWM:
 		/* Only valid for pwm[1-3] */
@@ -1233,7 +1229,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	switch (fn) {
@@ -1426,7 +1427,12 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	data->vrm = val;
 	return count;
@@ -1975,9 +1981,8 @@ static void dme1737_chmod_group(struct device *dev,
 {
 	struct attribute **attr;
 
-	for (attr = group->attrs; *attr; attr++) {
+	for (attr = group->attrs; *attr; attr++)
 		dme1737_chmod_file(dev, *attr, mode);
-	}
 }
 
 static void dme1737_remove_files(struct device *dev)
@@ -2003,26 +2008,20 @@ static void dme1737_remove_files(struct device *dev)
 		}
 	}
 
-	if (data->has_features & HAS_TEMP_OFFSET) {
+	if (data->has_features & HAS_TEMP_OFFSET)
 		sysfs_remove_group(&dev->kobj, &dme1737_temp_offset_group);
-	}
-	if (data->has_features & HAS_VID) {
+	if (data->has_features & HAS_VID)
 		sysfs_remove_group(&dev->kobj, &dme1737_vid_group);
-	}
-	if (data->has_features & HAS_ZONE3) {
+	if (data->has_features & HAS_ZONE3)
 		sysfs_remove_group(&dev->kobj, &dme1737_zone3_group);
-	}
-	if (data->has_features & HAS_ZONE_HYST) {
+	if (data->has_features & HAS_ZONE_HYST)
 		sysfs_remove_group(&dev->kobj, &dme1737_zone_hyst_group);
-	}
-	if (data->has_features & HAS_IN7) {
+	if (data->has_features & HAS_IN7)
 		sysfs_remove_group(&dev->kobj, &dme1737_in7_group);
-	}
 	sysfs_remove_group(&dev->kobj, &dme1737_group);
 
-	if (!data->client) {
+	if (!data->client)
 		sysfs_remove_file(&dev->kobj, &dev_attr_name.attr);
-	}
 }
 
 static int dme1737_create_files(struct device *dev)
@@ -2033,48 +2032,41 @@ static int dme1737_create_files(struct device *dev)
 	/* Create a name attribute for ISA devices */
 	if (!data->client) {
 		err = sysfs_create_file(&dev->kobj, &dev_attr_name.attr);
-		if (err) {
+		if (err)
 			goto exit;
-		}
 	}
 
 	/* Create standard sysfs attributes */
 	err = sysfs_create_group(&dev->kobj, &dme1737_group);
-	if (err) {
+	if (err)
 		goto exit_remove;
-	}
 
 	/* Create chip-dependent sysfs attributes */
 	if (data->has_features & HAS_TEMP_OFFSET) {
 		err = sysfs_create_group(&dev->kobj,
 					 &dme1737_temp_offset_group);
-		if (err) {
+		if (err)
 			goto exit_remove;
-		}
 	}
 	if (data->has_features & HAS_VID) {
 		err = sysfs_create_group(&dev->kobj, &dme1737_vid_group);
-		if (err) {
+		if (err)
 			goto exit_remove;
-		}
 	}
 	if (data->has_features & HAS_ZONE3) {
 		err = sysfs_create_group(&dev->kobj, &dme1737_zone3_group);
-		if (err) {
+		if (err)
 			goto exit_remove;
-		}
 	}
 	if (data->has_features & HAS_ZONE_HYST) {
 		err = sysfs_create_group(&dev->kobj, &dme1737_zone_hyst_group);
-		if (err) {
+		if (err)
 			goto exit_remove;
-		}
 	}
 	if (data->has_features & HAS_IN7) {
 		err = sysfs_create_group(&dev->kobj, &dme1737_in7_group);
-		if (err) {
+		if (err)
 			goto exit_remove;
-		}
 	}
 
 	/* Create fan sysfs attributes */
@@ -2082,9 +2074,8 @@ static int dme1737_create_files(struct device *dev)
 		if (data->has_features & HAS_FAN(ix)) {
 			err = sysfs_create_group(&dev->kobj,
 						 &dme1737_fan_group[ix]);
-			if (err) {
+			if (err)
 				goto exit_remove;
-			}
 		}
 	}
 
@@ -2093,15 +2084,13 @@ static int dme1737_create_files(struct device *dev)
 		if (data->has_features & HAS_PWM(ix)) {
 			err = sysfs_create_group(&dev->kobj,
 						 &dme1737_pwm_group[ix]);
-			if (err) {
+			if (err)
 				goto exit_remove;
-			}
 			if ((data->has_features & HAS_PWM_MIN) && (ix < 3)) {
 				err = sysfs_create_file(&dev->kobj,
 						dme1737_auto_pwm_min_attr[ix]);
-				if (err) {
+				if (err)
 					goto exit_remove;
-				}
 			}
 		}
 	}
@@ -2199,16 +2188,14 @@ static int dme1737_init_device(struct device *dev)
 	if (client) {   /* I2C chip */
 		data->config2 = dme1737_read(data, DME1737_REG_CONFIG2);
 		/* Check if optional fan3 input is enabled */
-		if (data->config2 & 0x04) {
+		if (data->config2 & 0x04)
 			data->has_features |= HAS_FAN(2);
-		}
 
 		/* Fan4 and pwm3 are only available if the client's I2C address
 		 * is the default 0x2e. Otherwise the I/Os associated with
 		 * these functions are used for addr enable/select. */
-		if (client->addr = 0x2e) {
+		if (client->addr = 0x2e)
 			data->has_features |= HAS_FAN(3) | HAS_PWM(2);
-		}
 
 		/* Determine which of the optional fan[5-6] and pwm[5-6]
 		 * features are enabled. For this, we need to query the runtime
@@ -2298,9 +2285,8 @@ static int dme1737_init_device(struct device *dev)
 	data->pwm_acz[2] = 4;	/* pwm3 -> zone3 */
 
 	/* Set VRM */
-	if (data->has_features & HAS_VID) {
+	if (data->has_features & HAS_VID)
 		data->vrm = vid_which_vrm();
-	}
 
 	return 0;
 }
@@ -2341,18 +2327,14 @@ static int dme1737_i2c_get_features(int sio_cip, struct dme1737_data *data)
 	/* Read the runtime registers to determine which optional features
 	 * are enabled and available. Bits [3:2] of registers 0x43-0x46 are set
 	 * to '10' if the respective feature is enabled. */
-	if ((inb(addr + 0x43) & 0x0c) = 0x08) { /* fan6 */
+	if ((inb(addr + 0x43) & 0x0c) = 0x08) /* fan6 */
 		data->has_features |= HAS_FAN(5);
-	}
-	if ((inb(addr + 0x44) & 0x0c) = 0x08) { /* pwm6 */
+	if ((inb(addr + 0x44) & 0x0c) = 0x08) /* pwm6 */
 		data->has_features |= HAS_PWM(5);
-	}
-	if ((inb(addr + 0x45) & 0x0c) = 0x08) { /* fan5 */
+	if ((inb(addr + 0x45) & 0x0c) = 0x08) /* fan5 */
 		data->has_features |= HAS_FAN(4);
-	}
-	if ((inb(addr + 0x46) & 0x0c) = 0x08) { /* pwm5 */
+	if ((inb(addr + 0x46) & 0x0c) = 0x08) /* pwm5 */
 		data->has_features |= HAS_PWM(4);
-	}
 
 exit:
 	dme1737_sio_exit(sio_cip);
@@ -2369,9 +2351,8 @@ static int dme1737_i2c_detect(struct i2c_client *client,
 	u8 company, verstep = 0;
 	const char *name;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	company = i2c_smbus_read_byte_data(client, DME1737_REG_COMPANY);
 	verstep = i2c_smbus_read_byte_data(client, DME1737_REG_VERSTEP);
@@ -2610,11 +2591,10 @@ static int __devinit dme1737_isa_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (data->type = sch5127) {
+	if (data->type = sch5127)
 		data->name = "sch5127";
-	} else {
+	else
 		data->name = "sch311x";
-	}
 
 	/* Initialize the mutex */
 	mutex_init(&data->update_lock);
@@ -2689,9 +2669,8 @@ static int __init dme1737_init(void)
 	unsigned short addr;
 
 	err = i2c_add_driver(&dme1737_i2c_driver);
-	if (err) {
+	if (err)
 		goto exit;
-	}
 
 	if (dme1737_isa_detect(0x2e, &addr) &&
 	    dme1737_isa_detect(0x4e, &addr) &&
@@ -2703,15 +2682,13 @@ static int __init dme1737_init(void)
 	}
 
 	err = platform_driver_register(&dme1737_isa_driver);
-	if (err) {
+	if (err)
 		goto exit_del_i2c_driver;
-	}
 
 	/* Sets global pdev as a side effect */
 	err = dme1737_isa_device_add(addr);
-	if (err) {
+	if (err)
 		goto exit_del_isa_driver;
-	}
 
 	return 0;
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
