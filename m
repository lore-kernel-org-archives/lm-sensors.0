From: Henrik Rydberg <rydberg@euromail.se>
Date: Thu, 04 Dec 2008 07:36:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Add support for MacBook Air 2
Message-Id: <49378885.90401@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D7A9F9.50502@euromail.se>
In-Reply-To: <48D7A9F9.50502@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

    Add temperature sensor support for MacBook Air 2.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 086c2a5..dca47a5 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -131,6 +131,10 @@ static const char* temperature_sensors_sets[][36] = {
 /* Set 14: iMac 6,1 */
 	{ "TA0P", "TC0D", "TC0H", "TC0P", "TG0D", "TG0H", "TG0P", "TH0P",
 	  "TO0P", "Tp0P", NULL },
+/* Set 15: MacBook Air 2,1 */
+	{ "TB0T", "TB1S", "TB1T", "TB2S", "TB2T", "TC0D", "TN0D", "TTF0",
+	  "TV0P", "TVFP", "TW0P", "Th0P", "Tp0P", "Tp1P", "TpFP", "Ts0P",
+	  "Ts0S", NULL },
 };

 /* List of keys used to read/write fan speeds */
@@ -1301,11 +1305,17 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 0, .light = 0, .temperature_set = 13 },
 /* iMac 6: light sensor only, temperature set 14 */
 	{ .accelerometer = 0, .light = 0, .temperature_set = 14 },
+/* MacBook Air 2,1: accelerometer, backlight and temperature set 15 */
+	{ .accelerometer = 1, .light = 1, .temperature_set = 15 },
 };

 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
  * So we need to put "Apple MacBook Pro" before "Apple MacBook". */
 static __initdata struct dmi_system_id applesmc_whitelist[] = {
+	{ applesmc_dmi_match, "Apple MacBook Air 2", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir2") },
+		&applesmc_dmi_data[15]},
 	{ applesmc_dmi_match, "Apple MacBook Air", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir") },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
