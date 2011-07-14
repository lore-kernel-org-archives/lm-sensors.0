From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:36 +0000
Subject: [lm-sensors] [PATCH v2 07/15] hwmon: (pmbus) Add support for
Message-Id: <1310608484-20678-8-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some PMBus chips have non-standard sensor registers. An easy way to
support such sensors is to introduce virtual pages and map the non-standard
registers into standard registers on an extra page.

For this to work, the code verifying if the configured number of pages exists
has to be removed. Since a wrong number of pages can only be configured in a
front-end driver, this should not have a practical impact since the resulting
errors should be found during development and testing.

Also, functions to read the chip status while checking if a command register
exists must be modified to no longer set the page register before reading the
status, since the physical page associated with the checked register may not
exist. This does not make a functional difference since the page was already set
when the attempt to read the register was made.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Improved status register handling

 drivers/hwmon/pmbus/pmbus.h      |    2 +-
 drivers/hwmon/pmbus/pmbus_core.c |   46 +++++++++++++++----------------------
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d631cae..ceb71f7 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -303,7 +303,7 @@ struct pmbus_driver_info {
 int pmbus_set_page(struct i2c_client *client, u8 page);
 int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
 int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word);
-int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg);
+int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
 void pmbus_clear_faults(struct i2c_client *client);
 bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index abdc3a3..3daae16 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -164,13 +164,15 @@ int pmbus_set_page(struct i2c_client *client, u8 page)
 }
 EXPORT_SYMBOL_GPL(pmbus_set_page);
 
-static int pmbus_write_byte(struct i2c_client *client, u8 page, u8 value)
+static int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
 {
 	int rv;
 
-	rv = pmbus_set_page(client, page);
-	if (rv < 0)
-		return rv;
+	if (page >= 0) {
+		rv = pmbus_set_page(client, page);
+		if (rv < 0)
+			return rv;
+	}
 
 	return i2c_smbus_write_byte(client, value);
 }
@@ -238,13 +240,15 @@ static int _pmbus_read_word_data(struct i2c_client *client, int page, int reg)
 	return pmbus_read_word_data(client, page, reg);
 }
 
-int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
+int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg)
 {
 	int rv;
 
-	rv = pmbus_set_page(client, page);
-	if (rv < 0)
-		return rv;
+	if (page >= 0) {
+		rv = pmbus_set_page(client, page);
+		if (rv < 0)
+			return rv;
+	}
 
 	return i2c_smbus_read_byte_data(client, reg);
 }
@@ -265,13 +269,13 @@ void pmbus_clear_faults(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(pmbus_clear_faults);
 
-static int pmbus_check_status_cml(struct i2c_client *client, int page)
+static int pmbus_check_status_cml(struct i2c_client *client)
 {
 	int status, status2;
 
-	status = pmbus_read_byte_data(client, page, PMBUS_STATUS_BYTE);
+	status = pmbus_read_byte_data(client, -1, PMBUS_STATUS_BYTE);
 	if (status < 0 || (status & PB_STATUS_CML)) {
-		status2 = pmbus_read_byte_data(client, page, PMBUS_STATUS_CML);
+		status2 = pmbus_read_byte_data(client, -1, PMBUS_STATUS_CML);
 		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
 			return -EINVAL;
 	}
@@ -285,8 +289,8 @@ bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg)
 
 	rv = pmbus_read_byte_data(client, page, reg);
 	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
-		rv = pmbus_check_status_cml(client, page);
-	pmbus_clear_fault_page(client, page);
+		rv = pmbus_check_status_cml(client);
+	pmbus_clear_fault_page(client, -1);
 	return rv >= 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_check_byte_register);
@@ -298,8 +302,8 @@ bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
 
 	rv = pmbus_read_word_data(client, page, reg);
 	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
-		rv = pmbus_check_status_cml(client, page);
-	pmbus_clear_fault_page(client, page);
+		rv = pmbus_check_status_cml(client);
+	pmbus_clear_fault_page(client, -1);
 	return rv >= 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_check_word_register);
@@ -1541,18 +1545,6 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		ret = -EINVAL;
 		goto out_data;
 	}
-	/*
-	 * Bail out if more than one page was configured, but we can not
-	 * select the highest page. This is an indication that the wrong
-	 * chip type was selected. Better bail out now than keep
-	 * returning errors later on.
-	 */
-	if (info->pages > 1 && pmbus_set_page(client, info->pages - 1) < 0) {
-		dev_err(&client->dev, "Failed to select page %d\n",
-			info->pages - 1);
-		ret = -EINVAL;
-		goto out_data;
-	}
 
 	ret = pmbus_identify_common(client, data);
 	if (ret < 0) {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
