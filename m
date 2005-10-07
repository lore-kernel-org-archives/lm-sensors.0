From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 23:57:22 +0000
Subject: [lm-sensors] [PATCH 05/16] i2c: Cleanup i2c-i801 ifdefs
Message-Id: <20051007235646.22706935.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No more need to check for PEC support being available now that both
the i2c-core and the i2c-i801 drivers are part of the Linux kernel
source tree. It's just there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-i801.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-i801.c	2005-10-07 20:08:16.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-i801.c	2005-10-07 20:50:16.000000000 +0200
@@ -52,10 +52,6 @@
 #include <linux/i2c.h>
 #include <asm/io.h>
 
-#ifdef I2C_FUNC_SMBUS_BLOCK_DATA_PEC
-#define HAVE_PEC
-#endif
-
 /* I801 SMBus address offsets */
 #define SMBHSTSTS	(0 + i801_smba)
 #define SMBHSTCNT	(2 + i801_smba)
@@ -392,7 +388,6 @@
 			goto END;
 	}
 
-#ifdef HAVE_PEC
 	if(isich4 && command = I2C_SMBUS_BLOCK_DATA_PEC) {
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
@@ -407,7 +402,6 @@
 		}
 		outb_p(temp, SMBHSTSTS); 
 	}
-#endif
 	result = 0;
 END:
 	if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
@@ -426,10 +420,8 @@
 	int block = 0;
 	int ret, xact = 0;
 
-#ifdef HAVE_PEC
 	if(isich4)
 		hwpec = (flags & I2C_CLIENT_PEC) != 0;
-#endif
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -464,11 +456,9 @@
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-#ifdef HAVE_PEC
 	case I2C_SMBUS_BLOCK_DATA_PEC:
 		if(hwpec && size = I2C_SMBUS_BLOCK_DATA)
 			size = I2C_SMBUS_BLOCK_DATA_PEC;
-#endif
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
 		outb_p(command, SMBHSTCMD);
@@ -480,13 +470,11 @@
 		return -1;
 	}
 
-#ifdef HAVE_PEC
 	if(isich4 && hwpec) {
 		if(size != I2C_SMBUS_QUICK &&
 		   size != I2C_SMBUS_I2C_BLOCK_DATA)
 			outb_p(1, SMBAUXCTL);	/* enable HW PEC */
 	}
-#endif
 	if(block)
 		ret = i801_block_transaction(data, read_write, size);
 	else {
@@ -494,13 +482,11 @@
 		ret = i801_transaction();
 	}
 
-#ifdef HAVE_PEC
 	if(isich4 && hwpec) {
 		if(size != I2C_SMBUS_QUICK &&
 		   size != I2C_SMBUS_I2C_BLOCK_DATA)
 			outb_p(0, SMBAUXCTL);
 	}
-#endif
 
 	if(block)
 		return ret;
@@ -527,12 +513,8 @@
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-#ifdef HAVE_PEC
 	     | (isich4 ? I2C_FUNC_SMBUS_BLOCK_DATA_PEC |
-	                 I2C_FUNC_SMBUS_HWPEC_CALC
-	               : 0)
-#endif
-	    ;
+	                 I2C_FUNC_SMBUS_HWPEC_CALC : 0);
 }
 
 static struct i2c_algorithm smbus_algorithm = {

-- 
Jean Delvare
