From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] I2C: Fix some i2c algorithm initialization
Message-Id: <20050323204943.77cf3f01.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While searching for i2c_algorithm declarations missing their
.functionality member, I found three of them which were not properly
initialized. i2c-algo-ite and i2c_sibyte_algo do not use the C99
initialization syntax, and i2c-ibm_iic.c explicitely initializes NULL
members. Following patch puts some order in there.

Please apply, thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm1/drivers/i2c/algos/i2c-algo-ite.c.orig	2005-03-22 10:48:12.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/i2c/algos/i2c-algo-ite.c	2005-03-23 17:09:51.000000000 +0100
@@ -713,14 +713,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm iic_algo = {
-	"ITE IIC algorithm",
-	I2C_ALGO_IIC,
-	iic_xfer,		/* master_xfer	*/
-	NULL,				/* smbus_xfer	*/
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	iic_func,			/* functionality	*/
+	.name		= "ITE IIC algorithm",
+	.id		= I2C_ALGO_IIC,
+	.master_xfer	= iic_xfer,
+	.algo_control	= algo_control, /* ioctl */
+	.functionality	= iic_func,
 };
 
 
--- linux-2.6.12-rc1-mm1/drivers/i2c/algos/i2c-algo-sibyte.c.orig	2005-03-22 10:22:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/i2c/algos/i2c-algo-sibyte.c	2005-03-23 17:07:04.000000000 +0100
@@ -136,14 +136,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_sibyte_algo = {
-	"SiByte algorithm",
-	I2C_ALGO_SIBYTE,
-	NULL,                           /* master_xfer          */
-	smbus_xfer,                   	/* smbus_xfer           */
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.name		= "SiByte algorithm",
+	.id		= I2C_ALGO_SIBYTE,
+	.smbus_xfer	= smbus_xfer,
+	.algo_control	= algo_control, /* ioctl */
+	.functionality	= bit_func,
 };
 
 /* 
--- linux-2.6.12-rc1-mm1/drivers/i2c/busses/i2c-ibm_iic.c.orig	2005-03-22 10:48:12.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/i2c/busses/i2c-ibm_iic.c	2005-03-23 16:59:21.000000000 +0100
@@ -630,10 +630,6 @@
 	.name 		= "IBM IIC algorithm",
 	.id   		= I2C_ALGO_OCP,
 	.master_xfer 	= iic_xfer,
-	.smbus_xfer	= NULL,
-	.slave_send	= NULL,
-	.slave_recv	= NULL,
-	.algo_control	= NULL,
 	.functionality	= iic_func
 };
 


-- 
Jean Delvare
