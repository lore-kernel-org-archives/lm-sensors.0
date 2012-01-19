From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:25 +0000
Subject: [lm-sensors] [PATCH 31/82] hwmon: (jc42) Fix multi-line comments
Message-Id: <1327017376-20466-32-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 28c09ee..fc8ea29 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -324,8 +324,10 @@ set(temp_min, JC42_REG_TEMP_LOWER);
 set(temp_max, JC42_REG_TEMP_UPPER);
 set(temp_crit, JC42_REG_TEMP_CRITICAL);
 
-/* JC42.4 compliant chips only support four hysteresis values.
- * Pick best choice and go from there. */
+/*
+ * JC42.4 compliant chips only support four hysteresis values.
+ * Pick best choice and go from there.
+ */
 static ssize_t set_temp_crit_hyst(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
