From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:50 +0000
Subject: [lm-sensors] [PATCH 16/36] i2c: Speed up block transfers
Message-Id: <1143153830466-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Speed up i2c_smbus_write_block_data and i2c_smbus_read_i2c_block_data
a bit by using memcpy instead of an explicit loop.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/i2c-core.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

7656032b904b936eca65a41afa1f2b3603195657
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 9733443..2b0c555 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -920,12 +920,11 @@ s32 i2c_smbus_write_block_data(struct i2
 			       u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
+
 	if (length > I2C_SMBUS_BLOCK_MAX)
 		length = I2C_SMBUS_BLOCK_MAX;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
 	data.block[0] = length;
+	memcpy(&data.block[1], values, length);
 	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
 			      I2C_SMBUS_WRITE,command,
 			      I2C_SMBUS_BLOCK_DATA,&data);
@@ -935,16 +934,14 @@ s32 i2c_smbus_write_block_data(struct i2
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
+
 	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
 	                      I2C_SMBUS_READ,command,
 	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
 		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
+
+	memcpy(values, &data.block[1], data.block[0]);
+	return data.block[0];
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
-- 
1.2.4



