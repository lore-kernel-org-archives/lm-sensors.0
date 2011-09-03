From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Sep 2011 02:27:48 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (pmbus) Replace EINVAL return codes
Message-Id: <1315016870-10579-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

EINVAL was over-used in the code. Replace it with more appropriate errors.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/lm25066.c    |    8 ++++----
 drivers/hwmon/pmbus/max8688.c    |    4 ++--
 drivers/hwmon/pmbus/pmbus_core.c |   10 +++++-----
 drivers/hwmon/pmbus/ucd9000.c    |    4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 2107f41..a72bb9f 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -57,7 +57,7 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 	int ret;
 
 	if (page > 1)
-		return -EINVAL;
+		return -ENXIO;
 
 	/* Map READ_VAUX into READ_VOUT register on page 1 */
 	if (page = 1) {
@@ -85,7 +85,7 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 			break;
 		default:
 			/* No other valid registers on page 1 */
-			ret = -EINVAL;
+			ret = -ENXIO;
 			break;
 		}
 		goto done;
@@ -138,7 +138,7 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	int ret;
 
 	if (page > 1)
-		return -EINVAL;
+		return -ENXIO;
 
 	switch (reg) {
 	case PMBUS_IIN_OC_WARN_LIMIT:
@@ -164,7 +164,7 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 static int lm25066_write_byte(struct i2c_client *client, int page, u8 value)
 {
 	if (page > 1)
-		return -EINVAL;
+		return -ENXIO;
 
 	if (page = 0)
 		return pmbus_write_byte(client, 0, value);
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index e148e2c..7113f11 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -45,7 +45,7 @@ static int max8688_read_word_data(struct i2c_client *client, int page, int reg)
 	int ret;
 
 	if (page)
-		return -EINVAL;
+		return -ENXIO;
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_VOUT_MAX:
@@ -102,7 +102,7 @@ static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
 	int mfg_status;
 
 	if (page)
-		return -EINVAL;
+		return -ENXIO;
 
 	switch (reg) {
 	case PMBUS_STATUS_VOUT:
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index b1320cf..cefbd85 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -160,7 +160,7 @@ int pmbus_set_page(struct i2c_client *client, u8 page)
 		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
 		newpage = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
 		if (newpage != page)
-			rv = -EINVAL;
+			rv = -EIO;
 		else
 			data->currpage = page;
 	}
@@ -229,7 +229,7 @@ static int _pmbus_write_word_data(struct i2c_client *client, int page, int reg,
 			return status;
 	}
 	if (reg >= PMBUS_VIRT_BASE)
-		return -EINVAL;
+		return -ENXIO;
 	return pmbus_write_word_data(client, page, reg, word);
 }
 
@@ -261,7 +261,7 @@ static int _pmbus_read_word_data(struct i2c_client *client, int page, int reg)
 			return status;
 	}
 	if (reg >= PMBUS_VIRT_BASE)
-		return -EINVAL;
+		return -ENXIO;
 	return pmbus_read_word_data(client, page, reg);
 }
 
@@ -320,7 +320,7 @@ static int pmbus_check_status_cml(struct i2c_client *client)
 	if (status < 0 || (status & PB_STATUS_CML)) {
 		status2 = pmbus_read_byte_data(client, -1, PMBUS_STATUS_CML);
 		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
-			return -EINVAL;
+			return -EIO;
 	}
 	return 0;
 }
@@ -1675,7 +1675,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
 		dev_err(&client->dev, "Bad number of PMBus pages: %d\n",
 			info->pages);
-		ret = -EINVAL;
+		ret = -ENODEV;
 		goto out_data;
 	}
 
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 640a9c9..1536db6 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -75,7 +75,7 @@ static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
 	switch (reg) {
 	case PMBUS_FAN_CONFIG_12:
 		if (page)
-			return -EINVAL;
+			return -ENXIO;
 
 		ret = ucd9000_get_fan_config(client, 0);
 		if (ret < 0)
@@ -89,7 +89,7 @@ static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
 		break;
 	case PMBUS_FAN_CONFIG_34:
 		if (page)
-			return -EINVAL;
+			return -ENXIO;
 
 		ret = ucd9000_get_fan_config(client, 2);
 		if (ret < 0)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
