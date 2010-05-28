From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Date: Fri, 28 May 2010 06:13:23 +0000
Subject: [lm-sensors] [RFC][PATCH]Add suspend and resume for LM75
Message-Id: <0680EC522D0CC943BC586913CF3768C003B3358228@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


There is a shutdown feature at suspend it can be enabled
to reduce current consumption and resume it can be switched
off.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |   35 +++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm75.h |    1 +
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5646342..4ef1f59 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -281,6 +281,39 @@ static int lm75_detect(struct i2c_client *new_client,
 
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
+#else
+#define lm75_suspend NULL
+#define lm75_resume NULL
+#endif /* CONFIG_PM */
+
 
 static struct i2c_driver lm75_driver = {
 	.class		= I2C_CLASS_HWMON,
@@ -292,6 +325,8 @@ static struct i2c_driver lm75_driver = {
 	.id_table	= lm75_ids,
 	.detect		= lm75_detect,
 	.address_list	= normal_i2c,
+	.suspend		= lm75_suspend,
+	.resume		= lm75_resume,
 };
 
 /*-----------------------------------------------------------------------*/
diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
index 7c93454..8e14253 100644
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -30,6 +30,7 @@
 /* straight from the datasheet */
 #define LM75_TEMP_MIN (-55000)
 #define LM75_TEMP_MAX 125000
+#define LM75_SHUTDOWN 1
 
 /* TEMP: 0.001C/bit (-55C to +125C)
    REG: (0.5C/bit, two's complement) << 7 */
-- 
1.5.4.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
