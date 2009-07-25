From: Roel Kluin <roel.kluin@gmail.com>
Date: Sat, 25 Jul 2009 08:18:15 +0000
Subject: Re: [lm-sensors] [PATCH] dme1737: Keep index within pwm_config[]
Message-Id: <4A6ABFC7.50401@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A689F42.4070701@gmail.com>
In-Reply-To: <4A689F42.4070701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The static code scanner "Parfait" reported this because pwm_config is
only 3 bytes - pwm_config[3] is out of range. Since this code path is
never called with ix = 3 (the device has no PWM4 output) this doesn't
change anything in practice. But to encourage testing with Parfait, lets
make the warning go away...

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
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
