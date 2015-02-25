From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Feb 2015 17:16:21 +0000
Subject: [lm-sensors] [PATCH v2 5/5] hwmon: (it87) No need to skip fan4 for IT8603
Message-Id: <1424884581-2348-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IT8603 supports only three fans, so it is not necessary to skip fan4.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Patch added to series

 drivers/hwmon/it87.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 691067b..ab12dc2 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1932,10 +1932,6 @@ static int __init it87_find(unsigned short *address,
 		sio_data->skip_in |= (1 << 5); /* No VIN5 */
 		sio_data->skip_in |= (1 << 6); /* No VIN6 */
 
-		/* no fan4 */
-		sio_data->skip_pwm |= (1 << 3);
-		sio_data->skip_fan |= (1 << 3);
-
 		sio_data->internal |= (1 << 1); /* in7 is VSB */
 		sio_data->internal |= (1 << 3); /* in9 is AVCC */
 
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
