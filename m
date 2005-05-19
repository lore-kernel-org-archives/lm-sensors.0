From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: [PATCH 2.6] Fix w83781d temp
Message-Id: <20040110140700.5b5ab705.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch fixes the temperature handling in the w83781d driver:
1* Fix bad magnitude.
2* Use MMH's lm75.h.
3* Allow negative temperatures.

This applies on top of the patches stack. In particular, the asb100 patch needs to be applied before this one so that lm75.h is present.

Thanks.

--- linux-2.6.1-k1/drivers/i2c/chips/w83781d.c.orig	2004-01-10 11:27:49.000000000 +0100
+++ linux-2.6.1-k1/drivers/i2c/chips/w83781d.c	2004-01-10 12:58:58.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <asm/io.h>
+#include "lm75.h"
 
 /* RT Table support #defined so we can take it out if it gets bothersome */
 #define W83781D_RT			1
@@ -170,17 +171,14 @@
 					((val) = 255 ? 0 : \
 							1350000 / ((val) * (div))))
 
-#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val / 10) < 0 ? (((val / 10) - 5) / 10) : \
-									 ((val / 10) + 5) / 10), 0, 255))
-#define TEMP_FROM_REG(val)		((((val ) > 0x80 ? (val) - 0x100 : (val)) * 10) * 10)
-
-#define TEMP_ADD_TO_REG(val)		(SENSORS_LIMIT(((((val / 10) + 2) / 5) << 7),\
-                                              0, 0xffff))
-#define TEMP_ADD_FROM_REG(val)		((((val) >> 7) * 5) * 10)
-
-#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((((val / 10) + 2)*4)/10) \
-                                               << 7), 0, 0xffff))
-#define AS99127_TEMP_ADD_FROM_REG(val)	(((((val) >> 7) * 10) / 4) * 10)
+#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
+						: (val)) / 1000, 0, 0xff))
+#define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
+
+#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((val) < 0 ? (val)+0x10000*250 \
+						: (val)) / 250) << 7, 0, 0xffff))
+#define AS99127_TEMP_ADD_FROM_REG(val)	((((val) & 0x8000 ? (val)-0x10000 : (val)) \
+						>> 7) * 250)
 
 #define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
@@ -437,8 +435,8 @@
 			return sprintf(buf,"%ld\n", \
 				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
 		} else { \
-			return sprintf(buf,"%ld\n", \
-				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+			return sprintf(buf,"%d\n", \
+				LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 		} \
 	} else {	/* TEMP1 */ \
 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
@@ -453,15 +451,15 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83781d_data *data = i2c_get_clientdata(client); \
-	u32 val; \
+	s32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
+	val = simple_strtol(buf, NULL, 10); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type = as99127f) \
 			data->temp_##reg##_add[nr-2] = AS99127_TEMP_ADD_TO_REG(val); \
 		else \
-			data->temp_##reg##_add[nr-2] = TEMP_ADD_TO_REG(val); \
+			data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
 		 \
 		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
 				data->temp_##reg##_add[nr-2]); \


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
