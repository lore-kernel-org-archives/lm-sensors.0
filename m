From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:54 +0000
Subject: [lm-sensors] [PATCH 23/30] i2c-core: Drop useless bitmaskings
Message-Id: <11593190003763-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-core: Drop useless bitmaskings

The code generated is exactly the same.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 36e1214..88dd803 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -901,7 +901,7 @@ s32 i2c_smbus_read_byte(struct i2c_clien
 	                   I2C_SMBUS_READ,0,I2C_SMBUS_BYTE, &data))
 		return -1;
 	else
-		return 0x0FF & data.byte;
+		return data.byte;
 }
 
 s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value)
@@ -917,7 +917,7 @@ s32 i2c_smbus_read_byte_data(struct i2c_
 	                   I2C_SMBUS_READ,command, I2C_SMBUS_BYTE_DATA,&data))
 		return -1;
 	else
-		return 0x0FF & data.byte;
+		return data.byte;
 }
 
 s32 i2c_smbus_write_byte_data(struct i2c_client *client, u8 command, u8 value)
@@ -936,7 +936,7 @@ s32 i2c_smbus_read_word_data(struct i2c_
 	                   I2C_SMBUS_READ,command, I2C_SMBUS_WORD_DATA, &data))
 		return -1;
 	else
-		return 0x0FFFF & data.word;
+		return data.word;
 }
 
 s32 i2c_smbus_write_word_data(struct i2c_client *client, u8 command, u16 value)
@@ -1039,7 +1039,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 		else {
 			msg[0].len=3;
 			msgbuf0[1] = data->word & 0xff;
-			msgbuf0[2] = (data->word >> 8) & 0xff;
+			msgbuf0[2] = data->word >> 8;
 		}
 		break;
 	case I2C_SMBUS_PROC_CALL:
@@ -1048,7 +1048,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 		msg[0].len = 3;
 		msg[1].len = 2;
 		msgbuf0[1] = data->word & 0xff;
-		msgbuf0[2] = (data->word >> 8) & 0xff;
+		msgbuf0[2] = data->word >> 8;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (read_write = I2C_SMBUS_READ) {
-- 
1.4.2.1


