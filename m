From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Apr 2011 15:59:43 +0000
Subject: [lm-sensors] [PATCH v2 5/6] hwmon: (pmbus) Support for TI UCD90xxx
Message-Id: <1303228784-17909-6-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hardware monitoring support for TI UCD90120, UCD90124, UCD9090, and UCD90910
Sequencer and System Health Controllers.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Tom Grennan <tom.grennan@ericsson.com>
---
v2: Added driver documentation

 Documentation/hwmon/ucd9000 |  110 +++++++++++++++++
 drivers/hwmon/Kconfig       |   14 ++-
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/ucd9000.c     |  278 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 402 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/hwmon/ucd9000
 create mode 100644 drivers/hwmon/ucd9000.c

diff --git a/Documentation/hwmon/ucd9000 b/Documentation/hwmon/ucd9000
new file mode 100644
index 0000000..40ca6db
--- /dev/null
+++ b/Documentation/hwmon/ucd9000
@@ -0,0 +1,110 @@
+Kernel driver ucd9000
+==========+
+Supported chips:
+  * TI UCD90120, UCD90124, UCD9090, and UCD90910
+    Prefixes: 'ucd90120', 'ucd90124', 'ucd9090', 'ucd90910'
+    Addresses scanned: -
+    Datasheets:
+	http://focus.ti.com/lit/ds/symlink/ucd90120.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd90124.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd9090.pdf
+	http://focus.ti.com/lit/ds/symlink/ucd90910.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+From datasheets:
+
+The UCD90120 Power Supply Sequencer and System Health Monitor monitors and
+sequences up to 12 independent voltage rails. The device integrates a 12-bit
+ADC with a 2.5V internal reference for monitoring up to 13 power supply voltage,
+current, or temperature inputs.
+
+The UCD90124 is a 12-rail PMBus/I2C addressable power-supply sequencer and
+system-health monitor. The device integrates a 12-bit ADC for monitoring up to
+13 power-supply voltage, current, or temperature inputs. Twenty-six GPIO pins
+can be used for power supply enables, power-on reset signals, external
+interrupts, cascading, or other system functions. Twelve of these pins offer PWM
+functionality. Using these pins, the UCD90124 offers support for fan control,
+margining, and general-purpose PWM functions.
+
+The UCD9090 is a 10-rail PMBus/I2C addressable power-supply sequencer and
+monitor. The device integrates a 12-bit ADC for monitoring up to 10 power-supply
+voltage inputs. Twenty-three GPIO pins can be used for power supply enables,
+power-on reset signals, external interrupts, cascading, or other system
+functions. Ten of these pins offer PWM functionality. Using these pins, the
+UCD9090 offers support for margining, and general-purpose PWM functions.
+
+The UCD90910 is a ten-rail I2C / PMBus addressable power-supply sequencer and
+system-health monitor. The device integrates a 12-bit ADC for monitoring up to
+13 power-supply voltage, current, or temperature inputs.
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
+in[1-12]_label		"vout[1-12]".
+in[1-12]_input		Measured voltage. From READ_VOUT register.
+in[1-12]_min		Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
+in[1-12]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
+in[1-12]_lcrit		Critical minumum Voltage. VOUT_UV_FAULT_LIMIT register.
+in[1-12]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[1-12]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
+in[1-12]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
+in[1-12]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
+in[1-12]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+
+curr[1-12]_label	"iout[1-12]".
+curr[1-12]_input	Measured current. From READ_IOUT register.
+curr[1-12]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
+curr[1-12]_lcrit	Critical minumum output current. From IOUT_UC_FAULT_LIMIT
+			register.
+curr[1-12]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr[1-12]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
+curr[1-12]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
+
+			For each attribute index, either voltage or current is
+			reported, but not both. If voltage or current is
+			reported depends on the chip configuration.
+
+temp[1-2]_input		Measured temperatures. From READ_TEMPERATURE_1 and
+			READ_TEMPERATURE_2 registers.
+temp[1-2]_max		Maximum temperature. From OT_WARN_LIMIT register.
+temp[1-2]_crit		Critical high temperature. From OT_FAULT_LIMIT register.
+temp[1-2]_max_alarm	Temperature high alarm.
+temp[1-2]_crit_alarm	Temperature critical high alarm.
+
+fan[1-4]_input		Fan RPM.
+fan[1-4]_alarm		Fan alarm.
+fan[1-4]_fault		Fan fault.
+
+			Fan attributes are only available on chips supporting
+			fan control (UCD90124, UCD90910). Attribute files are
+			created only for enabled fans.
+			Note that even though UCD90910 supports up to 10 fans,
+			only up to four fans are currently supported.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a1aaf34..c3476cd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -831,12 +831,24 @@ config SENSORS_MAX8688
 	  This driver can also be built as a module. If so, the module will
 	  be called max8688.
 
+config SENSORS_UCD9000
+	tristate "TI UCD90120, UCD90124, UCD9090, UCD90910"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for TI
+	  UCD90120, UCD90124, UCD9090, UCD90910 Sequencer and System Health
+	  Controllers.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ucd9000.
+
 config SENSORS_UCD9200
 	tristate "TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, UCD9248"
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for TI
-	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248.
+	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
+	  Digital PWM System Controllers.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ucd9200.
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 99c87df..19bc8fd 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
+obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
diff --git a/drivers/hwmon/ucd9000.c b/drivers/hwmon/ucd9000.c
new file mode 100644
index 0000000..ace1c73
--- /dev/null
+++ b/drivers/hwmon/ucd9000.c
@@ -0,0 +1,278 @@
+/*
+ * Hardware monitoring driver for UCD90xxx Sequencer and System Health
+ * Controller series
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
+enum chips { ucd9000, ucd90120, ucd90124, ucd9090, ucd90910 };
+
+#define UCD9000_MONITOR_CONFIG		0xd5
+#define UCD9000_NUM_PAGES		0xd6
+#define UCD9000_FAN_CONFIG_INDEX	0xe7
+#define UCD9000_FAN_CONFIG		0xe8
+#define UCD9000_DEVICE_ID		0xfd
+
+#define UCD9000_MON_TYPE(x)	(((x) >> 5) & 0x07)
+#define UCD9000_MON_PAGE(x)	((x) & 0x0f)
+
+#define UCD9000_MON_VOLTAGE	1
+#define UCD9000_MON_TEMPERATURE	2
+#define UCD9000_MON_CURRENT	3
+#define UCD9000_MON_VOLTAGE_HW	4
+
+#define UCD9000_NUM_FAN		4
+
+struct ucd9000_data {
+	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
+	struct pmbus_driver_info info;
+};
+#define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
+
+static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
+{
+	int fan_config = 0;
+	struct ucd9000_data *data
+	  = to_ucd9000_data(pmbus_get_driver_info(client));
+
+	if (data->fan_data[fan][3] & 1)
+		fan_config |= PB_FAN_2_INSTALLED;   /* Use lower bit position */
+
+	/* Pulses/revolution */
+	fan_config |= (data->fan_data[fan][3] & 0x06) >> 1;
+
+	return fan_config;
+}
+
+static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret = 0;
+	int fan_config;
+
+	switch (reg) {
+	case PMBUS_FAN_CONFIG_12:
+		if (page)
+			return -EINVAL;
+
+		ret = ucd9000_get_fan_config(client, 0);
+		if (ret < 0)
+			return ret;
+		fan_config = ret << 4;
+		ret = ucd9000_get_fan_config(client, 1);
+		if (ret < 0)
+			return ret;
+		fan_config |= ret;
+		ret = fan_config;
+		break;
+	case PMBUS_FAN_CONFIG_34:
+		if (page)
+			return -EINVAL;
+
+		ret = ucd9000_get_fan_config(client, 2);
+		if (ret < 0)
+			return ret;
+		fan_config = ret << 4;
+		ret = ucd9000_get_fan_config(client, 3);
+		if (ret < 0)
+			return ret;
+		fan_config |= ret;
+		ret = fan_config;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static const struct i2c_device_id ucd9000_id[] = {
+	{"ucd9000", ucd9000},
+	{"ucd90120", ucd90120},
+	{"ucd90124", ucd90124},
+	{"ucd9090", ucd9090},
+	{"ucd90910", ucd90910},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ucd9000_id);
+
+static int ucd9000_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+	struct ucd9000_data *data;
+	struct pmbus_driver_info *info;
+	const struct i2c_device_id *mid;
+	int i, ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, UCD9000_DEVICE_ID,
+					block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read device ID\n");
+		return ret;
+	}
+	block_buffer[ret] = '\0';
+	dev_info(&client->dev, "Device ID %s\n", block_buffer);
+
+	mid = NULL;
+	for (i = 0; i < ARRAY_SIZE(ucd9000_id); i++) {
+		mid = &ucd9000_id[i];
+		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
+			break;
+	}
+	if (!mid || !strlen(mid->name)) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+
+	if (id->driver_data != ucd9000 && id->driver_data != mid->driver_data)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   id->name, mid->name);
+
+	data = kzalloc(sizeof(struct ucd9000_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	info = &data->info;
+
+	ret = i2c_smbus_read_byte_data(client, UCD9000_NUM_PAGES);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to read number of active pages\n");
+		goto out;
+	}
+	info->pages = ret;
+	if (!info->pages) {
+		dev_err(&client->dev, "No pages configured\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* The internal temperature sensor is always active */
+	info->func[0] = PMBUS_HAVE_TEMP;
+
+	/* Everything else is configurable */
+	ret = i2c_smbus_read_block_data(client, UCD9000_MONITOR_CONFIG,
+					block_buffer);
+	if (ret <= 0) {
+		dev_err(&client->dev, "Failed to read configuration data\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	for (i = 0; i < ret; i++) {
+		int page = UCD9000_MON_PAGE(block_buffer[i]);
+
+		if (page >= info->pages)
+			continue;
+
+		switch (UCD9000_MON_TYPE(block_buffer[i])) {
+		case UCD9000_MON_VOLTAGE:
+		case UCD9000_MON_VOLTAGE_HW:
+			info->func[page] |= PMBUS_HAVE_VOUT
+			  | PMBUS_HAVE_STATUS_VOUT;
+			break;
+		case UCD9000_MON_TEMPERATURE:
+			info->func[page] |= PMBUS_HAVE_TEMP2
+			  | PMBUS_HAVE_STATUS_TEMP;
+			break;
+		case UCD9000_MON_CURRENT:
+			info->func[page] |= PMBUS_HAVE_IOUT
+			  | PMBUS_HAVE_STATUS_IOUT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Fan configuration */
+	if (mid->driver_data = ucd90124) {
+		for (i = 0; i < UCD9000_NUM_FAN; i++) {
+			i2c_smbus_write_byte_data(client,
+						  UCD9000_FAN_CONFIG_INDEX, i);
+			ret = i2c_smbus_read_block_data(client,
+							UCD9000_FAN_CONFIG,
+							data->fan_data[i]);
+			if (ret < 0)
+				goto out;
+		}
+		i2c_smbus_write_byte_data(client, UCD9000_FAN_CONFIG_INDEX, 0);
+
+		info->read_byte_data = ucd9000_read_byte_data;
+		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12
+		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
+	}
+
+	ret = pmbus_do_probe(client, mid, info);
+	if (ret < 0)
+		goto out;
+	return 0;
+
+out:
+	kfree(data);
+	return ret;
+}
+
+static int ucd9000_remove(struct i2c_client *client)
+{
+	int ret;
+	struct ucd9000_data *data;
+
+	data = to_ucd9000_data(pmbus_get_driver_info(client));
+	ret = pmbus_do_remove(client);
+	kfree(data);
+	return ret;
+}
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ucd9000_driver = {
+	.driver = {
+		.name = "ucd9000",
+	},
+	.probe = ucd9000_probe,
+	.remove = ucd9000_remove,
+	.id_table = ucd9000_id,
+};
+
+static int __init ucd9000_init(void)
+{
+	return i2c_add_driver(&ucd9000_driver);
+}
+
+static void __exit ucd9000_exit(void)
+{
+	i2c_del_driver(&ucd9000_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for TI UCD90xxx");
+MODULE_LICENSE("GPL");
+module_init(ucd9000_init);
+module_exit(ucd9000_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
