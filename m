From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Jun 2006 16:23:58 +0000
Subject: [lm-sensors] [PATCH] i2c: fix scx200_acb block transactions
Message-Id: <20060608182358.a3f24450.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

This would be a better fix. I would much appreciate if someone with an
scx200_acb bus could give it some testing, just in case. In particular
testing the various modes of i2cdump on an EEPROM would be useful.


The scx200_acb i2c bus driver pretends to support SMBus block
transactions, but in fact it implements the more simple I2C block
transactions. Additionally, it lacks sanity checks on the length
of the block transactions, which could lead to a buffer overrun.

This fixes an oops reported by Alexander Atanasov:
http://marc.theaimsgroup.com/?l=linux-kernel&m4970382125094

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/scx200_acb.c	2006-06-08 17:39:22.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/scx200_acb.c	2006-06-08 17:51:43.000000000 +0200
@@ -304,8 +304,14 @@
 		buffer = (u8 *)&cur_word;
 		break;
 
-	case I2C_SMBUS_BLOCK_DATA:
-		len = data->block[0];
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (rw = I2C_SMBUS_READ) {
+			len = I2C_SMBUS_BLOCK_MAX;
+		} else {
+			len = data->block[0];
+			if (len = 0 || len > I2C_SMBUS_BLOCK_MAX)
+				return -EINVAL;
+		}
 		buffer = &data->block[1];
 		break;
 
@@ -369,7 +375,7 @@
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
+	       I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
 /* For now, we only handle combined mode (smbus) */

-- 
Jean Delvare

