From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:16 +0000
Subject: [lm-sensors] [PATCH 22/82] hwmon: (f71805f) Fix multi-line comments
Message-Id: <1327017376-20466-23-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71805f.c |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 859b203..974e919 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -241,9 +241,11 @@ static inline long fan_from_reg(u16 reg)
 
 static inline u16 fan_to_reg(long rpm)
 {
-	/* If the low limit is set below what the chip can measure,
-	   store the largest possible 12-bit value in the registers,
-	   so that no alarm will ever trigger. */
+	/*
+	 * If the low limit is set below what the chip can measure,
+	 * store the largest possible 12-bit value in the registers,
+	 * so that no alarm will ever trigger.
+	 */
 	if (rpm < 367)
 		return 0xfff;
 	return 1500000 / rpm;
@@ -308,9 +310,11 @@ static void f71805f_write8(struct f71805f_data *data, u8 reg, u8 val)
 	outb(val, data->addr + DATA_REG_OFFSET);
 }
 
-/* It is important to read the MSB first, because doing so latches the
-   value of the LSB, so we are sure both bytes belong to the same value.
-   Must be called with data->update_lock held, except during initialization */
+/*
+ * It is important to read the MSB first, because doing so latches the
+ * value of the LSB, so we are sure both bytes belong to the same value.
+ * Must be called with data->update_lock held, except during initialization
+ */
 static u16 f71805f_read16(struct f71805f_data *data, u8 reg)
 {
 	u16 val;
@@ -1075,8 +1079,10 @@ static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO | S_IWUSR,
 		    show_temp_hyst, set_temp_hyst, 2);
 static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2);
 
-/* pwm (value) files are created read-only, write permission is
-   then added or removed dynamically as needed */
+/*
+ * pwm (value) files are created read-only, write permission is
+ * then added or removed dynamically as needed
+ */
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO, show_pwm, set_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 0);
@@ -1311,8 +1317,10 @@ static const struct attribute_group f71805f_group_optin[4] = {
 	{ .attrs = f71805f_attributes_optin[3] },
 };
 
-/* We don't include pwm_freq files in the arrays above, because they must be
-   created conditionally (only if pwm_mode is 1 = PWM) */
+/*
+ * We don't include pwm_freq files in the arrays above, because they must be
+ * created conditionally (only if pwm_mode is 1 = PWM)
+ */
 static struct attribute *f71805f_attributes_pwm_freq[] = {
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
@@ -1347,13 +1355,17 @@ static void __devinit f71805f_init_device(struct f71805f_data *data)
 		f71805f_write8(data, F71805F_REG_START, (reg | 0x01) & ~0x40);
 	}
 
-	/* Fan monitoring can be disabled. If it is, we won't be polling
-	   the register values, and won't create the related sysfs files. */
+	/*
+	 * Fan monitoring can be disabled. If it is, we won't be polling
+	 * the register values, and won't create the related sysfs files.
+	 */
 	for (i = 0; i < 3; i++) {
 		data->fan_ctrl[i] = f71805f_read8(data,
 						  F71805F_REG_FAN_CTRL(i));
-		/* Clear latch full bit, else "speed mode" fan speed control
-		   doesn't work */
+		/*
+		 * Clear latch full bit, else "speed mode" fan speed control
+		 * doesn't work
+		 */
 		if (data->fan_ctrl[i] & FAN_CTRL_LATCH_FULL) {
 			data->fan_ctrl[i] &= ~FAN_CTRL_LATCH_FULL;
 			f71805f_write8(data, F71805F_REG_FAN_CTRL(i),
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
