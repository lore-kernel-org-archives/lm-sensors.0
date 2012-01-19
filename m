From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:29 +0000
Subject: [lm-sensors] [PATCH 35/82] hwmon: (lm77) Fix multi-line comments
Message-Id: <1327017376-20466-36-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm77.c |   92 +++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 08f7ffe..d3d7a78 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -1,29 +1,29 @@
 /*
-    lm77.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-
-    Copyright (c) 2004  Andras BALI <drewie@freemail.hu>
-
-    Heavily based on lm75.c by Frodo Looijaard <frodol@dds.nl>.  The LM77
-    is a temperature sensor and thermal window comparator with 0.5 deg
-    resolution made by National Semiconductor.  Complete datasheet can be
-    obtained at their site:
-       http://www.national.com/pf/LM/LM77.html
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
+ * lm77.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	    monitoring
+ *
+ * Copyright (c) 2004  Andras BALI <drewie@freemail.hu>
+ *
+ * Heavily based on lm75.c by Frodo Looijaard <frodol@dds.nl>.  The LM77
+ * is a temperature sensor and thermal window comparator with 0.5 deg
+ * resolution made by National Semiconductor.  Complete datasheet can be
+ * obtained at their site:
+ *	http://www.national.com/pf/LM/LM77.html
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
@@ -95,8 +95,10 @@ static struct i2c_driver lm77_driver = {
 #define LM77_TEMP_MIN (-55000)
 #define LM77_TEMP_MAX 125000
 
-/* In the temperature registers, the low 3 bits are not part of the
-   temperature values; they are the status bits. */
+/*
+ * In the temperature registers, the low 3 bits are not part of the
+ * temperature values; they are the status bits.
+ */
 static inline s16 LM77_TEMP_TO_REG(int temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
@@ -167,8 +169,10 @@ static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
 set(temp_min, LM77_REG_TEMP_MIN);
 set(temp_max, LM77_REG_TEMP_MAX);
 
-/* hysteresis is stored as a relative value on the chip, so it has to be
-   converted first */
+/*
+ * hysteresis is stored as a relative value on the chip, so it has to be
+ * converted first
+ */
 static ssize_t set_temp_crit_hyst(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
@@ -273,17 +277,19 @@ static int lm77_detect(struct i2c_client *new_client,
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	/* Here comes the remaining detection.  Since the LM77 has no
-	   register dedicated to identification, we have to rely on the
-	   following tricks:
-
-	   1. the high 4 bits represent the sign and thus they should
-	      always be the same
-	   2. the high 3 bits are unused in the configuration register
-	   3. addresses 0x06 and 0x07 return the last read value
-	   4. registers cycling over 8-address boundaries
-
-	   Word-sized registers are high-byte first. */
+	/*
+	 * Here comes the remaining detection.  Since the LM77 has no
+	 * register dedicated to identification, we have to rely on the
+	 * following tricks:
+	 *
+	 * 1. the high 4 bits represent the sign and thus they should
+	 *    always be the same
+	 * 2. the high 3 bits are unused in the configuration register
+	 * 3. addresses 0x06 and 0x07 return the last read value
+	 * 4. registers cycling over 8-address boundaries
+	 *
+	 * Word-sized registers are high-byte first.
+	 */
 
 	/* addresses cycling */
 	cur = i2c_smbus_read_word_data(new_client, 0);
@@ -381,8 +387,10 @@ static int lm77_remove(struct i2c_client *client)
 	return 0;
 }
 
-/* All registers are word-sized, except for the configuration register.
-   The LM77 uses the high-byte first convention. */
+/*
+ * All registers are word-sized, except for the configuration register.
+ * The LM77 uses the high-byte first convention.
+ */
 static u16 lm77_read_value(struct i2c_client *client, u8 reg)
 {
 	if (reg = LM77_REG_CONF)
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
