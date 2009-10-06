From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 17:43:34 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm83) Clean up detect function
Message-Id: <20091006194334.3e580923@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm83.c |   81 ++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 55 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/lm83.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/lm83.c	2009-10-06 11:44:50.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * lm83.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003-2008  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2009  Jean Delvare <khali@linux-fr.org>
  *
  * Heavily inspired from the lm78, lm75 and adm1021 drivers. The LM83 is
  * a sensor chip made by National Semiconductor. It reports up to four
@@ -295,69 +295,40 @@ static int lm83_detect(struct i2c_client
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
-	const char *name = "";
+	const char *name;
+	u8 man_id, chip_id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/* Now we do the detection and identification. A negative kind
-	 * means that the driver was loaded with no force parameter
-	 * (default), so we must both detect and identify the chip
-	 * (actually there is only one possible kind of chip for now, LM83).
-	 * A zero kind means that the driver was loaded with the force
-	 * parameter, the detection step shall be skipped. A positive kind
-	 * means that the driver was loaded with the force parameter and a
-	 * given kind of chip is requested, so both the detection and the
-	 * identification steps are skipped. */
-
-	/* Default to an LM83 if forced */
-	if (kind = 0)
-		kind = lm83;
-
-	if (kind < 0) { /* detection */
-		if (((i2c_smbus_read_byte_data(new_client, LM83_REG_R_STATUS1)
-		    & 0xA8) != 0x00) ||
-		    ((i2c_smbus_read_byte_data(new_client, LM83_REG_R_STATUS2)
-		    & 0x48) != 0x00) ||
-		    ((i2c_smbus_read_byte_data(new_client, LM83_REG_R_CONFIG)
-		    & 0x41) != 0x00)) {
-			dev_dbg(&adapter->dev,
-				"LM83 detection failed at 0x%02x.\n",
-				new_client->addr);
-			return -ENODEV;
-		}
+	/* Detection */
+	if ((i2c_smbus_read_byte_data(new_client, LM83_REG_R_STATUS1) & 0xA8) ||
+	    (i2c_smbus_read_byte_data(new_client, LM83_REG_R_STATUS2) & 0x48) ||
+	    (i2c_smbus_read_byte_data(new_client, LM83_REG_R_CONFIG) & 0x41)) {
+		dev_dbg(&adapter->dev, "LM83 detection failed at 0x%02x\n",
+			new_client->addr);
+		return -ENODEV;
 	}
 
-	if (kind <= 0) { /* identification */
-		u8 man_id, chip_id;
-
-		man_id = i2c_smbus_read_byte_data(new_client,
-		    LM83_REG_R_MAN_ID);
-		chip_id = i2c_smbus_read_byte_data(new_client,
-		    LM83_REG_R_CHIP_ID);
-
-		if (man_id = 0x01) { /* National Semiconductor */
-			if (chip_id = 0x03) {
-				kind = lm83;
-			} else
-			if (chip_id = 0x01) {
-				kind = lm82;
-			}
-		}
-
-		if (kind <= 0) { /* identification failed */
-			dev_info(&adapter->dev,
-			    "Unsupported chip (man_id=0x%02X, "
-			    "chip_id=0x%02X).\n", man_id, chip_id);
-			return -ENODEV;
-		}
-	}
+	/* Identification */
+	man_id = i2c_smbus_read_byte_data(new_client, LM83_REG_R_MAN_ID);
+	if (man_id != 0x01)	/* National Semiconductor */
+		return -ENODEV;
 
-	if (kind = lm83) {
+	chip_id = i2c_smbus_read_byte_data(new_client, LM83_REG_R_CHIP_ID);
+	switch (chip_id) {
+	case 0x03:
 		name = "lm83";
-	} else
-	if (kind = lm82) {
+		break;
+	case 0x01:
 		name = "lm82";
+		break;
+	default:
+		/* identification failed */
+		dev_info(&adapter->dev,
+			 "Unsupported chip (man_id=0x%02X, chip_id=0x%02X)\n",
+			 man_id, chip_id);
+		return -ENODEV;
 	}
 
 	strlcpy(info->type, name, I2C_NAME_SIZE);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
