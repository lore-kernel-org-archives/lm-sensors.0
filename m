From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 May 2012 18:48:19 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pmbus) Add support for non-standard status register
Message-Id: <1337453300-27643-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not all PMBus devices support the byte status register at 0x78.
Add support for non-standard status registers to work around this problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.h      |    1 +
 drivers/hwmon/pmbus/pmbus_core.c |   13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 3fe03dc..8073dc4 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -332,6 +332,7 @@ struct pmbus_driver_info {
 	int R[PSC_NUM_CLASSES];	/* exponent */
 
 	u32 func[PMBUS_PAGES];	/* Functionality, per page */
+	u8 status_register;	/* Set if not PMBUS_STATUS_BYTE */
 	/*
 	 * The following functions map manufacturing specific register values
 	 * to PMBus standard register values. Specify only if mapping is
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 29b319d..0d8d50c 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -150,6 +150,7 @@ struct pmbus_data {
 	 * so we keep them all together.
 	 */
 	u8 status[PB_NUM_STATUS_REG];
+	u8 status_register;
 
 	u8 currpage;
 };
@@ -318,9 +319,10 @@ EXPORT_SYMBOL_GPL(pmbus_clear_faults);
 
 static int pmbus_check_status_cml(struct i2c_client *client)
 {
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	int status, status2;
 
-	status = _pmbus_read_byte_data(client, -1, PMBUS_STATUS_BYTE);
+	status = _pmbus_read_byte_data(client, -1, data->status_register);
 	if (status < 0 || (status & PB_STATUS_CML)) {
 		status2 = _pmbus_read_byte_data(client, -1, PMBUS_STATUS_CML);
 		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
@@ -376,7 +378,7 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 		for (i = 0; i < info->pages; i++)
 			data->status[PB_STATUS_BASE + i]
 			    = _pmbus_read_byte_data(client, i,
-						    PMBUS_STATUS_BYTE);
+						    data->status_register);
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
 				continue;
@@ -1069,7 +1071,8 @@ static void pmbus_add_sensor_attrs_one(struct i2c_client *client,
 		 * the generic status register for this page is accessible.
 		 */
 		if (!have_alarm && attr->gbit &&
-		    pmbus_check_byte_register(client, page, PMBUS_STATUS_BYTE))
+		    pmbus_check_byte_register(client, page,
+					      data->status_register))
 			pmbus_add_boolean_reg(data, name, "alarm", index,
 					      PB_STATUS_BASE + page,
 					      attr->gbit);
@@ -1704,8 +1707,10 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
+	data->status_register = info->status_register ? : PMBUS_STATUS_BYTE;
+
 	/* Bail out if PMBus status register does not exist. */
-	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
+	if (i2c_smbus_read_byte_data(client, data->status_register) < 0) {
 		dev_err(&client->dev, "PMBus status register not found\n");
 		return -ENODEV;
 	}
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
