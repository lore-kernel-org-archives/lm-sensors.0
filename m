From: Henrik Rydberg <rydberg@euromail.se>
Date: Mon, 17 Nov 2008 09:34:33 +0000
Subject: [lm-sensors] [PATCH] Add generic MacPro support
Message-Id: <49213AA9.6070800@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

In order to analyze the SMC of the newer MacPros, applesmc needs to
recognize the machine. This patch adds the missing generic dmi_match
entry for MacPro models.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 10977b3..f7dce8b 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1354,6 +1354,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacPro2") },
 		&applesmc_dmi_data[4]},
+	{ applesmc_dmi_match, "Apple MacPro", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacPro") },
+		&applesmc_dmi_data[4]},
 	{ applesmc_dmi_match, "Apple iMac 8", {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac8") },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
