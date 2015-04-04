From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 22:05:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Fix pwm frequency display
Message-Id: <1428185145-22959-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 687c68dd7955 ("hwmon: (it87) Fix PWM frequency display for chips
with newer PWM control") tried to fix pwm frequency display but got operator
precedence all wrong, resulting in a pwm frequency display of 256 or,
with older chips, a division by zero.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I might actually fold this one into the original patch, given the severeness
of the problem.

 drivers/hwmon/it87.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 2c2d945e47e3..b70227108cb8 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1085,7 +1085,7 @@ static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
 	else
 		index = (data->fan_ctl >> 4) & 0x07;
 
-	freq = pwm_freq[index] / has_newer_autopwm(data) ? 256 : 128;
+	freq = pwm_freq[index] / (has_newer_autopwm(data) ? 256 : 128);
 
 	return sprintf(buf, "%u\n", freq);
 }
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
