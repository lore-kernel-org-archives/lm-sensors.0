From: Henrik Rydberg <rydberg@bitmath.org>
Date: Thu, 20 Nov 2008 19:14:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Make applesmc load
Message-Id: <4925B6F8.5040500@bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

This patch makes use of the new dmi device loading support to
automatically load the applesmc driver based on the dmi_match table.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 488e45c..3e18f19 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1551,3 +1551,4 @@ module_exit(applesmc_exit);
 MODULE_AUTHOR("Nicolas Boichat");
 MODULE_DESCRIPTION("Apple SMC");
 MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(dmi, applesmc_whitelist);
-- 
1.5.6.3



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
