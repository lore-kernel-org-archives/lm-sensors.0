From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:30 +0000
Subject: [lm-sensors] [PATCH 07/12] hwmon: (gpio_fan) Use error value returned from get_fan_speed_index()
Message-Id: <1379147615-7703-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

get_fan_speed_index() returns -EINVAL in case of errors, only to have it
ignored and replaced with -ENODEV. Make it return -ENODEV and use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpio-fan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index b7d6a57..155c78f 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -169,7 +169,7 @@ static int get_fan_speed_index(struct gpio_fan_data *fan_data)
 	dev_warn(&fan_data->pdev->dev,
 		 "missing speed array entry for GPIO value 0x%x\n", ctrl_val);
 
-	return -EINVAL;
+	return -ENODEV;
 }
 
 static int rpm_to_speed_index(struct gpio_fan_data *fan_data, int rpm)
@@ -384,7 +384,7 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 	fan_data->pwm_enable = true; /* Enable manual fan speed control. */
 	fan_data->speed_index = get_fan_speed_index(fan_data);
 	if (fan_data->speed_index < 0)
-		return -ENODEV;
+		return fan_data->speed_index;
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
