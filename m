From: Henrik Rydberg <rydberg@euromail.se>
Date: Thu, 06 Nov 2008 08:31:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Add support for Macbook 4
Message-Id: <4912AB54.1030405@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D7A9F9.50502@euromail.se>
In-Reply-To: <48D7A9F9.50502@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

This patch adds accelerometer and temperature sensor support for Macbook 4.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index be32859..488e45c 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1280,7 +1280,7 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 0, .light = 0, .temperature_set = 4 },
 /* iMac: temperature set 5 */
 	{ .accelerometer = 0, .light = 0, .temperature_set = 5 },
-/* MacBook3: accelerometer and temperature set 6 */
+/* MacBook3, MacBook4: accelerometer and temperature set 6 */
 	{ .accelerometer = 1, .light = 0, .temperature_set = 6 },
 /* MacBook Air: accelerometer, backlight and temperature set 7 */
 	{ .accelerometer = 1, .light = 1, .temperature_set = 7 },
@@ -1329,6 +1329,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook3") },
 		&applesmc_dmi_data[6]},
+	{ applesmc_dmi_match, "Apple MacBook 4", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook4") },
+		&applesmc_dmi_data[6]},
 	{ applesmc_dmi_match, "Apple MacBook 5", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook5") },
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
