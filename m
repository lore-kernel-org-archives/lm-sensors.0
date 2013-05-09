From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:09:51 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (max6639) Convert to use __pm instead of #ifdef CONFIG_PM_SLEEP
Message-Id: <1368119391-13837-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>, Guenter Roeck <linux@roeck-us.net>

Drops #ifdef from code, and ensures that conditional code still compiles
if power management is disabled. Resulting code is dropped from object file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6639.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 3e7b426..6080913 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -591,8 +591,7 @@ static int max6639_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max6639_suspend(struct device *dev)
+static int __pm max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
@@ -603,7 +602,7 @@ static int max6639_suspend(struct device *dev)
 			MAX6639_REG_GCONFIG, data | MAX6639_GCONFIG_STANDBY);
 }
 
-static int max6639_resume(struct device *dev)
+static int __pm max6639_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
@@ -613,7 +612,6 @@ static int max6639_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(client,
 			MAX6639_REG_GCONFIG, data & ~MAX6639_GCONFIG_STANDBY);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id max6639_id[] = {
 	{"max6639", 0},
@@ -622,15 +620,16 @@ static const struct i2c_device_id max6639_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max6639_id);
 
-static const struct dev_pm_ops max6639_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(max6639_suspend, max6639_resume)
+static const struct dev_pm_ops __pm max6639_pm_ops = {
+	.suspend = max6639_suspend,
+	.resume = max6639_resume,
 };
 
 static struct i2c_driver max6639_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		   .name = "max6639",
-		   .pm = &max6639_pm_ops,
+		   .pm = pm_ops_ptr(&max6639_pm_ops),
 		   },
 	.probe = max6639_probe,
 	.remove = max6639_remove,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
