From: <grygorii.strashko@linaro.org>
Date: Tue, 03 Feb 2015 15:01:58 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: tmp102: add hibernation callbacks
Message-Id: <1422975718-871-1-git-send-email-grygorii.strashko@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org
Cc: sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Setting a dev_pm_ops suspend/resume pair but not a set of
hibernation functions means those pm functions will not be
called upon hibernation.
Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
assigns the suspend and hibernation handlers and move
mp102_suspend/tmp102_resume under CONFIG_PM_SLEEP to avoid
build warnings.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
V1:
- https://lkml.org/lkml/2015/2/2/509

 drivers/hwmon/tmp102.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index ba9f478..565df47 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -253,7 +253,7 @@ static int tmp102_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int tmp102_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -279,17 +279,10 @@ static int tmp102_resume(struct device *dev)
 	config &= ~TMP102_CONF_SD;
 	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
 }
-
-static const struct dev_pm_ops tmp102_dev_pm_ops = {
-	.suspend	= tmp102_suspend,
-	.resume		= tmp102_resume,
-};
-
-#define TMP102_DEV_PM_OPS (&tmp102_dev_pm_ops)
-#else
-#define	TMP102_DEV_PM_OPS NULL
 #endif /* CONFIG_PM */
 
+SIMPLE_DEV_PM_OPS(tmp102_dev_pm_ops, tmp102_suspend, tmp102_resume);
+
 static const struct i2c_device_id tmp102_id[] = {
 	{ "tmp102", 0 },
 	{ }
@@ -298,7 +291,7 @@ MODULE_DEVICE_TABLE(i2c, tmp102_id);
 
 static struct i2c_driver tmp102_driver = {
 	.driver.name	= DRIVER_NAME,
-	.driver.pm	= TMP102_DEV_PM_OPS,
+	.driver.pm	= &tmp102_dev_pm_ops,
 	.probe		= tmp102_probe,
 	.remove		= tmp102_remove,
 	.id_table	= tmp102_id,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
