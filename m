From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:33 +0000
Subject: [lm-sensors] [PATCH 54/79] hwmon: (vt1211) Fix checkpatch issues
Message-Id: <1327373398-997-55-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: do not use assignment in if condition
ERROR: switch and case should be at the same indent
ERROR: trailing statements should be on next line
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Not all fixed (code complexity):
ERROR: do not use assignment in if condition

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt1211.c |  162 ++++++++++++++++++++++++++++++------------------
 1 files changed, 102 insertions(+), 60 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 49163d4..5de5f72 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -151,8 +151,10 @@ struct vt1211_data {
 #define ISTEMP(ix, uch_config)	((ix) < 2 ? 1 : \
 				 ((uch_config) >> (ix)) & 1)
 
-/* in5 (ix = 5) is special. It's the internal 3.3V so it's scaled in the
-   driver according to the VT1211 BIOS porting guide */
+/*
+ * in5 (ix = 5) is special. It's the internal 3.3V so it's scaled in the
+ * driver according to the VT1211 BIOS porting guide
+ */
 #define IN_FROM_REG(ix, reg)	((reg) < 3 ? 0 : (ix) = 5 ? \
 				 (((reg) - 3) * 15882 + 479) / 958 : \
 				 (((reg) - 3) * 10000 + 479) / 958)
@@ -160,11 +162,13 @@ struct vt1211_data {
 				 ((val) * 958 + 7941) / 15882 + 3 : \
 				 ((val) * 958 + 5000) / 10000 + 3, 0, 255))
 
-/* temp1 (ix = 0) is an intel thermal diode which is scaled in user space.
-   temp2 (ix = 1) is the internal temp diode so it's scaled in the driver
-   according to some measurements that I took on an EPIA M10000.
-   temp3-7 are thermistor based so the driver returns the voltage measured at
-   the pin (range 0V - 2.2V). */
+/*
+ * temp1 (ix = 0) is an intel thermal diode which is scaled in user space.
+ * temp2 (ix = 1) is the internal temp diode so it's scaled in the driver
+ * according to some measurements that I took on an EPIA M10000.
+ * temp3-7 are thermistor based so the driver returns the voltage measured at
+ * the pin (range 0V - 2.2V).
+ */
 #define TEMP_FROM_REG(ix, reg)	((ix) = 0 ? (reg) * 1000 : \
 				 (ix) = 1 ? (reg) < 51 ? 0 : \
 				 ((reg) - 51) * 1000 : \
@@ -186,8 +190,10 @@ struct vt1211_data {
  * Super-I/O constants and functions
  * --------------------------------------------------------------------- */
 
-/* Configuration index port registers
- * The vt1211 can live at 2 different addresses so we need to probe both */
+/*
+ * Configuration index port registers
+ * The vt1211 can live at 2 different addresses so we need to probe both
+ */
 #define SIO_REG_CIP1		0x2e
 #define SIO_REG_CIP2		0x4e
 
@@ -377,7 +383,12 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
 						to_sensor_dev_attr_2(attr);
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
@@ -446,7 +457,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 						to_sensor_dev_attr_2(attr);
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
@@ -517,8 +533,13 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 						to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
 	int reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -536,16 +557,23 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 		break;
 	case SHOW_SET_FAN_DIV:
 		switch (val) {
-			case 1: data->fan_div[ix] = 0; break;
-			case 2: data->fan_div[ix] = 1; break;
-			case 4: data->fan_div[ix] = 2; break;
-			case 8: data->fan_div[ix] = 3; break;
-			default:
-				count = -EINVAL;
-				dev_warn(dev, "fan div value %ld not "
-					 "supported. Choose one of 1, 2, "
-					 "4, or 8.\n", val);
-				goto EXIT;
+		case 1:
+			data->fan_div[ix] = 0;
+			break;
+		case 2:
+			data->fan_div[ix] = 1;
+			break;
+		case 4:
+			data->fan_div[ix] = 2;
+			break;
+		case 8:
+			data->fan_div[ix] = 3;
+			break;
+		default:
+			count = -EINVAL;
+			dev_warn(dev, "fan div value %ld not supported. "
+				 "Choose one of 1, 2, 4, or 8.\n", val);
+			goto EXIT;
 		}
 		vt1211_write8(data, VT1211_REG_FAN_DIV,
 			      ((data->fan_div[1] << 6) |
@@ -610,8 +638,13 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 						to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int fn = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
 	int tmp, reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -628,11 +661,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		switch (val) {
 		case 0:
 			data->pwm_ctl[ix] &= 7;
-			/* disable SmartGuardian if both PWM outputs are
-			 * disabled */
-			if ((data->pwm_ctl[ix ^ 1] & 1) = 0) {
+			/*
+			 * disable SmartGuardian if both PWM outputs are
+			 * disabled
+			 */
+			if ((data->pwm_ctl[ix ^ 1] & 1) = 0)
 				data->fan_ctl &= 0xe;
-			}
 			break;
 		case 2:
 			data->pwm_ctl[ix] |= 8;
@@ -656,16 +690,15 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		val = 135000 / SENSORS_LIMIT(val, 135000 >> 7, 135000);
 		/* calculate tmp = log2(val) */
 		tmp = 0;
-		for (val >>= 1; val > 0; val >>= 1) {
+		for (val >>= 1; val > 0; val >>= 1)
 			tmp++;
-		}
 		/* sync the data cache */
 		reg = vt1211_read8(data, VT1211_REG_PWM_CLK);
 		data->pwm_clk = (reg & 0xf8) | tmp;
 		vt1211_write8(data, VT1211_REG_PWM_CLK, data->pwm_clk);
 		break;
 	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
-		if ((val < 1) || (val > 7)) {
+		if (val < 1 || val > 7) {
 			count = -EINVAL;
 			dev_warn(dev, "temp channel %ld not supported. "
 				 "Choose a value between 1 and 7.\n", val);
@@ -741,8 +774,14 @@ static ssize_t set_pwm_auto_point_temp(struct device *dev,
 						to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int ap = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
 	int reg;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
 
 	mutex_lock(&data->update_lock);
 
@@ -774,7 +813,7 @@ static ssize_t set_pwm_auto_point_temp(struct device *dev,
  * 1  1  : pwm2 low speed duty cycle  (pwm_auto_pwm[1][1])
  * 1  2  : pwm2 high speed duty cycle (pwm_auto_pwm[1][2])
  * 1  3  : pwm2 full speed            (pwm_auto_pwm[1][3], hard-wired to 255)
-*/
+ */
 
 static ssize_t show_pwm_auto_point_pwm(struct device *dev,
 				       struct device_attribute *attr,
@@ -798,16 +837,15 @@ static ssize_t set_pwm_auto_point_pwm(struct device *dev,
 						to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
 	int ap = sensor_attr_2->nr;
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
 
-	if ((val < 0) || (val > 255)) {
-		dev_err(dev, "pwm value %ld is out of range. "
-			"Choose a value between 0 and 255.\n" , val);
-		return -EINVAL;
-	}
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	data->pwm_auto_pwm[ix][ap] = val;
+	data->pwm_auto_pwm[ix][ap] = SENSORS_LIMIT(val, 0, 255);
 	vt1211_write8(data, VT1211_REG_PWM_AUTO_PWM(ix, ap),
 		      data->pwm_auto_pwm[ix][ap]);
 	mutex_unlock(&data->update_lock);
@@ -831,7 +869,12 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
 	struct vt1211_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	data->vrm = val;
 
@@ -1069,7 +1112,8 @@ static void __devinit vt1211_init_device(struct vt1211_data *data)
 		vt1211_write8(data, VT1211_REG_UCH_CONFIG, data->uch_config);
 	}
 
-	/* Initialize the interrupt mode (if request at module load time).
+	/*
+	 * Initialize the interrupt mode (if request at module load time).
 	 * The VT1211 implements 3 different modes for clearing interrupts:
 	 * 0: Clear INT when status register is read. Regenerate INT as long
 	 *    as temp stays above hysteresis limit.
@@ -1079,7 +1123,8 @@ static void __devinit vt1211_init_device(struct vt1211_data *data)
 	 * 2: Clear INT when temp falls below max limit.
 	 *
 	 * The driver only allows to force mode 0 since that's the only one
-	 * that makes sense for 'sensors' */
+	 * that makes sense for 'sensors'
+	 */
 	if (int_mode = 0) {
 		vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0);
 		vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0);
@@ -1119,9 +1164,8 @@ static void vt1211_remove_sysfs(struct platform_device *pdev)
 		device_remove_file(dev,
 			&vt1211_sysfs_fan_pwm[i].dev_attr);
 	}
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
+	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++)
 		device_remove_file(dev, &vt1211_sysfs_misc[i]);
-	}
 }
 
 static int __devinit vt1211_probe(struct platform_device *pdev)
@@ -1131,7 +1175,8 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, err;
 
-	if (!(data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		dev_err(dev, "Out of memory\n");
 		goto EXIT;
@@ -1185,16 +1230,14 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_fan_pwm); i++) {
 		err = device_create_file(dev,
 			&vt1211_sysfs_fan_pwm[i].dev_attr);
-		if (err) {
+		if (err)
 			goto EXIT_DEV_REMOVE;
-		}
 	}
 	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
 		err = device_create_file(dev,
 		       &vt1211_sysfs_misc[i]);
-		if (err) {
+		if (err)
 			goto EXIT_DEV_REMOVE;
-		}
 	}
 
 	/* Register device */
@@ -1293,9 +1336,8 @@ static int __init vt1211_find(int sio_cip, unsigned short *address)
 	superio_enter(sio_cip);
 
 	devid = force_id ? force_id : superio_inb(sio_cip, SIO_VT1211_DEVID);
-	if (devid != SIO_VT1211_ID) {
+	if (devid != SIO_VT1211_ID)
 		goto EXIT;
-	}
 
 	superio_select(sio_cip, SIO_VT1211_LDN_HWMON);
 
@@ -1325,35 +1367,35 @@ static int __init vt1211_init(void)
 	int err;
 	unsigned short address = 0;
 
-	if ((err = vt1211_find(SIO_REG_CIP1, &address)) &&
-	    (err = vt1211_find(SIO_REG_CIP2, &address))) {
-		goto EXIT;
+	err = vt1211_find(SIO_REG_CIP1, &address);
+	if (err) {
+		err = vt1211_find(SIO_REG_CIP2, &address);
+		if (err)
+			goto EXIT;
 	}
 
 	if ((uch_config < -1) || (uch_config > 31)) {
 		err = -EINVAL;
 		pr_warn("Invalid UCH configuration %d. "
 			"Choose a value between 0 and 31.\n", uch_config);
-	  goto EXIT;
+		goto EXIT;
 	}
 
 	if ((int_mode < -1) || (int_mode > 0)) {
 		err = -EINVAL;
 		pr_warn("Invalid interrupt mode %d. "
 			"Only mode 0 is supported.\n", int_mode);
-	  goto EXIT;
+		goto EXIT;
 	}
 
 	err = platform_driver_register(&vt1211_driver);
-	if (err) {
+	if (err)
 		goto EXIT;
-	}
 
 	/* Sets global pdev as a side effect */
 	err = vt1211_device_add(address);
-	if (err) {
+	if (err)
 		goto EXIT_DRV_UNREGISTER;
-	}
 
 	return 0;
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
