From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 28 Jan 2008 18:30:22 +0000
Subject: [lm-sensors] [PATCH] HARDWARE MONITORING: Remove redundant power of
Message-Id: <alpine.LFD.1.00.0801281327470.22776@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Since this source file already includes <log2.h>, there's no reason
for it to redefine a power of 2 check.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  not compile tested since it seems relatively obvious, but i'll let
someone else make the call here.

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
====================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
====================================

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
