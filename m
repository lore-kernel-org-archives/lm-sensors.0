From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 22:14:55 +0000
Subject: [lm-sensors] [PATCH 12/17] i2c: Speed up block transfers
Message-Id: <20060118231455.71b0c12e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-speedup-block-transfers.patch

Speed up i2c_smbus_write_block_data and i2c_smbus_read_i2c_block_data
a bit by using memcpy instead of an explicit loop.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/i2c-core.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/i2c/i2c-core.c	2006-01-18 19:54:04.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/i2c-core.c	2006-01-18 20:52:26.000000000 +0100
@@ -920,12 +920,11 @@
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
@@ -935,16 +934,14 @@
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
Jean Delvare

