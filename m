From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Tue, 06 Nov 2007 08:21:42 +0000
Subject: [lm-sensors] [PATCH] HWMON: Replace power-of-two test in
Message-Id: <Pine.LNX.4.64.0711060319050.5243@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Since <linux/log2.h> already supplies a power-of-two test, there's no
point in having this source file redefine it again.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 9810aaa..a215560 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -114,8 +114,6 @@ I2C_CLIENT_INSMOD_1(adt7470);
 /* sleep 1s while gathering temperature data */
 #define TEMP_COLLECTION_TIME	1000

-#define power_of_2(x)	(((x) & ((x) - 1)) = 0)
-
 /* datasheet says to divide this number by the fan reading to get fan rpm */
 #define FAN_PERIOD_TO_RPM(x)	((90000 * 60) / (x))
 #define FAN_RPM_TO_PERIOD	FAN_PERIOD_TO_RPM
@@ -677,7 +675,7 @@ static int cvt_auto_temp(int input)
 {
 	if (input = ADT7470_PWM_ALL_TEMPS)
 		return 0;
-	if (input < 1 || !power_of_2(input))
+	if (input < 1 || !is_power_of_2(input))
 		return -EINVAL;
 	return ilog2(input) + 1;
 }
-- 
====================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
====================================

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
