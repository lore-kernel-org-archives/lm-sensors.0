From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Fri, 30 Apr 2010 21:38:05 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: applesmc: Add generic support for
Message-Id: <1272663486-16945-2-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272663486-16945-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1272663486-16945-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Bernhard Froemel <froemel@vmars.tuwien.ac.at>, Henrik Rydberg <rydberg@euromail.se>

From: Bernhard Froemel <froemel@vmars.tuwien.ac.at>

This patch adds generic support for the MacBook Pro 6 family
based on the 6,2 model.

[rydberg@euromail.se: patch cleanup]
Signed-off-by: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 67626c1..2ea6e67 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -155,6 +155,10 @@ static const char *temperature_sensors_sets[][41] = {
 /* Set 20: MacBook Pro 5,4 */
 	{ "TB0T", "TB1T", "TB2T", "TB3T", "TC0D", "TC0F", "TC0P", "TN0D",
 	  "TN0P", "TTF0", "Th2H", "Ts0P", "Ts0S", NULL },
+/* Set 21: MacBook Pro 6,2 */
+	{ "TB0T", "TB1T", "TB2T", "TC0C", "TC0D", "TC0P", "TC1C", "TG0D",
+	  "TG0P", "TG0T", "TMCD", "TP0P", "TPCD", "Th1H", "Th2H", "Tm0P",
+	  "Ts0P", "Ts0S", NULL },
 };
 
 /* List of keys used to read/write fan speeds */
@@ -1371,6 +1375,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 1, .light = 1, .temperature_set = 19 },
 /* MacBook Pro 5,4: accelerometer, backlight and temperature set 20 */
 	{ .accelerometer = 1, .light = 1, .temperature_set = 20 },
+/* MacBook Pro 6,2: accelerometer, backlight and temperature set 21 */
+	{ .accelerometer = 1, .light = 1, .temperature_set = 21 },
 };
 
 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1392,6 +1398,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro5,3") },
 		&applesmc_dmi_data[19]},
+	{ applesmc_dmi_match, "Apple MacBook Pro 6", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro6") },
+		&applesmc_dmi_data[21]},
 	{ applesmc_dmi_match, "Apple MacBook Pro 5", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro5") },
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
