From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 03 Jan 2012 11:02:41 +0000
Subject: [lm-sensors] [PATCH 2/2] drivers/hwmon/lm75.c: fix checkpatch
Message-Id: <1325588561-31073-2-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed this:

WARNING: strict_strtol is obsolete, use kstrtol instead
+   error = strict_strtol(buf, 10, &temp);

by replacing strict_strtol with kstrtol

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm75.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 903f229..b3311b1 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -111,7 +111,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	long temp;
 	int error;
 
-	error = strict_strtol(buf, 10, &temp);
+	error = kstrtol(buf, 10, &temp);
 	if (error)
 		return error;
 
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
