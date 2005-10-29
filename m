From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:04:18 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop I2C_SMBUS_I2C_BLOCK_MAX
Message-Id: <11305336611928@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051005222956.5bd8f3c0.khali@linux-fr.org>
In-Reply-To: <20051005222956.5bd8f3c0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop I2C_SMBUS_I2C_BLOCK_MAX

Drop I2C_SMBUS_I2C_BLOCK_MAX, use I2C_SMBUS_BLOCK_MAX instead.

I2C_SMBUS_I2C_BLOCK_MAX has always been defined to the same value as
I2C_SMBUS_BLOCK_MAX, and this will never change: setting it to a lower
value would make no sense, setting it to a higher value would break
i2c_smbus_data compatibility. There is no point in changing
i2c_smbus_data to support larger block transactions in SMBus mode, as
no SMBus hardware supports more than 32 byte blocks. Thus, for larger
transactions, direct I2C transfers are the way to go.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 30dac7469741906436b50f9413dccd446366d371
tree b5285192cd8b4274781d2dabd3bf89ceefadba82
parent d3554b4a2fb0e2229eb0d3fa9ece5b2f0b906d3e
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:15:59 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:10 -0700

 drivers/i2c/chips/eeprom.c |    4 ++--
 drivers/i2c/i2c-core.c     |    8 ++++----
 include/linux/i2c.h        |    1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
index d58403a..7fb739c 100644
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -88,8 +88,8 @@ static void eeprom_update_client(struct 
 		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			for (i = slice << 5; i < (slice + 1) << 5; i += I2C_SMBUS_I2C_BLOCK_MAX)
-				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_I2C_BLOCK_MAX)
+			for (i = slice << 5; i < (slice + 1) << 5; i += I2C_SMBUS_BLOCK_MAX)
+				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_BLOCK_MAX)
 					goto exit;
 		} else {
 			if (i2c_smbus_write_byte(client, slice << 5)) {
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 9583a54..1535417 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1108,10 +1108,10 @@ static s32 i2c_smbus_xfer_emulated(struc
 		return -1;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
 		if (read_write = I2C_SMBUS_READ) {
-			msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
+			msg[1].len = I2C_SMBUS_BLOCK_MAX;
 		} else {
 			msg[0].len = data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
+			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
 				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
@@ -1144,8 +1144,8 @@ static s32 i2c_smbus_xfer_emulated(struc
 				break;
 			case I2C_SMBUS_I2C_BLOCK_DATA:
 				/* fixed at 32 for now */
-				data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
-				for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
+				data->block[0] = I2C_SMBUS_BLOCK_MAX;
+				for (i = 0; i < I2C_SMBUS_BLOCK_MAX; i++)
 					data->block[i+1] = msgbuf1[i];
 				break;
 		}
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 74103d0..64c13c0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -448,7 +448,6 @@ struct i2c_msg {
  * Data for SMBus Messages 
  */
 #define I2C_SMBUS_BLOCK_MAX	32	/* As specified in SMBus standard */	
-#define I2C_SMBUS_I2C_BLOCK_MAX	32	/* Not specified but we use same structure */
 union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;

