From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:44 +0000
Subject: [lm-sensors] [PATCH v2 15/15] hwmon: (pmbus) Add client driver for
Message-Id: <1310608484-20678-16-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

PMBus client driver supporting National Semiconductor LM25066, LM5064, and LM5066.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Added documentation

 Documentation/hwmon/lm25066      |   90 ++++++++++
 drivers/hwmon/pmbus/Kconfig      |   10 +
 drivers/hwmon/pmbus/Makefile     |    1 +
 drivers/hwmon/pmbus/lm25066.c    |  340 ++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h      |    1 +
 drivers/hwmon/pmbus/pmbus_core.c |    3 +-
 6 files changed, 444 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/hwmon/lm25066
 create mode 100644 drivers/hwmon/pmbus/lm25066.c

diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
new file mode 100644
index 0000000..22f599b
--- /dev/null
+++ b/Documentation/hwmon/lm25066
@@ -0,0 +1,90 @@
+Kernel driver max8688
+==========+
+Supported chips:
+  * National Semiconductor LM25066
+    Prefix: 'lm25066'
+    Addresses scanned: -
+    Datasheets:
+	http://www.national.com/pf/LM/LM25066.html
+	http://www.national.com/pf/LM/LM25066A.html
+  * National Semiconductor LM5064
+    Prefix: 'lm5064'
+    Addresses scanned: -
+    Datasheet:
+	http://www.national.com/pf/LM/LM5064.html
+  * National Semiconductor LM5066
+    Prefix: 'lm5066'
+    Addresses scanned: -
+    Datasheet:
+	http://www.national.com/pf/LM/LM5066.html
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for National Semiconductor LM25066,
+LM5064, and LM5064 Power Management, Monitoring, Control, and Protection ICs.
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
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write; all other
+attributes are read-only.
+
+in1_label		"vin"
+in1_input		Measured input voltage.
+in1_average		Average measured input voltage.
+in1_min			Minimum input Voltage.
+in1_max			Maximum input voltage.
+in1_min_alarm		Input voltage low alarm.
+in1_max_alarm		Input voltage high alarm.
+
+in2_label		"vout1"
+in2_input		Measured output voltage.
+in2_average		Average measured output voltage.
+in2_min			Minimum output Voltage.
+in2_min_alarm		Output voltage low alarm.
+
+in3_label		"vout2"
+in3_input		Measured voltage on vaux pin
+
+curr1_label		"iin"
+curr1_input		Measured input current.
+curr1_average		Average measured input current.
+curr1_max		Maximum input current.
+curr1_max_alarm		Input current high alarm.
+
+power1_label		"pin"
+power1_input		Measured input power.
+power1_average		Average measured input power.
+power1_max		Maximum input power limit.
+power1_alarm		Input power alarm
+power1_input_highest	Historical maximum power.
+power1_reset_history	Write any value to reset maximum power history.
+
+temp1_input		Measured temperature.
+temp1_max		Maximum temperature.
+temp1_crit		Critical high temperature.
+temp1_max_alarm		Chip temperature high alarm.
+temp1_crit_alarm	Chip temperature critical high alarm.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index f3cf83d..c574bd1 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -36,6 +36,16 @@ config SENSORS_ADM1275
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
 
+config SENSORS_LM25066
+	tristate "National Semiconductor LM25066 and compatibles"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for National
+	  Semiconductor LM25066, LM5064, and LM5066.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called lm25066.
+
 config SENSORS_MAX16064
 	tristate "Maxim MAX16064"
 	default n
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 0178f81..623eedb 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
+obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
new file mode 100644
index 0000000..d4bc114
--- /dev/null
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -0,0 +1,340 @@
+/*
+ * Hardware monitoring driver for LM25066 / LM5064 / LM5066
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
+#include "pmbus.h"
+
+enum chips { lm25066, lm5064, lm5066 };
+
+#define LM25066_READ_VAUX		0xd0
+#define LM25066_MFR_READ_IIN		0xd1
+#define LM25066_MFR_READ_PIN		0xd2
+#define LM25066_MFR_IIN_OC_WARN_LIMIT	0xd3
+#define LM25066_MFR_PIN_OP_WARN_LIMIT	0xd4
+#define LM25066_READ_PIN_PEAK		0xd5
+#define LM25066_CLEAR_PIN_PEAK		0xd6
+#define LM25066_DEVICE_SETUP		0xd9
+#define LM25066_READ_AVG_VIN		0xdc
+#define LM25066_READ_AVG_VOUT		0xdd
+#define LM25066_READ_AVG_IIN		0xde
+#define LM25066_READ_AVG_PIN		0xdf
+
+#define LM25066_DEV_SETUP_CL		(1 << 4)	/* Current limit */
+
+struct lm25066_data {
+	int id;
+	struct pmbus_driver_info info;
+};
+
+#define to_lm25066_data(x)  container_of(x, struct lm25066_data, info)
+
+static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct lm25066_data *data = to_lm25066_data(info);
+	int ret;
+
+	if (page > 1)
+		return -EINVAL;
+
+	/* Map READ_VAUX into READ_VOUT register on page 1 */
+	if (page = 1) {
+		switch (reg) {
+		case PMBUS_READ_VOUT:
+			ret = pmbus_read_word_data(client, 0,
+						   LM25066_READ_VAUX);
+			if (ret < 0)
+				break;
+			/* Adjust returned value to match VOUT coefficients */
+			switch (data->id) {
+			case lm25066:
+				/* VOUT: 4.54 mV VAUX: 283.2 uV LSB */
+				ret = DIV_ROUND_CLOSEST(ret * 2832, 45400);
+				break;
+			case lm5064:
+				/* VOUT: 4.53 mV VAUX: 700 uV LSB */
+				ret = DIV_ROUND_CLOSEST(ret * 70, 453);
+				break;
+			case lm5066:
+				/* VOUT: 2.18 mV VAUX: 725 uV LSB */
+				ret = DIV_ROUND_CLOSEST(ret * 725, 2180);
+				break;
+			}
+			break;
+		default:
+			/* No other valid registers on page 1 */
+			ret = -EINVAL;
+			break;
+		}
+		goto done;
+	}
+
+	switch (reg) {
+	case PMBUS_READ_IIN:
+		ret = pmbus_read_word_data(client, 0, LM25066_MFR_READ_IIN);
+		break;
+	case PMBUS_READ_PIN:
+		ret = pmbus_read_word_data(client, 0, LM25066_MFR_READ_PIN);
+		break;
+	case PMBUS_IIN_OC_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, 0,
+					   LM25066_MFR_IIN_OC_WARN_LIMIT);
+		break;
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, 0,
+					   LM25066_MFR_PIN_OP_WARN_LIMIT);
+		break;
+	case PMBUS_VIRT_READ_VIN_AVG:
+		ret = pmbus_read_word_data(client, 0, LM25066_READ_AVG_VIN);
+		break;
+	case PMBUS_VIRT_READ_VOUT_AVG:
+		ret = pmbus_read_word_data(client, 0, LM25066_READ_AVG_VOUT);
+		break;
+	case PMBUS_VIRT_READ_IIN_AVG:
+		ret = pmbus_read_word_data(client, 0, LM25066_READ_AVG_IIN);
+		break;
+	case PMBUS_VIRT_READ_PIN_AVG:
+		ret = pmbus_read_word_data(client, 0, LM25066_READ_AVG_PIN);
+		break;
+	case PMBUS_VIRT_READ_PIN_MAX:
+		ret = pmbus_read_word_data(client, 0, LM25066_READ_PIN_PEAK);
+		break;
+	case PMBUS_VIRT_RESET_PIN_HISTORY:
+		ret = 0;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+done:
+	return ret;
+}
+
+static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
+				   u16 word)
+{
+	int ret;
+
+	if (page > 1)
+		return -EINVAL;
+
+	switch (reg) {
+	case PMBUS_IIN_OC_WARN_LIMIT:
+		ret = pmbus_write_word_data(client, 0,
+					    LM25066_MFR_IIN_OC_WARN_LIMIT,
+					    word);
+		break;
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		ret = pmbus_write_word_data(client, 0,
+					    LM25066_MFR_PIN_OP_WARN_LIMIT,
+					    word);
+		break;
+	case PMBUS_VIRT_RESET_PIN_HISTORY:
+		ret = pmbus_write_byte(client, 0, LM25066_CLEAR_PIN_PEAK);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static int lm25066_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	int config;
+	int ret;
+	struct lm25066_data *data;
+	struct pmbus_driver_info *info;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(struct lm25066_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	config = i2c_smbus_read_byte_data(client, LM25066_DEVICE_SETUP);
+	if (config < 0) {
+		ret = config;
+		goto err_mem;
+	}
+
+	data->id = id->driver_data;
+	info = &data->info;
+
+	info->pages = 2;
+	info->format[PSC_VOLTAGE_IN] = direct;
+	info->format[PSC_VOLTAGE_OUT] = direct;
+	info->format[PSC_CURRENT_IN] = direct;
+	info->format[PSC_TEMPERATURE] = direct;
+	info->format[PSC_POWER] = direct;
+
+	info->m[PSC_TEMPERATURE] = 16;
+	info->b[PSC_TEMPERATURE] = 0;
+	info->R[PSC_TEMPERATURE] = 0;
+
+	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
+	  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_IIN
+	  | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
+	info->func[1] = PMBUS_HAVE_VOUT;
+
+	info->read_word_data = lm25066_read_word_data;
+	info->write_word_data = lm25066_write_word_data;
+
+	switch (id->driver_data) {
+	case lm25066:
+		info->m[PSC_VOLTAGE_IN] = 22070;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -2;
+		info->m[PSC_VOLTAGE_OUT] = 22070;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -2;
+
+		if (config & LM25066_DEV_SETUP_CL) {
+			info->m[PSC_CURRENT_IN] = 6852;
+			info->b[PSC_CURRENT_IN] = 0;
+			info->R[PSC_CURRENT_IN] = -2;
+			info->m[PSC_POWER] = 369;
+			info->b[PSC_POWER] = 0;
+			info->R[PSC_POWER] = -2;
+		} else {
+			info->m[PSC_CURRENT_IN] = 13661;
+			info->b[PSC_CURRENT_IN] = 0;
+			info->R[PSC_CURRENT_IN] = -2;
+			info->m[PSC_POWER] = 736;
+			info->b[PSC_POWER] = 0;
+			info->R[PSC_POWER] = -2;
+		}
+		break;
+	case lm5064:
+		info->m[PSC_VOLTAGE_IN] = 22075;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -2;
+		info->m[PSC_VOLTAGE_OUT] = 22075;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -2;
+
+		if (config & LM25066_DEV_SETUP_CL) {
+			info->m[PSC_CURRENT_IN] = 6713;
+			info->b[PSC_CURRENT_IN] = 0;
+			info->R[PSC_CURRENT_IN] = -2;
+			info->m[PSC_POWER] = 3619;
+			info->b[PSC_POWER] = 0;
+			info->R[PSC_POWER] = -3;
+		} else {
+			info->m[PSC_CURRENT_IN] = 13426;
+			info->b[PSC_CURRENT_IN] = 0;
+			info->R[PSC_CURRENT_IN] = -2;
+			info->m[PSC_POWER] = 7238;
+			info->b[PSC_POWER] = 0;
+			info->R[PSC_POWER] = -3;
+		}
+		break;
+	case lm5066:
+		info->m[PSC_VOLTAGE_IN] = 4587;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -2;
+		info->m[PSC_VOLTAGE_OUT] = 4587;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -2;
+
+		if (config & LM25066_DEV_SETUP_CL) {
+			info->m[PSC_CURRENT_IN] = 10753;
+			info->b[PSC_CURRENT_IN] = 0;
+			info->R[PSC_CURRENT_IN] = -2;
+			info->m[PSC_POWER] = 1204;
+			info->b[PSC_POWER] = 0;
+			info->R[PSC_POWER] = -3;
+		} else {
+			info->m[PSC_CURRENT_IN] = 5405;
+			info->b[PSC_CURRENT_IN] = 0;
+			info->R[PSC_CURRENT_IN] = -2;
+			info->m[PSC_POWER] = 605;
+			info->b[PSC_POWER] = 0;
+			info->R[PSC_POWER] = -3;
+		}
+		break;
+	default:
+		ret = -ENODEV;
+		goto err_mem;
+	}
+
+	ret = pmbus_do_probe(client, id, info);
+	if (ret)
+		goto err_mem;
+	return 0;
+
+err_mem:
+	kfree(data);
+	return ret;
+}
+
+static int lm25066_remove(struct i2c_client *client)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct lm25066_data *data = to_lm25066_data(info);
+	int ret;
+
+	ret = pmbus_do_remove(client);
+	kfree(data);
+	return ret;
+}
+
+static const struct i2c_device_id lm25066_id[] = {
+	{"lm25066", lm25066},
+	{"lm5064", lm5064},
+	{"lm5066", lm5066},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, lm25066_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver lm25066_driver = {
+	.driver = {
+		   .name = "lm25066",
+		   },
+	.probe = lm25066_probe,
+	.remove = lm25066_remove,
+	.id_table = lm25066_id,
+};
+
+static int __init lm25066_init(void)
+{
+	return i2c_add_driver(&lm25066_driver);
+}
+
+static void __exit lm25066_exit(void)
+{
+	i2c_del_driver(&lm25066_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for LM25066/LM5064/LM5066");
+MODULE_LICENSE("GPL");
+module_init(lm25066_init);
+module_exit(lm25066_exit);
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 9973d26..0808d98 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -340,6 +340,7 @@ int pmbus_set_page(struct i2c_client *client, u8 page);
 int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
 int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word);
 int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
+int pmbus_write_byte(struct i2c_client *client, int page, u8 value);
 void pmbus_clear_faults(struct i2c_client *client);
 bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f9c20ad..78bf007 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -168,7 +168,7 @@ int pmbus_set_page(struct i2c_client *client, u8 page)
 }
 EXPORT_SYMBOL_GPL(pmbus_set_page);
 
-static int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
+int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
 {
 	int rv;
 
@@ -180,6 +180,7 @@ static int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
 
 	return i2c_smbus_write_byte(client, value);
 }
+EXPORT_SYMBOL_GPL(pmbus_write_byte);
 
 int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word)
 {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
