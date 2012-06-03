From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 03 Jun 2012 20:17:15 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (ina2xx) Use structure array to distinguish chip types
Message-Id: <1338754636-20376-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replace per-device initialization and per-device calculation code with
per-device configuration data, which is then used to configure the chip and
perform calculations based on that data.

Also use i2c_smbus_write_read_swapped i2c_smbus_write_word_swapped to read and
write word swapped I2C data.

This patch reduces code size by more than 400 bytes on x86_64.

Cc: Lothar Felten <l-felten@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ina2xx.c |  168 ++++++++++++++++--------------------------------
 1 files changed, 55 insertions(+), 113 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 7f3f4a3..eb42e8b 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -57,8 +57,19 @@
 
 enum ina2xx_ids { ina219, ina226 };
 
+struct ina2xx_config {
+	u16 config;
+	int calibration_factor;
+	int registers;
+	int shunt_div;
+	int bus_voltage_shift;
+	int bus_voltage_lsb;	/* uV */
+	int power_lsb;		/* uW */
+};
+
 struct ina2xx_data {
 	struct device *hwmon_dev;
+	struct ina2xx_config *config;
 
 	struct mutex update_lock;
 	bool valid;
@@ -69,21 +80,26 @@ struct ina2xx_data {
 	u16 regs[INA2XX_MAX_REGISTERS];
 };
 
-int ina2xx_read_word(struct i2c_client *client, int reg)
-{
-	int val = i2c_smbus_read_word_data(client, reg);
-	if (unlikely(val < 0)) {
-		dev_dbg(&client->dev,
-			"Failed to read register: %d\n", reg);
-		return val;
-	}
-	return be16_to_cpu(val);
-}
-
-void ina2xx_write_word(struct i2c_client *client, int reg, int data)
-{
-	i2c_smbus_write_word_data(client, reg, cpu_to_be16(data));
-}
+static struct ina2xx_config ina2xx_config[] = {
+	[ina219] = {
+		.config = INA219_CONFIG_DEFAULT,
+		.calibration_factor = 40960000,
+		.registers = INA219_REGISTERS,
+		.shunt_div = 100,
+		.bus_voltage_shift = 3,
+		.bus_voltage_lsb = 4000,
+		.power_lsb = 20000,
+	},
+	[ina226] = {
+		.config = INA226_CONFIG_DEFAULT,
+		.calibration_factor = 5120000,
+		.registers = INA226_REGISTERS,
+		.shunt_div = 400,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = 1250,
+		.power_lsb = 25000,
+	},
+};
 
 static struct ina2xx_data *ina2xx_update_device(struct device *dev)
 {
@@ -102,7 +118,7 @@ static struct ina2xx_data *ina2xx_update_device(struct device *dev)
 
 		/* Read all registers */
 		for (i = 0; i < data->registers; i++) {
-			int rv = ina2xx_read_word(client, i);
+			int rv = i2c_smbus_read_word_swapped(client, i);
 			if (rv < 0) {
 				ret = ERR_PTR(rv);
 				goto abort;
@@ -117,73 +133,25 @@ abort:
 	return ret;
 }
 
-static int ina219_get_value(struct ina2xx_data *data, u8 reg)
-{
-	/*
-	 * calculate exact value for the given register
-	 * we assume default power-on reset settings:
-	 * bus voltage range 32V
-	 * gain = /8
-	 * adc 1 & 2 -> conversion time 532uS
-	 * mode is continuous shunt and bus
-	 * calibration value is INA219_CALIBRATION_VALUE
-	 */
-	int val = data->regs[reg];
-
-	switch (reg) {
-	case INA2XX_SHUNT_VOLTAGE:
-		/* LSBuV. Convert to mV. */
-		val = DIV_ROUND_CLOSEST(val, 100);
-		break;
-	case INA2XX_BUS_VOLTAGE:
-		/* LSB=4mV. Register is not right aligned, convert to mV. */
-		val = (val >> 3) * 4;
-		break;
-	case INA2XX_POWER:
-		/* LSB mW. Convert to uW */
-		val = val * 20 * 1000;
-		break;
-	case INA2XX_CURRENT:
-		/* LSB=1mA (selected). Is in mA */
-		break;
-	default:
-		/* programmer goofed */
-		WARN_ON_ONCE(1);
-		val = 0;
-		break;
-	}
-
-	return val;
-}
-
-static int ina226_get_value(struct ina2xx_data *data, u8 reg)
+static int ina2xx_get_value(struct ina2xx_data *data, u8 reg)
 {
-	/*
-	 * calculate exact value for the given register
-	 * we assume default power-on reset settings:
-	 * bus voltage range 32V
-	 * gain = /8
-	 * adc 1 & 2 -> conversion time 532uS
-	 * mode is continuous shunt and bus
-	 * calibration value is INA226_CALIBRATION_VALUE
-	 */
-	int val = data->regs[reg];
+	int val;
 
 	switch (reg) {
 	case INA2XX_SHUNT_VOLTAGE:
-		/* LSB=2.5uV. Convert to mV. */
-		val = DIV_ROUND_CLOSEST(val, 400);
+		val = DIV_ROUND_CLOSEST(data->regs[reg],
+					data->config->shunt_div);
 		break;
 	case INA2XX_BUS_VOLTAGE:
-		/* LSB=1.25mV. Convert to mV. */
-		val = val + DIV_ROUND_CLOSEST(val, 4);
+		val = (data->regs[reg] >> data->config->bus_voltage_shift)
+		  * data->config->bus_voltage_lsb / 1000;
 		break;
 	case INA2XX_POWER:
-		/* LSB%mW. Convert to uW */
-		val = val * 25 * 1000;
+		val = data->regs[reg] * data->config->power_lsb;
 		break;
 	case INA2XX_CURRENT:
 		/* LSB=1mA (selected). Is in mA */
+		val = data->regs[reg];
 		break;
 	default:
 		/* programmer goofed */
@@ -200,23 +168,12 @@ static ssize_t ina2xx_show_value(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ina2xx_data *data = ina2xx_update_device(dev);
-	int value = 0;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	switch (data->kind) {
-	case ina219:
-		value = ina219_get_value(data, attr->index);
-		break;
-	case ina226:
-		value = ina226_get_value(data, attr->index);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ina2xx_get_value(data, attr->index));
 }
 
 /* shunt voltage */
@@ -254,7 +211,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct ina2xx_data *data;
 	struct ina2xx_platform_data *pdata;
-	int ret = 0;
+	int ret;
 	long shunt = 10000; /* default shunt value 10mOhms */
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -275,34 +232,16 @@ static int ina2xx_probe(struct i2c_client *client,
 
 	/* set the device type */
 	data->kind = id->driver_data;
+	data->config = &ina2xx_config[data->kind];
 
-	switch (data->kind) {
-	case ina219:
-		/* device configuration */
-		ina2xx_write_word(client, INA2XX_CONFIG, INA219_CONFIG_DEFAULT);
-
-		/* set current LSB to 1mA, shunt is in uOhms */
-		/* (equation 13 in datasheet) */
-		ina2xx_write_word(client, INA2XX_CALIBRATION, 40960000 / shunt);
-		dev_info(&client->dev,
-			 "power monitor INA219 (Rshunt = %li uOhm)\n", shunt);
-		data->registers = INA219_REGISTERS;
-		break;
-	case ina226:
-		/* device configuration */
-		ina2xx_write_word(client, INA2XX_CONFIG, INA226_CONFIG_DEFAULT);
-
-		/* set current LSB to 1mA, shunt is in uOhms */
-		/* (equation 1 in datasheet)*/
-		ina2xx_write_word(client, INA2XX_CALIBRATION, 5120000 / shunt);
-		dev_info(&client->dev,
-			 "power monitor INA226 (Rshunt = %li uOhm)\n", shunt);
-		data->registers = INA226_REGISTERS;
-		break;
-	default:
-		/* unknown device id */
-		return -ENODEV;
-	}
+	/* device configuration */
+	i2c_smbus_write_word_swapped(client, INA2XX_CONFIG,
+				     data->config->config);
+	/* set current LSB to 1mA, shunt is in uOhms */
+	/* (equation 13 in datasheet) */
+	i2c_smbus_write_word_swapped(client, INA2XX_CALIBRATION,
+				     data->config->calibration_factor / shunt);
+	data->registers = data->config->registers;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -317,6 +256,9 @@ static int ina2xx_probe(struct i2c_client *client,
 		goto out_err_hwmon;
 	}
 
+	dev_info(&client->dev, "power monitor %s (Rshunt = %li uOhm)\n",
+		 id->name, shunt);
+
 	return 0;
 
 out_err_hwmon:
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
