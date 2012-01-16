From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 18:16:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus) Replace strict_strtol with kstrtol
Message-Id: <1326737807-14774-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

strict_strtol is deprecated and results in a checkpatch warning.
Replace it with kstrtol.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 00460d8..b31f461 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -781,7 +781,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 	int ret;
 	u16 regval;
 
-	if (strict_strtol(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
