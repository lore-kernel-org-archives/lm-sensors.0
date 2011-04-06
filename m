From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 23:41:31 +0000
Subject: [lm-sensors] [PATCH 3/7] hwmon: (pmbus) Expand scope of device
Message-Id: <1302133295-17302-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some devices use non-standard registers to access various functionality.
This does not only affect status registers, but other registers as well.
Rename local get_status function to get_byte_data to reflect this requirement.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Tom Grennan <tom.grennan@ericsson.com>
---
 drivers/hwmon/max34440.c   |    6 +++---
 drivers/hwmon/max8688.c    |    4 ++--
 drivers/hwmon/pmbus.h      |   10 ++++------
 drivers/hwmon/pmbus_core.c |   29 ++++++++++++++++++-----------
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/max34440.c b/drivers/hwmon/max34440.c
index 992b701..db11e1a 100644
--- a/drivers/hwmon/max34440.c
+++ b/drivers/hwmon/max34440.c
@@ -32,7 +32,7 @@ enum chips { max34440, max34441 };
 #define MAX34440_STATUS_OT_FAULT	(1 << 5)
 #define MAX34440_STATUS_OT_WARN		(1 << 6)
 
-static int max34440_get_status(struct i2c_client *client, int page, int reg)
+static int max34440_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	int ret;
 	int mfg_status;
@@ -108,7 +108,7 @@ static struct pmbus_driver_info max34440_info[] = {
 		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.func[12] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.func[13] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.get_status = max34440_get_status,
+		.read_byte_data = max34440_read_byte_data,
 	},
 	[max34441] = {
 		.pages = 12,
@@ -149,7 +149,7 @@ static struct pmbus_driver_info max34440_info[] = {
 		.func[9] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.func[10] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.get_status = max34440_get_status,
+		.read_byte_data = max34440_read_byte_data,
 	},
 };
 
diff --git a/drivers/hwmon/max8688.c b/drivers/hwmon/max8688.c
index 8ebfef2..7fb93f4 100644
--- a/drivers/hwmon/max8688.c
+++ b/drivers/hwmon/max8688.c
@@ -37,7 +37,7 @@
 #define MAX8688_STATUS_OT_FAULT		(1 << 13)
 #define MAX8688_STATUS_OT_WARNING	(1 << 14)
 
-static int max8688_get_status(struct i2c_client *client, int page, int reg)
+static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	int ret = 0;
 	int mfg_status;
@@ -110,7 +110,7 @@ static struct pmbus_driver_info max8688_info = {
 	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP
 		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
 		| PMBUS_HAVE_STATUS_TEMP,
-	.get_status = max8688_get_status,
+	.read_byte_data = max8688_read_byte_data,
 };
 
 static int max8688_probe(struct i2c_client *client,
diff --git a/drivers/hwmon/pmbus.h b/drivers/hwmon/pmbus.h
index a81f7f2..50647ab 100644
--- a/drivers/hwmon/pmbus.h
+++ b/drivers/hwmon/pmbus.h
@@ -281,13 +281,11 @@ struct pmbus_driver_info {
 
 	u32 func[PMBUS_PAGES];	/* Functionality, per page */
 	/*
-	 * The get_status function maps manufacturing specific status values
-	 * into PMBus standard status values.
-	 * This function is optional and only necessary if chip specific status
-	 * register values have to be mapped into standard PMBus status register
-	 * values.
+	 * The following functions map manufacturing specific register values
+	 * to PMBus standard register values. Specify only if mapping is
+	 * necessary.
 	 */
-	int (*get_status)(struct i2c_client *client, int page, int reg);
+	int (*read_byte_data)(struct i2c_client *client, int page, int reg);
 	/*
 	 * The identify function determines supported PMBus functionality.
 	 * This function is only necessary if a chip driver supports multiple
diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 4e42a29..43ec105 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -270,18 +270,22 @@ const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(pmbus_get_driver_info);
 
-static int pmbus_get_status(struct i2c_client *client, int page, int reg)
+/*
+ * _pmbus_read_byte_data() is similar to pmbus_read_byte_data(), but checks if
+ * a device specific mapping funcion exists and calls it if necessary.
+ */
+static int _pmbus_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	const struct pmbus_driver_info *info = data->info;
 	int status;
 
-	if (info->get_status) {
-		status = info->get_status(client, page, reg);
+	if (info->read_byte_data) {
+		status = info->read_byte_data(client, page, reg);
 		if (status != -ENODATA)
 			return status;
 	}
-	return  pmbus_read_byte_data(client, page, reg);
+	return pmbus_read_byte_data(client, page, reg);
 }
 
 static struct pmbus_data *pmbus_update_device(struct device *dev)
@@ -302,38 +306,41 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
 				continue;
 			data->status[PB_STATUS_VOUT_BASE + i]
-			  = pmbus_get_status(client, i, PMBUS_STATUS_VOUT);
+			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_VOUT);
 		}
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_IOUT))
 				continue;
 			data->status[PB_STATUS_IOUT_BASE + i]
-			  = pmbus_get_status(client, i, PMBUS_STATUS_IOUT);
+			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_IOUT);
 		}
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_TEMP))
 				continue;
 			data->status[PB_STATUS_TEMP_BASE + i]
-			  = pmbus_get_status(client, i,
-					     PMBUS_STATUS_TEMPERATURE);
+			  = _pmbus_read_byte_data(client, i,
+						  PMBUS_STATUS_TEMPERATURE);
 		}
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN12))
 				continue;
 			data->status[PB_STATUS_FAN_BASE + i]
-			  = pmbus_get_status(client, i, PMBUS_STATUS_FAN_12);
+			  = _pmbus_read_byte_data(client, i,
+						  PMBUS_STATUS_FAN_12);
 		}
 
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN34))
 				continue;
 			data->status[PB_STATUS_FAN34_BASE + i]
-			  = pmbus_get_status(client, i, PMBUS_STATUS_FAN_34);
+			  = _pmbus_read_byte_data(client, i,
+						  PMBUS_STATUS_FAN_34);
 		}
 
 		if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
 			data->status[PB_STATUS_INPUT_BASE]
-			  = pmbus_get_status(client, 0, PMBUS_STATUS_INPUT);
+			  = _pmbus_read_byte_data(client, 0,
+						  PMBUS_STATUS_INPUT);
 
 		for (i = 0; i < data->num_sensors; i++) {
 			struct pmbus_sensor *sensor = &data->sensors[i];
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
