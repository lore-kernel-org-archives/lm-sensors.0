From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 07 Jul 2012 21:04:09 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon / abituguru: Use struct dev_pm_ops for power management
Message-Id: <201207072304.10067.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <201207072302.16491.rjw@sisk.pl>
In-Reply-To: <201207072302.16491.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alistair John Strachan <alistair@devzero.co.uk>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene.kim@samsung.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the Abit uGuru driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/hwmon/abituguru.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

Index: linux/drivers/hwmon/abituguru.c
=================================--- linux.orig/drivers/hwmon/abituguru.c
+++ linux/drivers/hwmon/abituguru.c
@@ -1514,9 +1514,11 @@ LEAVE_UPDATE:
 }
 
 #ifdef CONFIG_PM
-static int abituguru_suspend(struct platform_device *pdev, pm_message_t state)
+static int abituguru_suspend(struct device *dev)
 {
-	struct abituguru_data *data = platform_get_drvdata(pdev);
+	struct abituguru_data *data;
+
+	data = platform_get_drvdata(to_platform_device(dev));
 	/*
 	 * make sure all communications with the uguru are done and no new
 	 * ones are started
@@ -1525,29 +1527,32 @@ static int abituguru_suspend(struct plat
 	return 0;
 }
 
-static int abituguru_resume(struct platform_device *pdev)
+static int abituguru_resume(struct device *dev)
 {
-	struct abituguru_data *data = platform_get_drvdata(pdev);
+	struct abituguru_data *data;
+
+	data = platform_get_drvdata(to_platform_device(dev));
 	/* See if the uGuru is still ready */
 	if (inb_p(data->addr + ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT)
 		data->uguru_ready = 0;
 	mutex_unlock(&data->update_lock);
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(abituguru_pm, abituguru_suspend, abituguru_resume);
+#define ABIT_UGURU_PM	(&abituguru_pm)
 #else
-#define abituguru_suspend	NULL
-#define abituguru_resume	NULL
+#define ABIT_UGURU_PM	NULL
 #endif /* CONFIG_PM */
 
 static struct platform_driver abituguru_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= ABIT_UGURU_NAME,
+		.pm	= ABIT_UGURU_PM,
 	},
 	.probe		= abituguru_probe,
 	.remove		= __devexit_p(abituguru_remove),
-	.suspend	= abituguru_suspend,
-	.resume		= abituguru_resume,
 };
 
 static int __init abituguru_detect(void)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
