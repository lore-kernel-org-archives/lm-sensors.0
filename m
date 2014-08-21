From: <atull@opensource.altera.com>
Date: Thu, 21 Aug 2014 22:21:25 +0000
Subject: [lm-sensors] [PATCH 1/2] pmbus: add regulator support
Message-Id: <1408659686-29106-2-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408659686-29106-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1408659686-29106-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Enable pmbus device drivers to add regulator functionality.

To add a regulator, it's pretty straightforward.  The pmbus
device driver needs to add regulator information to its
pmbus_driver_info struct:

 * num_regulators : number of regulators
 * reg_init       : array of struct regulator_init_data
 * reg_desc       : array of struct regulator_desc

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 drivers/hwmon/pmbus/pmbus.h      |    7 +++++++
 drivers/hwmon/pmbus/pmbus_core.c |   40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index fa9beb3..a45722f 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -19,6 +19,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/regulator/driver.h>
+
 #ifndef PMBUS_H
 #define PMBUS_H
 
@@ -365,6 +367,11 @@ struct pmbus_driver_info {
 	 */
 	int (*identify)(struct i2c_client *client,
 			struct pmbus_driver_info *info);
+
+	/* Regulator functionality, if supported by this chip driver. */
+	int num_regulators;
+	struct regulator_init_data *reg_init;
+	const struct regulator_desc *reg_desc;
 };
 
 /* Function declarations */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 291d11f..10315ee 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -29,6 +29,8 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
 #include <linux/i2c/pmbus.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include "pmbus.h"
 
 /*
@@ -1727,6 +1729,39 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_REGULATOR)
+static int pmbus_register_regulators(struct pmbus_data *data)
+{
+	struct regulator_dev *rdev;
+	struct regulator_config config = { };
+	const struct pmbus_driver_info *info = data->info;
+	struct device *dev = data->dev;
+	int i;
+
+	config.dev = dev;
+	config.driver_data = data;
+
+	for (i = 0; i < info->num_regulators; i++) {
+		config.init_data = &info->reg_init[i];
+		rdev = devm_regulator_register(dev, &info->reg_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "failed to register regulator %s\n",
+				info->reg_desc[i].name);
+			hwmon_device_unregister(data->hwmon_dev);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+#else
+static int pmbus_register_regulators(struct pmbus_data *data)
+{
+	return 0;
+}
+#endif
+
 int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		   struct pmbus_driver_info *info)
 {
@@ -1781,6 +1816,11 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		dev_err(dev, "Failed to register hwmon device\n");
 		goto out_kfree;
 	}
+
+	ret = pmbus_register_regulators(data);
+	if (ret)
+		goto out_kfree;
+
 	return 0;
 
 out_kfree:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
