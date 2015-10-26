From: Constantine Shulyupin <const@makelinux.com>
Date: Mon, 26 Oct 2015 20:46:38 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add device tree support
Message-Id: <1445892399-3291-1-git-send-email-const@makelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Constantine Shulyupin <const@makelinux.com>

From: Constantine Shulyupin <const@MakeLinux.com>

Introduced nct7802_platform_data, nct7802_parse_dt,
nct7802_platform_data_set.

Parsing of DT nodes
 - compatible = "nuvoton,nct7802-sensor",
	with "sensor-type" = "thermal-diode" | "thermistor" | "voltage" |
				"local" | "vcc" | "vcore"
 - compatible = "nuvoton,nct7802-fan",
	with boolen properties "direct-current", "invert", "invert"
 - compatible = "nuvoton,nct7802-peci"

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
Changed in v3:
- Removed nuvoton,sensorX-type
- Introduced nct7802_platform_data, new DT parser for sensors, fans, peci,
  vcc, vcore

Changed in v2:
- removed tempX_type
- introduced nuvoton,sensorX-type with string values

Changed in v1:
- Introduced tempX_type with numerical values
---
 drivers/hwmon/nct7802.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 3ce33d2..dee9eb3 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -53,6 +53,8 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
 #define REG_PECI_ENABLE		0x23
 #define REG_FAN_ENABLE		0x24
 #define REG_VMON_ENABLE		0x25
+#define REG_FAN_TYPE		0x5e
+#define REG_FAN_MODE		0x5f
 #define REG_PWM(x)		(0x60 + (x))
 #define REG_SMARTFAN_EN(x)      (0x64 + (x) / 2)
 #define SMARTFAN_EN_SHIFT(x)    ((x) % 2 * 4)
@@ -69,6 +71,18 @@ struct nct7802_data {
 	struct mutex access_lock; /* for multi-byte read and write operations */
 };
 
+struct nct7802_platform_data {
+	s8 sensor_type[3];
+	s8 local_temp_enable;
+	s8 vcc_enable;
+	s8 vcore_enable;
+	s8 fan_enable[3];
+	s8 fan_dc[2];	/* direct current instead PWM */
+	s8 fan_od[3];	/* open drain */
+	s8 fan_inv[3];	/* inverted polarity */
+	s8 peci_enable[2];
+};
+
 static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -1077,6 +1091,151 @@ static const struct regmap_config nct7802_regmap_config = {
 	.volatile_reg = nct7802_regmap_is_volatile,
 };
 
+static int nct7802_parse_dt(struct device_node *node,
+			    struct nct7802_platform_data *pdata)
+{
+	struct device_node *child;
+	const char *sen_type;
+	int ret;
+	int i;
+
+	for_each_child_of_node(node, child) {
+		u32 reg = 0xFF;
+
+		of_property_read_u32(child, "reg", &reg);
+		if (of_device_is_compatible(child, "nuvoton,nct7802-sensor")) {
+			ret = of_property_read_string(child,
+						      "sensor-type", &sen_type);
+			if (ret < 0) {
+				pr_err("%s: expected property sensor-type\n",
+				       child->full_name);
+				return -EINVAL;
+			}
+			if (!strcmp(sen_type, "local")) {
+				pdata->local_temp_enable = 1;
+				continue;
+			} else if (!strcmp(sen_type, "vcc")) {
+				pdata->vcc_enable = 1;
+				continue;
+			} else if (!strcmp(sen_type, "vcore")) {
+				pdata->vcore_enable = 1;
+				continue;
+			}
+			if (reg >= ARRAY_SIZE(pdata->sensor_type)) {
+				pr_err("%s: invalid value: reg=%d\n",
+				       child->full_name, reg);
+				return -EINVAL;
+			}
+			if (!strcmp(sen_type, "thermal-diode")) {
+				pdata->sensor_type[reg] = 1;
+			} else if (!strcmp(sen_type, "thermistor")) {
+				pdata->sensor_type[reg] = 2;
+			} else if (!strcmp(sen_type, "voltage")) {
+				pdata->sensor_type[reg] = 3;
+			} else {
+				pr_err("%s: invalid sensor-type=\"%s\"\n",
+				       child->full_name, sen_type);
+				return -EINVAL;
+			}
+		} else if (of_device_is_compatible(child,
+						   "nuvoton,nct7802-fan")) {
+			if (reg >= ARRAY_SIZE(pdata->fan_enable)) {
+				pr_err("%s: invalid value: %s=%d\n",
+				       child->full_name, "reg", reg);
+				return -EINVAL;
+			}
+			pdata->fan_enable[reg] = 1;
+			if (of_property_read_bool(child, "direct-current")) {
+				if (reg >= ARRAY_SIZE(pdata->fan_dc)) {
+					pr_err("%s: invalid value: %s=%d\n",
+					       child->full_name, "reg", reg);
+					return -EINVAL;
+				}
+				pdata->fan_dc[reg] = 1;
+			}
+			pdata->fan_od[reg] +				of_property_read_bool(child, "open-drain");
+			pdata->fan_inv[reg] +				of_property_read_bool(child, "invert");
+		} else if (of_device_is_compatible(child,
+						   "nuvoton,nct7802-peci")) {
+			if (reg >= ARRAY_SIZE(pdata->peci_enable)) {
+				pr_err("%s: invalid value: reg=%d\n",
+				       child->full_name, reg);
+				return -EINVAL;
+			}
+			pdata->peci_enable[reg] = 1;
+		}
+	}
+
+	return 0;
+}
+
+static int nct7802_platform_data_set(struct nct7802_data *data,
+				     struct nct7802_platform_data *pdata)
+{
+	int ret;
+	int i;
+
+	/* Enable ADC */
+	ret = regmap_update_bits(data->regmap, REG_START, 1, 1);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(pdata->sensor_type); i++) {
+		ret = regmap_update_bits(data->regmap, REG_MODE,
+					 3 << 2 * i,
+					 pdata->sensor_type[i] << 2 * i);
+		if (ret)
+			return ret;
+	}
+	ret = regmap_update_bits(data->regmap, REG_MODE,
+				 1 << 6,
+				 pdata->local_temp_enable << 6);
+	if (ret)
+		return ret;
+	for (i = 0; i < ARRAY_SIZE(pdata->fan_enable); i++) {
+		ret = regmap_update_bits(data->regmap, REG_FAN_ENABLE,
+					 1 << i, pdata->fan_enable[i] << i);
+	}
+	for (i = 0; i < ARRAY_SIZE(pdata->peci_enable); i++) {
+		ret = regmap_update_bits(data->regmap, REG_PECI_ENABLE,
+					 1 << i, pdata->peci_enable[i] << i);
+		if (ret)
+			return ret;
+	}
+	ret = regmap_update_bits(data->regmap, REG_VMON_ENABLE, 1,
+				 pdata->vcc_enable);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, REG_VMON_ENABLE, 1 << 1,
+				 pdata->vcore_enable << 1);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(pdata->fan_dc); i++) {
+		ret = regmap_update_bits(data->regmap, REG_FAN_TYPE, 1 << i,
+					 pdata->fan_dc[i] << i);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < ARRAY_SIZE(pdata->fan_od); i++) {
+		ret = regmap_update_bits(data->regmap, REG_FAN_MODE, 1 << i,
+					 pdata->fan_od[i] << i);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < ARRAY_SIZE(pdata->fan_inv); i++) {
+		ret = regmap_update_bits(data->regmap, REG_FAN_MODE,
+					 1 << (i + 4),
+					 pdata->fan_inv[i] << (i + 4));
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int nct7802_init_chip(struct nct7802_data *data)
 {
 	int err;
@@ -1098,11 +1257,27 @@ static int nct7802_init_chip(struct nct7802_data *data)
 static int nct7802_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct nct7802_platform_data *pdata;
 	struct device *dev = &client->dev;
 	struct nct7802_data *data;
 	struct device *hwmon_dev;
 	int ret;
 
+	pdata = dev_get_platdata(dev);
+#ifdef CONFIG_OF
+	if (dev->of_node) {
+		pdata = devm_kzalloc(dev, sizeof(struct nct7802_platform_data),
+				     GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		ret = nct7802_parse_dt(dev->of_node, pdata);
+		if (ret < 0) {
+			devm_kfree(dev, pdata);
+			return ret;
+		}
+	}
+#endif
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (data = NULL)
 		return -ENOMEM;
@@ -1113,7 +1288,10 @@ static int nct7802_probe(struct i2c_client *client,
 
 	mutex_init(&data->access_lock);
 
-	ret = nct7802_init_chip(data);
+	if (pdata)
+		ret = nct7802_platform_data_set(data, pdata);
+	else
+		ret = nct7802_init_chip(data);
 	if (ret < 0)
 		return ret;
 
@@ -1133,10 +1311,16 @@ static const struct i2c_device_id nct7802_idtable[] = {
 };
 MODULE_DEVICE_TABLE(i2c, nct7802_idtable);
 
+static const struct __maybe_unused of_device_id nct7802_dt_match[] = {
+	{ .compatible = "nuvoton,nct7802" },
+	{ },
+};
+
 static struct i2c_driver nct7802_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = DRVNAME,
+		.of_match_table = of_match_ptr(nct7802_dt_match),
 	},
 	.detect = nct7802_detect,
 	.probe = nct7802_probe,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
