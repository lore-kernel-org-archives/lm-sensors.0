From: <atull@opensource.altera.com>
Date: Wed, 15 Oct 2014 18:55:10 +0000
Subject: [lm-sensors] [PATCH v6 4/4] pmbus: ltc2978: add regulator support
Message-Id: <1413399310-19277-5-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Add simple on/off regulator support for ltc2978 and
other pmbus parts supported by ltc2978.c

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>
---
v2: Remove '#include <linux/regulator/machine.h>'
    Only one regulator per pmbus device
    Get regulator_init_data from pdata or device tree

v3: Support multiple regulators for each chip
    Move most code to pmbus_core.c
    fixed values for on/off

v4: fix a #endif comment
    simplify probe code, remove added switch statement
    remove BUG_ON(), add error message and fix num_regulators

v5: Kconfig: update list of supported chips
    use "regulator: of: Provide simplified DT parsing method"
    remove #include <linux/regulator/of_regulator.h>
    remove of_regulator_match

v6: add compatible strings with vendor code
    s/vout_en/vout/
---
 drivers/hwmon/pmbus/Kconfig   |   11 +++++++++--
 drivers/hwmon/pmbus/ltc2978.c |   39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 6e1e493..a674cd8 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -47,15 +47,22 @@ config SENSORS_LM25066
 	  be called lm25066.
 
 config SENSORS_LTC2978
-	tristate "Linear Technologies LTC2974, LTC2978, LTC3880, and LTC3883"
+	tristate "Linear Technologies LTC2978 and compatibles"
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2974, LTC2978, LTC3880, and LTC3883.
+	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, and LTM4676.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
 
+config SENSORS_LTC2978_REGULATOR
+	boolean "Regulator support for LTC2978 and compatibles"
+	depends on SENSORS_LTC2978 && REGULATOR
+	help
+	  If you say yes here you get regulator support for Linear
+	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, and LTM4676.
+
 config SENSORS_MAX16064
 	tristate "Maxim MAX16064"
 	default n
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index e24ed52..0835050 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/regulator/driver.h>
 #include "pmbus.h"
 
 enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883, ltm4676 };
@@ -374,6 +375,19 @@ static const struct i2c_device_id ltc2978_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ltc2978_id);
 
+#if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
+static const struct regulator_desc ltc2978_reg_desc[] = {
+	PMBUS_REGULATOR("vout", 0),
+	PMBUS_REGULATOR("vout", 1),
+	PMBUS_REGULATOR("vout", 2),
+	PMBUS_REGULATOR("vout", 3),
+	PMBUS_REGULATOR("vout", 4),
+	PMBUS_REGULATOR("vout", 5),
+	PMBUS_REGULATOR("vout", 6),
+	PMBUS_REGULATOR("vout", 7),
+};
+#endif /* CONFIG_SENSORS_LTC2978_REGULATOR */
+
 static int ltc2978_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -487,13 +501,36 @@ static int ltc2978_probe(struct i2c_client *client,
 	default:
 		return -ENODEV;
 	}
+
+#if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
+	info->num_regulators = info->pages;
+	info->reg_desc = ltc2978_reg_desc;
+	if (info->num_regulators > ARRAY_SIZE(ltc2978_reg_desc)) {
+		dev_err(&client->dev, "num_regulators too large!");
+		info->num_regulators = ARRAY_SIZE(ltc2978_reg_desc);
+	}
+#endif
+
 	return pmbus_do_probe(client, id, info);
 }
 
-/* This is the driver that will be inserted */
+#ifdef CONFIG_OF
+static const struct of_device_id ltc2978_of_match[] = {
+	{ .compatible = "lltc,ltc2974" },
+	{ .compatible = "lltc,ltc2977" },
+	{ .compatible = "lltc,ltc2978" },
+	{ .compatible = "lltc,ltc3880" },
+	{ .compatible = "lltc,ltc3883" },
+	{ .compatible = "lltc,ltm4676" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2978_of_match);
+#endif
+
 static struct i2c_driver ltc2978_driver = {
 	.driver = {
 		   .name = "ltc2978",
+		   .of_match_table = of_match_ptr(ltc2978_of_match),
 		   },
 	.probe = ltc2978_probe,
 	.remove = pmbus_do_remove,
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
