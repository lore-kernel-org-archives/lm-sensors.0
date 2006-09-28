From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:36 +0000
Subject: [lm-sensors] [PATCH 16/39] abituguru: Add suspend/resume support
Message-Id: <1159483791314-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede at hhs.nl>

This patch contains rudimentary suspend / resume support for the uguru,
this protects the uguru and the driver against suspend / resume cycles,
so there is no reason to unload the driver in your suspend / resume
scripts.

Only include suspend / resume functions when CONFIG_PM is set.

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/abituguru.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 35ad1b0..e5cb0fd 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1354,13 +1354,39 @@ LEAVE_UPDATE:
 		return NULL;
 }
 
+#ifdef CONFIG_PM
+static int abituguru_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct abituguru_data *data = platform_get_drvdata(pdev);
+	/* make sure all communications with the uguru are done and no new
+	   ones are started */
+	mutex_lock(&data->update_lock);
+	return 0;
+}
+
+static int abituguru_resume(struct platform_device *pdev)
+{
+	struct abituguru_data *data = platform_get_drvdata(pdev);
+	/* See if the uGuru is still ready */
+	if (inb_p(data->addr + ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT)
+		data->uguru_ready = 0;
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+#else
+#define abituguru_suspend	NULL
+#define abituguru_resume	NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver abituguru_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= ABIT_UGURU_NAME,
 	},
-	.probe	= abituguru_probe,
-	.remove	= __devexit_p(abituguru_remove),
+	.probe		= abituguru_probe,
+	.remove		= __devexit_p(abituguru_remove),
+	.suspend	= abituguru_suspend,
+	.resume		= abituguru_resume,
 };
 
 static int __init abituguru_detect(void)
-- 
1.4.2.1


