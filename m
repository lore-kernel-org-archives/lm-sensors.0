From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Aug 2015 23:24:28 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (pmbus) Add support for MAX20751
Message-Id: <1438903468-5998-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MAX20751 is a multiphase power controller with internal buck converter.
It uses VR12.0 to report the output voltage. This requires an explicit
driver, since the VR version can not be auto-detected.

The chip supports a manufacturer specific command to fine-tune the output
voltage.  This command is not currently supported.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/max20751   | 77 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |  7 ++++
 drivers/hwmon/pmbus/Kconfig    | 10 ++++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/max20751.c | 64 +++++++++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 Documentation/hwmon/max20751
 create mode 100644 drivers/hwmon/pmbus/max20751.c

diff --git a/Documentation/hwmon/max20751 b/Documentation/hwmon/max20751
new file mode 100644
index 000000000000..f9fa25ebb521
--- /dev/null
+++ b/Documentation/hwmon/max20751
@@ -0,0 +1,77 @@
+Kernel driver max20751
+===========
+
+Supported chips:
+  * maxim MAX20751
+    Prefix: 'max20751'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX20751.pdf
+    Application note: http://pdfserv.maximintegrated.com/en/an/AN5941.pdf
+
+Author: Guenter Roeck <linux@roeck-us.net>
+
+
+Description
+-----------
+
+This driver supports MAX20751 Multiphase Master with PMBus Interface
+and Internal Buck Converter.
+
+The driver is a client driver to the core PMBus driver.
+Please see Documentation/hwmon/pmbus for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported.
+
+in1_label		"vin1"
+in1_input		Measured voltage.
+in1_min			Minimum input voltage.
+in1_max			Maximum input voltage.
+in1_lcrit		Critical minimum input voltage.
+in1_crit		Critical maximum input voltage.
+in1_min_alarm		Input voltage low alarm.
+in1_lcrit_alarm		Input voltage critical low alarm.
+in1_min_alarm		Input voltage low alarm.
+in1_max_alarm		Input voltage high alarm.
+
+in2_label		"vout1"
+in2_input		Measured voltage.
+in2_min			Minimum output voltage.
+in2_max			Maximum output voltage.
+in2_lcrit		Critical minimum output voltage.
+in2_crit		Critical maximum output voltage.
+in2_min_alarm		Output voltage low alarm.
+in2_lcrit_alarm		Output voltage critical low alarm.
+in2_min_alarm		Output voltage low alarm.
+in2_max_alarm		Output voltage high alarm.
+
+curr1_input		Measured output current.
+curr1_label		"iout1"
+curr1_max		Maximum output current.
+curr1_alarm		Current high alarm.
+
+temp1_input		Measured temperature.
+temp1_max		Maximum temperature.
+temp1_crit		Critical high temperature.
+temp1_max_alarm		Chip temperature high alarm.
+temp1_crit_alarm	Chip temperature critical high alarm.
+
+power1_input		Output power.
+power1_label		"pout1"
diff --git a/MAINTAINERS b/MAINTAINERS
index a9ae6c105520..6a406b607eeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6539,6 +6539,13 @@ S:	Maintained
 F:	Documentation/hwmon/max16065
 F:	drivers/hwmon/max16065.c
 
+MAX20751 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/max20751
+F:	drivers/hwmon/max20751.c
+
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	"Hans J. Koch" <hjk@hansjkoch.de>
 L:	lm-sensors@lm-sensors.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 0efde1358d83..6bac0ef32d61 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -74,6 +74,16 @@ config SENSORS_MAX16064
 	  This driver can also be built as a module. If so, the module will
 	  be called max16064.
 
+config SENSORS_MAX20751
+	tristate "Maxim MAX20751"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Maxim
+	  MAX20751.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called max20751.
+
 config SENSORS_MAX34440
 	tristate "Maxim MAX34440 and compatibles"
 	default n
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 1454293e985c..bce046d37f02 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
 obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
+obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
diff --git a/drivers/hwmon/pmbus/max20751.c b/drivers/hwmon/pmbus/max20751.c
new file mode 100644
index 000000000000..ab74aeae8cf2
--- /dev/null
+++ b/drivers/hwmon/pmbus/max20751.c
@@ -0,0 +1,64 @@
+/*
+ * Hardware monitoring driver for Maxim MAX20751
+ *
+ * Copyright (c) 2015 Guenter Roeck
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+static struct pmbus_driver_info max20751_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = vid,
+	.vrm_version = vr12,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+		PMBUS_HAVE_POUT,
+};
+
+static int max20751_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &max20751_info);
+}
+
+static const struct i2c_device_id max20751_id[] = {
+	{"max20751", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, max20751_id);
+
+static struct i2c_driver max20751_driver = {
+	.driver = {
+		   .name = "max20751",
+		   },
+	.probe = max20751_probe,
+	.remove = pmbus_do_remove,
+	.id_table = max20751_id,
+};
+
+module_i2c_driver(max20751_driver);
+
+MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
+MODULE_DESCRIPTION("PMBus driver for Maxim MAX20751");
+MODULE_LICENSE("GPL");
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
