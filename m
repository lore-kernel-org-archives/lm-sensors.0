From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 17 Jul 2014 11:20:53 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (smsc47m192) Avoid forward declaration
Message-Id: <1405596053.13586.11.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/smsc47m192.c | 161 ++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 84 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index efee4c5..7ab1659 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -112,30 +112,69 @@ struct smsc47m192_data {
 	u8 vrm;
 };
 
-static int smsc47m192_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id);
-static int smsc47m192_detect(struct i2c_client *client,
-			     struct i2c_board_info *info);
-static int smsc47m192_remove(struct i2c_client *client);
-static struct smsc47m192_data *smsc47m192_update_device(struct device *dev);
+static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	int i, config;
 
-static const struct i2c_device_id smsc47m192_id[] = {
-	{ "smsc47m192", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, smsc47m192_id);
+	mutex_lock(&data->update_lock);
 
-static struct i2c_driver smsc47m192_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "smsc47m192",
-	},
-	.probe		= smsc47m192_probe,
-	.remove		= smsc47m192_remove,
-	.id_table	= smsc47m192_id,
-	.detect		= smsc47m192_detect,
-	.address_list	= normal_i2c,
-};
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	 || !data->valid) {
+		u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
+
+		dev_dbg(&client->dev, "Starting smsc47m192 update\n");
+
+		for (i = 0; i <= 7; i++) {
+			data->in[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_IN(i));
+			data->in_min[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_IN_MIN(i));
+			data->in_max[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_IN_MAX(i));
+		}
+		for (i = 0; i < 3; i++) {
+			data->temp[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP[i]);
+			data->temp_max[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_MAX[i]);
+			data->temp_min[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_MIN[i]);
+		}
+		for (i = 1; i < 3; i++)
+			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_TEMP_OFFSET(i));
+		/*
+		 * first offset is temp_offset[0] if SFR bit 4 is set,
+		 * temp_offset[1] otherwise
+		 */
+		if (sfr & 0x10) {
+			data->temp_offset[0] = data->temp_offset[1];
+			data->temp_offset[1] = 0;
+		} else
+			data->temp_offset[0] = 0;
+
+		data->vid = i2c_smbus_read_byte_data(client, SMSC47M192_REG_VID)
+			    & 0x0f;
+		config = i2c_smbus_read_byte_data(client,
+						  SMSC47M192_REG_CONFIG);
+		if (config & 0x20)
+			data->vid |= (i2c_smbus_read_byte_data(client,
+					SMSC47M192_REG_VID4) & 0x01) << 4;
+		data->alarms = i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_ALARM1) |
+			       (i2c_smbus_read_byte_data(client,
+						SMSC47M192_REG_ALARM2) << 8);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 /* Voltages */
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
@@ -605,69 +644,23 @@ static int smsc47m192_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
-	int i, config;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	 || !data->valid) {
-		u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
-
-		dev_dbg(&client->dev, "Starting smsc47m192 update\n");
-
-		for (i = 0; i <= 7; i++) {
-			data->in[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_IN(i));
-			data->in_min[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_IN_MIN(i));
-			data->in_max[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_IN_MAX(i));
-		}
-		for (i = 0; i < 3; i++) {
-			data->temp[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_TEMP[i]);
-			data->temp_max[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_TEMP_MAX[i]);
-			data->temp_min[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_TEMP_MIN[i]);
-		}
-		for (i = 1; i < 3; i++)
-			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_TEMP_OFFSET(i));
-		/*
-		 * first offset is temp_offset[0] if SFR bit 4 is set,
-		 * temp_offset[1] otherwise
-		 */
-		if (sfr & 0x10) {
-			data->temp_offset[0] = data->temp_offset[1];
-			data->temp_offset[1] = 0;
-		} else
-			data->temp_offset[0] = 0;
-
-		data->vid = i2c_smbus_read_byte_data(client, SMSC47M192_REG_VID)
-			    & 0x0f;
-		config = i2c_smbus_read_byte_data(client,
-						  SMSC47M192_REG_CONFIG);
-		if (config & 0x20)
-			data->vid |= (i2c_smbus_read_byte_data(client,
-					SMSC47M192_REG_VID4) & 0x01) << 4;
-		data->alarms = i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_ALARM1) |
-			       (i2c_smbus_read_byte_data(client,
-						SMSC47M192_REG_ALARM2) << 8);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id smsc47m192_id[] = {
+	{ "smsc47m192", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, smsc47m192_id);
 
-	return data;
-}
+static struct i2c_driver smsc47m192_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "smsc47m192",
+	},
+	.probe		= smsc47m192_probe,
+	.remove		= smsc47m192_remove,
+	.id_table	= smsc47m192_id,
+	.detect		= smsc47m192_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(smsc47m192_driver);
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
