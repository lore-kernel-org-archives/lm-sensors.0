From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sun, 25 Sep 2005 14:42:36 +0000
Subject: [lm-sensors] [PATCH] fix SW PEC for read_byte_data
Message-Id: <200509251242.AA01320@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: kernel/i2c-core.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
retrieving revision 1.112
diff -u -r1.112 i2c-core.c
--- kernel/i2c-core.c	24 Sep 2005 20:37:39 -0000	1.112
+++ kernel/i2c-core.c	25 Sep 2005 05:27:14 -0000
@@ -998,7 +998,7 @@
 int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
                         union i2c_smbus_data *data)
 {
-	u8 buf[3], rpec, cpec;
+	u8 buf[4], rpec, cpec;
 
 	buf[1] = command;
 	switch(size) {
@@ -1008,9 +1008,10 @@
 			rpec = data->byte;
 			break;
 		case I2C_SMBUS_WORD_DATA:
-			buf[0] = (addr << 1) | 1;
-			buf[2] = data->word & 0xff;
-			cpec = i2c_smbus_pec(3, buf, NULL);
+			buf[0] = addr << 1;
+			buf[2] = (addr << 1) | 1;
+			buf[3] = data->word & 0xff;
+			cpec = i2c_smbus_pec(4, buf, NULL);
 			rpec = data->word >> 8;
 			break;
 		case I2C_SMBUS_WORD_DATA_PEC:
@@ -1399,6 +1400,9 @@
 		if(read_write = I2C_SMBUS_READ &&
 		   size = I2C_SMBUS_BLOCK_DATA)
 			size = I2C_SMBUS_BLOCK_DATA_PEC;
+		else if(read_write = I2C_SMBUS_READ &&
+		   size = I2C_SMBUS_BYTE_DATA)
+			size = I2C_SMBUS_WORD_DATA;
 		else if(size = I2C_SMBUS_PROC_CALL)
 			size = I2C_SMBUS_PROC_CALL_PEC;
 		else if(size = I2C_SMBUS_BLOCK_PROC_CALL) {

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
