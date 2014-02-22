From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Feb 2014 17:30:12 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (lm95245) Make temp2_crit_hyst read-only
Message-Id: <1393090212-24900-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The hysteresis register is shared among both temperature sensors.
This means changing one also affects the other. To avoid confusion,
established way to express this is to make only the first instance writable
and keep all other instances as read-only. Otherwise users may be
confused that changing the second writable value also affects the first,
while it is more obvious that a writable value may affect a different
read-only value.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Additional patch

 drivers/hwmon/lm95245.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 310e145..1f6a18f 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -396,8 +396,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_limit,
 		set_limit, 7);
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_crit_hyst,
-		set_crit_hyst, 7);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_crit_hyst, NULL, 7);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
 		STATUS1_RTCRIT);
 static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
