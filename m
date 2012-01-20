From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Jan 2012 15:09:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71805f) Fix clamping of temperature limits
Message-Id: <20120120160923.5f690806@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Properly clamp temperature limits set by the user. Without this fix,
attempts to write temperature limits above the maximum supported by
the chip (255 degrees Celsius) would arbitrarily and unexpectedly
result in the limit being set to 0 degree Celsius.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/f71805f.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-3.3-rc1.orig/drivers/hwmon/f71805f.c	2012-01-20 14:37:27.449912137 +0100
+++ linux-3.3-rc1/drivers/hwmon/f71805f.c	2012-01-20 14:58:33.600930905 +0100
@@ -283,10 +283,10 @@ static inline long temp_from_reg(u8 reg)
 
 static inline u8 temp_to_reg(long val)
 {
-	if (val < 0)
-		val = 0;
-	else if (val > 1000 * 0xff)
-		val = 0xff;
+	if (val <= 0)
+		return 0;
+	if (val >= 1000 * 0xff)
+		return 0xff;
 	return (val + 500) / 1000;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
