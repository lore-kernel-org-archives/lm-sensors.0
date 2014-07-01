From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 01 Jul 2014 14:39:08 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (ad7418) Avoid forward declaration
Message-Id: <1404225548.17487.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move ad7418_driver to proper place to avoid forward declaration.
Also move ad7418_init_client() close to ad7418_probe().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ad7418.c | 72 ++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index 57d4a62..f7bf429 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -55,44 +55,6 @@ struct ad7418_data {
 	u16			in[4];
 };
 
-static int ad7418_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
-static int ad7418_remove(struct i2c_client *client);
-
-static const struct i2c_device_id ad7418_id[] = {
-	{ "ad7416", ad7416 },
-	{ "ad7417", ad7417 },
-	{ "ad7418", ad7418 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ad7418_id);
-
-static struct i2c_driver ad7418_driver = {
-	.driver = {
-		.name	= "ad7418",
-	},
-	.probe		= ad7418_probe,
-	.remove		= ad7418_remove,
-	.id_table	= ad7418_id,
-};
-
-static void ad7418_init_client(struct i2c_client *client)
-{
-	struct ad7418_data *data = i2c_get_clientdata(client);
-
-	int reg = i2c_smbus_read_byte_data(client, AD7418_REG_CONF);
-	if (reg < 0) {
-		dev_err(&client->dev, "cannot read configuration register\n");
-	} else {
-		dev_info(&client->dev, "configuring for mode 1\n");
-		i2c_smbus_write_byte_data(client, AD7418_REG_CONF, reg & 0xfe);
-
-		if (data->type = ad7417 || data->type = ad7418)
-			i2c_smbus_write_byte_data(client,
-						AD7418_REG_CONF2, 0x00);
-	}
-}
-
 static struct ad7418_data *ad7418_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -219,6 +181,23 @@ static struct attribute *ad7418_attributes[] = {
 	NULL
 };
 
+static void ad7418_init_client(struct i2c_client *client)
+{
+	struct ad7418_data *data = i2c_get_clientdata(client);
+
+	int reg = i2c_smbus_read_byte_data(client, AD7418_REG_CONF);
+	if (reg < 0) {
+		dev_err(&client->dev, "cannot read configuration register\n");
+	} else {
+		dev_info(&client->dev, "configuring for mode 1\n");
+		i2c_smbus_write_byte_data(client, AD7418_REG_CONF, reg & 0xfe);
+
+		if (data->type = ad7417 || data->type = ad7418)
+			i2c_smbus_write_byte_data(client,
+						AD7418_REG_CONF2, 0x00);
+	}
+}
+
 static int ad7418_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -288,6 +267,23 @@ static int ad7418_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id ad7418_id[] = {
+	{ "ad7416", ad7416 },
+	{ "ad7417", ad7417 },
+	{ "ad7418", ad7418 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad7418_id);
+
+static struct i2c_driver ad7418_driver = {
+	.driver = {
+		.name	= "ad7418",
+	},
+	.probe		= ad7418_probe,
+	.remove		= ad7418_remove,
+	.id_table	= ad7418_id,
+};
+
 module_i2c_driver(ad7418_driver);
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
