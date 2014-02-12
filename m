From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 17:41:06 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (max6650) Introduce local 'dev' variable
Message-Id: <1392226866-25968-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This makes the code a bit easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6650.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 74916e7..162a520 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -563,13 +563,14 @@ static const struct attribute_group max6651_group = {
 static int max6650_init_client(struct max6650_data *data,
 			       struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	int config;
 	int err = -EIO;
 
 	config = i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG);
 
 	if (config < 0) {
-		dev_err(&client->dev, "Error reading config, aborting.\n");
+		dev_err(dev, "Error reading config, aborting.\n");
 		return err;
 	}
 
@@ -583,11 +584,11 @@ static int max6650_init_client(struct max6650_data *data,
 		config |= MAX6650_CFG_V12;
 		break;
 	default:
-		dev_err(&client->dev, "illegal value for fan_voltage (%d)\n",
+		dev_err(dev, "illegal value for fan_voltage (%d)\n",
 			fan_voltage);
 	}
 
-	dev_info(&client->dev, "Fan voltage is set to %dV.\n",
+	dev_info(dev, "Fan voltage is set to %dV.\n",
 		 (config & MAX6650_CFG_V12) ? 12 : 5);
 
 	switch (prescaler) {
@@ -613,11 +614,10 @@ static int max6650_init_client(struct max6650_data *data,
 			 | MAX6650_CFG_PRESCALER_16;
 		break;
 	default:
-		dev_err(&client->dev, "illegal value for prescaler (%d)\n",
-			prescaler);
+		dev_err(dev, "illegal value for prescaler (%d)\n", prescaler);
 	}
 
-	dev_info(&client->dev, "Prescaler is set to %d.\n",
+	dev_info(dev, "Prescaler is set to %d.\n",
 		 1 << (config & MAX6650_CFG_PRESCALER_MASK));
 
 	/*
@@ -627,17 +627,17 @@ static int max6650_init_client(struct max6650_data *data,
 	 */
 
 	if ((config & MAX6650_CFG_MODE_MASK) = MAX6650_CFG_MODE_OFF) {
-		dev_dbg(&client->dev, "Change mode to open loop, full off.\n");
+		dev_dbg(dev, "Change mode to open loop, full off.\n");
 		config = (config & ~MAX6650_CFG_MODE_MASK)
 			 | MAX6650_CFG_MODE_OPEN_LOOP;
 		if (i2c_smbus_write_byte_data(client, MAX6650_REG_DAC, 255)) {
-			dev_err(&client->dev, "DAC write error, aborting.\n");
+			dev_err(dev, "DAC write error, aborting.\n");
 			return err;
 		}
 	}
 
 	if (i2c_smbus_write_byte_data(client, MAX6650_REG_CONFIG, config)) {
-		dev_err(&client->dev, "Config write error, aborting.\n");
+		dev_err(dev, "Config write error, aborting.\n");
 		return err;
 	}
 
@@ -650,12 +650,12 @@ static int max6650_init_client(struct max6650_data *data,
 static int max6650_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct max6650_data *data;
 	struct device *hwmon_dev;
 	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct max6650_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -675,7 +675,7 @@ static int max6650_probe(struct i2c_client *client,
 	if (data->nr_fans = 4)
 		data->groups[1] = &max6651_group;
 
-	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
 							   client->name, data,
 							   data->groups);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
