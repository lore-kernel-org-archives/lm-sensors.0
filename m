From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Date: Thu, 26 Jun 2014 12:57:10 +0000
Subject: [lm-sensors] [PATCH] hwmon: ntc_thermistor: correct the information printed during probe
Message-Id: <1403787014-5858-1-git-send-email-ch.naveen@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, linux@roeck-us.net, cpgs@samsung.com, herbert@gondor.apana.org.au

Currently, dev_info() at the end of the probe says
"type:%s ". But, prints the pdev->name.

This patch uses "pdev_id->name" which prints the thermistor type.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/hwmon/ntc_thermistor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index bdfbe91..ae66f42 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -512,7 +512,7 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "Thermistor type: %s successfully probed.\n",
-								pdev->name);
+								pdev_id->name);
 
 	return 0;
 err_after_sysfs:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
