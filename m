From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 06 Jun 2014 09:50:56 +0000
Subject: [lm-sensors] [PATCH 1/2 v2] hwmon: (atxp1) Avoid forward declaration
Message-Id: <1402048256.690.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move atxp1_id and atxp1_driver to proper place to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/atxp1.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 6edce42..2ae8a30 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -45,30 +45,6 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 
 static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
 
-static int atxp1_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id);
-static int atxp1_remove(struct i2c_client *client);
-static struct atxp1_data *atxp1_update_device(struct device *dev);
-static int atxp1_detect(struct i2c_client *client, struct i2c_board_info *info);
-
-static const struct i2c_device_id atxp1_id[] = {
-	{ "atxp1", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, atxp1_id);
-
-static struct i2c_driver atxp1_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "atxp1",
-	},
-	.probe		= atxp1_probe,
-	.remove		= atxp1_remove,
-	.id_table	= atxp1_id,
-	.detect		= atxp1_detect,
-	.address_list	= normal_i2c,
-};
-
 struct atxp1_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
@@ -386,4 +362,22 @@ static int atxp1_remove(struct i2c_client *client)
 	return 0;
 };
 
+static const struct i2c_device_id atxp1_id[] = {
+	{ "atxp1", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, atxp1_id);
+
+static struct i2c_driver atxp1_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "atxp1",
+	},
+	.probe		= atxp1_probe,
+	.remove		= atxp1_remove,
+	.id_table	= atxp1_id,
+	.detect		= atxp1_detect,
+	.address_list	= normal_i2c,
+};
+
 module_i2c_driver(atxp1_driver);
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
