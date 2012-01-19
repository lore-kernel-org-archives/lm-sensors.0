From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:07 +0000
Subject: [lm-sensors] [PATCH 13/82] hwmon: (applesmc) Fix multi-line comments
Message-Id: <1327017376-20466-14-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/applesmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b989553..1b13085 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1189,8 +1189,10 @@ static int applesmc_dmi_match(const struct dmi_system_id *id)
 	return 1;
 }
 
-/* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
- * So we need to put "Apple MacBook Pro" before "Apple MacBook". */
+/*
+ * Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
+ * So we need to put "Apple MacBook Pro" before "Apple MacBook".
+ */
 static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	{ applesmc_dmi_match, "Apple MacBook Air", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
