From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:08 +0000
Subject: [lm-sensors] [PATCH 74/82] hwmon: (w83627hf) Fix multi-line comments
Message-Id: <1327017376-20466-75-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |  132 ++++++++++++++++++++++++++--------------------
 1 files changed, 74 insertions(+), 58 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 3162309..aaa2ad7 100644
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
@@ -371,12 +379,16 @@ struct w83627hf_data {
 	u32 alarms;		/* Register encoding, combined */
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 pwm[3];		/* Register value */
-	u8 pwm_enable[3];	/* 1 = manual
-				   2 = thermal cruise (also called SmartFan I)
-				   3 = fan speed cruise */
+	u8 pwm_enable[3];	/*
+				 * 1 = manual
+				 * 2 = thermal cruise (also called SmartFan I)
+				 * 3 = fan speed cruise
+				 */
 	u8 pwm_freq[3];		/* Register value */
-	u16 sens[3];		/* 1 = pentium diode; 2 = 3904 diode;
-				   4 = thermistor */
+	u16 sens[3];		/*
+				 * 1 = pentium diode; 2 = 3904 diode;
+				 * 4 = thermistor
+				 */
 	u8 vrm;
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
@@ -915,10 +927,12 @@ show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
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
@@ -1580,8 +1594,10 @@ static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
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
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
