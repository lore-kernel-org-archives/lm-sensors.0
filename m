From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 18:50:16 +0000
Subject: [lm-sensors] [PATCH 2/4] drivers/hwmon/mc13783-adc.c: remove space
Message-Id: <1325789418-11276-2-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

---
 drivers/hwmon/mc13783-adc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index ef65ab5..04d13b3 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -220,7 +220,7 @@ static int __devexit mc13783_adc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver mc13783_adc_driver = {
-	.remove 	= __devexit_p(mc13783_adc_remove),
+	.remove		= __devexit_p(mc13783_adc_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= MC13783_ADC_NAME,
-- 
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
