From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 17:44:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Clean up detect function
Message-Id: <20091006194423.082b4e88@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
The patch looks large, but most of it is really only removing one
depth of indentation.

 drivers/hwmon/lm90.c |  228 +++++++++++++++++++++-----------------------------
 1 file changed, 96 insertions(+), 132 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/lm90.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/lm90.c	2009-10-06 11:54:36.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * lm90.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003-2008  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2009  Jean Delvare <khali@linux-fr.org>
  *
  * Based on the lm83 driver. The LM90 is a sensor chip made by National
  * Semiconductor. It reports up to two temperatures (its own plus up to
@@ -661,154 +661,118 @@ static int lm90_detect(struct i2c_client
 {
 	struct i2c_adapter *adapter = new_client->adapter;
 	int address = new_client->addr;
-	const char *name = "";
+	const char *name = NULL;
+	int man_id, chip_id, reg_config1, reg_convrate;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/*
-	 * Now we do the remaining detection. A negative kind means that
-	 * the driver was loaded with no force parameter (default), so we
-	 * must both detect and identify the chip. A zero kind means that
-	 * the driver was loaded with the force parameter, the detection
-	 * step shall be skipped. A positive kind means that the driver
-	 * was loaded with the force parameter and a given kind of chip is
-	 * requested, so both the detection and the identification steps
-	 * are skipped.
-	 */
-
-	/* Default to an LM90 if forced */
-	if (kind = 0)
-		kind = lm90;
-
-	if (kind < 0) { /* detection and identification */
-		int man_id, chip_id, reg_config1, reg_convrate;
-
-		if ((man_id = i2c_smbus_read_byte_data(new_client,
+	/* detection and identification */
+	if ((man_id = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_MAN_ID)) < 0
-		 || (chip_id = i2c_smbus_read_byte_data(new_client,
+	 || (chip_id = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CHIP_ID)) < 0
-		 || (reg_config1 = i2c_smbus_read_byte_data(new_client,
+	 || (reg_config1 = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONFIG1)) < 0
-		 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
+	 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONVRATE)) < 0)
+		return -ENODEV;
+
+	if ((address = 0x4C || address = 0x4D)
+	 && man_id = 0x01) { /* National Semiconductor */
+		int reg_config2;
+
+		reg_config2 = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CONFIG2);
+		if (reg_config2 < 0)
 			return -ENODEV;
-		
-		if ((address = 0x4C || address = 0x4D)
-		 && man_id = 0x01) { /* National Semiconductor */
-			int reg_config2;
-
-			if ((reg_config2 = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONFIG2)) < 0)
-				return -ENODEV;
-
-			if ((reg_config1 & 0x2A) = 0x00
-			 && (reg_config2 & 0xF8) = 0x00
-			 && reg_convrate <= 0x09) {
-				if (address = 0x4C
-				 && (chip_id & 0xF0) = 0x20) { /* LM90 */
-					kind = lm90;
-				} else
-				if ((chip_id & 0xF0) = 0x30) { /* LM89/LM99 */
-					kind = lm99;
-					dev_info(&adapter->dev,
-						 "Assuming LM99 chip at "
-						 "0x%02x\n", address);
-					dev_info(&adapter->dev,
-						 "If it is an LM89, pass "
-						 "force_lm86=%d,0x%02x when "
-						 "loading the lm90 driver\n",
-						 i2c_adapter_id(adapter),
-						 address);
-				} else
-				if (address = 0x4C
-				 && (chip_id & 0xF0) = 0x10) { /* LM86 */
-					kind = lm86;
-				}
-			}
-		} else
-		if ((address = 0x4C || address = 0x4D)
-		 && man_id = 0x41) { /* Analog Devices */
-			if ((chip_id & 0xF0) = 0x40 /* ADM1032 */
-			 && (reg_config1 & 0x3F) = 0x00
-			 && reg_convrate <= 0x0A) {
-				kind = adm1032;
-			} else
-			if (chip_id = 0x51 /* ADT7461 */
-			 && (reg_config1 & 0x1B) = 0x00
-			 && reg_convrate <= 0x0A) {
-				kind = adt7461;
-			}
-		} else
-		if (man_id = 0x4D) { /* Maxim */
-			/*
-			 * The MAX6657, MAX6658 and MAX6659 do NOT have a
-			 * chip_id register. Reading from that address will
-			 * return the last read value, which in our case is
-			 * those of the man_id register. Likewise, the config1
-			 * register seems to lack a low nibble, so the value
-			 * will be those of the previous read, so in our case
-			 * those of the man_id register.
-			 */
-			if (chip_id = man_id
-			 && (address = 0x4C || address = 0x4D)
-			 && (reg_config1 & 0x1F) = (man_id & 0x0F)
-			 && reg_convrate <= 0x09) {
-			 	kind = max6657;
+
+		if ((reg_config1 & 0x2A) = 0x00
+		 && (reg_config2 & 0xF8) = 0x00
+		 && reg_convrate <= 0x09) {
+			if (address = 0x4C
+			 && (chip_id & 0xF0) = 0x20) { /* LM90 */
+				name = "lm90";
 			} else
-			/* The chip_id register of the MAX6680 and MAX6681
-			 * holds the revision of the chip.
-			 * the lowest bit of the config1 register is unused
-			 * and should return zero when read, so should the
-			 * second to last bit of config1 (software reset)
-			 */
-			if (chip_id = 0x01
-			 && (reg_config1 & 0x03) = 0x00
-			 && reg_convrate <= 0x07) {
-			 	kind = max6680;
+			if ((chip_id & 0xF0) = 0x30) { /* LM89/LM99 */
+				name = "lm99";
+				dev_info(&adapter->dev,
+					 "Assuming LM99 chip at 0x%02x\n",
+					 address);
+				dev_info(&adapter->dev,
+					 "If it is an LM89, instantiate it "
+					 "with the new_device sysfs "
+					 "interface\n");
 			} else
-			/* The chip_id register of the MAX6646/6647/6649
-			 * holds the revision of the chip.
-			 * The lowest 6 bits of the config1 register are
-			 * unused and should return zero when read.
-			 */
-			if (chip_id = 0x59
-			 && (reg_config1 & 0x3f) = 0x00
-			 && reg_convrate <= 0x07) {
-				kind = max6646;
+			if (address = 0x4C
+			 && (chip_id & 0xF0) = 0x10) { /* LM86 */
+				name = "lm86";
 			}
 		}
-
-		if (kind <= 0) { /* identification failed */
-			dev_dbg(&adapter->dev,
-				"Unsupported chip at 0x%02x (man_id=0x%02X, "
-				"chip_id=0x%02X)\n", address, man_id, chip_id);
-			return -ENODEV;
+	} else
+	if ((address = 0x4C || address = 0x4D)
+	 && man_id = 0x41) { /* Analog Devices */
+		if ((chip_id & 0xF0) = 0x40 /* ADM1032 */
+		 && (reg_config1 & 0x3F) = 0x00
+		 && reg_convrate <= 0x0A) {
+			name = "adm1032";
+			/* The ADM1032 supports PEC, but only if combined
+			   transactions are not used. */
+			if (i2c_check_functionality(adapter,
+						    I2C_FUNC_SMBUS_BYTE))
+				info->flags |= I2C_CLIENT_PEC;
+		} else
+		if (chip_id = 0x51 /* ADT7461 */
+		 && (reg_config1 & 0x1B) = 0x00
+		 && reg_convrate <= 0x0A) {
+			name = "adt7461";
+		}
+	} else
+	if (man_id = 0x4D) { /* Maxim */
+		/*
+		 * The MAX6657, MAX6658 and MAX6659 do NOT have a chip_id
+		 * register. Reading from that address will return the last
+		 * read value, which in our case is those of the man_id
+		 * register. Likewise, the config1 register seems to lack a
+		 * low nibble, so the value will be those of the previous
+		 * read, so in our case those of the man_id register.
+		 */
+		if (chip_id = man_id
+		 && (address = 0x4C || address = 0x4D)
+		 && (reg_config1 & 0x1F) = (man_id & 0x0F)
+		 && reg_convrate <= 0x09) {
+			name = "max6657";
+		} else
+		/*
+		 * The chip_id register of the MAX6680 and MAX6681 holds the
+		 * revision of the chip. The lowest bit of the config1 register
+		 * is unused and should return zero when read, so should the
+		 * second to last bit of config1 (software reset).
+		 */
+		if (chip_id = 0x01
+		 && (reg_config1 & 0x03) = 0x00
+		 && reg_convrate <= 0x07) {
+			name = "max6680";
+		} else
+		/*
+		 * The chip_id register of the MAX6646/6647/6649 holds the
+		 * revision of the chip. The lowest 6 bits of the config1
+		 * register are unused and should return zero when read.
+		 */
+		if (chip_id = 0x59
+		 && (reg_config1 & 0x3f) = 0x00
+		 && reg_convrate <= 0x07) {
+			name = "max6646";
 		}
 	}
 
-	/* Fill the i2c board info */
-	if (kind = lm90) {
-		name = "lm90";
-	} else if (kind = adm1032) {
-		name = "adm1032";
-		/* The ADM1032 supports PEC, but only if combined
-		   transactions are not used. */
-		if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-			info->flags |= I2C_CLIENT_PEC;
-	} else if (kind = lm99) {
-		name = "lm99";
-	} else if (kind = lm86) {
-		name = "lm86";
-	} else if (kind = max6657) {
-		name = "max6657";
-	} else if (kind = max6680) {
-		name = "max6680";
-	} else if (kind = adt7461) {
-		name = "adt7461";
-	} else if (kind = max6646) {
-		name = "max6646";
+	if (!name) { /* identification failed */
+		dev_dbg(&adapter->dev,
+			"Unsupported chip at 0x%02x (man_id=0x%02X, "
+			"chip_id=0x%02X)\n", address, man_id, chip_id);
+		return -ENODEV;
 	}
+
 	strlcpy(info->type, name, I2C_NAME_SIZE);
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
