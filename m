From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:05:36 +0000
Subject: [lm-sensors] [PATCH] i2c: SMBus PEC support rewrite, 3 of 3
Message-Id: <11305336643849@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11305336641964@kroah.com>
In-Reply-To: <11305336641964@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: SMBus PEC support rewrite, 3 of 3

The new SMBus PEC implementation doesn't support PEC emulation on
non-PEC non-I2C SMBus masters, so we can drop all related code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 585b3160f8212e58325bc1c0292c2ec01ac5db84
tree 368c38952dc1ee6b514266f6b25a285d6bc5d98c
parent 421ef47be20c5454b12ae0ec918d5073a9d2b938
author Jean Delvare <khali@linux-fr.org> Wed, 26 Oct 2005 21:31:15 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:14 -0700

 drivers/i2c/busses/i2c-amd8111.c |    7 -------
 drivers/i2c/busses/i2c-i801.c    |   13 +++++--------
 drivers/i2c/busses/i2c-nforce2.c |    7 -------
 include/linux/i2c.h              |    4 ----
 4 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index aface79..f3b79a6 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -253,13 +253,6 @@ static s32 amd8111_access(struct i2c_ada
 			read_write = I2C_SMBUS_READ;
 			break;
 
-		case I2C_SMBUS_WORD_DATA_PEC:
-		case I2C_SMBUS_BLOCK_DATA_PEC:
-		case I2C_SMBUS_PROC_CALL_PEC:
-		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			dev_warn(&adap->dev, "Unexpected software PEC transaction %d\n.", size);
-			return -1;
-
 		default:
 			dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b05e045..27e7894 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -102,8 +102,8 @@ MODULE_PARM_DESC(force_addr,
 		 "EXTREMELY DANGEROUS!");
 
 static int i801_transaction(void);
-static int i801_block_transaction(union i2c_smbus_data *data,
-				  char read_write, int command);
+static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
+				  int command, int hwpec);
 
 static unsigned short i801_smba;
 static struct pci_driver i801_driver;
@@ -249,7 +249,7 @@ static int i801_transaction(void)
 
 /* All-inclusive block transaction function */
 static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
-				  int command)
+				  int command, int hwpec)
 {
 	int i, len;
 	int smbcmd;
@@ -388,7 +388,7 @@ static int i801_block_transaction(union 
 			goto END;
 	}
 
-	if(isich4 && command = I2C_SMBUS_BLOCK_DATA_PEC) {
+	if (hwpec && command = I2C_SMBUS_BLOCK_DATA) {
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
 		do {
@@ -456,9 +456,6 @@ static s32 i801_access(struct i2c_adapte
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-	case I2C_SMBUS_BLOCK_DATA_PEC:
-		if(hwpec && size = I2C_SMBUS_BLOCK_DATA)
-			size = I2C_SMBUS_BLOCK_DATA_PEC;
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
 		outb_p(command, SMBHSTCMD);
@@ -476,7 +473,7 @@ static s32 i801_access(struct i2c_adapte
 			outb_p(1, SMBAUXCTL);	/* enable HW PEC */
 	}
 	if(block)
-		ret = i801_block_transaction(data, read_write, size);
+		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else {
 		outb_p(xact | ENABLE_INT9, SMBHSTCNT);
 		ret = i801_transaction();
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 9b42476..fd26036 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -188,13 +188,6 @@ static s32 nforce2_access(struct i2c_ada
 			dev_err(&adap->dev, "I2C_SMBUS_BLOCK_PROC_CALL not supported!\n");
 			return -1;
 
-		case I2C_SMBUS_WORD_DATA_PEC:
-		case I2C_SMBUS_BLOCK_DATA_PEC:
-		case I2C_SMBUS_PROC_CALL_PEC:
-		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			dev_err(&adap->dev, "Unexpected software PEC transaction %d\n.", size);
-			return -1;
-
 		default:
 			dev_err(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 78c64f7..32977fb 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -451,10 +451,6 @@ union i2c_smbus_data {
 #define I2C_SMBUS_BLOCK_DATA	    5
 #define I2C_SMBUS_I2C_BLOCK_DATA    6
 #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
-#define I2C_SMBUS_BLOCK_DATA_PEC    8		/* SMBus 2.0 */
-#define I2C_SMBUS_PROC_CALL_PEC     9		/* SMBus 2.0 */
-#define I2C_SMBUS_BLOCK_PROC_CALL_PEC  10	/* SMBus 2.0 */
-#define I2C_SMBUS_WORD_DATA_PEC	   11		/* SMBus 2.0 */
 
 
 /* ----- commands for the ioctl like i2c_command call:

