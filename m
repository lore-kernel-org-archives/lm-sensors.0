From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 16:19:04 +0000
Subject: [lm-sensors] [PATCH v2 3/4] hwmon: (pmbus/adm1275) Add support for
Message-Id: <1314375545-18335-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ADM1275 supports a second current limit, which can be configured as either lower
or upper limit. Add support for it and report it as either lower or upper
critical current limit.

Also replace error return code EINVAL for unsupported pages with ENXIO as this
is more appropriate for the observed condition.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/adm1275   |    8 +++
 drivers/hwmon/pmbus/adm1275.c |   95 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index 097b3cc..c438c98 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -60,5 +60,13 @@ curr1_label		"iout1"
 curr1_input		Measured current. From READ_IOUT register.
 curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
 curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
+curr1_lcrit		Critical minimum current. Depending on the chip
+			configuration, either curr1_lcrit or curr1_crit is
+			supported, but not both.
+curr1_lcrit_alarm	Critical current low alarm.
+curr1_crit		Critical maximum current. Depending on the chip
+			configuration, either curr1_lcrit or curr1_crit is
+			supported, but not both.
+curr1_crit_alarm	Critical current high alarm.
 curr1_highest		Historical maximum current.
 curr1_reset_history	Write any value to reset history.
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 424d0d7..7a9f2d9 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -31,14 +31,44 @@
 #define ADM1275_VIN_VOUT_SELECT		(1 << 6)
 #define ADM1275_VRANGE			(1 << 5)
 
+#define ADM1275_IOUT_WARN2_LIMIT	0xd7
+#define ADM1275_DEVICE_CONFIG		0xd8
+
+#define ADM1275_IOUT_WARN2_SELECT	(1 << 4)
+
+#define ADM1275_MFR_STATUS_IOUT_WARN2	(1 << 0)
+
+struct adm1275_data {
+	bool have_oc_fault;
+	struct pmbus_driver_info info;
+};
+
+#define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
+
 static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct adm1275_data *data = to_adm1275_data(info);
 	int ret;
 
 	if (page)
-		return -EINVAL;
+		return -ENXIO;
 
 	switch (reg) {
+	case PMBUS_IOUT_UC_FAULT_LIMIT:
+		if (data->have_oc_fault) {
+			ret = -ENXIO;
+			break;
+		}
+		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
+		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+		if (!data->have_oc_fault) {
+			ret = -ENXIO;
+			break;
+		}
+		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
+		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
 		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_IOUT);
 		break;
@@ -66,9 +96,14 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
 	int ret;
 
 	if (page)
-		return -EINVAL;
+		return -ENXIO;
 
 	switch (reg) {
+	case PMBUS_IOUT_UC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+		ret = pmbus_write_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT,
+					    word);
+		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_IOUT, 0);
 		break;
@@ -85,19 +120,52 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
 	return ret;
 }
 
+static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct adm1275_data *data = to_adm1275_data(info);
+	int mfr_status, ret;
+
+	if (page)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_STATUS_IOUT:
+		ret = pmbus_read_byte_data(client, page, PMBUS_STATUS_IOUT);
+		if (ret < 0)
+			break;
+		mfr_status = pmbus_read_byte_data(client, page,
+						  PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr_status < 0) {
+			ret = mfr_status;
+			break;
+		}
+		if (mfr_status & ADM1275_MFR_STATUS_IOUT_WARN2) {
+			ret |= data->have_oc_fault ?
+			  PB_IOUT_OC_FAULT : PB_IOUT_UC_FAULT;
+		}
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 static int adm1275_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	int config;
+	int config, device_config;
 	int ret;
 	struct pmbus_driver_info *info;
+	struct adm1275_data *data;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
 		return -ENODEV;
 
-	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
-	if (!info)
+	data = kzalloc(sizeof(struct adm1275_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
@@ -106,6 +174,14 @@ static int adm1275_probe(struct i2c_client *client,
 		goto err_mem;
 	}
 
+	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
+	if (device_config < 0) {
+		ret = device_config;
+		goto err_mem;
+	}
+
+	info = &data->info;
+
 	info->pages = 1;
 	info->format[PSC_VOLTAGE_IN] = direct;
 	info->format[PSC_VOLTAGE_OUT] = direct;
@@ -116,6 +192,7 @@ static int adm1275_probe(struct i2c_client *client,
 	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 
 	info->read_word_data = adm1275_read_word_data;
+	info->read_byte_data = adm1275_read_byte_data;
 	info->write_word_data = adm1275_write_word_data;
 
 	if (config & ADM1275_VRANGE) {
@@ -134,6 +211,9 @@ static int adm1275_probe(struct i2c_client *client,
 		info->R[PSC_VOLTAGE_OUT] = -1;
 	}
 
+	if (device_config & ADM1275_IOUT_WARN2_SELECT)
+		data->have_oc_fault = true;
+
 	if (config & ADM1275_VIN_VOUT_SELECT)
 		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 	else
@@ -145,16 +225,17 @@ static int adm1275_probe(struct i2c_client *client,
 	return 0;
 
 err_mem:
-	kfree(info);
+	kfree(data);
 	return ret;
 }
 
 static int adm1275_remove(struct i2c_client *client)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct adm1275_data *data = to_adm1275_data(info);
 
 	pmbus_do_remove(client);
-	kfree(info);
+	kfree(data);
 	return 0;
 }
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
