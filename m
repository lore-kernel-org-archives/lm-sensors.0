From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Nov 2011 19:30:51 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (pmbus/adm1275) Validate device ID
Message-Id: <1322076654-5652-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since manufacturer and device ID are known, read and validate it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/adm1275.c |   53 +++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 980a4d9..6349404 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -170,22 +170,61 @@ static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
+static const struct i2c_device_id adm1275_id[] = {
+	{ "adm1275", adm1275 },
+	{ "adm1276", adm1276 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1275_id);
+
 static int adm1275_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
 	int config, device_config;
 	int ret;
 	struct pmbus_driver_info *info;
 	struct adm1275_data *data;
+	const struct i2c_device_id *mid;
 
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				     | I2C_FUNC_SMBUS_BLOCK_DATA))
 		return -ENODEV;
 
 	data = kzalloc(sizeof(struct adm1275_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
+		return ret;
+	}
+	if (ret != 3 || strncmp(block_buffer, "ADI", 3)) {
+		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
+		return ret;
+	}
+	for (mid = adm1275_id; mid->name[0]; mid++) {
+		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
+			break;
+	}
+	if (!mid->name[0]) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+
+	if (id->driver_data != mid->driver_data)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   id->name, mid->name);
+
 	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
 	if (config < 0) {
 		ret = config;
@@ -198,7 +237,8 @@ static int adm1275_probe(struct i2c_client *client,
 		goto err_mem;
 	}
 
-	data->id = id->driver_data;
+	data->id = mid->driver_data;
+
 	info = &data->info;
 
 	info->pages = 1;
@@ -233,7 +273,7 @@ static int adm1275_probe(struct i2c_client *client,
 	if (device_config & ADM1275_IOUT_WARN2_SELECT)
 		data->have_oc_fault = true;
 
-	switch (id->driver_data) {
+	switch (data->id) {
 	case adm1275:
 		if (config & ADM1275_VIN_VOUT_SELECT)
 			info->func[0] |@@ -281,13 +321,6 @@ static int adm1275_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id adm1275_id[] = {
-	{ "adm1275", adm1275 },
-	{ "adm1276", adm1276 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1275_id);
-
 static struct i2c_driver adm1275_driver = {
 	.driver = {
 		   .name = "adm1275",
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
