From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 07 Jun 2006 20:24:07 +0000
Subject: [lm-sensors] [PATCH] i2c: fix scx200_acb functionalities
Message-Id: <20060607222407.6dc85114.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Can you please push this to Linus as soon as possible? It would be nice
to have this fix in 2.6.17 (and -stable too.)


The scx200_acb advertises SMBus block transactions as supported. In
fact, it supports SMBus block writes, but not SMBus block reads which
are more complex to implement.

This fixes an oops reported by Alexander Atanasov:
http://marc.theaimsgroup.com/?l=linux-kernel&m4970382125094

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Jordan Crouse <jordan.crouse at amd.com>
---
 drivers/i2c/busses/scx200_acb.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/scx200_acb.c	2006-06-07 21:50:26.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/scx200_acb.c	2006-06-07 22:12:26.000000000 +0200
@@ -305,6 +305,12 @@
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
+		/* Sanity check */
+		if (rw = I2C_SMBUS_READ) {
+			dev_warn(&adapter->dev, "SMBus block read is not "
+				 "supported!\n");
+			return -EINVAL;
+		}
 		len = data->block[0];
 		buffer = &data->block[1];
 		break;
@@ -369,7 +375,7 @@
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
+	       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA;
 }
 
 /* For now, we only handle combined mode (smbus) */


-- 
Jean Delvare

