From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:33 +0000
Subject: [lm-sensors] [PATCH 39/82] hwmon: (lm85) Fix multi-line comments
Message-Id: <1327017376-20466-40-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm85.c |  104 +++++++++++++++++++++++++++++---------------------
 1 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 240b7f9..16ad92c 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1,28 +1,28 @@
 /*
-    lm85.c - Part of lm_sensors, Linux kernel modules for hardware
-	monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
-    Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
-    Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
-    Copyright (C) 2007--2009  Jean Delvare <khali@linux-fr.org>
-
-    Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
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
+ * lm85.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	    monitoring
+ * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+ * Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
+ * Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
+ * Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
+ * Copyright (C) 2007--2009  Jean Delvare <khali@linux-fr.org>
+ *
+ * Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
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
@@ -125,9 +125,10 @@ enum chips {
 #define	EMC6D102_REG_EXTEND_ADC4	0x88
 
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
  */
 
 /* IN are scaled according to built-in resistors */
@@ -166,7 +167,8 @@ static inline u16 FAN_TO_REG(unsigned long val)
 #define PWM_FROM_REG(val)		(val)
 
 
-/* ZONEs have the following parameters:
+/*
+ * ZONEs have the following parameters:
  *    Limit (low) temp,           1. degC
  *    Hysteresis (below limit),   1. degC (0-15)
  *    Range of speed control,     .1 degC (2-80)
@@ -228,7 +230,8 @@ static int FREQ_FROM_REG(const int *map, u8 reg)
 	return map[reg & 0x07];
 }
 
-/* Since we can't use strings, I'm abusing these numbers
+/*
+ * Since we can't use strings, I'm abusing these numbers
  *   to stand in for the following meanings:
  *      1 -- PWM responds to Zone 1
  *      2 -- PWM responds to Zone 2
@@ -258,7 +261,8 @@ static int ZONE_TO_REG(int zone)
 #define HYST_TO_REG(val)	SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
 #define HYST_FROM_REG(val)	((val) * 1000)
 
-/* Chip sampling rates
+/*
+ * Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
  *    so it doesn't make sense to read them more often than that.
@@ -274,7 +278,8 @@ static int ZONE_TO_REG(int zone)
 #define LM85_DATA_INTERVAL  (HZ + HZ / 2)
 #define LM85_CONFIG_INTERVAL  (1 * 60 * HZ)
 
-/* LM85 can automatically adjust fan speeds based on temperature
+/*
+ * LM85 can automatically adjust fan speeds based on temperature
  * This structure encapsulates an entire Zone config.  There are
  * three zones (one for each temperature input) on the lm85
  */
@@ -283,7 +288,8 @@ struct lm85_zone {
 	u8 hyst;	/* Low limit hysteresis. (0-15) */
 	u8 range;	/* Temp range, encoded */
 	s8 critical;	/* "All fans ON" temp limit */
-	u8 max_desired; /* Actual "max" temperature specified.  Preserved
+	u8 max_desired; /*
+			 * Actual "max" temperature specified.  Preserved
 			 * to prevent "drift" as other autofan control
 			 * values change.
 			 */
@@ -295,8 +301,10 @@ struct lm85_autofan {
 	u8 min_off;	/* Min PWM or OFF below "limit", flag */
 };
 
-/* For each registered chip, we need to keep some data in memory.
-   The structure is dynamically allocated. */
+/*
+ * For each registered chip, we need to keep some data in memory.
+ * The structure is dynamically allocated.
+ */
 struct lm85_data {
 	struct device *hwmon_dev;
 	const int *freq_map;
@@ -570,8 +578,10 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 		config = 7;
 		break;
 	case 2:
-		/* Here we have to choose arbitrarily one of the 5 possible
-		   configurations; I go for the safest */
+		/*
+		 * Here we have to choose arbitrarily one of the 5 possible
+		 * configurations; I go for the safest
+		 */
 		config = 6;
 		break;
 	default:
@@ -618,9 +628,11 @@ static ssize_t set_pwm_freq(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	/* The ADT7468 has a special high-frequency PWM output mode,
+	/*
+	 * The ADT7468 has a special high-frequency PWM output mode,
 	 * where all PWM outputs are driven by a 22.5 kHz clock.
-	 * This might confuse the user, but there's not much we can do. */
+	 * This might confuse the user, but there's not much we can do.
+	 */
 	if (data->type = adt7468 && val >= 11300) {	/* High freq. mode */
 		data->cfg5 &= ~ADT7468_HFPWM;
 		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
@@ -1420,8 +1432,10 @@ static int lm85_probe(struct i2c_client *client,
 			goto err_remove_files;
 	}
 
-	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
-	   as a sixth digital VID input rather than an analog input. */
+	/*
+	 * The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
+	 * as a sixth digital VID input rather than an analog input.
+	 */
 	if (data->type = adt7463 || data->type = adt7468) {
 		u8 vid = lm85_read_value(client, LM85_REG_VID);
 		if (vid & 0x80)
@@ -1527,7 +1541,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 		/* Things that change quickly */
 		dev_dbg(&client->dev, "Reading sensor values\n");
 
-		/* Have to read extended bits first to "freeze" the
+		/*
+		 * Have to read extended bits first to "freeze" the
 		 * more significant bits that are read later.
 		 * There are 2 additional resolution bits per channel and we
 		 * have room for 4, so we shift them to the left.
@@ -1587,9 +1602,10 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 						EMC6D100_REG_ALARM3) << 16;
 		} else if (data->type = emc6d102 || data->type = emc6d103 ||
 			   data->type = emc6d103s) {
-			/* Have to read LSB bits after the MSB ones because
-			   the reading of the MSB bits has frozen the
-			   LSBs (backward from the ADM1027).
+			/*
+			 * Have to read LSB bits after the MSB ones because
+			 * the reading of the MSB bits has frozen the
+			 * LSBs (backward from the ADM1027).
 			 */
 			int ext1 = lm85_read_value(client,
 						   EMC6D102_REG_EXTEND_ADC1);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
