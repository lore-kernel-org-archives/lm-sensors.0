From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:48:15 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm1025) Avoid forward declaration
Message-Id: <1404395295.4895.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1025.c | 224 ++++++++++++++++++++++--------------------------
 1 file changed, 104 insertions(+), 120 deletions(-)

diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 9ffc4c8..0533c2c 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -103,41 +103,6 @@ static const int in_scale[6] = { 2500, 2250, 3300, 5000, 12000, 3300 };
 				   (val) + 500) / 1000))
 
 /*
- * Functions declaration
- */
-
-static int adm1025_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adm1025_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static void adm1025_init_client(struct i2c_client *client);
-static int adm1025_remove(struct i2c_client *client);
-static struct adm1025_data *adm1025_update_device(struct device *dev);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id adm1025_id[] = {
-	{ "adm1025", adm1025 },
-	{ "ne1619", ne1619 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1025_id);
-
-static struct i2c_driver adm1025_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "adm1025",
-	},
-	.probe		= adm1025_probe,
-	.remove		= adm1025_remove,
-	.id_table	= adm1025_id,
-	.detect		= adm1025_detect,
-	.address_list	= normal_i2c,
-};
-
-/*
  * Client data (each client gets its own)
  */
 
@@ -158,6 +123,51 @@ struct adm1025_data {
 	u8 vrm;
 };
 
+static struct adm1025_data *adm1025_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1025_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
+		int i;
+
+		dev_dbg(&client->dev, "Updating data.\n");
+		for (i = 0; i < 6; i++) {
+			data->in[i] = i2c_smbus_read_byte_data(client,
+				      ADM1025_REG_IN(i));
+			data->in_min[i] = i2c_smbus_read_byte_data(client,
+					  ADM1025_REG_IN_MIN(i));
+			data->in_max[i] = i2c_smbus_read_byte_data(client,
+					  ADM1025_REG_IN_MAX(i));
+		}
+		for (i = 0; i < 2; i++) {
+			data->temp[i] = i2c_smbus_read_byte_data(client,
+					ADM1025_REG_TEMP(i));
+			data->temp_min[i] = i2c_smbus_read_byte_data(client,
+					    ADM1025_REG_TEMP_LOW(i));
+			data->temp_max[i] = i2c_smbus_read_byte_data(client,
+					    ADM1025_REG_TEMP_HIGH(i));
+		}
+		data->alarms = i2c_smbus_read_byte_data(client,
+			       ADM1025_REG_STATUS1)
+			     | (i2c_smbus_read_byte_data(client,
+				ADM1025_REG_STATUS2) << 8);
+		data->vid = (i2c_smbus_read_byte_data(client,
+			     ADM1025_REG_VID) & 0x0f)
+			  | ((i2c_smbus_read_byte_data(client,
+			      ADM1025_REG_VID4) & 0x01) << 4);
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
@@ -470,6 +480,48 @@ static int adm1025_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void adm1025_init_client(struct i2c_client *client)
+{
+	u8 reg;
+	struct adm1025_data *data = i2c_get_clientdata(client);
+	int i;
+
+	data->vrm = vid_which_vrm();
+
+	/*
+	 * Set high limits
+	 * Usually we avoid setting limits on driver init, but it happens
+	 * that the ADM1025 comes with stupid default limits (all registers
+	 * set to 0). In case the chip has not gone through any limit
+	 * setting yet, we better set the high limits to the max so that
+	 * no alarm triggers.
+	 */
+	for (i = 0; i < 6; i++) {
+		reg = i2c_smbus_read_byte_data(client,
+					       ADM1025_REG_IN_MAX(i));
+		if (reg = 0)
+			i2c_smbus_write_byte_data(client,
+						  ADM1025_REG_IN_MAX(i),
+						  0xFF);
+	}
+	for (i = 0; i < 2; i++) {
+		reg = i2c_smbus_read_byte_data(client,
+					       ADM1025_REG_TEMP_HIGH(i));
+		if (reg = 0)
+			i2c_smbus_write_byte_data(client,
+						  ADM1025_REG_TEMP_HIGH(i),
+						  0x7F);
+	}
+
+	/*
+	 * Start the conversions
+	 */
+	reg = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
+	if (!(reg & 0x01))
+		i2c_smbus_write_byte_data(client, ADM1025_REG_CONFIG,
+					  (reg&0x7E)|0x01);
+}
+
 static int adm1025_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -515,48 +567,6 @@ exit_remove:
 	return err;
 }
 
-static void adm1025_init_client(struct i2c_client *client)
-{
-	u8 reg;
-	struct adm1025_data *data = i2c_get_clientdata(client);
-	int i;
-
-	data->vrm = vid_which_vrm();
-
-	/*
-	 * Set high limits
-	 * Usually we avoid setting limits on driver init, but it happens
-	 * that the ADM1025 comes with stupid default limits (all registers
-	 * set to 0). In case the chip has not gone through any limit
-	 * setting yet, we better set the high limits to the max so that
-	 * no alarm triggers.
-	 */
-	for (i = 0; i < 6; i++) {
-		reg = i2c_smbus_read_byte_data(client,
-					       ADM1025_REG_IN_MAX(i));
-		if (reg = 0)
-			i2c_smbus_write_byte_data(client,
-						  ADM1025_REG_IN_MAX(i),
-						  0xFF);
-	}
-	for (i = 0; i < 2; i++) {
-		reg = i2c_smbus_read_byte_data(client,
-					       ADM1025_REG_TEMP_HIGH(i));
-		if (reg = 0)
-			i2c_smbus_write_byte_data(client,
-						  ADM1025_REG_TEMP_HIGH(i),
-						  0x7F);
-	}
-
-	/*
-	 * Start the conversions
-	 */
-	reg = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
-	if (!(reg & 0x01))
-		i2c_smbus_write_byte_data(client, ADM1025_REG_CONFIG,
-					  (reg&0x7E)|0x01);
-}
-
 static int adm1025_remove(struct i2c_client *client)
 {
 	struct adm1025_data *data = i2c_get_clientdata(client);
@@ -568,50 +578,24 @@ static int adm1025_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct adm1025_data *adm1025_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
-		int i;
-
-		dev_dbg(&client->dev, "Updating data.\n");
-		for (i = 0; i < 6; i++) {
-			data->in[i] = i2c_smbus_read_byte_data(client,
-				      ADM1025_REG_IN(i));
-			data->in_min[i] = i2c_smbus_read_byte_data(client,
-					  ADM1025_REG_IN_MIN(i));
-			data->in_max[i] = i2c_smbus_read_byte_data(client,
-					  ADM1025_REG_IN_MAX(i));
-		}
-		for (i = 0; i < 2; i++) {
-			data->temp[i] = i2c_smbus_read_byte_data(client,
-					ADM1025_REG_TEMP(i));
-			data->temp_min[i] = i2c_smbus_read_byte_data(client,
-					    ADM1025_REG_TEMP_LOW(i));
-			data->temp_max[i] = i2c_smbus_read_byte_data(client,
-					    ADM1025_REG_TEMP_HIGH(i));
-		}
-		data->alarms = i2c_smbus_read_byte_data(client,
-			       ADM1025_REG_STATUS1)
-			     | (i2c_smbus_read_byte_data(client,
-				ADM1025_REG_STATUS2) << 8);
-		data->vid = (i2c_smbus_read_byte_data(client,
-			     ADM1025_REG_VID) & 0x0f)
-			  | ((i2c_smbus_read_byte_data(client,
-			      ADM1025_REG_VID4) & 0x01) << 4);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id adm1025_id[] = {
+	{ "adm1025", adm1025 },
+	{ "ne1619", ne1619 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1025_id);
 
-	return data;
-}
+static struct i2c_driver adm1025_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "adm1025",
+	},
+	.probe		= adm1025_probe,
+	.remove		= adm1025_remove,
+	.id_table	= adm1025_id,
+	.detect		= adm1025_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(adm1025_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
