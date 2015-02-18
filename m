From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 18 Feb 2015 10:07:34 +0000
Subject: [lm-sensors] [PATCH v4 6/8] hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty cyc
Message-Id: <1424254056-5904-7-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

It was necessary to decouple code handling writing to sysfs from the one
responsible for setting PWM of the fan.
Due to that, new __set_pwm() method was extracted, which is responsible for
only setting new PWM duty cycle.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- The commit headline has been reedited.
Changes for v4:
- Protect "if (ctx->pwm_value = pwm)" with ctx lock
- Initialize ret with zero
---
 drivers/hwmon/pwm-fan.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 1991d903..bd42d39 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -33,20 +33,14 @@ struct pwm_fan_ctx {
 	unsigned char pwm_value;
 };
 
-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
-	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	unsigned long pwm, duty;
-	ssize_t ret;
-
-	if (kstrtoul(buf, 10, &pwm) || pwm > MAX_PWM)
-		return -EINVAL;
+	unsigned long duty;
+	int ret = 0;
 
 	mutex_lock(&ctx->lock);
-
 	if (ctx->pwm_value = pwm)
-		goto exit_set_pwm_no_change;
+		goto exit_set_pwm_err;
 
 	if (pwm = 0) {
 		pwm_disable(ctx->pwm);
@@ -66,13 +60,28 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 
 exit_set_pwm:
 	ctx->pwm_value = pwm;
-exit_set_pwm_no_change:
-	ret = count;
 exit_set_pwm_err:
 	mutex_unlock(&ctx->lock);
 	return ret;
 }
 
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	unsigned long pwm;
+	int ret;
+
+	if (kstrtoul(buf, 10, &pwm) || pwm > MAX_PWM)
+		return -EINVAL;
+
+	ret = __set_pwm(ctx, pwm);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static ssize_t show_pwm(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
