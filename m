From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jul 2011 18:37:05 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm90) Refactor reading of config2
Message-Id: <20110724203705.37ad14cf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Several vendors implement a second configuration register, which we
check during device detection. Refactor the code to avoid duplication.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Stijn Devriendt <sdevrien@cisco.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm90.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

--- linux-3.0-rc6.orig/drivers/hwmon/lm90.c	2011-07-07 14:26:10.000000000 +0200
+++ linux-3.0-rc6/drivers/hwmon/lm90.c	2011-07-07 15:04:03.000000000 +0200
@@ -1111,7 +1111,7 @@ static int lm90_detect(struct i2c_client
 	struct i2c_adapter *adapter = new_client->adapter;
 	int address = new_client->addr;
 	const char *name = NULL;
-	int man_id, chip_id, reg_config1, reg_convrate;
+	int man_id, chip_id, reg_config1, reg_config2, reg_convrate;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -1127,15 +1127,16 @@ static int lm90_detect(struct i2c_client
 						LM90_REG_R_CONVRATE)) < 0)
 		return -ENODEV;
 
-	if ((address = 0x4C || address = 0x4D)
-	 && man_id = 0x01) { /* National Semiconductor */
-		int reg_config2;
-
+	if (man_id = 0x01 || man_id = 0x5C || man_id = 0x41) {
 		reg_config2 = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONFIG2);
 		if (reg_config2 < 0)
 			return -ENODEV;
+	} else
+		reg_config2 = 0;	/* Make compiler happy */
 
+	if ((address = 0x4C || address = 0x4D)
+	 && man_id = 0x01) { /* National Semiconductor */
 		if ((reg_config1 & 0x2A) = 0x00
 		 && (reg_config2 & 0xF8) = 0x00
 		 && reg_convrate <= 0x09) {
@@ -1264,13 +1265,6 @@ static int lm90_detect(struct i2c_client
 	} else
 	if (address = 0x4C
 	 && man_id = 0x5C) { /* Winbond/Nuvoton */
-		int reg_config2;
-
-		reg_config2 = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONFIG2);
-		if (reg_config2 < 0)
-			return -ENODEV;
-
 		if ((reg_config1 & 0x2A) = 0x00
 		 && (reg_config2 & 0xF8) = 0x00) {
 			if (chip_id = 0x01 /* W83L771W/G */
@@ -1285,13 +1279,6 @@ static int lm90_detect(struct i2c_client
 	} else
 	if (address >= 0x48 && address <= 0x4F
 	 && man_id = 0xA1) { /*  NXP Semiconductor/Philips */
-		int reg_config2;
-
-		reg_config2 = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONFIG2);
-		if (reg_config2 < 0)
-			return -ENODEV;
-
 		if (chip_id = 0x00
 		 && (reg_config1 & 0x2A) = 0x00
 		 && (reg_config2 & 0xFE) = 0x00


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
