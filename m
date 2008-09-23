From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 23 Sep 2008 17:30:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Add support for Macbook Pro 3
Message-Id: <48D927B3.5000207@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D7A9F9.50502@euromail.se>
In-Reply-To: <48D7A9F9.50502@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

This patch adds temperature sensor support for Macbook Pro 3.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 631d31c..321dc82 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -110,6 +110,9 @@ static const char* temperature_sensors_sets[][36] = {
 /* Set 8: Macbook Pro 4,1 (Penryn) */
 	{ "TB0T", "TC0D", "TC0P", "TG0D", "TG0H", "TTF0", "TW0P", "Th0H",
 	  "Th1H", "Th2H", "Tm0P", "Ts0P", NULL },
+/* Set 9: Macbook Pro 3,1 (Santa Rosa) */
+	{ "TALP", "TB0T", "TC0D", "TC0P", "TG0D", "TG0H", "TTF0", "TW0P",
+	  "Th0H", "Th1H", "Th2H", "Tm0P", "Ts0P", NULL },
 };

 /* List of keys used to read/write fan speeds */
@@ -1269,6 +1272,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 1, .light = 1, .temperature_set = 7 },
 /* MacBook Pro 4: accelerometer, backlight and temperature set 8 */
 	{ .accelerometer = 1, .light = 1, .temperature_set = 8 },
+/* MacBook Pro 3: accelerometer, backlight and temperature set 9 */
+	{ .accelerometer = 1, .light = 1, .temperature_set = 9 },
 };

 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1278,6 +1283,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir") },
 		(void*)&applesmc_dmi_data[7]},
+	{ applesmc_dmi_match, "Apple MacBook Pro 3", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3") },
+		&applesmc_dmi_data[9]},
 	{ applesmc_dmi_match, "Apple MacBook Pro 4", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro4") },
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
