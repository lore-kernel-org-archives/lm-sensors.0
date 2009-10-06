From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 17:42:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1025) Clean up detect function
Message-Id: <20091006194230.28b50328@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c |   73 ++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/adm1025.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/adm1025.c	2009-10-06 11:44:13.000000000 +0200
@@ -2,7 +2,7 @@
  * adm1025.c
  *
  * Copyright (C) 2000       Chen-Yuan Wu <gwu@esoft.com>
- * Copyright (C) 2003-2008  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2009  Jean Delvare <khali@linux-fr.org>
  *
  * The ADM1025 is a sensor chip made by Analog Devices. It reports up to 6
  * voltages (including its own power source) and up to two temperatures
@@ -413,67 +413,34 @@ static int adm1025_detect(struct i2c_cli
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	const char *name = "";
-	u8 config;
+	const char *name;
+	u8 man_id, chip_id;
 
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
-	config = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
-	if (kind < 0) { /* detection */
-		if ((config & 0x80) != 0x00
-		 || (i2c_smbus_read_byte_data(client,
-		     ADM1025_REG_STATUS1) & 0xC0) != 0x00
-		 || (i2c_smbus_read_byte_data(client,
-		     ADM1025_REG_STATUS2) & 0xBC) != 0x00) {
-			dev_dbg(&adapter->dev,
-				"ADM1025 detection failed at 0x%02x.\n",
-				client->addr);
-			return -ENODEV;
-		}
+	/* Check for unused bits */
+	if ((i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG) & 0x80)
+	 || (i2c_smbus_read_byte_data(client, ADM1025_REG_STATUS1) & 0xC0)
+	 || (i2c_smbus_read_byte_data(client, ADM1025_REG_STATUS2) & 0xBC)) {
+		dev_dbg(&adapter->dev, "ADM1025 detection failed at 0x%02x\n",
+			client->addr);
+		return -ENODEV;
 	}
 
-	if (kind <= 0) { /* identification */
-		u8 man_id, chip_id;
-
-		man_id = i2c_smbus_read_byte_data(client, ADM1025_REG_MAN_ID);
-		chip_id = i2c_smbus_read_byte_data(client, ADM1025_REG_CHIP_ID);
-
-		if (man_id = 0x41) { /* Analog Devices */
-			if ((chip_id & 0xF0) = 0x20) { /* ADM1025/ADM1025A */
-				kind = adm1025;
-			}
-		} else
-		if (man_id = 0xA1) { /* Philips */
-			if (client->addr != 0x2E
-			 && (chip_id & 0xF0) = 0x20) { /* NE1619 */
-				kind = ne1619;
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
+	chip_id = i2c_smbus_read_byte_data(client, ADM1025_REG_CHIP_ID);
+	if ((chip_id & 0xF0) != 0x20)
+		return -ENODEV;
 
-	if (kind = adm1025) {
+	man_id = i2c_smbus_read_byte_data(client, ADM1025_REG_MAN_ID);
+	if (man_id = 0x41)
 		name = "adm1025";
-	} else if (kind = ne1619) {
+	else if (man_id = 0xA1 && client->addr != 0x2E)
 		name = "ne1619";
-	}
+	else
+		return -ENODEV;
+
 	strlcpy(info->type, name, I2C_NAME_SIZE);
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
