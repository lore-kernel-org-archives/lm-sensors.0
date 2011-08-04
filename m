From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 04 Aug 2011 18:11:12 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pmbus) Virtualize pmbus_write_byte
Message-Id: <1312481473-28601-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With virtual pages and to be able to handle more chips, it is necessary to
virtualise pmbus_write_byte().

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus.h      |    1 +
 drivers/hwmon/pmbus/pmbus_core.c |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 0808d98..a6ae20f 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -325,6 +325,7 @@ struct pmbus_driver_info {
 	int (*read_word_data)(struct i2c_client *client, int page, int reg);
 	int (*write_word_data)(struct i2c_client *client, int page, int reg,
 			       u16 word);
+	int (*write_byte)(struct i2c_client *client, int page, u8 value);
 	/*
 	 * The identify function determines supported PMBus functionality.
 	 * This function is only necessary if a chip driver supports multiple
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 5c1b6cf..a561c3a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -182,6 +182,24 @@ int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
 }
 EXPORT_SYMBOL_GPL(pmbus_write_byte);
 
+/*
+ * _pmbus_write_byte() is similar to pmbus_write_byte(), but checks if
+ * a device specific mapping funcion exists and calls it if necessary.
+ */
+static int _pmbus_write_byte(struct i2c_client *client, int page, u8 value)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+	int status;
+
+	if (info->write_byte) {
+		status = info->write_byte(client, page, value);
+		if (status != -ENODATA)
+			return status;
+	}
+	return pmbus_write_byte(client, page, value);
+}
+
 int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word)
 {
 	int rv;
@@ -281,7 +299,7 @@ static int _pmbus_read_byte_data(struct i2c_client *client, int page, int reg)
 
 static void pmbus_clear_fault_page(struct i2c_client *client, int page)
 {
-	pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+	_pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
 }
 
 void pmbus_clear_faults(struct i2c_client *client)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
