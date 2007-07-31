From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: (applesmc) add temperature sensors set
Message-Id: <11858460011367-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Martin Szulecki <mactel@sukimashita.com>

Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>
Acked-by: Jean Delvare <khali@linux-fr.org>
Cc: Martin Szulecki <mactel@sukimashita.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/applesmc.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index fd1281f..941729a 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -79,11 +79,15 @@
 
 /*
  * Temperature sensors keys (sp78 - 2 bytes).
- * First set for Macbook(Pro), second for Macmini.
  */
 static const char* temperature_sensors_sets[][13] = {
+/* Set 0: Macbook Pro */
 	{ "TA0P", "TB0T", "TC0D", "TC0P", "TG0H", "TG0P", "TG0T", "Th0H",
 	  "Th1H", "Tm0P", "Ts0P", "Ts1P", NULL },
+/* Set 1: Macbook set */
+	{ "TB0T", "TC0D", "TC0P", "TM0P", "TN0P", "TN1P", "Th0H", "Th0S",
+	  "Th1H", "Ts0P", NULL },
+/* Set 2: Macmini set */
 	{ "TC0D", "TC0P", NULL }
 };
 
@@ -1150,10 +1154,10 @@ static void applesmc_release_accelerometer(void)
 static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 /* MacBook Pro: accelerometer, backlight and temperature set 0 */
 	{ .accelerometer = 1, .light = 1, .temperature_set = 0 },
-/* MacBook: accelerometer and temperature set 0 */
-	{ .accelerometer = 1, .light = 0, .temperature_set = 0 },
-/* MacBook: temperature set 1 */
-	{ .accelerometer = 0, .light = 0, .temperature_set = 1 }
+/* MacBook: accelerometer and temperature set 1 */
+	{ .accelerometer = 1, .light = 0, .temperature_set = 1 },
+/* MacMini: temperature set 2 */
+	{ .accelerometer = 0, .light = 0, .temperature_set = 2 },
 };
 
 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
