From: Roland Stigge <stigge@antcom.de>
Date: Sat, 24 Mar 2012 18:36:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: max6639: Fix CONFIG_PM compile option
Message-Id: <1332614169-30854-1-git-send-email-stigge@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes a compiler warning in case CONFIG_PM is not defined

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

 This solves the issue recently encountered by Kurt Roeck in the nightly build.

 The solution with #ifdef's is done as in all the other drivers.

 drivers/hwmon/max6639.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.orig/drivers/hwmon/max6639.c
+++ linux-2.6/drivers/hwmon/max6639.c
@@ -596,6 +596,7 @@ static int max6639_remove(struct i2c_cli
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -617,6 +618,10 @@ static int max6639_resume(struct device
 	return i2c_smbus_write_byte_data(client,
 			MAX6639_REG_GCONFIG, data & ~MAX6639_GCONFIG_STANDBY);
 }
+#else
+#define max6639_suspend NULL
+#define max6639_resume NULL
+#endif
 
 static const struct i2c_device_id max6639_id[] = {
 	{"max6639", 0},

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
