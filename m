From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 03:31:30 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (pmbus/ltc2978) Explicit driver for
Message-Id: <1316748692-8326-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Provide explicit driver for LTC2978 to enable support for minimum and peak
attributes. Remove ltc2978 chip id from generic pmbus driver.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/ltc2978   |   78 +++++++++++
 Documentation/hwmon/pmbus     |    5 -
 drivers/hwmon/pmbus/Kconfig   |   12 ++-
 drivers/hwmon/pmbus/Makefile  |    1 +
 drivers/hwmon/pmbus/ltc2978.c |  300 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.c   |    1 -
 6 files changed, 390 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/hwmon/ltc2978
 create mode 100644 drivers/hwmon/pmbus/ltc2978.c

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
new file mode 100644
index 0000000..f4cba8c
--- /dev/null
+++ b/Documentation/hwmon/ltc2978
@@ -0,0 +1,78 @@
+Kernel driver ltc2978
+==========+
+Supported chips:
+  * Linear Technology LTC2978
+    Prefix: 'ltc2978'
+    Addresses scanned: -
+    Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+The LTC2978 is an octal power supply monitor, supervisor, sequencer and
+margin controller.
+
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have to instantiate
+devices explicitly.
+
+Example: the following commands will load the driver for an LTC2978 at address
+0x60 on I2C bus #1:
+
+# modprobe ltc2978
+# echo ltc2978 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
+
+
+Sysfs attributes
+----------------
+
+in1_label		"vin"
+in1_input		Measured input voltage.
+in1_min			Minimum input Voltage.
+in1_max			Maximum input voltage.
+in1_lcrit		Critical minimum input Voltage.
+in1_crit		Critical maximum input voltage.
+in1_min_alarm		Input voltage low alarm.
+in1_max_alarm		Input voltage high alarm.
+in1_lcrit_alarm		Input voltage critical low alarm.
+in1_crit_alarm		Input voltage critical high alarm.
+in1_lowest		Lowest input voltage.
+in1_highest		Highest input voltage.
+in1_reset_history	Reset history. Writing into this attribute will reset
+			history for all attributes.
+
+in[2-9]_label		"vout[1-8]".
+in[2-9]_input		Measured output voltage.
+in[2-9]_min		Minimum output Voltage.
+in[2-9]_max		Maximum output voltage.
+in[2-9]_lcrit		Critical minimum output Voltage.
+in[2-9]_crit		Critical maximum output voltage.
+in[2-9]_min_alarm	Output voltage low alarm.
+in[2-9]_max_alarm	Output voltage high alarm.
+in[2-9]_lcrit_alarm	Output voltage critical low alarm.
+in[2-9]_crit_alarm	Output voltage critical high alarm.
+in[2-9]_lowest		Lowest output voltage.
+in[2-9]_highest		Lowest output voltage.
+in[2-9]_reset_history	Reset history. Writing into this attribute will reset
+			history for all attributes.
+
+temp1_input		Measured temperature.
+temp1_min		Mimimum temperature.
+temp1_max		Maximum temperature.
+temp1_lcrit		Critical low temperature.
+temp1_crit		Critical high temperature.
+temp1_min_alarm		Chip temperature low alarm.
+temp1_max_alarm		Chip temperature high alarm.
+temp1_lcrit_alarm	Chip temperature critical low alarm.
+temp1_crit_alarm	Chip temperature critical high alarm.
+temp1_lowest		Lowest measured temperature.
+temp1_highest		Highest measured temperature.
+temp1_reset_history	Reset history. Writing into this attribute will reset
+			history for all attributes.
diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index c36c1c1..ce02f5d 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -8,11 +8,6 @@ Supported chips:
     Addresses scanned: -
     Datasheet:
  http://archive.ericsson.net/service/internet/picov/get?DocNo(701-EN/LZT146395
-  * Linear Technology LTC2978
-    Octal PMBus Power Supply Monitor and Controller
-    Prefix: 'ltc2978'
-    Addresses scanned: -
-    Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
   * ON Semiconductor ADP4000, NCP4200, NCP4208
     Prefixes: 'adp4000', 'ncp4200', 'ncp4208'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index efaf340..c4dcdca 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -20,7 +20,7 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR450, BMR451,
-	  BMR453, BMR454, LTC2978, NCP4200, and NCP4208.
+	  BMR453, BMR454, NCP4200, and NCP4208.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
@@ -46,6 +46,16 @@ config SENSORS_LM25066
 	  This driver can also be built as a module. If so, the module will
 	  be called lm25066.
 
+config SENSORS_LTC2978
+	tristate "Linear Technologies LTC2978"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Linear
+	  Technology LTC2978.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2978.
+
 config SENSORS_MAX16064
 	tristate "Maxim MAX16064"
 	default n
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index b9e4fb4..789376c 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
+obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
new file mode 100644
index 0000000..0c8e2a6
--- /dev/null
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -0,0 +1,300 @@
+/*
+ * Hardware monitoring driver for LTC2978
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
+enum chips { ltc2978 };
+
+#define LTC2978_MFR_VOUT_PEAK		0xdd
+#define LTC2978_MFR_VIN_PEAK		0xde
+#define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
+#define LTC2978_MFR_SPECIAL_ID		0xe7
+
+#define LTC2978_MFR_VOUT_MIN		0xfb
+#define LTC2978_MFR_VIN_MIN		0xfc
+#define LTC2978_MFR_TEMPERATURE_MIN	0xfd
+
+#define LTC2978_ID_REV1			0x0121
+#define LTC2978_ID_REV2			0x0122
+
+/*
+ * LTC2978 clears peak data whenever the CLEAR_FAULTS command is executed, which
+ * happens pretty much each time chip data is updated. Raw peak data therefore
+ * does not provide much value. To be able to provide useful peak data, keep an
+ * internal cache of measured peak data, which is only cleared if an explicit
+ * "clear peak" command is executed for the sensor in question.
+ */
+struct ltc2978_data {
+	enum chips id;
+	int vin_min, vin_max;
+	int temp_min, temp_max;
+	int vout_min[8], vout_max[8];
+	struct pmbus_driver_info info;
+};
+
+#define to_ltc2978_data(x)  container_of(x, struct ltc2978_data, info)
+
+static inline int lin11_to_val(int data)
+{
+	s16 e = (data >> 11) & 0x1f;
+	s32 m = data & 0x7ff;
+
+	/* sign-extend mantissa and exponent */
+	if (e > 0x0f)
+		e |= 0xffe0;
+	if (m > 0x3ff)
+		m |= 0xfffff800;
+	/*
+	 * mantissa is 10 bit + sign, exponent is up to 15 bit.
+	 * Add 6 bit to exponent for maximum accuracy (10 + 15 + 6 = 31).
+	 */
+	e += 6;
+	return (e < 0 ? m >> -e : m << e);
+}
+
+static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VIN_MAX:
+		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VIN_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret) > lin11_to_val(data->vin_max))
+				data->vin_max = ret;
+			ret = data->vin_max;
+		}
+		break;
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VOUT_PEAK);
+		if (ret >= 0) {
+			/*
+			 * VOUT is 16 bit unsigned with fixed exponent,
+			 * so we can compare it directly
+			 */
+			if (ret > data->vout_max[page])
+				data->vout_max[page] = ret;
+			ret = data->vout_max[page];
+		}
+		break;
+	case PMBUS_VIRT_READ_TEMP_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   LTC2978_MFR_TEMPERATURE_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret) > lin11_to_val(data->temp_max))
+				data->temp_max = ret;
+			ret = data->temp_max;
+		}
+		break;
+	case PMBUS_VIRT_READ_VIN_MIN:
+		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VIN_MIN);
+		if (ret >= 0) {
+			if (lin11_to_val(ret) < lin11_to_val(data->vin_min))
+				data->vin_min = ret;
+			ret = data->vin_min;
+		}
+		break;
+	case PMBUS_VIRT_READ_VOUT_MIN:
+		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VOUT_MIN);
+		if (ret >= 0) {
+			/*
+			 * VOUT_MIN is known to not be supported on some lots
+			 * of LTC2978 revision 1, and will return the maximum
+			 * possible voltage if read. If VOUT_MAX is valid and
+			 * lower than the reading of VOUT_MIN, use it instead.
+			 */
+			if (data->vout_max[page] && ret > data->vout_max[page])
+				ret = data->vout_max[page];
+			if (ret < data->vout_min[page])
+				data->vout_min[page] = ret;
+			ret = data->vout_min[page];
+		}
+		break;
+	case PMBUS_VIRT_READ_TEMP_MIN:
+		ret = pmbus_read_word_data(client, page,
+					   LTC2978_MFR_TEMPERATURE_MIN);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    < lin11_to_val(data->temp_min))
+				data->temp_min = ret;
+			ret = data->temp_min;
+		}
+		break;
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+		ret = 0;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static int ltc2978_write_word_data(struct i2c_client *client, int page,
+				    int reg, u16 word)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+		data->vout_min[page] = 0xffff;
+		data->vout_max[page] = 0;
+		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		break;
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+		data->vin_min = 0x7bff;
+		data->vin_max = 0;
+		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		break;
+	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+		data->temp_min = 0x7bff;
+		data->temp_max = 0x7fff;
+		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static const struct i2c_device_id ltc2978_id[] = {
+	{"ltc2978", ltc2978},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ltc2978_id);
+
+static int ltc2978_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	int chip_id, ret, i;
+	struct ltc2978_data *data;
+	struct pmbus_driver_info *info;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(struct ltc2978_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	chip_id = i2c_smbus_read_word_data(client, LTC2978_MFR_SPECIAL_ID);
+	if (chip_id < 0) {
+		ret = chip_id;
+		goto err_mem;
+	}
+
+	if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
+		data->id = ltc2978;
+	} else {
+		dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
+		ret = -ENODEV;
+		goto err_mem;
+	}
+	if (data->id != id->driver_data)
+		dev_warn(&client->dev,
+			 "Device mismatch: Configured %s, detected %s\n",
+			 id->name,
+			 ltc2978_id[data->id].name);
+
+	info = &data->info;
+	info->read_word_data = ltc2978_read_word_data;
+	info->write_word_data = ltc2978_write_word_data;
+
+	data->vout_min[0] = 0xffff;
+	data->vin_min = 0x7bff;
+	data->temp_min = 0x7bff;
+	data->temp_max = 0x7fff;
+
+	switch (id->driver_data) {
+	case ltc2978:
+		info->pages = 8;
+		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
+		for (i = 1; i < 8; i++) {
+			info->func[i] = PMBUS_HAVE_VOUT
+			  | PMBUS_HAVE_STATUS_VOUT;
+			data->vout_min[i] = 0xffff;
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
+static int ltc2978_remove(struct i2c_client *client)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct ltc2978_data *data = to_ltc2978_data(info);
+
+	pmbus_do_remove(client);
+	kfree(data);
+	return 0;
+}
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ltc2978_driver = {
+	.driver = {
+		   .name = "ltc2978",
+		   },
+	.probe = ltc2978_probe,
+	.remove = ltc2978_remove,
+	.id_table = ltc2978_id,
+};
+
+static int __init ltc2978_init(void)
+{
+	return i2c_add_driver(&ltc2978_driver);
+}
+
+static void __exit ltc2978_exit(void)
+{
+	i2c_del_driver(&ltc2978_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for LTC2978");
+MODULE_LICENSE("GPL");
+module_init(ltc2978_init);
+module_exit(ltc2978_exit);
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 1dfba44..ef5cc1e 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -204,7 +204,6 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"bmr451", 1},
 	{"bmr453", 1},
 	{"bmr454", 1},
-	{"ltc2978", 8},
 	{"ncp4200", 1},
 	{"ncp4208", 1},
 	{"pmbus", 0},
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
