From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 20 Jan 2011 21:27:56 +0000
Subject: [lm-sensors] [PATCH] HWMON: (lis3lv02d) Convert SPI to dev_pm_ops
Message-Id: <1295558876-25061-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is a move to deprecate bus-specific PM operations and move to
using dev_pm_ops instead in order to reduce the amount of boilerplate
code in buses and facilitiate updates to the PM core. Do this move for
the lis3lv02d SPI driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/hwmon/lis3lv02d_spi.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d_spi.c b/drivers/hwmon/lis3lv02d_spi.c
index 2549de1..c1f8a8f 100644
--- a/drivers/hwmon/lis3lv02d_spi.c
+++ b/drivers/hwmon/lis3lv02d_spi.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/spi/spi.h>
+#include <linux/pm.h>
 
 #include "lis3lv02d.h"
 
@@ -88,9 +89,10 @@ static int __devexit lis302dl_spi_remove(struct spi_device *spi)
 	return lis3lv02d_remove_fs(&lis3_dev);
 }
 
-#ifdef CONFIG_PM
-static int lis3lv02d_spi_suspend(struct spi_device *spi, pm_message_t mesg)
+#ifdef CONFIG_PM_SLEEP
+static int lis3lv02d_spi_suspend(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct lis3lv02d *lis3 = spi_get_drvdata(spi);
 
 	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
@@ -99,8 +101,9 @@ static int lis3lv02d_spi_suspend(struct spi_device *spi, pm_message_t mesg)
 	return 0;
 }
 
-static int lis3lv02d_spi_resume(struct spi_device *spi)
+static int lis3lv02d_spi_resume(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct lis3lv02d *lis3 = spi_get_drvdata(spi);
 
 	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
@@ -108,21 +111,19 @@ static int lis3lv02d_spi_resume(struct spi_device *spi)
 
 	return 0;
 }
-
-#else
-#define lis3lv02d_spi_suspend	NULL
-#define lis3lv02d_spi_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(lis3lv02d_spi_pm, lis3lv02d_spi_suspend,
+			 lis3lv02d_spi_resume);
+
 static struct spi_driver lis302dl_spi_driver = {
 	.driver	 = {
 		.name   = DRV_NAME,
 		.owner  = THIS_MODULE,
+		.pm	= &lis3lv02d_spi_pm,
 	},
 	.probe	= lis302dl_spi_probe,
 	.remove	= __devexit_p(lis302dl_spi_remove),
-	.suspend = lis3lv02d_spi_suspend,
-	.resume  = lis3lv02d_spi_resume,
 };
 
 static int __init lis302dl_init(void)
-- 
1.7.2.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
