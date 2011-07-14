From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:37 +0000
Subject: [lm-sensors] [PATCH 08/15] hwmon: (pmbus) Strengthen check for
Message-Id: <1310608484-20678-9-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310485300-2168-9-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310485300-2168-9-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With virtual register page support, it is now possible that the status register
on virtual pages does not exist or is itself virtual. To take this into account
when creating alarm attributes, generate those attributes only if the status
register on the respective page is known to exist.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |   44 +++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 3daae16..019085f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -254,6 +254,24 @@ int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg)
 }
 EXPORT_SYMBOL_GPL(pmbus_read_byte_data);
 
+/*
+ * _pmbus_read_byte_data() is similar to pmbus_read_byte_data(), but checks if
+ * a device specific mapping funcion exists and calls it if necessary.
+ */
+static int _pmbus_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+	int status;
+
+	if (info->read_byte_data) {
+		status = info->read_byte_data(client, page, reg);
+		if (status != -ENODATA)
+			return status;
+	}
+	return pmbus_read_byte_data(client, page, reg);
+}
+
 static void pmbus_clear_fault_page(struct i2c_client *client, int page)
 {
 	pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
@@ -287,7 +305,7 @@ bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg)
 	int rv;
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
-	rv = pmbus_read_byte_data(client, page, reg);
+	rv = _pmbus_read_byte_data(client, page, reg);
 	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
 		rv = pmbus_check_status_cml(client);
 	pmbus_clear_fault_page(client, -1);
@@ -316,24 +334,6 @@ const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(pmbus_get_driver_info);
 
-/*
- * _pmbus_read_byte_data() is similar to pmbus_read_byte_data(), but checks if
- * a device specific mapping funcion exists and calls it if necessary.
- */
-static int _pmbus_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	const struct pmbus_driver_info *info = data->info;
-	int status;
-
-	if (info->read_byte_data) {
-		status = info->read_byte_data(client, page, reg);
-		if (status != -ENODATA)
-			return status;
-	}
-	return pmbus_read_byte_data(client, page, reg);
-}
-
 static struct pmbus_data *pmbus_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1037,9 +1037,11 @@ static void pmbus_add_sensor_attrs_one(struct i2c_client *client,
 						   index, page, cbase, attr);
 		/*
 		 * Add generic alarm attribute only if there are no individual
-		 * alarm attributes, and if there is a global alarm bit.
+		 * alarm attributes, if there is a global alarm bit, and if
+		 * the generic status register for this page is accessible.
 		 */
-		if (!have_alarm && attr->gbit)
+		if (!have_alarm && attr->gbit &&
+		    pmbus_check_byte_register(client, page, PMBUS_STATUS_BYTE))
 			pmbus_add_boolean_reg(data, name, "alarm", index,
 					      PB_STATUS_BASE + page,
 					      attr->gbit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
