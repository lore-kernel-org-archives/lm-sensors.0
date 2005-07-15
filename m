From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 15 Jul 2005 09:13:32 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Missing space in split strings
Message-Id: <20050715085305.4dc8c732.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

A few split string in i2c (and now hwmon) drivers lack a joining space,
causing them to display incorrectly. This trivial patch fixes that up.
Please apply, thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/adm1026.c       |    2 +-
 drivers/hwmon/max1619.c       |    2 +-
 drivers/hwmon/pc87360.c       |    2 +-
 drivers/i2c/busses/i2c-i801.c |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/pc87360.c	2005-07-13 23:34:59.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/pc87360.c	2005-07-13 23:35:05.000000000 +0200
@@ -1056,7 +1056,7 @@
 	if (init >= 2 && data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONVRATE);
-		dev_info(&client->dev, "VLM conversion set to"
+		dev_info(&client->dev, "VLM conversion set to "
 			 "1s period, 160us delay\n");
 		pc87360_write_value(data, LD_IN, NO_BANK,
 				    PC87365_REG_IN_CONVRATE,
--- linux-2.6.13-rc3.orig/drivers/i2c/busses/i2c-i801.c	2005-07-13 23:34:12.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/busses/i2c-i801.c	2005-07-13 23:35:05.000000000 +0200
@@ -137,7 +137,7 @@
 		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
 		i801_smba &= 0xfff0;
 		if(i801_smba = 0) {
-			dev_err(&dev->dev, "SMB base address uninitialized"
+			dev_err(&dev->dev, "SMB base address uninitialized "
 				"- upgrade BIOS or use force_addr=0xaddr\n");
 			return -ENODEV;
 		}
@@ -186,7 +186,7 @@
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x,"
+	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
 		inb_p(SMBHSTDAT1));
@@ -240,7 +240,7 @@
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction"
+		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
 			"(%02x)\n", temp);
 	}
 	dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
--- linux-2.6.13-rc3.orig/drivers/hwmon/adm1026.c	2005-07-13 23:34:59.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/adm1026.c	2005-07-13 23:35:05.000000000 +0200
@@ -398,7 +398,7 @@
 
 	value = data->config3;
 	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev, "GPIO16 enabled.  THERM"
+		dev_dbg(&client->dev, "GPIO16 enabled.  THERM "
 			"pin disabled.\n");
 	} else {
 		dev_dbg(&client->dev, "THERM pin enabled.  "
--- linux-2.6.13-rc3.orig/drivers/hwmon/max1619.c	2005-07-13 23:34:59.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/max1619.c	2005-07-13 23:35:05.000000000 +0200
@@ -376,7 +376,7 @@
 	i2c_del_driver(&max1619_driver);
 }
 
-MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and"
+MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and "
 	"Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("MAX1619 sensor driver");
 MODULE_LICENSE("GPL");


-- 
Jean Delvare
