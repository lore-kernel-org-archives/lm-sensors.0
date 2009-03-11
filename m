From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Mar 2009 17:23:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Properly decode -128 degrees C
Message-Id: <20090311182303.60575130@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The it87 driver is reporting -128 degrees C as +128 degrees C.
That's not a terribly likely temperature value but let's still
get it right, especially when it simplifies the code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.29-rc7.orig/drivers/hwmon/it87.c	2009-01-11 10:57:18.000000000 +0100
+++ linux-2.6.29-rc7/drivers/hwmon/it87.c	2009-03-11 17:45:51.000000000 +0100
@@ -213,7 +213,7 @@ static inline u16 FAN16_TO_REG(long rpm)
 
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
 					((val)+500)/1000),-128,127))
-#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
+#define TEMP_FROM_REG(val) ((val) * 1000)
 
 #define PWM_TO_REG(val)   ((val) >> 1)
 #define PWM_FROM_REG(val) (((val)&0x7f) << 1)
@@ -267,9 +267,9 @@ struct it87_data {
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[5];		/* Register values, possibly combined */
 	u16 fan_min[5];		/* Register values, possibly combined */
-	u8 temp[3];		/* Register value */
-	u8 temp_high[3];	/* Register value */
-	u8 temp_low[3];		/* Register value */
+	s8 temp[3];		/* Register value */
+	s8 temp_high[3];	/* Register value */
+	s8 temp_low[3];		/* Register value */
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
