From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 05 Mar 2013 03:12:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: (mc13783-adc.c) use module_platform_driver_probe()
Message-Id: <005401ce194f$54e8b250$feba16f0$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/mc13783-adc.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index 2a7f331..982d862 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -273,18 +273,7 @@ static struct platform_driver mc13783_adc_driver = {
 	.id_table	= mc13783_adc_idtable,
 };
 
-static int __init mc13783_adc_init(void)
-{
-	return platform_driver_probe(&mc13783_adc_driver, mc13783_adc_probe);
-}
-
-static void __exit mc13783_adc_exit(void)
-{
-	platform_driver_unregister(&mc13783_adc_driver);
-}
-
-module_init(mc13783_adc_init);
-module_exit(mc13783_adc_exit);
+module_platform_driver_probe(mc13783_adc_driver, mc13783_adc_probe);
 
 MODULE_DESCRIPTION("MC13783 ADC driver");
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
-- 
1.7.2.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
