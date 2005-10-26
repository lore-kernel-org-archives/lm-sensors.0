From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:30:35 +0000
Subject: [lm-sensors] [PATCH 11/16] i2c: SMBus PEC support rewrite, 3 of 3
Message-Id: <20051026213115.19b83fee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-smbus-pec-03-drop-swpec-sizes.patch

The new SMBus PEC implementation doesn't support PEC emulation on
non-PEC non-I2C SMBus masters, so we can drop all related code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-amd8111.c |    7 -------
 drivers/i2c/busses/i2c-i801.c    |   13 +++++--------
 drivers/i2c/busses/i2c-nforce2.c |    7 -------
 include/linux/i2c.h              |    4 ----
 4 files changed, 5 insertions(+), 26 deletions(-)

--- linux-2.6.14-rc5.orig/drivers/i2c/busses/i2c-amd8111.c	2005-10-23 13:13:54.000000000 +0200
+++ linux-2.6.14-rc5/drivers/i2c/busses/i2c-amd8111.c	2005-10-23 13:33:37.000000000 +0200
@@ -253,13 +253,6 @@
 			read_write = I2C_SMBUS_READ;
 			break;
 
-		case I2C_SMBUS_WORD_DATA_PEC:
-		case I2C_SMBUS_BLOCK_DATA_PEC:
-		case I2C_SMBUS_PROC_CALL_PEC:
-		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			dev_warn(&adap->dev, "Unexpected software PEC transaction %d\n", size);
-			return -1;
-
 		default:
 			dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
--- linux-2.6.14-rc5.orig/drivers/i2c/busses/i2c-nforce2.c	2005-10-23 13:13:54.000000000 +0200
+++ linux-2.6.14-rc5/drivers/i2c/busses/i2c-nforce2.c	2005-10-23 13:33:37.000000000 +0200
@@ -188,13 +188,6 @@
 			dev_err(&adap->dev, "I2C_SMBUS_BLOCK_PROC_CALL not supported!\n");
 			return -1;
 
-		case I2C_SMBUS_WORD_DATA_PEC:
-		case I2C_SMBUS_BLOCK_DATA_PEC:
-		case I2C_SMBUS_PROC_CALL_PEC:
-		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			dev_err(&adap->dev, "Unexpected software PEC transaction %d\n", size);
-			return -1;
-
 		default:
 			dev_err(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
--- linux-2.6.14-rc5.orig/include/linux/i2c.h	2005-10-23 13:33:37.000000000 +0200
+++ linux-2.6.14-rc5/include/linux/i2c.h	2005-10-23 13:33:37.000000000 +0200
@@ -451,10 +451,6 @@
 #define I2C_SMBUS_BLOCK_DATA	    5
 #define I2C_SMBUS_I2C_BLOCK_DATA    6
 #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
-#define I2C_SMBUS_BLOCK_DATA_PEC    8		/* SMBus 2.0 */
-#define I2C_SMBUS_PROC_CALL_PEC     9		/* SMBus 2.0 */
-#define I2C_SMBUS_BLOCK_PROC_CALL_PEC  10	/* SMBus 2.0 */
-#define I2C_SMBUS_WORD_DATA_PEC	   11		/* SMBus 2.0 */
 
 
 /* ----- commands for the ioctl like i2c_command call:
--- linux-2.6.14-rc5.orig/drivers/i2c/busses/i2c-i801.c	2005-10-23 13:33:37.000000000 +0200
+++ linux-2.6.14-rc5/drivers/i2c/busses/i2c-i801.c	2005-10-23 13:35:11.000000000 +0200
@@ -102,8 +102,8 @@
 		 "EXTREMELY DANGEROUS!");
 
 static int i801_transaction(void);
-static int i801_block_transaction(union i2c_smbus_data *data,
-				  char read_write, int command);
+static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
+				  int command, int hwpec);
 
 static unsigned short i801_smba;
 static struct pci_driver i801_driver;
@@ -249,7 +249,7 @@
 
 /* All-inclusive block transaction function */
 static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
-				  int command)
+				  int command, int hwpec)
 {
 	int i, len;
 	int smbcmd;
@@ -388,7 +388,7 @@
 			goto END;
 	}
 
-	if(isich4 && command = I2C_SMBUS_BLOCK_DATA_PEC) {
+	if (hwpec && command = I2C_SMBUS_BLOCK_DATA) {
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
 		do {
@@ -456,9 +456,6 @@
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-	case I2C_SMBUS_BLOCK_DATA_PEC:
-		if(hwpec && size = I2C_SMBUS_BLOCK_DATA)
-			size = I2C_SMBUS_BLOCK_DATA_PEC;
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
 		outb_p(command, SMBHSTCMD);
@@ -476,7 +473,7 @@
 			outb_p(1, SMBAUXCTL);	/* enable HW PEC */
 	}
 	if(block)
-		ret = i801_block_transaction(data, read_write, size);
+		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else {
 		outb_p(xact | ENABLE_INT9, SMBHSTCNT);
 		ret = i801_transaction();

-- 
Jean Delvare
