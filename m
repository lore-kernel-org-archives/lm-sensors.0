From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:44 +0000
Subject: [lm-sensors] [PATCH 10/13] hwmon: (pmbus/zl6100) Add support for VMON/VDRV
Message-Id: <1359253067-11644-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some of the ZL6100 compatible chips support monitoring a separate voltage pin,
VMON (ZL2004) or VDRV (ZL91xx). Report it as in2 / vmon.

The chips support implicit warning limits for VMON/VDRV, as percentage of the
respective critical voltage. Support by reading/writing the critical voltages
and calculating the associated warning voltages.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/zl6100   |   26 +++++--
 drivers/hwmon/pmbus/zl6100.c |  176 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 188 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index a995b41..3d924b6 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -121,12 +121,26 @@ in1_max_alarm		Input voltage high alarm.
 in1_lcrit_alarm		Input voltage critical low alarm.
 in1_crit_alarm		Input voltage critical high alarm.
 
-in2_label		"vout1"
-in2_input		Measured output voltage.
-in2_lcrit		Critical minimum output Voltage.
-in2_crit		Critical maximum output voltage.
-in2_lcrit_alarm		Critical output voltage critical low alarm.
-in2_crit_alarm		Critical output voltage critical high alarm.
+in2_label		"vmon"
+in2_input		Measured voltage on VMON (ZL2004) or VDRV (ZL9101M,
+			ZL9117M) pin. Reported voltage is 16x the voltage on the
+			pin (adjusted internally by the chip).
+in2_lcrit		Critical minumum VMON/VDRV Voltage.
+in2_crit		Critical maximum VMON/VDRV voltage.
+in2_lcrit_alarm		VMON/VDRV voltage critical low alarm.
+in2_crit_alarm		VMON/VDRV voltage critical high alarm.
+
+			vmon attributes are supported on ZL2004, ZL9101M,
+			and ZL9117M only.
+
+inX_label		"vout1"
+inX_input		Measured output voltage.
+inX_lcrit		Critical minimum output Voltage.
+inX_crit		Critical maximum output voltage.
+inX_lcrit_alarm		Critical output voltage critical low alarm.
+inX_crit_alarm		Critical output voltage critical high alarm.
+
+			X is 3 for ZL2004, ZL9101M, and ZL9117M, 2 otherwise.
 
 curr1_label		"iout1"
 curr1_input		Measured output current.
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index fc5eed8..8196441 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -2,6 +2,7 @@
  * Hardware monitoring driver for ZL6100 and compatibles
  *
  * Copyright (c) 2011 Ericsson AB.
+ * Copyright (c) 2012 Guenter Roeck
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -45,12 +46,87 @@ struct zl6100_data {
 
 #define ZL6100_MFR_XTEMP_ENABLE		(1 << 7)
 
+#define MFR_VMON_OV_FAULT_LIMIT		0xf5
+#define MFR_VMON_UV_FAULT_LIMIT		0xf6
+#define MFR_READ_VMON			0xf7
+
+#define VMON_UV_WARNING			(1 << 5)
+#define VMON_OV_WARNING			(1 << 4)
+#define VMON_UV_FAULT			(1 << 1)
+#define VMON_OV_FAULT			(1 << 0)
+
 #define ZL6100_WAIT_TIME		1000	/* uS	*/
 
 static ushort delay = ZL6100_WAIT_TIME;
 module_param(delay, ushort, 0644);
 MODULE_PARM_DESC(delay, "Delay between chip accesses in uS");
 
+/* Convert linear sensor value to milli-units */
+static long zl6100_l2d(s16 l)
+{
+	s16 exponent;
+	s32 mantissa;
+	long val;
+
+	exponent = l >> 11;
+	mantissa = ((s16)((l & 0x7ff) << 5)) >> 5;
+
+	val = mantissa;
+
+	/* scale result to milli-units */
+	val = val * 1000L;
+
+	if (exponent >= 0)
+		val <<= exponent;
+	else
+		val >>= -exponent;
+
+	return val;
+}
+
+#define MAX_MANTISSA	(1023 * 1000)
+#define MIN_MANTISSA	(511 * 1000)
+
+static u16 zl6100_d2l(long val)
+{
+	s16 exponent = 0, mantissa;
+	bool negative = false;
+
+	/* simple case */
+	if (val = 0)
+		return 0;
+
+	if (val < 0) {
+		negative = true;
+		val = -val;
+	}
+
+	/* Reduce large mantissa until it fits into 10 bit */
+	while (val >= MAX_MANTISSA && exponent < 15) {
+		exponent++;
+		val >>= 1;
+	}
+	/* Increase small mantissa to improve precision */
+	while (val < MIN_MANTISSA && exponent > -15) {
+		exponent--;
+		val <<= 1;
+	}
+
+	/* Convert mantissa from milli-units to units */
+	mantissa = DIV_ROUND_CLOSEST(val, 1000);
+
+	/* Ensure that resulting number is within range */
+	if (mantissa > 0x3ff)
+		mantissa = 0x3ff;
+
+	/* restore sign */
+	if (negative)
+		mantissa = -mantissa;
+
+	/* Convert to 5 bit exponent, 11 bit mantissa */
+	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
+}
+
 /* Some chips need a delay between accesses */
 static inline void zl6100_wait(const struct zl6100_data *data)
 {
@@ -65,9 +141,9 @@ static int zl6100_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct zl6100_data *data = to_zl6100_data(info);
-	int ret;
+	int ret, vreg;
 
-	if (page || reg >= PMBUS_VIRT_BASE)
+	if (page > 0)
 		return -ENXIO;
 
 	if (data->id = zl2005) {
@@ -83,9 +159,39 @@ static int zl6100_read_word_data(struct i2c_client *client, int page, int reg)
 		}
 	}
 
+	switch (reg) {
+	case PMBUS_VIRT_READ_VMON:
+		vreg = MFR_READ_VMON;
+		break;
+	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
+	case PMBUS_VIRT_VMON_OV_FAULT_LIMIT:
+		vreg = MFR_VMON_OV_FAULT_LIMIT;
+		break;
+	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
+	case PMBUS_VIRT_VMON_UV_FAULT_LIMIT:
+		vreg = MFR_VMON_UV_FAULT_LIMIT;
+		break;
+	default:
+		if (reg >= PMBUS_VIRT_BASE)
+			return -ENXIO;
+		vreg = reg;
+		break;
+	}
+
 	zl6100_wait(data);
-	ret = pmbus_read_word_data(client, page, reg);
+	ret = pmbus_read_word_data(client, page, vreg);
 	data->access = ktime_get();
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
+		ret = zl6100_d2l(DIV_ROUND_CLOSEST(zl6100_l2d(ret) * 9, 10));
+		break;
+	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
+		ret = zl6100_d2l(DIV_ROUND_CLOSEST(zl6100_l2d(ret) * 11, 10));
+		break;
+	}
 
 	return ret;
 }
@@ -94,13 +200,35 @@ static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct zl6100_data *data = to_zl6100_data(info);
-	int ret;
+	int ret, status;
 
 	if (page > 0)
 		return -ENXIO;
 
 	zl6100_wait(data);
-	ret = pmbus_read_byte_data(client, page, reg);
+
+	switch (reg) {
+	case PMBUS_VIRT_STATUS_VMON:
+		ret = pmbus_read_byte_data(client, 0,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (ret < 0)
+			break;
+
+		status = 0;
+		if (ret & VMON_UV_WARNING)
+			status |= PB_VOLTAGE_UV_WARNING;
+		if (ret & VMON_OV_WARNING)
+			status |= PB_VOLTAGE_OV_WARNING;
+		if (ret & VMON_UV_FAULT)
+			status |= PB_VOLTAGE_UV_FAULT;
+		if (ret & VMON_OV_FAULT)
+			status |= PB_VOLTAGE_OV_FAULT;
+		ret = status;
+		break;
+	default:
+		ret = pmbus_read_byte_data(client, page, reg);
+		break;
+	}
 	data->access = ktime_get();
 
 	return ret;
@@ -111,13 +239,38 @@ static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct zl6100_data *data = to_zl6100_data(info);
-	int ret;
+	int ret, vreg;
 
-	if (page || reg >= PMBUS_VIRT_BASE)
+	if (page > 0)
 		return -ENXIO;
 
+	switch (reg) {
+	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
+		word = zl6100_d2l(DIV_ROUND_CLOSEST(zl6100_l2d(word) * 10, 9));
+		vreg = MFR_VMON_OV_FAULT_LIMIT;
+		pmbus_clear_cache(client);
+		break;
+	case PMBUS_VIRT_VMON_OV_FAULT_LIMIT:
+		vreg = MFR_VMON_OV_FAULT_LIMIT;
+		pmbus_clear_cache(client);
+		break;
+	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
+		word = zl6100_d2l(DIV_ROUND_CLOSEST(zl6100_l2d(word) * 10, 11));
+		vreg = MFR_VMON_UV_FAULT_LIMIT;
+		pmbus_clear_cache(client);
+		break;
+	case PMBUS_VIRT_VMON_UV_FAULT_LIMIT:
+		vreg = MFR_VMON_UV_FAULT_LIMIT;
+		pmbus_clear_cache(client);
+		break;
+	default:
+		if (reg >= PMBUS_VIRT_BASE)
+			return -ENXIO;
+		vreg = reg;
+	}
+
 	zl6100_wait(data);
-	ret = pmbus_write_word_data(client, page, reg, word);
+	ret = pmbus_write_word_data(client, page, vreg, word);
 	data->access = ktime_get();
 
 	return ret;
@@ -225,6 +378,13 @@ static int zl6100_probe(struct i2c_client *client,
 	  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
 	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
+	/*
+	 * ZL2004, ZL9101M, and ZL9117M support monitoring an extra voltage
+	 * (VMON for ZL2004, VDRV for ZL9101M and ZL9117M). Report it as vmon.
+	 */
+	if (data->id = zl2004 || data->id = zl9101 || data->id = zl9117)
+		info->func[0] |= PMBUS_HAVE_VMON | PMBUS_HAVE_STATUS_VMON;
+
 	ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
 	if (ret < 0)
 		return ret;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
