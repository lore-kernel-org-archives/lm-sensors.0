From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:40 +0000
Subject: [lm-sensors] [PATCH 61/79] hwmon: (w83627hf) Fix checkpatch issues
Message-Id: <1327373398-997-62-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
ERROR: do not use assignment in if condition

Modify multi-line comments to follow Documentation/CodingStyle.

Other checkpatch issues not fixed to reduce number of conflicts with pending
rewrite as mfd driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |  264 ++++++++++++++++++++++++++++++----------------
 1 files changed, 174 insertions(+), 90 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index ca4d378..5ce54a2 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1,43 +1,43 @@
 /*
-    w83627hf.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
-    Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    and Mark Studebaker <mdsxyz123@yahoo.com>
-    Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
-    Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * w83627hf.c - Part of lm_sensors, Linux kernel modules for hardware
+ *		monitoring
+ * Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
+ *			      Philip Edelbrock <phil@netroedge.com>,
+ *			      and Mark Studebaker <mdsxyz123@yahoo.com>
+ * Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
+ * Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
-    w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
-    w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
-    w83687thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
-
-    For other winbond chips, and for i2c support in the above chips,
-    use w83781d.c.
-
-    Note: automatic ("cruise") fan control for 697, 637 & 627thf not
-    supported yet.
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
+ * w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
+ * w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
+ * w83687thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
+ * w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
+ *
+ * For other winbond chips, and for i2c support in the above chips,
+ * use w83781d.c.
+ *
+ * Note: automatic ("cruise") fan control for 697, 637 & 627thf not
+ * supported yet.
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -80,7 +80,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 /* modified from kernel/include/traps.c */
-#define	DEV	0x07	/* Register: Logical device select */
+#define DEV			0x07 /* Register: Logical device select */
 
 /* logical device numbers for superio_select (below) */
 #define W83627HF_LD_FDC		0x00
@@ -99,7 +99,7 @@ MODULE_PARM_DESC(force_id, "Override the detected device ID");
 #define W83627HF_LD_ACPI	0x0a
 #define W83627HF_LD_HWM		0x0b
 
-#define	DEVID	0x20	/* Register: Device ID */
+#define DEVID			0x20 /* Register: Device ID */
 
 #define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
 #define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
@@ -248,10 +248,12 @@ static const u8 BIT_SCFG1[] = { 0x02, 0x04, 0x08 };
 static const u8 BIT_SCFG2[] = { 0x10, 0x20, 0x40 };
 #define W83781D_DEFAULT_BETA 3435
 
-/* Conversions. Limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
+/*
+ * Conversions. Limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
+ * Fixing this is just not worth it.
+ */
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
 #define IN_FROM_REG(val) ((val) * 16)
 
@@ -267,8 +269,10 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 #define TEMP_MIN (-128000)
 #define TEMP_MAX ( 127000)
 
-/* TEMP: 0.001C/bit (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 0.001C/bit (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static u8 TEMP_TO_REG(long temp)
 {
         int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
@@ -294,8 +298,10 @@ static inline unsigned long pwm_freq_from_reg_627hf(u8 reg)
 static inline u8 pwm_freq_to_reg_627hf(unsigned long val)
 {
 	u8 i;
-	/* Only 5 dividers (1 2 4 8 16)
-	   Search for the nearest available frequency */
+	/*
+	 * Only 5 dividers (1 2 4 8 16)
+	 * Search for the nearest available frequency
+	 */
 	for (i = 0; i < 4; i++) {
 		if (val > (((W83627HF_BASE_PWM_FREQ >> i) +
 			    (W83627HF_BASE_PWM_FREQ >> (i+1))) / 2))
@@ -345,8 +351,10 @@ static inline u8 DIV_TO_REG(long val)
 	return (u8)i;
 }
 
-/* For each registered chip, we need to keep some data in memory.
-   The structure is dynamically allocated. */
+/*
+ * For each registered chip, we need to keep some data in memory.
+ * The structure is dynamically allocated.
+ */
 struct w83627hf_data {
 	unsigned short addr;
 	const char *name;
@@ -372,11 +380,13 @@ struct w83627hf_data {
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 pwm[3];		/* Register value */
 	u8 pwm_enable[3];	/* 1 = manual
-				   2 = thermal cruise (also called SmartFan I)
-				   3 = fan speed cruise */
+				 * 2 = thermal cruise (also called SmartFan I)
+				 * 3 = fan speed cruise
+				 */
 	u8 pwm_freq[3];		/* Register value */
 	u16 sens[3];		/* 1 = pentium diode; 2 = 3904 diode;
-				   4 = thermistor */
+				 * 4 = thermistor
+				 */
 	u8 vrm;
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
@@ -427,7 +437,12 @@ store_in_min(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -441,7 +456,12 @@ store_in_max(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -506,9 +526,12 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
 	const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	
@@ -533,9 +556,12 @@ static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *a
 	const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -584,7 +610,12 @@ store_fan_min(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -645,9 +676,15 @@ store_temp_max(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
-	u16 tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
+	u16 tmp;
+	long val;
+	int err;
 
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
+	tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = tmp;
 	w83627hf_write_value(data, w83627hf_reg_temp_over[nr], tmp);
@@ -661,9 +698,15 @@ store_temp_max_hyst(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
-	u16 tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
+	u16 tmp;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
+	tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
 	mutex_lock(&data->update_lock);
 	data->temp_max_hyst[nr] = tmp;
 	w83627hf_write_value(data, w83627hf_reg_temp_hyst[nr], tmp);
@@ -701,9 +744,12 @@ static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 	data->vrm = val;
 
 	return count;
@@ -755,8 +801,11 @@ store_beep_mask(struct device *dev, struct device_attribute *attr,
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -791,10 +840,14 @@ store_beep(struct device *dev, struct device_attribute *attr,
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
-	unsigned long bit;
 	u8 reg;
+	unsigned long bit;
+	int err;
+
+	err = kstrtoul(buf, 10, &bit);
+	if (err)
+		return err;
 
-	bit = simple_strtoul(buf, NULL, 10);
 	if (bit & ~1)
 		return -EINVAL;
 
@@ -872,10 +925,12 @@ show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%ld\n",
 		       (long) DIV_FROM_REG(data->fan_div[nr]));
 }
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan divisor.  This follows the principle of
-   least surprise; the user doesn't expect the fan minimum to change just
-   because the divisor changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan divisor.  This follows the principle of
+ * least surprise; the user doesn't expect the fan minimum to change just
+ * because the divisor changed.
+ */
 static ssize_t
 store_fan_div(struct device *dev, struct device_attribute *devattr,
 	      const char *buf, size_t count)
@@ -884,7 +939,12 @@ store_fan_div(struct device *dev, struct device_attribute *devattr,
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long min;
 	u8 reg;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -933,7 +993,12 @@ store_pwm(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -974,10 +1039,15 @@ store_pwm_enable(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	if (!val || (val > 3))	/* modes 1, 2 and 3 are supported */
+	if (!val || val > 3)	/* modes 1, 2 and 3 are supported */
 		return -EINVAL;
 	mutex_lock(&data->update_lock);
 	data->pwm_enable[nr] = val;
@@ -1016,9 +1086,12 @@ store_pwm_freq(struct device *dev, struct device_attribute *devattr,
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	static const u8 mask[]={0xF8, 0x8F};
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -1060,9 +1133,13 @@ store_temp_type(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val, tmp;
+	unsigned long val;
+	u32 tmp;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -1290,7 +1367,8 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 		goto ERROR0;
 	}
 
-	if (!(data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
@@ -1311,7 +1389,8 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	w83627hf_update_fan_div(data);
 
 	/* Register common device attributes */
-	if ((err = sysfs_create_group(&dev->kobj, &w83627hf_group)))
+	err = sysfs_create_group(&dev->kobj, &w83627hf_group);
+	if (err)
 		goto ERROR3;
 
 	/* Register chip-specific device attributes */
@@ -1387,10 +1466,11 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	}
 
 	if (data->type = w83627thf || data->type = w83637hf
-	 || data->type = w83687thf)
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm3.dev_attr)))
+	    || data->type = w83687thf) {
+		err = device_create_file(dev, &sensor_dev_attr_pwm3.dev_attr);
+		if (err)
 			goto ERROR4;
+	}
 
 	if (data->type = w83637hf || data->type = w83687thf)
 		if ((err = device_create_file(dev,
@@ -1409,10 +1489,12 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 			goto ERROR4;
 
 	if (data->type = w83627thf || data->type = w83637hf
-	 || data->type = w83687thf)
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm3_enable.dev_attr)))
+	    || data->type = w83687thf) {
+		err = device_create_file(dev,
+					 &sensor_dev_attr_pwm3_enable.dev_attr);
+		if (err)
 			goto ERROR4;
+	}
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1510,8 +1592,10 @@ static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
 		goto exit;
 	}
 
-	/* Make sure the pins are configured for input
-	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
+	/*
+	 * Make sure the pins are configured for input
+	 * There must be at least five (VRM 9), and possibly 6 (VRM 10)
+	 */
 	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
 		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
