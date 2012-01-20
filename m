From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 Jan 2012 15:38:31 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (it87) Fix multi-line comments
Message-Id: <1327073911-26882-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fix multi-line comments, and clean up some of the affected comments.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Some additional comment cleanup

 drivers/hwmon/it87.c |  170 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 108 insertions(+), 62 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 0054d6f..93a197b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -176,12 +176,16 @@ static bool fix_pwm_polarity;
 #define IT87_REG_ALARM2        0x02
 #define IT87_REG_ALARM3        0x03
 
-/* The IT8718F and IT8720F have the VID value in a different register, in
-   Super-I/O configuration space. */
+/*
+ * The IT8718F and IT8720F have the VID value in a different register, in
+ * Super-I/O configuration space.
+ */
 #define IT87_REG_VID           0x0a
-/* The IT8705F and IT8712F earlier than revision 0x08 use register 0x0b
-   for fan divisors. Later IT8712F revisions must use 16-bit tachometer
-   mode. */
+/*
+ * The IT8705F and IT8712F earlier than revision 0x08 use register 0x0b
+ * for fan divisors. Later IT8712F revisions must use 16-bit tachometer
+ * mode.
+ */
 #define IT87_REG_FAN_DIV       0x0b
 #define IT87_REG_FAN_16BIT     0x0c
 
@@ -227,8 +231,10 @@ struct it87_sio_data {
 	u8 skip_pwm;
 };
 
-/* For each registered chip, we need to keep some data in memory.
-   The structure is dynamically allocated. */
+/*
+ * For each registered chip, we need to keep some data in memory.
+ * The structure is dynamically allocated.
+ */
 struct it87_data {
 	struct device *hwmon_dev;
 	enum chips type;
@@ -259,14 +265,16 @@ struct it87_data {
 	u8 fan_main_ctrl;	/* Register value */
 	u8 fan_ctl;		/* Register value */
 
-	/* The following 3 arrays correspond to the same registers up to
+	/*
+	 * The following 3 arrays correspond to the same registers up to
 	 * the IT8720F. The meaning of bits 6-0 depends on the value of bit
 	 * 7, and we want to preserve settings on mode changes, so we have
 	 * to track all values separately.
 	 * Starting with the IT8721F, the manual PWM duty cycles are stored
 	 * in separate registers (8-bit values), so the separate tracking
 	 * is no longer needed, but it is still done to keep the driver
-	 * simple. */
+	 * simple.
+	 */
 	u8 pwm_ctrl[3];		/* Register value */
 	u8 pwm_duty[3];		/* Manual PWM value set by user */
 	u8 pwm_temp_map[3];	/* PWM to temp. chan. mapping (bits 1-0) */
@@ -388,9 +396,11 @@ static const unsigned int pwm_freq[8] = {
 
 static inline int has_16bit_fans(const struct it87_data *data)
 {
-	/* IT8705F Datasheet 0.4.1, 3h = Version G.
-	   IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
-	   These are the first revisions with 16bit tachometer support. */
+	/*
+	 * IT8705F Datasheet 0.4.1, 3h = Version G.
+	 * IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
+	 * These are the first revisions with 16-bit tachometer support.
+	 */
 	return (data->type = it87 && data->revision >= 0x03)
 	    || (data->type = it8712 && data->revision >= 0x08)
 	    || data->type = it8716
@@ -402,9 +412,11 @@ static inline int has_16bit_fans(const struct it87_data *data)
 
 static inline int has_old_autopwm(const struct it87_data *data)
 {
-	/* The old automatic fan speed control interface is implemented
-	   by IT8705F chips up to revision F and IT8712F chips up to
-	   revision G. */
+	/*
+	 * The old automatic fan speed control interface is implemented
+	 * by IT8705F chips up to revision F and IT8712F chips up to
+	 * revision G.
+	 */
 	return (data->type = it87 && data->revision < 0x03)
 	    || (data->type = it8712 && data->revision < 0x08);
 }
@@ -606,10 +618,8 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-
 	struct it87_data *data = it87_update_device(dev);
-	u8 reg = data->sensor;		/* In case the value is updated while
-					   we use it */
+	u8 reg = data->sensor;	    /* In case value is updated while used */
 
 	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
@@ -894,8 +904,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	if (has_newer_autopwm(data)) {
-		/* If we are in automatic mode, the PWM duty cycle register
-		 * is read-only so we can't write the value */
+		/*
+		 * If we are in automatic mode, the PWM duty cycle register
+		 * is read-only so we can't write the value.
+		 */
 		if (data->pwm_ctrl[nr] & 0x80) {
 			mutex_unlock(&data->update_lock);
 			return -EBUSY;
@@ -905,8 +917,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 				 data->pwm_duty[nr]);
 	} else {
 		data->pwm_duty[nr] = pwm_to_reg(data, val);
-		/* If we are in manual mode, write the duty cycle immediately;
-		 * otherwise, just store it for later use. */
+		/*
+		 * If we are in manual mode, write the duty cycle immediately;
+		 * otherwise, just store it for later use.
+		 */
 		if (!(data->pwm_ctrl[nr] & 0x80)) {
 			data->pwm_ctrl[nr] = data->pwm_duty[nr];
 			it87_write_value(data, IT87_REG_PWM(nr),
@@ -965,8 +979,10 @@ static ssize_t set_pwm_temp_map(struct device *dev,
 	long val;
 	u8 reg;
 
-	/* This check can go away if we ever support automatic fan speed
-	   control on newer chips. */
+	/*
+	 * This check can go away if we ever support automatic fan speed
+	 * control on newer chips.
+	 */
 	if (!has_old_autopwm(data)) {
 		dev_notice(dev, "Mapping change disabled for safety reasons\n");
 		return -EINVAL;
@@ -991,8 +1007,10 @@ static ssize_t set_pwm_temp_map(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->pwm_temp_map[nr] = reg;
-	/* If we are in automatic mode, write the temp mapping immediately;
-	 * otherwise, just store it for later use. */
+	/*
+	 * If we are in automatic mode, write the temp mapping immediately;
+	 * otherwise, just store it for later use.
+	 */
 	if (data->pwm_ctrl[nr] & 0x80) {
 		data->pwm_ctrl[nr] = 0x80 | data->pwm_temp_map[nr];
 		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
@@ -1162,9 +1180,11 @@ static ssize_t set_fan16_min(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* We want to use the same sysfs file names as 8-bit fans, but we need
-   different variable names, so we have to use SENSOR_ATTR instead of
-   SENSOR_DEVICE_ATTR. */
+/*
+ * We want to use the same sysfs file names as 8-bit fans, but we need
+ * different variable names, so we have to use SENSOR_ATTR instead of
+ * SENSOR_DEVICE_ATTR.
+ */
 #define show_fan16_offset(offset) \
 static struct sensor_device_attribute sensor_dev_attr_fan##offset##_input16 \
 	= SENSOR_ATTR(fan##offset##_input, S_IRUGO,		\
@@ -1736,12 +1756,14 @@ static int __init it87_find(unsigned short *address,
 	if (board_vendor && board_name) {
 		if (strcmp(board_vendor, "nVIDIA") = 0
 		 && strcmp(board_name, "FN68PT") = 0) {
-			/* On the Shuttle SN68PT, FAN_CTL2 is apparently not
-			   connected to a fan, but to something else. One user
-			   has reported instant system power-off when changing
-			   the PWM2 duty cycle, so we disable it.
-			   I use the board name string as the trigger in case
-			   the same board is ever used in other systems. */
+			/*
+			 * On the Shuttle SN68PT, FAN_CTL2 is apparently not
+			 * connected to a fan, but to something else. One user
+			 * has reported instant system power-off when changing
+			 * the PWM2 duty cycle, so we disable it.
+			 * I use the board name string as the trigger in case
+			 * the same board is ever used in other systems.
+			 */
 			pr_info("Disabling pwm2 due to hardware constraints\n");
 			sio_data->skip_pwm = (1 << 1);
 		}
@@ -1879,9 +1901,11 @@ static int __devinit it87_probe(struct platform_device *pdev)
 			if (!fan_beep_need_rw)
 				continue;
 
-			/* As we have a single beep enable bit for all fans,
+			/*
+			 * As we have a single beep enable bit for all fans,
 			 * only the first enabled fan has a writable attribute
-			 * for it. */
+			 * for it.
+			 */
 			if (sysfs_chmod_file(&dev->kobj,
 					     it87_attributes_fan_beep[i],
 					     S_IRUGO | S_IWUSR))
@@ -1961,18 +1985,22 @@ static int __devexit it87_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* Must be called with data->update_lock held, except during initialization.
-   We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the IT87 access and should not be necessary. */
+/*
+ * Must be called with data->update_lock held, except during initialization.
+ * We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
+ * would slow down the IT87 access and should not be necessary.
+ */
 static int it87_read_value(struct it87_data *data, u8 reg)
 {
 	outb_p(reg, data->addr + IT87_ADDR_REG_OFFSET);
 	return inb_p(data->addr + IT87_DATA_REG_OFFSET);
 }
 
-/* Must be called with data->update_lock held, except during initialization.
-   We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the IT87 access and should not be necessary. */
+/*
+ * Must be called with data->update_lock held, except during initialization.
+ * We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
+ * would slow down the IT87 access and should not be necessary.
+ */
 static void it87_write_value(struct it87_data *data, u8 reg, u8 value)
 {
 	outb_p(reg, data->addr + IT87_ADDR_REG_OFFSET);
@@ -1983,15 +2011,19 @@ static void it87_write_value(struct it87_data *data, u8 reg, u8 value)
 static int __devinit it87_check_pwm(struct device *dev)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
-	/* Some BIOSes fail to correctly configure the IT87 fans. All fans off
+	/*
+	 * Some BIOSes fail to correctly configure the IT87 fans. All fans off
 	 * and polarity set to active low is sign that this is the case so we
-	 * disable pwm control to protect the user. */
+	 * disable pwm control to protect the user.
+	 */
 	int tmp = it87_read_value(data, IT87_REG_FAN_CTL);
 	if ((tmp & 0x87) = 0) {
 		if (fix_pwm_polarity) {
-			/* The user asks us to attempt a chip reconfiguration.
+			/*
+			 * The user asks us to attempt a chip reconfiguration.
 			 * This means switching to active high polarity and
-			 * inverting all fan speed values. */
+			 * inverting all fan speed values.
+			 */
 			int i;
 			u8 pwm[3];
 
@@ -1999,10 +2031,12 @@ static int __devinit it87_check_pwm(struct device *dev)
 				pwm[i] = it87_read_value(data,
 							 IT87_REG_PWM(i));
 
-			/* If any fan is in automatic pwm mode, the polarity
+			/*
+			 * If any fan is in automatic pwm mode, the polarity
 			 * might be correct, as suspicious as it seems, so we
 			 * better don't change anything (but still disable the
-			 * PWM interface). */
+			 * PWM interface).
+			 */
 			if (!((pwm[0] | pwm[1] | pwm[2]) & 0x80)) {
 				dev_info(dev, "Reconfiguring PWM to "
 					 "active high polarity\n");
@@ -2038,7 +2072,8 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 	int tmp, i;
 	u8 mask;
 
-	/* For each PWM channel:
+	/*
+	 * For each PWM channel:
 	 * - If it is in automatic mode, setting to manual mode should set
 	 *   the fan to full speed by default.
 	 * - If it is in manual mode, we need a mapping to temperature
@@ -2048,18 +2083,21 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 	 * prior to switching to a different mode.
 	 * Note that this is no longer needed for the IT8721F and later, as
 	 * these have separate registers for the temperature mapping and the
-	 * manual duty cycle. */
+	 * manual duty cycle.
+	 */
 	for (i = 0; i < 3; i++) {
 		data->pwm_temp_map[i] = i;
 		data->pwm_duty[i] = 0x7f;	/* Full speed */
 		data->auto_pwm[i][3] = 0x7f;	/* Full speed, hard-coded */
 	}
 
-	/* Some chips seem to have default value 0xff for all limit
+	/*
+	 * Some chips seem to have default value 0xff for all limit
 	 * registers. For low voltage limits it makes no sense and triggers
 	 * alarms, so change to 0 instead. For high temperature limits, it
 	 * means -1 degree C, which surprisingly doesn't trigger an alarm,
-	 * but is still confusing, so change to 127 degrees C. */
+	 * but is still confusing, so change to 127 degrees C.
+	 */
 	for (i = 0; i < 8; i++) {
 		tmp = it87_read_value(data, IT87_REG_VIN_MIN(i));
 		if (tmp = 0xff)
@@ -2071,10 +2109,12 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 			it87_write_value(data, IT87_REG_TEMP_HIGH(i), 127);
 	}
 
-	/* Temperature channels are not forcibly enabled, as they can be
+	/*
+	 * Temperature channels are not forcibly enabled, as they can be
 	 * set to two different sensor types and we can't guess which one
 	 * is correct for a given system. These channels can be enabled at
-	 * run-time through the temp{1-3}_type sysfs accessors if needed. */
+	 * run-time through the temp{1-3}_type sysfs accessors if needed.
+	 */
 
 	/* Check if voltage monitors are reset manually or by some reason */
 	tmp = it87_read_value(data, IT87_REG_VIN_ENABLE);
@@ -2157,8 +2197,10 @@ static struct it87_data *it87_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
 		if (update_vbat) {
-			/* Cleared after each update, so reenable.  Value
-			   returned by this read will be previous value */
+			/*
+			 * Cleared after each update, so reenable.  Value
+			 * returned by this read will be previous value
+			 */
 			it87_write_value(data, IT87_REG_CONFIG,
 				it87_read_value(data, IT87_REG_CONFIG) | 0x40);
 		}
@@ -2220,13 +2262,17 @@ static struct it87_data *it87_update_device(struct device *dev)
 			it87_update_pwm_ctrl(data, i);
 
 		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
-		/* The 8705 does not have VID capability.
-		   The 8718 and later don't use IT87_REG_VID for the
-		   same purpose. */
+		/*
+		 * The IT8705F does not have VID capability.
+		 * The IT8718F and later don't use IT87_REG_VID for the
+		 * same purpose.
+		 */
 		if (data->type = it8712 || data->type = it8716) {
 			data->vid = it87_read_value(data, IT87_REG_VID);
-			/* The older IT8712F revisions had only 5 VID pins,
-			   but we assume it is always safe to read 6 bits. */
+			/*
+			 * The older IT8712F revisions had only 5 VID pins,
+			 * but we assume it is always safe to read 6 bits.
+			 */
 			data->vid &= 0x3f;
 		}
 		data->last_updated = jiffies;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
