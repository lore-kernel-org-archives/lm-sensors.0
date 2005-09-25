From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 17:01:45 +0000
Subject: [lm-sensors] [PATCH] (13/13) i2c: Several PEC-related fixes in
Message-Id: <20050925170111.6a3d2ce7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix several errors in I2C SMBus emulation when PEC is used:
* Weird logic error in SMBus Write Word transactions.
* Wrong buffer size, affecting SMBus Block Write transactions.
* Potential buffer overrun in SMBus Block Write transactions.

From: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/i2c/i2c-core.c	2005-09-25 14:51:24.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/i2c-core.c	2005-09-25 15:07:39.000000000 +0200
@@ -864,7 +864,7 @@
 			break;
 		case I2C_SMBUS_BYTE_DATA:
 			buf[2] = data->byte;
-			data->word = buf[2] ||
+			data->word = buf[2] |
 			            (i2c_smbus_pec(3, buf, NULL) << 8);
 			size = I2C_SMBUS_WORD_DATA;
 			break;
@@ -1033,8 +1033,8 @@
 	  need to use only one message; when reading, we need two. We initialize
 	  most things with sane defaults, to keep the code below somewhat
 	  simpler. */
-	unsigned char msgbuf0[34];
-	unsigned char msgbuf1[34];
+	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
+	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
 	int num = read_write = I2C_SMBUS_READ?2:1;
 	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 
 	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
@@ -1097,7 +1097,7 @@
 			}
 			if(size = I2C_SMBUS_BLOCK_DATA_PEC)
 				(msg[0].len)++;
-			for (i = 1; i <= msg[0].len; i++)
+			for (i = 1; i < msg[0].len; i++)
 				msgbuf0[i] = data->block[i-1];
 		}
 		break;

-- 
Jean Delvare
