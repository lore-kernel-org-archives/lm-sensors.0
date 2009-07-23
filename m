From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 23 Jul 2009 17:34:58 +0000
Subject: [lm-sensors] [PATCH] dme1737: Keep index within pwm_config[]
Message-Id: <4A689F42.4070701@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pwm_config is only 3 bytes - pwm_config[3] is out of range.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Credits to Parfait and Nathan Keynes,

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 3df202a..57e8ed4 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -1134,7 +1134,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 		res = PWM_FREQ_FROM_REG(data->pwm_freq[ix]);
 		break;
 	case SYS_PWM_ENABLE:
-		if (ix > 3) {
+		if (ix >= 3) {
 			res = 1; /* pwm[5-6] hard-wired to manual mode */
 		} else {
 			res = PWM_EN_FROM_REG(data->pwm_config[ix]);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
