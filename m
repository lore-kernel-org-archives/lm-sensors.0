From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Oct 2005 22:30:43 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop I2C_SMBUS_I2C_BLOCK_MAX
Message-Id: <20051005222956.5bd8f3c0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am enqueuing the following patch. Comments welcome.

Drop I2C_SMBUS_I2C_BLOCK_MAX, use I2C_SMBUS_BLOCK_MAX instead.

I2C_SMBUS_I2C_BLOCK_MAX has always been defined to the same value as
I2C_SMBUS_BLOCK_MAX, and this will never change: setting it to a lower
value would make no sense, setting it to a higher value would break
i2c_smbus_data compatibility. There is no point in changing
i2c_smbus_data nor i2c-core to support larger block transactions in
SMBus mode, as no SMBus hardware supports more than 32 byte blocks.
Thus, if anyone ever really wants larger transactions, he/she'd better
call i2c_transfer() directly than going through the SMBus
compatibility layer.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/eeprom.c |    4 ++--
 drivers/i2c/i2c-core.c     |    8 ++++----
 include/linux/i2c.h        |    1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/chips/eeprom.c	2005-09-13 21:21:06.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/chips/eeprom.c	2005-10-05 21:56:04.000000000 +0200
@@ -88,8 +88,8 @@
 		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			for (i = slice << 5; i < (slice + 1) << 5; i += I2C_SMBUS_I2C_BLOCK_MAX)
-				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_I2C_BLOCK_MAX)
+			for (i = slice << 5; i < (slice + 1) << 5; i += I2C_SMBUS_BLOCK_MAX)
+				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_BLOCK_MAX)
 					goto exit;
 		} else {
 			if (i2c_smbus_write_byte(client, slice << 5)) {
--- linux-2.6.14-rc3.orig/drivers/i2c/i2c-core.c	2005-10-05 21:55:35.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/i2c-core.c	2005-10-05 21:56:04.000000000 +0200
@@ -1108,10 +1108,10 @@
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
@@ -1144,8 +1144,8 @@
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
--- linux-2.6.14-rc3.orig/include/linux/i2c.h	2005-10-05 21:55:35.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c.h	2005-10-05 21:56:04.000000000 +0200
@@ -448,7 +448,6 @@
  * Data for SMBus Messages 
  */
 #define I2C_SMBUS_BLOCK_MAX	32	/* As specified in SMBus standard */	
-#define I2C_SMBUS_I2C_BLOCK_MAX	32	/* Not specified but we use same structure */
 union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;


-- 
Jean Delvare
