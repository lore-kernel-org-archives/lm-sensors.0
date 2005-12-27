From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Tue, 27 Dec 2005 00:02:30 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <200512270102.30671.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

I invested a little bit of time into the nforce2/3/4 SMBus driver and changed 
the following things:

- general cleanup:
	o removed code for the unsupported I2C block transfer mode
	o removed detail warnings about unsupported modes that are covered in a 
general warning (unsupported transaction...) anyway
	o removed necessity of a definition of struct i2c_adapter
	o moved definition of struct i2c_algorithm, making forward declarations of 
nforce2_access and nforce2_func unnecessary
- improvements:
	o support MCP51 and MCP55 southbridges
	o advertise  I2C_FUNC_SMBUS_BLOCK_DATA, so that it really can be used

the patch is relative to 2.6.15-rc7 with your patch 
i2c-nforce2-support-nforce4-mcp04.patch of 18 december (thanks) already 
applied. If preferred, I can of course also send a full patch relative to 
2.6.15-rc7 (which should be applicable to other kernel versions as well).

Signed-off-by: Hans-Frieder Vogt <hfvogt at arcor.de>

--- linux-2.6.15-rc7-jean/include/linux/pci_ids.h	2005-12-26 
13:15:06.582626423 +0100
+++ linux-2.6.15-rc7/include/linux/pci_ids.h	2005-12-26 13:15:34.625804868 
+0100
@@ -1091,9 +1091,11 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS	0x0264
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS	0x0368
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x037E
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2	0x037F
--- linux-2.6.15-rc7-jean/Documentation/i2c/busses/i2c-nforce2	2005-12-26 
13:10:06.125382505 +0100
+++ linux-2.6.15-rc7/Documentation/i2c/busses/i2c-nforce2	2005-12-26 
13:11:48.400743251 +0100
@@ -7,6 +7,8 @@
   * nForce3 250Gb MCP          10de:00E4 
   * nForce4 MCP	       	       10de:0052
   * nForce4 MCP-04             10de:0034
+  * nForce  MCP-51             10de:0264
+  * nForce  MCP-55             10de:0368
 
 Datasheet: not publically available, but seems to be similar to the
            AMD-8111 SMBus 2.0 adapter.
--- linux-2.6.15-rc7-jean/drivers/i2c/busses/i2c-nforce2.c	2005-12-26 
13:12:48.669359700 +0100
+++ linux-2.6.15-rc7/drivers/i2c/busses/i2c-nforce2.c	2005-12-27 
00:21:24.719391220 +0100
@@ -31,6 +31,8 @@
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
     nForce4 MCP-04		0034
+    nForce MCP-51		0264
+    nForce MCP-55		0368
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -100,24 +102,7 @@
 
 static struct pci_driver nforce2_driver;
 
-static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
-		       unsigned short flags, char read_write,
-		       u8 command, int size, union i2c_smbus_data *data);
-static u32 nforce2_func(struct i2c_adapter *adapter);
 
-
-static struct i2c_algorithm smbus_algorithm = {
-	.smbus_xfer = nforce2_access,
-	.functionality = nforce2_func,
-};
-
-static struct i2c_adapter nforce2_adapter = {
-	.owner          = THIS_MODULE,
-	.class          = I2C_CLASS_HWMON,
-	.algo           = &smbus_algorithm,
-};
-
-/* Return -1 on error. See smbus.h for more information */
 static s32 nforce2_access(struct i2c_adapter * adap, u16 addr,
 		unsigned short flags, char read_write,
 		u8 command, int size, union i2c_smbus_data * data)
@@ -171,24 +156,6 @@
 			protocol |= NVIDIA_SMB_PRTCL_BLOCK_DATA | pec;
 			break;
 
-		case I2C_SMBUS_I2C_BLOCK_DATA:
-			len = min_t(u8, data->block[0], 32);
-			outb_p(command, NVIDIA_SMB_CMD);
-			outb_p(len, NVIDIA_SMB_BCNT);
-			if (read_write = I2C_SMBUS_WRITE)
-				for (i = 0; i < len; i++)
-					outb_p(data->block[i + 1], NVIDIA_SMB_DATA+i);
-			protocol |= NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA;
-			break;
-
-		case I2C_SMBUS_PROC_CALL:
-			dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-			return -1;
-
-		case I2C_SMBUS_BLOCK_PROC_CALL:
-			dev_err(&adap->dev, "I2C_SMBUS_BLOCK_PROC_CALL not supported!\n");
-			return -1;
-
 		default:
 			dev_err(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
@@ -224,15 +191,12 @@
 			break;
 
 		case I2C_SMBUS_WORD_DATA:
-		/* case I2C_SMBUS_PROC_CALL: not supported */
 			data->word = inb_p(NVIDIA_SMB_DATA) | (inb_p(NVIDIA_SMB_DATA+1) << 8);
 			break;
 
 		case I2C_SMBUS_BLOCK_DATA:
-		/* case I2C_SMBUS_BLOCK_PROC_CALL: not supported */
 			len = inb_p(NVIDIA_SMB_BCNT);
 			len = min_t(u8, len, 32);
-		case I2C_SMBUS_I2C_BLOCK_DATA:
 			for (i = 0; i < len; i++)
 				data->block[i+1] = inb_p(NVIDIA_SMB_DATA + i);
 			data->block[0] = len;
@@ -247,10 +211,15 @@
 {
 	/* other functionality might be possible, but is not tested */
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA /* |
-	    I2C_FUNC_SMBUS_BLOCK_DATA */;
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+static struct i2c_algorithm smbus_algorithm = {
+	.smbus_xfer = nforce2_access,
+	.functionality = nforce2_func,
+};
+
 
 static struct pci_device_id nforce2_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS) },
@@ -259,6 +228,8 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, 
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, 
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, 
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS) },
 	{ 0 }
 };
 
@@ -278,14 +249,16 @@
 	}
 	smbus->dev  = dev;
 	smbus->base = iobase & 0xfffc;
-	smbus->size = 8;
+	smbus->size = 64;
 
 	if (!request_region(smbus->base, smbus->size, nforce2_driver.name)) {
 		dev_err(&smbus->adapter.dev, "Error requesting region %02x .. %02X for 
%s\n",
 			smbus->base, smbus->base+smbus->size-1, name);
 		return -1;
 	}
-	smbus->adapter = nforce2_adapter;
+	smbus->adapter.owner = THIS_MODULE;
+	smbus->adapter.class = I2C_CLASS_HWMON;
+	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 	smbus->adapter.dev.parent = &dev->dev;
 	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
@@ -318,6 +291,7 @@
 		dev_err(&dev->dev, "Error probing SMB1.\n");
 		smbuses[0].base = 0;	/* to have a check value */
 	}
+	/* SMBus adapter 2 */
 	res2 = nforce2_probe_smb (dev, NFORCE_PCI_SMB2, &smbuses[1], "SMB2");
 	if (res2 < 0) {
 		dev_err(&dev->dev, "Error probing SMB2.\n");


-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net

