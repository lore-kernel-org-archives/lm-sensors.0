From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:44 +0000
Subject: [lm-sensors] [PATCH 65/79] hwmon: (applesmc) Fix multi-line comments
Message-Id: <1327373398-997-66-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

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
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
