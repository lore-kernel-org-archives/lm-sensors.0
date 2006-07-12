From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:14 +0000
Subject: [lm-sensors] [PATCH 2/13] [PATCH] i2c-iop3xx: Avoid addressing self
Message-Id: <11527468492476-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Peter Milne <peter.milne at d-tacq.com>

Avoid addressing self when sending a slave address. Follows instruction
in Intel 80331/80321 manuals.
Ignoring this worked previously on 80321, but causes a hang on i2cdetect
on 80331.

Signed-off-by: Peter Milne <peter.milne at d-tacq.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-iop3xx.c |   17 ++++++++++-------
 drivers/i2c/busses/i2c-iop3xx.h |    2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index aca7e16..48c5693 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -21,6 +21,9 @@
  * - Make it work with IXP46x chips
  * - Cleanup function names, coding style, etc
  *
+ * - writing to slave address causes latchup on iop331.
+ *	fix: driver refuses to address self.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, version 2.
@@ -73,12 +76,6 @@ iop3xx_i2c_reset(struct i2c_algo_iop3xx_
 } 
 
 static void 
-iop3xx_i2c_set_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	__raw_writel(MYSAR, iop3xx_adap->ioaddr + SAR_OFFSET);
-}
-
-static void 
 iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	u32 cr = IOP3XX_ICR_GCD | IOP3XX_ICR_SCLEN | IOP3XX_ICR_UE;
@@ -248,6 +245,13 @@ iop3xx_i2c_send_target_addr(struct i2c_a
 	int status;
 	int rc;
 
+	/* avoid writing to my slave address (hangs on 80331),
+	 * forbidden in Intel developer manual
+	 */
+	if (msg->addr = MYSAR) {
+		return -EBUSY;
+	}
+
 	__raw_writel(iic_cook_addr(msg), iop3xx_adap->ioaddr + DBR_OFFSET);
 	
 	cr &= ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
@@ -498,7 +502,6 @@ iop3xx_i2c_probe(struct platform_device 
 	spin_lock_init(&adapter_data->lock);
 
 	iop3xx_i2c_reset(adapter_data);
-	iop3xx_i2c_set_slave_addr(adapter_data);
 	iop3xx_i2c_enable(adapter_data);
 
 	platform_set_drvdata(pdev, new_adapter);
diff --git a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-iop3xx.h
index e46ebae..8485861 100644
--- a/drivers/i2c/busses/i2c-iop3xx.h
+++ b/drivers/i2c/busses/i2c-iop3xx.h
@@ -80,7 +80,7 @@ #define IOP3XX_IBMR_SDA		0x0001
 #define IOP3XX_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
 #define IOP3XX_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
 
-#define MYSAR			0x02	/* SWAG a suitable slave address */
+#define MYSAR			0	/* default slave address */
 
 #define I2C_ERR			321
 #define I2C_ERR_BERR		(I2C_ERR+0)
-- 
1.4.1


