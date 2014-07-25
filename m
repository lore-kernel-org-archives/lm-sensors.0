From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 25 Jul 2014 03:14:33 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (pwm-fan) Add proper #ifdef CONFIG_OF guard for of_device_id table
Message-Id: <1406258073.9778.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use of_match_ptr and proper #ifdef CONFIG_OF guard for of_device_id table.
Also makes of_pwm_fan_match const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/pwm-fan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index d2507a6..5354c36 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -170,10 +170,12 @@ static int pwm_fan_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pwm_fan_pm, pwm_fan_suspend, pwm_fan_resume);
 
-static struct of_device_id of_pwm_fan_match[] = {
+#ifdef CONFIG_OF
+static const struct of_device_id of_pwm_fan_match[] = {
 	{ .compatible = "pwm-fan", },
 	{},
 };
+#endif
 
 static struct platform_driver pwm_fan_driver = {
 	.probe		= pwm_fan_probe,
@@ -181,7 +183,7 @@ static struct platform_driver pwm_fan_driver = {
 	.driver	= {
 		.name		= "pwm-fan",
 		.pm		= &pwm_fan_pm,
-		.of_match_table	= of_pwm_fan_match,
+		.of_match_table	= of_match_ptr(of_pwm_fan_match),
 	},
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
