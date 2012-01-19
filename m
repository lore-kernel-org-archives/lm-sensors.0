From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:09 +0000
Subject: [lm-sensors] [PATCH 15/82] hwmon: (asc7621) Fix multi-line comments
Message-Id: <1327017376-20466-16-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: George Joseph <george.joseph@fairview5.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asc7621.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index 3efd324..7caa242 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -268,9 +268,11 @@ static ssize_t store_fan16(struct device *dev,
 	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
-	/* If a minimum RPM of zero is requested, then we set the register to
-	   0xffff. This value allows the fan to be stopped completely without
-	   generating an alarm. */
+	/*
+	 * If a minimum RPM of zero is requested, then we set the register to
+	 * 0xffff. This value allows the fan to be stopped completely without
+	 * generating an alarm.
+	 */
 	reqval  	    (reqval <= 0 ? 0xffff : SENSORS_LIMIT(5400000 / reqval, 0, 0xfffe));
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
