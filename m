From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:41:54 +0000
Subject: [lm-sensors] [PATCH 09/11] hwmon: (adt7475) Add support for the
Message-Id: <20091202164154.6aed4994@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the Analog Devices ADT7476 chip. This chip is largely
compatible with the ADT7473 and ADT7475, with additional features.
In particular, it has 5 voltage inputs instead of 2, and VID input
pins.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 Documentation/hwmon/adt7475 |   20 ++++++++--
 drivers/hwmon/Kconfig       |    5 +-
 drivers/hwmon/adt7475.c     |   80 +++++++++++++++++++++++++++++++++----------
 3 files changed, 80 insertions(+), 25 deletions(-)

--- linux-2.6.32-rc8.orig/Documentation/hwmon/adt7475	2009-12-02 14:30:35.000000000 +0100
+++ linux-2.6.32-rc8/Documentation/hwmon/adt7475	2009-12-02 14:31:43.000000000 +0100
@@ -10,6 +10,10 @@ Supported chips:
     Prefix: 'adt7475'
     Addresses scanned: I2C 0x2E
     Datasheet: Publicly available at the On Semiconductors website
+  * Analog Devices ADT7476
+    Prefix: 'adt7476'
+    Addresses scanned: I2C 0x2C, 0x2D, 0x2E
+    Datasheet: Publicly available at the On Semiconductors website
   * Analog Devices ADT7490
     Prefix: 'adt7490'
     Addresses scanned: I2C 0x2C, 0x2D, 0x2E
@@ -25,11 +29,13 @@ Authors:
 Description
 -----------
 
-This driver implements support for the Analog Devices ADT7473, ADT7475 and
-ADT7490 chip family. The ADT7473 and ADT7475 differ only in minor details.
-The ADT7490 has additional features, including extra voltage measurement
-inputs and PECI support. All the supported chips will be collectively
-designed by the name "ADT747x" in the rest of this document.
+This driver implements support for the Analog Devices ADT7473, ADT7475,
+ADT7476 and ADT7490 chip family. The ADT7473 and ADT7475 differ only in
+minor details. The ADT7476 has additional features, including extra voltage
+measurement inputs and VID support. The ADT7490 also has additional
+features, including extra voltage measurement inputs and PECI support. All
+the supported chips will be collectively designed by the name "ADT747x" in
+the rest of this document.
 
 The ADT747x uses the 2-wire interface compatible with the SMBus 2.0
 specification. Using an analog to digital converter it measures three (3)
@@ -62,6 +68,10 @@ ADT7473:
 ADT7475:
   * 2 voltage inputs
 
+ADT7476:
+  * 5 voltage inputs
+  * VID support (not implemented)
+
 ADT7490:
   * 6 voltage inputs
   * 1 Imon input (not implemented)
--- linux-2.6.32-rc8.orig/drivers/hwmon/Kconfig	2009-12-02 14:30:35.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/Kconfig	2009-12-02 14:31:43.000000000 +0100
@@ -205,11 +205,12 @@ config SENSORS_ADT7473
 	  will be called adt7473.
 
 config SENSORS_ADT7475
-	tristate "Analog Devices ADT7473, ADT7475 and ADT7490"
+	tristate "Analog Devices ADT7473, ADT7475, ADT7476 and ADT7490"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the Analog Devices
-	  ADT7473, ADT7475 and ADT7490 hardware monitoring chips.
+	  ADT7473, ADT7475, ADT7476 and ADT7490 hardware monitoring
+	  chips.
 
 	  This driver can also be build as a module.  If so, the module
 	  will be called adt7475.
--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 14:31:20.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 14:31:43.000000000 +0100
@@ -58,6 +58,8 @@
 #define REG_STATUS1		0x41
 #define REG_STATUS2		0x42
 
+#define REG_VID			0x43	/* ADT7476 only */
+
 #define REG_VOLTAGE_MIN_BASE	0x44
 #define REG_VOLTAGE_MAX_BASE	0x45
 
@@ -94,6 +96,8 @@
 #define REG_VTT_MIN		0x84	/* ADT7490 only */
 #define REG_VTT_MAX		0x86	/* ADT7490 only */
 
+#define VID_VIDSEL		0x80	/* ADT7476 only */
+
 #define CONFIG2_ATTN		0x20
 
 #define CONFIG3_SMBALERT	0x01
@@ -142,11 +146,12 @@
 
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-I2C_CLIENT_INSMOD_3(adt7473, adt7475, adt7490);
+I2C_CLIENT_INSMOD_4(adt7473, adt7475, adt7476, adt7490);
 
 static const struct i2c_device_id adt7475_id[] = {
 	{ "adt7473", adt7473 },
 	{ "adt7475", adt7475 },
+	{ "adt7476", adt7476 },
 	{ "adt7490", adt7490 },
 	{ }
 };
@@ -1082,7 +1087,6 @@ static struct attribute *pwm2_attrs[]  	NULL
 };
 
-/* Attributes specific to the ADT7490 */
 static struct attribute *in0_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
@@ -1091,15 +1095,23 @@ static struct attribute *in0_attrs[] = {
 	NULL
 };
 
-static struct attribute *adt7490_attrs[] = {
+static struct attribute *in3_attrs[] = {
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
 	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *in4_attrs[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *in5_attrs[] = {
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in5_min.dev_attr.attr,
@@ -1111,7 +1123,9 @@ static struct attribute_group adt7475_at
 static struct attribute_group fan4_attr_group = { .attrs = fan4_attrs };
 static struct attribute_group pwm2_attr_group = { .attrs = pwm2_attrs };
 static struct attribute_group in0_attr_group = { .attrs = in0_attrs };
-static struct attribute_group adt7490_attr_group = { .attrs = adt7490_attrs };
+static struct attribute_group in3_attr_group = { .attrs = in3_attrs };
+static struct attribute_group in4_attr_group = { .attrs = in4_attrs };
+static struct attribute_group in5_attr_group = { .attrs = in5_attrs };
 
 static int adt7475_detect(struct i2c_client *client, int kind,
 			  struct i2c_board_info *info)
@@ -1134,11 +1148,13 @@ static int adt7475_detect(struct i2c_cli
 		name = "adt7473";
 	else if (devid = 0x75 && client->addr = 0x2e)
 		name = "adt7475";
+	else if (devid = 0x76)
+		name = "adt7476";
 	else if ((devid2 & 0xfc) = 0x6c)
 		name = "adt7490";
 	else {
 		dev_dbg(&adapter->dev,
-			"Couldn't detect an ADT7473/75/90 part at "
+			"Couldn't detect an ADT7473/75/76/90 part at "
 			"0x%02x\n", (unsigned int)client->addr);
 		return -ENODEV;
 	}
@@ -1152,14 +1168,18 @@ static void adt7475_remove_files(struct
 				 struct adt7475_data *data)
 {
 	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
-	if (data->has_voltage & 0x39)
-		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
 	if (data->has_fan4)
 		sysfs_remove_group(&client->dev.kobj, &fan4_attr_group);
 	if (data->has_pwm2)
 		sysfs_remove_group(&client->dev.kobj, &pwm2_attr_group);
 	if (data->has_voltage & (1 << 0))
 		sysfs_remove_group(&client->dev.kobj, &in0_attr_group);
+	if (data->has_voltage & (1 << 3))
+		sysfs_remove_group(&client->dev.kobj, &in3_attr_group);
+	if (data->has_voltage & (1 << 4))
+		sysfs_remove_group(&client->dev.kobj, &in4_attr_group);
+	if (data->has_voltage & (1 << 5))
+		sysfs_remove_group(&client->dev.kobj, &in5_attr_group);
 }
 
 static int adt7475_probe(struct i2c_client *client,
@@ -1168,6 +1188,7 @@ static int adt7475_probe(struct i2c_clie
 	static const char *names[] = {
 		[adt7473] = "ADT7473",
 		[adt7475] = "ADT7475",
+		[adt7476] = "ADT7476",
 		[adt7490] = "ADT7490",
 	};
 
@@ -1184,6 +1205,10 @@ static int adt7475_probe(struct i2c_clie
 
 	/* Initialize device-specific values */
 	switch (id->driver_data) {
+	case adt7476:
+		data->has_voltage = 0x0e;	/* in1 to in3 */
+		revision = adt7475_read(REG_DEVID2) & 0x07;
+		break;
 	case adt7490:
 		data->has_voltage = 0x3e;	/* in1 to in5 */
 		revision = adt7475_read(REG_DEVID2) & 0x03;
@@ -1208,17 +1233,27 @@ static int adt7475_probe(struct i2c_clie
 	if ((data->config4 & CONFIG4_PINFUNC) = 0x0)
 		data->has_fan4 = 1;
 
-	/* THERM configuration is more complex on the ADT7490, because 2
-	   different pins (TACH4 and +2.5 Vin) can be used for this function */
+	/* THERM configuration is more complex on the ADT7476 and ADT7490,
+	   because 2 different pins (TACH4 and +2.5 Vin) can be used for
+	   this function */
 	if (id->driver_data = adt7490) {
 		if ((data->config4 & CONFIG4_PINFUNC) = 0x1 &&
 		    !(config3 & CONFIG3_THERM))
 			data->has_fan4 = 1;
+	}
+	if (id->driver_data = adt7476 || id->driver_data = adt7490) {
 		if (!(config3 & CONFIG3_THERM) ||
 		    (data->config4 & CONFIG4_PINFUNC) = 0x1)
 			data->has_voltage |= (1 << 0);		/* in0 */
 	}
 
+	/* On the ADT7476, the +12V input pin may instead be used as VID5 */
+	if (id->driver_data = adt7476) {
+		u8 vid = adt7475_read(REG_VID);
+		if (!(vid & VID_VIDSEL))
+			data->has_voltage |= (1 << 4);		/* in4 */
+	}
+
 	/* Voltage attenuators can be bypassed, globally or individually */
 	config2 = adt7475_read(REG_CONFIG2);
 	if (config2 & CONFIG2_ATTN) {
@@ -1238,13 +1273,6 @@ static int adt7475_probe(struct i2c_clie
 	if (ret)
 		goto efree;
 
-	if (id->driver_data = adt7490) {
-		ret = sysfs_create_group(&client->dev.kobj,
-					 &adt7490_attr_group);
-		if (ret)
-			goto eremove;
-	}
-
 	/* Features that can be disabled individually */
 	if (data->has_fan4) {
 		ret = sysfs_create_group(&client->dev.kobj, &fan4_attr_group);
@@ -1261,6 +1289,21 @@ static int adt7475_probe(struct i2c_clie
 		if (ret)
 			goto eremove;
 	}
+	if (data->has_voltage & (1 << 3)) {
+		ret = sysfs_create_group(&client->dev.kobj, &in3_attr_group);
+		if (ret)
+			goto eremove;
+	}
+	if (data->has_voltage & (1 << 4)) {
+		ret = sysfs_create_group(&client->dev.kobj, &in4_attr_group);
+		if (ret)
+			goto eremove;
+	}
+	if (data->has_voltage & (1 << 5)) {
+		ret = sysfs_create_group(&client->dev.kobj, &in5_attr_group);
+		if (ret)
+			goto eremove;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1270,9 +1313,10 @@ static int adt7475_probe(struct i2c_clie
 
 	dev_info(&client->dev, "%s device, revision %d\n",
 		 names[id->driver_data], revision);
-	if ((data->has_voltage & (1 << 0)) || data->has_fan4 || data->has_pwm2)
-		dev_info(&client->dev, "Optional features:%s%s%s\n",
+	if ((data->has_voltage & 0x11) || data->has_fan4 || data->has_pwm2)
+		dev_info(&client->dev, "Optional features:%s%s%s%s\n",
 			 (data->has_voltage & (1 << 0)) ? " in0" : "",
+			 (data->has_voltage & (1 << 4)) ? " in4" : "",
 			 data->has_fan4 ? " fan4" : "",
 			 data->has_pwm2 ? " pwm2" : "");
 	if (data->bypass_attn)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
