From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 10 Jun 2013 15:47:45 +0000
Subject: [lm-sensors] [PATCH] hwmon/iio_hwmon: add alias table
Message-Id: <1370879265-32196-1-git-send-email-bigeasy@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This helps the kernel to find the right module once the device is
created.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hwmon/iio_hwmon.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 52b77af..708081b 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -180,6 +180,7 @@ static struct of_device_id iio_hwmon_of_match[] = {
 	{ .compatible = "iio-hwmon", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, iio_hwmon_of_match);
 
 static struct platform_driver __refdata iio_hwmon_driver = {
 	.driver = {
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
