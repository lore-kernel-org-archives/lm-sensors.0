From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 26 Apr 2014 05:29:50 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (jc42) Rearrange code to avoid forward declarations
Message-Id: <1398490192-593-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c |  186 ++++++++++++++++++++++++--------------------------
 1 file changed, 89 insertions(+), 97 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 6013611..ba1a3f7 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -176,65 +176,6 @@ struct jc42_data {
 	u16		temp_max;
 };
 
-static int jc42_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int jc42_detect(struct i2c_client *client, struct i2c_board_info *info);
-static int jc42_remove(struct i2c_client *client);
-
-static struct jc42_data *jc42_update_device(struct device *dev);
-
-static const struct i2c_device_id jc42_id[] = {
-	{ "jc42", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, jc42_id);
-
-#ifdef CONFIG_PM
-
-static int jc42_suspend(struct device *dev)
-{
-	struct jc42_data *data = dev_get_drvdata(dev);
-
-	data->config |= JC42_CFG_SHUTDOWN;
-	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
-				     data->config);
-	return 0;
-}
-
-static int jc42_resume(struct device *dev)
-{
-	struct jc42_data *data = dev_get_drvdata(dev);
-
-	data->config &= ~JC42_CFG_SHUTDOWN;
-	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
-				     data->config);
-	return 0;
-}
-
-static const struct dev_pm_ops jc42_dev_pm_ops = {
-	.suspend = jc42_suspend,
-	.resume = jc42_resume,
-};
-
-#define JC42_DEV_PM_OPS (&jc42_dev_pm_ops)
-#else
-#define JC42_DEV_PM_OPS NULL
-#endif /* CONFIG_PM */
-
-/* This is the driver that will be inserted */
-static struct i2c_driver jc42_driver = {
-	.class		= I2C_CLASS_SPD,
-	.driver = {
-		.name	= "jc42",
-		.pm = JC42_DEV_PM_OPS,
-	},
-	.probe		= jc42_probe,
-	.remove		= jc42_remove,
-	.id_table	= jc42_id,
-	.detect		= jc42_detect,
-	.address_list	= normal_i2c,
-};
-
 #define JC42_TEMP_MIN_EXTENDED	(-40000)
 #define JC42_TEMP_MIN		0
 #define JC42_TEMP_MAX		125000
@@ -261,6 +202,53 @@ static int jc42_temp_from_reg(s16 reg)
 	return reg * 125 / 2;
 }
 
+static struct jc42_data *jc42_update_device(struct device *dev)
+{
+	struct jc42_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	struct jc42_data *ret = data;
+	int val;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_input = val;
+
+		val = i2c_smbus_read_word_swapped(client,
+						  JC42_REG_TEMP_CRITICAL);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_crit = val;
+
+		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_LOWER);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_min = val;
+
+		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_UPPER);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_max = val;
+
+		data->last_updated = jiffies;
+		data->valid = true;
+	}
+abort:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
 /* sysfs stuff */
 
 /* read routines for temperature limits */
@@ -537,52 +525,56 @@ static int jc42_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct jc42_data *jc42_update_device(struct device *dev)
+#ifdef CONFIG_PM
+
+static int jc42_suspend(struct device *dev)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	struct jc42_data *ret = data;
-	int val;
 
-	mutex_lock(&data->update_lock);
+	data->config |= JC42_CFG_SHUTDOWN;
+	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
+				     data->config);
+	return 0;
+}
 
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_input = val;
+static int jc42_resume(struct device *dev)
+{
+	struct jc42_data *data = dev_get_drvdata(dev);
 
-		val = i2c_smbus_read_word_swapped(client,
-						  JC42_REG_TEMP_CRITICAL);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_crit = val;
+	data->config &= ~JC42_CFG_SHUTDOWN;
+	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
+				     data->config);
+	return 0;
+}
 
-		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_LOWER);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_min = val;
+static const struct dev_pm_ops jc42_dev_pm_ops = {
+	.suspend = jc42_suspend,
+	.resume = jc42_resume,
+};
 
-		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_UPPER);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_max = val;
+#define JC42_DEV_PM_OPS (&jc42_dev_pm_ops)
+#else
+#define JC42_DEV_PM_OPS NULL
+#endif /* CONFIG_PM */
 
-		data->last_updated = jiffies;
-		data->valid = true;
-	}
-abort:
-	mutex_unlock(&data->update_lock);
-	return ret;
-}
+static const struct i2c_device_id jc42_id[] = {
+	{ "jc42", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, jc42_id);
+
+static struct i2c_driver jc42_driver = {
+	.class		= I2C_CLASS_SPD,
+	.driver = {
+		.name	= "jc42",
+		.pm = JC42_DEV_PM_OPS,
+	},
+	.probe		= jc42_probe,
+	.remove		= jc42_remove,
+	.id_table	= jc42_id,
+	.detect		= jc42_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(jc42_driver);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
