From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:13 +0000
Subject: [lm-sensors] [PATCH 79/82] hwmon: (w83795) Fix multi-line comments
Message-Id: <1327017376-20466-80-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83795.c |   94 +++++++++++++++++++++++++++++++----------------
 1 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index aa58b25..a6f5671 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -72,8 +72,10 @@ MODULE_PARM_DESC(reset, "Set to 1 to reset chip, not recommended");
 #define TEMP_CRIT_HYST			2
 #define TEMP_WARN			3
 #define TEMP_WARN_HYST			4
-/* only crit and crit_hyst affect real-time alarm status
- * current crit crit_hyst warn warn_hyst */
+/*
+ * only crit and crit_hyst affect real-time alarm status
+ * current crit crit_hyst warn warn_hyst
+ */
 static const u16 W83795_REG_TEMP[][5] = {
 	{0x21, 0x96, 0x97, 0x98, 0x99},	/* TD1/TR1 */
 	{0x22, 0x9a, 0x9b, 0x9c, 0x9d},	/* TD2/TR2 */
@@ -354,26 +356,34 @@ struct w83795_data {
 	u8 temp_mode;		/* Bit vector, 0 = TR, 1 = TD */
 	u8 temp_src[3];		/* Register value */
 
-	u8 enable_dts;		/* Enable PECI and SB-TSI,
+	u8 enable_dts;		/*
+				 * Enable PECI and SB-TSI,
 				 * bit 0: =1 enable, =0 disable,
-				 * bit 1: =1 AMD SB-TSI, =0 Intel PECI */
+				 * bit 1: =1 AMD SB-TSI, =0 Intel PECI
+				 */
 	u8 has_dts;		/* Enable monitor DTS temp */
 	s8 dts[8];		/* Register value */
 	u8 dts_read_vrlsb[8];	/* Register value */
 	s8 dts_ext[4];		/* Register value */
 
-	u8 has_pwm;		/* 795g supports 8 pwm, 795adg only supports 2,
+	u8 has_pwm;		/*
+				 * 795g supports 8 pwm, 795adg only supports 2,
 				 * no config register, only affected by chip
-				 * type */
-	u8 pwm[8][5];		/* Register value, output, freq, start,
-				 *  non stop, stop time */
+				 * type
+				 */
+	u8 pwm[8][5];		/*
+				 * Register value, output, freq, start,
+				 *  non stop, stop time
+				 */
 	u16 clkin;		/* CLKIN frequency in kHz */
 	u8 pwm_fcms[2];		/* Register value */
 	u8 pwm_tfmr[6];		/* Register value */
 	u8 pwm_fomc;		/* Register value */
 
-	u16 target_speed[8];	/* Register value, target speed for speed
-				 * cruise */
+	u16 target_speed[8];	/*
+				 * Register value, target speed for speed
+				 * cruise
+				 */
 	u8 tol_speed;		/* tolerance of target speed */
 	u8 pwm_temp[6][4];	/* TTTI, CTFS, HCT, HOT */
 	u8 sf4_reg[6][2][7];	/* 6 temp, temp/dcpwm, 7 registers */
@@ -482,8 +492,10 @@ static void w83795_update_limits(struct i2c_client *client)
 	/* Read the fan limits */
 	lsb = 0; /* Silent false gcc warning */
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
-		/* Each register contains LSB for 2 fans, but we want to
-		 * read it only once to save time */
+		/*
+		 * Each register contains LSB for 2 fans, but we want to
+		 * read it only once to save time
+		 */
 		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
 			lsb = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
 
@@ -665,9 +677,11 @@ static struct w83795_data *w83795_update_device(struct device *dev)
 		    w83795_read(client, W83795_REG_PWM(i, PWM_OUTPUT));
 	}
 
-	/* Update intrusion and alarms
+	/*
+	 * Update intrusion and alarms
 	 * It is important to read intrusion first, because reading from
-	 * register SMI STS6 clears the interrupt status temporarily. */
+	 * register SMI STS6 clears the interrupt status temporarily.
+	 */
 	tmp = w83795_read(client, W83795_REG_ALARM_CTRL);
 	/* Switch to interrupt status for intrusion if needed */
 	if (tmp & ALARM_CTRL_RTSACS)
@@ -1595,8 +1609,10 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 
 #define NOT_USED			-1
 
-/* Don't change the attribute order, _max, _min and _beep are accessed by index
- * somewhere else in the code */
+/*
+ * Don't change the attribute order, _max, _min and _beep are accessed by index
+ * somewhere else in the code
+ */
 #define SENSOR_ATTR_IN(index) {						\
 	SENSOR_ATTR_2(in##index##_input, S_IRUGO, show_in, NULL,	\
 		IN_READ, index), \
@@ -1610,8 +1626,10 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 		show_alarm_beep, store_beep, BEEP_ENABLE,		\
 		index + ((index > 14) ? 1 : 0)) }
 
-/* Don't change the attribute order, _beep is accessed by index
- * somewhere else in the code */
+/*
+ * Don't change the attribute order, _beep is accessed by index
+ * somewhere else in the code
+ */
 #define SENSOR_ATTR_FAN(index) {					\
 	SENSOR_ATTR_2(fan##index##_input, S_IRUGO, show_fan,		\
 		NULL, FAN_INPUT, index - 1), \
@@ -1640,8 +1658,10 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
 		show_fanin, store_fanin, FANIN_TARGET, index - 1) }
 
-/* Don't change the attribute order, _beep is accessed by index
- * somewhere else in the code */
+/*
+ * Don't change the attribute order, _beep is accessed by index
+ * somewhere else in the code
+ */
 #define SENSOR_ATTR_DTS(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO ,		\
 		show_dts_mode, NULL, NOT_USED, index - 7),	\
@@ -1660,8 +1680,10 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 	SENSOR_ATTR_2(temp##index##_beep, S_IWUSR | S_IRUGO,		\
 		show_alarm_beep, store_beep, BEEP_ENABLE, index + 17) }
 
-/* Don't change the attribute order, _beep is accessed by index
- * somewhere else in the code */
+/*
+ * Don't change the attribute order, _beep is accessed by index
+ * somewhere else in the code
+ */
 #define SENSOR_ATTR_TEMP(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
@@ -1867,8 +1889,10 @@ static int w83795_get_device_id(struct i2c_client *client)
 
 	device_id = i2c_smbus_read_byte_data(client, W83795_REG_DEVICEID);
 
-	/* Special case for rev. A chips; can't be checked first because later
-	   revisions emulate this for compatibility */
+	/*
+	 * Special case for rev. A chips; can't be checked first because later
+	 * revisions emulate this for compatibility
+	 */
 	if (device_id < 0 || (device_id & 0xf0) != 0x50) {
 		int alt_id;
 
@@ -1920,8 +1944,10 @@ static int w83795_detect(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	/* If Nuvoton chip, address of chip and W83795_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Nuvoton chip, address of chip and W83795_REG_I2C_ADDR
+	 * should match
+	 */
 	if ((bank & 0x07) = 0) {
 		i2c_addr = i2c_smbus_read_byte_data(client,
 						    W83795_REG_I2C_ADDR);
@@ -1933,10 +1959,12 @@ static int w83795_detect(struct i2c_client *client,
 		}
 	}
 
-	/* Check 795 chip type: 795G or 795ADG
-	   Usually we don't write to chips during detection, but here we don't
-	   quite have the choice; hopefully it's OK, we are about to return
-	   success anyway */
+	/*
+	 * Check 795 chip type: 795G or 795ADG
+	 * Usually we don't write to chips during detection, but here we don't
+	 * quite have the choice; hopefully it's OK, we are about to return
+	 * success anyway
+	 */
 	if ((bank & 0x07) != 0)
 		i2c_smbus_write_byte_data(client, W83795_REG_BANKSEL,
 					  bank & ~0x07);
@@ -2183,8 +2211,10 @@ static int w83795_probe(struct i2c_client *client,
 		/* The W83795G has a dedicated BEEP pin */
 		data->enable_beep = 1;
 	} else {
-		/* The W83795ADG has a shared pin for OVT# and BEEP, so you
-		 * can't have both */
+		/*
+		 * The W83795ADG has a shared pin for OVT# and BEEP, so you
+		 * can't have both
+		 */
 		tmp = w83795_read(client, W83795_REG_OVT_CFG);
 		if ((tmp & OVT_CFG_SEL) = 0)
 			data->enable_beep = 1;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
