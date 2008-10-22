From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 22 Oct 2008 16:17:50 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: applesmc: Add support for Macbook 5
Message-Id: <48FF522E.1070209@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

This patch adds accelerometer, backlight and temperature sensor
support for the new unibody Macbook 5.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Tested-by: David M. Lary <dmlary@gmail.com>
---
 drivers/hwmon/applesmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 80d545d..074f7f4 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -118,6 +118,9 @@ static const char* temperature_sensors_sets[][36] = {
 	  "Th0H", "Th1H", "Th2H", "Tm0P", "Ts0P", NULL },
 /* Set 10: iMac 5,1 */
 	{ "TA0P", "TC0D", "TC0P", "TG0D", "TH0P", "TO0P", "Tm0P", NULL },
+/* Set 11: Macbook 5,1 */
+	{ "TB0T", "TB1T", "TB2T", "TB3T", "TC0D", "TC0P", "TN0D", "TN0P",
+	  "TTF0", "Th0H", "Th1H", "ThFH", "Ts0P", "Ts0S", NULL },
 };

 /* List of keys used to read/write fan speeds */
@@ -1280,6 +1283,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 1, .light = 1, .temperature_set = 9 },
 /* iMac 5: light sensor only, temperature set 10 */
 	{ .accelerometer = 0, .light = 0, .temperature_set = 10 },
+/* MacBook 5: accelerometer, backlight and temperature set 11 */
+	{ .accelerometer = 1, .light = 1, .temperature_set = 11 },
 };

 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1309,6 +1314,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook3") },
 		&applesmc_dmi_data[6]},
+	{ applesmc_dmi_match, "Apple MacBook 5", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook5") },
+		&applesmc_dmi_data[11]},
 	{ applesmc_dmi_match, "Apple MacBook", {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook") },
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
