From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:47 +0000
Subject: [lm-sensors] [PATCH 08/79] hwmon: (lm93) Fix checkpatch issues
Message-Id: <1327373398-997-9-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: else should follow close brace '}'
ERROR: space prohibited after that open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<=' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxW)
ERROR: trailing statements should be on next line
WARNING: braces {} are not necessary for any arm of this statement
WARNING: do not add new typedefs
WARNING: please, no space before tabs
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed (unknown impact):
WARNING: msleep < 20ms can sleep for up to 20ms

Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm93.c |  683 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 427 insertions(+), 256 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index d08e6f2..67e8fe2 100644
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
-        Copyright (c) 2006 Carsten Emde, Open Source Automation Development Lab
-
-    Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
-        Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
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
@@ -83,7 +83,7 @@
 #define LM93_REG_FAN_MIN(nr)		(0xb4 + (nr) * 2)
 
 /* pwm outputs: pwm1-pwm2 (nr => 0-1, reg => 0-3) */
-#define LM93_REG_PWM_CTL(nr,reg)	(0xc8 + (reg) + (nr) * 4)
+#define LM93_REG_PWM_CTL(nr, reg)	(0xc8 + (reg) + (nr) * 4)
 #define LM93_PWM_CTL1	0x0
 #define LM93_PWM_CTL2	0x1
 #define LM93_PWM_CTL3	0x2
@@ -160,7 +160,7 @@ static bool init;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to non-zero to force chip initialization.");
 
-static int vccp_limit_type[2] = {0,0};
+static int vccp_limit_type[2] = {0, 0};
 module_param_array(vccp_limit_type, int, NULL, 0);
 MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes.");
 
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
@@ -386,12 +398,14 @@ static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
 	return (uV_vid + uV_offset + 5000) / 10000;
 }
 
-#define LM93_IN_MIN_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,0,vid)
-#define LM93_IN_MAX_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,1,vid)
+#define LM93_IN_MIN_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 0, (vid))
+#define LM93_IN_MAX_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 1, (vid))
 
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
@@ -404,22 +418,26 @@ static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
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
 }
 
 #define LM93_TEMP_MIN (-128000)
-#define LM93_TEMP_MAX ( 127000)
+#define LM93_TEMP_MAX (127000)
 
-/* TEMP: 1/1000 degrees C (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 1/1000 degrees C (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static u8 LM93_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
-	ntemp += (ntemp<0 ? -500 : 500);
+	ntemp += (ntemp < 0 ? -500 : 500);
 	return (u8)(ntemp / 1000);
 }
 
@@ -430,21 +448,25 @@ static int LM93_TEMP_OFFSET_MODE_FROM_REG(u8 sfc2, int nr)
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
 }
 
-#define LM93_TEMP_OFFSET_MIN  (  0)
+#define LM93_TEMP_OFFSET_MIN  (0)
 #define LM93_TEMP_OFFSET_MAX0 (150)
-#define LM93_TEMP_OFFSET_MAX1 ( 75)
+#define LM93_TEMP_OFFSET_MAX1 (75)
 
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
@@ -532,9 +556,12 @@ static u8 LM93_AUTO_BOOST_HYST_TO_REG(struct lm93_data *data, long hyst,
 	return reg;
 }
 
-/* PWM: 0-255 per sensors documentation
-   REG: 0-13 as mapped below... right justified */
-typedef enum { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ } pwm_freq_t;
+/*
+ * PWM: 0-255 per sensors documentation
+ * REG: 0-13 as mapped below... right justified
+ */
+enum pwm_freq { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ };
+
 static int lm93_pwm_map[2][16] = {
 	{
 		0x00, /*   0.00% */ 0x40, /*  25.00% */
@@ -558,13 +585,13 @@ static int lm93_pwm_map[2][16] = {
 	},
 };
 
-static int LM93_PWM_FROM_REG(u8 reg, pwm_freq_t freq)
+static int LM93_PWM_FROM_REG(u8 reg, enum pwm_freq freq)
 {
 	return lm93_pwm_map[freq][reg & 0x0f];
 }
 
 /* round up to nearest match */
-static u8 LM93_PWM_TO_REG(int pwm, pwm_freq_t freq)
+static u8 LM93_PWM_TO_REG(int pwm, enum pwm_freq freq)
 {
 	int i;
 	for (i = 0; i < 13; i++)
@@ -578,7 +605,7 @@ static u8 LM93_PWM_TO_REG(int pwm, pwm_freq_t freq)
 static int LM93_FAN_FROM_REG(u16 regs)
 {
 	const u16 count = le16_to_cpu(regs) >> 2;
-	return count=0 ? -1 : count=0x3fff ? 0: 1350000 / count;
+	return count = 0 ? -1 : count = 0x3fff ? 0 : 1350000 / count;
 }
 
 /*
@@ -600,8 +627,10 @@ static u16 LM93_FAN_TO_REG(long rpm)
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
@@ -623,8 +652,10 @@ static u8 LM93_PWM_FREQ_TO_REG(int freq)
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
@@ -654,24 +685,30 @@ static int LM93_RAMP_FROM_REG(u8 reg)
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
@@ -693,22 +730,25 @@ static u8 LM93_INTERVAL_TO_REG(long interval)
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
@@ -772,11 +812,12 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 	int value, i;
 
 	/* retry in case of read errors */
-	for (i=1; i<=MAX_RETRIES; i++) {
-		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_byte_data(client, reg);
+		if (value >= 0) {
 			return value;
 		} else {
-			dev_warn(&client->dev,"lm93: read byte data failed, "
+			dev_warn(&client->dev, "lm93: read byte data failed, "
 				"address 0x%02x.\n", reg);
 			mdelay(i + 3);
 		}
@@ -784,7 +825,7 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 	}
 
 	/* <TODO> what to return in case of error? */
-	dev_err(&client->dev,"lm93: All read byte retries failed!!\n");
+	dev_err(&client->dev, "lm93: All read byte retries failed!!\n");
 	return 0;
 }
 
@@ -796,7 +837,7 @@ static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
 	result = i2c_smbus_write_byte_data(client, reg, value);
 
 	if (result < 0)
-		dev_warn(&client->dev,"lm93: write byte data failed, "
+		dev_warn(&client->dev, "lm93: write byte data failed, "
 			 "0x%02x at address 0x%02x.\n", value, reg);
 
 	return result;
@@ -807,11 +848,12 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 	int value, i;
 
 	/* retry in case of read errors */
-	for (i=1; i<=MAX_RETRIES; i++) {
-		if ((value = i2c_smbus_read_word_data(client, reg)) >= 0) {
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_word_data(client, reg);
+		if (value >= 0) {
 			return value;
 		} else {
-			dev_warn(&client->dev,"lm93: read word data failed, "
+			dev_warn(&client->dev, "lm93: read word data failed, "
 				 "address 0x%02x.\n", reg);
 			mdelay(i + 3);
 		}
@@ -819,7 +861,7 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 	}
 
 	/* <TODO> what to return in case of error? */
-	dev_err(&client->dev,"lm93: All read word retries failed!!\n");
+	dev_err(&client->dev, "lm93: All read word retries failed!!\n");
 	return 0;
 }
 
@@ -831,7 +873,7 @@ static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
 	result = i2c_smbus_write_word_data(client, reg, value);
 
 	if (result < 0)
-		dev_warn(&client->dev,"lm93: write word data failed, "
+		dev_warn(&client->dev, "lm93: write word data failed, "
 			 "0x%04x at address 0x%02x.\n", value, reg);
 
 	return result;
@@ -840,13 +882,13 @@ static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
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
-	int i, result=0;
+	int i, result = 0;
 
 	for (i = 1; i <= MAX_RETRIES; i++) {
 		result = i2c_smbus_read_block_data(client,
@@ -855,7 +897,7 @@ static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 		if (result = lm93_block_read_cmds[fbn].len) {
 			break;
 		} else {
-			dev_warn(&client->dev,"lm93: block read data failed, "
+			dev_warn(&client->dev, "lm93: block read data failed, "
 				 "command 0x%02x.\n",
 				 lm93_block_read_cmds[fbn].cmd);
 			mdelay(i + 3);
@@ -863,7 +905,8 @@ static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 	}
 
 	if (result = lm93_block_read_cmds[fbn].len) {
-		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
+		memcpy(values, lm93_block_buffer,
+		       lm93_block_read_cmds[fbn].len);
 	} else {
 		/* <TODO> what to do in case of error? */
 	}
@@ -964,7 +1007,7 @@ static void lm93_update_client_common(struct lm93_data *data,
 static void lm93_update_client_full(struct lm93_data *data,
 				    struct i2c_client *client)
 {
-	dev_dbg(&client->dev,"starting device update (block data enabled)\n");
+	dev_dbg(&client->dev, "starting device update (block data enabled)\n");
 
 	/* in1 - in16: values & limits */
 	lm93_read_block(client, 3, (u8 *)(data->block3));
@@ -996,10 +1039,10 @@ static void lm93_update_client_full(struct lm93_data *data,
 static void lm93_update_client_min(struct lm93_data *data,
 				   struct i2c_client *client)
 {
-	int i,j;
+	int i, j;
 	u8 *ptr;
 
-	dev_dbg(&client->dev,"starting device update (block data disabled)\n");
+	dev_dbg(&client->dev, "starting device update (block data disabled)\n");
 
 	/* in1 - in16: values & limits */
 	for (i = 0; i < 16; i++) {
@@ -1037,7 +1080,7 @@ static void lm93_update_client_min(struct lm93_data *data,
 	for (i = 0; i < 2; i++) {
 		for (j = 0; j < 4; j++) {
 			data->block9[i][j] -				lm93_read_byte(client, LM93_REG_PWM_CTL(i,j));
+				lm93_read_byte(client, LM93_REG_PWM_CTL(i, j));
 		}
 	}
 
@@ -1097,14 +1140,13 @@ static ssize_t show_in_min(struct device *dev,
 	int vccp = nr - 6;
 	long rc, vid;
 
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
 		rc = LM93_IN_MIN_FROM_REG(data->vccp_limits[vccp], vid);
+	} else {
+		rc = LM93_IN_FROM_REG(nr, data->block7[nr].min);
 	}
-	else {
-		rc = LM93_IN_FROM_REG(nr, data->block7[nr].min); \
-	}
-	return sprintf(buf, "%ld\n", rc); \
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
@@ -1113,20 +1155,24 @@ static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	int vccp = nr - 6;
 	long vid;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
 		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & 0xf0) |
 				LM93_IN_REL_TO_REG(val, 0, vid);
 		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp),
 				data->vccp_limits[vccp]);
-	}
-	else {
-		data->block7[nr].min = LM93_IN_TO_REG(nr,val);
+	} else {
+		data->block7[nr].min = LM93_IN_TO_REG(nr, val);
 		lm93_write_byte(client, LM93_REG_IN_MIN(nr),
 				data->block7[nr].min);
 	}
@@ -1175,14 +1221,13 @@ static ssize_t show_in_max(struct device *dev,
 	int vccp = nr - 6;
 	long rc, vid;
 
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
-		rc = LM93_IN_MAX_FROM_REG(data->vccp_limits[vccp],vid);
-	}
-	else {
-		rc = LM93_IN_FROM_REG(nr,data->block7[nr].max); \
+		rc = LM93_IN_MAX_FROM_REG(data->vccp_limits[vccp], vid);
+	} else {
+		rc = LM93_IN_FROM_REG(nr, data->block7[nr].max);
 	}
-	return sprintf(buf,"%ld\n",rc); \
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
@@ -1191,20 +1236,24 @@ static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	int vccp = nr - 6;
 	long vid;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
 		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & 0x0f) |
 				LM93_IN_REL_TO_REG(val, 1, vid);
 		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp),
 				data->vccp_limits[vccp]);
-	}
-	else {
-		data->block7[nr].max = LM93_IN_TO_REG(nr,val);
+	} else {
+		data->block7[nr].max = LM93_IN_TO_REG(nr, val);
 		lm93_write_byte(client, LM93_REG_IN_MAX(nr),
 				data->block7[nr].max);
 	}
@@ -1250,7 +1299,7 @@ static ssize_t show_temp(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block2[nr]));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->block2[nr]));
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
@@ -1262,7 +1311,7 @@ static ssize_t show_temp_min(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->temp_lim[nr].min));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->temp_lim[nr].min));
 }
 
 static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
@@ -1271,7 +1320,12 @@ static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].min = LM93_TEMP_TO_REG(val);
@@ -1292,7 +1346,7 @@ static ssize_t show_temp_max(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->temp_lim[nr].max));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->temp_lim[nr].max));
 }
 
 static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
@@ -1301,7 +1355,12 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].max = LM93_TEMP_TO_REG(val);
@@ -1322,7 +1381,7 @@ static ssize_t show_temp_auto_base(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block10.base[nr]));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->block10.base[nr]));
 }
 
 static ssize_t store_temp_auto_base(struct device *dev,
@@ -1332,7 +1391,12 @@ static ssize_t store_temp_auto_base(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->block10.base[nr] = LM93_TEMP_TO_REG(val);
@@ -1349,11 +1413,11 @@ static SENSOR_DEVICE_ATTR(temp3_auto_base, S_IWUSR | S_IRUGO,
 			  show_temp_auto_base, store_temp_auto_base, 2);
 
 static ssize_t show_temp_auto_boost(struct device *dev,
-				    struct device_attribute *attr,char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->boost[nr]));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->boost[nr]));
 }
 
 static ssize_t store_temp_auto_boost(struct device *dev,
@@ -1363,7 +1427,12 @@ static ssize_t store_temp_auto_boost(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->boost[nr] = LM93_TEMP_TO_REG(val);
@@ -1386,7 +1455,7 @@ static ssize_t show_temp_auto_boost_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_AUTO_BOOST_HYST_FROM_REGS(data, nr, mode));
 }
 
@@ -1397,7 +1466,12 @@ static ssize_t store_temp_auto_boost_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* force 0.5C/bit mode */
@@ -1429,9 +1503,9 @@ static ssize_t show_temp_auto_offset(struct device *dev,
 	int ofs = s_attr->nr;
 	struct lm93_data *data = lm93_update_device(dev);
 	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 	       LM93_TEMP_AUTO_OFFSET_FROM_REG(data->block10.offset[ofs],
-					      nr,mode));
+					      nr, mode));
 }
 
 static ssize_t store_temp_auto_offset(struct device *dev,
@@ -1443,7 +1517,12 @@ static ssize_t store_temp_auto_offset(struct device *dev,
 	int ofs = s_attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* force 0.5C/bit mode */
@@ -1539,7 +1618,7 @@ static ssize_t show_temp_auto_pwm_min(struct device *dev,
 	struct lm93_data *data = lm93_update_device(dev);
 	reg = data->auto_pwm_min_hyst[nr/2] >> 4 & 0x0f;
 	ctl4 = data->block9[nr][LM93_PWM_CTL4];
-	return sprintf(buf,"%d\n",LM93_PWM_FROM_REG(reg, (ctl4 & 0x07) ?
+	return sprintf(buf, "%d\n", LM93_PWM_FROM_REG(reg, (ctl4 & 0x07) ?
 				LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
 }
 
@@ -1550,12 +1629,17 @@ static ssize_t store_temp_auto_pwm_min(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 reg, ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	reg = lm93_read_byte(client, LM93_REG_PWM_MIN_HYST(nr));
-	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
 	reg = (reg & 0x0f) |
 		LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
 				LM93_PWM_MAP_LO_FREQ :
@@ -1582,8 +1666,8 @@ static ssize_t show_temp_auto_offset_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
-	return sprintf(buf,"%d\n",LM93_TEMP_OFFSET_FROM_REG(
-					data->auto_pwm_min_hyst[nr/2], mode));
+	return sprintf(buf, "%d\n", LM93_TEMP_OFFSET_FROM_REG(
+					data->auto_pwm_min_hyst[nr / 2], mode));
 }
 
 static ssize_t store_temp_auto_offset_hyst(struct device *dev,
@@ -1593,8 +1677,13 @@ static ssize_t store_temp_auto_offset_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* force 0.5C/bit mode */
@@ -1626,7 +1715,7 @@ static ssize_t show_fan_input(struct device *dev,
 	int nr = s_attr->index;
 	struct lm93_data *data = lm93_update_device(dev);
 
-	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block5[nr]));
+	return sprintf(buf, "%d\n", LM93_FAN_FROM_REG(data->block5[nr]));
 }
 
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
@@ -1640,7 +1729,7 @@ static ssize_t show_fan_min(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 
-	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block8[nr]));
+	return sprintf(buf, "%d\n", LM93_FAN_FROM_REG(data->block8[nr]));
 }
 
 static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
@@ -1649,11 +1738,16 @@ static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->block8[nr] = LM93_FAN_TO_REG(val);
-	lm93_write_word(client,LM93_REG_FAN_MIN(nr),data->block8[nr]);
+	lm93_write_word(client, LM93_REG_FAN_MIN(nr), data->block8[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1667,18 +1761,19 @@ static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO,
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
+ *	data->sf_tach_to_pwm: (tach to pwm mapping bits)
+ *
+ *		bit |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0
+ *		     T4:P2 T4:P1 T3:P2 T3:P1 T2:P2 T2:P1 T1:P2 T1:P1
+ *
+ *	data->sfc2: (enable bits)
+ *
+ *		bit |  3  |  2  |  1  |  0
+ *		       T4    T3    T2    T1
+ */
 
 static ssize_t show_fan_smart_tach(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1694,11 +1789,13 @@ static ssize_t show_fan_smart_tach(struct device *dev,
 	/* if there's a mapping and it's enabled */
 	if (mapping && ((data->sfc2 >> nr) & 0x01))
 		rc = mapping;
-	return sprintf(buf,"%ld\n",rc);
+	return sprintf(buf, "%ld\n", rc);
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
@@ -1724,7 +1821,12 @@ static ssize_t store_fan_smart_tach(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* sanity test, ignore the write otherwise */
@@ -1732,7 +1834,7 @@ static ssize_t store_fan_smart_tach(struct device *dev,
 		/* can't enable if pwm freq is 22.5KHz */
 		if (val) {
 			u8 ctl4 = lm93_read_byte(client,
-				LM93_REG_PWM_CTL(val-1,LM93_PWM_CTL4));
+				LM93_REG_PWM_CTL(val - 1, LM93_PWM_CTL4));
 			if ((ctl4 & 0x07) = 0)
 				val = 0;
 		}
@@ -1766,7 +1868,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 	else /* show present h/w value if manual pwm disabled */
 		rc = LM93_PWM_FROM_REG(ctl2 >> 4, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ);
-	return sprintf(buf,"%ld\n",rc);
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
@@ -1775,19 +1877,24 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl2, ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
-	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
-	ctl2 = (ctl2 & 0x0f) | LM93_PWM_TO_REG(val,(ctl4 & 0x07) ?
+	ctl2 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
+	ctl2 = (ctl2 & 0x0f) | LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ) << 4;
 	/* save user commanded value */
 	data->pwm_override[nr] = LM93_PWM_FROM_REG(ctl2 >> 4,
 			(ctl4 & 0x07) ?  LM93_PWM_MAP_LO_FREQ :
 			LM93_PWM_MAP_HI_FREQ);
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2), ctl2);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1808,7 +1915,7 @@ static ssize_t show_pwm_enable(struct device *dev,
 		rc = ((ctl2 & 0xF0) = 0xF0) ? 0 : 1;
 	else
 		rc = 2;
-	return sprintf(buf,"%ld\n",rc);
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_pwm_enable(struct device *dev,
@@ -1818,26 +1925,33 @@ static ssize_t store_pwm_enable(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl2;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
+	ctl2 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2));
 
 	switch (val) {
 	case 0:
 		ctl2 |= 0xF1; /* enable manual override, set PWM to max */
 		break;
-	case 1: ctl2 |= 0x01; /* enable manual override */
+	case 1:
+		ctl2 |= 0x01; /* enable manual override */
 		break;
-	case 2: ctl2 &= ~0x01; /* disable manual override */
+	case 2:
+		ctl2 &= ~0x01; /* disable manual override */
 		break;
 	default:
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
 
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2), ctl2);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1855,12 +1969,14 @@ static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
 	u8 ctl4;
 
 	ctl4 = data->block9[nr][LM93_PWM_CTL4];
-	return sprintf(buf,"%d\n",LM93_PWM_FREQ_FROM_REG(ctl4));
+	return sprintf(buf, "%d\n", LM93_PWM_FREQ_FROM_REG(ctl4));
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
@@ -1887,17 +2003,22 @@ static ssize_t store_pwm_freq(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
 	ctl4 = (ctl4 & 0xf8) | LM93_PWM_FREQ_TO_REG(val);
 	data->block9[nr][LM93_PWM_CTL4] = ctl4;
 	/* ctl4 = 0 -> 22.5KHz -> disable smart tach */
 	if (!ctl4)
 		lm93_disable_fan_smart_tach(client, data, nr);
-	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4), ctl4);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4), ctl4);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1912,7 +2033,7 @@ static ssize_t show_pwm_auto_channels(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->block9[nr][LM93_PWM_CTL1]);
+	return sprintf(buf, "%d\n", data->block9[nr][LM93_PWM_CTL1]);
 }
 
 static ssize_t store_pwm_auto_channels(struct device *dev,
@@ -1922,11 +2043,16 @@ static ssize_t store_pwm_auto_channels(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->block9[nr][LM93_PWM_CTL1] = SENSORS_LIMIT(val, 0, 255);
-	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL1),
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL1),
 				data->block9[nr][LM93_PWM_CTL1]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1938,7 +2064,7 @@ static SENSOR_DEVICE_ATTR(pwm2_auto_channels, S_IWUSR | S_IRUGO,
 			  show_pwm_auto_channels, store_pwm_auto_channels, 1);
 
 static ssize_t show_pwm_auto_spinup_min(struct device *dev,
-				struct device_attribute *attr,char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
@@ -1946,7 +2072,7 @@ static ssize_t show_pwm_auto_spinup_min(struct device *dev,
 
 	ctl3 = data->block9[nr][LM93_PWM_CTL3];
 	ctl4 = data->block9[nr][LM93_PWM_CTL4];
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_PWM_FROM_REG(ctl3 & 0x0f, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
 }
@@ -1958,17 +2084,22 @@ static ssize_t store_pwm_auto_spinup_min(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl3, ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
-	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
-	ctl3 = (ctl3 & 0xf0) | 	LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
+	ctl3 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
+	ctl3 = (ctl3 & 0xf0) | LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ :
 			LM93_PWM_MAP_HI_FREQ);
 	data->block9[nr][LM93_PWM_CTL3] = ctl3;
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1985,7 +2116,7 @@ static ssize_t show_pwm_auto_spinup_time(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_SPINUP_TIME_FROM_REG(
+	return sprintf(buf, "%d\n", LM93_SPINUP_TIME_FROM_REG(
 				data->block9[nr][LM93_PWM_CTL3]));
 }
 
@@ -1996,14 +2127,19 @@ static ssize_t store_pwm_auto_spinup_time(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl3;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
+	ctl3 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
 	ctl3 = (ctl3 & 0x1f) | (LM93_SPINUP_TIME_TO_REG(val) << 5 & 0xe0);
 	data->block9[nr][LM93_PWM_CTL3] = ctl3;
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2019,7 +2155,7 @@ static ssize_t show_pwm_auto_prochot_ramp(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl >> 4 & 0x0f));
 }
 
@@ -2029,8 +2165,13 @@ static ssize_t store_pwm_auto_prochot_ramp(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ramp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
@@ -2048,7 +2189,7 @@ static ssize_t show_pwm_auto_vrdhot_ramp(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl & 0x0f));
 }
 
@@ -2058,8 +2199,13 @@ static ssize_t store_pwm_auto_vrdhot_ramp(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ramp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
@@ -2078,7 +2224,7 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_VID_FROM_REG(data->vid[nr]));
+	return sprintf(buf, "%d\n", LM93_VID_FROM_REG(data->vid[nr]));
 }
 
 static SENSOR_DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL, 0);
@@ -2089,7 +2235,7 @@ static ssize_t show_prochot(struct device *dev, struct device_attribute *attr,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->block4[nr].cur);
+	return sprintf(buf, "%d\n", data->block4[nr].cur);
 }
 
 static SENSOR_DEVICE_ATTR(prochot1, S_IRUGO, show_prochot, NULL, 0);
@@ -2100,7 +2246,7 @@ static ssize_t show_prochot_avg(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->block4[nr].avg);
+	return sprintf(buf, "%d\n", data->block4[nr].avg);
 }
 
 static SENSOR_DEVICE_ATTR(prochot1_avg, S_IRUGO, show_prochot_avg, NULL, 0);
@@ -2111,7 +2257,7 @@ static ssize_t show_prochot_max(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->prochot_max[nr]);
+	return sprintf(buf, "%d\n", data->prochot_max[nr]);
 }
 
 static ssize_t store_prochot_max(struct device *dev,
@@ -2121,7 +2267,12 @@ static ssize_t store_prochot_max(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->prochot_max[nr] = LM93_PROCHOT_TO_REG(val);
@@ -2143,7 +2294,7 @@ static ssize_t show_prochot_override(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		(data->prochot_override & prochot_override_mask[nr]) ? 1 : 0);
 }
 
@@ -2154,7 +2305,12 @@ static ssize_t store_prochot_override(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	if (val)
@@ -2178,11 +2334,11 @@ static ssize_t show_prochot_interval(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 	u8 tmp;
-	if (nr=1)
+	if (nr = 1)
 		tmp = (data->prochot_interval & 0xf0) >> 4;
 	else
 		tmp = data->prochot_interval & 0x0f;
-	return sprintf(buf,"%d\n",LM93_INTERVAL_FROM_REG(tmp));
+	return sprintf(buf, "%d\n", LM93_INTERVAL_FROM_REG(tmp));
 }
 
 static ssize_t store_prochot_interval(struct device *dev,
@@ -2192,12 +2348,17 @@ static ssize_t store_prochot_interval(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 tmp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	tmp = lm93_read_byte(client, LM93_REG_PROCHOT_INTERVAL);
-	if (nr=1)
+	if (nr = 1)
 		tmp = (tmp & 0x0f) | (LM93_INTERVAL_TO_REG(val) << 4);
 	else
 		tmp = (tmp & 0xf0) | LM93_INTERVAL_TO_REG(val);
@@ -2217,7 +2378,7 @@ static ssize_t show_prochot_override_duty_cycle(struct device *dev,
 						char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->prochot_override & 0x0f);
+	return sprintf(buf, "%d\n", data->prochot_override & 0x0f);
 }
 
 static ssize_t store_prochot_override_duty_cycle(struct device *dev,
@@ -2226,7 +2387,12 @@ static ssize_t store_prochot_override_duty_cycle(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->prochot_override = (data->prochot_override & 0xf0) |
@@ -2245,7 +2411,7 @@ static ssize_t show_prochot_short(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",(data->config & 0x10) ? 1 : 0);
+	return sprintf(buf, "%d\n", (data->config & 0x10) ? 1 : 0);
 }
 
 static ssize_t store_prochot_short(struct device *dev,
@@ -2254,7 +2420,12 @@ static ssize_t store_prochot_short(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	if (val)
@@ -2274,8 +2445,8 @@ static ssize_t show_vrdhot(struct device *dev, struct device_attribute *attr,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
-		       data->block1.host_status_1 & (1 << (nr+4)) ? 1 : 0);
+	return sprintf(buf, "%d\n",
+		       data->block1.host_status_1 & (1 << (nr + 4)) ? 1 : 0);
 }
 
 static SENSOR_DEVICE_ATTR(vrdhot1, S_IRUGO, show_vrdhot, NULL, 0);
@@ -2285,7 +2456,7 @@ static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_GPI_FROM_REG(data->gpi));
+	return sprintf(buf, "%d\n", LM93_GPI_FROM_REG(data->gpi));
 }
 
 static DEVICE_ATTR(gpio, S_IRUGO, show_gpio, NULL);
@@ -2294,7 +2465,7 @@ static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_ALARMS_FROM_REG(data->block1));
+	return sprintf(buf, "%d\n", LM93_ALARMS_FROM_REG(data->block1));
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
@@ -2494,13 +2665,13 @@ static void lm93_init_client(struct i2c_client *client)
 	lm93_write_byte(client, LM93_REG_CONFIG, reg | 0x01);
 
 	/* spin until ready */
-	for (i=0; i<20; i++) {
+	for (i = 0; i < 20; i++) {
 		msleep(10);
 		if ((lm93_read_byte(client, LM93_REG_CONFIG) & 0x80) = 0x80)
 			return;
 	}
 
-	dev_warn(&client->dev,"timed out waiting for sensor "
+	dev_warn(&client->dev, "timed out waiting for sensor "
 		 "chip to signal ready!\n");
 }
 
@@ -2540,7 +2711,7 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
 	}
 
 	strlcpy(info->type, name, I2C_NAME_SIZE);
-	dev_dbg(&adapter->dev,"loading %s at %d,0x%02x\n",
+	dev_dbg(&adapter->dev, "loading %s at %d, 0x%02x\n",
 		client->name, i2c_adapter_id(client->adapter),
 		client->addr);
 
@@ -2593,7 +2764,7 @@ static int lm93_probe(struct i2c_client *client,
 
 	/* Register hwmon driver class */
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if ( !IS_ERR(data->hwmon_dev))
+	if (!IS_ERR(data->hwmon_dev))
 		return 0;
 
 	err = PTR_ERR(data->hwmon_dev);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
