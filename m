From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 16 Jul 2014 15:12:05 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adt7470) Avoid forward declaration
Message-Id: <1405523525.6874.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adt7470.c | 66 ++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 0f4dea5..9965fdb 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -175,30 +175,6 @@ struct adt7470_data {
 	unsigned int		auto_update_interval;
 };
 
-static int adt7470_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adt7470_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static int adt7470_remove(struct i2c_client *client);
-
-static const struct i2c_device_id adt7470_id[] = {
-	{ "adt7470", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adt7470_id);
-
-static struct i2c_driver adt7470_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "adt7470",
-	},
-	.probe		= adt7470_probe,
-	.remove		= adt7470_remove,
-	.id_table	= adt7470_id,
-	.detect		= adt7470_detect,
-	.address_list	= normal_i2c,
-};
-
 /*
  * 16-bit registers on the ADT7470 are low-byte first.  The data sheet says
  * that the low byte must be read before the high byte.
@@ -218,18 +194,6 @@ static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
 	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
 }
 
-static void adt7470_init_client(struct i2c_client *client)
-{
-	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-
-	if (reg < 0) {
-		dev_err(&client->dev, "cannot read configuration register\n");
-	} else {
-		/* start monitoring (and do a self-test) */
-		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
-	}
-}
-
 /* Probe for temperature sensors.  Assumes lock is held */
 static int adt7470_read_temperatures(struct i2c_client *client,
 				     struct adt7470_data *data)
@@ -1250,6 +1214,18 @@ static int adt7470_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void adt7470_init_client(struct i2c_client *client)
+{
+	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+
+	if (reg < 0) {
+		dev_err(&client->dev, "cannot read configuration register\n");
+	} else {
+		/* start monitoring (and do a self-test) */
+		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
+	}
+}
+
 static int adt7470_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1312,6 +1288,24 @@ static int adt7470_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id adt7470_id[] = {
+	{ "adt7470", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adt7470_id);
+
+static struct i2c_driver adt7470_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "adt7470",
+	},
+	.probe		= adt7470_probe,
+	.remove		= adt7470_remove,
+	.id_table	= adt7470_id,
+	.detect		= adt7470_detect,
+	.address_list	= normal_i2c,
+};
+
 module_i2c_driver(adt7470_driver);
 
 MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
