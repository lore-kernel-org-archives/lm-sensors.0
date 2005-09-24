From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 24 Sep 2005 05:09:44 +0000
Subject: [lm-sensors] [PATCH] fix functionality constant for read_byte_pec
Message-Id: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Implementing read_byte_pec using read_byte_data is impossible.

SMBus read byte with PEC:
    S Addr Rd [A] [Data] A [PEC] NA P

SMBus read byte data:
    S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P

Index: i2c/kernel/i2c.h
=================================RCS file: /home/cvs/i2c/kernel/i2c.h,v
retrieving revision 1.95
diff -u -r1.95 i2c.h
--- i2c/kernel/i2c.h	6 Sep 2005 20:08:39 -0000	1.95
+++ i2c/kernel/i2c.h	24 Sep 2005 02:36:03 -0000
@@ -397,6 +397,7 @@
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
 #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_READ_BYTE_PEC	0x00000400 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
 #define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
 #define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
@@ -435,12 +436,12 @@
                                        I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
 #define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
                                        I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
+#define I2C_FUNC_SMBUS_BYTE_PEC (I2C_FUNC_SMBUS_READ_BYTE_PEC | \
+                                 I2C_FUNC_SMBUS_WRITE_BYTE_PEC)
 
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 #define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
 #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
Index: lm_sensors2/kernel/include/i2c-dev.h
=================================RCS file: /home/cvs/lm_sensors2/kernel/include/i2c-dev.h,v
retrieving revision 1.7
diff -u -r1.7 i2c-dev.h
--- lm_sensors2/kernel/include/i2c-dev.h	21 Jan 2003 20:01:26 -0000	1.7
+++ lm_sensors2/kernel/include/i2c-dev.h	24 Sep 2005 02:36:03 -0000
@@ -55,6 +55,7 @@
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
 #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_READ_BYTE_PEC	0x00000400 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
 #define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
 #define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
@@ -93,12 +94,12 @@
                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
 #define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
+#define I2C_FUNC_SMBUS_BYTE_PEC I2C_FUNC_SMBUS_READ_BYTE_PEC | \
+                                I2C_FUNC_SMBUS_WRITE_BYTE_PEC
 
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 #define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
 #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \


----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
