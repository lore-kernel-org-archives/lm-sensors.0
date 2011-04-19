From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Apr 2011 15:59:44 +0000
Subject: [lm-sensors] [PATCH v2 6/6] hwmon: (pmbus) Add support for Analog
Message-Id: <1303228784-17909-7-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for Analog Devices ADM1275 Hot-Swap Controller and Digital Power
Monitor

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Tom Grennan <tom.grennan@ericsson.com>
---
v2: Added driver documentation

 Documentation/hwmon/adm1275 |   60 +++++++++++++++++++++
 drivers/hwmon/Kconfig       |   10 ++++
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/adm1275.c     |  121 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/adm1275
 create mode 100644 drivers/hwmon/adm1275.c

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
new file mode 100644
index 0000000..2b88c99
--- /dev/null
+++ b/Documentation/hwmon/adm1275
@@ -0,0 +1,60 @@
+Kernel driver adm1275
+==========+
+Supported chips:
+  * Analog Devices ADM1275
+    Prefix: 'adm1275'
+    Addresses scanned: -
+    Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1275.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for Analog Devices ADM1275 Hot-Swap
+Controller and Digital Power Monitor.
+
+The ADM1275 is a hot-swap controller that allows a circuit board to be removed
+from or inserted into a live backplane. It also features current and voltage
+readback via an integrated 12-bit analog-to-digital converter (ADC), accessed
+using a PMBus. interface.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus for details on PMBus client drivers.
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
+The driver supports standard PMBus driver platform data. Please see
+Documentation/hwmon/pmbus for details.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write; all other
+attributes are read-only.
+
+in1_label		"vin1" or "vout1" depending on chip variant and
+			configuration.
+in1_input		Measured voltage. From READ_VOUT register.
+in1_min			Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
+in1_max			Maximum voltage. From VOUT_OV_WARN_LIMIT register.
+in1_min_alarm		Voltage low alarm. From VOLTAGE_UV_WARNING status.
+in1_max_alarm		Voltage high alarm. From VOLTAGE_OV_WARNING status.
+
+curr1_label		"iout1"
+curr1_input		Measured current. From READ_IOUT register.
+curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
+curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c3476cd..b518a56 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -801,6 +801,16 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ADM1275
+	tristate "Analog Devices ADM1275"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices ADM1275 Hot-Swap Controller and Digital Power Monitor.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called adm1275.
+
 config SENSORS_MAX16064
 	tristate "Maxim MAX16064"
 	default n
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 19bc8fd..efc199e 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 # PMBus drivers
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
diff --git a/drivers/hwmon/adm1275.c b/drivers/hwmon/adm1275.c
new file mode 100644
index 0000000..c2ee204
--- /dev/null
+++ b/drivers/hwmon/adm1275.c
@@ -0,0 +1,121 @@
+/*
+ * Hardware monitoring driver for Analog Devices ADM1275 Hot-Swap Controller
+ * and Digital Power Monitor
+ *
+ * Copyright (c) 2011 Ericsson AB.
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
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+#define ADM1275_PMON_CONFIG		0xd4
+
+#define ADM1275_VIN_VOUT_SELECT		(1 << 6)
+#define ADM1275_VRANGE			(1 << 5)
+
+static int adm1275_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	int config;
+	struct pmbus_driver_info *info;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		return -ENODEV;
+
+	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+	if (config < 0)
+		return config;
+
+	info->pages = 1;
+	info->direct[PSC_VOLTAGE_IN] = true;
+	info->direct[PSC_VOLTAGE_OUT] = true;
+	info->direct[PSC_CURRENT_OUT] = true;
+	info->m[PSC_CURRENT_OUT] = 800;
+	info->b[PSC_CURRENT_OUT] = 20475;
+	info->R[PSC_CURRENT_OUT] = -1;
+	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+
+	if (config & ADM1275_VRANGE) {
+		info->m[PSC_VOLTAGE_IN] = 19045;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -2;
+		info->m[PSC_VOLTAGE_OUT] = 19045;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -2;
+	} else {
+		info->m[PSC_VOLTAGE_IN] = 6666;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -1;
+		info->m[PSC_VOLTAGE_OUT] = 6666;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -1;
+	}
+
+	if (config & ADM1275_VIN_VOUT_SELECT)
+		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+	else
+		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
+
+	return pmbus_do_probe(client, id, info);
+}
+
+static int adm1275_remove(struct i2c_client *client)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	int ret;
+
+	ret = pmbus_do_remove(client);
+	kfree(info);
+	return ret;
+}
+
+static const struct i2c_device_id adm1275_id[] = {
+	{"adm1275", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1275_id);
+
+static struct i2c_driver adm1275_driver = {
+	.driver = {
+		   .name = "adm1275",
+		   },
+	.probe = adm1275_probe,
+	.remove = adm1275_remove,
+	.id_table = adm1275_id,
+};
+
+static int __init adm1275_init(void)
+{
+	return i2c_add_driver(&adm1275_driver);
+}
+
+static void __exit adm1275_exit(void)
+{
+	i2c_del_driver(&adm1275_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1275");
+MODULE_LICENSE("GPL");
+module_init(adm1275_init);
+module_exit(adm1275_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
