From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 15:41:35 +0000
Subject: [lm-sensors] [PATCH 10/15] hwmon: (pmbus) Add support for peak
Message-Id: <1310485300-2168-11-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Most PMBus devices provide manufacturer specific commands to read low and/or
high peak values for some or all of its sensors.

To support providing those values as lowest/highest attributes to the user,
introduce virtual PMBus commands. Those commands reside outside the normal
command set and have to be implemented in device specific code, which map the
virtual commands to device specific commands.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus.h      |   36 ++++++++++
 drivers/hwmon/pmbus/pmbus_core.c |  142 ++++++++++++++++++++++++++++++++++----
 2 files changed, 163 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d631cae..a7ad06c 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -126,6 +126,42 @@
 #define PMBUS_MFR_SERIAL		0x9E
 
 /*
+ * Virtual registers.
+ * Useful to support attributes which are not supported by standard PMBus
+ * registers but exist as manufacturer specific registers on individual chips.
+ * Must be mapped to real registers in device specific code.
+ *
+ * Semantics:
+ * Virtual registers are all word size.
+ * READ registers are read-only; writes are either ignored or return an error.
+ * RESET registers are read/write. Reading returns zero (used for detection),
+ * writing any value causes the associated history to be reset.
+ */
+#define PMBUS_VIRT_BASE			0x100
+#define PMBUS_VIRT_READ_TEMP_MIN	(PMBUS_VIRT_BASE + 0)
+#define PMBUS_VIRT_READ_TEMP_MAX	(PMBUS_VIRT_BASE + 1)
+#define PMBUS_VIRT_RESET_TEMP_HISTORY	(PMBUS_VIRT_BASE + 2)
+#define PMBUS_VIRT_READ_VIN_AVG		(PMBUS_VIRT_BASE + 3)
+#define PMBUS_VIRT_READ_VIN_MIN		(PMBUS_VIRT_BASE + 4)
+#define PMBUS_VIRT_READ_VIN_MAX		(PMBUS_VIRT_BASE + 5)
+#define PMBUS_VIRT_RESET_VIN_HISTORY	(PMBUS_VIRT_BASE + 6)
+#define PMBUS_VIRT_READ_IIN_AVG		(PMBUS_VIRT_BASE + 7)
+#define PMBUS_VIRT_READ_IIN_MIN		(PMBUS_VIRT_BASE + 8)
+#define PMBUS_VIRT_READ_IIN_MAX		(PMBUS_VIRT_BASE + 9)
+#define PMBUS_VIRT_RESET_IIN_HISTORY	(PMBUS_VIRT_BASE + 10)
+#define PMBUS_VIRT_READ_PIN_AVG		(PMBUS_VIRT_BASE + 11)
+#define PMBUS_VIRT_READ_PIN_MAX		(PMBUS_VIRT_BASE + 12)
+#define PMBUS_VIRT_RESET_PIN_HISTORY	(PMBUS_VIRT_BASE + 13)
+#define PMBUS_VIRT_READ_VOUT_AVG	(PMBUS_VIRT_BASE + 14)
+#define PMBUS_VIRT_READ_VOUT_MIN	(PMBUS_VIRT_BASE + 15)
+#define PMBUS_VIRT_READ_VOUT_MAX	(PMBUS_VIRT_BASE + 16)
+#define PMBUS_VIRT_RESET_VOUT_HISTORY	(PMBUS_VIRT_BASE + 17)
+#define PMBUS_VIRT_READ_IOUT_AVG	(PMBUS_VIRT_BASE + 18)
+#define PMBUS_VIRT_READ_IOUT_MIN	(PMBUS_VIRT_BASE + 19)
+#define PMBUS_VIRT_READ_IOUT_MAX	(PMBUS_VIRT_BASE + 20)
+#define PMBUS_VIRT_RESET_IOUT_HISTORY	(PMBUS_VIRT_BASE + 21)
+
+/*
  * CAPABILITY
  */
 #define PB_CAPABILITY_SMBALERT		(1<<4)
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index de32bcc..c4fb68c2 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -33,14 +33,18 @@
 /*
  * Constants needed to determine number of sensors, booleans, and labels.
  */
-#define PMBUS_MAX_INPUT_SENSORS		11	/* 6*volt, 3*curr, 2*power */
-#define PMBUS_VOUT_SENSORS_PER_PAGE	5	/* input, min, max, lcrit,
-						   crit */
-#define PMBUS_IOUT_SENSORS_PER_PAGE	4	/* input, min, max, crit */
+#define PMBUS_MAX_INPUT_SENSORS		22	/* 10*volt, 7*curr, 5*power */
+#define PMBUS_VOUT_SENSORS_PER_PAGE	9	/* input, min, max, lcrit,
+						   crit, lowest, highest, avg,
+						   reset */
+#define PMBUS_IOUT_SENSORS_PER_PAGE	8	/* input, min, max, crit,
+						   lowest, highest, avg,
+						   reset */
 #define PMBUS_POUT_SENSORS_PER_PAGE	4	/* input, cap, max, crit */
 #define PMBUS_MAX_SENSORS_PER_FAN	1	/* input */
-#define PMBUS_MAX_SENSORS_PER_TEMP	5	/* input, min, max, lcrit,
-						   crit */
+#define PMBUS_MAX_SENSORS_PER_TEMP	8	/* input, min, max, lcrit,
+						   crit, lowest, highest,
+						   reset */
 
 #define PMBUS_MAX_INPUT_BOOLEANS	7	/* v: min_alarm, max_alarm,
 						   lcrit_alarm, crit_alarm;
@@ -80,7 +84,7 @@ struct pmbus_sensor {
 	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
 	struct sensor_device_attribute attribute;
 	u8 page;		/* page number */
-	u8 reg;			/* register */
+	u16 reg;		/* register */
 	enum pmbus_sensor_classes class;	/* sensor class */
 	bool update;		/* runtime sensor update needed */
 	int data;		/* Sensor data.
@@ -235,6 +239,8 @@ static int _pmbus_read_word_data(struct i2c_client *client, int page, int reg)
 		if (status != -ENODATA)
 			return status;
 	}
+	if (reg >= PMBUS_VIRT_BASE)
+		return -EINVAL;
 	return pmbus_read_word_data(client, page, reg);
 }
 
@@ -314,7 +320,7 @@ bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
 	int rv;
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
-	rv = pmbus_read_word_data(client, page, reg);
+	rv = _pmbus_read_word_data(client, page, reg);
 	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
 		rv = pmbus_check_status_cml(client, page);
 	pmbus_clear_fault_page(client, page);
@@ -947,7 +953,8 @@ static void pmbus_find_max_attr(struct i2c_client *client,
  * and its associated alarm attribute.
  */
 struct pmbus_limit_attr {
-	u8 reg;			/* Limit register */
+	u16 reg;		/* Limit register */
+	bool update;		/* True if register needs updates */
 	const char *attr;	/* Attribute name */
 	const char *alarm;	/* Alarm attribute name */
 	u32 sbit;		/* Alarm attribute status bit */
@@ -992,9 +999,10 @@ static bool pmbus_add_limit_attrs(struct i2c_client *client,
 		if (pmbus_check_word_register(client, page, l->reg)) {
 			cindex = data->num_sensors;
 			pmbus_add_sensor(data, name, l->attr, index, page,
-					 l->reg, attr->class, attr->update,
+					 l->reg, attr->class,
+					 attr->update || l->update,
 					 false);
-			if (info->func[page] & attr->sfunc) {
+			if (l->sbit && (info->func[page] & attr->sfunc)) {
 				if (attr->compare) {
 					pmbus_add_boolean_cmp(data, name,
 						l->alarm, index,
@@ -1090,6 +1098,21 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
 		.attr = "crit",
 		.alarm = "crit_alarm",
 		.sbit = PB_VOLTAGE_OV_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_VIN_AVG,
+		.update = true,
+		.attr = "average",
+	}, {
+		.reg = PMBUS_VIRT_READ_VIN_MIN,
+		.update = true,
+		.attr = "lowest",
+	}, {
+		.reg = PMBUS_VIRT_READ_VIN_MAX,
+		.update = true,
+		.attr = "highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_VIN_HISTORY,
+		.attr = "reset_history",
 	},
 };
 
@@ -1114,6 +1137,21 @@ static const struct pmbus_limit_attr vout_limit_attrs[] = {
 		.attr = "crit",
 		.alarm = "crit_alarm",
 		.sbit = PB_VOLTAGE_OV_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_VOUT_AVG,
+		.update = true,
+		.attr = "average",
+	}, {
+		.reg = PMBUS_VIRT_READ_VOUT_MIN,
+		.update = true,
+		.attr = "lowest",
+	}, {
+		.reg = PMBUS_VIRT_READ_VOUT_MAX,
+		.update = true,
+		.attr = "highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_VOUT_HISTORY,
+		.attr = "reset_history",
 	}
 };
 
@@ -1160,6 +1198,21 @@ static const struct pmbus_limit_attr iin_limit_attrs[] = {
 		.attr = "crit",
 		.alarm = "crit_alarm",
 		.sbit = PB_IIN_OC_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_IIN_AVG,
+		.update = true,
+		.attr = "average",
+	}, {
+		.reg = PMBUS_VIRT_READ_IIN_MIN,
+		.update = true,
+		.attr = "lowest",
+	}, {
+		.reg = PMBUS_VIRT_READ_IIN_MAX,
+		.update = true,
+		.attr = "highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_IIN_HISTORY,
+		.attr = "reset_history",
 	}
 };
 
@@ -1179,6 +1232,21 @@ static const struct pmbus_limit_attr iout_limit_attrs[] = {
 		.attr = "crit",
 		.alarm = "crit_alarm",
 		.sbit = PB_IOUT_OC_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_IOUT_AVG,
+		.update = true,
+		.attr = "average",
+	}, {
+		.reg = PMBUS_VIRT_READ_IOUT_MIN,
+		.update = true,
+		.attr = "lowest",
+	}, {
+		.reg = PMBUS_VIRT_READ_IOUT_MAX,
+		.update = true,
+		.attr = "highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_IOUT_HISTORY,
+		.attr = "reset_history",
 	}
 };
 
@@ -1214,6 +1282,17 @@ static const struct pmbus_limit_attr pin_limit_attrs[] = {
 		.attr = "max",
 		.alarm = "alarm",
 		.sbit = PB_PIN_OP_WARNING,
+	}, {
+		.reg = PMBUS_VIRT_READ_PIN_AVG,
+		.update = true,
+		.attr = "average",
+	}, {
+		.reg = PMBUS_VIRT_READ_PIN_MAX,
+		.update = true,
+		.attr = "input_highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_PIN_HISTORY,
+		.attr = "reset_history",
 	}
 };
 
@@ -1282,6 +1361,39 @@ static const struct pmbus_limit_attr temp_limit_attrs[] = {
 		.attr = "crit",
 		.alarm = "crit_alarm",
 		.sbit = PB_TEMP_OT_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_TEMP_MIN,
+		.attr = "lowest",
+	}, {
+		.reg = PMBUS_VIRT_READ_TEMP_MAX,
+		.attr = "highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_TEMP_HISTORY,
+		.attr = "reset_history",
+	}
+};
+
+static const struct pmbus_limit_attr temp_limit_attrs23[] = {
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
 	}
 };
 
@@ -1308,8 +1420,8 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 		.sfunc = PMBUS_HAVE_STATUS_TEMP,
 		.sbase = PB_STATUS_TEMP_BASE,
 		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+		.limit = temp_limit_attrs23,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs23),
 	}, {
 		.reg = PMBUS_READ_TEMPERATURE_3,
 		.class = PSC_TEMPERATURE,
@@ -1320,8 +1432,8 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 		.sfunc = PMBUS_HAVE_STATUS_TEMP,
 		.sbase = PB_STATUS_TEMP_BASE,
 		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+		.limit = temp_limit_attrs23,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs23),
 	}
 };
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
