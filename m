From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 14 May 2009 11:29:38 +0000
Subject: [lm-sensors] [PATCH] missing parentheses?
Message-Id: <4A0C00A2.1080803@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add missing parentheses.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
The original code looks odd, but I am not sure whether my patch is correct.
So please review.

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 3195a26..a5a511b 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -219,9 +219,9 @@ static ssize_t show_pwm1(struct device *dev, struct device_attribute *dummy,
 			 char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * data->pwm1_freq ?
+	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * (data->pwm1_freq ?
 		       255 : (data->pwm1_value * 255 + data->pwm1_freq) /
-		       (2 * data->pwm1_freq));
+		       (2 * data->pwm1_freq)));
 }
 
 static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
