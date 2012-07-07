From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 07 Jul 2012 21:06:08 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon / exynos4_tmu: Use struct dev_pm_ops for power management
Message-Id: <201207072306.09305.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <201207072302.16491.rjw@sisk.pl>
In-Reply-To: <201207072302.16491.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alistair John Strachan <alistair@devzero.co.uk>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene.kim@samsung.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the Exynos4 TMU driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/hwmon/exynos4_tmu.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Index: linux/drivers/hwmon/exynos4_tmu.c
=================================--- linux.orig/drivers/hwmon/exynos4_tmu.c
+++ linux/drivers/hwmon/exynos4_tmu.c
@@ -476,34 +476,37 @@ static int __devexit exynos4_tmu_remove(
 }
 
 #ifdef CONFIG_PM
-static int exynos4_tmu_suspend(struct platform_device *pdev, pm_message_t state)
+static int exynos4_tmu_suspend(struct device *dev)
 {
-	exynos4_tmu_control(pdev, false);
+	exynos4_tmu_control(to_platform_device(dev), false);
 
 	return 0;
 }
 
-static int exynos4_tmu_resume(struct platform_device *pdev)
+static int exynos4_tmu_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+
 	exynos4_tmu_initialize(pdev);
 	exynos4_tmu_control(pdev, true);
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(exynos4_tmu_pm, exynos4_tmu_suspend, exynos4_tmu_resume);
+#define EXYNOS4_TMU_PM	(&exynos4_tmu_pm)
 #else
-#define exynos4_tmu_suspend NULL
-#define exynos4_tmu_resume NULL
+#define EXYNOS4_TMU_PM	NULL
 #endif
 
 static struct platform_driver exynos4_tmu_driver = {
 	.driver = {
 		.name   = "exynos4-tmu",
 		.owner  = THIS_MODULE,
+		.pm     = EXYNOS4_TMU_PM,
 	},
 	.probe = exynos4_tmu_probe,
 	.remove	= __devexit_p(exynos4_tmu_remove),
-	.suspend = exynos4_tmu_suspend,
-	.resume = exynos4_tmu_resume,
 };
 
 module_platform_driver(exynos4_tmu_driver);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
