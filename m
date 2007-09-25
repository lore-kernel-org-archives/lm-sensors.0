From: David Brownell <david-b@pacbell.net>
Date: Tue, 25 Sep 2007 05:23:07 +0000
Subject: [lm-sensors] [patch 2.6.23-rc8 3/3] lm75: use 12 bit samples
Message-Id: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the lm75 driver so that use the best resolution available on
each chip it finds ... usually this is 12 bits (0.0625 degrees C),
though some chips only handle the original 9 bits.

Note that this preserves the quirky "round away from zero" behavior
for converting temperatures to sensor values.  (I'd think no rounding
at all would be better.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/hwmon/Kconfig |    4 +++-
 drivers/hwmon/lm75.c  |   38 +++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 8 deletions(-)

--- a/drivers/hwmon/Kconfig	2007-09-24 21:59:42.000000000 -0700
+++ b/drivers/hwmon/Kconfig	2007-09-24 21:59:58.000000000 -0700
@@ -313,7 +313,9 @@ config SENSORS_LM75
 		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
 
 	  This driver supports driver model based binding through board
-	  specific I2C device tables.
+	  specific I2C device tables.  When those tables report a chip
+	  type that's recognized as supporting it, this driver uses 12-bit
+	  sample resolution (to 1/16 degree C).
 
 	  It also supports the "legacy" style of driver binding.  To use
 	  that with some chips which don't replicate lm75 quirks exactly,
--- a/drivers/hwmon/lm75.c	2007-09-24 21:59:54.000000000 -0700
+++ b/drivers/hwmon/lm75.c	2007-09-24 21:59:58.000000000 -0700
@@ -27,7 +27,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include "lm75.h"
 
 
 /*
@@ -65,6 +64,7 @@ struct lm75_data {
 						   0 = input
 						   1 = max
 						   2 = hyst */
+	u16			round;		/* f(resolution) */
 };
 
 static int lm75_read_value(struct i2c_client *client, u8 reg);
@@ -74,7 +74,7 @@ static struct lm75_data *lm75_update_dev
 
 /*-----------------------------------------------------------------------*/
 
-/* sysfs attributes for hwmon */
+/* sysfs attributes for hwmon, handling any sample resolution */
 
 static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
 {
@@ -83,12 +83,17 @@ static inline s16 temp_to_reg(struct lm7
 	else if (temp > lm75->max)
 		temp = lm75->max;
 
-	return LM75_TEMP_TO_REG(temp);
+	/* this "rounding" is squirrely but backwards-compatible */
+	temp += (temp < 0) ? -lm75->round : lm75->round;
+	return (temp * 256) / 1000;
 }
 
 static inline int reg_to_temp(s16 reg)
 {
-	return LM75_TEMP_FROM_REG(reg);
+	/* Use integer division instead of logical right shift to
+	 * preserve sign (compiler uses arithmetic right shift).
+	 */
+	return (reg * 1000) / 256;
 }
 
 static ssize_t show_temp(struct device *dev, struct device_attribute *da,
@@ -144,6 +149,7 @@ static int lm75_probe(struct i2c_client 
 	int			status;
 	u8			set_mask, clr_mask;
 	int			new;
+	int			resolution;
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -163,13 +169,28 @@ static int lm75_probe(struct i2c_client 
 	set_mask = 0;
 	clr_mask = (1 << 0)			/* continuous conversions */
 		| (1 << 6) | (1 << 5);		/* 9-bit mode */
+	resolution = 9;
 
 	data->min = -55 * 1000;
 	data->max = 125 * 1000;
 
 	/* for tmp175 or tmp275, use name "tmp75" */
-	if (strcmp(client->name, "tmp75") = 0)
+	if (strcmp(client->name, "tmp75") = 0) {
 		data->min = -40 * 1000;
+		set_mask |= (1 << 6) | (1 << 5);
+		resolution = 12;
+
+	/* for ds1175, use name "ds75". */
+	} else if (strcmp(client->name, "ds75") = 0
+			|| strcmp(client->name, "mcp980x") = 0
+			|| strcmp(client->name, "tmp100") = 0
+			|| strcmp(client->name, "tmp101") = 0
+			) {
+		set_mask |= (1 << 6) | (1 << 5);
+		resolution = 12;
+
+	} else if (strcmp(client->name, "max6626") = 0)
+		resolution = 12;
 
 	/* NOTE:  also need to ensure that the chip is in interrupt mode
 	 * in various cases, and maybe handle SMBALERT#.
@@ -188,6 +209,8 @@ static int lm75_probe(struct i2c_client 
 		lm75_write_value(client, LM75_REG_CONF, new);
 	dev_dbg(&client->dev, "config %02x\n", new);
 
+	data->round = 500 / (1 << (resolution - 8));
+
 	/* Register sysfs hooks */
 	if ((status = sysfs_create_group(&client->dev.kobj, &lm75_group)))
 		goto exit_free;
@@ -198,8 +221,9 @@ static int lm75_probe(struct i2c_client 
 		goto exit_remove;
 	}
 
-	dev_info(&client->dev, "%s: sensor '%s'\n",
-		data->hwmon_dev->bus_id, client->name);
+	dev_info(&client->dev,
+		"%s: sensor '%s', resolution %d millidegrees C\n",
+		data->hwmon_dev->bus_id, client->name, data->round * 2);
 
 	return 0;
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
