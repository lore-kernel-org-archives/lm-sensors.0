From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:05 +0000
Subject: [lm-sensors] [PATCH 11/82] hwmon: (adt7475) Fix multi-line comments
Message-Id: <1327017376-20466-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7475.c |   90 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 71e9ac4..a3b4692 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -32,9 +32,10 @@
 #define THERM		5
 #define HYSTERSIS	6
 
-/* These are unique identifiers for the sysfs functions - unlike the
-   numbers above, these are not also indexes into an array
-*/
+/*
+ * These are unique identifiers for the sysfs functions - unlike the
+ * numbers above, these are not also indexes into an array
+ */
 
 #define ALARM		9
 #define FAULT		10
@@ -288,8 +289,10 @@ static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)
 	i2c_smbus_write_byte_data(client, reg, val & 0xFF);
 }
 
-/* Find the nearest value in a table - used for pwm frequency and
-   auto temp range */
+/*
+ * Find the nearest value in a table - used for pwm frequency and
+ * auto temp range
+ */
 static int find_nearest(long val, const int *array, int size)
 {
 	int i;
@@ -385,16 +388,20 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
 			out = (out >> 4) & 0xF;
 		else
 			out = (out & 0xF);
-		/* Show the value as an absolute number tied to
-		 * THERM */
+		/*
+		 * Show the value as an absolute number tied to
+		 * THERM
+		 */
 		out = reg2temp(data, data->temp[THERM][sattr->index]) -
 			out * 1000;
 		mutex_unlock(&data->lock);
 		break;
 
 	case OFFSET:
-		/* Offset is always 2's complement, regardless of the
-		 * setting in CONFIG5 */
+		/*
+		 * Offset is always 2's complement, regardless of the
+		 * setting in CONFIG5
+		 */
 		mutex_lock(&data->lock);
 		out = (s8)data->temp[sattr->nr][sattr->index];
 		if (data->config5 & CONFIG5_TEMPOFFSET)
@@ -452,8 +459,10 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 		break;
 
 	case HYSTERSIS:
-		/* The value will be given as an absolute value, turn it
-		   into an offset based on THERM */
+		/*
+		 * The value will be given as an absolute value, turn it
+		 * into an offset based on THERM
+		 */
 
 		/* Read fresh THERM and HYSTERSIS values from the chip */
 		data->temp[THERM][sattr->index] @@ -478,8 +487,10 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	default:
 		data->temp[sattr->nr][sattr->index] = temp2reg(data, val);
 
-		/* We maintain an extra 2 digits of precision for simplicity
-		 * - shift those back off before writing the value */
+		/*
+		 * We maintain an extra 2 digits of precision for simplicity
+		 * - shift those back off before writing the value
+		 */
 		out = (u8) (data->temp[sattr->nr][sattr->index] >> 2);
 	}
 
@@ -514,8 +525,10 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* Table of autorange values - the user will write the value in millidegrees,
-   and we'll convert it */
+/*
+ * Table of autorange values - the user will write the value in millidegrees,
+ * and we'll convert it
+ */
 static const int autorange_table[] = {
 	2000, 2500, 3330, 4000, 5000, 6670, 8000,
 	10000, 13330, 16000, 20000, 26670, 32000, 40000,
@@ -558,8 +571,10 @@ static ssize_t set_point2(struct device *dev, struct device_attribute *attr,
 	data->range[sattr->index]  		adt7475_read(TEMP_TRANGE_REG(sattr->index));
 
-	/* The user will write an absolute value, so subtract the start point
-	   to figure the range */
+	/*
+	 * The user will write an absolute value, so subtract the start point
+	 * to figure the range
+	 */
 	temp = reg2temp(data, data->temp[AUTOMIN][sattr->index]);
 	val = SENSORS_LIMIT(val, temp + autorange_table[0],
 		temp + autorange_table[ARRAY_SIZE(autorange_table) - 1]);
@@ -664,8 +679,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		data->pwm[CONTROL][sattr->index]  			adt7475_read(PWM_CONFIG_REG(sattr->index));
 
-		/* If we are not in manual mode, then we shouldn't allow
-		 * the user to set the pwm speed */
+		/*
+		 * If we are not in manual mode, then we shouldn't allow
+		 * the user to set the pwm speed
+		 */
 		if (((data->pwm[CONTROL][sattr->index] >> 5) & 7) != 7) {
 			mutex_unlock(&data->lock);
 			return count;
@@ -1280,9 +1297,11 @@ static int adt7475_probe(struct i2c_client *client,
 	if ((data->config4 & CONFIG4_PINFUNC) = 0x0)
 		data->has_fan4 = 1;
 
-	/* THERM configuration is more complex on the ADT7476 and ADT7490,
-	   because 2 different pins (TACH4 and +2.5 Vin) can be used for
-	   this function */
+	/*
+	 * THERM configuration is more complex on the ADT7476 and ADT7490,
+	 * because 2 different pins (TACH4 and +2.5 Vin) can be used for
+	 * this function
+	 */
 	if (id->driver_data = adt7490) {
 		if ((data->config4 & CONFIG4_PINFUNC) = 0x1 &&
 		    !(config3 & CONFIG3_THERM))
@@ -1294,8 +1313,10 @@ static int adt7475_probe(struct i2c_client *client,
 			data->has_voltage |= (1 << 0);		/* in0 */
 	}
 
-	/* On the ADT7476, the +12V input pin may instead be used as VID5,
-	   and VID pins may alternatively be used as GPIO */
+	/*
+	 * On the ADT7476, the +12V input pin may instead be used as VID5,
+	 * and VID pins may alternatively be used as GPIO
+	 */
 	if (id->driver_data = adt7476) {
 		u8 vid = adt7475_read(REG_VID);
 		if (!(vid & VID_VIDSEL))
@@ -1314,8 +1335,10 @@ static int adt7475_probe(struct i2c_client *client,
 	}
 	data->bypass_attn &= data->has_voltage;
 
-	/* Call adt7475_read_pwm for all pwm's as this will reprogram any
-	   pwm's which are disabled to manual mode with 0% duty cycle */
+	/*
+	 * Call adt7475_read_pwm for all pwm's as this will reprogram any
+	 * pwm's which are disabled to manual mode with 0% duty cycle
+	 */
 	for (i = 0; i < ADT7475_PWM_COUNT; i++)
 		adt7475_read_pwm(client, i);
 
@@ -1431,8 +1454,10 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 
 	data->pwm[CONTROL][index] = adt7475_read(PWM_CONFIG_REG(index));
 
-	/* Figure out the internal value for pwmctrl and pwmchan
-	   based on the current settings */
+	/*
+	 * Figure out the internal value for pwmctrl and pwmchan
+	 * based on the current settings
+	 */
 	v = (data->pwm[CONTROL][index] >> 5) & 7;
 
 	if (v = 3)
@@ -1440,10 +1465,11 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 	else if (v = 7)
 		data->pwmctl[index] = 1;
 	else if (v = 4) {
-		/* The fan is disabled - we don't want to
-		   support that, so change to manual mode and
-		   set the duty cycle to 0 instead
-		*/
+		/*
+		 * The fan is disabled - we don't want to
+		 * support that, so change to manual mode and
+		 * set the duty cycle to 0 instead
+		 */
 		data->pwm[INPUT][index] = 0;
 		data->pwm[CONTROL][index] &= ~0xE0;
 		data->pwm[CONTROL][index] |= (7 << 5);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
