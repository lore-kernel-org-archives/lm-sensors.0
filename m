From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:37 +0000
Subject: [lm-sensors] [PATCH 43/82] hwmon: (lm93) Fix multi-line comments
Message-Id: <1327017376-20466-44-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm93.c |  286 +++++++++++++++++++++++++++++---------------------
 1 files changed, 165 insertions(+), 121 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index d2fc4ac..882b8423 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -1,42 +1,42 @@
 /*
-    lm93.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
-
-    Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
-	Copyright (c) 2004 Utilitek Systems, Inc.
-
-    derived in part from lm78.c:
-	Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-
-    derived in part from lm85.c:
-	Copyright (c) 2002, 2003 Philip Pokorny <ppokorny@penguincomputing.com>
-	Copyright (c) 2003       Margit Schubert-While <margitsw@t-online.de>
-
-    derived in part from w83l785ts.c:
-	Copyright (c) 2003-2004 Jean Delvare <khali@linux-fr.org>
-
-    Ported to Linux 2.6 by Eric J. Bowersox <ericb@aspsys.com>
-	Copyright (c) 2005 Aspen Systems, Inc.
-
-    Adapted to 2.6.20 by Carsten Emde <cbe@osadl.org>
-	Copyright (c) 2006 Carsten Emde, Open Source Automation Development Lab
-
-    Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
-	Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
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
+ * lm93.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
+ *
+ * Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
+ *	Copyright (c) 2004 Utilitek Systems, Inc.
+ *
+ * derived in part from lm78.c:
+ *	Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+ *
+ * derived in part from lm85.c:
+ *	Copyright (c) 2002, 2003 Philip Pokorny <ppokorny@penguincomputing.com>
+ *	Copyright (c) 2003       Margit Schubert-While <margitsw@t-online.de>
+ *
+ * derived in part from w83l785ts.c:
+ *	Copyright (c) 2003-2004 Jean Delvare <khali@linux-fr.org>
+ *
+ * Ported to Linux 2.6 by Eric J. Bowersox <ericb@aspsys.com>
+ *	Copyright (c) 2005 Aspen Systems, Inc.
+ *
+ * Adapted to 2.6.20 by Carsten Emde <cbe@osadl.org>
+ *	Copyright (c) 2006 Carsten Emde, Open Source Automation Development Lab
+ *
+ * Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
+ *	Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
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
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -187,8 +187,10 @@ static const struct { u8 cmd; u8 len; } lm93_block_read_cmds[12] = {
 	{ 0xfd,  9 },
 };
 
-/* ALARMS: SYSCTL format described further below
-   REG: 64 bits in 8 registers, as immediately below */
+/*
+ * ALARMS: SYSCTL format described further below
+ * REG: 64 bits in 8 registers, as immediately below
+ */
 struct block1_t {
 	u8 host_status_1;
 	u8 host_status_2;
@@ -217,8 +219,10 @@ struct lm93_data {
 	/* register values, arranged by block read groups */
 	struct block1_t block1;
 
-	/* temp1 - temp4: unfiltered readings
-	   temp1 - temp2: filtered readings */
+	/*
+	 * temp1 - temp4: unfiltered readings
+	 * temp1 - temp2: filtered readings
+	 */
 	u8 block2[6];
 
 	/* vin1 - vin16: readings */
@@ -295,14 +299,18 @@ struct lm93_data {
 	u8 sfc2;
 	u8 sf_tach_to_pwm;
 
-	/* The two PWM CTL2  registers can read something other than what was
-	   last written for the OVR_DC field (duty cycle override).  So, we
-	   save the user-commanded value here. */
+	/*
+	 * The two PWM CTL2  registers can read something other than what was
+	 * last written for the OVR_DC field (duty cycle override).  So, we
+	 * save the user-commanded value here.
+	 */
 	u8 pwm_override[2];
 };
 
-/* VID:	mV
-   REG: 6-bits, right justified, *always* using Intel VRM/VRD 10 */
+/*
+ * VID:	mV
+ * REG: 6-bits, right justified, *always* using Intel VRM/VRD 10
+ */
 static int LM93_VID_FROM_REG(u8 reg)
 {
 	return vid_from_reg((reg & 0x3f), 100);
@@ -317,12 +325,13 @@ static const u8 lm93_vin_reg_max[16] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	0xff, 0xfa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xd1,
 };
-/* Values from the datasheet. They're here for documentation only.
-static const u8 lm93_vin_reg_nom[16] = {
-	0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0,
-	0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x40, 0xc0,
-};
-*/
+/*
+ * Values from the datasheet. They're here for documentation only.
+ * static const u8 lm93_vin_reg_nom[16] = {
+ * 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0,
+ * 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x40, 0xc0,
+ * };
+ */
 
 /* min, max, and nominal voltage readings, per channel (mV)*/
 static const unsigned long lm93_vin_val_min[16] = {
@@ -334,12 +343,13 @@ static const unsigned long lm93_vin_val_max[16] = {
 	1236, 1236, 1236, 1600, 2000, 2000, 1600, 1600,
 	4400, 6500, 3333, 2625, 1312, 1312, 1236, 3600,
 };
-/* Values from the datasheet. They're here for documentation only.
-static const unsigned long lm93_vin_val_nom[16] = {
-	 927,  927,  927, 1200, 1500, 1500, 1200, 1200,
-	3300, 5000, 2500, 1969,  984,  984,  309, 3300,
-};
-*/
+/*
+ * Values from the datasheet. They're here for documentation only.
+ * static const unsigned long lm93_vin_val_nom[16] = {
+ * 927,  927,  927, 1200, 1500, 1500, 1200, 1200,
+ * 3300, 5000, 2500, 1969,  984,  984,  309, 3300,
+ * };
+ */
 
 static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
 {
@@ -353,8 +363,10 @@ static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
 	return (slope * reg + intercept + 500) / 1000;
 }
 
-/* IN: mV, limits determined by channel nr
-   REG: scaling determined by channel nr */
+/*
+ * IN: mV, limits determined by channel nr
+ * REG: scaling determined by channel nr
+ */
 static u8 LM93_IN_TO_REG(int nr, unsigned val)
 {
 	/* range limit */
@@ -389,9 +401,11 @@ static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
 #define LM93_IN_MIN_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 0, (vid))
 #define LM93_IN_MAX_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 1, (vid))
 
-/* vid in mV , upper = 0 indicates low limit, otherwise upper limit
-   upper also determines which nibble of the register is returned
-   (the other nibble will be 0x0) */
+/*
+ * vid in mV , upper = 0 indicates low limit, otherwise upper limit
+ * upper also determines which nibble of the register is returned
+ * (the other nibble will be 0x0)
+ */
 static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
 {
 	long uV_offset = vid * 1000 - val * 10000;
@@ -404,8 +418,10 @@ static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
 	}
 }
 
-/* TEMP: 1/1000 degrees C (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 1/1000 degrees C (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static int LM93_TEMP_FROM_REG(u8 reg)
 {
 	return (s8)reg * 1000;
@@ -414,8 +430,10 @@ static int LM93_TEMP_FROM_REG(u8 reg)
 #define LM93_TEMP_MIN (-128000)
 #define LM93_TEMP_MAX (127000)
 
-/* TEMP: 1/1000 degrees C (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 1/1000 degrees C (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static u8 LM93_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
@@ -430,9 +448,11 @@ static int LM93_TEMP_OFFSET_MODE_FROM_REG(u8 sfc2, int nr)
 	return sfc2 & (nr < 2 ? 0x10 : 0x20);
 }
 
-/* This function is common to all 4-bit temperature offsets
-   reg is 4 bits right justified
-   mode 0 => 1C/bit, mode !0 => 0.5C/bit */
+/*
+ * This function is common to all 4-bit temperature offsets
+ * reg is 4 bits right justified
+ * mode 0 => 1C/bit, mode !0 => 0.5C/bit
+ */
 static int LM93_TEMP_OFFSET_FROM_REG(u8 reg, int mode)
 {
 	return (reg & 0x0f) * (mode ? 5 : 10);
@@ -442,9 +462,11 @@ static int LM93_TEMP_OFFSET_FROM_REG(u8 reg, int mode)
 #define LM93_TEMP_OFFSET_MAX0 (150)
 #define LM93_TEMP_OFFSET_MAX1 (75)
 
-/* This function is common to all 4-bit temperature offsets
-   returns 4 bits right justified
-   mode 0 => 1C/bit, mode !0 => 0.5C/bit */
+/*
+ * This function is common to all 4-bit temperature offsets
+ * returns 4 bits right justified
+ * mode 0 => 1C/bit, mode !0 => 0.5C/bit
+ */
 static u8 LM93_TEMP_OFFSET_TO_REG(int off, int mode)
 {
 	int factor = mode ? 5 : 10;
@@ -466,9 +488,11 @@ static int LM93_TEMP_AUTO_OFFSET_FROM_REG(u8 reg, int nr, int mode)
 		return LM93_TEMP_OFFSET_FROM_REG(reg >> 4 & 0x0f, mode);
 }
 
-/* TEMP: 1/10 degrees C (0C to +15C (mode 0) or +7.5C (mode non-zero))
-   REG: 1.0C/bit (mode 0) or 0.5C/bit (mode non-zero)
-   0 <= nr <= 3 */
+/*
+ * TEMP: 1/10 degrees C (0C to +15C (mode 0) or +7.5C (mode non-zero))
+ * REG: 1.0C/bit (mode 0) or 0.5C/bit (mode non-zero)
+ * 0 <= nr <= 3
+ */
 static u8 LM93_TEMP_AUTO_OFFSET_TO_REG(u8 old, int off, int nr, int mode)
 {
 	u8 new = LM93_TEMP_OFFSET_TO_REG(off, mode);
@@ -532,8 +556,10 @@ static u8 LM93_AUTO_BOOST_HYST_TO_REG(struct lm93_data *data, long hyst,
 	return reg;
 }
 
-/* PWM: 0-255 per sensors documentation
-   REG: 0-13 as mapped below... right justified */
+/*
+ * PWM: 0-255 per sensors documentation
+ * REG: 0-13 as mapped below... right justified
+ */
 enum pwm_freq { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ };
 
 static int lm93_pwm_map[2][16] = {
@@ -601,8 +627,10 @@ static u16 LM93_FAN_TO_REG(long rpm)
 	return cpu_to_le16(regs);
 }
 
-/* PWM FREQ: HZ
-   REG: 0-7 as mapped below */
+/*
+ * PWM FREQ: HZ
+ * REG: 0-7 as mapped below
+ */
 static int lm93_pwm_freq_map[8] = {
 	22500, 96, 84, 72, 60, 48, 36, 12
 };
@@ -624,8 +652,10 @@ static u8 LM93_PWM_FREQ_TO_REG(int freq)
 	return (u8)i;
 }
 
-/* TIME: 1/100 seconds
- * REG: 0-7 as mapped below */
+/*
+ * TIME: 1/100 seconds
+ * REG: 0-7 as mapped below
+ */
 static int lm93_spinup_time_map[8] = {
 	0, 10, 25, 40, 70, 100, 200, 400,
 };
@@ -655,24 +685,30 @@ static int LM93_RAMP_FROM_REG(u8 reg)
 	return (reg & 0x0f) * 5;
 }
 
-/* RAMP: 1/100 seconds
-   REG: 50mS/bit 4-bits right justified */
+/*
+ * RAMP: 1/100 seconds
+ * REG: 50mS/bit 4-bits right justified
+ */
 static u8 LM93_RAMP_TO_REG(int ramp)
 {
 	ramp = SENSORS_LIMIT(ramp, LM93_RAMP_MIN, LM93_RAMP_MAX);
 	return (u8)((ramp + 2) / 5);
 }
 
-/* PROCHOT: 0-255, 0 => 0%, 255 => > 96.6%
- * REG: (same) */
+/*
+ * PROCHOT: 0-255, 0 => 0%, 255 => > 96.6%
+ * REG: (same)
+ */
 static u8 LM93_PROCHOT_TO_REG(long prochot)
 {
 	prochot = SENSORS_LIMIT(prochot, 0, 255);
 	return (u8)prochot;
 }
 
-/* PROCHOT-INTERVAL: 73 - 37200 (1/100 seconds)
- * REG: 0-9 as mapped below */
+/*
+ * PROCHOT-INTERVAL: 73 - 37200 (1/100 seconds)
+ * REG: 0-9 as mapped below
+ */
 static int lm93_interval_map[10] = {
 	73, 146, 290, 580, 1170, 2330, 4660, 9320, 18600, 37200,
 };
@@ -694,22 +730,25 @@ static u8 LM93_INTERVAL_TO_REG(long interval)
 	return (u8)i;
 }
 
-/* GPIO: 0-255, GPIO0 is LSB
- * REG: inverted */
+/*
+ * GPIO: 0-255, GPIO0 is LSB
+ * REG: inverted
+ */
 static unsigned LM93_GPI_FROM_REG(u8 reg)
 {
 	return ~reg & 0xff;
 }
 
-/* alarm bitmask definitions
-   The LM93 has nearly 64 bits of error status... I've pared that down to
-   what I think is a useful subset in order to fit it into 32 bits.
-
-   Especially note that the #VRD_HOT alarms are missing because we provide
-   that information as values in another sysfs file.
-
-   If libsensors is extended to support 64 bit values, this could be revisited.
-*/
+/*
+ * alarm bitmask definitions
+ * The LM93 has nearly 64 bits of error status... I've pared that down to
+ * what I think is a useful subset in order to fit it into 32 bits.
+ *
+ * Especially note that the #VRD_HOT alarms are missing because we provide
+ * that information as values in another sysfs file.
+ *
+ * If libsensors is extended to support 64 bit values, this could be revisited.
+ */
 #define LM93_ALARM_IN1		0x00000001
 #define LM93_ALARM_IN2		0x00000002
 #define LM93_ALARM_IN3		0x00000004
@@ -843,10 +882,10 @@ static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
 static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
 
 /*
-	read block data into values, retry if not expected length
-	fbn => index to lm93_block_read_cmds table
-		(Fixed Block Number - section 14.5.2 of LM93 datasheet)
-*/
+ * read block data into values, retry if not expected length
+ * fbn => index to lm93_block_read_cmds table
+ * (Fixed Block Number - section 14.5.2 of LM93 datasheet)
+ */
 static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 {
 	int i, result = 0;
@@ -1721,18 +1760,19 @@ static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO,
 			  show_fan_min, store_fan_min, 3);
 
-/* some tedious bit-twiddling here to deal with the register format:
-
-	data->sf_tach_to_pwm: (tach to pwm mapping bits)
-
-		bit |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0
-		     T4:P2 T4:P1 T3:P2 T3:P1 T2:P2 T2:P1 T1:P2 T1:P1
-
-	data->sfc2: (enable bits)
-
-		bit |  3  |  2  |  1  |  0
-		       T4    T3    T2    T1
-*/
+/*
+ * some tedious bit-twiddling here to deal with the register format:
+ *
+ * data->sf_tach_to_pwm: (tach to pwm mapping bits)
+ *
+ * bit |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0
+ * T4:P2 T4:P1 T3:P2 T3:P1 T2:P2 T2:P1 T1:P2 T1:P1
+ *
+ * data->sfc2: (enable bits)
+ *
+ * bit |  3  |  2  |  1  |  0
+ * T4    T3    T2    T1
+ */
 
 static ssize_t show_fan_smart_tach(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1751,8 +1791,10 @@ static ssize_t show_fan_smart_tach(struct device *dev,
 	return sprintf(buf, "%ld\n", rc);
 }
 
-/* helper function - must grab data->update_lock before calling
-   fan is 0-3, indicating fan1-fan4 */
+/*
+ * helper function - must grab data->update_lock before calling
+ * fan is 0-3, indicating fan1-fan4
+ */
 static void lm93_write_fan_smart_tach(struct i2c_client *client,
 	struct lm93_data *data, int fan, long value)
 {
@@ -1929,9 +1971,11 @@ static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", LM93_PWM_FREQ_FROM_REG(ctl4));
 }
 
-/* helper function - must grab data->update_lock before calling
-   pwm is 0-1, indicating pwm1-pwm2
-   this disables smart tach for all tach channels bound to the given pwm */
+/*
+ * helper function - must grab data->update_lock before calling
+ * pwm is 0-1, indicating pwm1-pwm2
+ * this disables smart tach for all tach channels bound to the given pwm
+ */
 static void lm93_disable_fan_smart_tach(struct i2c_client *client,
 	struct lm93_data *data, int pwm)
 {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
