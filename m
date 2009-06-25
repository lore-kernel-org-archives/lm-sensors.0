From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 25 Jun 2009 16:11:56 +0000
Subject: [lm-sensors] [RFC] LM75 add regulator support
Message-Id: <4A43A1CC.2040701@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
Data sheet trawling has established that, of the devices listed by
this driver, there are two voltage ranges. (2.7-5.5 or 3-5.5)
This driver uses the i2c id to identify which is need and request that
from a 'vcc' regulator.

What do people think about adding this support?

On the embedded board I'm using this allows the relevant, heavily
shared, supply to only be brought up if module is loaded. 

This obviously only effects devices that supply such a regulator
in their machine config (typically embedded). The fall throughs
on voltage setting failure are to allow for regulator definitions that
don't allow the voltages to be changed.

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 55bd87c..a06025d 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -27,6 +27,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
 #include "lm75.h"
 
 
@@ -81,6 +82,7 @@ struct lm75_data {
 						   0 = input
 						   1 = max
 						   2 = hyst */
+	struct regulator	*reg;
 };
 
 static int lm75_read_value(struct i2c_client *client, u8 reg);
@@ -146,6 +148,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int status;
 	u8 set_mask, clr_mask;
 	int new;
+	int min_voltage;
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -158,6 +161,56 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
+	data->reg = regulator_get(&client->dev, "vcc");
+
+	/* Voltage ranges:
+	 * lm75a 2.7 - 5.5V
+	 * lm75b 3 - 5.5 V
+	 * lm75c 3 - 5.5
+	 * ds1775 2.7 - 5.5V
+	 * ds75 2.7 - 5.5V
+	 * max6625 3 - 5.5V
+	 * max6626 3 - 5.5V
+	 * mcp980x 2.7 - 5.5V
+	 * stds75 2.7 - 5.5V
+	 * tcn75 2.7 - 5.5V
+	 * tmp100 2.7 - 5.5V
+	 * tmp101 2.7 - 5.5V
+	 * tmp175 2.7 - 5.5V
+	 * tmp75 2.7 - 5.5V
+	 * tmp275 2.7 - 5.5V
+	 */
+	if (!IS_ERR(data->reg)) {
+		switch (id->driver_data) {
+		default:
+		case 1: /* lm75 */
+		case max6625:
+		case max6626:
+			min_voltage = 3000000;
+			break;
+		case lm75a:
+		case ds1775:
+		case ds75:
+		case mcp980x:
+		case stds75:
+		case tcn75:
+		case tmp100:
+		case tmp101:
+		case tmp175:
+		case tmp75:
+		case tmp275:
+			min_voltage = 2700000;
+			break;
+		}
+		status = regulator_set_voltage(data->reg,
+					       min_voltage,
+					       5500000);
+		if (status)
+			dev_info(&client->dev, "could not set voltage\n");
+		status = regulator_enable(data->reg);
+		if (status)
+			dev_info(&client->dev, "could not enable regulator\n");
+	}
 	/* Set to LM75 resolution (9 bits, 1/2 degree C) and range.
 	 * Then tweak to be more precise when appropriate.
 	 */
@@ -210,6 +263,10 @@ static int lm75_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
 	i2c_set_clientdata(client, NULL);
+	if (!IS_ERR(data->reg)) {
+		regulator_disable(data->reg);
+		regulator_put(data->reg);
+	}
 	kfree(data);
 	return 0;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
