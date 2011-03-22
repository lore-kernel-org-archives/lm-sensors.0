From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Mar 2011 14:58:48 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (pmbus) Fix temperature limit
Message-Id: <1300806192-1168-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 8677011 added auto-update to temperature limit registers.
Unfortunately, the update flag is also used to determine if an attribute
is writable, which results in read-only temperature limit registers.
To fix the problem, pass 'readonly' as separate flag to the function used
to add sensor attributes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus_core.c |   70 ++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 29c7d91..196ffaf 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -751,7 +751,7 @@ static void pmbus_add_boolean_cmp(struct pmbus_data *data,
 static void pmbus_add_sensor(struct pmbus_data *data,
 			     const char *name, const char *type, int seq,
 			     int page, int reg, enum pmbus_sensor_classes class,
-			     bool update)
+			     bool update, bool readonly)
 {
 	struct pmbus_sensor *sensor;
 
@@ -764,7 +764,7 @@ static void pmbus_add_sensor(struct pmbus_data *data,
 	sensor->reg = reg;
 	sensor->class = class;
 	sensor->update = update;
-	if (update)
+	if (readonly)
 		PMBUS_ADD_GET_ATTR(data, sensor->name, sensor,
 				   data->num_sensors);
 	else
@@ -915,14 +915,14 @@ static void pmbus_find_attributes(struct i2c_client *client,
 
 		i0 = data->num_sensors;
 		pmbus_add_label(data, "in", in_index, "vin", 0);
-		pmbus_add_sensor(data, "in", "input", in_index,
-				 0, PMBUS_READ_VIN, PSC_VOLTAGE_IN, true);
+		pmbus_add_sensor(data, "in", "input", in_index, 0,
+				 PMBUS_READ_VIN, PSC_VOLTAGE_IN, true, true);
 		if (pmbus_check_word_register(client, 0,
 					      PMBUS_VIN_UV_WARN_LIMIT)) {
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "min", in_index,
 					 0, PMBUS_VIN_UV_WARN_LIMIT,
-					 PSC_VOLTAGE_IN, false);
+					 PSC_VOLTAGE_IN, false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
 				pmbus_add_boolean_reg(data, "in", "min_alarm",
 						      in_index,
@@ -936,7 +936,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "lcrit", in_index,
 					 0, PMBUS_VIN_UV_FAULT_LIMIT,
-					 PSC_VOLTAGE_IN, false);
+					 PSC_VOLTAGE_IN, false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
 				pmbus_add_boolean_reg(data, "in", "lcrit_alarm",
 						      in_index,
@@ -950,7 +950,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "max", in_index,
 					 0, PMBUS_VIN_OV_WARN_LIMIT,
-					 PSC_VOLTAGE_IN, false);
+					 PSC_VOLTAGE_IN, false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
 				pmbus_add_boolean_reg(data, "in", "max_alarm",
 						      in_index,
@@ -964,7 +964,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "crit", in_index,
 					 0, PMBUS_VIN_OV_FAULT_LIMIT,
-					 PSC_VOLTAGE_IN, false);
+					 PSC_VOLTAGE_IN, false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
 				pmbus_add_boolean_reg(data, "in", "crit_alarm",
 						      in_index,
@@ -987,7 +987,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 	if (info->func[0] & PMBUS_HAVE_VCAP) {
 		pmbus_add_label(data, "in", in_index, "vcap", 0);
 		pmbus_add_sensor(data, "in", "input", in_index, 0,
-				 PMBUS_READ_VCAP, PSC_VOLTAGE_IN, true);
+				 PMBUS_READ_VCAP, PSC_VOLTAGE_IN, true, true);
 		in_index++;
 	}
 
@@ -1003,13 +1003,13 @@ static void pmbus_find_attributes(struct i2c_client *client,
 		i0 = data->num_sensors;
 		pmbus_add_label(data, "in", in_index, "vout", page + 1);
 		pmbus_add_sensor(data, "in", "input", in_index, page,
-				 PMBUS_READ_VOUT, PSC_VOLTAGE_OUT, true);
+				 PMBUS_READ_VOUT, PSC_VOLTAGE_OUT, true, true);
 		if (pmbus_check_word_register(client, page,
 					      PMBUS_VOUT_UV_WARN_LIMIT)) {
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "min", in_index, page,
 					 PMBUS_VOUT_UV_WARN_LIMIT,
-					 PSC_VOLTAGE_OUT, false);
+					 PSC_VOLTAGE_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
 				pmbus_add_boolean_reg(data, "in", "min_alarm",
 						      in_index,
@@ -1024,7 +1024,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "lcrit", in_index, page,
 					 PMBUS_VOUT_UV_FAULT_LIMIT,
-					 PSC_VOLTAGE_OUT, false);
+					 PSC_VOLTAGE_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
 				pmbus_add_boolean_reg(data, "in", "lcrit_alarm",
 						      in_index,
@@ -1039,7 +1039,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "max", in_index, page,
 					 PMBUS_VOUT_OV_WARN_LIMIT,
-					 PSC_VOLTAGE_OUT, false);
+					 PSC_VOLTAGE_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
 				pmbus_add_boolean_reg(data, "in", "max_alarm",
 						      in_index,
@@ -1054,7 +1054,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "in", "crit", in_index, page,
 					 PMBUS_VOUT_OV_FAULT_LIMIT,
-					 PSC_VOLTAGE_OUT, false);
+					 PSC_VOLTAGE_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
 				pmbus_add_boolean_reg(data, "in", "crit_alarm",
 						      in_index,
@@ -1087,14 +1087,14 @@ static void pmbus_find_attributes(struct i2c_client *client,
 	if (info->func[0] & PMBUS_HAVE_IIN) {
 		i0 = data->num_sensors;
 		pmbus_add_label(data, "curr", in_index, "iin", 0);
-		pmbus_add_sensor(data, "curr", "input", in_index,
-				 0, PMBUS_READ_IIN, PSC_CURRENT_IN, true);
+		pmbus_add_sensor(data, "curr", "input", in_index, 0,
+				 PMBUS_READ_IIN, PSC_CURRENT_IN, true, true);
 		if (pmbus_check_word_register(client, 0,
 					      PMBUS_IIN_OC_WARN_LIMIT)) {
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "curr", "max", in_index,
 					 0, PMBUS_IIN_OC_WARN_LIMIT,
-					 PSC_CURRENT_IN, false);
+					 PSC_CURRENT_IN, false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
 				pmbus_add_boolean_reg(data, "curr", "max_alarm",
 						      in_index,
@@ -1107,7 +1107,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "curr", "crit", in_index,
 					 0, PMBUS_IIN_OC_FAULT_LIMIT,
-					 PSC_CURRENT_IN, false);
+					 PSC_CURRENT_IN, false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
 				pmbus_add_boolean_reg(data, "curr",
 						      "crit_alarm",
@@ -1130,13 +1130,13 @@ static void pmbus_find_attributes(struct i2c_client *client,
 		i0 = data->num_sensors;
 		pmbus_add_label(data, "curr", in_index, "iout", page + 1);
 		pmbus_add_sensor(data, "curr", "input", in_index, page,
-				 PMBUS_READ_IOUT, PSC_CURRENT_OUT, true);
+				 PMBUS_READ_IOUT, PSC_CURRENT_OUT, true, true);
 		if (pmbus_check_word_register(client, page,
 					      PMBUS_IOUT_OC_WARN_LIMIT)) {
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "curr", "max", in_index, page,
 					 PMBUS_IOUT_OC_WARN_LIMIT,
-					 PSC_CURRENT_OUT, false);
+					 PSC_CURRENT_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
 				pmbus_add_boolean_reg(data, "curr", "max_alarm",
 						      in_index,
@@ -1150,7 +1150,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "curr", "lcrit", in_index, page,
 					 PMBUS_IOUT_UC_FAULT_LIMIT,
-					 PSC_CURRENT_OUT, false);
+					 PSC_CURRENT_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
 				pmbus_add_boolean_reg(data, "curr",
 						      "lcrit_alarm",
@@ -1165,7 +1165,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "curr", "crit", in_index, page,
 					 PMBUS_IOUT_OC_FAULT_LIMIT,
-					 PSC_CURRENT_OUT, false);
+					 PSC_CURRENT_OUT, false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
 				pmbus_add_boolean_reg(data, "curr",
 						      "crit_alarm",
@@ -1198,13 +1198,13 @@ static void pmbus_find_attributes(struct i2c_client *client,
 		i0 = data->num_sensors;
 		pmbus_add_label(data, "power", in_index, "pin", 0);
 		pmbus_add_sensor(data, "power", "input", in_index,
-				 0, PMBUS_READ_PIN, PSC_POWER, true);
+				 0, PMBUS_READ_PIN, PSC_POWER, true, true);
 		if (pmbus_check_word_register(client, 0,
 					      PMBUS_PIN_OP_WARN_LIMIT)) {
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "power", "max", in_index,
 					 0, PMBUS_PIN_OP_WARN_LIMIT, PSC_POWER,
-					 false);
+					 false, false);
 			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
 				pmbus_add_boolean_reg(data, "power",
 						      "alarm",
@@ -1227,7 +1227,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 		i0 = data->num_sensors;
 		pmbus_add_label(data, "power", in_index, "pout", page + 1);
 		pmbus_add_sensor(data, "power", "input", in_index, page,
-				 PMBUS_READ_POUT, PSC_POWER, true);
+				 PMBUS_READ_POUT, PSC_POWER, true, true);
 		/*
 		 * Per hwmon sysfs API, power_cap is to be used to limit output
 		 * power.
@@ -1240,7 +1240,8 @@ static void pmbus_find_attributes(struct i2c_client *client,
 		if (pmbus_check_word_register(client, page, PMBUS_POUT_MAX)) {
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "power", "cap", in_index, page,
-					 PMBUS_POUT_MAX, PSC_POWER, false);
+					 PMBUS_POUT_MAX, PSC_POWER,
+					 false, false);
 			need_alarm = true;
 		}
 		if (pmbus_check_word_register(client, page,
@@ -1248,7 +1249,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "power", "max", in_index, page,
 					 PMBUS_POUT_OP_WARN_LIMIT, PSC_POWER,
-					 false);
+					 false, false);
 			need_alarm = true;
 		}
 		if (need_alarm && (info->func[page] & PMBUS_HAVE_STATUS_IOUT))
@@ -1263,7 +1264,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i1 = data->num_sensors;
 			pmbus_add_sensor(data, "power", "crit", in_index, page,
 					 PMBUS_POUT_OP_FAULT_LIMIT, PSC_POWER,
-					 false);
+					 false, false);
 			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT)
 				pmbus_add_boolean_reg(data, "power",
 						      "crit_alarm",
@@ -1301,7 +1302,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			i0 = data->num_sensors;
 			pmbus_add_sensor(data, "temp", "input", in_index, page,
 					 pmbus_temp_registers[t],
-					 PSC_TEMPERATURE, true);
+					 PSC_TEMPERATURE, true, true);
 
 			/*
 			 * PMBus provides only one status register for TEMP1-3.
@@ -1322,7 +1323,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 				i1 = data->num_sensors;
 				pmbus_add_sensor(data, "temp", "min", in_index,
 						 page, PMBUS_UT_WARN_LIMIT,
-						 PSC_TEMPERATURE, true);
+						 PSC_TEMPERATURE, true, false);
 				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
 					pmbus_add_boolean_cmp(data, "temp",
 						"min_alarm", in_index, i1, i0,
@@ -1337,7 +1338,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 				pmbus_add_sensor(data, "temp", "lcrit",
 						 in_index, page,
 						 PMBUS_UT_FAULT_LIMIT,
-						 PSC_TEMPERATURE, true);
+						 PSC_TEMPERATURE, true, false);
 				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
 					pmbus_add_boolean_cmp(data, "temp",
 						"lcrit_alarm", in_index, i1, i0,
@@ -1351,7 +1352,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 				i1 = data->num_sensors;
 				pmbus_add_sensor(data, "temp", "max", in_index,
 						 page, PMBUS_OT_WARN_LIMIT,
-						 PSC_TEMPERATURE, true);
+						 PSC_TEMPERATURE, true, false);
 				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
 					pmbus_add_boolean_cmp(data, "temp",
 						"max_alarm", in_index, i0, i1,
@@ -1365,7 +1366,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 				i1 = data->num_sensors;
 				pmbus_add_sensor(data, "temp", "crit", in_index,
 						 page, PMBUS_OT_FAULT_LIMIT,
-						 PSC_TEMPERATURE, true);
+						 PSC_TEMPERATURE, true, false);
 				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
 					pmbus_add_boolean_cmp(data, "temp",
 						"crit_alarm", in_index, i0, i1,
@@ -1420,7 +1421,8 @@ static void pmbus_find_attributes(struct i2c_client *client,
 
 			i0 = data->num_sensors;
 			pmbus_add_sensor(data, "fan", "input", in_index, page,
-					 pmbus_fan_registers[f], PSC_FAN, true);
+					 pmbus_fan_registers[f], PSC_FAN, true,
+					 true);
 
 			/*
 			 * Each fan status register covers multiple fans,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
