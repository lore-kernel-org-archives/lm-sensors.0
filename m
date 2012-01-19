From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:55 +0000
Subject: [lm-sensors] [PATCH 61/82] hwmon: (smm665) Fix multi-line comments
Message-Id: <1327017376-20466-62-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smm665.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 1b4301f..51f8178 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -389,7 +389,8 @@ SMM665_SHOW(max);
 SMM665_SHOW(lcrit);
 SMM665_SHOW(crit);
 
-/* These macros are used below in constructing device attribute objects
+/*
+ * These macros are used below in constructing device attribute objects
  * for use with sysfs_create_group() to make a sysfs device file
  * for each register.
  */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
