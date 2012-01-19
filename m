From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:12 +0000
Subject: [lm-sensors] [PATCH 18/82] hwmon: (dme1737) Fix multi-line comments
Message-Id: <1327017376-20466-19-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/dme1737.c |  384 +++++++++++++++++++++++++++++++----------------
 1 files changed, 256 insertions(+), 128 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 1f3113c..4ada418 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -63,7 +63,8 @@ static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
 
 enum chips { dme1737, sch5027, sch311x, sch5127 };
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Registers
  *
  * The sensors are defined as follows:
@@ -79,7 +80,8 @@ enum chips { dme1737, sch5027, sch311x, sch5127 };
  * in6   Vbat
  * in7   Vtrip (sch5127 only)
  *
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 /* Voltages (in) numbered 0-7 (ix) */
 #define	DME1737_REG_IN(ix)		((ix) < 5 ? 0x20 + (ix) : \
@@ -97,14 +99,16 @@ enum chips { dme1737, sch5027, sch311x, sch5127 };
 #define DME1737_REG_TEMP_OFFSET(ix)	((ix) = 0 ? 0x1f \
 						   : 0x1c + (ix))
 
-/* Voltage and temperature LSBs
+/*
+ * Voltage and temperature LSBs
  * The LSBs (4 bits each) are stored in 5 registers with the following layouts:
  *    IN_TEMP_LSB(0) = [in5, in6]
  *    IN_TEMP_LSB(1) = [temp3, temp1]
  *    IN_TEMP_LSB(2) = [in4, temp2]
  *    IN_TEMP_LSB(3) = [in3, in0]
  *    IN_TEMP_LSB(4) = [in2, in1]
- *    IN_TEMP_LSB(5) = [res, in7] */
+ *    IN_TEMP_LSB(5) = [res, in7]
+ */
 #define DME1737_REG_IN_TEMP_LSB(ix)	(0x84 + (ix))
 static const u8 DME1737_REG_IN_LSB[] = {3, 4, 4, 3, 2, 0, 0, 5};
 static const u8 DME1737_REG_IN_LSB_SHL[] = {4, 4, 0, 0, 0, 0, 4, 4};
@@ -127,24 +131,30 @@ static const u8 DME1737_REG_TEMP_LSB_SHL[] = {4, 4, 0};
 #define DME1737_REG_PWM_MIN(ix)		(0x64 + (ix)) /* only for pwm[0-2] */
 #define DME1737_REG_PWM_FREQ(ix)	((ix) < 3 ? 0x5f + (ix) \
 						  : 0xa3 + (ix))
-/* The layout of the ramp rate registers is different from the other pwm
+/*
+ * The layout of the ramp rate registers is different from the other pwm
  * registers. The bits for the 3 PWMs are stored in 2 registers:
  *    PWM_RR(0) = [OFF3, OFF2,  OFF1,  RES,   RR1E, RR1-2, RR1-1, RR1-0]
- *    PWM_RR(1) = [RR2E, RR2-2, RR2-1, RR2-0, RR3E, RR3-2, RR3-1, RR3-0] */
+ *    PWM_RR(1) = [RR2E, RR2-2, RR2-1, RR2-0, RR3E, RR3-2, RR3-1, RR3-0]
+ */
 #define DME1737_REG_PWM_RR(ix)		(0x62 + (ix)) /* only for pwm[0-2] */
 
 /* Thermal zones 0-2 */
 #define DME1737_REG_ZONE_LOW(ix)	(0x67 + (ix))
 #define DME1737_REG_ZONE_ABS(ix)	(0x6a + (ix))
-/* The layout of the hysteresis registers is different from the other zone
+/*
+ * The layout of the hysteresis registers is different from the other zone
  * registers. The bits for the 3 zones are stored in 2 registers:
  *    ZONE_HYST(0) = [H1-3,  H1-2,  H1-1, H1-0, H2-3, H2-2, H2-1, H2-0]
- *    ZONE_HYST(1) = [H3-3,  H3-2,  H3-1, H3-0, RES,  RES,  RES,  RES] */
+ *    ZONE_HYST(1) = [H3-3,  H3-2,  H3-1, H3-0, RES,  RES,  RES,  RES]
+ */
 #define DME1737_REG_ZONE_HYST(ix)	(0x6d + (ix))
 
-/* Alarm registers and bit mapping
+/*
+ * Alarm registers and bit mapping
  * The 3 8-bit alarm registers will be concatenated to a single 32-bit
- * alarm value [0, ALARM3, ALARM2, ALARM1]. */
+ * alarm value [0, ALARM3, ALARM2, ALARM1].
+ */
 #define DME1737_REG_ALARM1		0x41
 #define DME1737_REG_ALARM2		0x42
 #define DME1737_REG_ALARM3		0x83
@@ -161,9 +171,11 @@ static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
 #define DME1737_REG_VID			0x43
 #define DME1737_REG_TACH_PWM		0x81
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Misc defines
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 /* Chip identification */
 #define DME1737_COMPANY_SMSC	0x5c
@@ -195,9 +207,11 @@ static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
 #define HAS_PWM(ix)		(1 << ((ix) + 11))	/* bits 11-16 */
 #define HAS_IN7			(1 << 17)		/* bit 17 */
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Data structures and manipulation thereof
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 struct dme1737_data {
 	struct i2c_client *client;	/* for I2C devices only */
@@ -257,9 +271,11 @@ static const int IN_NOMINAL_SCH5127[] = {2500, 2250, 3300, 1125, 1125, 3300,
 				 (type) = sch5127 ? IN_NOMINAL_SCH5127 : \
 				 IN_NOMINAL_DME1737)
 
-/* Voltage input
+/*
+ * Voltage input
  * Voltage inputs have 16 bits resolution, limit values have 8 bits
- * resolution. */
+ * resolution.
+ */
 static inline int IN_FROM_REG(int reg, int nominal, int res)
 {
 	return (reg * nominal + (3 << (res - 3))) / (3 << (res - 2));
@@ -270,10 +286,12 @@ static inline int IN_TO_REG(int val, int nominal)
 	return SENSORS_LIMIT((val * 192 + nominal / 2) / nominal, 0, 255);
 }
 
-/* Temperature input
+/*
+ * Temperature input
  * The register values represent temperatures in 2's complement notation from
  * -127 degrees C to +127 degrees C. Temp inputs have 16 bits resolution, limit
- * values have 8 bits resolution. */
+ * values have 8 bits resolution.
+ */
 static inline int TEMP_FROM_REG(int reg, int res)
 {
 	return (reg * 1000) >> (res - 8);
@@ -307,10 +325,12 @@ static int TEMP_RANGE_TO_REG(int val, int reg)
 	return (reg & 0x0f) | (i << 4);
 }
 
-/* Temperature hysteresis
+/*
+ * Temperature hysteresis
  * Register layout:
  *    reg[0] = [H1-3, H1-2, H1-1, H1-0, H2-3, H2-2, H2-1, H2-0]
- *    reg[1] = [H3-3, H3-2, H3-1, H3-0, xxxx, xxxx, xxxx, xxxx] */
+ *    reg[1] = [H3-3, H3-2, H3-1, H3-0, xxxx, xxxx, xxxx, xxxx]
+ */
 static inline int TEMP_HYST_FROM_REG(int reg, int ix)
 {
 	return (((ix = 1) ? reg : reg >> 4) & 0x0f) * 1000;
@@ -341,17 +361,21 @@ static inline int FAN_TO_REG(int val, int tpc)
 			SENSORS_LIMIT(90000 * 60 / val, 0, 0xfffe);
 }
 
-/* Fan TPC (tach pulse count)
+/*
+ * Fan TPC (tach pulse count)
  * Converts a register value to a TPC multiplier or returns 0 if the tachometer
- * is configured in legacy (non-tpc) mode */
+ * is configured in legacy (non-tpc) mode
+ */
 static inline int FAN_TPC_FROM_REG(int reg)
 {
 	return (reg & 0x20) ? 0 : 60 >> (reg & 0x03);
 }
 
-/* Fan type
+/*
+ * Fan type
  * The type of a fan is expressed in number of pulses-per-revolution that it
- * emits */
+ * emits
+ */
 static inline int FAN_TYPE_FROM_REG(int reg)
 {
 	int edge = (reg >> 1) & 0x03;
@@ -394,7 +418,8 @@ static int FAN_MAX_TO_REG(int val)
 	return FAN_MAX[i];
 }
 
-/* PWM enable
+/*
+ * PWM enable
  * Register to enable mapping:
  * 000:  2  fan on zone 1 auto
  * 001:  2  fan on zone 2 auto
@@ -403,7 +428,8 @@ static int FAN_MAX_TO_REG(int val)
  * 100: -1  fan disabled
  * 101:  2  fan on hottest of zones 2,3 auto
  * 110:  2  fan on hottest of zones 1,2,3 auto
- * 111:  1  fan in manual mode */
+ * 111:  1  fan in manual mode
+ */
 static inline int PWM_EN_FROM_REG(int reg)
 {
 	static const int en[] = {2, 2, 2, 0, -1, 2, 2, 1};
@@ -418,7 +444,8 @@ static inline int PWM_EN_TO_REG(int val, int reg)
 	return (reg & 0x1f) | ((en & 0x07) << 5);
 }
 
-/* PWM auto channels zone
+/*
+ * PWM auto channels zone
  * Register to auto channels zone mapping (ACZ is a bitfield with bit x
  * corresponding to zone x+1):
  * 000: 001  fan on zone 1 auto
@@ -428,7 +455,8 @@ static inline int PWM_EN_TO_REG(int val, int reg)
  * 100: 000  fan disabled
  * 101: 110  fan on hottest of zones 2,3 auto
  * 110: 111  fan on hottest of zones 1,2,3 auto
- * 111: 000  fan in manual mode */
+ * 111: 000  fan in manual mode
+ */
 static inline int PWM_ACZ_FROM_REG(int reg)
 {
 	static const int acz[] = {1, 2, 4, 0, 0, 6, 7, 0};
@@ -471,10 +499,12 @@ static int PWM_FREQ_TO_REG(int val, int reg)
 	return (reg & 0xf0) | i;
 }
 
-/* PWM ramp rate
+/*
+ * PWM ramp rate
  * Register layout:
  *    reg[0] = [OFF3,  OFF2,  OFF1,  RES,   RR1-E, RR1-2, RR1-1, RR1-0]
- *    reg[1] = [RR2-E, RR2-2, RR2-1, RR2-0, RR3-E, RR3-2, RR3-1, RR3-0] */
+ *    reg[1] = [RR2-E, RR2-2, RR2-1, RR2-0, RR3-E, RR3-2, RR3-1, RR3-0]
+ */
 static const u8 PWM_RR[] = {206, 104, 69, 41, 26, 18, 10, 5};
 
 static inline int PWM_RR_FROM_REG(int reg, int ix)
@@ -509,9 +539,11 @@ static inline int PWM_RR_EN_TO_REG(int val, int ix, int reg)
 	return val ? reg | en : reg & ~en;
 }
 
-/* PWM min/off
+/*
+ * PWM min/off
  * The PWM min/off bits are part of the PMW ramp rate register 0 (see above for
- * the register layout). */
+ * the register layout).
+ */
 static inline int PWM_OFF_FROM_REG(int reg, int ix)
 {
 	return (reg >> (ix + 5)) & 0x01;
@@ -522,14 +554,16 @@ static inline int PWM_OFF_TO_REG(int val, int ix, int reg)
 	return (reg & ~(1 << (ix + 5))) | ((val & 0x01) << (ix + 5));
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Device I/O access
  *
  * ISA access is performed through an index/data register pair and needs to
  * be protected by a mutex during runtime (not required for initialization).
  * We use data->update_lock for this and need to ensure that we acquire it
  * before calling dme1737_read or dme1737_write.
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static u8 dme1737_read(const struct dme1737_data *data, u8 reg)
 {
@@ -597,9 +631,11 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 
 		/* In (voltage) registers */
 		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
-			/* Voltage inputs are stored as 16 bit values even
+			/*
+			 * Voltage inputs are stored as 16 bit values even
 			 * though they have only 12 bits resolution. This is
-			 * to make it consistent with the temp inputs. */
+			 * to make it consistent with the temp inputs.
+			 */
 			if (ix = 7 && !(data->has_features & HAS_IN7))
 				continue;
 			data->in[ix] = dme1737_read(data,
@@ -612,11 +648,13 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 
 		/* Temp registers */
 		for (ix = 0; ix < ARRAY_SIZE(data->temp); ix++) {
-			/* Temp inputs are stored as 16 bit values even
+			/*
+			 * Temp inputs are stored as 16 bit values even
 			 * though they have only 12 bits resolution. This is
 			 * to take advantage of implicit conversions between
 			 * register values (2's complement) and temp values
-			 * (signed decimal). */
+			 * (signed decimal).
+			 */
 			data->temp[ix] = dme1737_read(data,
 					DME1737_REG_TEMP(ix)) << 8;
 			data->temp_min[ix] = dme1737_read(data,
@@ -629,10 +667,12 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 			}
 		}
 
-		/* In and temp LSB registers
+		/*
+		 * In and temp LSB registers
 		 * The LSBs are latched when the MSBs are read, so the order in
 		 * which the registers are read (MSB first, then LSB) is
-		 * important! */
+		 * important!
+		 */
 		for (ix = 0; ix < ARRAY_SIZE(lsb); ix++) {
 			if (ix = 5 && !(data->has_features & HAS_IN7))
 				continue;
@@ -652,8 +692,10 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 
 		/* Fan registers */
 		for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {
-			/* Skip reading registers if optional fans are not
-			 * present */
+			/*
+			 * Skip reading registers if optional fans are not
+			 * present
+			 */
 			if (!(data->has_features & HAS_FAN(ix)))
 				continue;
 			data->fan[ix] = dme1737_read(data,
@@ -675,8 +717,10 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 
 		/* PWM registers */
 		for (ix = 0; ix < ARRAY_SIZE(data->pwm); ix++) {
-			/* Skip reading registers if optional PWMs are not
-			 * present */
+			/*
+			 * Skip reading registers if optional PWMs are not
+			 * present
+			 */
 			if (!(data->has_features & HAS_PWM(ix)))
 				continue;
 			data->pwm[ix] = dme1737_read(data,
@@ -724,8 +768,10 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 		/* Alarm registers */
 		data->alarms = dme1737_read(data,
 						DME1737_REG_ALARM1);
-		/* Bit 7 tells us if the other alarm registers are non-zero and
-		 * therefore also need to be read */
+		/*
+		 * Bit 7 tells us if the other alarm registers are non-zero and
+		 * therefore also need to be read
+		 */
 		if (data->alarms & 0x80) {
 			data->alarms |= dme1737_read(data,
 						DME1737_REG_ALARM2) << 8;
@@ -733,9 +779,11 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 						DME1737_REG_ALARM3) << 16;
 		}
 
-		/* The ISA chips require explicit clearing of alarm bits.
+		/*
+		 * The ISA chips require explicit clearing of alarm bits.
 		 * Don't worry, an alarm will come back if the condition
-		 * that causes it still exists */
+		 * that causes it still exists
+		 */
 		if (!data->client) {
 			if (data->alarms & 0xff0000)
 				dme1737_write(data, DME1737_REG_ALARM3, 0xff);
@@ -754,10 +802,12 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
 	return data;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Voltage sysfs attributes
  * ix = [0-7]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SYS_IN_INPUT	0
 #define SYS_IN_MIN	1
@@ -830,10 +880,12 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Temperature sysfs attributes
  * ix = [0-2]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SYS_TEMP_INPUT			0
 #define SYS_TEMP_MIN			1
@@ -919,10 +971,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Zone sysfs attributes
  * ix = [0-2]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SYS_ZONE_AUTO_CHANNELS_TEMP	0
 #define SYS_ZONE_AUTO_POINT1_TEMP_HYST	1
@@ -1009,8 +1063,10 @@ static ssize_t set_zone(struct device *dev, struct device_attribute *attr,
 		/* Refresh the cache */
 		data->zone_low[ix] = dme1737_read(data,
 						  DME1737_REG_ZONE_LOW(ix));
-		/* Modify the temp range value (which is stored in the upper
-		 * nibble of the pwm_freq register) */
+		/*
+		 * Modify the temp range value (which is stored in the upper
+		 * nibble of the pwm_freq register)
+		 */
 		data->pwm_freq[ix] = TEMP_RANGE_TO_REG(val -
 					TEMP_FROM_REG(data->zone_low[ix], 8),
 					dme1737_read(data,
@@ -1031,10 +1087,12 @@ static ssize_t set_zone(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Fan sysfs attributes
  * ix = [0-5]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SYS_FAN_INPUT	0
 #define SYS_FAN_MIN	1
@@ -1144,10 +1202,12 @@ exit:
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * PWM sysfs attributes
  * ix = [0-4]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SYS_PWM				0
 #define SYS_PWM_FREQ			1
@@ -1308,8 +1368,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 			/* Change permissions of pwm[ix] to read-only */
 			dme1737_chmod_file(dev, dme1737_pwm_chmod_attr[ix],
 					   S_IRUGO);
-			/* Turn on auto mode using the saved zone channel
-			 * assignment */
+			/*
+			 * Turn on auto mode using the saved zone channel
+			 * assignment
+			 */
 			data->pwm_config[ix] = PWM_ACZ_TO_REG(
 							data->pwm_acz[ix],
 							data->pwm_config[ix]);
@@ -1339,8 +1401,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 			data->pwm_rr[ix > 0] = PWM_RR_TO_REG(val, ix,
 							data->pwm_rr[ix > 0]);
 		}
-		/* Enable/disable the feature only if the associated PWM
-		 * output is in automatic mode. */
+		/*
+		 * Enable/disable the feature only if the associated PWM
+		 * output is in automatic mode.
+		 */
 		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
 			data->pwm_rr[ix > 0] = PWM_RR_EN_TO_REG(val > 0, ix,
 							data->pwm_rr[ix > 0]);
@@ -1362,15 +1426,19 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		data->pwm_config[ix] = dme1737_read(data,
 						DME1737_REG_PWM_CONFIG(ix));
 		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
-			/* PWM is already in auto mode so update the temp
-			 * channel assignment */
+			/*
+			 * PWM is already in auto mode so update the temp
+			 * channel assignment
+			 */
 			data->pwm_config[ix] = PWM_ACZ_TO_REG(val,
 						data->pwm_config[ix]);
 			dme1737_write(data, DME1737_REG_PWM_CONFIG(ix),
 				      data->pwm_config[ix]);
 		} else {
-			/* PWM is not in auto mode so we save the temp
-			 * channel assignment for later use */
+			/*
+			 * PWM is not in auto mode so we save the temp
+			 * channel assignment for later use
+			 */
 			data->pwm_acz[ix] = val;
 		}
 		break;
@@ -1379,10 +1447,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		/* Refresh the cache */
 		data->pwm_min[ix] = dme1737_read(data,
 						DME1737_REG_PWM_MIN(ix));
-		/* There are only 2 values supported for the auto_pwm_min
+		/*
+		 * There are only 2 values supported for the auto_pwm_min
 		 * value: 0 or auto_point1_pwm. So if the temperature drops
 		 * below the auto_point1_temp_hyst value, the fan either turns
-		 * off or runs at auto_point1_pwm duty-cycle. */
+		 * off or runs at auto_point1_pwm duty-cycle.
+		 */
 		if (val > ((data->pwm_min[ix] + 1) / 2)) {
 			data->pwm_rr[0] = PWM_OFF_TO_REG(1, ix,
 						dme1737_read(data,
@@ -1410,9 +1480,11 @@ exit:
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Miscellaneous sysfs attributes
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -1454,9 +1526,11 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%s\n", data->name);
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Sysfs device attribute defines and structs
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 /* Voltages 0-7 */
 
@@ -1592,10 +1666,12 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);   /* for ISA devices */
 
-/* This struct holds all the attributes that are always present and need to be
+/*
+ * This struct holds all the attributes that are always present and need to be
  * created unconditionally. The attributes that need modification of their
  * permissions are created read-only and write permissions are added or removed
- * on the fly when required */
+ * on the fly when required
+ */
 static struct attribute *dme1737_attr[] = {
 	/* Voltages */
 	&sensor_dev_attr_in0_input.dev_attr.attr,
@@ -1658,9 +1734,11 @@ static const struct attribute_group dme1737_group = {
 	.attrs = dme1737_attr,
 };
 
-/* The following struct holds temp offset attributes, which are not available
+/*
+ * The following struct holds temp offset attributes, which are not available
  * in all chips. The following chips support them:
- * DME1737, SCH311x */
+ * DME1737, SCH311x
+ */
 static struct attribute *dme1737_temp_offset_attr[] = {
 	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
@@ -1672,9 +1750,11 @@ static const struct attribute_group dme1737_temp_offset_group = {
 	.attrs = dme1737_temp_offset_attr,
 };
 
-/* The following struct holds VID related attributes, which are not available
+/*
+ * The following struct holds VID related attributes, which are not available
  * in all chips. The following chips support them:
- * DME1737 */
+ * DME1737
+ */
 static struct attribute *dme1737_vid_attr[] = {
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
@@ -1685,9 +1765,11 @@ static const struct attribute_group dme1737_vid_group = {
 	.attrs = dme1737_vid_attr,
 };
 
-/* The following struct holds temp zone 3 related attributes, which are not
+/*
+ * The following struct holds temp zone 3 related attributes, which are not
  * available in all chips. The following chips support them:
- * DME1737, SCH311x, SCH5027 */
+ * DME1737, SCH311x, SCH5027
+ */
 static struct attribute *dme1737_zone3_attr[] = {
 	&sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
 	&sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
@@ -1701,9 +1783,11 @@ static const struct attribute_group dme1737_zone3_group = {
 };
 
 
-/* The following struct holds temp zone hysteresis related attributes, which
+/*
+ * The following struct holds temp zone hysteresis related attributes, which
  * are not available in all chips. The following chips support them:
- * DME1737, SCH311x */
+ * DME1737, SCH311x
+ */
 static struct attribute *dme1737_zone_hyst_attr[] = {
 	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
 	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
@@ -1715,9 +1799,11 @@ static const struct attribute_group dme1737_zone_hyst_group = {
 	.attrs = dme1737_zone_hyst_attr,
 };
 
-/* The following struct holds voltage in7 related attributes, which
+/*
+ * The following struct holds voltage in7 related attributes, which
  * are not available in all chips. The following chips support them:
- * SCH5127 */
+ * SCH5127
+ */
 static struct attribute *dme1737_in7_attr[] = {
 	&sensor_dev_attr_in7_input.dev_attr.attr,
 	&sensor_dev_attr_in7_min.dev_attr.attr,
@@ -1730,9 +1816,11 @@ static const struct attribute_group dme1737_in7_group = {
 	.attrs = dme1737_in7_attr,
 };
 
-/* The following structs hold the PWM attributes, some of which are optional.
+/*
+ * The following structs hold the PWM attributes, some of which are optional.
  * Their creation depends on the chip configuration which is determined during
- * module load. */
+ * module load.
+ */
 static struct attribute *dme1737_pwm1_attr[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
@@ -1785,18 +1873,22 @@ static const struct attribute_group dme1737_pwm_group[] = {
 	{ .attrs = dme1737_pwm6_attr },
 };
 
-/* The following struct holds auto PWM min attributes, which are not available
+/*
+ * The following struct holds auto PWM min attributes, which are not available
  * in all chips. Their creation depends on the chip type which is determined
- * during module load. */
+ * during module load.
+ */
 static struct attribute *dme1737_auto_pwm_min_attr[] = {
 	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
 };
 
-/* The following structs hold the fan attributes, some of which are optional.
+/*
+ * The following structs hold the fan attributes, some of which are optional.
  * Their creation depends on the chip configuration which is determined during
- * module load. */
+ * module load.
+ */
 static struct attribute *dme1737_fan1_attr[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -1849,8 +1941,10 @@ static const struct attribute_group dme1737_fan_group[] = {
 	{ .attrs = dme1737_fan6_attr },
 };
 
-/* The permissions of the following zone attributes are changed to read-
- * writeable if the chip is *not* locked. Otherwise they stay read-only. */
+/*
+ * The permissions of the following zone attributes are changed to read-
+ * writeable if the chip is *not* locked. Otherwise they stay read-only.
+ */
 static struct attribute *dme1737_zone_chmod_attr[] = {
 	&sensor_dev_attr_zone1_auto_point1_temp.dev_attr.attr,
 	&sensor_dev_attr_zone1_auto_point2_temp.dev_attr.attr,
@@ -1866,8 +1960,10 @@ static const struct attribute_group dme1737_zone_chmod_group = {
 };
 
 
-/* The permissions of the following zone 3 attributes are changed to read-
- * writeable if the chip is *not* locked. Otherwise they stay read-only. */
+/*
+ * The permissions of the following zone 3 attributes are changed to read-
+ * writeable if the chip is *not* locked. Otherwise they stay read-only.
+ */
 static struct attribute *dme1737_zone3_chmod_attr[] = {
 	&sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
 	&sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
@@ -1879,9 +1975,11 @@ static const struct attribute_group dme1737_zone3_chmod_group = {
 	.attrs = dme1737_zone3_chmod_attr,
 };
 
-/* The permissions of the following PWM attributes are changed to read-
+/*
+ * The permissions of the following PWM attributes are changed to read-
  * writeable if the chip is *not* locked and the respective PWM is available.
- * Otherwise they stay read-only. */
+ * Otherwise they stay read-only.
+ */
 static struct attribute *dme1737_pwm1_chmod_attr[] = {
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
@@ -1926,17 +2024,21 @@ static const struct attribute_group dme1737_pwm_chmod_group[] = {
 	{ .attrs = dme1737_pwm6_chmod_attr },
 };
 
-/* Pwm[1-3] are read-writeable if the associated pwm is in manual mode and the
- * chip is not locked. Otherwise they are read-only. */
+/*
+ * Pwm[1-3] are read-writeable if the associated pwm is in manual mode and the
+ * chip is not locked. Otherwise they are read-only.
+ */
 static struct attribute *dme1737_pwm_chmod_attr[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 };
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Super-IO functions
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static inline void dme1737_sio_enter(int sio_cip)
 {
@@ -1960,9 +2062,11 @@ static inline void dme1737_sio_outb(int sio_cip, int reg, int val)
 	outb(val, sio_cip + 1);
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Device initialization
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static int dme1737_i2c_get_features(int, struct dme1737_data*);
 
@@ -2095,8 +2199,10 @@ static int dme1737_create_files(struct device *dev)
 		}
 	}
 
-	/* Inform if the device is locked. Otherwise change the permissions of
-	 * selected attributes from read-only to read-writeable. */
+	/*
+	 * Inform if the device is locked. Otherwise change the permissions of
+	 * selected attributes from read-only to read-writeable.
+	 */
 	if (data->config & 0x02) {
 		dev_info(dev, "Device is locked. Some attributes "
 			 "will be read-only.\n");
@@ -2183,24 +2289,30 @@ static int dme1737_init_device(struct device *dev)
 		return -EFAULT;
 	}
 
-	/* Determine which optional fan and pwm features are enabled (only
-	 * valid for I2C devices) */
+	/*
+	 * Determine which optional fan and pwm features are enabled (only
+	 * valid for I2C devices)
+	 */
 	if (client) {   /* I2C chip */
 		data->config2 = dme1737_read(data, DME1737_REG_CONFIG2);
 		/* Check if optional fan3 input is enabled */
 		if (data->config2 & 0x04)
 			data->has_features |= HAS_FAN(2);
 
-		/* Fan4 and pwm3 are only available if the client's I2C address
+		/*
+		 * Fan4 and pwm3 are only available if the client's I2C address
 		 * is the default 0x2e. Otherwise the I/Os associated with
-		 * these functions are used for addr enable/select. */
+		 * these functions are used for addr enable/select.
+		 */
 		if (client->addr = 0x2e)
 			data->has_features |= HAS_FAN(3) | HAS_PWM(2);
 
-		/* Determine which of the optional fan[5-6] and pwm[5-6]
+		/*
+		 * Determine which of the optional fan[5-6] and pwm[5-6]
 		 * features are enabled. For this, we need to query the runtime
 		 * registers through the Super-IO LPC interface. Try both
-		 * config ports 0x2e and 0x4e. */
+		 * config ports 0x2e and 0x4e.
+		 */
 		if (dme1737_i2c_get_features(0x2e, data) &&
 		    dme1737_i2c_get_features(0x4e, data)) {
 			dev_warn(dev, "Failed to query Super-IO for optional "
@@ -2258,9 +2370,11 @@ static int dme1737_init_device(struct device *dev)
 			 ((reg >> 4) & 0x03) + 1);
 	}
 
-	/* Switch pwm[1-3] to manual mode if they are currently disabled and
+	/*
+	 * Switch pwm[1-3] to manual mode if they are currently disabled and
 	 * set the duty-cycles to 0% (which is identical to the PWMs being
-	 * disabled). */
+	 * disabled).
+	 */
 	if (!(data->config & 0x02)) {
 		for (ix = 0; ix < 3; ix++) {
 			data->pwm_config[ix] = dme1737_read(data,
@@ -2291,9 +2405,11 @@ static int dme1737_init_device(struct device *dev)
 	return 0;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * I2C device detection and registration
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static struct i2c_driver dme1737_i2c_driver;
 
@@ -2304,8 +2420,10 @@ static int dme1737_i2c_get_features(int sio_cip, struct dme1737_data *data)
 
 	dme1737_sio_enter(sio_cip);
 
-	/* Check device ID
-	 * We currently know about two kinds of DME1737 and SCH5027. */
+	/*
+	 * Check device ID
+	 * We currently know about two kinds of DME1737 and SCH5027.
+	 */
 	reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
 	if (!(reg = DME1737_ID_1 || reg = DME1737_ID_2 ||
 	      reg = SCH5027_ID)) {
@@ -2324,9 +2442,11 @@ static int dme1737_i2c_get_features(int sio_cip, struct dme1737_data *data)
 		goto exit;
 	}
 
-	/* Read the runtime registers to determine which optional features
+	/*
+	 * Read the runtime registers to determine which optional features
 	 * are enabled and available. Bits [3:2] of registers 0x43-0x46 are set
-	 * to '10' if the respective feature is enabled. */
+	 * to '10' if the respective feature is enabled.
+	 */
 	if ((inb(addr + 0x43) & 0x0c) = 0x08) /* fan6 */
 		data->has_features |= HAS_FAN(5);
 	if ((inb(addr + 0x44) & 0x0c) = 0x08) /* pwm6 */
@@ -2456,9 +2576,11 @@ static struct i2c_driver dme1737_i2c_driver = {
 	.address_list = normal_i2c,
 };
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * ISA device detection and registration
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static int __init dme1737_isa_detect(int sio_cip, unsigned short *addr)
 {
@@ -2467,8 +2589,10 @@ static int __init dme1737_isa_detect(int sio_cip, unsigned short *addr)
 
 	dme1737_sio_enter(sio_cip);
 
-	/* Check device ID
-	 * We currently know about SCH3112, SCH3114, SCH3116, and SCH5127 */
+	/*
+	 * Check device ID
+	 * We currently know about SCH3112, SCH3114, SCH3116, and SCH5127
+	 */
 	reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
 	if (!(reg = SCH3112_ID || reg = SCH3114_ID || reg = SCH3116_ID ||
 	      reg = SCH5127_ID)) {
@@ -2488,8 +2612,10 @@ static int __init dme1737_isa_detect(int sio_cip, unsigned short *addr)
 		goto exit;
 	}
 
-	/* Access to the hwmon registers is through an index/data register
-	 * pair located at offset 0x70/0x71. */
+	/*
+	 * Access to the hwmon registers is through an index/data register
+	 * pair located at offset 0x70/0x71.
+	 */
 	*addr = base_addr + 0x70;
 
 exit:
@@ -2659,9 +2785,11 @@ static struct platform_driver dme1737_isa_driver = {
 	.remove = __devexit_p(dme1737_isa_remove),
 };
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Module initialization and cleanup
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static int __init dme1737_init(void)
 {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
