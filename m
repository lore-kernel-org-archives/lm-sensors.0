From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 2.6] I2C: Store lm83 and lm90 temperatures in signed
Message-Id: <20040926113151.298d9349.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Back when I wrote the lm83 and lm90 drivers, I decided to use unsigned
variables to store temperature values as mirrored from the chipset
registers. I wonder why, since the registers use signed values
themselves. The patch below changes the variables back to signed types,
so as to simplify the conversions made by the driver, making them faster
and easier to understand.

Additionally, the lm90 driver was lacking boundary checkings and proper
rounding when writing temperature limits to the chipset, so I added
these. I also reworded the comments about internal temperature values
representation for all chipsets.

Tested to work fine on my (LM90-compatible) ADM1032 chip. lm83 patch
untested, but it is more simple and directly copied from the lm90, so I
am confident it works fine too.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc2-mm3/drivers/i2c/chips/lm83.c.orig	2004-09-26 09:03:32.000000000 +0200
+++ linux-2.6.9-rc2-mm3/drivers/i2c/chips/lm83.c	2004-09-26 10:58:06.000000000 +0200
@@ -80,13 +80,14 @@
 
 /*
  * Conversions and various macros
- * The LM83 uses signed 8-bit values.
+ * The LM83 uses signed 8-bit values with LSB = 1 degree Celcius.
  */
 
-#define TEMP_FROM_REG(val)	(((val) > 127 ? (val) - 0x100 : (val)) * 1000)
-#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0x100 : (val) >= 127000 ? 127 : \
-				 (val) > -500 ? ((val)+500) / 1000 : \
-				 ((val)-500) / 1000 + 0x100)
+#define TEMP_FROM_REG(val)	((val) * 1000)
+#define TEMP_TO_REG(val)	((val) <= -128000 ? -128 : \
+				 (val) >= 127000 ? 127 : \
+				 (val) < 0 ? ((val) - 500) / 1000 : \
+				 ((val) + 500) / 1000)
 
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,
@@ -142,9 +143,9 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp_input[4];
-	u8 temp_high[4];
-	u8 temp_crit;
+	s8 temp_input[4];
+	s8 temp_high[4];
+	s8 temp_crit;
 	u16 alarms; /* bitvector, combined */
 };
 
--- linux-2.6.9-rc2-mm3/drivers/i2c/chips/lm90.c.orig	2004-09-26 09:03:32.000000000 +0200
+++ linux-2.6.9-rc2-mm3/drivers/i2c/chips/lm90.c	2004-09-26 10:52:09.000000000 +0200
@@ -127,19 +127,24 @@
 
 /*
  * Conversions and various macros
- * The LM90 uses signed 8-bit values for the local temperatures,
- * and signed 11-bit values for the remote temperatures (except
- * T_CRIT). Note that TEMP2_TO_REG does not round values, but
- * stick to the nearest lower value instead. Fixing it is just
- * not worth it.
+ * For local temperatures and limits, critical limits and the hysteresis
+ * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celcius.
+ * For remote temperatures and limits, it uses signed 11-bit values with
+ * LSB = 0.125 degree Celcius, left-justified in 16-bit registers.
  */
 
-#define TEMP1_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)
-#define TEMP1_TO_REG(val)	((val < 0 ? val+0x100*1000 : val) / 1000)
-#define TEMP2_FROM_REG(val)	(((val & 0x8000 ? val-0x10000 : val) >> 5) * 125)
-#define TEMP2_TO_REG(val)	((((val / 125) << 5) + (val < 0 ? 0x10000 : 0)) & 0xFFE0)
-#define HYST_FROM_REG(val)	(val * 1000)
-#define HYST_TO_REG(val)	(val <= 0 ? 0 : val >= 31000 ? 31 : val / 1000)
+#define TEMP1_FROM_REG(val)	((val) * 1000)
+#define TEMP1_TO_REG(val)	((val) <= -128000 ? -128 : \
+				 (val) >= 127000 ? 127 : \
+				 (val) < 0 ? ((val) - 500) / 1000 : \
+				 ((val) + 500) / 1000)
+#define TEMP2_FROM_REG(val)	((val) / 32 * 125)
+#define TEMP2_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
+				 (val) >= 127875 ? 0x7FE0 : \
+				 (val) < 0 ? ((val) - 62) / 125 * 32 : \
+				 ((val) + 62) / 125 * 32)
+#define HYST_TO_REG(val)	((val) <= 0 ? 0 : (val) >= 30500 ? 31 : \
+				 ((val) + 500) / 1000)
 
 /*
  * Functions declaration
@@ -176,9 +181,9 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp_input1, temp_low1, temp_high1; /* local */
-	u16 temp_input2, temp_low2, temp_high2; /* remote, combined */
-	u8 temp_crit1, temp_crit2;
+	s8 temp_input1, temp_low1, temp_high1; /* local */
+	s16 temp_input2, temp_low2, temp_high2; /* remote, combined */
+	s8 temp_crit1, temp_crit2;
 	u8 temp_hyst;
 	u16 alarms; /* bitvector, combined */
 };
@@ -243,7 +248,7 @@
 { \
 	struct lm90_data *data = lm90_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->basereg) \
-		       - HYST_FROM_REG(data->temp_hyst)); \
+		       - TEMP1_FROM_REG(data->temp_hyst)); \
 }
 show_temp_hyst(temp_hyst1, temp_crit1);
 show_temp_hyst(temp_hyst2, temp_crit2);


-- 
Jean Delvare
http://khali.linux-fr.org/
