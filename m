From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:34 +0000
Subject: [lm-sensors] [PATCH 32/39] hwmon: (vt1211) Fix checkpatch issues
Message-Id: <1326703781-14272-33-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: switch and case should be at the same indent
ERROR: trailing statements should be on next line
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Not all fixed (code complexity):
ERROR: do not use assignment in if condition

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt1211.c |  126 ++++++++++++++++++++++++++++++------------------
 1 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 49163d4..7ca0ebe 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -377,7 +377,12 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
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
@@ -446,7 +451,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
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
@@ -517,8 +527,13 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
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
 
@@ -536,16 +551,23 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
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
@@ -610,8 +632,13 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
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
 
@@ -630,9 +657,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 			data->pwm_ctl[ix] &= 7;
 			/* disable SmartGuardian if both PWM outputs are
 			 * disabled */
-			if ((data->pwm_ctl[ix ^ 1] & 1) = 0) {
+			if ((data->pwm_ctl[ix ^ 1] & 1) = 0)
 				data->fan_ctl &= 0xe;
-			}
 			break;
 		case 2:
 			data->pwm_ctl[ix] |= 8;
@@ -656,16 +682,15 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
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
@@ -741,8 +766,14 @@ static ssize_t set_pwm_auto_point_temp(struct device *dev,
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
 
@@ -798,16 +829,15 @@ static ssize_t set_pwm_auto_point_pwm(struct device *dev,
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
@@ -831,9 +861,14 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
 	struct vt1211_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
 
-	data->vrm = val;
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 
 	return count;
 }
@@ -1119,9 +1154,8 @@ static void vt1211_remove_sysfs(struct platform_device *pdev)
 		device_remove_file(dev,
 			&vt1211_sysfs_fan_pwm[i].dev_attr);
 	}
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
+	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++)
 		device_remove_file(dev, &vt1211_sysfs_misc[i]);
-	}
 }
 
 static int __devinit vt1211_probe(struct platform_device *pdev)
@@ -1131,7 +1165,8 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, err;
 
-	if (!(data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		dev_err(dev, "Out of memory\n");
 		goto EXIT;
@@ -1185,16 +1220,14 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
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
@@ -1293,9 +1326,8 @@ static int __init vt1211_find(int sio_cip, unsigned short *address)
 	superio_enter(sio_cip);
 
 	devid = force_id ? force_id : superio_inb(sio_cip, SIO_VT1211_DEVID);
-	if (devid != SIO_VT1211_ID) {
+	if (devid != SIO_VT1211_ID)
 		goto EXIT;
-	}
 
 	superio_select(sio_cip, SIO_VT1211_LDN_HWMON);
 
@@ -1325,35 +1357,35 @@ static int __init vt1211_init(void)
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
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
