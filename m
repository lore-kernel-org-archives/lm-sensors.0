From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Date: Mon, 07 Jun 2010 13:20:19 +0000
Subject: [lm-sensors] [RFC][PATCH] Add suspend resume feature to lm75
Message-Id: <0680EC522D0CC943BC586913CF3768C003B34011FC@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is a shutdown feature at suspend it can be enabled
to reduce current consumption and resume it can be switched
off. Also some minor changes to keep checkpatch happy

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm75.h |    3 ++-
 2 files changed, 39 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 drivers/hwmon/lm75.c

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
old mode 100644
new mode 100755
index 5646342..ae717a0
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -281,11 +281,48 @@ static int lm75_detect(struct i2c_client *new_client,
 
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
index 7c93454..c2d8120 100644
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -30,13 +30,14 @@
 /* straight from the datasheet */
 #define LM75_TEMP_MIN (-55000)
 #define LM75_TEMP_MAX 125000
+#define LM75_SHUTDOWN 0x01
 
 /* TEMP: 0.001C/bit (-55C to +125C)
    REG: (0.5C/bit, two's complement) << 7 */
 static inline u16 LM75_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
-	ntemp += (ntemp<0 ? -250 : 250);
+	ntemp += (ntemp < 0 ? -250 : 250);
 	return (u16)((ntemp / 500) << 7);
 }
 
-- 
1.5.4.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
