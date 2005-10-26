From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:24:22 +0000
Subject: [lm-sensors] [PATCH 09/16] i2c: SMBus PEC support rewrite, 1 of 3
Message-Id: <20051026212504.589fef53.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-smbus-pec-01-drop-pec-funcs.patch

Discard I2C_FUNC_SMBUS_*_PEC defines. i2c clients are not supposed to
check for PEC support of i2c bus drivers on individual SMBus
transactions, and i2c bus drivers are not supposed to advertise them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-i801.c |    3 +--
 include/linux/i2c.h           |   18 ------------------
 2 files changed, 1 insertion(+), 20 deletions(-)

--- linux-2.6.14-rc2.orig/include/linux/i2c.h	2005-09-30 20:48:44.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c.h	2005-09-30 20:50:59.000000000 +0200
@@ -389,10 +389,6 @@
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
 #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC 0x00004000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000 
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000 
@@ -408,8 +404,6 @@
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
 #define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
                              I2C_FUNC_SMBUS_WRITE_BYTE)
@@ -423,17 +417,6 @@
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
 #define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
                                     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC (I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
-
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
-#define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
                              I2C_FUNC_SMBUS_BYTE | \
@@ -441,7 +424,6 @@
                              I2C_FUNC_SMBUS_WORD_DATA | \
                              I2C_FUNC_SMBUS_PROC_CALL | \
                              I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
                              I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* 
--- linux-2.6.14-rc2.orig/drivers/i2c/busses/i2c-i801.c	2005-09-30 20:49:52.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/busses/i2c-i801.c	2005-09-30 20:50:59.000000000 +0200
@@ -513,8 +513,7 @@
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-	     | (isich4 ? I2C_FUNC_SMBUS_BLOCK_DATA_PEC |
-	                 I2C_FUNC_SMBUS_HWPEC_CALC : 0);
+	     | (isich4 ? I2C_FUNC_SMBUS_HWPEC_CALC : 0);
 }
 
 static struct i2c_algorithm smbus_algorithm = {

-- 
Jean Delvare
