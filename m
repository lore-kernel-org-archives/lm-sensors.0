From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:11:18 +0000
Subject: [lm-sensors] [PATCH] i2c: Cleanup i2c-i801 ifdefs
Message-Id: <11305336603731@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Cleanup i2c-i801 ifdefs

No more need to check for PEC support being available now that both
the i2c-core and the i2c-i801 drivers are part of the Linux kernel
source tree. It's just there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 47b8b103f7f50d56568eb8d6cff0e3a2373f0eb3
tree 477c11eeef2a45ac5c7dfeb761de50b2d89eeb9d
parent ada0c2f8fa087dc1dbc34e096c318739b1d6381a
author Jean Delvare <khali@linux-fr.org> Fri, 07 Oct 2005 23:56:46 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:09 -0700

 drivers/i2c/busses/i2c-i801.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5885835..413930c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
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
@@ -392,7 +388,6 @@ static int i801_block_transaction(union 
 			goto END;
 	}
 
-#ifdef HAVE_PEC
 	if(isich4 && command = I2C_SMBUS_BLOCK_DATA_PEC) {
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
@@ -407,7 +402,6 @@ static int i801_block_transaction(union 
 		}
 		outb_p(temp, SMBHSTSTS); 
 	}
-#endif
 	result = 0;
 END:
 	if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
@@ -426,10 +420,8 @@ static s32 i801_access(struct i2c_adapte
 	int block = 0;
 	int ret, xact = 0;
 
-#ifdef HAVE_PEC
 	if(isich4)
 		hwpec = (flags & I2C_CLIENT_PEC) != 0;
-#endif
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -464,11 +456,9 @@ static s32 i801_access(struct i2c_adapte
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
@@ -480,13 +470,11 @@ static s32 i801_access(struct i2c_adapte
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
@@ -494,13 +482,11 @@ static s32 i801_access(struct i2c_adapte
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
@@ -527,12 +513,8 @@ static u32 i801_func(struct i2c_adapter 
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

