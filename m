From: "Justin P. Mattock" <justinmattock@gmail.com>
Date: Fri, 02 Apr 2010 21:07:26 +0000
Subject: [lm-sensors] [PATCH] hwmon:applesmc: Add support for iMac 9.
Message-Id: <1270242446-12333-1-git-send-email-justinmattock@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, "Justin P. Mattock" <justinmattock@gmail.com>


This patch adds support to hwmon:applesmc for the iMac9,1.
Without this the default settings for applesmc and iMac
are to set the machine to use only nine temperature
sensors, with this patch you get all fourteen of them.


Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
---
 drivers/hwmon/applesmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index c1605b5..6ab3e78 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -142,6 +142,9 @@ static const char *temperature_sensors_sets[][41] = {
 	  "TM1S", "TM2P", "TM2S", "TM3S", "TM8P", "TM8S", "TM9P", "TM9S",
 	  "TN0C", "TN0D", "TN0H", "TS0C", "Tp0C", "Tp1C", "Tv0S", "Tv1S",
 	  NULL },
+/* Set 17: iMac9,1 */
+	{ "TA0P", "TC0D", "TC0H", "TC0P", "TG0D", "TG0H", "TH0P", "TL0P",
+	  "TN0D", "TN0H", "TN0P", "TO0P", "Tm0P", "Tp0P", NULL },
 };
 
 /* List of keys used to read/write fan speeds */
@@ -1350,6 +1353,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 1, .light = 1, .temperature_set = 15 },
 /* MacPro3,1: temperature set 16 */
 	{ .accelerometer = 0, .light = 0, .temperature_set = 16 },
+/* iMac 9: light sensor only, temperature set 17 */
+	{ .accelerometer = 0, .light = 0, .temperature_set = 17 },
 };
 
 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1415,6 +1420,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacPro") },
 		&applesmc_dmi_data[4]},
+	{ applesmc_dmi_match, "Apple iMac 9", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac9,1") },
+		&applesmc_dmi_data[17]},
 	{ applesmc_dmi_match, "Apple iMac 8", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac8") },
-- 
1.6.5.GIT


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
