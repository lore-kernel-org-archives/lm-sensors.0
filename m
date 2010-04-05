From: "Justin P. Mattock" <justinmattock@gmail.com>
Date: Mon, 05 Apr 2010 19:28:27 +0000
Subject: [lm-sensors] [PATCH]hwmon:applesmc:Add MacBook2,
Message-Id: <1270495707-2946-1-git-send-email-justinmattock@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>

This patch needs to be applied on top of:
[PATCH]hwmon:applesmc:Add support for iMac 9.
located here:
http://lkml.org/lkml/2010/4/2/300

This patch fixes an input/output error when
trying to read the temperature sensors in:
/sys/devices/platform/applesmc.768
(example)
watch cat /sys/devices/platform/applesmc.768/temp*_input

the reason for this is the temperature sensors are wrong. Using the
key enumeration proceedure I was able to locate the correct
temperature sensors for this machine, and now the above 
watch cat commands now show changing temperatures with no error.
(BTW:If you need me to add both patches to make one patch
for the iMac9,1 and MacBookPro2,2 let me know.)


 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/hwmon/applesmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 6ab3e78..a581f11 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -145,6 +145,9 @@ static const char *temperature_sensors_sets[][41] = {
 /* Set 17: iMac9,1 */
 	{ "TA0P", "TC0D", "TC0H", "TC0P", "TG0D", "TG0H", "TH0P", "TL0P",
 	  "TN0D", "TN0H", "TN0P", "TO0P", "Tm0P", "Tp0P", NULL },
+/* Set 18: MacBookPro2,2 */
+	{ "TB0T", "TC0D", "TC0P", "TG0H", "TG0P", "TG0T", "TM0P", "TTF0",
+	  "Th0H", "Th1H", "Tm0P", "Ts0P", NULL },
 };
 
 /* List of keys used to read/write fan speeds */
@@ -1355,6 +1358,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 0, .light = 0, .temperature_set = 16 },
 /* iMac 9: light sensor only, temperature set 17 */
 	{ .accelerometer = 0, .light = 0, .temperature_set = 17 },
+/* MacBookPro2,2: accelerometer, backlight and temperature set 18 */
+	{ .accelerometer = 1, .light = 1, .temperature_set = 18 },
 };
 
 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1380,6 +1385,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3") },
 		&applesmc_dmi_data[9]},
+	{ applesmc_dmi_match, "Apple MacBookPro2,2", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple Computer, Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro2,2") },
+		&applesmc_dmi_data[18]},
 	{ applesmc_dmi_match, "Apple MacBook Pro", {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBookPro") },
-- 
1.6.5.GIT


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
