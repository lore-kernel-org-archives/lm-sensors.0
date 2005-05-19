From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: Use standard temperature converters for as99127f
Message-Id: <20050122112337.7fceb7bc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

When support for the Asus AS99127F chip was once added to the w83781d
driver, it was decided that we would treat temp2 and temp3 as having a
LSB of 0.25 degree C, as opposed to 0.5 degree C for the compatible
Winbond chips. The reason why this was done seems to be a couple of
users reporting that these temperatures were reading twice as high as it
should for them in the first place. We had much more feedback about the
A99127F chip since, and it turns out that the exact conversion required
for temp2 and temp3 depends on the motherboard model. For some models
(including my A7V133-C), we now have to multiply the readings by 2,
effectively negating the change that was once done in the driver. For
other models, a linear conversion formula is needed. The bottom line is
that the raw readings from the driver are correct for no known board,
while it would be for at least some of them if we had kept the same LSB
as the Winbond chips are known to have. Thus I believe that the standard
LSB of 0.5 degree C should be restored.

There is no datasheet available for the AS99127F chip, so whatever was
done was guess work (and still is). I see no reason why we would keep
additional code in the w83781d driver to handle this former supposed
difference, especially when the facts now tend to prove that this
difference doesn't exist.

The following patch drops the additional code and treats temp2 and temp3
the same way for all chips supported by the w83781d driver. A similar
change will be made to the 2.4 version of this driver, and the default
sensors.conf will be updated accordingly. Users will have to update
their configuration file, or their readings will of course read twice as
high as they should due to the old conversion formulae.

Please apply,
thanks.

Signed-off-by: Jean Delvare

--- linux-2.6.11-rc1-bk8/drivers/i2c/chips/w83781d.c.orig	2005-01-20 20:49:24.000000000 +0100
+++ linux-2.6.11-rc1-bk8/drivers/i2c/chips/w83781d.c	2005-01-21 20:54:05.000000000 +0100
@@ -175,11 +175,6 @@
 						: (val)) / 1000, 0, 0xff))
 #define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
 
-#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((val) < 0 ? (val)+0x10000*250 \
-						: (val)) / 250) << 7, 0, 0xffff))
-#define AS99127_TEMP_ADD_FROM_REG(val)	((((val) & 0x8000 ? (val)-0x10000 : (val)) \
-						>> 7) * 250)
-
 #define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
 #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
@@ -417,13 +412,8 @@
 { \
 	struct w83781d_data *data = w83781d_update_device(dev); \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
-		if (data->type = as99127f) { \
-			return sprintf(buf,"%ld\n", \
-				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
-		} else { \
-			return sprintf(buf,"%d\n", \
-				LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
-		} \
+		return sprintf(buf,"%d\n", \
+			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 	} else {	/* TEMP1 */ \
 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
 	} \
@@ -442,11 +432,7 @@
 	val = simple_strtol(buf, NULL, 10); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
-		if (data->type = as99127f) \
-			data->temp_##reg##_add[nr-2] = AS99127_TEMP_ADD_TO_REG(val); \
-		else \
-			data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
-		 \
+		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
 		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
 				data->temp_##reg##_add[nr-2]); \
 	} else {	/* TEMP1 */ \

-- 
Jean Delvare
http://khali.linux-fr.org/
