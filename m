From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 22 Oct 2008 16:16:07 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: applesmc: Add support for iMac 5
Message-Id: <48FF51C7.7020103@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

This patch adds temperature sensor support for iMac 5.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Tested-by: Ricky Campbell <johnrcampbell@gmail.com>
---
 drivers/hwmon/applesmc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index bc011da..80d545d 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -116,6 +116,8 @@ static const char* temperature_sensors_sets[][36] = {
 /* Set 9: Macbook Pro 3,1 (Santa Rosa) */
 	{ "TALP", "TB0T", "TC0D", "TC0P", "TG0D", "TG0H", "TTF0", "TW0P",
 	  "Th0H", "Th1H", "Th2H", "Tm0P", "Ts0P", NULL },
+/* Set 10: iMac 5,1 */
+	{ "TA0P", "TC0D", "TC0P", "TG0D", "TH0P", "TO0P", "Tm0P", NULL },
 };

 /* List of keys used to read/write fan speeds */
@@ -1276,6 +1278,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 1, .light = 1, .temperature_set = 8 },
 /* MacBook Pro 3: accelerometer, backlight and temperature set 9 */
 	{ .accelerometer = 1, .light = 1, .temperature_set = 9 },
+/* iMac 5: light sensor only, temperature set 10 */
+	{ .accelerometer = 0, .light = 0, .temperature_set = 10 },
 };

 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1317,6 +1321,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacPro2") },
 		&applesmc_dmi_data[4]},
+	{ applesmc_dmi_match, "Apple iMac 5", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac5") },
+		&applesmc_dmi_data[10]},
 	{ applesmc_dmi_match, "Apple iMac", {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"iMac") },
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
