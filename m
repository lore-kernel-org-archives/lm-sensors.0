From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 Apr 2014 22:27:44 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm83) Rearange code to avoid forward declarations
Message-Id: <1397946465-4396-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Avoid forward declarations by rearranging code.
No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm83.c |  111 +++++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 61 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 90cba32..f9fcc91 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -107,40 +107,6 @@ static const u8 LM83_REG_W_HIGH[] = {
 };
 
 /*
- * Functions declaration
- */
-
-static int lm83_detect(struct i2c_client *new_client,
-		       struct i2c_board_info *info);
-static int lm83_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int lm83_remove(struct i2c_client *client);
-static struct lm83_data *lm83_update_device(struct device *dev);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id lm83_id[] = {
-	{ "lm83", lm83 },
-	{ "lm82", lm82 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm83_id);
-
-static struct i2c_driver lm83_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm83",
-	},
-	.probe		= lm83_probe,
-	.remove		= lm83_remove,
-	.id_table	= lm83_id,
-	.detect		= lm83_detect,
-	.address_list	= normal_i2c,
-};
-
-/*
  * Client data (each client gets its own)
  */
 
@@ -157,6 +123,36 @@ struct lm83_data {
 	u16 alarms; /* bitvector, combined */
 };
 
+static struct lm83_data *lm83_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm83_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
+		int nr;
+
+		dev_dbg(&client->dev, "Updating lm83 data.\n");
+		for (nr = 0; nr < 9; nr++) {
+			data->temp[nr] +			    i2c_smbus_read_byte_data(client,
+			    LM83_REG_R_TEMP[nr]);
+		}
+		data->alarms +		    i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS1)
+		    + (i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS2)
+		    << 8);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
 /*
  * Sysfs stuff
  */
@@ -390,35 +386,28 @@ static int lm83_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct lm83_data *lm83_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm83_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
-		int nr;
-
-		dev_dbg(&client->dev, "Updating lm83 data.\n");
-		for (nr = 0; nr < 9; nr++) {
-			data->temp[nr] -			    i2c_smbus_read_byte_data(client,
-			    LM83_REG_R_TEMP[nr]);
-		}
-		data->alarms -		    i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS1)
-		    + (i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS2)
-		    << 8);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
+/*
+ * Driver data (common to all clients)
+ */
 
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id lm83_id[] = {
+	{ "lm83", lm83 },
+	{ "lm82", lm82 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm83_id);
 
-	return data;
-}
+static struct i2c_driver lm83_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm83",
+	},
+	.probe		= lm83_probe,
+	.remove		= lm83_remove,
+	.id_table	= lm83_id,
+	.detect		= lm83_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(lm83_driver);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
