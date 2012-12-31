From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Dec 2012 08:13:07 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (vexpress) Remove __devexit and __devexit_p
Message-Id: <1356941588-25249-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vexpress.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index 59fd126..86d7f6d 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -196,7 +196,7 @@ error:
 	return err;
 }
 
-static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
+static int vexpress_hwmon_remove(struct platform_device *pdev)
 {
 	struct vexpress_hwmon_data *data = platform_get_drvdata(pdev);
 	const struct of_device_id *match;
@@ -213,7 +213,7 @@ static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver vexpress_hwmon_driver = {
 	.probe = vexpress_hwmon_probe,
-	.remove = __devexit_p(vexpress_hwmon_remove),
+	.remove = vexpress_hwmon_remove,
 	.driver	= {
 		.name = DRVNAME,
 		.owner = THIS_MODULE,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
