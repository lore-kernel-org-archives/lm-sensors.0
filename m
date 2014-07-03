From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:51:43 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm1026) Avoid forward declaration
Message-Id: <1404395503.4895.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1026.c | 452 +++++++++++++++++++++++-------------------------
 1 file changed, 219 insertions(+), 233 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index b3498ac..cf3ed299 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -298,37 +298,6 @@ struct adm1026_data {
 	u8 config3;		/* Register value */
 };
 
-static int adm1026_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int adm1026_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
-static int adm1026_remove(struct i2c_client *client);
-static int adm1026_read_value(struct i2c_client *client, u8 reg);
-static int adm1026_write_value(struct i2c_client *client, u8 reg, int value);
-static void adm1026_print_gpio(struct i2c_client *client);
-static void adm1026_fixup_gpio(struct i2c_client *client);
-static struct adm1026_data *adm1026_update_device(struct device *dev);
-static void adm1026_init_client(struct i2c_client *client);
-
-
-static const struct i2c_device_id adm1026_id[] = {
-	{ "adm1026", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1026_id);
-
-static struct i2c_driver adm1026_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "adm1026",
-	},
-	.probe		= adm1026_probe,
-	.remove		= adm1026_remove,
-	.id_table	= adm1026_id,
-	.detect		= adm1026_detect,
-	.address_list	= normal_i2c,
-};
-
 static int adm1026_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
@@ -357,208 +326,6 @@ static int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
 	return res;
 }
 
-static void adm1026_init_client(struct i2c_client *client)
-{
-	int value, i;
-	struct adm1026_data *data = i2c_get_clientdata(client);
-
-	dev_dbg(&client->dev, "Initializing device\n");
-	/* Read chip config */
-	data->config1 = adm1026_read_value(client, ADM1026_REG_CONFIG1);
-	data->config2 = adm1026_read_value(client, ADM1026_REG_CONFIG2);
-	data->config3 = adm1026_read_value(client, ADM1026_REG_CONFIG3);
-
-	/* Inform user of chip config */
-	dev_dbg(&client->dev, "ADM1026_REG_CONFIG1 is: 0x%02x\n",
-		data->config1);
-	if ((data->config1 & CFG1_MONITOR) = 0) {
-		dev_dbg(&client->dev,
-			"Monitoring not currently enabled.\n");
-	}
-	if (data->config1 & CFG1_INT_ENABLE) {
-		dev_dbg(&client->dev,
-			"SMBALERT interrupts are enabled.\n");
-	}
-	if (data->config1 & CFG1_AIN8_9) {
-		dev_dbg(&client->dev,
-			"in8 and in9 enabled. temp3 disabled.\n");
-	} else {
-		dev_dbg(&client->dev,
-			"temp3 enabled.  in8 and in9 disabled.\n");
-	}
-	if (data->config1 & CFG1_THERM_HOT) {
-		dev_dbg(&client->dev,
-			"Automatic THERM, PWM, and temp limits enabled.\n");
-	}
-
-	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev,
-			"GPIO16 enabled.  THERM pin disabled.\n");
-	} else {
-		dev_dbg(&client->dev,
-			"THERM pin enabled.  GPIO16 disabled.\n");
-	}
-	if (data->config3 & CFG3_VREF_250)
-		dev_dbg(&client->dev, "Vref is 2.50 Volts.\n");
-	else
-		dev_dbg(&client->dev, "Vref is 1.82 Volts.\n");
-	/* Read and pick apart the existing GPIO configuration */
-	value = 0;
-	for (i = 0; i <= 15; ++i) {
-		if ((i & 0x03) = 0) {
-			value = adm1026_read_value(client,
-					ADM1026_REG_GPIO_CFG_0_3 + i / 4);
-		}
-		data->gpio_config[i] = value & 0x03;
-		value >>= 2;
-	}
-	data->gpio_config[16] = (data->config3 >> 6) & 0x03;
-
-	/* ... and then print it */
-	adm1026_print_gpio(client);
-
-	/*
-	 * If the user asks us to reprogram the GPIO config, then
-	 * do it now.
-	 */
-	if (gpio_input[0] != -1 || gpio_output[0] != -1
-		|| gpio_inverted[0] != -1 || gpio_normal[0] != -1
-		|| gpio_fan[0] != -1) {
-		adm1026_fixup_gpio(client);
-	}
-
-	/*
-	 * WE INTENTIONALLY make no changes to the limits,
-	 *   offsets, pwms, fans and zones.  If they were
-	 *   configured, we don't want to mess with them.
-	 *   If they weren't, the default is 100% PWM, no
-	 *   control and will suffice until 'sensors -s'
-	 *   can be run by the user.  We DO set the default
-	 *   value for pwm1.auto_pwm_min to its maximum
-	 *   so that enabling automatic pwm fan control
-	 *   without first setting a value for pwm1.auto_pwm_min
-	 *   will not result in potentially dangerous fan speed decrease.
-	 */
-	data->pwm1.auto_pwm_min = 255;
-	/* Start monitoring */
-	value = adm1026_read_value(client, ADM1026_REG_CONFIG1);
-	/* Set MONITOR, clear interrupt acknowledge and s/w reset */
-	value = (value | CFG1_MONITOR) & (~CFG1_INT_CLEAR & ~CFG1_RESET);
-	dev_dbg(&client->dev, "Setting CONFIG to: 0x%02x\n", value);
-	data->config1 = value;
-	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
-
-	/* initialize fan_div[] to hardware defaults */
-	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
-		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
-	for (i = 0; i <= 7; ++i) {
-		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
-		value >>= 2;
-	}
-}
-
-static void adm1026_print_gpio(struct i2c_client *client)
-{
-	struct adm1026_data *data = i2c_get_clientdata(client);
-	int i;
-
-	dev_dbg(&client->dev, "GPIO config is:\n");
-	for (i = 0; i <= 7; ++i) {
-		if (data->config2 & (1 << i)) {
-			dev_dbg(&client->dev, "\t%sGP%s%d\n",
-				data->gpio_config[i] & 0x02 ? "" : "!",
-				data->gpio_config[i] & 0x01 ? "OUT" : "IN",
-				i);
-		} else {
-			dev_dbg(&client->dev, "\tFAN%d\n", i);
-		}
-	}
-	for (i = 8; i <= 15; ++i) {
-		dev_dbg(&client->dev, "\t%sGP%s%d\n",
-			data->gpio_config[i] & 0x02 ? "" : "!",
-			data->gpio_config[i] & 0x01 ? "OUT" : "IN",
-			i);
-	}
-	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev, "\t%sGP%s16\n",
-			data->gpio_config[16] & 0x02 ? "" : "!",
-			data->gpio_config[16] & 0x01 ? "OUT" : "IN");
-	} else {
-		/* GPIO16 is THERM */
-		dev_dbg(&client->dev, "\tTHERM\n");
-	}
-}
-
-static void adm1026_fixup_gpio(struct i2c_client *client)
-{
-	struct adm1026_data *data = i2c_get_clientdata(client);
-	int i;
-	int value;
-
-	/* Make the changes requested. */
-	/*
-	 * We may need to unlock/stop monitoring or soft-reset the
-	 *    chip before we can make changes.  This hasn't been
-	 *    tested much.  FIXME
-	 */
-
-	/* Make outputs */
-	for (i = 0; i <= 16; ++i) {
-		if (gpio_output[i] >= 0 && gpio_output[i] <= 16)
-			data->gpio_config[gpio_output[i]] |= 0x01;
-		/* if GPIO0-7 is output, it isn't a FAN tach */
-		if (gpio_output[i] >= 0 && gpio_output[i] <= 7)
-			data->config2 |= 1 << gpio_output[i];
-	}
-
-	/* Input overrides output */
-	for (i = 0; i <= 16; ++i) {
-		if (gpio_input[i] >= 0 && gpio_input[i] <= 16)
-			data->gpio_config[gpio_input[i]] &= ~0x01;
-		/* if GPIO0-7 is input, it isn't a FAN tach */
-		if (gpio_input[i] >= 0 && gpio_input[i] <= 7)
-			data->config2 |= 1 << gpio_input[i];
-	}
-
-	/* Inverted */
-	for (i = 0; i <= 16; ++i) {
-		if (gpio_inverted[i] >= 0 && gpio_inverted[i] <= 16)
-			data->gpio_config[gpio_inverted[i]] &= ~0x02;
-	}
-
-	/* Normal overrides inverted */
-	for (i = 0; i <= 16; ++i) {
-		if (gpio_normal[i] >= 0 && gpio_normal[i] <= 16)
-			data->gpio_config[gpio_normal[i]] |= 0x02;
-	}
-
-	/* Fan overrides input and output */
-	for (i = 0; i <= 7; ++i) {
-		if (gpio_fan[i] >= 0 && gpio_fan[i] <= 7)
-			data->config2 &= ~(1 << gpio_fan[i]);
-	}
-
-	/* Write new configs to registers */
-	adm1026_write_value(client, ADM1026_REG_CONFIG2, data->config2);
-	data->config3 = (data->config3 & 0x3f)
-			| ((data->gpio_config[16] & 0x03) << 6);
-	adm1026_write_value(client, ADM1026_REG_CONFIG3, data->config3);
-	for (i = 15, value = 0; i >= 0; --i) {
-		value <<= 2;
-		value |= data->gpio_config[i] & 0x03;
-		if ((i & 0x03) = 0) {
-			adm1026_write_value(client,
-					ADM1026_REG_GPIO_CFG_0_3 + i/4,
-					value);
-			value = 0;
-		}
-	}
-
-	/* Print the new config */
-	adm1026_print_gpio(client);
-}
-
-
 static struct adm1026_data *adm1026_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1829,6 +1596,207 @@ static int adm1026_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void adm1026_print_gpio(struct i2c_client *client)
+{
+	struct adm1026_data *data = i2c_get_clientdata(client);
+	int i;
+
+	dev_dbg(&client->dev, "GPIO config is:\n");
+	for (i = 0; i <= 7; ++i) {
+		if (data->config2 & (1 << i)) {
+			dev_dbg(&client->dev, "\t%sGP%s%d\n",
+				data->gpio_config[i] & 0x02 ? "" : "!",
+				data->gpio_config[i] & 0x01 ? "OUT" : "IN",
+				i);
+		} else {
+			dev_dbg(&client->dev, "\tFAN%d\n", i);
+		}
+	}
+	for (i = 8; i <= 15; ++i) {
+		dev_dbg(&client->dev, "\t%sGP%s%d\n",
+			data->gpio_config[i] & 0x02 ? "" : "!",
+			data->gpio_config[i] & 0x01 ? "OUT" : "IN",
+			i);
+	}
+	if (data->config3 & CFG3_GPIO16_ENABLE) {
+		dev_dbg(&client->dev, "\t%sGP%s16\n",
+			data->gpio_config[16] & 0x02 ? "" : "!",
+			data->gpio_config[16] & 0x01 ? "OUT" : "IN");
+	} else {
+		/* GPIO16 is THERM */
+		dev_dbg(&client->dev, "\tTHERM\n");
+	}
+}
+
+static void adm1026_fixup_gpio(struct i2c_client *client)
+{
+	struct adm1026_data *data = i2c_get_clientdata(client);
+	int i;
+	int value;
+
+	/* Make the changes requested. */
+	/*
+	 * We may need to unlock/stop monitoring or soft-reset the
+	 *    chip before we can make changes.  This hasn't been
+	 *    tested much.  FIXME
+	 */
+
+	/* Make outputs */
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_output[i] >= 0 && gpio_output[i] <= 16)
+			data->gpio_config[gpio_output[i]] |= 0x01;
+		/* if GPIO0-7 is output, it isn't a FAN tach */
+		if (gpio_output[i] >= 0 && gpio_output[i] <= 7)
+			data->config2 |= 1 << gpio_output[i];
+	}
+
+	/* Input overrides output */
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_input[i] >= 0 && gpio_input[i] <= 16)
+			data->gpio_config[gpio_input[i]] &= ~0x01;
+		/* if GPIO0-7 is input, it isn't a FAN tach */
+		if (gpio_input[i] >= 0 && gpio_input[i] <= 7)
+			data->config2 |= 1 << gpio_input[i];
+	}
+
+	/* Inverted */
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_inverted[i] >= 0 && gpio_inverted[i] <= 16)
+			data->gpio_config[gpio_inverted[i]] &= ~0x02;
+	}
+
+	/* Normal overrides inverted */
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_normal[i] >= 0 && gpio_normal[i] <= 16)
+			data->gpio_config[gpio_normal[i]] |= 0x02;
+	}
+
+	/* Fan overrides input and output */
+	for (i = 0; i <= 7; ++i) {
+		if (gpio_fan[i] >= 0 && gpio_fan[i] <= 7)
+			data->config2 &= ~(1 << gpio_fan[i]);
+	}
+
+	/* Write new configs to registers */
+	adm1026_write_value(client, ADM1026_REG_CONFIG2, data->config2);
+	data->config3 = (data->config3 & 0x3f)
+			| ((data->gpio_config[16] & 0x03) << 6);
+	adm1026_write_value(client, ADM1026_REG_CONFIG3, data->config3);
+	for (i = 15, value = 0; i >= 0; --i) {
+		value <<= 2;
+		value |= data->gpio_config[i] & 0x03;
+		if ((i & 0x03) = 0) {
+			adm1026_write_value(client,
+					ADM1026_REG_GPIO_CFG_0_3 + i/4,
+					value);
+			value = 0;
+		}
+	}
+
+	/* Print the new config */
+	adm1026_print_gpio(client);
+}
+
+static void adm1026_init_client(struct i2c_client *client)
+{
+	int value, i;
+	struct adm1026_data *data = i2c_get_clientdata(client);
+
+	dev_dbg(&client->dev, "Initializing device\n");
+	/* Read chip config */
+	data->config1 = adm1026_read_value(client, ADM1026_REG_CONFIG1);
+	data->config2 = adm1026_read_value(client, ADM1026_REG_CONFIG2);
+	data->config3 = adm1026_read_value(client, ADM1026_REG_CONFIG3);
+
+	/* Inform user of chip config */
+	dev_dbg(&client->dev, "ADM1026_REG_CONFIG1 is: 0x%02x\n",
+		data->config1);
+	if ((data->config1 & CFG1_MONITOR) = 0) {
+		dev_dbg(&client->dev,
+			"Monitoring not currently enabled.\n");
+	}
+	if (data->config1 & CFG1_INT_ENABLE) {
+		dev_dbg(&client->dev,
+			"SMBALERT interrupts are enabled.\n");
+	}
+	if (data->config1 & CFG1_AIN8_9) {
+		dev_dbg(&client->dev,
+			"in8 and in9 enabled. temp3 disabled.\n");
+	} else {
+		dev_dbg(&client->dev,
+			"temp3 enabled.  in8 and in9 disabled.\n");
+	}
+	if (data->config1 & CFG1_THERM_HOT) {
+		dev_dbg(&client->dev,
+			"Automatic THERM, PWM, and temp limits enabled.\n");
+	}
+
+	if (data->config3 & CFG3_GPIO16_ENABLE) {
+		dev_dbg(&client->dev,
+			"GPIO16 enabled.  THERM pin disabled.\n");
+	} else {
+		dev_dbg(&client->dev,
+			"THERM pin enabled.  GPIO16 disabled.\n");
+	}
+	if (data->config3 & CFG3_VREF_250)
+		dev_dbg(&client->dev, "Vref is 2.50 Volts.\n");
+	else
+		dev_dbg(&client->dev, "Vref is 1.82 Volts.\n");
+	/* Read and pick apart the existing GPIO configuration */
+	value = 0;
+	for (i = 0; i <= 15; ++i) {
+		if ((i & 0x03) = 0) {
+			value = adm1026_read_value(client,
+					ADM1026_REG_GPIO_CFG_0_3 + i / 4);
+		}
+		data->gpio_config[i] = value & 0x03;
+		value >>= 2;
+	}
+	data->gpio_config[16] = (data->config3 >> 6) & 0x03;
+
+	/* ... and then print it */
+	adm1026_print_gpio(client);
+
+	/*
+	 * If the user asks us to reprogram the GPIO config, then
+	 * do it now.
+	 */
+	if (gpio_input[0] != -1 || gpio_output[0] != -1
+		|| gpio_inverted[0] != -1 || gpio_normal[0] != -1
+		|| gpio_fan[0] != -1) {
+		adm1026_fixup_gpio(client);
+	}
+
+	/*
+	 * WE INTENTIONALLY make no changes to the limits,
+	 *   offsets, pwms, fans and zones.  If they were
+	 *   configured, we don't want to mess with them.
+	 *   If they weren't, the default is 100% PWM, no
+	 *   control and will suffice until 'sensors -s'
+	 *   can be run by the user.  We DO set the default
+	 *   value for pwm1.auto_pwm_min to its maximum
+	 *   so that enabling automatic pwm fan control
+	 *   without first setting a value for pwm1.auto_pwm_min
+	 *   will not result in potentially dangerous fan speed decrease.
+	 */
+	data->pwm1.auto_pwm_min = 255;
+	/* Start monitoring */
+	value = adm1026_read_value(client, ADM1026_REG_CONFIG1);
+	/* Set MONITOR, clear interrupt acknowledge and s/w reset */
+	value = (value | CFG1_MONITOR) & (~CFG1_INT_CLEAR & ~CFG1_RESET);
+	dev_dbg(&client->dev, "Setting CONFIG to: 0x%02x\n", value);
+	data->config1 = value;
+	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+	/* initialize fan_div[] to hardware defaults */
+	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
+		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
+	for (i = 0; i <= 7; ++i) {
+		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+		value >>= 2;
+	}
+}
+
 static int adm1026_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1892,6 +1860,24 @@ static int adm1026_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id adm1026_id[] = {
+	{ "adm1026", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1026_id);
+
+static struct i2c_driver adm1026_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "adm1026",
+	},
+	.probe		= adm1026_probe,
+	.remove		= adm1026_remove,
+	.id_table	= adm1026_id,
+	.detect		= adm1026_detect,
+	.address_list	= normal_i2c,
+};
+
 module_i2c_driver(adm1026_driver);
 
 MODULE_LICENSE("GPL");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
