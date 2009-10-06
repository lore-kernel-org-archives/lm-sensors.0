From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 17:42:10 +0000
Subject: [lm-sensors] hwmon: (adm1021) Clean up detect function
Message-Id: <20091006194210.58e4f4e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1021.c |   76 +++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 51 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/adm1021.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/adm1021.c	2009-10-06 11:33:22.000000000 +0200
@@ -288,9 +288,8 @@ static int adm1021_detect(struct i2c_cli
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int i;
-	const char *type_name = "";
-	int conv_rate, status, config;
+	const char *type_name;
+	int conv_rate, status, config, man_id, dev_id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		pr_debug("adm1021: detect failed, "
@@ -303,62 +302,37 @@ static int adm1021_detect(struct i2c_cli
 					     ADM1021_REG_CONV_RATE_R);
 	config = i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R);
 
-	/* Now, we do the remaining detection. */
-	if (kind < 0) {
-		if ((status & 0x03) != 0x00 || (config & 0x3F) != 0x00
-		    || (conv_rate & 0xF8) != 0x00) {
-			pr_debug("adm1021: detect failed, "
-				 "chip not detected!\n");
-			return -ENODEV;
-		}
+	/* Check unused bits */
+	if ((status & 0x03) || (config & 0x3F) || (conv_rate & 0xF8)) {
+		pr_debug("adm1021: detect failed, chip not detected!\n");
+		return -ENODEV;
 	}
 
 	/* Determine the chip type. */
-	if (kind <= 0) {
-		i = i2c_smbus_read_byte_data(client, ADM1021_REG_MAN_ID);
-		if (i = 0x41)
-			if ((i2c_smbus_read_byte_data(client,
-					ADM1021_REG_DEV_ID) & 0xF0) = 0x30)
-				kind = adm1023;
-			else
-				kind = adm1021;
-		else if (i = 0x49)
-			kind = thmc10;
-		else if (i = 0x23)
-			kind = gl523sm;
-		else if ((i = 0x4d) &&
-			 (i2c_smbus_read_byte_data(client,
-						   ADM1021_REG_DEV_ID) = 0x01))
-			kind = max1617a;
-		else if (i = 0x54)
-			kind = mc1066;
-		/* LM84 Mfr ID in a different place, and it has more unused bits */
-		else if (conv_rate = 0x00
-			 && (kind = 0 /* skip extra detection */
-			     || ((config & 0x7F) = 0x00
-				 && (status & 0xAB) = 0x00)))
-			kind = lm84;
-		else
-			kind = max1617;
-	}
+	man_id = i2c_smbus_read_byte_data(client, ADM1021_REG_MAN_ID);
+	dev_id = i2c_smbus_read_byte_data(client, ADM1021_REG_DEV_ID);
 
-	if (kind = max1617) {
-		type_name = "max1617";
-	} else if (kind = max1617a) {
+	if (man_id = 0x4d && dev_id = 0x01)
 		type_name = "max1617a";
-	} else if (kind = adm1021) {
-		type_name = "adm1021";
-	} else if (kind = adm1023) {
-		type_name = "adm1023";
-	} else if (kind = thmc10) {
+	else if (man_id = 0x41) {
+		if ((dev_id & 0xF0) = 0x30)
+			type_name = "adm1023";
+		else
+			type_name = "adm1021";
+	} else if (man_id = 0x49)
 		type_name = "thmc10";
-	} else if (kind = lm84) {
-		type_name = "lm84";
-	} else if (kind = gl523sm) {
+	else if (man_id = 0x23)
 		type_name = "gl523sm";
-	} else if (kind = mc1066) {
+	else if (man_id = 0x54)
 		type_name = "mc1066";
-	}
+	/* LM84 Mfr ID in a different place, and it has more unused bits */
+	else if (conv_rate = 0x00
+		 && (config & 0x7F) = 0x00
+		 && (status & 0xAB) = 0x00)
+		type_name = "lm84";
+	else
+		type_name = "max1617";
+
 	pr_debug("adm1021: Detected chip %s at adapter %d, address 0x%02x.\n",
 		 type_name, i2c_adapter_id(adapter), client->addr);
 	strlcpy(info->type, type_name, I2C_NAME_SIZE);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
