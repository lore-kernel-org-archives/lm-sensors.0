From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Jan 2014 23:08:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Fix driver to work on standard PCs with CONFIG_REGULATOR enabled
Message-Id: <1390777731-10277-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Ubuntu systems with CONFIG_REGULATOR enabled, the lm90 driver fails to load
with an error mesage such as

i2c 1-0018: Driver lm90 requests probe deferral

This is a result of commit 3e0f964f2ad (hwmon: (lm90) Add power control)
which adds mandatory regulator support to the lm90 driver. On non-dt systems
with CONFIG_REGULATOR enabled, this fails if regulators are not fully
specified. This is the case on a standard PC system.

To fix the problem, make the regulator on non-dt systems optional.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index bc41682..51932da 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1520,15 +1520,23 @@ static int lm90_probe(struct i2c_client *client,
 	struct regulator *regulator;
 	int err;
 
+	/*
+	 * On non-dt systems, the regulator subsystem expects regulators
+	 * to be fully constrained if enabled, which is an unreasonable
+	 * expectation from the perspective of this driver.
+	 * Therefore, ignore errors on such systems.
+	 */
 	regulator = devm_regulator_get(dev, "vcc");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err = regulator_enable(regulator);
-	if (err < 0) {
-		dev_err(&client->dev,
-			"Failed to enable regulator: %d\n", err);
-		return err;
+	if (IS_ERR(regulator)) {
+		if (IS_ENABLED(CONFIG_OF))
+			return PTR_ERR(regulator);
+	} else {
+		err = regulator_enable(regulator);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"Failed to enable regulator: %d\n", err);
+			return err;
+		}
 	}
 
 	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
@@ -1621,7 +1629,8 @@ exit_remove_files:
 	lm90_remove_files(client, data);
 exit_restore:
 	lm90_restore_conf(client, data);
-	regulator_disable(data->regulator);
+	if (!IS_ERR_OR_NULL(data->regulator))
+		regulator_disable(data->regulator);
 
 	return err;
 }
@@ -1633,7 +1642,8 @@ static int lm90_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	lm90_remove_files(client, data);
 	lm90_restore_conf(client, data);
-	regulator_disable(data->regulator);
+	if (!IS_ERR_OR_NULL(data->regulator))
+		regulator_disable(data->regulator);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
