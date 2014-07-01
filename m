From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 01 Jul 2014 23:44:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (amc6821) Fix permissions for temp2_input
Message-Id: <1404258284.7829.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

temp2_input should not be writable, fix it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/amc6821.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index cb84fb9..66b994a 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -743,7 +743,7 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
 	get_temp_alarm, NULL, IDX_TEMP1_MAX);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO,
 	get_temp_alarm, NULL, IDX_TEMP1_CRIT);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO,
 	get_temp, NULL, IDX_TEMP2_INPUT);
 static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, get_temp,
 	set_temp, IDX_TEMP2_MIN);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
