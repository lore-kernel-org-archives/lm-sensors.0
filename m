From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC - PATCH for s3c2410 i2c missing support
Message-Id: <20050325122653.GA14551@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch (as requested by J Delvare) adds the
following bits which have been missing from the
s3c2410-i2c.c bus driver, as well as a couple of
other minor changes:

1) add a .functionality field to our algo, and
   report the facilities.

2) Add I2C_M_REV_DIR_ADDR handling for our start
   code, to better support our reported value
   from the .functionality probe (the use of
   I2C_FUNC_PROTOCOL_MANGLING)

3) change the call to dev_err() to dev_dbg() in
   the code that checks for an ack off the
   start condition. This avoids the `flood` of
   output when using i2cdetect

4) Add a .algo_control field which points to a
   function returning zero.

5) Add an `.owner = THIS_MODULE` to the adapter

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.12-rc1-mm3/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.12-rc1-mm3-i2cf1/drivers/i2c/busses/i2c-s3c2410.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/busses/i2c-s3c2410.c	2005-03-25 11:47:29.000000000 +0000
+++ linux-2.6.12-rc1-mm3-i2cf1/drivers/i2c/busses/i2c-s3c2410.c	2005-03-25 12:19:07.000000000 +0000
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
+			dev_dbg(i2c->dev, "ack was not received\n" );
 			s3c24xx_i2c_stop(i2c, -EREMOTEIO);
 			goto out_ack;
 		}
@@ -555,11 +558,24 @@
 	return -EREMOTEIO;
 }
 
+static u32 s3c24xx_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+static int s3c24xx_i2c_control(struct i2c_adapter *adapter, unsigned int cmd,
+			       unsigned long arg)
+{
+	return 0;
+}
+
 /* i2c bus registration info */
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
 	.master_xfer		= s3c24xx_i2c_xfer,
+	.functionality		= s3c24xx_i2c_func,
+	.algo_control		= s3c24xx_i2c_control,
 };
 
 static struct s3c24xx_i2c s3c24xx_i2c = {
@@ -567,6 +583,7 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
+		.owner			= THIS_MODULE,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 		.class			= I2C_CLASS_HWMON,
-------------- next part --------------
diff -urN -X ../dontdiff linux-2.6.12-rc1-mm3/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.12-rc1-mm3-i2cf1/drivers/i2c/busses/i2c-s3c2410.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/busses/i2c-s3c2410.c	2005-03-25 11:47:29.000000000 +0000
+++ linux-2.6.12-rc1-mm3-i2cf1/drivers/i2c/busses/i2c-s3c2410.c	2005-03-25 12:19:07.000000000 +0000
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
+			dev_dbg(i2c->dev, "ack was not received\n" );
 			s3c24xx_i2c_stop(i2c, -EREMOTEIO);
 			goto out_ack;
 		}
@@ -555,11 +558,24 @@
 	return -EREMOTEIO;
 }
 
+static u32 s3c24xx_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+static int s3c24xx_i2c_control(struct i2c_adapter *adapter, unsigned int cmd,
+			       unsigned long arg)
+{
+	return 0;
+}
+
 /* i2c bus registration info */
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
 	.master_xfer		= s3c24xx_i2c_xfer,
+	.functionality		= s3c24xx_i2c_func,
+	.algo_control		= s3c24xx_i2c_control,
 };
 
 static struct s3c24xx_i2c s3c24xx_i2c = {
@@ -567,6 +583,7 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
+		.owner			= THIS_MODULE,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 		.class			= I2C_CLASS_HWMON,
