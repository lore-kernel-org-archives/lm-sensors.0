From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 10 Jul 2015 05:00:08 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: pmbus: Constify pmbus_regulator_ops
Message-Id: <1436504408.17707.2.camel@ingics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pmbus_regulator_ops is not modified after initialized, so make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/pmbus/pmbus.h      | 2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 21f8b2f..58262b5 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -380,7 +380,7 @@ struct pmbus_driver_info {
 
 /* Regulator ops */
 
-extern struct regulator_ops pmbus_regulator_ops;
+extern const struct regulator_ops pmbus_regulator_ops;
 
 /* Macro for filling in array of struct regulator_desc */
 #define PMBUS_REGULATOR(_name, _id)				\
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f2e47c7..12d85b1 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1796,7 +1796,7 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
 	return _pmbus_regulator_on_off(rdev, 0);
 }
 
-struct regulator_ops pmbus_regulator_ops = {
+const struct regulator_ops pmbus_regulator_ops = {
 	.enable = pmbus_regulator_enable,
 	.disable = pmbus_regulator_disable,
 	.is_enabled = pmbus_regulator_is_enabled,
-- 
2.1.0




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
