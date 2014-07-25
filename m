From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 25 Jul 2014 03:12:26 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pwm-fan) Remove duplicate dev_set_drvdata call
Message-Id: <1406257946.9778.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The dev_set_drvdata() call is equivalent to the platform_set_drvdata() call in
next line.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/pwm-fan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index ba7fe3e..d2507a6 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -110,7 +110,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->pwm);
 	}
 
-	dev_set_drvdata(&pdev->dev, ctx);
 	platform_set_drvdata(pdev, ctx);
 
 	/* Set duty cycle to maximum allowed */
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
