From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Apr 2011 15:59:42 +0000
Subject: [lm-sensors] [PATCH v2 4/6] hwmon: (pmbus) Add support for TI
Message-Id: <1303228784-17909-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds hardware monitoring support for TI UCD9220, UCD9222, UCD9224,
UCD9240, UCD9244, UCD9246, and UCD9248 Digital PWM System Controllers.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Tom Grennan <tom.grennan@ericsson.com>
---
v2: Added driver documentation

 Documentation/hwmon/ucd9200 |  112 +++++++++++++++++++++++
 drivers/hwmon/Kconfig       |   10 ++
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/ucd9200.c     |  210 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ucd9200
 create mode 100644 drivers/hwmon/ucd9200.c

diff --git a/Documentation/hwmon/ucd9200 b/Documentation/hwmon/ucd9200
new file mode 100644
index 0000000..3c58607
--- /dev/null
+++ b/Documentation/hwmon/ucd9200
@@ -0,0 +1,112 @@
+Kernel driver ucd9200
+==========+
+Supported chips:
+  * TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
+    Prefixes: 'ucd9220', 'ucd9222', 'ucd9224', 'ucd9240', 'ucd9244', 'ucd9246',
+	'ucd9248'
+    Addresses scanned: -
+    Datasheets:
+	http://focus.ti.com/lit/ds/symlink/ucd9220.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9222.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9224.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9240.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9244.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9246.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9248.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+[From datasheets] UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and
+UCD9248 are multi-rail, multi-phase synchronous buck digital PWM controllers
+designed for non-isolated DC/DC power applications. The devices integrate
+dedicated circuitry for DC/DC loop management with flash memory and a serial
+interface to support configuration, monitoring and management.
+
+This driver is a client driver to the core PMBus driver. Please see
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
+in1_label		"vin".
+in1_input		Measured voltage. From READ_VIN register.
+in1_min			Minumum Voltage. From VIN_UV_WARN_LIMIT register.
+in1_max			Maximum voltage. From VIN_OV_WARN_LIMIT register.
+in1_lcrit		Critical minumum Voltage. VIN_UV_FAULT_LIMIT register.
+in1_crit		Critical maximum voltage. From VIN_OV_FAULT_LIMIT register.
+in1_min_alarm		Voltage low alarm. From VIN_UV_WARNING status.
+in1_max_alarm		Voltage high alarm. From VIN_OV_WARNING status.
+in1_lcrit_alarm		Voltage critical low alarm. From VIN_UV_FAULT status.
+in1_crit_alarm		Voltage critical high alarm. From VIN_OV_FAULT status.
+
+in[2-5]_label		"vout[1-4]".
+in[2-5]_input		Measured voltage. From READ_VOUT register.
+in[2-5]_min		Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
+in[2-5]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
+in[2-5]_lcrit		Critical minumum Voltage. VOUT_UV_FAULT_LIMIT register.
+in[2-5]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[2-5]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
+in[2-5]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
+in[2-5]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
+in[2-5]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+
+curr1_label		"iin".
+curr1_input		Measured current. From READ_IIN register.
+
+curr[2-5]_label		"iout[1-4]".
+curr[2-5]_input		Measured current. From READ_IOUT register.
+curr[2-5]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
+curr[2-5]_lcrit		Critical minumum output current. From IOUT_UC_FAULT_LIMIT
+			register.
+curr[2-5]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr[2-5]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
+curr[2-5]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
+
+power1_input		Measured input power. From READ_PIN register.
+power1_label		"pin"
+
+power[2-5]_input	Measured output power. From READ_POUT register.
+power[2-5]_label	"pout[1-4]"
+
+			The number of output voltage, current, and power
+			attribute sets is determined by the number of enabled
+			rails. See chip datasheets for details.
+
+temp[1-5]_input		Measured temperatures. From READ_TEMPERATURE_1 and
+		        READ_TEMPERATURE_2 registers.
+			temp1 is the chip internal temperature. temp[2-5] are
+			rail temperatures.  temp[2-5] attributes are only
+			created for enabled rails. See chip datasheets for
+			details.
+temp[1-5]_max		Maximum temperature. From OT_WARN_LIMIT register.
+temp[1-5]_crit		Critical high temperature. From OT_FAULT_LIMIT register.
+temp[1-5]_max_alarm	Temperature high alarm.
+temp[1-5]_crit_alarm	Temperature critical high alarm.
+
+fan1_input		Fan RPM. ucd9240 only.
+fan1_alarm		Fan alarm. ucd9240 only.
+fan1_fault		Fan fault. ucd9240 only.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 060ef63..a1aaf34 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -831,6 +831,16 @@ config SENSORS_MAX8688
 	  This driver can also be built as a module. If so, the module will
 	  be called max8688.
 
+config SENSORS_UCD9200
+	tristate "TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, UCD9248"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for TI
+	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ucd9200.
+
 endif # PMBUS
 
 config SENSORS_SHT15
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 967d0ea..99c87df 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
+obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
 
diff --git a/drivers/hwmon/ucd9200.c b/drivers/hwmon/ucd9200.c
new file mode 100644
index 0000000..ffcc1cf
--- /dev/null
+++ b/drivers/hwmon/ucd9200.c
@@ -0,0 +1,210 @@
+/*
+ * Hardware monitoring driver for ucd9200 series Digital PWM System Controllers
+ *
+ * Copyright (C) 2011 Ericsson AB.
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pmbus.h>
+#include "pmbus.h"
+
+#define UCD9200_PHASE_INFO	0xd2
+#define UCD9200_DEVICE_ID	0xfd
+
+enum chips { ucd9200, ucd9220, ucd9222, ucd9224, ucd9240, ucd9244, ucd9246,
+	     ucd9248 };
+
+static const struct i2c_device_id ucd9200_id[] = {
+	{"ucd9200", ucd9200},
+	{"ucd9220", ucd9220},
+	{"ucd9222", ucd9222},
+	{"ucd9224", ucd9224},
+	{"ucd9240", ucd9240},
+	{"ucd9244", ucd9244},
+	{"ucd9246", ucd9246},
+	{"ucd9248", ucd9248},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ucd9200_id);
+
+static int ucd9200_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+	struct pmbus_driver_info *info;
+	const struct i2c_device_id *mid;
+	int i, j, ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, UCD9200_DEVICE_ID,
+					block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read device ID\n");
+		return ret;
+	}
+	block_buffer[ret] = '\0';
+	dev_info(&client->dev, "Device ID %s\n", block_buffer);
+
+	mid = NULL;
+	for (i = 0; i < ARRAY_SIZE(ucd9200_id); i++) {
+		mid = &ucd9200_id[i];
+		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
+			break;
+	}
+	if (!mid || !strlen(mid->name)) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+	if (id->driver_data != ucd9200 && id->driver_data != mid->driver_data)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   id->name, mid->name);
+
+	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = i2c_smbus_read_block_data(client, UCD9200_PHASE_INFO,
+					block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read phase information\n");
+		goto out;
+	}
+
+	/*
+	 * Calculate number of configured pages (rails) from PHASE_INFO
+	 * register.
+	 * Rails have to be sequential, so we can abort after finding
+	 * the first unconfigured rail.
+	 */
+	info->pages = 0;
+	for (i = 0; i < ret; i++) {
+		if (!block_buffer[i])
+			break;
+		info->pages++;
+	}
+	if (!info->pages) {
+		dev_err(&client->dev, "No rails configured\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	dev_info(&client->dev, "%d rails configured\n", info->pages);
+
+	/*
+	 * Set PHASE registers on all pages to 0xff to ensure that phase
+	 * specific commands will apply to all phases of a given page (rail).
+	 * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
+	 * READ_IOUT will return the sum of currents of all phases of a rail,
+	 * and READ_TEMPERATURE2 will return the maximum temperature detected
+	 * for the the phases of the rail.
+	 */
+	for (i = 0; i < info->pages; i++) {
+		/*
+		 * Setting PAGE & PHASE fails once in a while for no obvious
+		 * reason, so we need to retry a couple of times.
+		 */
+		for (j = 0; j < 3; j++) {
+			ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
+			if (ret < 0)
+				continue;
+			ret = i2c_smbus_write_byte_data(client, PMBUS_PHASE,
+							0xff);
+			if (ret < 0)
+				continue;
+			break;
+		}
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Failed to initialize PHASE registers\n");
+			goto out;
+		}
+	}
+	if (info->pages > 1)
+		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+
+	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT |
+			PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP |
+			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+
+	for (i = 1; i < info->pages; i++)
+		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_POUT |
+			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+
+	/* ucd9240 supports a single fan */
+	if (mid->driver_data = ucd9240)
+		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12;
+
+	ret = pmbus_do_probe(client, mid, info);
+	if (ret < 0)
+		goto out;
+	return 0;
+out:
+	kfree(info);
+	return ret;
+}
+
+static int ucd9200_remove(struct i2c_client *client)
+{
+	int ret;
+	const struct pmbus_driver_info *info;
+
+	info = pmbus_get_driver_info(client);
+	ret = pmbus_do_remove(client);
+	kfree(info);
+	return ret;
+}
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ucd9200_driver = {
+	.driver = {
+		.name = "ucd9200",
+	},
+	.probe = ucd9200_probe,
+	.remove = ucd9200_remove,
+	.id_table = ucd9200_id,
+};
+
+static int __init ucd9200_init(void)
+{
+	return i2c_add_driver(&ucd9200_driver);
+}
+
+static void __exit ucd9200_exit(void)
+{
+	i2c_del_driver(&ucd9200_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for TI UCD922x, UCD924x");
+MODULE_LICENSE("GPL");
+module_init(ucd9200_init);
+module_exit(ucd9200_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
