From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:45 +0000
Subject: [lm-sensors] [PATCH 11/13] hwmon: (pmbus) Add support for word status register
Message-Id: <1359253067-11644-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not all PMBus devices support the byte status register at 0x78.
Try to use the word status register at 0x79 instead if that is the case.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   80 +++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 32f4530..cb5e255 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -109,6 +109,7 @@ struct pmbus_data {
 	 * so we keep them all together.
 	 */
 	u8 status[PB_NUM_STATUS_REG];
+	u8 status_register;
 
 	u8 currpage;
 };
@@ -285,9 +286,10 @@ EXPORT_SYMBOL_GPL(pmbus_clear_faults);
 
 static int pmbus_check_status_cml(struct i2c_client *client)
 {
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	int status, status2;
 
-	status = _pmbus_read_byte_data(client, -1, PMBUS_STATUS_BYTE);
+	status = _pmbus_read_byte_data(client, -1, data->status_register);
 	if (status < 0 || (status & PB_STATUS_CML)) {
 		status2 = _pmbus_read_byte_data(client, -1, PMBUS_STATUS_CML);
 		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
@@ -344,7 +346,7 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 		for (i = 0; i < info->pages; i++)
 			data->status[PB_STATUS_BASE + i]
 			    = _pmbus_read_byte_data(client, i,
-						    PMBUS_STATUS_BYTE);
+						    data->status_register);
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
 				continue;
@@ -1015,7 +1017,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 		 */
 		if (!ret && attr->gbit &&
 		    pmbus_check_byte_register(client, page,
-					      PMBUS_STATUS_BYTE)) {
+					      data->status_register)) {
 			ret = pmbus_add_boolean(data, name, "alarm", index,
 						NULL, NULL,
 						PB_STATUS_BASE + page,
@@ -1683,6 +1685,51 @@ static int pmbus_identify_common(struct i2c_client *client,
 	return 0;
 }
 
+static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
+			     struct pmbus_driver_info *info)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	/*
+	 * Some PMBus chips don't support PMBUS_STATUS_BYTE, so try
+	 * to use PMBUS_STATUS_WORD instead if that is the case.
+	 * Bail out if both registers are not supported.
+	 */
+	data->status_register = PMBUS_STATUS_BYTE;
+	ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
+	if (ret < 0 || ret = 0xff) {
+		data->status_register = PMBUS_STATUS_WORD;
+		ret = i2c_smbus_read_word_data(client, PMBUS_STATUS_WORD);
+		if (ret < 0 || ret = 0xffff) {
+			dev_err(dev, "PMBus status register not found\n");
+			return -ENODEV;
+		}
+	}
+
+	pmbus_clear_faults(client);
+
+	if (info->identify) {
+		ret = (*info->identify)(client, info);
+		if (ret < 0) {
+			dev_err(dev, "Chip identification failed\n");
+			return ret;
+		}
+	}
+
+	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
+		dev_err(dev, "Bad number of PMBus pages: %d\n", info->pages);
+		return -ENODEV;
+	}
+
+	ret = pmbus_identify_common(client, data);
+	if (ret < 0) {
+		dev_err(dev, "Failed to identify chip capabilities\n");
+		return ret;
+	}
+	return 0;
+}
+
 int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		   struct pmbus_driver_info *info)
 {
@@ -1707,36 +1754,13 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	mutex_init(&data->update_lock);
 	data->dev = dev;
 
-	/* Bail out if PMBus status register does not exist. */
-	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
-		dev_err(dev, "PMBus status register not found\n");
-		return -ENODEV;
-	}
-
 	if (pdata)
 		data->flags = pdata->flags;
 	data->info = info;
 
-	pmbus_clear_faults(client);
-
-	if (info->identify) {
-		ret = (*info->identify)(client, info);
-		if (ret < 0) {
-			dev_err(dev, "Chip identification failed\n");
-			return ret;
-		}
-	}
-
-	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
-		dev_err(dev, "Bad number of PMBus pages: %d\n", info->pages);
-		return -ENODEV;
-	}
-
-	ret = pmbus_identify_common(client, data);
-	if (ret < 0) {
-		dev_err(dev, "Failed to identify chip capabilities\n");
+	ret = pmbus_init_common(client, data, info);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = pmbus_find_attributes(client, data);
 	if (ret)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
