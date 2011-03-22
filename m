From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Mar 2011 15:09:56 +0000
Subject: [lm-sensors] [PATCH 3/3 resend] hwmon: (pmbus) Introduce
Message-Id: <1300806596-1311-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This commit replaces hard-coded sensor and limit register detection code
with table based sensor detection. This change eliminates code block repetition
and reduces code size.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Looks like our mailer swallowed this one the first time around, so I am
resending. My apologies if you receive it twice.

 drivers/hwmon/pmbus_core.c |  935 ++++++++++++++++++++------------------------
 1 files changed, 421 insertions(+), 514 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 196ffaf..4e42a29 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -793,53 +793,6 @@ static void pmbus_add_label(struct pmbus_data *data,
 	data->num_labels++;
 }
 
-static const int pmbus_temp_registers[] = {
-	PMBUS_READ_TEMPERATURE_1,
-	PMBUS_READ_TEMPERATURE_2,
-	PMBUS_READ_TEMPERATURE_3
-};
-
-static const int pmbus_temp_flags[] = {
-	PMBUS_HAVE_TEMP,
-	PMBUS_HAVE_TEMP2,
-	PMBUS_HAVE_TEMP3
-};
-
-static const int pmbus_fan_registers[] = {
-	PMBUS_READ_FAN_SPEED_1,
-	PMBUS_READ_FAN_SPEED_2,
-	PMBUS_READ_FAN_SPEED_3,
-	PMBUS_READ_FAN_SPEED_4
-};
-
-static const int pmbus_fan_config_registers[] = {
-	PMBUS_FAN_CONFIG_12,
-	PMBUS_FAN_CONFIG_12,
-	PMBUS_FAN_CONFIG_34,
-	PMBUS_FAN_CONFIG_34
-};
-
-static const int pmbus_fan_status_registers[] = {
-	PMBUS_STATUS_FAN_12,
-	PMBUS_STATUS_FAN_12,
-	PMBUS_STATUS_FAN_34,
-	PMBUS_STATUS_FAN_34
-};
-
-static const u32 pmbus_fan_flags[] = {
-	PMBUS_HAVE_FAN12,
-	PMBUS_HAVE_FAN12,
-	PMBUS_HAVE_FAN34,
-	PMBUS_HAVE_FAN34
-};
-
-static const u32 pmbus_fan_status_flags[] = {
-	PMBUS_HAVE_STATUS_FAN12,
-	PMBUS_HAVE_STATUS_FAN12,
-	PMBUS_HAVE_STATUS_FAN34,
-	PMBUS_HAVE_STATUS_FAN34
-};
-
 /*
  * Determine maximum number of sensors, booleans, and labels.
  * To keep things simple, only make a rough high estimate.
@@ -900,499 +853,431 @@ static void pmbus_find_max_attr(struct i2c_client *client,
 /*
  * Search for attributes. Allocate sensors, booleans, and labels as needed.
  */
-static void pmbus_find_attributes(struct i2c_client *client,
-				  struct pmbus_data *data)
-{
-	const struct pmbus_driver_info *info = data->info;
-	int page, i0, i1, in_index;
 
-	/*
-	 * Input voltage sensors
-	 */
-	in_index = 1;
-	if (info->func[0] & PMBUS_HAVE_VIN) {
-		bool have_alarm = false;
-
-		i0 = data->num_sensors;
-		pmbus_add_label(data, "in", in_index, "vin", 0);
-		pmbus_add_sensor(data, "in", "input", in_index, 0,
-				 PMBUS_READ_VIN, PSC_VOLTAGE_IN, true, true);
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_VIN_UV_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "min", in_index,
-					 0, PMBUS_VIN_UV_WARN_LIMIT,
-					 PSC_VOLTAGE_IN, false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
-				pmbus_add_boolean_reg(data, "in", "min_alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_VOLTAGE_UV_WARNING);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_VIN_UV_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "lcrit", in_index,
-					 0, PMBUS_VIN_UV_FAULT_LIMIT,
-					 PSC_VOLTAGE_IN, false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
-				pmbus_add_boolean_reg(data, "in", "lcrit_alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_VOLTAGE_UV_FAULT);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_VIN_OV_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "max", in_index,
-					 0, PMBUS_VIN_OV_WARN_LIMIT,
-					 PSC_VOLTAGE_IN, false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
-				pmbus_add_boolean_reg(data, "in", "max_alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_VOLTAGE_OV_WARNING);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_VIN_OV_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "crit", in_index,
-					 0, PMBUS_VIN_OV_FAULT_LIMIT,
-					 PSC_VOLTAGE_IN, false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
-				pmbus_add_boolean_reg(data, "in", "crit_alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_VOLTAGE_OV_FAULT);
+/*
+ * The pmbus_limit_attr structure describes a single limit attribute
+ * and its associated alarm attribute.
+ */
+struct pmbus_limit_attr {
+	u8 reg;			/* Limit register */
+	const char *attr;	/* Attribute name */
+	const char *alarm;	/* Alarm attribute name */
+	u32 sbit;		/* Alarm attribute status bit */
+};
+
+/*
+ * The pmbus_sensor_attr structure describes one sensor attribute. This
+ * description includes a reference to the associated limit attributes.
+ */
+struct pmbus_sensor_attr {
+	u8 reg;				/* sensor register */
+	enum pmbus_sensor_classes class;/* sensor class */
+	const char *label;		/* sensor label */
+	bool paged;			/* true if paged sensor */
+	bool update;			/* true if update needed */
+	bool compare;			/* true if compare function needed */
+	u32 func;			/* sensor mask */
+	u32 sfunc;			/* sensor status mask */
+	int sbase;			/* status base register */
+	u32 gbit;			/* generic status bit */
+	const struct pmbus_limit_attr *limit;/* limit registers */
+	int nlimit;			/* # of limit registers */
+};
+
+/*
+ * Add a set of limit attributes and, if supported, the associated
+ * alarm attributes.
+ */
+static bool pmbus_add_limit_attrs(struct i2c_client *client,
+				  struct pmbus_data *data,
+				  const struct pmbus_driver_info *info,
+				  const char *name, int index, int page,
+				  int cbase,
+				  const struct pmbus_sensor_attr *attr)
+{
+	const struct pmbus_limit_attr *l = attr->limit;
+	int nlimit = attr->nlimit;
+	bool have_alarm = false;
+	int i, cindex;
+
+	for (i = 0; i < nlimit; i++) {
+		if (pmbus_check_word_register(client, page, l->reg)) {
+			cindex = data->num_sensors;
+			pmbus_add_sensor(data, name, l->attr, index, page,
+					 l->reg, attr->class, attr->update,
+					 false);
+			if (info->func[page] & attr->sfunc) {
+				if (attr->compare) {
+					pmbus_add_boolean_cmp(data, name,
+						l->alarm, index,
+						cbase, cindex,
+						attr->sbase + page, l->sbit);
+				} else {
+					pmbus_add_boolean_reg(data, name,
+						l->alarm, index,
+						attr->sbase + page, l->sbit);
+				}
 				have_alarm = true;
 			}
 		}
-		/*
-		 * Add generic alarm attribute only if there are no individual
-		 * attributes.
-		 */
-		if (!have_alarm)
-			pmbus_add_boolean_reg(data, "in", "alarm",
-					      in_index,
-					      PB_STATUS_BASE,
-					      PB_STATUS_VIN_UV);
-		in_index++;
-	}
-	if (info->func[0] & PMBUS_HAVE_VCAP) {
-		pmbus_add_label(data, "in", in_index, "vcap", 0);
-		pmbus_add_sensor(data, "in", "input", in_index, 0,
-				 PMBUS_READ_VCAP, PSC_VOLTAGE_IN, true, true);
-		in_index++;
+		l++;
 	}
+	return have_alarm;
+}
 
-	/*
-	 * Output voltage sensors
-	 */
-	for (page = 0; page < info->pages; page++) {
-		bool have_alarm = false;
-
-		if (!(info->func[page] & PMBUS_HAVE_VOUT))
-			continue;
-
-		i0 = data->num_sensors;
-		pmbus_add_label(data, "in", in_index, "vout", page + 1);
-		pmbus_add_sensor(data, "in", "input", in_index, page,
-				 PMBUS_READ_VOUT, PSC_VOLTAGE_OUT, true, true);
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_VOUT_UV_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "min", in_index, page,
-					 PMBUS_VOUT_UV_WARN_LIMIT,
-					 PSC_VOLTAGE_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
-				pmbus_add_boolean_reg(data, "in", "min_alarm",
-						      in_index,
-						      PB_STATUS_VOUT_BASE +
-						      page,
-						      PB_VOLTAGE_UV_WARNING);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_VOUT_UV_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "lcrit", in_index, page,
-					 PMBUS_VOUT_UV_FAULT_LIMIT,
-					 PSC_VOLTAGE_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
-				pmbus_add_boolean_reg(data, "in", "lcrit_alarm",
-						      in_index,
-						      PB_STATUS_VOUT_BASE +
-						      page,
-						      PB_VOLTAGE_UV_FAULT);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_VOUT_OV_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "max", in_index, page,
-					 PMBUS_VOUT_OV_WARN_LIMIT,
-					 PSC_VOLTAGE_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
-				pmbus_add_boolean_reg(data, "in", "max_alarm",
-						      in_index,
-						      PB_STATUS_VOUT_BASE +
-						      page,
-						      PB_VOLTAGE_OV_WARNING);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_VOUT_OV_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "in", "crit", in_index, page,
-					 PMBUS_VOUT_OV_FAULT_LIMIT,
-					 PSC_VOLTAGE_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
-				pmbus_add_boolean_reg(data, "in", "crit_alarm",
-						      in_index,
-						      PB_STATUS_VOUT_BASE +
-						      page,
-						      PB_VOLTAGE_OV_FAULT);
-				have_alarm = true;
-			}
-		}
+static void pmbus_add_sensor_attrs_one(struct i2c_client *client,
+				       struct pmbus_data *data,
+				       const struct pmbus_driver_info *info,
+				       const char *name,
+				       int index, int page,
+				       const struct pmbus_sensor_attr *attr)
+{
+	bool have_alarm;
+	int cbase = data->num_sensors;
+
+	if (attr->label)
+		pmbus_add_label(data, name, index, attr->label,
+				attr->paged ? page + 1 : 0);
+	pmbus_add_sensor(data, name, "input", index, page, attr->reg,
+			 attr->class, true, true);
+	if (attr->sfunc) {
+		have_alarm = pmbus_add_limit_attrs(client, data, info, name,
+						   index, page, cbase, attr);
 		/*
 		 * Add generic alarm attribute only if there are no individual
-		 * attributes.
+		 * alarm attributes, and if there is a global alarm bit.
 		 */
-		if (!have_alarm)
-			pmbus_add_boolean_reg(data, "in", "alarm",
-					      in_index,
+		if (!have_alarm && attr->gbit)
+			pmbus_add_boolean_reg(data, name, "alarm", index,
 					      PB_STATUS_BASE + page,
-					      PB_STATUS_VOUT_OV);
-		in_index++;
+					      attr->gbit);
 	}
+}
 
-	/*
-	 * Current sensors
-	 */
+static void pmbus_add_sensor_attrs(struct i2c_client *client,
+				   struct pmbus_data *data,
+				   const char *name,
+				   const struct pmbus_sensor_attr *attrs,
+				   int nattrs)
+{
+	const struct pmbus_driver_info *info = data->info;
+	int index, i;
 
-	/*
-	 * Input current sensors
-	 */
-	in_index = 1;
-	if (info->func[0] & PMBUS_HAVE_IIN) {
-		i0 = data->num_sensors;
-		pmbus_add_label(data, "curr", in_index, "iin", 0);
-		pmbus_add_sensor(data, "curr", "input", in_index, 0,
-				 PMBUS_READ_IIN, PSC_CURRENT_IN, true, true);
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_IIN_OC_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "curr", "max", in_index,
-					 0, PMBUS_IIN_OC_WARN_LIMIT,
-					 PSC_CURRENT_IN, false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT) {
-				pmbus_add_boolean_reg(data, "curr", "max_alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_IIN_OC_WARNING);
-			}
-		}
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_IIN_OC_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "curr", "crit", in_index,
-					 0, PMBUS_IIN_OC_FAULT_LIMIT,
-					 PSC_CURRENT_IN, false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
-				pmbus_add_boolean_reg(data, "curr",
-						      "crit_alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_IIN_OC_FAULT);
+	index = 1;
+	for (i = 0; i < nattrs; i++) {
+		int page, pages;
+
+		pages = attrs->paged ? info->pages : 1;
+		for (page = 0; page < pages; page++) {
+			if (!(info->func[page] & attrs->func))
+				continue;
+			pmbus_add_sensor_attrs_one(client, data, info, name,
+						   index, page, attrs);
+			index++;
 		}
-		in_index++;
+		attrs++;
 	}
+}
 
-	/*
-	 * Output current sensors
-	 */
-	for (page = 0; page < info->pages; page++) {
-		bool have_alarm = false;
-
-		if (!(info->func[page] & PMBUS_HAVE_IOUT))
-			continue;
-
-		i0 = data->num_sensors;
-		pmbus_add_label(data, "curr", in_index, "iout", page + 1);
-		pmbus_add_sensor(data, "curr", "input", in_index, page,
-				 PMBUS_READ_IOUT, PSC_CURRENT_OUT, true, true);
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_IOUT_OC_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "curr", "max", in_index, page,
-					 PMBUS_IOUT_OC_WARN_LIMIT,
-					 PSC_CURRENT_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
-				pmbus_add_boolean_reg(data, "curr", "max_alarm",
-						      in_index,
-						      PB_STATUS_IOUT_BASE +
-						      page, PB_IOUT_OC_WARNING);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_IOUT_UC_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "curr", "lcrit", in_index, page,
-					 PMBUS_IOUT_UC_FAULT_LIMIT,
-					 PSC_CURRENT_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
-				pmbus_add_boolean_reg(data, "curr",
-						      "lcrit_alarm",
-						      in_index,
-						      PB_STATUS_IOUT_BASE +
-						      page, PB_IOUT_UC_FAULT);
-				have_alarm = true;
-			}
-		}
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_IOUT_OC_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "curr", "crit", in_index, page,
-					 PMBUS_IOUT_OC_FAULT_LIMIT,
-					 PSC_CURRENT_OUT, false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
-				pmbus_add_boolean_reg(data, "curr",
-						      "crit_alarm",
-						      in_index,
-						      PB_STATUS_IOUT_BASE +
-						      page, PB_IOUT_OC_FAULT);
-				have_alarm = true;
-			}
-		}
-		/*
-		 * Add generic alarm attribute only if there are no individual
-		 * attributes.
-		 */
-		if (!have_alarm)
-			pmbus_add_boolean_reg(data, "curr", "alarm",
-					      in_index,
-					      PB_STATUS_BASE + page,
-					      PB_STATUS_IOUT_OC);
-		in_index++;
+static const struct pmbus_limit_attr vin_limit_attrs[] = {
+	{
+		.reg = PMBUS_VIN_UV_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_VOLTAGE_UV_WARNING,
+	}, {
+		.reg = PMBUS_VIN_UV_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_VOLTAGE_UV_FAULT,
+	}, {
+		.reg = PMBUS_VIN_OV_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_VOLTAGE_OV_WARNING,
+	}, {
+		.reg = PMBUS_VIN_OV_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_VOLTAGE_OV_FAULT,
+	},
+};
+
+static const struct pmbus_limit_attr vout_limit_attrs[] = {
+	{
+		.reg = PMBUS_VOUT_UV_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_VOLTAGE_UV_WARNING,
+	}, {
+		.reg = PMBUS_VOUT_UV_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_VOLTAGE_UV_FAULT,
+	}, {
+		.reg = PMBUS_VOUT_OV_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_VOLTAGE_OV_WARNING,
+	}, {
+		.reg = PMBUS_VOUT_OV_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_VOLTAGE_OV_FAULT,
 	}
+};
 
-	/*
-	 * Power sensors
-	 */
-	/*
-	 * Input Power sensors
-	 */
-	in_index = 1;
-	if (info->func[0] & PMBUS_HAVE_PIN) {
-		i0 = data->num_sensors;
-		pmbus_add_label(data, "power", in_index, "pin", 0);
-		pmbus_add_sensor(data, "power", "input", in_index,
-				 0, PMBUS_READ_PIN, PSC_POWER, true, true);
-		if (pmbus_check_word_register(client, 0,
-					      PMBUS_PIN_OP_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "power", "max", in_index,
-					 0, PMBUS_PIN_OP_WARN_LIMIT, PSC_POWER,
-					 false, false);
-			if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
-				pmbus_add_boolean_reg(data, "power",
-						      "alarm",
-						      in_index,
-						      PB_STATUS_INPUT_BASE,
-						      PB_PIN_OP_WARNING);
-		}
-		in_index++;
+static const struct pmbus_sensor_attr voltage_attributes[] = {
+	{
+		.reg = PMBUS_READ_VIN,
+		.class = PSC_VOLTAGE_IN,
+		.label = "vin",
+		.func = PMBUS_HAVE_VIN,
+		.sfunc = PMBUS_HAVE_STATUS_INPUT,
+		.sbase = PB_STATUS_INPUT_BASE,
+		.gbit = PB_STATUS_VIN_UV,
+		.limit = vin_limit_attrs,
+		.nlimit = ARRAY_SIZE(vin_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_VCAP,
+		.class = PSC_VOLTAGE_IN,
+		.label = "vcap",
+		.func = PMBUS_HAVE_VCAP,
+	}, {
+		.reg = PMBUS_READ_VOUT,
+		.class = PSC_VOLTAGE_OUT,
+		.label = "vout",
+		.paged = true,
+		.func = PMBUS_HAVE_VOUT,
+		.sfunc = PMBUS_HAVE_STATUS_VOUT,
+		.sbase = PB_STATUS_VOUT_BASE,
+		.gbit = PB_STATUS_VOUT_OV,
+		.limit = vout_limit_attrs,
+		.nlimit = ARRAY_SIZE(vout_limit_attrs),
 	}
+};
 
-	/*
-	 * Output Power sensors
-	 */
-	for (page = 0; page < info->pages; page++) {
-		bool need_alarm = false;
+/* Current attributes */
+
+static const struct pmbus_limit_attr iin_limit_attrs[] = {
+	{
+		.reg = PMBUS_IIN_OC_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_IIN_OC_WARNING,
+	}, {
+		.reg = PMBUS_IIN_OC_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_IIN_OC_FAULT,
+	}
+};
 
-		if (!(info->func[page] & PMBUS_HAVE_POUT))
-			continue;
+static const struct pmbus_limit_attr iout_limit_attrs[] = {
+	{
+		.reg = PMBUS_IOUT_OC_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_IOUT_OC_WARNING,
+	}, {
+		.reg = PMBUS_IOUT_UC_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_IOUT_UC_FAULT,
+	}, {
+		.reg = PMBUS_IOUT_OC_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_IOUT_OC_FAULT,
+	}
+};
 
-		i0 = data->num_sensors;
-		pmbus_add_label(data, "power", in_index, "pout", page + 1);
-		pmbus_add_sensor(data, "power", "input", in_index, page,
-				 PMBUS_READ_POUT, PSC_POWER, true, true);
-		/*
-		 * Per hwmon sysfs API, power_cap is to be used to limit output
-		 * power.
-		 * We have two registers related to maximum output power,
-		 * PMBUS_POUT_MAX and PMBUS_POUT_OP_WARN_LIMIT.
-		 * PMBUS_POUT_MAX matches the powerX_cap attribute definition.
-		 * There is no attribute in the API to match
-		 * PMBUS_POUT_OP_WARN_LIMIT. We use powerX_max for now.
-		 */
-		if (pmbus_check_word_register(client, page, PMBUS_POUT_MAX)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "power", "cap", in_index, page,
-					 PMBUS_POUT_MAX, PSC_POWER,
-					 false, false);
-			need_alarm = true;
-		}
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_POUT_OP_WARN_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "power", "max", in_index, page,
-					 PMBUS_POUT_OP_WARN_LIMIT, PSC_POWER,
-					 false, false);
-			need_alarm = true;
-		}
-		if (need_alarm && (info->func[page] & PMBUS_HAVE_STATUS_IOUT))
-			pmbus_add_boolean_reg(data, "power", "alarm",
-					      in_index,
-					      PB_STATUS_IOUT_BASE + page,
-					      PB_POUT_OP_WARNING
-					      | PB_POWER_LIMITING);
-
-		if (pmbus_check_word_register(client, page,
-					      PMBUS_POUT_OP_FAULT_LIMIT)) {
-			i1 = data->num_sensors;
-			pmbus_add_sensor(data, "power", "crit", in_index, page,
-					 PMBUS_POUT_OP_FAULT_LIMIT, PSC_POWER,
-					 false, false);
-			if (info->func[page] & PMBUS_HAVE_STATUS_IOUT)
-				pmbus_add_boolean_reg(data, "power",
-						      "crit_alarm",
-						      in_index,
-						      PB_STATUS_IOUT_BASE
-						      + page,
-						      PB_POUT_OP_FAULT);
-		}
-		in_index++;
+static const struct pmbus_sensor_attr current_attributes[] = {
+	{
+		.reg = PMBUS_READ_IIN,
+		.class = PSC_CURRENT_IN,
+		.label = "iin",
+		.func = PMBUS_HAVE_IIN,
+		.sfunc = PMBUS_HAVE_STATUS_INPUT,
+		.sbase = PB_STATUS_INPUT_BASE,
+		.limit = iin_limit_attrs,
+		.nlimit = ARRAY_SIZE(iin_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_IOUT,
+		.class = PSC_CURRENT_OUT,
+		.label = "iout",
+		.paged = true,
+		.func = PMBUS_HAVE_IOUT,
+		.sfunc = PMBUS_HAVE_STATUS_IOUT,
+		.sbase = PB_STATUS_IOUT_BASE,
+		.gbit = PB_STATUS_IOUT_OC,
+		.limit = iout_limit_attrs,
+		.nlimit = ARRAY_SIZE(iout_limit_attrs),
 	}
+};
 
-	/*
-	 * Temperature sensors
-	 */
-	in_index = 1;
-	for (page = 0; page < info->pages; page++) {
-		int t;
+/* Power attributes */
 
-		for (t = 0; t < ARRAY_SIZE(pmbus_temp_registers); t++) {
-			bool have_alarm = false;
+static const struct pmbus_limit_attr pin_limit_attrs[] = {
+	{
+		.reg = PMBUS_PIN_OP_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "alarm",
+		.sbit = PB_PIN_OP_WARNING,
+	}
+};
 
-			/*
-			 * A PMBus chip may support any combination of
-			 * temperature registers on any page. So we can not
-			 * abort after a failure to detect a register, but have
-			 * to continue checking for all registers on all pages.
-			 */
-			if (!(info->func[page] & pmbus_temp_flags[t]))
-				continue;
+static const struct pmbus_limit_attr pout_limit_attrs[] = {
+	{
+		.reg = PMBUS_POUT_MAX,
+		.attr = "cap",
+		.alarm = "cap_alarm",
+		.sbit = PB_POWER_LIMITING,
+	}, {
+		.reg = PMBUS_POUT_OP_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_POUT_OP_WARNING,
+	}, {
+		.reg = PMBUS_POUT_OP_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_POUT_OP_FAULT,
+	}
+};
 
-			if (!pmbus_check_word_register
-			    (client, page, pmbus_temp_registers[t]))
-				continue;
+static const struct pmbus_sensor_attr power_attributes[] = {
+	{
+		.reg = PMBUS_READ_PIN,
+		.class = PSC_POWER,
+		.label = "pin",
+		.func = PMBUS_HAVE_PIN,
+		.sfunc = PMBUS_HAVE_STATUS_INPUT,
+		.sbase = PB_STATUS_INPUT_BASE,
+		.limit = pin_limit_attrs,
+		.nlimit = ARRAY_SIZE(pin_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_POUT,
+		.class = PSC_POWER,
+		.label = "pout",
+		.paged = true,
+		.func = PMBUS_HAVE_POUT,
+		.sfunc = PMBUS_HAVE_STATUS_IOUT,
+		.sbase = PB_STATUS_IOUT_BASE,
+		.limit = pout_limit_attrs,
+		.nlimit = ARRAY_SIZE(pout_limit_attrs),
+	}
+};
 
-			i0 = data->num_sensors;
-			pmbus_add_sensor(data, "temp", "input", in_index, page,
-					 pmbus_temp_registers[t],
-					 PSC_TEMPERATURE, true, true);
+/* Temperature atributes */
+
+static const struct pmbus_limit_attr temp_limit_attrs[] = {
+	{
+		.reg = PMBUS_UT_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_TEMP_UT_WARNING,
+	}, {
+		.reg = PMBUS_UT_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_TEMP_UT_FAULT,
+	}, {
+		.reg = PMBUS_OT_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_TEMP_OT_WARNING,
+	}, {
+		.reg = PMBUS_OT_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_TEMP_OT_FAULT,
+	}
+};
 
-			/*
-			 * PMBus provides only one status register for TEMP1-3.
-			 * Thus, we can not use the status register to determine
-			 * which of the three sensors actually caused an alarm.
-			 * Always compare current temperature against the limit
-			 * registers to determine alarm conditions for a
-			 * specific sensor.
-			 *
-			 * Since there is only one set of limit registers for
-			 * up to three temperature sensors, we need to update
-			 * all limit registers after the limit was changed for
-			 * one of the sensors. This ensures that correct limits
-			 * are reported for all temperature sensors.
-			 */
-			if (pmbus_check_word_register
-			    (client, page, PMBUS_UT_WARN_LIMIT)) {
-				i1 = data->num_sensors;
-				pmbus_add_sensor(data, "temp", "min", in_index,
-						 page, PMBUS_UT_WARN_LIMIT,
-						 PSC_TEMPERATURE, true, false);
-				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
-					pmbus_add_boolean_cmp(data, "temp",
-						"min_alarm", in_index, i1, i0,
-						PB_STATUS_TEMP_BASE + page,
-						PB_TEMP_UT_WARNING);
-					have_alarm = true;
-				}
-			}
-			if (pmbus_check_word_register(client, page,
-						      PMBUS_UT_FAULT_LIMIT)) {
-				i1 = data->num_sensors;
-				pmbus_add_sensor(data, "temp", "lcrit",
-						 in_index, page,
-						 PMBUS_UT_FAULT_LIMIT,
-						 PSC_TEMPERATURE, true, false);
-				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
-					pmbus_add_boolean_cmp(data, "temp",
-						"lcrit_alarm", in_index, i1, i0,
-						PB_STATUS_TEMP_BASE + page,
-						PB_TEMP_UT_FAULT);
-					have_alarm = true;
-				}
-			}
-			if (pmbus_check_word_register
-			    (client, page, PMBUS_OT_WARN_LIMIT)) {
-				i1 = data->num_sensors;
-				pmbus_add_sensor(data, "temp", "max", in_index,
-						 page, PMBUS_OT_WARN_LIMIT,
-						 PSC_TEMPERATURE, true, false);
-				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
-					pmbus_add_boolean_cmp(data, "temp",
-						"max_alarm", in_index, i0, i1,
-						PB_STATUS_TEMP_BASE + page,
-						PB_TEMP_OT_WARNING);
-					have_alarm = true;
-				}
-			}
-			if (pmbus_check_word_register(client, page,
-						      PMBUS_OT_FAULT_LIMIT)) {
-				i1 = data->num_sensors;
-				pmbus_add_sensor(data, "temp", "crit", in_index,
-						 page, PMBUS_OT_FAULT_LIMIT,
-						 PSC_TEMPERATURE, true, false);
-				if (info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
-					pmbus_add_boolean_cmp(data, "temp",
-						"crit_alarm", in_index, i0, i1,
-						PB_STATUS_TEMP_BASE + page,
-						PB_TEMP_OT_FAULT);
-					have_alarm = true;
-				}
-			}
-			/*
-			 * Last resort - we were not able to create any alarm
-			 * registers. Report alarm for all sensors using the
-			 * status register temperature alarm bit.
-			 */
-			if (!have_alarm)
-				pmbus_add_boolean_reg(data, "temp", "alarm",
-						      in_index,
-						      PB_STATUS_BASE + page,
-						      PB_STATUS_TEMPERATURE);
-			in_index++;
-		}
+static const struct pmbus_sensor_attr temp_attributes[] = {
+	{
+		.reg = PMBUS_READ_TEMPERATURE_1,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_TEMPERATURE_2,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP2,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_TEMPERATURE_3,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP3,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs),
 	}
+};
+
+static const int pmbus_fan_registers[] = {
+	PMBUS_READ_FAN_SPEED_1,
+	PMBUS_READ_FAN_SPEED_2,
+	PMBUS_READ_FAN_SPEED_3,
+	PMBUS_READ_FAN_SPEED_4
+};
+
+static const int pmbus_fan_config_registers[] = {
+	PMBUS_FAN_CONFIG_12,
+	PMBUS_FAN_CONFIG_12,
+	PMBUS_FAN_CONFIG_34,
+	PMBUS_FAN_CONFIG_34
+};
+
+static const int pmbus_fan_status_registers[] = {
+	PMBUS_STATUS_FAN_12,
+	PMBUS_STATUS_FAN_12,
+	PMBUS_STATUS_FAN_34,
+	PMBUS_STATUS_FAN_34
+};
+
+static const u32 pmbus_fan_flags[] = {
+	PMBUS_HAVE_FAN12,
+	PMBUS_HAVE_FAN12,
+	PMBUS_HAVE_FAN34,
+	PMBUS_HAVE_FAN34
+};
+
+static const u32 pmbus_fan_status_flags[] = {
+	PMBUS_HAVE_STATUS_FAN12,
+	PMBUS_HAVE_STATUS_FAN12,
+	PMBUS_HAVE_STATUS_FAN34,
+	PMBUS_HAVE_STATUS_FAN34
+};
+
+/* Fans */
+static void pmbus_add_fan_attributes(struct i2c_client *client,
+				     struct pmbus_data *data)
+{
+	const struct pmbus_driver_info *info = data->info;
+	int index = 1;
+	int page;
 
-	/*
-	 * Fans
-	 */
-	in_index = 1;
 	for (page = 0; page < info->pages; page++) {
 		int f;
 
@@ -1419,8 +1304,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
 				continue;
 
-			i0 = data->num_sensors;
-			pmbus_add_sensor(data, "fan", "input", in_index, page,
+			pmbus_add_sensor(data, "fan", "input", index, page,
 					 pmbus_fan_registers[f], PSC_FAN, true,
 					 true);
 
@@ -1438,17 +1322,40 @@ static void pmbus_find_attributes(struct i2c_client *client,
 				else
 					base = PB_STATUS_FAN_BASE + page;
 				pmbus_add_boolean_reg(data, "fan", "alarm",
-					in_index, base,
+					index, base,
 					PB_FAN_FAN1_WARNING >> (f & 1));
 				pmbus_add_boolean_reg(data, "fan", "fault",
-					in_index, base,
+					index, base,
 					PB_FAN_FAN1_FAULT >> (f & 1));
 			}
-			in_index++;
+			index++;
 		}
 	}
 }
 
+static void pmbus_find_attributes(struct i2c_client *client,
+				  struct pmbus_data *data)
+{
+	/* Voltage sensors */
+	pmbus_add_sensor_attrs(client, data, "in", voltage_attributes,
+			       ARRAY_SIZE(voltage_attributes));
+
+	/* Current sensors */
+	pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
+			       ARRAY_SIZE(current_attributes));
+
+	/* Power sensors */
+	pmbus_add_sensor_attrs(client, data, "power", power_attributes,
+			       ARRAY_SIZE(power_attributes));
+
+	/* Temperature sensors */
+	pmbus_add_sensor_attrs(client, data, "temp", temp_attributes,
+			       ARRAY_SIZE(temp_attributes));
+
+	/* Fans */
+	pmbus_add_fan_attributes(client, data);
+}
+
 /*
  * Identify chip parameters.
  * This function is called for all chips.
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
