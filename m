From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:12:36 +0000
Subject: [lm-sensors] [PATCH] i2c: Several PEC-related fixes in software
Message-Id: <11305336582271@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Several PEC-related fixes in software SMBus emulation

Fix several errors in I2C SMBus emulation when PEC is used:
* Weird logic error in SMBus Write Word transactions.
* Wrong buffer size, affecting SMBus Block Write transactions.
* Potential buffer overrun in SMBus Block Write transactions.

From: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/i2c-core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

---
commit 5c50d1885981537ff3b8df6433951de6c9cb72cb
tree 1440c92b1716fb27a93c96fc9494aa7980421d95
parent 0f69a612f950f7508e556bf1b09390087d112115
author Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp> Sun, 25 Sep 2005 17:01:11 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 drivers/i2c/i2c-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b55097d..9583a54 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -864,7 +864,7 @@ static int i2c_smbus_add_pec(u16 addr, u
 			break;
 		case I2C_SMBUS_BYTE_DATA:
 			buf[2] = data->byte;
-			data->word = buf[2] ||
+			data->word = buf[2] |
 			            (i2c_smbus_pec(3, buf, NULL) << 8);
 			size = I2C_SMBUS_WORD_DATA;
 			break;
@@ -1033,8 +1033,8 @@ static s32 i2c_smbus_xfer_emulated(struc
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
@@ -1097,7 +1097,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 			}
 			if(size = I2C_SMBUS_BLOCK_DATA_PEC)
 				(msg[0].len)++;
-			for (i = 1; i <= msg[0].len; i++)
+			for (i = 1; i < msg[0].len; i++)
 				msgbuf0[i] = data->block[i-1];
 		}
 		break;

