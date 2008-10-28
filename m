From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 28 Oct 2008 21:12:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Add support for iMac 8
Message-Id: <49078047.6040300@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D7A9F9.50502@euromail.se>
In-Reply-To: <48D7A9F9.50502@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

This patch adds temperature sensor support for iMac 8.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Tested-by: Klaus Doblmann <klaus.doblmann@gmail.com>
---
 drivers/hwmon/applesmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 9f04283..be32859 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -125,6 +125,9 @@ static const char* temperature_sensors_sets[][36] = {
 	{ "TB0T", "TB1T", "TB2T", "TB3T", "TC0D", "TC0F", "TC0P", "TG0D",
 	  "TG0F", "TG0H", "TG0P", "TG0T", "TG1H", "TN0D", "TN0P", "TTF0",
 	  "Th2H", "Tm0P", "Ts0P", "Ts0S", NULL },
+/* Set 13: iMac 8,1 */
+	{ "TA0P", "TC0D", "TC0H", "TC0P", "TG0D", "TG0H", "TG0P", "TH0P",
+	  "TL0P", "TO0P", "TW0P", "Tm0P", "Tp0P", NULL },
 };

 /* List of keys used to read/write fan speeds */
@@ -1291,6 +1294,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 1, .light = 1, .temperature_set = 11 },
 /* MacBook Pro 5: accelerometer, backlight and temperature set 12 */
 	{ .accelerometer = 1, .light = 1, .temperature_set = 12 },
+/* iMac 8: light sensor only, temperature set 13 */
+	{ .accelerometer = 0, .light = 0, .temperature_set = 13 },
 };

 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1340,6 +1345,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacPro2") },
 		&applesmc_dmi_data[4]},
+	{ applesmc_dmi_match, "Apple iMac 8", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac8") },
+		&applesmc_dmi_data[13]},
 	{ applesmc_dmi_match, "Apple iMac 5", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac5") },
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
