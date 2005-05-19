From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Fix some i2c algorithm initialization
Message-Id: <11123113922117@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113924150@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2335, 2005/03/31 14:09:20-08:00, khali@linux-fr.org

[PATCH] I2C: Fix some i2c algorithm initialization

While searching for i2c_algorithm declarations missing their
.functionality member, I found three of them which were not properly
initialized. i2c-algo-ite and i2c_sibyte_algo do not use the C99
initialization syntax, and i2c-ibm_iic.c explicitely initializes NULL
members. Following patch puts some order in there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/algos/i2c-algo-ite.c    |   13 +++++--------
 drivers/i2c/algos/i2c-algo-sibyte.c |   13 +++++--------
 drivers/i2c/busses/i2c-ibm_iic.c    |    4 ----
 3 files changed, 10 insertions(+), 20 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	2005-03-31 15:17:46 -08:00
+++ b/drivers/i2c/algos/i2c-algo-ite.c	2005-03-31 15:17:46 -08:00
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
 
 
diff -Nru a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
--- a/drivers/i2c/algos/i2c-algo-sibyte.c	2005-03-31 15:17:46 -08:00
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c	2005-03-31 15:17:46 -08:00
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
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	2005-03-31 15:17:46 -08:00
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	2005-03-31 15:17:46 -08:00
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
 

