From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:09:50 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (tmp102) Convert to use __pm instead of #ifdef CONFIG_PM
Message-Id: <1368119391-13837-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>, Guenter Roeck <linux@roeck-us.net>

With this change, code only needed is power management is active still
compiles if it is disabled, but does not consume space in the object file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp102.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 523dd89..8e5d267 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -236,8 +236,7 @@ static int tmp102_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int tmp102_suspend(struct device *dev)
+static int __pm tmp102_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int config;
@@ -250,7 +249,7 @@ static int tmp102_suspend(struct device *dev)
 	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
 }
 
-static int tmp102_resume(struct device *dev)
+static int __pm tmp102_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int config;
@@ -263,16 +262,11 @@ static int tmp102_resume(struct device *dev)
 	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
 }
 
-static const struct dev_pm_ops tmp102_dev_pm_ops = {
+static const struct dev_pm_ops __pm tmp102_dev_pm_ops = {
 	.suspend	= tmp102_suspend,
 	.resume		= tmp102_resume,
 };
 
-#define TMP102_DEV_PM_OPS (&tmp102_dev_pm_ops)
-#else
-#define	TMP102_DEV_PM_OPS NULL
-#endif /* CONFIG_PM */
-
 static const struct i2c_device_id tmp102_id[] = {
 	{ "tmp102", 0 },
 	{ }
@@ -281,7 +275,7 @@ MODULE_DEVICE_TABLE(i2c, tmp102_id);
 
 static struct i2c_driver tmp102_driver = {
 	.driver.name	= DRIVER_NAME,
-	.driver.pm	= TMP102_DEV_PM_OPS,
+	.driver.pm	= pm_ops_ptr(&tmp102_dev_pm_ops),
 	.probe		= tmp102_probe,
 	.remove		= tmp102_remove,
 	.id_table	= tmp102_id,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
