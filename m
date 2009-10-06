From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 17:43:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm85) Clean up detect function
Message-Id: <20091006194357.7845b7d2@hyperion.delvare>
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

 drivers/hwmon/lm85.c |  155 ++++++++++++++++++++------------------------------
 1 file changed, 64 insertions(+), 91 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/lm85.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/lm85.c	2009-10-06 11:45:05.000000000 +0200
@@ -5,7 +5,7 @@
     Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
     Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
     Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
-    Copyright (C) 2007, 2008  Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007- 2009  Jean Delvare <khali@linux-fr.org>
 
     Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
 
@@ -1162,107 +1162,80 @@ static int lm85_detect(struct i2c_client
 	struct i2c_adapter *adapter = client->adapter;
 	int address = client->addr;
 	const char *type_name;
+	int company, verstep;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		/* We need to be able to do byte I/O */
 		return -ENODEV;
 	}
 
-	/* If auto-detecting, determine the chip type */
-	if (kind < 0) {
-		int company = lm85_read_value(client, LM85_REG_COMPANY);
-		int verstep = lm85_read_value(client, LM85_REG_VERSTEP);
-
-		dev_dbg(&adapter->dev, "Detecting device at 0x%02x with "
-			"COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
-			address, company, verstep);
-
-		/* All supported chips have the version in common */
-		if ((verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC &&
-		    (verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC2) {
-			dev_dbg(&adapter->dev, "Autodetection failed: "
-				"unsupported version\n");
-			return -ENODEV;
-		}
-		kind = any_chip;
+	/* Determine the chip type */
+	company = lm85_read_value(client, LM85_REG_COMPANY);
+	verstep = lm85_read_value(client, LM85_REG_VERSTEP);
+
+	dev_dbg(&adapter->dev, "Detecting device at 0x%02x with "
+		"COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+		address, company, verstep);
+
+	/* All supported chips have the version in common */
+	if ((verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC &&
+	    (verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC2) {
+		dev_dbg(&adapter->dev,
+			"Autodetection failed: unsupported version\n");
+		return -ENODEV;
+	}
+	type_name = "lm85";
 
-		/* Now, refine the detection */
-		if (company = LM85_COMPANY_NATIONAL) {
-			switch (verstep) {
-			case LM85_VERSTEP_LM85C:
-				kind = lm85c;
-				break;
-			case LM85_VERSTEP_LM85B:
-				kind = lm85b;
-				break;
-			case LM85_VERSTEP_LM96000_1:
-			case LM85_VERSTEP_LM96000_2:
-				/* Check for Winbond WPCD377I */
-				if (lm85_is_fake(client)) {
-					dev_dbg(&adapter->dev,
-						"Found Winbond WPCD377I, "
-						"ignoring\n");
-					return -ENODEV;
-				}
-				break;
-			}
-		} else if (company = LM85_COMPANY_ANALOG_DEV) {
-			switch (verstep) {
-			case LM85_VERSTEP_ADM1027:
-				kind = adm1027;
-				break;
-			case LM85_VERSTEP_ADT7463:
-			case LM85_VERSTEP_ADT7463C:
-				kind = adt7463;
-				break;
-			case LM85_VERSTEP_ADT7468_1:
-			case LM85_VERSTEP_ADT7468_2:
-				kind = adt7468;
-				break;
-			}
-		} else if (company = LM85_COMPANY_SMSC) {
-			switch (verstep) {
-			case LM85_VERSTEP_EMC6D100_A0:
-			case LM85_VERSTEP_EMC6D100_A1:
-				/* Note: we can't tell a '100 from a '101 */
-				kind = emc6d100;
-				break;
-			case LM85_VERSTEP_EMC6D102:
-				kind = emc6d102;
-				break;
+	/* Now, refine the detection */
+	if (company = LM85_COMPANY_NATIONAL) {
+		switch (verstep) {
+		case LM85_VERSTEP_LM85C:
+			type_name = "lm85c";
+			break;
+		case LM85_VERSTEP_LM85B:
+			type_name = "lm85b";
+			break;
+		case LM85_VERSTEP_LM96000_1:
+		case LM85_VERSTEP_LM96000_2:
+			/* Check for Winbond WPCD377I */
+			if (lm85_is_fake(client)) {
+				dev_dbg(&adapter->dev,
+					"Found Winbond WPCD377I, ignoring\n");
+				return -ENODEV;
 			}
-		} else {
-			dev_dbg(&adapter->dev, "Autodetection failed: "
-				"unknown vendor\n");
-			return -ENODEV;
+			break;
+		}
+	} else if (company = LM85_COMPANY_ANALOG_DEV) {
+		switch (verstep) {
+		case LM85_VERSTEP_ADM1027:
+			type_name = "adm1027";
+			break;
+		case LM85_VERSTEP_ADT7463:
+		case LM85_VERSTEP_ADT7463C:
+			type_name = "adt7463";
+			break;
+		case LM85_VERSTEP_ADT7468_1:
+		case LM85_VERSTEP_ADT7468_2:
+			type_name = "adt7468";
+			break;
+		}
+	} else if (company = LM85_COMPANY_SMSC) {
+		switch (verstep) {
+		case LM85_VERSTEP_EMC6D100_A0:
+		case LM85_VERSTEP_EMC6D100_A1:
+			/* Note: we can't tell a '100 from a '101 */
+			type_name = "emc6d100";
+			break;
+		case LM85_VERSTEP_EMC6D102:
+			type_name = "emc6d102";
+			break;
 		}
+	} else {
+		dev_dbg(&adapter->dev,
+			"Autodetection failed: unknown vendor\n");
+		return -ENODEV;
 	}
 
-	switch (kind) {
-	case lm85b:
-		type_name = "lm85b";
-		break;
-	case lm85c:
-		type_name = "lm85c";
-		break;
-	case adm1027:
-		type_name = "adm1027";
-		break;
-	case adt7463:
-		type_name = "adt7463";
-		break;
-	case adt7468:
-		type_name = "adt7468";
-		break;
-	case emc6d100:
-		type_name = "emc6d100";
-		break;
-	case emc6d102:
-		type_name = "emc6d102";
-		break;
-	default:
-		type_name = "lm85";
-	}
 	strlcpy(info->type, type_name, I2C_NAME_SIZE);
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
