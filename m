From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 May 2010 09:02:53 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (tmp102) Fix suspend and resume
Message-Id: <20100518110253.58655906@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Suspend and resume functions shouldn't overwrite the configuration
register. They should only alter the one bit they have to touch.

Also don't assume that register reads and writes always succeed.
Handle errors properly, shall they happen.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Steven King <sfking@fdwdc.com>
---
 drivers/hwmon/tmp102.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.34.orig/drivers/hwmon/tmp102.c	2010-05-18 10:57:05.000000000 +0200
+++ linux-2.6.34/drivers/hwmon/tmp102.c	2010-05-18 10:57:10.000000000 +0200
@@ -239,19 +239,27 @@ static int __devexit tmp102_remove(struc
 static int tmp102_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	int config;
 
-	tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONF_SD);
+	config = tmp102_read_reg(client, TMP102_CONF_REG);
+	if (config < 0)
+		return config;
 
-	return 0;
+	config |= TMP102_CONF_SD;
+	return tmp102_write_reg(client, TMP102_CONF_REG, config);
 }
 
 static int tmp102_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	int config;
 
-	tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONFIG);
+	config = tmp102_read_reg(client, TMP102_CONF_REG);
+	if (config < 0)
+		return config;
 
-	return 0;
+	config &= ~TMP102_CONF_SD;
+	return tmp102_write_reg(client, TMP102_CONF_REG, config);
 }
 
 static const struct dev_pm_ops tmp102_dev_pm_ops = {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
