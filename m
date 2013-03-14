From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:19 +0000
Subject: [lm-sensors] [PATCH 4/9] hwmon: Fix checkpatch warning 'quoted string split across lines'
Message-Id: <1363221864-15284-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Juerg Haefliger <juergh@gmail.com>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Roger Lucas <vt8231@hiddenengine.co.uk>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7314.c         |    3 +-
 drivers/hwmon/adm1021.c        |   11 +++----
 drivers/hwmon/adm1026.c        |   53 ++++++++++++++++---------------
 drivers/hwmon/adm1029.c        |    9 +++---
 drivers/hwmon/adm9240.c        |    9 +++---
 drivers/hwmon/adt7411.c        |   10 +++---
 drivers/hwmon/asb100.c         |   23 ++++++++------
 drivers/hwmon/coretemp.c       |    3 +-
 drivers/hwmon/dme1737.c        |   68 ++++++++++++++++++++--------------------
 drivers/hwmon/fam15h_power.c   |    4 +--
 drivers/hwmon/fschmd.c         |    9 +++---
 drivers/hwmon/gl518sm.c        |    5 +--
 drivers/hwmon/ibmaem.c         |   21 +++++++------
 drivers/hwmon/ibmpex.c         |   17 +++++-----
 drivers/hwmon/k8temp.c         |    4 +--
 drivers/hwmon/lm78.c           |   10 +++---
 drivers/hwmon/lm80.c           |    5 +--
 drivers/hwmon/lm85.c           |    4 +--
 drivers/hwmon/lm93.c           |   36 +++++++++++----------
 drivers/hwmon/pc87360.c        |   25 +++++++--------
 drivers/hwmon/pc87427.c        |   13 ++++----
 drivers/hwmon/sch56xx-common.c |   12 +++----
 drivers/hwmon/sis5595.c        |    5 +--
 drivers/hwmon/thmc50.c         |    7 ++---
 drivers/hwmon/tmp102.c         |    4 +--
 drivers/hwmon/tmp401.c         |    5 +--
 drivers/hwmon/tmp421.c         |    7 ++---
 drivers/hwmon/via686a.c        |    9 +++---
 drivers/hwmon/vt1211.c         |   23 ++++++++------
 drivers/hwmon/vt8231.c         |    5 +--
 drivers/hwmon/w83627ehf.c      |   31 +++++++++---------
 drivers/hwmon/w83781d.c        |   36 +++++++++++----------
 drivers/hwmon/w83791d.c        |    4 +--
 drivers/hwmon/w83792d.c        |   13 ++++----
 drivers/hwmon/w83793.c         |    8 ++---
 drivers/hwmon/w83795.c         |    9 +++---
 36 files changed, 271 insertions(+), 249 deletions(-)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index a57584d..f3c6001 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -166,6 +166,5 @@ static struct spi_driver ad7314_driver = {
 module_spi_driver(ad7314_driver);
 
 MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7314, ADT7301 and ADT7302 digital"
-			" temperature sensor driver");
+MODULE_DESCRIPTION("Analog Devices AD7314, ADT7301 and ADT7302 digital temperature sensor driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 71bcba8a..7e76922 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -312,8 +312,7 @@ static int adm1021_detect(struct i2c_client *client,
 	int conv_rate, status, config, man_id, dev_id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		pr_debug("adm1021: detect failed, "
-			 "smbus byte data not supported!\n");
+		pr_debug("detect failed, smbus byte data not supported!\n");
 		return -ENODEV;
 	}
 
@@ -324,7 +323,7 @@ static int adm1021_detect(struct i2c_client *client,
 
 	/* Check unused bits */
 	if ((status & 0x03) || (config & 0x3F) || (conv_rate & 0xF8)) {
-		pr_debug("adm1021: detect failed, chip not detected!\n");
+		pr_debug("detect failed, chip not detected!\n");
 		return -ENODEV;
 	}
 
@@ -353,7 +352,7 @@ static int adm1021_detect(struct i2c_client *client,
 	else
 		type_name = "max1617";
 
-	pr_debug("adm1021: Detected chip %s at adapter %d, address 0x%02x.\n",
+	pr_debug("Detected chip %s at adapter %d, address 0x%02x.\n",
 		 type_name, i2c_adapter_id(adapter), client->addr);
 	strlcpy(info->type, type_name, I2C_NAME_SIZE);
 
@@ -368,10 +367,8 @@ static int adm1021_probe(struct i2c_client *client,
 
 	data = devm_kzalloc(&client->dev, sizeof(struct adm1021_data),
 			    GFP_KERNEL);
-	if (!data) {
-		pr_debug("adm1021: detect failed, devm_kzalloc failed!\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(client, data);
 	data->type = id->driver_data;
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index ea09046..3a6d9ef 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -49,14 +49,14 @@ static int gpio_fan[8] = { -1, -1, -1, -1, -1, -1, -1, -1 };
 module_param_array(gpio_input, int, NULL, 0);
 MODULE_PARM_DESC(gpio_input, "List of GPIO pins (0-16) to program as inputs");
 module_param_array(gpio_output, int, NULL, 0);
-MODULE_PARM_DESC(gpio_output, "List of GPIO pins (0-16) to program as "
-	"outputs");
+MODULE_PARM_DESC(gpio_output,
+		 "List of GPIO pins (0-16) to program as outputs");
 module_param_array(gpio_inverted, int, NULL, 0);
-MODULE_PARM_DESC(gpio_inverted, "List of GPIO pins (0-16) to program as "
-	"inverted");
+MODULE_PARM_DESC(gpio_inverted,
+		 "List of GPIO pins (0-16) to program as inverted");
 module_param_array(gpio_normal, int, NULL, 0);
-MODULE_PARM_DESC(gpio_normal, "List of GPIO pins (0-16) to program as "
-	"normal/non-inverted");
+MODULE_PARM_DESC(gpio_normal,
+		 "List of GPIO pins (0-16) to program as normal/non-inverted");
 module_param_array(gpio_fan, int, NULL, 0);
 MODULE_PARM_DESC(gpio_fan, "List of GPIO pins (0-7) to program as fan tachs");
 
@@ -372,31 +372,31 @@ static void adm1026_init_client(struct i2c_client *client)
 	dev_dbg(&client->dev, "ADM1026_REG_CONFIG1 is: 0x%02x\n",
 		data->config1);
 	if ((data->config1 & CFG1_MONITOR) = 0) {
-		dev_dbg(&client->dev, "Monitoring not currently "
-			"enabled.\n");
+		dev_dbg(&client->dev,
+			"Monitoring not currently enabled.\n");
 	}
 	if (data->config1 & CFG1_INT_ENABLE) {
-		dev_dbg(&client->dev, "SMBALERT interrupts are "
-			"enabled.\n");
+		dev_dbg(&client->dev,
+			"SMBALERT interrupts are enabled.\n");
 	}
 	if (data->config1 & CFG1_AIN8_9) {
-		dev_dbg(&client->dev, "in8 and in9 enabled. "
-			"temp3 disabled.\n");
+		dev_dbg(&client->dev,
+			"in8 and in9 enabled. temp3 disabled.\n");
 	} else {
-		dev_dbg(&client->dev, "temp3 enabled.  in8 and "
-			"in9 disabled.\n");
+		dev_dbg(&client->dev,
+			"temp3 enabled.  in8 and in9 disabled.\n");
 	}
 	if (data->config1 & CFG1_THERM_HOT) {
-		dev_dbg(&client->dev, "Automatic THERM, PWM, "
-			"and temp limits enabled.\n");
+		dev_dbg(&client->dev,
+			"Automatic THERM, PWM, and temp limits enabled.\n");
 	}
 
 	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev, "GPIO16 enabled.  THERM "
-			"pin disabled.\n");
+		dev_dbg(&client->dev,
+			"GPIO16 enabled.  THERM pin disabled.\n");
 	} else {
-		dev_dbg(&client->dev, "THERM pin enabled.  "
-			"GPIO16 disabled.\n");
+		dev_dbg(&client->dev,
+			"THERM pin enabled.  GPIO16 disabled.\n");
 	}
 	if (data->config3 & CFG3_VREF_250)
 		dev_dbg(&client->dev, "Vref is 2.50 Volts.\n");
@@ -1798,8 +1798,8 @@ static int adm1026_detect(struct i2c_client *client,
 	company = adm1026_read_value(client, ADM1026_REG_COMPANY);
 	verstep = adm1026_read_value(client, ADM1026_REG_VERSTEP);
 
-	dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
-		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+	dev_dbg(&adapter->dev,
+		"Detecting device at %d,0x%02x with COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
 		i2c_adapter_id(client->adapter), client->addr,
 		company, verstep);
 
@@ -1811,11 +1811,12 @@ static int adm1026_detect(struct i2c_client *client,
 		/* Analog Devices ADM1026 */
 	} else if (company = ADM1026_COMPANY_ANALOG_DEV
 		&& (verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
-		dev_err(&adapter->dev, "Unrecognized stepping "
-			"0x%02x. Defaulting to ADM1026.\n", verstep);
+		dev_err(&adapter->dev,
+			"Unrecognized stepping 0x%02x. Defaulting to ADM1026.\n",
+			verstep);
 	} else if ((verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
-		dev_err(&adapter->dev, "Found version/stepping "
-			"0x%02x. Assuming generic ADM1026.\n",
+		dev_err(&adapter->dev,
+			"Found version/stepping 0x%02x. Assuming generic ADM1026.\n",
 			verstep);
 	} else {
 		dev_dbg(&adapter->dev, "Autodetection failed\n");
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 97f4718..9ee5e06 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -224,8 +224,9 @@ static ssize_t set_fan_div(struct device *dev,
 		break;
 	default:
 		mutex_unlock(&data->update_lock);
-		dev_err(&client->dev, "fan_div value %ld not "
-			"supported. Choose one of 1, 2 or 4!\n", val);
+		dev_err(&client->dev,
+			"fan_div value %ld not supported. Choose one of 1, 2 or 4!\n",
+			val);
 		return -EINVAL;
 	}
 	/* Update the value */
@@ -326,8 +327,8 @@ static int adm1029_detect(struct i2c_client *client,
 		 * There are no "official" CHIP ID, so actually
 		 * we use Major/Minor revision for that
 		 */
-		pr_info("adm1029: Unknown major revision %x, "
-			"please let us know\n", chip_id);
+		pr_info("Unknown major revision %x, please let us know\n",
+			chip_id);
 		return -ENODEV;
 	}
 
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 2416628..086d02a 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -351,8 +351,9 @@ static void adm9240_write_fan_div(struct i2c_client *client, int nr,
 	reg &= ~(3 << shift);
 	reg |= (fan_div << shift);
 	i2c_smbus_write_byte_data(client, ADM9240_REG_VID_FAN_DIV, reg);
-	dev_dbg(&client->dev, "fan%d clock divider changed from %u "
-			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
+	dev_dbg(&client->dev,
+		"fan%d clock divider changed from %u to %u\n",
+		nr + 1, 1 << old, 1 << fan_div);
 }
 
 /*
@@ -699,8 +700,8 @@ static void adm9240_init_client(struct i2c_client *client)
 		/* start measurement cycle */
 		i2c_smbus_write_byte_data(client, ADM9240_REG_CONFIG, 1);
 
-		dev_info(&client->dev, "cold start: config was 0x%02x "
-				"mode %u\n", conf, mode);
+		dev_info(&client->dev,
+			 "cold start: config was 0x%02x mode %u\n", conf, mode);
 	}
 }
 
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 34ff03a..d9299de 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -259,15 +259,17 @@ static int adt7411_detect(struct i2c_client *client,
 
 	val = i2c_smbus_read_byte_data(client, ADT7411_REG_MANUFACTURER_ID);
 	if (val < 0 || val != ADT7411_MANUFACTURER_ID) {
-		dev_dbg(&client->dev, "Wrong manufacturer ID. Got %d, "
-			"expected %d\n", val, ADT7411_MANUFACTURER_ID);
+		dev_dbg(&client->dev,
+			"Wrong manufacturer ID. Got %d, expected %d\n",
+			val, ADT7411_MANUFACTURER_ID);
 		return -ENODEV;
 	}
 
 	val = i2c_smbus_read_byte_data(client, ADT7411_REG_DEVICE_ID);
 	if (val < 0 || val != ADT7411_DEVICE_ID) {
-		dev_dbg(&client->dev, "Wrong device ID. Got %d, "
-			"expected %d\n", val, ADT7411_DEVICE_ID);
+		dev_dbg(&client->dev,
+			"Wrong device ID. Got %d, expected %d\n",
+			val, ADT7411_DEVICE_ID);
 		return -ENODEV;
 	}
 
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 6ac612c..f960636 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -55,8 +55,8 @@ static const unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
-MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
-	"{bus, clientaddr, subclientaddr1, subclientaddr2}");
+MODULE_PARM_DESC(force_subclients,
+	"List of subclient addresses: {bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 /* Voltage IN registers 0-6 */
 #define ASB100_REG_IN(nr)	(0x20 + (nr))
@@ -689,8 +689,8 @@ static int asb100_detect_subclients(struct i2c_client *client)
 		for (i = 2; i <= 3; i++) {
 			if (force_subclients[i] < 0x48 ||
 			    force_subclients[i] > 0x4f) {
-				dev_err(&client->dev, "invalid subclient "
-					"address %d; must be 0x48-0x4f\n",
+				dev_err(&client->dev,
+					"invalid subclient address %d; must be 0x48-0x4f\n",
 					force_subclients[i]);
 				err = -ENODEV;
 				goto ERROR_SC_2;
@@ -708,24 +708,27 @@ static int asb100_detect_subclients(struct i2c_client *client)
 	}
 
 	if (sc_addr[0] = sc_addr[1]) {
-		dev_err(&client->dev, "duplicate addresses 0x%x "
-				"for subclients\n", sc_addr[0]);
+		dev_err(&client->dev,
+			"duplicate addresses 0x%x for subclients\n",
+			sc_addr[0]);
 		err = -ENODEV;
 		goto ERROR_SC_2;
 	}
 
 	data->lm75[0] = i2c_new_dummy(adapter, sc_addr[0]);
 	if (!data->lm75[0]) {
-		dev_err(&client->dev, "subclient %d registration "
-			"at address 0x%x failed.\n", 1, sc_addr[0]);
+		dev_err(&client->dev,
+			"subclient %d registration at address 0x%x failed.\n",
+			1, sc_addr[0]);
 		err = -ENOMEM;
 		goto ERROR_SC_2;
 	}
 
 	data->lm75[1] = i2c_new_dummy(adapter, sc_addr[1]);
 	if (!data->lm75[1]) {
-		dev_err(&client->dev, "subclient %d registration "
-			"at address 0x%x failed.\n", 2, sc_addr[1]);
+		dev_err(&client->dev,
+			"subclient %d registration at address 0x%x failed.\n",
+			2, sc_addr[1]);
 		err = -ENOMEM;
 		goto ERROR_SC_3;
 	}
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 3f1e297..658ce3a 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -411,8 +411,7 @@ static int __cpuinit chk_ucode_version(unsigned int cpu)
 	 * fixed for stepping D0 (6EC).
 	 */
 	if (c->x86_model = 0xe && c->x86_mask < 0xc && c->microcode < 0x39) {
-		pr_err("Errata AE18 not fixed, update BIOS or "
-		       "microcode of the CPU!\n");
+		pr_err("Errata AE18 not fixed, update BIOS or microcode of the CPU!\n");
 		return -ENODEV;
 	}
 	return 0;
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index c347c94..4ae3fff 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -55,14 +55,16 @@ MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 static bool probe_all_addr;
 module_param(probe_all_addr, bool, 0);
-MODULE_PARM_DESC(probe_all_addr, "Include probing of non-standard LPC "
-		 "addresses");
+MODULE_PARM_DESC(probe_all_addr,
+		 "Include probing of non-standard LPC addresses");
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
 
 enum chips { dme1737, sch5027, sch311x, sch5127 };
 
+#define	DO_REPORT "Please report to the driver maintainer."
+
 /* ---------------------------------------------------------------------
  * Registers
  *
@@ -566,9 +568,9 @@ static u8 dme1737_read(const struct dme1737_data *data, u8 reg)
 		val = i2c_smbus_read_byte_data(client, reg);
 
 		if (val < 0) {
-			dev_warn(&client->dev, "Read from register "
-				 "0x%02x failed! Please report to the driver "
-				 "maintainer.\n", reg);
+			dev_warn(&client->dev,
+				 "Read from register 0x%02x failed! %s\n",
+				 reg, DO_REPORT);
 		}
 	} else { /* ISA device */
 		outb(reg, data->addr);
@@ -587,9 +589,9 @@ static s32 dme1737_write(const struct dme1737_data *data, u8 reg, u8 val)
 		res = i2c_smbus_write_byte_data(client, reg, val);
 
 		if (res < 0) {
-			dev_warn(&client->dev, "Write to register "
-				 "0x%02x failed! Please report to the driver "
-				 "maintainer.\n", reg);
+			dev_warn(&client->dev,
+				 "Write to register 0x%02x failed! %s\n",
+				 reg, DO_REPORT);
 		}
 	} else { /* ISA device */
 		outb(reg, data->addr);
@@ -1167,8 +1169,8 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 		/* Only valid for fan[1-4] */
 		if (!(val = 1 || val = 2 || val = 4)) {
 			count = -EINVAL;
-			dev_warn(dev, "Fan type value %ld not "
-				 "supported. Choose one of 1, 2, or 4.\n",
+			dev_warn(dev,
+				 "Fan type value %ld not supported. Choose one of 1, 2, or 4.\n",
 				 val);
 			goto exit;
 		}
@@ -1294,8 +1296,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		/* Only valid for pwm[1-3] */
 		if (val < 0 || val > 2) {
 			count = -EINVAL;
-			dev_warn(dev, "PWM enable %ld not "
-				 "supported. Choose one of 0, 1, or 2.\n",
+			dev_warn(dev,
+				 "PWM enable %ld not supported. Choose one of 0, 1, or 2.\n",
 				 val);
 			goto exit;
 		}
@@ -1399,8 +1401,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		if (!(val = 1 || val = 2 || val = 4 ||
 		      val = 6 || val = 7)) {
 			count = -EINVAL;
-			dev_warn(dev, "PWM auto channels zone %ld "
-				 "not supported. Choose one of 1, 2, 4, 6, "
+			dev_warn(dev,
+				 "PWM auto channels zone %ld not supported. Choose one of 1, 2, 4, 6, "
 				 "or 7.\n", val);
 			goto exit;
 		}
@@ -2178,8 +2180,8 @@ static int dme1737_create_files(struct device *dev)
 	 * selected attributes from read-only to read-writeable.
 	 */
 	if (data->config & 0x02) {
-		dev_info(dev, "Device is locked. Some attributes "
-			 "will be read-only.\n");
+		dev_info(dev,
+			 "Device is locked. Some attributes will be read-only.\n");
 	} else {
 		/* Change permissions of zone sysfs attributes */
 		dme1737_chmod_group(dev, &dme1737_zone_chmod_group,
@@ -2247,9 +2249,8 @@ static int dme1737_init_device(struct device *dev)
 	/* Inform if part is not monitoring/started */
 	if (!(data->config & 0x01)) {
 		if (!force_start) {
-			dev_err(dev, "Device is not monitoring. "
-				"Use the force_start load parameter to "
-				"override.\n");
+			dev_err(dev,
+				"Device is not monitoring. Use the force_start load parameter to override.\n");
 			return -EFAULT;
 		}
 
@@ -2289,8 +2290,8 @@ static int dme1737_init_device(struct device *dev)
 		 */
 		if (dme1737_i2c_get_features(0x2e, data) &&
 		    dme1737_i2c_get_features(0x4e, data)) {
-			dev_warn(dev, "Failed to query Super-IO for optional "
-				 "features.\n");
+			dev_warn(dev,
+				 "Failed to query Super-IO for optional features.\n");
 		}
 	}
 
@@ -2317,8 +2318,8 @@ static int dme1737_init_device(struct device *dev)
 		break;
 	}
 
-	dev_info(dev, "Optional features: pwm3=%s, pwm5=%s, pwm6=%s, "
-		 "fan3=%s, fan4=%s, fan5=%s, fan6=%s.\n",
+	dev_info(dev,
+		 "Optional features: pwm3=%s, pwm5=%s, pwm6=%s, fan3=%s, fan4=%s, fan5=%s, fan6=%s.\n",
 		 (data->has_features & HAS_PWM(2)) ? "yes" : "no",
 		 (data->has_features & HAS_PWM(4)) ? "yes" : "no",
 		 (data->has_features & HAS_PWM(5)) ? "yes" : "no",
@@ -2330,18 +2331,16 @@ static int dme1737_init_device(struct device *dev)
 	reg = dme1737_read(data, DME1737_REG_TACH_PWM);
 	/* Inform if fan-to-pwm mapping differs from the default */
 	if (client && reg != 0xa4) {   /* I2C chip */
-		dev_warn(dev, "Non-standard fan to pwm mapping: "
-			 "fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
-			 "fan4->pwm%d. Please report to the driver "
-			 "maintainer.\n",
+		dev_warn(dev,
+			 "Non-standard fan to pwm mapping: fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, fan4->pwm%d. %s\n",
 			 (reg & 0x03) + 1, ((reg >> 2) & 0x03) + 1,
-			 ((reg >> 4) & 0x03) + 1, ((reg >> 6) & 0x03) + 1);
+			 ((reg >> 4) & 0x03) + 1, ((reg >> 6) & 0x03) + 1,
+			 DO_REPORT);
 	} else if (!client && reg != 0x24) {   /* ISA chip */
-		dev_warn(dev, "Non-standard fan to pwm mapping: "
-			 "fan1->pwm%d, fan2->pwm%d, fan3->pwm%d. "
-			 "Please report to the driver maintainer.\n",
+		dev_warn(dev,
+			 "Non-standard fan to pwm mapping: fan1->pwm%d, fan2->pwm%d, fan3->pwm%d. %s\n",
 			 (reg & 0x03) + 1, ((reg >> 2) & 0x03) + 1,
-			 ((reg >> 4) & 0x03) + 1);
+			 ((reg >> 4) & 0x03) + 1, DO_REPORT);
 	}
 
 	/*
@@ -2355,8 +2354,9 @@ static int dme1737_init_device(struct device *dev)
 						DME1737_REG_PWM_CONFIG(ix));
 			if ((data->has_features & HAS_PWM(ix)) &&
 			    (PWM_EN_FROM_REG(data->pwm_config[ix]) = -1)) {
-				dev_info(dev, "Switching pwm%d to "
-					 "manual mode.\n", ix + 1);
+				dev_info(dev,
+					 "Switching pwm%d to manual mode.\n",
+					 ix + 1);
 				data->pwm_config[ix] = PWM_EN_TO_REG(1,
 							data->pwm_config[ix]);
 				dme1737_write(data, DME1737_REG_PWM(ix), 0);
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index b757088..dff8410 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -189,8 +189,8 @@ static void fam15h_power_init_data(struct pci_dev *f4,
 
 	/* result not allowed to be >= 256W */
 	if ((tmp >> 16) >= 256)
-		dev_warn(&f4->dev, "Bogus value for ProcessorPwrWatts "
-			 "(processor_pwr_watts>=%u)\n",
+		dev_warn(&f4->dev,
+			 "Bogus value for ProcessorPwrWatts (processor_pwr_watts>=%u)\n",
 			 (unsigned int) (tmp >> 16));
 
 	/* convert to microWatt */
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 8af2755..d58abdc 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -463,8 +463,9 @@ static ssize_t store_fan_div(struct device *dev, struct device_attribute
 		v = 3;
 		break;
 	default:
-		dev_err(dev, "fan_div value %lu not supported. "
-			"Choose one of 2, 4 or 8!\n", v);
+		dev_err(dev,
+			"fan_div value %lu not supported. Choose one of 2, 4 or 8!\n",
+			v);
 		return -EINVAL;
 	}
 
@@ -1249,8 +1250,8 @@ static int fschmd_probe(struct i2c_client *client,
 	}
 	if (i = ARRAY_SIZE(watchdog_minors)) {
 		data->watchdog_miscdev.minor = 0;
-		dev_warn(&client->dev, "Couldn't register watchdog chardev "
-			"(due to no free minor)\n");
+		dev_warn(&client->dev,
+			 "Couldn't register watchdog chardev (due to no free minor)\n");
 	}
 	mutex_unlock(&watchdog_data_mutex);
 
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index e2e5909..95257a5 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -344,8 +344,9 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		val = 3;
 		break;
 	default:
-		dev_err(dev, "Invalid fan clock divider %lu, choose one "
-			"of 1, 2, 4 or 8\n", val);
+		dev_err(dev,
+			"Invalid fan clock divider %lu, choose one of 1, 2, 4 or 8\n",
+			val);
 		return -EINVAL;
 	}
 
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index a14f634..1429f6e 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -289,8 +289,9 @@ static int aem_init_ipmi_data(struct aem_ipmi_data *data, int iface,
 	err = ipmi_create_user(data->interface, &driver_data.ipmi_hndlrs,
 			       data, &data->user);
 	if (err < 0) {
-		dev_err(bmc, "Unable to register user with IPMI "
-			"interface %d\n", data->interface);
+		dev_err(bmc,
+			"Unable to register user with IPMI interface %d\n",
+			data->interface);
 		return -EACCES;
 	}
 
@@ -328,8 +329,8 @@ static void aem_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	struct aem_ipmi_data *data = user_msg_data;
 
 	if (msg->msgid != data->tx_msgid) {
-		dev_err(data->bmc_device, "Mismatch between received msgid "
-			"(%02x) and transmitted msgid (%02x)!\n",
+		dev_err(data->bmc_device,
+			"Mismatch between received msgid (%02x) and transmitted msgid (%02x)!\n",
 			(int)msg->msgid,
 			(int)data->tx_msgid);
 		ipmi_free_recv_msg(msg);
@@ -575,8 +576,8 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	/* Register with hwmon */
 	data->hwmon_dev = hwmon_device_register(&data->pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
-		dev_err(&data->pdev->dev, "Unable to register hwmon "
-			"device for IPMI interface %d\n",
+		dev_err(&data->pdev->dev,
+			"Unable to register hwmon device for IPMI interface %d\n",
 			probe->interface);
 		res = PTR_ERR(data->hwmon_dev);
 		goto hwmon_reg_err;
@@ -715,8 +716,8 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	/* Register with hwmon */
 	data->hwmon_dev = hwmon_device_register(&data->pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
-		dev_err(&data->pdev->dev, "Unable to register hwmon "
-			"device for IPMI interface %d\n",
+		dev_err(&data->pdev->dev,
+			"Unable to register hwmon device for IPMI interface %d\n",
 			probe->interface);
 		res = PTR_ERR(data->hwmon_dev);
 		goto hwmon_reg_err;
@@ -768,8 +769,8 @@ static void aem_init_aem2(struct aem_ipmi_data *probe)
 
 	while (!aem_find_aem2(probe, &fi_resp, i)) {
 		if (fi_resp.major != 2) {
-			dev_err(probe->bmc_device, "Unknown AEM v%d; please "
-				"report this to the maintainer.\n",
+			dev_err(probe->bmc_device,
+				"Unknown AEM v%d; please report this to the maintainer.\n",
 				fi_resp.major);
 			i++;
 			continue;
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index b622a93..74b365e 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -163,8 +163,8 @@ static int ibmpex_ver_check(struct ibmpex_bmc_data *data)
 	data->sensor_major = data->rx_msg_data[0];
 	data->sensor_minor = data->rx_msg_data[1];
 
-	dev_info(data->bmc_device, "Found BMC with sensor interface "
-		 "v%d.%d %d-%02d-%02d on interface %d\n",
+	dev_info(data->bmc_device,
+		 "Found BMC with sensor interface v%d.%d %d-%02d-%02d on interface %d\n",
 		 data->sensor_major,
 		 data->sensor_minor,
 		 extract_value(data->rx_msg_data, 2),
@@ -478,8 +478,9 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
 	err = ipmi_create_user(data->interface, &driver_data.ipmi_hndlrs,
 			       data, &data->user);
 	if (err < 0) {
-		dev_err(dev, "Unable to register user with IPMI "
-			"interface %d\n", data->interface);
+		dev_err(dev,
+			"Unable to register user with IPMI interface %d\n",
+			data->interface);
 		goto out;
 	}
 
@@ -501,8 +502,8 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
 	data->hwmon_dev = hwmon_device_register(data->bmc_device);
 
 	if (IS_ERR(data->hwmon_dev)) {
-		dev_err(data->bmc_device, "Unable to register hwmon "
-			"device for IPMI interface %d\n",
+		dev_err(data->bmc_device,
+			"Unable to register hwmon device for IPMI interface %d\n",
 			data->interface);
 		goto out_user;
 	}
@@ -567,8 +568,8 @@ static void ibmpex_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	struct ibmpex_bmc_data *data = (struct ibmpex_bmc_data *)user_msg_data;
 
 	if (msg->msgid != data->tx_msgid) {
-		dev_err(data->bmc_device, "Mismatch between received msgid "
-			"(%02x) and transmitted msgid (%02x)!\n",
+		dev_err(data->bmc_device,
+			"Mismatch between received msgid (%02x) and transmitted msgid (%02x)!\n",
 			(int)msg->msgid,
 			(int)data->tx_msgid);
 		ipmi_free_recv_msg(msg);
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 9f3c0ae..5b50e9e 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -200,8 +200,8 @@ static int k8temp_probe(struct pci_dev *pdev,
 	 */
 	if (model >= 0x40) {
 		data->swap_core_select = 1;
-		dev_warn(&pdev->dev, "Temperature readouts might be wrong - "
-			 "check erratum #141\n");
+		dev_warn(&pdev->dev,
+			 "Temperature readouts might be wrong - check erratum #141\n");
 	}
 
 	/*
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 483538f..6cf6bff 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -386,8 +386,9 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 		data->fan_div[nr] = 3;
 		break;
 	default:
-		dev_err(dev, "fan_div value %ld not "
-			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		dev_err(dev,
+			"fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n",
+			val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
@@ -636,8 +637,9 @@ static int lm78_i2c_detect(struct i2c_client *client,
 		goto err_nodev;
 
 	if (lm78_alias_detect(client, i)) {
-		dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
-			"be the same as ISA device\n", address);
+		dev_dbg(&adapter->dev,
+			"Device at 0x%02x appears to be the same as ISA device\n",
+			address);
 		goto err_nodev;
 	}
 
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 357fbb9..eba89aa 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -286,8 +286,9 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		data->fan_div[nr] = 3;
 		break;
 	default:
-		dev_err(&client->dev, "fan_div value %ld not "
-			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		dev_err(&client->dev,
+			"fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n",
+			val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 47ade8b..3894c40 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1293,8 +1293,8 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 	company = lm85_read_value(client, LM85_REG_COMPANY);
 	verstep = lm85_read_value(client, LM85_REG_VERSTEP);
 
-	dev_dbg(&adapter->dev, "Detecting device at 0x%02x with "
-		"COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+	dev_dbg(&adapter->dev,
+		"Detecting device at 0x%02x with COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
 		address, company, verstep);
 
 	/* All supported chips have the version in common */
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 340382f..a6f4605 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -818,8 +818,9 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 		if (value >= 0) {
 			return value;
 		} else {
-			dev_warn(&client->dev, "lm93: read byte data failed, "
-				"address 0x%02x.\n", reg);
+			dev_warn(&client->dev,
+				 "lm93: read byte data failed, address 0x%02x.\n",
+				 reg);
 			mdelay(i + 3);
 		}
 
@@ -838,8 +839,9 @@ static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
 	result = i2c_smbus_write_byte_data(client, reg, value);
 
 	if (result < 0)
-		dev_warn(&client->dev, "lm93: write byte data failed, "
-			 "0x%02x at address 0x%02x.\n", value, reg);
+		dev_warn(&client->dev,
+			 "lm93: write byte data failed, 0x%02x at address 0x%02x.\n",
+			 value, reg);
 
 	return result;
 }
@@ -854,8 +856,9 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 		if (value >= 0) {
 			return value;
 		} else {
-			dev_warn(&client->dev, "lm93: read word data failed, "
-				 "address 0x%02x.\n", reg);
+			dev_warn(&client->dev,
+				 "lm93: read word data failed, address 0x%02x.\n",
+				 reg);
 			mdelay(i + 3);
 		}
 
@@ -874,8 +877,9 @@ static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
 	result = i2c_smbus_write_word_data(client, reg, value);
 
 	if (result < 0)
-		dev_warn(&client->dev, "lm93: write word data failed, "
-			 "0x%04x at address 0x%02x.\n", value, reg);
+		dev_warn(&client->dev,
+			 "lm93: write word data failed, 0x%04x at address 0x%02x.\n",
+			 value, reg);
 
 	return result;
 }
@@ -898,8 +902,8 @@ static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 		if (result = lm93_block_read_cmds[fbn].len) {
 			break;
 		} else {
-			dev_warn(&client->dev, "lm93: block read data failed, "
-				 "command 0x%02x.\n",
+			dev_warn(&client->dev,
+				 "lm93: block read data failed, command 0x%02x.\n",
 				 lm93_block_read_cmds[fbn].cmd);
 			mdelay(i + 3);
 		}
@@ -2672,8 +2676,8 @@ static void lm93_init_client(struct i2c_client *client)
 			return;
 	}
 
-	dev_warn(&client->dev, "timed out waiting for sensor "
-		 "chip to signal ready!\n");
+	dev_warn(&client->dev,
+		 "timed out waiting for sensor chip to signal ready!\n");
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
@@ -2733,12 +2737,12 @@ static int lm93_probe(struct i2c_client *client,
 		dev_dbg(&client->dev, "using SMBus block data transactions\n");
 		update = lm93_update_client_full;
 	} else if ((LM93_SMBUS_FUNC_MIN & func) = LM93_SMBUS_FUNC_MIN) {
-		dev_dbg(&client->dev, "disabled SMBus block data "
-			"transactions\n");
+		dev_dbg(&client->dev,
+			"disabled SMBus block data transactions\n");
 		update = lm93_update_client_min;
 	} else {
-		dev_dbg(&client->dev, "detect failed, "
-			"smbus byte and/or word data not supported!\n");
+		dev_dbg(&client->dev,
+			"detect failed, smbus byte and/or word data not supported!\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index e35856b..aa615ba 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1190,8 +1190,7 @@ static int __init pc87360_find(int sioaddr, u8 *devid,
 				confreg[3] = superio_inb(sioaddr, 0x25);
 
 				if (confreg[2] & 0x40) {
-					pr_info("Using thermistors for "
-						"temperature monitoring\n");
+					pr_info("Using thermistors for temperature monitoring\n");
 				}
 				if (confreg[3] & 0xE0) {
 					pr_info("VID inputs routed (mode %u)\n",
@@ -1271,9 +1270,9 @@ static int pc87360_probe(struct platform_device *pdev)
 		if (data->address[i]
 		 && !devm_request_region(dev, extra_isa[i], PC87360_EXTENT,
 					 pc87360_driver.driver.name)) {
-			dev_err(dev, "Region 0x%x-0x%x already "
-				"in use!\n", extra_isa[i],
-				extra_isa[i]+PC87360_EXTENT-1);
+			dev_err(dev,
+				"Region 0x%x-0x%x already in use!\n",
+				extra_isa[i], extra_isa[i]+PC87360_EXTENT-1);
 			return -EBUSY;
 		}
 	}
@@ -1435,8 +1434,8 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (init >= 2 && data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONVRATE);
-		dev_info(&pdev->dev, "VLM conversion set to "
-			 "1s period, 160us delay\n");
+		dev_info(&pdev->dev,
+			 "VLM conversion set to 1s period, 160us delay\n");
 		pc87360_write_value(data, LD_IN, NO_BANK,
 				    PC87365_REG_IN_CONVRATE,
 				    (reg & 0xC0) | 0x11);
@@ -1450,8 +1449,8 @@ static void pc87360_init_device(struct platform_device *pdev,
 		if (init >= init_in[i]) {
 			/* Forcibly enable voltage channel */
 			if (!(reg & CHAN_ENA)) {
-				dev_dbg(&pdev->dev, "Forcibly "
-					"enabling in%d\n", i);
+				dev_dbg(&pdev->dev, "Forcibly enabling in%d\n",
+					i);
 				pc87360_write_value(data, LD_IN, i,
 						    PC87365_REG_IN_STATUS,
 						    (reg & 0x68) | 0x87);
@@ -1575,8 +1574,8 @@ static void pc87360_autodiv(struct device *dev, int nr)
 			data->fan_status[nr] += 0x20;
 			data->fan_min[nr] >>= 1;
 			data->fan[nr] >>= 1;
-			dev_dbg(dev, "Increasing "
-				"clock divider to %d for fan %d\n",
+			dev_dbg(dev,
+				"Increasing clock divider to %d for fan %d\n",
 				FAN_DIV_FROM_REG(data->fan_status[nr]), nr + 1);
 		}
 	} else {
@@ -1587,8 +1586,8 @@ static void pc87360_autodiv(struct device *dev, int nr)
 			data->fan_status[nr] -= 0x20;
 			data->fan_min[nr] <<= 1;
 			data->fan[nr] <<= 1;
-			dev_dbg(dev, "Decreasing "
-				"clock divider to %d for fan %d\n",
+			dev_dbg(dev,
+				"Decreasing clock divider to %d for fan %d\n",
 				FAN_DIV_FROM_REG(data->fan_status[nr]),
 				nr + 1);
 		}
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 6086ad0..ea60686 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -627,8 +627,9 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute
 	pc87427_readall_pwm(data, nr);
 	mode = data->pwm_enable[nr] & PWM_ENABLE_MODE_MASK;
 	if (mode != PWM_MODE_MANUAL && mode != PWM_MODE_OFF) {
-		dev_notice(dev, "Can't set PWM%d duty cycle while not in "
-			   "manual mode\n", nr + 1);
+		dev_notice(dev,
+			   "Can't set PWM%d duty cycle while not in manual mode\n",
+			   nr + 1);
 		mutex_unlock(&data->lock);
 		return -EPERM;
 	}
@@ -1245,16 +1246,16 @@ static int __init pc87427_find(int sioaddr, struct pc87427_sio_data *sio_data)
 
 		val = superio_inb(sioaddr, SIOREG_MAP);
 		if (val & 0x01) {
-			pr_warn("Logical device 0x%02x is memory-mapped, "
-				"can't use\n", logdev[i]);
+			pr_warn("Logical device 0x%02x is memory-mapped, can't use\n",
+				logdev[i]);
 			continue;
 		}
 
 		val = (superio_inb(sioaddr, SIOREG_IOBASE) << 8)
 		    | superio_inb(sioaddr, SIOREG_IOBASE + 1);
 		if (!val) {
-			pr_info("I/O base address not set for logical device "
-				"0x%02x\n", logdev[i]);
+			pr_info("I/O base address not set for logical device 0x%02x\n",
+				logdev[i]);
 			continue;
 		}
 		sio_data->address[i] = val;
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index d00b30a..7386819 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -161,8 +161,8 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg, u8 v)
 			break;
 	}
 	if (i = max_busy_polls + max_lazy_polls) {
-		pr_err("Max retries exceeded reading virtual "
-		       "register 0x%04hx (%d)\n", reg, 1);
+		pr_err("Max retries exceeded reading virtual register 0x%04hx (%d)\n",
+		       reg, 1);
 		return -EIO;
 	}
 
@@ -178,12 +178,12 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg, u8 v)
 			break;
 
 		if (i = 0)
-			pr_warn("EC reports: 0x%02x reading virtual register "
-				"0x%04hx\n", (unsigned int)val, reg);
+			pr_warn("EC reports: 0x%02x reading virtual register 0x%04hx\n",
+				(unsigned int)val, reg);
 	}
 	if (i = max_busy_polls) {
-		pr_err("Max retries exceeded reading virtual "
-		       "register 0x%04hx (%d)\n", reg, 2);
+		pr_err("Max retries exceeded reading virtual register 0x%04hx (%d)\n",
+		       reg, 2);
 		return -EIO;
 	}
 
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index c35847a..1404e63 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -456,8 +456,9 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 		data->fan_div[nr] = 3;
 		break;
 	default:
-		dev_err(dev, "fan_div value %ld not "
-			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		dev_err(dev,
+			"fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n",
+			val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 4b59eb5..db288db 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -41,8 +41,8 @@ enum chips { thmc50, adm1022 };
 static unsigned short adm1022_temp3[16];
 static unsigned int adm1022_temp3_num;
 module_param_array(adm1022_temp3, ushort, &adm1022_temp3_num, 0);
-MODULE_PARM_DESC(adm1022_temp3, "List of adapter,address pairs "
-			"to enable 3rd temperature (ADM1022 only)");
+MODULE_PARM_DESC(adm1022_temp3,
+		 "List of adapter,address pairs to enable 3rd temperature (ADM1022 only)");
 
 /* Many THMC50 constants specified below */
 
@@ -312,8 +312,7 @@ static int thmc50_detect(struct i2c_client *client,
 	const char *type_name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		pr_debug("thmc50: detect failed, "
-			 "smbus byte data not supported!\n");
+		pr_debug("thmc50: detect failed, smbus byte data not supported!\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 523dd89..d7b47ab 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -155,8 +155,8 @@ static int tmp102_probe(struct i2c_client *client,
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(&client->dev, "adapter doesn't support SMBus word "
-			"transactions\n");
+		dev_err(&client->dev,
+			"adapter doesn't support SMBus word transactions\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index c85f696..97bf344 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -451,8 +451,9 @@ static ssize_t reset_temp_history(struct device *dev,
 		return -EINVAL;
 
 	if (val != 1) {
-		dev_err(dev, "temp_reset_history value %ld not"
-			" supported. Use 1 to reset the history!\n", val);
+		dev_err(dev,
+			"temp_reset_history value %ld not supported. Use 1 to reset the history!\n",
+			val);
 		return -EINVAL;
 	}
 	i2c_smbus_write_byte_data(to_i2c_client(dev),
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 6a8ded2..964c1d6 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -208,8 +208,8 @@ static int tmp421_init_client(struct i2c_client *client)
 	/* Start conversions (disable shutdown if necessary) */
 	config = i2c_smbus_read_byte_data(client, TMP421_CONFIG_REG_1);
 	if (config < 0) {
-		dev_err(&client->dev, "Could not read configuration"
-			 " register (%d)\n", config);
+		dev_err(&client->dev,
+			"Could not read configuration register (%d)\n", config);
 		return -ENODEV;
 	}
 
@@ -322,6 +322,5 @@ static struct i2c_driver tmp421_driver = {
 module_i2c_driver(tmp421_driver);
 
 MODULE_AUTHOR("Andre Prendel <andre.prendel@gmx.de>");
-MODULE_DESCRIPTION("Texas Instruments TMP421/422/423 temperature sensor"
-		   " driver");
+MODULE_DESCRIPTION("Texas Instruments TMP421/422/423 temperature sensor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 9427e95..c9dcce8 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -889,8 +889,8 @@ static int via686a_pci_probe(struct pci_dev *dev,
 
 	address = val & ~(VIA686A_EXTENT - 1);
 	if (address = 0) {
-		dev_err(&dev->dev, "base address not set - upgrade BIOS "
-			"or use force_addr=0xaddr\n");
+		dev_err(&dev->dev,
+			"base address not set - upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
@@ -899,8 +899,9 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	if (!(val & 0x0001)) {
 		if (!force_addr) {
-			dev_warn(&dev->dev, "Sensors disabled, enable "
-				 "with force_addr=0x%x\n", address);
+			dev_warn(&dev->dev,
+				 "Sensors disabled, enable with force_addr=0x%x\n",
+				 address);
 			return -ENODEV;
 		}
 
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index dcc62f8..6b2f1a4 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -571,8 +571,9 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 			break;
 		default:
 			count = -EINVAL;
-			dev_warn(dev, "fan div value %ld not supported. "
-				 "Choose one of 1, 2, 4, or 8.\n", val);
+			dev_warn(dev,
+				 "fan div value %ld not supported. Choose one of 1, 2, 4, or 8.\n",
+				 val);
 			goto EXIT;
 		}
 		vt1211_write8(data, VT1211_REG_FAN_DIV,
@@ -674,8 +675,9 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 			break;
 		default:
 			count = -EINVAL;
-			dev_warn(dev, "pwm mode %ld not supported. "
-				 "Choose one of 0 or 2.\n", val);
+			dev_warn(dev,
+				 "pwm mode %ld not supported. Choose one of 0 or 2.\n",
+				 val);
 			goto EXIT;
 		}
 		vt1211_write8(data, VT1211_REG_PWM_CTL,
@@ -700,8 +702,9 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
 		if (val < 1 || val > 7) {
 			count = -EINVAL;
-			dev_warn(dev, "temp channel %ld not supported. "
-				 "Choose a value between 1 and 7.\n", val);
+			dev_warn(dev,
+				 "temp channel %ld not supported. Choose a value between 1 and 7.\n",
+				 val);
 			goto EXIT;
 		}
 		if (!ISTEMP(val - 1, data->uch_config)) {
@@ -1325,15 +1328,15 @@ static int __init vt1211_init(void)
 
 	if ((uch_config < -1) || (uch_config > 31)) {
 		err = -EINVAL;
-		pr_warn("Invalid UCH configuration %d. "
-			"Choose a value between 0 and 31.\n", uch_config);
+		pr_warn("Invalid UCH configuration %d. Choose a value between 0 and 31.\n",
+			uch_config);
 		goto EXIT;
 	}
 
 	if ((int_mode < -1) || (int_mode > 0)) {
 		err = -EINVAL;
-		pr_warn("Invalid interrupt mode %d. "
-			"Only mode 0 is supported.\n", int_mode);
+		pr_warn("Invalid interrupt mode %d. Only mode 0 is supported.\n",
+			int_mode);
 		goto EXIT;
 	}
 
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 988a2a7..0e70178 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -573,8 +573,9 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		data->fan_div[nr] = 3;
 		break;
 	default:
-		dev_err(dev, "fan_div value %ld not supported. "
-			"Choose one of 1, 2, 4 or 8!\n", val);
+		dev_err(dev,
+			"fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n",
+			val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0a89211..0160272 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -840,8 +840,8 @@ static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
 			    && (reg >= 0xff || (sio_data->kind = nct6775
 						&& reg = 0x00))
 			    && data->fan_div[i] < 0x07) {
-				dev_dbg(dev, "Increasing fan%d "
-					"clock divider from %u to %u\n",
+				dev_dbg(dev,
+					"Increasing fan%d clock divider from %u to %u\n",
 					i + 1, div_from_reg(data->fan_div[i]),
 					div_from_reg(data->fan_div[i] + 1));
 				data->fan_div[i]++;
@@ -1110,9 +1110,9 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 		 */
 		data->fan_min[nr] = 254;
 		new_div = 7; /* 128 = (1 << 7) */
-		dev_warn(dev, "fan%u low limit %lu below minimum %u, set to "
-			 "minimum\n", nr + 1, val,
-			 data->fan_from_reg_min(254, 7));
+		dev_warn(dev,
+			 "fan%u low limit %lu below minimum %u, set to minimum\n",
+			 nr + 1, val, data->fan_from_reg_min(254, 7));
 	} else if (!reg) {
 		/*
 		 * Speed above this value cannot possibly be represented,
@@ -1120,9 +1120,9 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 		 */
 		data->fan_min[nr] = 1;
 		new_div = 0; /* 1 = (1 << 0) */
-		dev_warn(dev, "fan%u low limit %lu above maximum %u, set to "
-			 "maximum\n", nr + 1, val,
-			 data->fan_from_reg_min(1, 0));
+		dev_warn(dev,
+			 "fan%u low limit %lu above maximum %u, set to maximum\n",
+			 nr + 1, val, data->fan_from_reg_min(1, 0));
 	} else {
 		/*
 		 * Automatically pick the best divider, i.e. the one such
@@ -2396,15 +2396,15 @@ static int w83627ehf_probe(struct platform_device *pdev)
 				en_vrm10 = superio_inb(sio_data->sioreg,
 						       SIO_REG_EN_VRM10);
 				if ((en_vrm10 & 0x08) && data->vrm = 90) {
-					dev_warn(dev, "Setting VID input "
-						 "voltage to TTL\n");
+					dev_warn(dev,
+						 "Setting VID input voltage to TTL\n");
 					superio_outb(sio_data->sioreg,
 						     SIO_REG_EN_VRM10,
 						     en_vrm10 & ~0x08);
 				} else if (!(en_vrm10 & 0x08)
 					   && data->vrm = 100) {
-					dev_warn(dev, "Setting VID input "
-						 "voltage to VRM10\n");
+					dev_warn(dev,
+						 "Setting VID input voltage to VRM10\n");
 					superio_outb(sio_data->sioreg,
 						     SIO_REG_EN_VRM10,
 						     en_vrm10 | 0x08);
@@ -2420,8 +2420,8 @@ static int w83627ehf_probe(struct platform_device *pdev)
 			if (err)
 				goto exit_release;
 		} else {
-			dev_info(dev, "VID pins in output mode, CPU VID not "
-				 "available\n");
+			dev_info(dev,
+				 "VID pins in output mode, CPU VID not available\n");
 		}
 	}
 
@@ -2795,8 +2795,7 @@ static int __init w83627ehf_find(int sioaddr, unsigned short *addr,
 	/* Activate logical device if needed */
 	val = superio_inb(sioaddr, SIO_REG_ENABLE);
 	if (!(val & 0x01)) {
-		pr_warn("Forcibly enabling Super-I/O. "
-			"Sensor is probably unusable.\n");
+		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
 		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
 	}
 
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index aeec5b1..f9d5139 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -64,8 +64,8 @@ enum chips { w83781d, w83782d, w83783s, as99127f };
 /* Insmod parameters */
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
-MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
-		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
+MODULE_PARM_DESC(force_subclients,
+		 "List of subclient addresses: {bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static bool reset;
 module_param(reset, bool, 0);
@@ -826,8 +826,9 @@ store_sensor(struct device *dev, struct device_attribute *da,
 		data->sens[nr] = val;
 		break;
 	case W83781D_DEFAULT_BETA:
-		dev_warn(dev, "Sensor type %d is deprecated, please use 4 "
-			 "instead\n", W83781D_DEFAULT_BETA);
+		dev_warn(dev,
+			 "Sensor type %d is deprecated, please use 4 instead\n",
+			 W83781D_DEFAULT_BETA);
 		/* fall through */
 	case 4:		/* thermistor */
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
@@ -874,8 +875,8 @@ w83781d_detect_subclients(struct i2c_client *new_client)
 		for (i = 2; i <= 3; i++) {
 			if (force_subclients[i] < 0x48 ||
 			    force_subclients[i] > 0x4f) {
-				dev_err(&new_client->dev, "Invalid subclient "
-					"address %d; must be 0x48-0x4f\n",
+				dev_err(&new_client->dev,
+					"Invalid subclient address %d; must be 0x48-0x4f\n",
 					force_subclients[i]);
 				err = -EINVAL;
 				goto ERROR_SC_1;
@@ -910,9 +911,9 @@ w83781d_detect_subclients(struct i2c_client *new_client)
 	for (i = 0; i < num_sc; i++) {
 		data->lm75[i] = i2c_new_dummy(adapter, sc_addr[i]);
 		if (!data->lm75[i]) {
-			dev_err(&new_client->dev, "Subclient %d "
-				"registration at address 0x%x "
-				"failed.\n", i, sc_addr[i]);
+			dev_err(&new_client->dev,
+				"Subclient %d registration at address 0x%x failed.\n",
+				i, sc_addr[i]);
 			err = -ENOMEM;
 			if (i = 1)
 				goto ERROR_SC_3;
@@ -1176,8 +1177,9 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 		goto err_nodev;
 
 	if (val1 <= 0x30 && w83781d_alias_detect(client, val1)) {
-		dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
-			"be the same as ISA device\n", address);
+		dev_dbg(&adapter->dev,
+			"Device at 0x%02x appears to be the same as ISA device\n",
+			address);
 		goto err_nodev;
 	}
 
@@ -1367,8 +1369,8 @@ w83781d_init_device(struct device *dev)
 		 * as I see very little reason why this would be needed at
 		 * all.
 		 */
-		dev_info(dev, "If reset=1 solved a problem you were "
-			 "having, please report!\n");
+		dev_info(dev,
+			 "If reset=1 solved a problem you were having, please report!\n");
 
 		/* save these registers */
 		i = w83781d_read_value(data, W83781D_REG_BEEP_CONFIG);
@@ -1425,8 +1427,8 @@ w83781d_init_device(struct device *dev)
 		/* Enable temp2 */
 		tmp = w83781d_read_value(data, W83781D_REG_TEMP2_CONFIG);
 		if (tmp & 0x01) {
-			dev_warn(dev, "Enabling temp2, readings "
-				 "might not make sense\n");
+			dev_warn(dev,
+				 "Enabling temp2, readings might not make sense\n");
 			w83781d_write_value(data, W83781D_REG_TEMP2_CONFIG,
 				tmp & 0xfe);
 		}
@@ -1436,8 +1438,8 @@ w83781d_init_device(struct device *dev)
 			tmp = w83781d_read_value(data,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
-				dev_warn(dev, "Enabling temp3, "
-					 "readings might not make sense\n");
+				dev_warn(dev,
+					 "Enabling temp3, readings might not make sense\n");
 				w83781d_write_value(data,
 					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 38ddddd..a3feee3 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -56,8 +56,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
-MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
-			"{bus, clientaddr, subclientaddr1, subclientaddr2}");
+MODULE_PARM_DESC(force_subclients,
+		 "List of subclient addresses: {bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static bool reset;
 module_param(reset, bool, 0);
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 5cb83dd..0b80489 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -54,8 +54,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
-MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
-			"{bus, clientaddr, subclientaddr1, subclientaddr2}");
+MODULE_PARM_DESC(force_subclients,
+		 "List of subclient addresses: {bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static bool init;
 module_param(init, bool, 0);
@@ -951,8 +951,8 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 		for (i = 2; i <= 3; i++) {
 			if (force_subclients[i] < 0x48 ||
 			    force_subclients[i] > 0x4f) {
-				dev_err(&new_client->dev, "invalid subclient "
-					"address %d; must be 0x48-0x4f\n",
+				dev_err(&new_client->dev,
+					"invalid subclient address %d; must be 0x48-0x4f\n",
 					force_subclients[i]);
 				err = -ENODEV;
 				goto ERROR_SC_0;
@@ -969,8 +969,9 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
 			((val & 0x7) = ((val >> 4) & 0x7))) {
-			dev_err(&new_client->dev, "duplicate addresses 0x%x, "
-				"use force_subclient\n", data->lm75[0]->addr);
+			dev_err(&new_client->dev,
+				"duplicate addresses 0x%x, use force_subclient\n",
+				data->lm75[0]->addr);
 			err = -ENODEV;
 			goto ERROR_SC_1;
 		}
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 6604275..b0c30a5 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -59,8 +59,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
-MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
-		       "{bus, clientaddr, subclientaddr1, subclientaddr2}");
+MODULE_PARM_DESC(force_subclients,
+		 "List of subclient addresses: {bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static bool reset;
 module_param(reset, bool, 0);
@@ -1921,8 +1921,8 @@ static int w83793_probe(struct i2c_client *client,
 	}
 	if (i = ARRAY_SIZE(watchdog_minors)) {
 		data->watchdog_miscdev.minor = 0;
-		dev_warn(&client->dev, "Couldn't register watchdog chardev "
-			"(due to no free minor)\n");
+		dev_warn(&client->dev,
+			 "Couldn't register watchdog chardev (due to no free minor)\n");
 	}
 
 	mutex_unlock(&watchdog_data_mutex);
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index e226096..908209d 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -2120,11 +2120,12 @@ static void w83795_check_dynamic_in_limits(struct i2c_client *client)
 					   &w83795_in[i][3].dev_attr.attr,
 					   S_IRUGO);
 		if (err_max || err_min)
-			dev_warn(&client->dev, "Failed to set in%d limits "
-				 "read-only (%d, %d)\n", i, err_max, err_min);
+			dev_warn(&client->dev,
+				 "Failed to set in%d limits read-only (%d, %d)\n",
+				 i, err_max, err_min);
 		else
-			dev_info(&client->dev, "in%d limits set dynamically "
-				 "from VID\n", i);
+			dev_info(&client->dev,
+				 "in%d limits set dynamically from VID\n", i);
 	}
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
