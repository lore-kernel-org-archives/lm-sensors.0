From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:34 +0000
Subject: [lm-sensors] [PATCH 40/82] hwmon: (lm87) Fix multi-line comments
Message-Id: <1327017376-20466-41-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm87.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index ebf4efd..68a5899 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -489,10 +489,12 @@ static ssize_t set_fan_min(struct device *dev, const char *buf, int nr,
 	return count;
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan clock divider.  This follows the principle
-   of least surprise; the user doesn't expect the fan minimum to change just
-   because the divider changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan clock divider.  This follows the principle
+ * of least surprise; the user doesn't expect the fan minimum to change just
+ * because the divider changed.
+ */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
