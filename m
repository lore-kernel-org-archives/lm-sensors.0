From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 12 Jan 2012 01:55:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Add range check to set_update_interval
Message-Id: <1326333305-11082-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When writing the update_interval attribute, the parameter value was not range
checked, which could cause an integer overflow and result in an arbitrary
update interval. Fix by limiting the value range to <0, 100000>.

Reported-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index bdfd675..d2dd5f9 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -917,7 +917,7 @@ static ssize_t set_update_interval(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	lm90_set_convrate(client, data, val);
+	lm90_set_convrate(client, data, SENSORS_LIMIT(val, 0, 100000));
 	mutex_unlock(&data->update_lock);
 
 	return count;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
