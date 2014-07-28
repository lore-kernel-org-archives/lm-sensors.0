From: weiyj_lk@163.com
Date: Mon, 28 Jul 2014 13:17:58 +0000
Subject: [lm-sensors] [PATCH -next] hwmon: (pwm-fan) Fix sparse NULL pointer warning
Message-Id: <1406553478-29767-1-git-send-email-weiyj_lk@163.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/hwmon/pwm-fan.c:107:67: warning: Using plain integer as NULL pointer

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index ba7fe3e..af30dd6 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -104,7 +104,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	mutex_init(&ctx->lock);
 
-	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, 0);
+	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
 	if (IS_ERR(ctx->pwm)) {
 		dev_err(&pdev->dev, "Could not get PWM\n");
 		return PTR_ERR(ctx->pwm);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
