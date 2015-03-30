From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 06:33:42 +0000
Subject: [lm-sensors] [PATCH 02/15] hwmon: (it87) Fix pwm sysfs attribute removal
Message-Id: <1427697235-23566-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Detection if a pwm channel is supported was wrong on removal,
causing the code to try removing non-existing sysfs attributes.
That didn't matter much because sysfs attribute removal of non-existing
files fails silently, and because the wrong evaluation always returned
false, but should nevertheless be fixed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 7ab5bd026e91..180750ef6156 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -2095,7 +2095,7 @@ static void it87_remove_files(struct device *dev)
 					  it87_attributes_fan_div[i]);
 	}
 	for (i = 0; i < 3; i++) {
-		if (sio_data->skip_pwm & (1 << 0))
+		if (sio_data->skip_pwm & (1 << i))
 			continue;
 		sysfs_remove_group(&dev->kobj, &it87_group_pwm[i]);
 		if (has_old_autopwm(data))
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
