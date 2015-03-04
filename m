From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 04 Mar 2015 17:54:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pwm-fan) Declare pwm_fan_of_get_cooling_data static
Message-Id: <1425491682-6555-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Address the following sparse warnings.

drivers/hwmon/pwm-fan.c:176:5: warning:
	symbol 'pwm_fan_of_get_cooling_data' was not declared. Should it be static?
drivers/hwmon/pwm-fan.c:176:5: warning:
	no previous prototype for 'pwm_fan_of_get_cooling_data'

pwm_fan_of_get_cooling_data is only used in the pwm-fan driver and thus should
be declared static.

Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7c83dc4..4170728 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -173,7 +173,8 @@ static const struct thermal_cooling_device_ops pwm_fan_cooling_ops = {
 	.set_cur_state = pwm_fan_set_cur_state,
 };
 
-int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
+static int pwm_fan_of_get_cooling_data(struct device *dev,
+				       struct pwm_fan_ctx *ctx)
 {
 	struct device_node *np = dev->of_node;
 	int num, i, ret;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
