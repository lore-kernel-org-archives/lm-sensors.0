From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Date: Tue, 06 Jul 2010 14:11:07 +0000
Subject: [lm-sensors] [RFC][PATCH] suspend resume lm75
Message-Id: <0680EC522D0CC943BC586913CF3768C003B36037D4@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100706161029.6b2aef3f@hyperion.delvare>
In-Reply-To: <20100706161029.6b2aef3f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is a shutdown feature at suspend it can be enabled
to reduce current consumption and resume it can be switched
off.

- Removed the unnecessary cleanups 

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm75.h |    1 +
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 393f354..906b1a0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -279,11 +279,48 @@ static int lm75_detect(struct i2c_client *new_client,
 
 	return 0;
 }
+#ifdef CONFIG_PM
+static int lm75_suspend(struct device *dev)
+{
+	int status;
+	struct i2c_client *client = to_i2c_client(dev);
+	status = lm75_read_value(client, LM75_REG_CONF);
+	if (status < 0) {
+		dev_dbg(&client->dev, "Can't read config? %d\n", status);
+		return status;
+	}
+	status = status | LM75_SHUTDOWN;
+	lm75_write_value(client, LM75_REG_CONF, status);
+	return 0;
+}
+
+static int lm75_resume(struct device *dev)
+{
+	int status;
+	struct i2c_client *client = to_i2c_client(dev);
+	status = lm75_read_value(client, LM75_REG_CONF);
+	if (status < 0) {
+		dev_dbg(&client->dev, "Can't read config? %d\n", status);
+		return status;
+	}
+	status = status & ~LM75_SHUTDOWN;
+	lm75_write_value(client, LM75_REG_CONF, status);
+	return 0;
+}
+static const struct dev_pm_ops lm75_dev_pm_ops = {
+	.suspend	= lm75_suspend,
+	.resume	= lm75_resume,
+};
 
+#define LM75_DEV_PM_OPS (&lm75_dev_pm_ops)
+#else
+#define	LM75_DEV_PM_OPS NULL
+#endif /* CONFIG_PM */
 static struct i2c_driver lm75_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm75",
+		.pm	= LM75_DEV_PM_OPS,
 	},
 	.probe		= lm75_probe,
 	.remove		= lm75_remove,
diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
index 7c93454..e547a3e 100644
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -30,6 +30,7 @@
 /* straight from the datasheet */
 #define LM75_TEMP_MIN (-55000)
 #define LM75_TEMP_MAX 125000
+#define LM75_SHUTDOWN 0x01
 
 /* TEMP: 0.001C/bit (-55C to +125C)
    REG: (0.5C/bit, two's complement) << 7 */
-- 
1.5.4.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
