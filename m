From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:42 +0000
Subject: [lm-sensors] [PATCH 08/13] hwmon: (pmbus) Add support for additional voltage sensor
Message-Id: <1359253067-11644-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some PMBus chips support monitoring an additional non-standard voltage. While
this voltage can in many cases be supported by simulating an additional sensor
page, this does not work in all cases. Specifically, it is problematic if the
data format is linear and the voltage is reported in LINEAR11 format. Since
output voltages use LINEAR16, and the exponent for LINEAR16 data is chip-wide
and fixed, this can result in overflows.

To solve this problem, add support for an additional virtual input voltage,
call it 'vmon', and treat this voltage as input voltage (which, when the chip
supports linear data format, uses LINEAR11).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.h      |   10 +++++++
 drivers/hwmon/pmbus/pmbus_core.c |   54 +++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 3fe03dc..164d177 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -2,6 +2,7 @@
  * pmbus.h - Common defines and structures for PMBus devices
  *
  * Copyright (c) 2010, 2011 Ericsson AB.
+ * Copyright (c) 2012 Guenter Roeck
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -177,6 +178,13 @@
 #define PMBUS_VIRT_READ_TEMP2_MAX	(PMBUS_VIRT_BASE + 28)
 #define PMBUS_VIRT_RESET_TEMP2_HISTORY	(PMBUS_VIRT_BASE + 29)
 
+#define PMBUS_VIRT_READ_VMON		(PMBUS_VIRT_BASE + 30)
+#define PMBUS_VIRT_VMON_UV_WARN_LIMIT	(PMBUS_VIRT_BASE + 31)
+#define PMBUS_VIRT_VMON_OV_WARN_LIMIT	(PMBUS_VIRT_BASE + 32)
+#define PMBUS_VIRT_VMON_UV_FAULT_LIMIT	(PMBUS_VIRT_BASE + 33)
+#define PMBUS_VIRT_VMON_OV_FAULT_LIMIT	(PMBUS_VIRT_BASE + 34)
+#define PMBUS_VIRT_STATUS_VMON		(PMBUS_VIRT_BASE + 35)
+
 /*
  * CAPABILITY
  */
@@ -317,6 +325,8 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_STATUS_TEMP	(1 << 15)
 #define PMBUS_HAVE_STATUS_FAN12	(1 << 16)
 #define PMBUS_HAVE_STATUS_FAN34	(1 << 17)
+#define PMBUS_HAVE_VMON		(1 << 18)
+#define PMBUS_HAVE_STATUS_VMON	(1 << 19)
 
 enum pmbus_data_format { linear = 0, direct, vid };
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 26b699a..3b5c24d 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2,6 +2,7 @@
  * Hardware monitoring driver for PMBus devices
  *
  * Copyright (c) 2010, 2011 Ericsson AB.
+ * Copyright (c) 2012 Guenter Roeck
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -37,12 +38,6 @@
 #define PMBUS_ATTR_ALLOC_SIZE	32
 
 /*
- * status, status_vout, status_iout, status_fans, status_fan34, and status_temp
- * are paged. status_input is unpaged.
- */
-#define PB_NUM_STATUS_REG	(PMBUS_PAGES * 6 + 1)
-
-/*
  * Index into status register array, per status register group
  */
 #define PB_STATUS_BASE		0
@@ -50,8 +45,11 @@
 #define PB_STATUS_IOUT_BASE	(PB_STATUS_VOUT_BASE + PMBUS_PAGES)
 #define PB_STATUS_FAN_BASE	(PB_STATUS_IOUT_BASE + PMBUS_PAGES)
 #define PB_STATUS_FAN34_BASE	(PB_STATUS_FAN_BASE + PMBUS_PAGES)
-#define PB_STATUS_INPUT_BASE	(PB_STATUS_FAN34_BASE + PMBUS_PAGES)
-#define PB_STATUS_TEMP_BASE	(PB_STATUS_INPUT_BASE + 1)
+#define PB_STATUS_TEMP_BASE	(PB_STATUS_FAN34_BASE + PMBUS_PAGES)
+#define PB_STATUS_INPUT_BASE	(PB_STATUS_TEMP_BASE + PMBUS_PAGES)
+#define PB_STATUS_VMON_BASE	(PB_STATUS_INPUT_BASE + 1)
+
+#define PB_NUM_STATUS_REG	(PB_STATUS_VMON_BASE + 1)
 
 #define PMBUS_NAME_SIZE		24
 
@@ -379,6 +377,11 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 			  = _pmbus_read_byte_data(client, 0,
 						  PMBUS_STATUS_INPUT);
 
+		if (info->func[0] & PMBUS_HAVE_STATUS_VMON)
+			data->status[PB_STATUS_VMON_BASE]
+			  = _pmbus_read_byte_data(client, 0,
+						  PMBUS_VIRT_STATUS_VMON);
+
 		for (sensor = data->sensors; sensor; sensor = sensor->next) {
 			if (!data->valid || sensor->update)
 				sensor->data
@@ -913,7 +916,7 @@ struct pmbus_limit_attr {
  * description includes a reference to the associated limit attributes.
  */
 struct pmbus_sensor_attr {
-	u8 reg;				/* sensor register */
+	u16 reg;			/* sensor register */
 	enum pmbus_sensor_classes class;/* sensor class */
 	const char *label;		/* sensor label */
 	bool paged;			/* true if paged sensor */
@@ -1085,6 +1088,30 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
 	},
 };
 
+static const struct pmbus_limit_attr vmon_limit_attrs[] = {
+	{
+		.reg = PMBUS_VIRT_VMON_UV_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_VOLTAGE_UV_WARNING,
+	}, {
+		.reg = PMBUS_VIRT_VMON_UV_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_VOLTAGE_UV_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_VMON_OV_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_VOLTAGE_OV_WARNING,
+	}, {
+		.reg = PMBUS_VIRT_VMON_OV_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_VOLTAGE_OV_FAULT,
+	}
+};
+
 static const struct pmbus_limit_attr vout_limit_attrs[] = {
 	{
 		.reg = PMBUS_VOUT_UV_WARN_LIMIT,
@@ -1136,6 +1163,15 @@ static const struct pmbus_sensor_attr voltage_attributes[] = {
 		.limit = vin_limit_attrs,
 		.nlimit = ARRAY_SIZE(vin_limit_attrs),
 	}, {
+		.reg = PMBUS_VIRT_READ_VMON,
+		.class = PSC_VOLTAGE_IN,
+		.label = "vmon",
+		.func = PMBUS_HAVE_VMON,
+		.sfunc = PMBUS_HAVE_STATUS_VMON,
+		.sbase = PB_STATUS_VMON_BASE,
+		.limit = vmon_limit_attrs,
+		.nlimit = ARRAY_SIZE(vmon_limit_attrs),
+	}, {
 		.reg = PMBUS_READ_VCAP,
 		.class = PSC_VOLTAGE_IN,
 		.label = "vcap",
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
