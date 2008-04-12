From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 18:03:40 +0000
Subject: [lm-sensors] [PATCH 07/10] hwmon: (lm85) Rework the device detection
Message-Id: <20080412200340.54b47ea6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rework the device detection to make it clearer and faster in the
general case (when a known device is found.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |  120 ++++++++++++++++++++------------------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-03 16:06:27.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-03 16:29:06.000000000 +0200
@@ -1107,7 +1107,6 @@ static void lm85_init_client(struct i2c_
 static int lm85_detect(struct i2c_adapter *adapter, int address,
 		int kind)
 {
-	int company, verstep;
 	struct i2c_client *client;
 	struct lm85_data *data;
 	int err = 0;
@@ -1118,10 +1117,6 @@ static int lm85_detect(struct i2c_adapte
 		goto ERROR0;
 	}
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access lm85_{read,write}_value. */
-
 	if (!(data = kzalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
@@ -1133,75 +1128,60 @@ static int lm85_detect(struct i2c_adapte
 	client->adapter = adapter;
 	client->driver = &lm85_driver;
 
-	/* Now, we do the remaining detection. */
-
-	company = lm85_read_value(client, LM85_REG_COMPANY);
-	verstep = lm85_read_value(client, LM85_REG_VERSTEP);
+	/* If auto-detecting, determine the chip type */
+	if (kind <= 0) {
+		int company = lm85_read_value(client, LM85_REG_COMPANY);
+		int verstep = lm85_read_value(client, LM85_REG_VERSTEP);
 
-	dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
-		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
-		i2c_adapter_id(client->adapter), client->addr,
-		company, verstep);
+		dev_dbg(&adapter->dev, "Detecting device at 0x%02x with "
+			"COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+			address, company, verstep);
+
+		if (company = LM85_COMPANY_NATIONAL) {
+			switch (verstep) {
+			case LM85_VERSTEP_LM85C:
+				kind = lm85c;
+				break;
+			case LM85_VERSTEP_LM85B:
+				kind = lm85b;
+				break;
+			}
+		} else if (company = LM85_COMPANY_ANALOG_DEV) {
+			switch (verstep) {
+			case LM85_VERSTEP_ADM1027:
+				kind = adm1027;
+				break;
+			case LM85_VERSTEP_ADT7463:
+			case LM85_VERSTEP_ADT7463C:
+				kind = adt7463;
+				break;
+			}
+		} else if (company = LM85_COMPANY_SMSC) {
+			switch (verstep) {
+			case LM85_VERSTEP_EMC6D100_A0:
+			case LM85_VERSTEP_EMC6D100_A1:
+				/* Note: we can't tell a '100 from a '101 */
+				kind = emc6d100;
+				break;
+			case LM85_VERSTEP_EMC6D102:
+				kind = emc6d102;
+				break;
+			}
+		}
 
-	/* If auto-detecting, Determine the chip type. */
-	if (kind <= 0) {
-		dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x ...\n",
-			i2c_adapter_id(adapter), address);
-		if (company = LM85_COMPANY_NATIONAL
-		    && verstep = LM85_VERSTEP_LM85C) {
-			kind = lm85c;
-		} else if (company = LM85_COMPANY_NATIONAL
-		    && verstep = LM85_VERSTEP_LM85B) {
-			kind = lm85b;
-		} else if (company = LM85_COMPANY_NATIONAL
-		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
-			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
-				" Defaulting to LM85.\n", verstep);
-			kind = any_chip;
-		} else if (company = LM85_COMPANY_ANALOG_DEV
-		    && verstep = LM85_VERSTEP_ADM1027) {
-			kind = adm1027;
-		} else if (company = LM85_COMPANY_ANALOG_DEV
-		    && (verstep = LM85_VERSTEP_ADT7463
-			 || verstep = LM85_VERSTEP_ADT7463C)) {
-			kind = adt7463;
-		} else if (company = LM85_COMPANY_ANALOG_DEV
-		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
-			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
-				" Defaulting to Generic LM85.\n", verstep);
-			kind = any_chip;
-		} else if (company = LM85_COMPANY_SMSC
-		    && (verstep = LM85_VERSTEP_EMC6D100_A0
-			 || verstep = LM85_VERSTEP_EMC6D100_A1)) {
-			/* Unfortunately, we can't tell a '100 from a '101
-			 * from the registers.  Since a '101 is a '100
-			 * in a package with fewer pins and therefore no
-			 * 3.3V, 1.5V or 1.8V inputs, perhaps if those
-			 * inputs read 0, then it's a '101.
-			 */
-			kind = emc6d100;
-		} else if (company = LM85_COMPANY_SMSC
-		    && verstep = LM85_VERSTEP_EMC6D102) {
-			kind = emc6d102;
-		} else if (company = LM85_COMPANY_SMSC
-		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
-			dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
-			dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
-			    " Defaulting to Generic LM85.\n", verstep);
+		/* Not a known device, but maybe compatible */
+		if (kind <= 0
+		 && (company = LM85_COMPANY_NATIONAL
+		  || company = LM85_COMPANY_ANALOG_DEV
+		  || company = LM85_COMPANY_SMSC)
+		 && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
+			dev_info(&adapter->dev, "LM85-compatible device "
+				 "detected at 0x%02x\n", address);
 			kind = any_chip;
-		} else if (kind = any_chip
-		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
-			dev_err(&adapter->dev, "Generic LM85 Version 6 detected\n");
-			/* Leave kind as "any_chip" */
-		} else {
+		}
+
+		if (kind < 0) {
 			dev_dbg(&adapter->dev, "Autodetection failed\n");
-			/* Not an LM85... */
-			if (kind = any_chip) {  /* User used force=x,y */
-				dev_err(&adapter->dev, "Generic LM85 Version 6 not"
-					" found at %d,0x%02x. Try force_lm85c.\n",
-					i2c_adapter_id(adapter), address);
-			}
-			err = 0;
 			goto ERROR1;
 		}
 	}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
