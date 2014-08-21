From: <atull@opensource.altera.com>
Date: Thu, 21 Aug 2014 22:21:26 +0000
Subject: [lm-sensors] [PATCH 2/2] pmbus: ltc2978: add regulator gating
Message-Id: <1408659686-29106-3-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408659686-29106-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1408659686-29106-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Add support for enabling or disabling all supplies.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 drivers/hwmon/pmbus/Kconfig   |    9 ++++++
 drivers/hwmon/pmbus/ltc2978.c |   69 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 6e1e493..c0d98f2 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -56,6 +56,15 @@ config SENSORS_LTC2978
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
 
+config SENSORS_LTC2978_REGULATOR
+	boolean "Regulator support for LTC2974, LTC2978, LTC3880, and LTC3883"
+	default n
+	depends on SENSORS_LTC2978
+	select REGULATOR
+	help
+	  If you say yes here you get regulator support for Linear
+	  Technology LTC2974, LTC2978, LTC3880, and LTC3883.
+
 config SENSORS_MAX16064
 	tristate "Maxim MAX16064"
 	default n
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index e24ed52..1e25346 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include "pmbus.h"
@@ -151,6 +153,66 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
+static int ltc2978_write_pmbus_operation(struct regulator_dev *rdev, u8 value)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	int ret;
+
+	ret = pmbus_set_page(client, 0xff);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_write_byte_data(client, PMBUS_OPERATION, value);
+}
+
+static int ltc2978_enable_all(struct regulator_dev *rdev)
+{
+	return ltc2978_write_pmbus_operation(rdev, 0x80);
+}
+
+static int ltc2978_disable_all(struct regulator_dev *rdev)
+{
+	return ltc2978_write_pmbus_operation(rdev, 0);
+}
+
+static int ltc2978_is_enabled(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	int ret;
+
+	ret = pmbus_set_page(client, 0xff);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, PMBUS_OPERATION);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & 0x80);
+}
+
+static struct regulator_ops ltc2978_regulator_ops = {
+	.enable = ltc2978_enable_all,
+	.disable = ltc2978_disable_all,
+	.is_enabled = ltc2978_is_enabled,
+};
+
+static const struct regulator_desc ltc2978_reg_desc = {
+	.name = "ltc2978",
+	.ops = &ltc2978_regulator_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct regulator_init_data ltc2978_regulator_init = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+#endif
+
 static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
@@ -487,6 +549,13 @@ static int ltc2978_probe(struct i2c_client *client,
 	default:
 		return -ENODEV;
 	}
+
+#if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
+	info->num_regulators = 1;
+	info->reg_desc = &ltc2978_reg_desc;
+	info->reg_init = &ltc2978_regulator_init;
+#endif
+
 	return pmbus_do_probe(client, id, info);
 }
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
