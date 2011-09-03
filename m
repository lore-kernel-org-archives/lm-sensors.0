From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Sep 2011 02:27:50 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (pmbus) Add support for Intersil
Message-Id: <1315016870-10579-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for Intersil / Zilker Labs ZL2004, ZL2006, ZL2008, ZL2105, ZL2106,
ZL6100, and ZL6105.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Be more careful with page number validation for byte access functions,
    and use improved id array walking code in probe function.
    Add warning to documentation to avoid access to certain command registers.

 Documentation/hwmon/zl6100   |  125 ++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig  |   11 ++
 drivers/hwmon/pmbus/Makefile |    1 +
 drivers/hwmon/pmbus/zl6100.c |  256 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 393 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/zl6100
 create mode 100644 drivers/hwmon/pmbus/zl6100.c

diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
new file mode 100644
index 0000000..7617798
--- /dev/null
+++ b/Documentation/hwmon/zl6100
@@ -0,0 +1,125 @@
+Kernel driver zl6100
+==========
+
+Supported chips:
+  * Intersil / Zilker Labs ZL2004
+    Prefix: 'zl2004'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6847.pdf
+  * Intersil / Zilker Labs ZL2006
+    Prefix: 'zl2006'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6850.pdf
+  * Intersil / Zilker Labs ZL2008
+    Prefix: 'zl2008'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6859.pdf
+  * Intersil / Zilker Labs ZL2105
+    Prefix: 'zl2105'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6851.pdf
+  * Intersil / Zilker Labs ZL2106
+    Prefix: 'zl2106'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6852.pdf
+  * Intersil / Zilker Labs ZL6100
+    Prefix: 'zl6100'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6876.pdf
+  * Intersil / Zilker Labs ZL6105
+    Prefix: 'zl6105'
+    Addresses scanned: -
+    Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for Intersil / Zilker Labs ZL6100 and
+compatible digital DC-DC controllers.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus and Documentation.hwmon/pmbus-core for details
+on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+WARNING: Do not access chip registers using the i2cdump command, and do not use
+any of the i2ctools commands on a command register used to save and restore
+configuration data (0x11, 0x12, 0x15, 0x16, and 0xf4). The chips supported by
+this driver interpret any access to those command registers (including read
+commands) as request to execute the command in question. Unless write accesses
+to those registers are protected, this may result in power loss, board resets,
+and/or Flash corruption. Worst case, your board may turn into a brick.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Module parameters
+-----------------
+
+delay
+-----
+
+Some Intersil/Zilker Labs DC-DC controllers require a minimum interval between
+I2C bus accesses. According to Intersil, the minimum interval is 2 ms, though
+1 ms appears to be sufficient and has not caused any problems in testing.
+The problem is known to affect ZL6100, ZL2105, and ZL2008. It is known not to
+affect ZL2004 and ZL6105. The driver automatically sets the interval to 1 ms
+except for ZL2004 and ZL6105. To enable manual override, the driver provides a
+writeable module parameter, 'delay', which can be used to set the interval to
+a value between 0 and 65,535 microseconds.
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
+in1_min			Minimum input voltage.
+in1_max			Maximum input voltage.
+in1_lcrit		Critical minumum input voltage.
+in1_crit		Critical maximum input voltage.
+in1_min_alarm		Input voltage low alarm.
+in1_max_alarm		Input voltage high alarm.
+in1_lcrit_alarm		Input voltage critical low alarm.
+in1_crit_alarm		Input voltage critical high alarm.
+
+in2_label		"vout1"
+in2_input		Measured output voltage.
+in2_lcrit		Critical minumum output Voltage.
+in2_crit		Critical maximum output voltage.
+in2_lcrit_alarm		Critical output voltage critical low alarm.
+in2_crit_alarm		Critical output voltage critical high alarm.
+
+curr1_label		"iout1"
+curr1_input		Measured output current.
+curr1_lcrit		Critical minimum output current.
+curr1_crit		Critical maximum output current.
+curr1_lcrit_alarm	Output current critical low alarm.
+curr1_crit_alarm	Output current critical high alarm.
+
+temp[12]_input		Measured temperature.
+temp[12]_min		Minimum temperature.
+temp[12]_max		Maximum temperature.
+temp[12]_lcrit		Critical low temperature.
+temp[12]_crit		Critical high temperature.
+temp[12]_min_alarm	Chip temperature low alarm.
+temp[12]_max_alarm	Chip temperature high alarm.
+temp[12]_lcrit_alarm	Chip temperature critical low alarm.
+temp[12]_crit_alarm	Chip temperature critical high alarm.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 3757558..efaf340 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -98,4 +98,15 @@ config SENSORS_UCD9200
 	  This driver can also be built as a module. If so, the module will
 	  be called ucd9200.
 
+config SENSORS_ZL6100
+	tristate "Intersil ZL6100 and compatibles"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Intersil
+	  ZL2004, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, and ZL6105 Digital
+	  DC/DC Controllers.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called zl6100.
+
 endif # PMBUS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 623eedb..b9e4fb4 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
+obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
new file mode 100644
index 0000000..2bc9800
--- /dev/null
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -0,0 +1,256 @@
+/*
+ * Hardware monitoring driver for ZL6100 and compatibles
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
+#include <linux/ktime.h>
+#include <linux/delay.h>
+#include "pmbus.h"
+
+enum chips { zl2004, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
+
+struct zl6100_data {
+	int id;
+	ktime_t access;		/* chip access time */
+	struct pmbus_driver_info info;
+};
+
+#define to_zl6100_data(x)  container_of(x, struct zl6100_data, info)
+
+#define ZL6100_DEVICE_ID		0xe4
+
+#define ZL6100_WAIT_TIME		1000	/* uS	*/
+
+static ushort delay = ZL6100_WAIT_TIME;
+module_param(delay, ushort, 0644);
+MODULE_PARM_DESC(delay, "Delay between chip accesses in uS");
+
+/* Some chips need a delay between accesses */
+static inline void zl6100_wait(const struct zl6100_data *data)
+{
+	if (delay) {
+		s64 delta = ktime_us_delta(ktime_get(), data->access);
+		if (delta < delay)
+			udelay(delay - delta);
+	}
+}
+
+static int zl6100_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct zl6100_data *data = to_zl6100_data(info);
+	int ret;
+
+	if (page || reg >= PMBUS_VIRT_BASE)
+		return -ENXIO;
+
+	zl6100_wait(data);
+	ret = pmbus_read_word_data(client, page, reg);
+	data->access = ktime_get();
+
+	return ret;
+}
+
+static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct zl6100_data *data = to_zl6100_data(info);
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	zl6100_wait(data);
+	ret = pmbus_read_byte_data(client, page, reg);
+	data->access = ktime_get();
+
+	return ret;
+}
+
+static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
+				  u16 word)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct zl6100_data *data = to_zl6100_data(info);
+	int ret;
+
+	if (page || reg >= PMBUS_VIRT_BASE)
+		return -ENXIO;
+
+	zl6100_wait(data);
+	ret = pmbus_write_word_data(client, page, reg, word);
+	data->access = ktime_get();
+
+	return ret;
+}
+
+static int zl6100_write_byte(struct i2c_client *client, int page, u8 value)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct zl6100_data *data = to_zl6100_data(info);
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	zl6100_wait(data);
+	ret = pmbus_write_byte(client, page, value);
+	data->access = ktime_get();
+
+	return ret;
+}
+
+static const struct i2c_device_id zl6100_id[] = {
+	{"zl2004", zl2004},
+	{"zl2006", zl2006},
+	{"zl2008", zl2008},
+	{"zl2105", zl2105},
+	{"zl2106", zl2106},
+	{"zl6100", zl6100},
+	{"zl6105", zl6105},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, zl6100_id);
+
+static int zl6100_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int ret;
+	struct zl6100_data *data;
+	struct pmbus_driver_info *info;
+	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
+	const struct i2c_device_id *mid;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, ZL6100_DEVICE_ID,
+					device_id);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read device ID\n");
+		return ret;
+	}
+	device_id[ret] = '\0';
+	dev_info(&client->dev, "Device ID %s\n", device_id);
+
+	mid = NULL;
+	for (mid = zl6100_id; mid->name[0]; mid++) {
+		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
+			break;
+	}
+	if (!mid->name[0]) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+	if (id->driver_data != mid->driver_data)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   id->name, mid->name);
+
+	data = kzalloc(sizeof(struct zl6100_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = mid->driver_data;
+
+	/*
+	 * ZL2008, ZL2105, and ZL6100 are known to require a wait time
+	 * between I2C accesses. ZL2004 and ZL6105 are known to be safe.
+	 *
+	 * Only clear the wait time for chips known to be safe. The wait time
+	 * can be cleared later for additional chips if tests show that it
+	 * is not needed (in other words, better be safe than sorry).
+	 */
+	if (data->id = zl2004 || data->id = zl6105)
+		delay = 0;
+
+	/*
+	 * Since there was a direct I2C device access above, wait before
+	 * accessing the chip again.
+	 * Set the timestamp, wait, then set it again. This should provide
+	 * enough buffer time to be safe.
+	 */
+	data->access = ktime_get();
+	zl6100_wait(data);
+	data->access = ktime_get();
+
+	info = &data->info;
+
+	info->pages = 1;
+	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+	  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+	  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+
+	info->read_word_data = zl6100_read_word_data;
+	info->read_byte_data = zl6100_read_byte_data;
+	info->write_word_data = zl6100_write_word_data;
+	info->write_byte = zl6100_write_byte;
+
+	ret = pmbus_do_probe(client, mid, info);
+	if (ret)
+		goto err_mem;
+	return 0;
+
+err_mem:
+	kfree(data);
+	return ret;
+}
+
+static int zl6100_remove(struct i2c_client *client)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct zl6100_data *data = to_zl6100_data(info);
+
+	pmbus_do_remove(client);
+	kfree(data);
+	return 0;
+}
+
+static struct i2c_driver zl6100_driver = {
+	.driver = {
+		   .name = "zl6100",
+		   },
+	.probe = zl6100_probe,
+	.remove = zl6100_remove,
+	.id_table = zl6100_id,
+};
+
+static int __init zl6100_init(void)
+{
+	return i2c_add_driver(&zl6100_driver);
+}
+
+static void __exit zl6100_exit(void)
+{
+	i2c_del_driver(&zl6100_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for ZL6100 and compatibles");
+MODULE_LICENSE("GPL");
+module_init(zl6100_init);
+module_exit(zl6100_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
