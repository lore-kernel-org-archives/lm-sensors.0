From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 14:27:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm80) Add detection of NatSemi/TI LM96080
Message-Id: <20120131152711.7402733d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add detection of the National Semiconductor (now Texas Instruments)
LM96080. It is functionally compatible with the LM80 but detection is
completely different.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
Guenter, I'll let you pick this one as you have already several lm80
patches in your tree.

 Documentation/hwmon/lm80 |    9 ++++++++-
 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/lm80.c     |   44 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 12 deletions(-)

--- linux-3.3-rc1.orig/Documentation/hwmon/lm80	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.3-rc1/Documentation/hwmon/lm80	2012-01-31 14:53:29.578234088 +0100
@@ -7,6 +7,11 @@ Supported chips:
     Addresses scanned: I2C 0x28 - 0x2f
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/
+  * National Semiconductor LM96080
+    Prefix: 'lm96080'
+    Addresses scanned: I2C 0x28 - 0x2f
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
 
 Authors:
         Frodo Looijaard <frodol@dds.nl>,
@@ -17,7 +22,9 @@ Description
 
 This driver implements support for the National Semiconductor LM80.
 It is described as a 'Serial Interface ACPI-Compatible Microprocessor
-System Hardware Monitor'.
+System Hardware Monitor'. The LM96080 is a more recent incarnation,
+it is pin and register compatible, with a few additional features not
+yet supported by the driver.
 
 The LM80 implements one temperature sensor, two fan rotation speed sensors,
 seven voltage sensors, alarms, and some miscellaneous stuff.
--- linux-3.3-rc1.orig/drivers/hwmon/Kconfig	2012-01-31 09:59:47.000000000 +0100
+++ linux-3.3-rc1/drivers/hwmon/Kconfig	2012-01-31 14:13:00.671500654 +0100
@@ -597,11 +597,11 @@ config SENSORS_LM78
 	  will be called lm78.
 
 config SENSORS_LM80
-	tristate "National Semiconductor LM80"
+	tristate "National Semiconductor LM80 and LM96080"
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor
-	  LM80 sensor chips.
+	  LM80 and LM96080 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm80.
--- linux-3.3-rc1.orig/drivers/hwmon/lm80.c	2012-01-31 14:09:09.000000000 +0100
+++ linux-3.3-rc1/drivers/hwmon/lm80.c	2012-01-31 14:55:45.653838657 +0100
@@ -60,6 +60,10 @@ static const unsigned short normal_i2c[]
 #define LM80_REG_FANDIV			0x05
 #define LM80_REG_RES			0x06
 
+#define LM96080_REG_CONV_RATE		0x07
+#define LM96080_REG_MAN_ID		0x3e
+#define LM96080_REG_DEV_ID		0x3f
+
 
 /*
  * Conversions. Rounding and limit checking is only done on the TO_REG
@@ -147,6 +151,7 @@ static int lm80_write_value(struct i2c_c
 
 static const struct i2c_device_id lm80_id[] = {
 	{ "lm80", 0 },
+	{ "lm96080", 1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm80_id);
@@ -490,23 +495,44 @@ static const struct attribute_group lm80
 static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int i, cur;
+	int i, cur, man_id, dev_id;
+	const char *name = NULL;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/* Now, we do the remaining detection. It is lousy. */
-	if (lm80_read_value(client, LM80_REG_ALARM2) & 0xc0)
+	/* First check for unused bits, common to both chip types */
+	if ((lm80_read_value(client, LM80_REG_ALARM2) & 0xc0)
+	 || (lm80_read_value(client, LM80_REG_CONFIG) & 0x80))
 		return -ENODEV;
-	for (i = 0x2a; i <= 0x3d; i++) {
-		cur = i2c_smbus_read_byte_data(client, i);
-		if ((i2c_smbus_read_byte_data(client, i + 0x40) != cur)
-		 || (i2c_smbus_read_byte_data(client, i + 0x80) != cur)
-		 || (i2c_smbus_read_byte_data(client, i + 0xc0) != cur))
+
+	/*
+	 * The LM96080 has manufacturer and stepping/die rev registers so we
+	 * can just check that. The LM80 does not have such registers so we
+	 * have to use a more expensive trick.
+	 */
+	man_id = lm80_read_value(client, LM96080_REG_MAN_ID);
+	dev_id = lm80_read_value(client, LM96080_REG_DEV_ID);
+	if (man_id = 0x01 && dev_id = 0x08) {
+		/* Check more unused bits for confirmation */
+		if (lm80_read_value(client, LM96080_REG_CONV_RATE) & 0xfe)
 			return -ENODEV;
+
+		name = "lm96080";
+	} else {
+		/* Check 6-bit addressing */
+		for (i = 0x2a; i <= 0x3d; i++) {
+			cur = i2c_smbus_read_byte_data(client, i);
+			if ((i2c_smbus_read_byte_data(client, i + 0x40) != cur)
+			 || (i2c_smbus_read_byte_data(client, i + 0x80) != cur)
+			 || (i2c_smbus_read_byte_data(client, i + 0xc0) != cur))
+				return -ENODEV;
+		}
+
+		name = "lm80";
 	}
 
-	strlcpy(info->type, "lm80", I2C_NAME_SIZE);
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
