From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 16 Jul 2014 15:09:41 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adt7462) Avoid forward declaration
Message-Id: <1405523381.6874.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adt7462.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 562cc38..c4a1784 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -232,30 +232,6 @@ struct adt7462_data {
 	u8			alarms[ADT7462_ALARM_REG_COUNT];
 };
 
-static int adt7462_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adt7462_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static int adt7462_remove(struct i2c_client *client);
-
-static const struct i2c_device_id adt7462_id[] = {
-	{ "adt7462", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adt7462_id);
-
-static struct i2c_driver adt7462_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "adt7462",
-	},
-	.probe		= adt7462_probe,
-	.remove		= adt7462_remove,
-	.id_table	= adt7462_id,
-	.detect		= adt7462_detect,
-	.address_list	= normal_i2c,
-};
-
 /*
  * 16-bit registers on the ADT7462 are low-byte first.  The data sheet says
  * that the low byte must be read before the high byte.
@@ -1967,6 +1943,24 @@ static int adt7462_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id adt7462_id[] = {
+	{ "adt7462", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adt7462_id);
+
+static struct i2c_driver adt7462_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "adt7462",
+	},
+	.probe		= adt7462_probe,
+	.remove		= adt7462_remove,
+	.id_table	= adt7462_id,
+	.detect		= adt7462_detect,
+	.address_list	= normal_i2c,
+};
+
 module_i2c_driver(adt7462_driver);
 
 MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
