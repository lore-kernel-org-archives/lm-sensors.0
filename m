From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: [PATCH 2.6] I2C: i2c-s3c2410 functionality and fixes
Message-Id: <20050326190444.7c4c5367.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch does the following updates to the i2c-s3c2410 bus driver:

* Properly report the i2c functionality by adding to the
  `.functionality` field of the adapter

* Change the dev_err() call on no-ack to an dev_dbg() to make
  it less noisy when the bus is being probed by i2cdetect, etc.

* Add I2C_M_REV_DIR_ADDR to fully implement the
  I2C_FUNC_PROTOCOLO_MANGLING.

* Ensure that the adapter owner field is set to THIS_MODULE

Please apply, thanks.

(Once this is applied, all i2c bus drivers will be properly reporting
their functionality so I'll be able to go on with the i2c functionality
core cleanups.)

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm3/drivers/i2c/busses/i2c-s3c2410.c.orig	2005-03-26 06:59:33.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/i2c/busses/i2c-s3c2410.c	2005-03-26 19:02:15.000000000 +0100
@@ -1,6 +1,6 @@
 /* linux/drivers/i2c/busses/i2c-s3c2410.c
  *
- * Copyright (C) 2004 Simtec Electronics
+ * Copyright (C) 2004,2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 I2C Controller
@@ -188,6 +188,9 @@
 	} else
 		stat |= S3C2410_IICSTAT_MASTER_TX;
 
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
+		addr ^= 1;
+
 	// todo - check for wether ack wanted or not
 	s3c24xx_i2c_enable_ack(i2c);
 
@@ -287,7 +290,7 @@
 		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			/* ack was not received... */
 
-			dev_err(i2c->dev, "ack was not received\n" );
+			dev_dbg(i2c->dev, "ack was not received\n");
 			s3c24xx_i2c_stop(i2c, -EREMOTEIO);
 			goto out_ack;
 		}
@@ -555,11 +558,18 @@
 	return -EREMOTEIO;
 }
 
+/* declare our i2c functionality */
+static u32 s3c24xx_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+}
+
 /* i2c bus registration info */
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
 	.master_xfer		= s3c24xx_i2c_xfer,
+	.functionality		= s3c24xx_i2c_func,
 };
 
 static struct s3c24xx_i2c s3c24xx_i2c = {
@@ -567,6 +577,7 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
+		.owner			= THIS_MODULE,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 		.class			= I2C_CLASS_HWMON,

-- 
Jean Delvare
