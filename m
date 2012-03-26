From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 26 Mar 2012 15:41:02 +0000
Subject: [lm-sensors] [PATCH] hwmon: max6639: Convert to dev_pm_ops
Message-Id: <1332776462-22343-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The I2C specific PM operations have been deprecated and printing a
warning on boot for over a year now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/hwmon/max6639.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 193067e..c028fd5 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -596,8 +596,9 @@ static int max6639_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int max6639_suspend(struct i2c_client *client, pm_message_t mesg)
+static int max6639_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
 	if (data < 0)
 		return data;
@@ -606,8 +607,9 @@ static int max6639_suspend(struct i2c_client *client, pm_message_t mesg)
 			MAX6639_REG_GCONFIG, data | MAX6639_GCONFIG_STANDBY);
 }
 
-static int max6639_resume(struct i2c_client *client)
+static int max6639_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
 	if (data < 0)
 		return data;
@@ -623,15 +625,19 @@ static const struct i2c_device_id max6639_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max6639_id);
 
+static const struct dev_pm_ops max6639_pm_ops = {
+	.suspend = max6639_suspend,
+	.resume = max6639_resume,
+};
+
 static struct i2c_driver max6639_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		   .name = "max6639",
+		   .pm = &max6639_pm_ops,
 		   },
 	.probe = max6639_probe,
 	.remove = max6639_remove,
-	.suspend = max6639_suspend,
-	.resume = max6639_resume,
 	.id_table = max6639_id,
 	.detect = max6639_detect,
 	.address_list = normal_i2c,
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
