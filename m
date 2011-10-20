From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Oct 2011 07:06:45 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (w83627ehf) Fix negative 8-bit
Message-Id: <20111020090645.1b85f1aa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since 8-bit temperature values are now handled in 16-bit struct
members, values have to be cast to s8 for negative temperatures to be
properly handled. This is broken since kernel version 2.6.39
(commit bce26c58df86599c9570cee83eac58bdaae760e4.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: stable@kernel.org
---
I also have a more intrusive fix, but for stable I prefer this simple
version.

 drivers/hwmon/w83627ehf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-3.1-rc9.orig/drivers/hwmon/w83627ehf.c	2011-10-17 21:05:51.000000000 +0200
+++ linux-3.1-rc9/drivers/hwmon/w83627ehf.c	2011-10-17 22:18:45.000000000 +0200
@@ -390,7 +390,7 @@ temp_from_reg(u16 reg, s16 regval)
 {
 	if (is_word_sized(reg))
 		return LM75_TEMP_FROM_REG(regval);
-	return regval * 1000;
+	return ((s8)regval) * 1000;
 }
 
 static inline u16
@@ -398,7 +398,8 @@ temp_to_reg(u16 reg, long temp)
 {
 	if (is_word_sized(reg))
 		return LM75_TEMP_TO_REG(temp);
-	return DIV_ROUND_CLOSEST(SENSORS_LIMIT(temp, -127000, 128000), 1000);
+	return (s8)DIV_ROUND_CLOSEST(SENSORS_LIMIT(temp, -127000, 128000),
+				     1000);
 }
 
 /* Some of analog inputs have internal scaling (2x), 8mV is ADC LSB */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
