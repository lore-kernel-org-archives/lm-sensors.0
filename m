From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 18:11:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83792d) Clean up detect function
Message-Id: <20091006201130.4fdea915@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83792d.c |   61 +++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/w83792d.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/w83792d.c	2009-10-06 12:13:47.000000000 +0200
@@ -1273,58 +1273,33 @@ w83792d_detect(struct i2c_client *client
 		return -ENODEV;
 	}
 
-	/* The w83792d may be stuck in some other bank than bank 0. This may
-	   make reading other information impossible. Specify a force=... or
-	   force_*=... parameter, and the Winbond will be reset to the right
-	   bank. */
-	if (kind < 0) {
-		if (w83792d_read_value(client, W83792D_REG_CONFIG) & 0x80) {
-			return -ENODEV;
-		}
-		val1 = w83792d_read_value(client, W83792D_REG_BANK);
-		val2 = w83792d_read_value(client, W83792D_REG_CHIPMAN);
-		/* Check for Winbond ID if in bank 0 */
-		if (!(val1 & 0x07)) {  /* is Bank0 */
-			if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
-			     ((val1 & 0x80) && (val2 != 0x5c))) {
-				return -ENODEV;
-			}
-		}
-		/* If Winbond chip, address of chip and W83792D_REG_I2C_ADDR
-		   should match */
-		if (w83792d_read_value(client,
-					W83792D_REG_I2C_ADDR) != address) {
+	if (w83792d_read_value(client, W83792D_REG_CONFIG) & 0x80)
+		return -ENODEV;
+
+	val1 = w83792d_read_value(client, W83792D_REG_BANK);
+	val2 = w83792d_read_value(client, W83792D_REG_CHIPMAN);
+	/* Check for Winbond ID if in bank 0 */
+	if (!(val1 & 0x07)) {  /* is Bank0 */
+		if ((!(val1 & 0x80) && val2 != 0xa3) ||
+		    ( (val1 & 0x80) && val2 != 0x5c))
 			return -ENODEV;
-		}
 	}
+	/* If Winbond chip, address of chip and W83792D_REG_I2C_ADDR
+	   should match */
+	if (w83792d_read_value(client, W83792D_REG_I2C_ADDR) != address)
+		return -ENODEV;
 
-	/* We have either had a force parameter, or we have already detected the
-	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
+	/*  Put it now into bank 0 and Vendor ID High Byte */
 	w83792d_write_value(client,
 			    W83792D_REG_BANK,
 			    (w83792d_read_value(client,
 				W83792D_REG_BANK) & 0x78) | 0x80);
 
 	/* Determine the chip type. */
-	if (kind <= 0) {
-		/* get vendor ID */
-		val2 = w83792d_read_value(client, W83792D_REG_CHIPMAN);
-		if (val2 != 0x5c) {  /* the vendor is NOT Winbond */
-			return -ENODEV;
-		}
-		val1 = w83792d_read_value(client, W83792D_REG_WCHIPID);
-		if (val1 = 0x7a) {
-			kind = w83792d;
-		} else {
-			if (kind = 0)
-				dev_warn(&adapter->dev,
-					"w83792d: Ignoring 'force' parameter for"
-					" unknown chip at adapter %d, address"
-					" 0x%02x\n", i2c_adapter_id(adapter),
-					address);
-			return -ENODEV;
-		}
-	}
+	val1 = w83792d_read_value(client, W83792D_REG_WCHIPID);
+	val2 = w83792d_read_value(client, W83792D_REG_CHIPMAN);
+	if (val1 != 0x7a || val2 != 0x5c)
+		return -ENODEV;
 
 	strlcpy(info->type, "w83792d", I2C_NAME_SIZE);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
