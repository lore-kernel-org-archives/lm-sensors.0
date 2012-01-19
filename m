From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:58 +0000
Subject: [lm-sensors] [PATCH 64/82] hwmon: (smsc47m192) Fix multi-line comments
Message-Id: <1327017376-20466-65-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m192.c |   60 ++++++++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 95761bd..d92fc3a 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -1,25 +1,25 @@
 /*
-    smsc47m192.c - Support for hardware monitoring block of
-		SMSC LPC47M192 and compatible Super I/O chips
-
-    Copyright (C) 2006  Hartmut Rick <linux@rick.claranet.de>
-
-    Derived from lm78.c and other chip drivers.
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
+ * smsc47m192.c - Support for hardware monitoring block of
+ *		  SMSC LPC47M192 and compatible Super I/O chips
+ *
+ * Copyright (C) 2006  Hartmut Rick <linux@rick.claranet.de>
+ *
+ * Derived from lm78.c and other chip drivers.
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
@@ -80,8 +80,10 @@ static inline u8 IN_TO_REG(unsigned long val, int n)
 	return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
 }
 
-/* TEMP: 0.001 degC units (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 0.001 degC units (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static inline s8 TEMP_TO_REG(int val)
 {
 	return SENSORS_LIMIT(SCALE(val, 1, 1000), -128000, 127000);
@@ -326,8 +328,10 @@ static ssize_t set_temp_offset(struct device *dev, struct device_attribute
 		i2c_smbus_write_byte_data(client,
 			SMSC47M192_REG_TEMP_OFFSET(nr), data->temp_offset[nr]);
 	else if (data->temp_offset[nr] != 0) {
-		/* offset[0] and offset[1] share the same register,
-			SFR bit 4 activates offset[0] */
+		/*
+		 * offset[0] and offset[1] share the same register,
+		 * SFR bit 4 activates offset[0]
+		 */
 		i2c_smbus_write_byte_data(client, SMSC47M192_REG_SFR,
 					(sfr & 0xef) | (nr = 0 ? 0x10 : 0));
 		data->temp_offset[1-nr] = 0;
@@ -640,8 +644,10 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 		for (i = 1; i < 3; i++)
 			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
 						SMSC47M192_REG_TEMP_OFFSET(i));
-		/* first offset is temp_offset[0] if SFR bit 4 is set,
-					temp_offset[1] otherwise */
+		/*
+		 * first offset is temp_offset[0] if SFR bit 4 is set,
+		 * temp_offset[1] otherwise
+		 */
 		if (sfr & 0x10) {
 			data->temp_offset[0] = data->temp_offset[1];
 			data->temp_offset[1] = 0;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
