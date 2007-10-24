From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 22:05:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Use generic i2c reads during
Message-Id: <20071025000543.67dc6edb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As indirectly reported by Olof Johansson, the lm90 driver uses a
custom i2c read function even during detection, at which point we
don't know yet what device we're talking with. It would make more
sense to only use the generic i2c read function at this point, so
that we don't log irrelevant errors on misdetection.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-2.6.24-rc1.orig/drivers/hwmon/lm90.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc1/drivers/hwmon/lm90.c	2007-10-24 23:56:32.000000000 +0200
@@ -531,24 +531,24 @@ static int lm90_detect(struct i2c_adapte
 		kind = lm90;
 
 	if (kind < 0) { /* detection and identification */
-		u8 man_id, chip_id, reg_config1, reg_convrate;
+		int man_id, chip_id, reg_config1, reg_convrate;
 
-		if (lm90_read_reg(new_client, LM90_REG_R_MAN_ID,
-				  &man_id) < 0
-		 || lm90_read_reg(new_client, LM90_REG_R_CHIP_ID,
-		 		  &chip_id) < 0
-		 || lm90_read_reg(new_client, LM90_REG_R_CONFIG1,
-		 		  &reg_config1) < 0
-		 || lm90_read_reg(new_client, LM90_REG_R_CONVRATE,
-		 		  &reg_convrate) < 0)
+		if ((man_id = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_MAN_ID) < 0)
+		 || (chip_id = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CHIP_ID) < 0)
+		 || (reg_config1 = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CONFIG1) < 0)
+		 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CONVRATE) < 0))
 			goto exit_free;
 		
 		if ((address = 0x4C || address = 0x4D)
 		 && man_id = 0x01) { /* National Semiconductor */
-			u8 reg_config2;
+			int reg_config2;
 
-			if (lm90_read_reg(new_client, LM90_REG_R_CONFIG2,
-					  &reg_config2) < 0)
+			if ((reg_config2 = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CONFIG2)) < 0)
 				goto exit_free;
 
 			if ((reg_config1 & 0x2A) = 0x00


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
