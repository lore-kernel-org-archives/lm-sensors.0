From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [PATCH 2.6] I2C: Clean up i2c-amd756 and i2c-prosavage messages
Message-Id: <20041016212605.630f6e64.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

A number of messages in the i2c-amd756 and i2c-prosavage drivers have a
leading ": " (especially the former). This is a legacy from lm_sensors'
printks of the 2.4 times. This patch cleans them up. While I was there,
I dropped a couple useless white spaces and dots as well.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-amd756.c linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756.c
--- linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-amd756.c	2004-10-16 19:53:21.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756.c	2004-10-16 21:13:45.000000000 +0200
@@ -116,14 +116,14 @@
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&adap->dev, ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
+	dev_dbg(&adap->dev, "Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
 		"DAT=%04x\n", inw_p(SMB_GLOBAL_STATUS),
 		inw_p(SMB_GLOBAL_ENABLE), inw_p(SMB_HOST_ADDRESS),
 		inb_p(SMB_HOST_DATA));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
-		dev_dbg(&adap->dev, ": SMBus busy (%04x). Waiting... \n", temp);
+		dev_dbg(&adap->dev, "SMBus busy (%04x). Waiting...\n", temp);
 		do {
 			msleep(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
@@ -131,7 +131,7 @@
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
-			dev_dbg(&adap->dev, ": Busy wait timeout (%04x)\n", temp);
+			dev_dbg(&adap->dev, "Busy wait timeout (%04x)\n", temp);
 			goto abort;
 		}
 		timeout = 0;
@@ -148,46 +148,46 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		dev_dbg(&adap->dev, ": Completion timeout!\n");
+		dev_dbg(&adap->dev, "Completion timeout!\n");
 		goto abort;
 	}
 
 	if (temp & GS_PRERR_STS) {
 		result = -1;
-		dev_dbg(&adap->dev, ": SMBus Protocol error (no response)!\n");
+		dev_dbg(&adap->dev, "SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
 		result = -1;
-		dev_warn(&adap->dev, " SMBus collision!\n");
+		dev_warn(&adap->dev, "SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
 		result = -1;
-		dev_dbg(&adap->dev, ": SMBus protocol timeout!\n");
+		dev_dbg(&adap->dev, "SMBus protocol timeout!\n");
 	}
 
 	if (temp & GS_HCYC_STS)
-		dev_dbg(&adap->dev, " SMBus protocol success!\n");
+		dev_dbg(&adap->dev, "SMBus protocol success!\n");
 
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 
 #ifdef DEBUG
 	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
 		dev_dbg(&adap->dev,
-			": Failed reset at end of transaction (%04x)\n", temp);
+			"Failed reset at end of transaction (%04x)\n", temp);
 	}
 #endif
 
 	dev_dbg(&adap->dev,
-		": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+		"Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
 		inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
 		inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
 
 	return result;
 
  abort:
-	dev_warn(&adap->dev, ": Sending abort.\n");
+	dev_warn(&adap->dev, "Sending abort\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
 	msleep(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
@@ -204,7 +204,7 @@
 	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		dev_dbg(&adap->dev, ": I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_dbg(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		/* TODO: Well... It is supported, I'm just not sure what to do here... */
 		return -1;
 	case I2C_SMBUS_QUICK:
@@ -334,8 +334,8 @@
 	u8 temp;
 	
 	if (amd756_ioport) {
-		dev_err(&pdev->dev, ": Only one device supported. "
-		       "(you have a strange motherboard, btw..)\n");
+		dev_err(&pdev->dev, "Only one device supported "
+		       "(you have a strange motherboard, btw)\n");
 		return -ENODEV;
 	}
 
@@ -352,7 +352,7 @@
 		pci_read_config_byte(pdev, SMBGCFG, &temp);
 		if ((temp & 128) = 0) {
 			dev_err(&pdev->dev,
-				": Error: SMBus controller I/O not enabled!\n");
+				"Error: SMBus controller I/O not enabled!\n");
 			return -ENODEV;
 		}
 
@@ -364,14 +364,14 @@
 	}
 
 	if (!request_region(amd756_ioport, SMB_IOSIZE, "amd756-smbus")) {
-		dev_err(&pdev->dev, ": SMB region 0x%x already in use!\n",
+		dev_err(&pdev->dev, "SMB region 0x%x already in use!\n",
 			amd756_ioport);
 		return -ENODEV;
 	}
 
 	pci_read_config_byte(pdev, SMBREV, &temp);
-	dev_dbg(&pdev->dev, ": SMBREV = 0x%X\n", temp);
-	dev_dbg(&pdev->dev, ": AMD756_smba = 0x%X\n", amd756_ioport);
+	dev_dbg(&pdev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&pdev->dev, "AMD756_smba = 0x%X\n", amd756_ioport);
 
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
@@ -382,7 +382,7 @@
 	error = i2c_add_adapter(&amd756_adapter);
 	if (error) {
 		dev_err(&pdev->dev,
-			": Adapter registration failed, module not inserted.\n");
+			"Adapter registration failed, module not inserted\n");
 		goto out_err;
 	}
 
diff -ruN linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-prosavage.c linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-prosavage.c
--- linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-prosavage.c	2004-10-12 19:44:25.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-prosavage.c	2004-10-16 21:01:03.000000000 +0200
@@ -228,7 +228,7 @@
 
 		ret = i2c_bit_del_bus(&chip->i2c_bus[i].adap);
 	        if (ret) {
-			dev_err(&dev->dev, ": %s not removed\n",
+			dev_err(&dev->dev, "%s not removed\n",
 				chip->i2c_bus[i].adap.name);
 		}
 	}
@@ -298,7 +298,7 @@
 	}
 	return 0;
 err_adap:
-	dev_err(&dev->dev, ": %s failed\n", bus->adap.name);
+	dev_err(&dev->dev, "%s failed\n", bus->adap.name);
 	prosavage_remove(dev);
 	return ret;
 }


-- 
Jean Delvare
http://khali.linux-fr.org/
