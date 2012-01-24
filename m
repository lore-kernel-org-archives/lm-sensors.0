From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:06 +0000
Subject: [lm-sensors] [PATCH 27/79] hwmon: (ltc4151) Fix multi-line comments
Message-Id: <1327373398-997-28-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Per Dalen <per.dalen@appeartv.com>
---
 drivers/hwmon/ltc4151.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
index f646b45..4d005b2 100644
--- a/drivers/hwmon/ltc4151.c
+++ b/drivers/hwmon/ltc4151.c
@@ -154,7 +154,8 @@ static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, \
 static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, \
 	ltc4151_show_value, NULL, LTC4151_SENSE_H);
 
-/* Finally, construct an array of pointers to members of the above objects,
+/*
+ * Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
 static struct attribute *ltc4151_attributes[] = {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
