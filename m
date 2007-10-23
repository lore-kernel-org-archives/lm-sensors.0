From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2007 12:02:24 +0000
Subject: [lm-sensors] [PATCH] hwmon: (gl518sm) Fix the reported fan speed
Message-Id: <20071023140224.0f8ca055@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The fan speeds reported by the gl518sm driver are twice as much as they
should. It's currently reporting the number of pulses per minute, not
rotations per minute, while typical fans emit two pulses per rotation.
This explains why all reports with this driver had very high speed
values (between 9000 to 12000 RPM). Odd that nobody ever actually
complained about this bug.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl518sm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.24-rc0.orig/drivers/hwmon/gl518sm.c	2007-10-22 20:33:05.000000000 +0200
+++ linux-2.6.24-rc0/drivers/hwmon/gl518sm.c	2007-10-22 20:49:49.000000000 +0200
@@ -96,10 +96,10 @@ static inline u8 FAN_TO_REG(long rpm, in
 	long rpmdiv;
 	if (rpm = 0)
 		return 0;
-	rpmdiv = SENSORS_LIMIT(rpm, 1, 1920000) * div;
-	return SENSORS_LIMIT((960000 + rpmdiv / 2) / rpmdiv, 1, 255);
+	rpmdiv = SENSORS_LIMIT(rpm, 1, 960000) * div;
+	return SENSORS_LIMIT((480000 + rpmdiv / 2) / rpmdiv, 1, 255);
 }
-#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (960000/((val)*(div))))
+#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (480000/((val)*(div))))
 
 #define IN_TO_REG(val)		(SENSORS_LIMIT((((val)+9)/19),0,255))
 #define IN_FROM_REG(val)	((val)*19)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
